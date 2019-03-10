Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79922C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48459206DF
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="x1vfgadq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfCJQ4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 12:56:52 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:36169 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726714AbfCJQ4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 12:56:41 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id C066420E9F;
        Sun, 10 Mar 2019 19:56:38 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id RPEfT421Z4-ucEGU1Ia;
        Sun, 10 Mar 2019 19:56:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1552236998; bh=Poth8bsXzGuMFlWc+hjheuYpxKTUXD6jqzrvGKzvghU=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=x1vfgadqPzWLosEjmFW8XWTlHak8LMpmr+mf+PFKvXoqqjPiO+FTIpbqG3IBXSncB
         zdXA+PUSVadjL6uorMAFwtXige9Wb4qANums9qKnGwfjkVRmBXhZMtjGrS9T5exuaM
         JsMeCdVMS8WHvZx5ZO7jWMGvfho4re0HeYwGpsZM=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-iva.dhcp.yndx.net (dynamic-iva.dhcp.yndx.net [2a02:6b8:0:827::1:35])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id EJC7WAbWTj-uc4mBWBk;
        Sun, 10 Mar 2019 19:56:38 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v1 5/6] lib: scanf: mark sscanf and vsscanf as __must_check
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Date:   Sun, 10 Mar 2019 19:56:38 +0300
Message-ID: <155223699818.4075.9452536087987358708.stgit@buzz>
In-Reply-To: <155223448227.4075.6846910559654700796.stgit@buzz>
References: <155223448227.4075.6846910559654700796.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Caller must check returned count of matched arguments.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 include/linux/kernel.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 32726b25eaa5..3142a456f00b 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -483,9 +483,9 @@ const char *kvasprintf_const(gfp_t gfp, const char *fmt, va_list args);
 #define SCANF_MORE	(1 << 30)
 
 extern __scanf(2, 3)
-int sscanf(const char *, const char *, ...);
+int __must_check sscanf(const char *, const char *, ...);
 extern __scanf(2, 0)
-int vsscanf(const char *, const char *, va_list);
+int __must_check vsscanf(const char *, const char *, va_list);
 
 extern int get_option(char **str, int *pint);
 extern char *get_options(const char *str, int nints, int *ints);

