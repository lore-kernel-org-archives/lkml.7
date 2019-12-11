Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2BFC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19C224658
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077683;
	bh=o0097HBGczPpjO6uj/IUnUpcuRfOFsYqRgOdD/t3OHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IR5ouDY0Jj37N7i0sMgZjTJ3yJ8R1+9gBy1/v2xa/bHkPuppLXN2llB6yZsAOHBA5
	 mOMaHDWNmn+RJ5oAZaaQNcTf0TbxxUC5/fpFJPXcMgFikvijn3lIbl2W9HuzBEua2h
	 A8+irPXpKcvGoHiRWLuNSrtNyfitO6Lk2ayPC7ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbfLKPVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:21:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:51520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732446AbfLKPVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:21:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9591922527;
        Wed, 11 Dec 2019 15:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077679;
        bh=o0097HBGczPpjO6uj/IUnUpcuRfOFsYqRgOdD/t3OHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=09ORxwGg7zjVwLFEYTipA6Mqfsfpot4WPkaMuLb0YDpLYg7mNaeiecAdvMcxkzF1L
         4lQbGw/1YfIfWxIvoEvdyxY5K80yrbmAteqw8q8cFIAxBXW/lzTKvbUvg/KlSElyAt
         CRznjLbV8TCPsrlytL7jsZNA8hOmBWC18Tzy28oc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 129/243] dlm: NULL check before kmem_cache_destroy is not needed
Date:   Wed, 11 Dec 2019 16:04:51 +0100
Message-Id: <20191211150347.839078743@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

[ Upstream commit f31a89692830061bceba8469607e4e4b0f900159 ]

kmem_cache_destroy(NULL) is safe, so removes NULL check before
freeing the mem. This patch also fix ifnullfree.cocci warnings.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/memory.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/dlm/memory.c b/fs/dlm/memory.c
index 7cd24bccd4fe5..37be29f21d04d 100644
--- a/fs/dlm/memory.c
+++ b/fs/dlm/memory.c
@@ -38,10 +38,8 @@ int __init dlm_memory_init(void)
 
 void dlm_memory_exit(void)
 {
-	if (lkb_cache)
-		kmem_cache_destroy(lkb_cache);
-	if (rsb_cache)
-		kmem_cache_destroy(rsb_cache);
+	kmem_cache_destroy(lkb_cache);
+	kmem_cache_destroy(rsb_cache);
 }
 
 char *dlm_allocate_lvb(struct dlm_ls *ls)
@@ -86,8 +84,7 @@ void dlm_free_lkb(struct dlm_lkb *lkb)
 		struct dlm_user_args *ua;
 		ua = lkb->lkb_ua;
 		if (ua) {
-			if (ua->lksb.sb_lvbptr)
-				kfree(ua->lksb.sb_lvbptr);
+			kfree(ua->lksb.sb_lvbptr);
 			kfree(ua);
 		}
 	}
-- 
2.20.1



