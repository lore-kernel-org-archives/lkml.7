Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC3CC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BFC214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="XCUhP2RQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbfGOIE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 04:04:59 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:52346 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729360AbfGOIE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 04:04:59 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 379622E0A47;
        Mon, 15 Jul 2019 11:04:56 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id davYswMrtD-4t4mKctH;
        Mon, 15 Jul 2019 11:04:56 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1563177896; bh=tZqqy9uD1wSUTPSJffIwrW0KJcma4VgQdmk3SSU/7w4=;
        h=Message-ID:Date:To:From:Subject;
        b=XCUhP2RQxVYUqfbGjnADI3nWhM8KRQi7/5duDBGbe1T4CgL9HbQfZVj+gT5wIkqEG
         5wdomPApnw2qY9DYRGSQE9zAbzUyVL2lqVgRNQjGLHkaJXZJwEG4VBPqj5vf90BaVA
         s3vBb0Fg6oZY73Z/3dV2Og/NLHXbvnRs0JeWCyVk=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:38c5:1c4f:8e20:cf1b])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id s3A8beTSyS-4tQG6NfJ;
        Mon, 15 Jul 2019 11:04:55 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v2] kernel/printk: prevent deadlock at unexpected call
 kmsg_dump in NMI context
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date:   Mon, 15 Jul 2019 11:04:55 +0300
Message-ID: <156317789553.326.15952579019338825022.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel message dumper - function kmsg_dump() is called on various oops or
panic paths which could happen in unpredictable context including NMI.

Panic in NMI is handled especially by stopping all other cpus with
smp_send_stop() and busting locks in printk_safe_flush_on_panic().

Other less-fatal cases shouldn't happen in NMI and cannot be handled.
But this might happen for example on oops in nmi context. In this case
dumper could deadlock on lockbuf_lock or break internal structures.

This patch catches kmsg_dump() called in NMI context except panic and
prints warning once.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Link: https://lore.kernel.org/lkml/156294329676.1745.2620297516210526183.stgit@buzz/ (v1)
---
 kernel/printk/printk.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1888f6a3b694..e711f64a1843 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3104,6 +3104,13 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 	struct kmsg_dumper *dumper;
 	unsigned long flags;
 
+	/*
+	 * In NMI context only panic could be handled safely:
+	 * it stops other cpus and busts logbuf lock.
+	 */
+	if (WARN_ON_ONCE(reason != KMSG_DUMP_PANIC && in_nmi()))
+		return;
+
 	if ((reason > KMSG_DUMP_OOPS) && !always_kmsg_dump)
 		return;
 

