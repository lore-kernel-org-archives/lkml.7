Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8866FC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5860320881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="C1Gdt9q6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfEOIlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 04:41:40 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:54070 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726347AbfEOIlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 04:41:22 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 6C13C2E1471;
        Wed, 15 May 2019 11:41:20 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id BfmpUuiCqw-fJsqIJcU;
        Wed, 15 May 2019 11:41:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1557909680; bh=8cD7osAd7wj30fMNGC0J8IUxkft7sVoc3Ldv03Ms9+A=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=C1Gdt9q6DvCWb8OHGL64+FSDhO+5tEwZKryiXKS18mzixvKGghDJYSKH81UNviwME
         /A8Dn06dQrccwq2bJFh3nZ73zV9z8LI08I/MXXklUY/i+rbKyZhgGvpGXVLvHuXr+7
         LIqC9GlgTCkLXk02BEAVj9Z0aXmjiJCTOfL0nNVM=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:ed19:3833:7ce1:2324])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id ImDQZhn1h5-fJ84Bnif;
        Wed, 15 May 2019 11:41:19 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 3/5] proc: use down_read_killable for /proc/pid/pagemap
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Wed, 15 May 2019 11:41:19 +0300
Message-ID: <155790967960.1319.6040190052682812218.stgit@buzz>
In-Reply-To: <155790967258.1319.11531787078240675602.stgit@buzz>
References: <155790967258.1319.11531787078240675602.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ditto.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 fs/proc/task_mmu.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 781879a91e3b..78bed6adc62d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1547,7 +1547,9 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
 		/* overflow ? */
 		if (end < start_vaddr || end > end_vaddr)
 			end = end_vaddr;
-		down_read(&mm->mmap_sem);
+		ret = down_read_killable(&mm->mmap_sem);
+		if (ret)
+			goto out_free;
 		ret = walk_page_range(start_vaddr, end, &pagemap_walk);
 		up_read(&mm->mmap_sem);
 		start_vaddr = end;

