Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06586C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD5E2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="aNjr5SR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfEOIl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 04:41:29 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:54100 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbfEOIlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 04:41:25 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 658F52E146D;
        Wed, 15 May 2019 11:41:22 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 9zoT92Owie-fL0uKV6u;
        Wed, 15 May 2019 11:41:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1557909682; bh=DXKTyv1Zt0cbjxS03oPn1lBJLs878fkqtHSHT6TGUvY=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=aNjr5SR1VzkHw+xEMkDZjfNamwaILWaRolaTmyWU5+xXDFs9RbvV8LmC1+fXO4YCP
         dm2PkDwHYBgEKcdaXOl1syN8qZ/el2BXO6s9Bno/cJUjP8agzdxS8NqjpxZqkvdF5P
         GFMlg9fUgmB31B3VVcLdRfMkfsf1X2zY9luH43kk=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:ed19:3833:7ce1:2324])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id wNdlQeZj5Y-fLl0uD8T;
        Wed, 15 May 2019 11:41:21 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 4/5] proc: use down_read_killable for /proc/pid/clear_refs
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Wed, 15 May 2019 11:41:21 +0300
Message-ID: <155790968147.1319.10247444846354273332.stgit@buzz>
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

Replace the only unkillable mmap_sem lock in clear_refs_write.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 fs/proc/task_mmu.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 78bed6adc62d..7f84d1477b5b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1140,7 +1140,10 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 			goto out_mm;
 		}
 
-		down_read(&mm->mmap_sem);
+		if (down_read_killable(&mm->mmap_sem)) {
+			count = -EINTR;
+			goto out_mm;
+		}
 		tlb_gather_mmu(&tlb, mm, 0, -1);
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			for (vma = mm->mmap; vma; vma = vma->vm_next) {

