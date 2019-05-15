Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C540DC04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978F420862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="yiIhTfm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfEOIPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 04:15:42 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:37772 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbfEOIPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 04:15:42 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id A73FB2E0987;
        Wed, 15 May 2019 11:15:38 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id RoCJEKO4OP-Fc0KCJcQ;
        Wed, 15 May 2019 11:15:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1557908138; bh=jHxTX7+w5XRXWiyeoOBtShSglDK2yw1HqwPBfT2YxAA=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=yiIhTfm8Y8WhZ27MzSCHygSHiu5oBt8MnnCw4imtDEH6qA2novSoggL0Mk1CNqZ9T
         7xF4+sJ+Uco+w51uWRsqF5JueXBt2YYU1CZvrsjb3//DVbmxezl4Kkc7S2+eC/xLEJ
         XdmVbHG1DwYMOOkK8yT+YETJRQD++p45vkpsltKw=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:ed19:3833:7ce1:2324])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id TMPGL1lslS-Fbl0Xd6Q;
        Wed, 15 May 2019 11:15:37 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] mm: fix protection of mm_struct fields in get_cmdline()
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Date:   Wed, 15 May 2019 11:15:37 +0300
Message-ID: <155790813764.2995.13706842444028749629.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 88aa7cc688d4 ("mm: introduce arg_lock to protect arg_start|
end and env_start|end in mm_struct") related mm fields are protected with
separate spinlock and mmap_sem held for read is not enough for protection.

Fixes: 88aa7cc688d4 ("mm: introduce arg_lock to protect arg_start|end and env_start|end in mm_struct")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 mm/util.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index e2e4f8c3fa12..540e7c157cf2 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -717,12 +717,12 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
 	if (!mm->arg_end)
 		goto out_mm;	/* Shh! No looking before we're done */
 
-	down_read(&mm->mmap_sem);
+	spin_lock(&mm->arg_lock);
 	arg_start = mm->arg_start;
 	arg_end = mm->arg_end;
 	env_start = mm->env_start;
 	env_end = mm->env_end;
-	up_read(&mm->mmap_sem);
+	spin_unlock(&mm->arg_lock);
 
 	len = arg_end - arg_start;
 

