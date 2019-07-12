Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9D1C742C7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E676120863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="OexDzgjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfGLOzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 10:55:01 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:60308 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726984AbfGLOzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 10:55:01 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id D1EB02E12E4;
        Fri, 12 Jul 2019 17:54:57 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id TrVwfLmUeH-sv4OMBfK;
        Fri, 12 Jul 2019 17:54:57 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1562943297; bh=MDH/AtBHcwuVTMXn+O7Dj31MfSoJS8ZDQ7kV9R+jNeI=;
        h=Message-ID:Date:To:From:Subject;
        b=OexDzgjru4NF0iXvM9SU/N+Wkvc7rV0gYTBIm1WrSPupuTPENO9sMPMV8O95ysS5J
         /Vmo29h2TEF95TdmbmvLwnnPlu3stj8+pmSzAypJ4eCxG1dbMTEse3mYY8l0thynyW
         CG9Mt7cTEnWlNgnfcUOcLxHxNAmiR/pfpvXmvHkI=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:fce8:911:2fe8:4dfb])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id I4l5tGLLwY-sv9aD6nL;
        Fri, 12 Jul 2019 17:54:57 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] kernel/printk: prevent deadlock at calling kmsg_dump from
 NMI context
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date:   Fri, 12 Jul 2019 17:54:56 +0300
Message-ID: <156294329676.1745.2620297516210526183.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function kmsg_dump could be invoked from NMI context intentionally or
accidentally because it is called at various oops/panic paths.
Kernel message dumpers are not ready to work in NMI context right now.
They could deadlock on lockbuf_lock or break internal structures.

Theoretically some dumpers could be fixed and marked as NMI-safe.
Right now it's safer to print warning once and give up.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 kernel/printk/printk.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1888f6a3b694..2b83820bdc57 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3104,6 +3104,9 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 	struct kmsg_dumper *dumper;
 	unsigned long flags;
 
+	if (WARN_ON_ONCE(in_nmi()))
+		return;
+
 	if ((reason > KMSG_DUMP_OOPS) && !always_kmsg_dump)
 		return;
 

