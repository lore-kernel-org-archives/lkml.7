Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214B5C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FB32173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558547093;
	bh=WGpxkLS3O1W5xJkPVT6OtlO6L0fjxSCDqpvjxfdM6e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RRm73oKSxeKmo72CcjN56NFqwUyp6/OwH0I4mKaLC4EMi+UwUNpClEJzdsSW6HpOa
	 UexS9baOygmXpWu23b+E096ilyY48ixik27eMc1n9ckymEXzJRBSW5fWMjMtOzRC3L
	 vWieShzCyi+D0YzWFrgccYgiC7gZlu6EZEOhGTYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfEVRow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 13:44:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbfEVRov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 13:44:51 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC5C121019;
        Wed, 22 May 2019 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558547090;
        bh=WGpxkLS3O1W5xJkPVT6OtlO6L0fjxSCDqpvjxfdM6e8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SzL7buq0bAzafVDhOU8P3wAUmBGyHpJpmx/A+Wg9G+RBjrePwONfrzYdaLTQ6n0ke
         xz8NKrRO3GWrfZTLu5+xIfiqvqPnf6DQ0cVkiooeJc32eSX+rfY8IFuTtOPMSTssKH
         1IWqBJr6jhO9FgvLdW5ERpUg+ZbExknEYZH5aPHs=
Date:   Wed, 22 May 2019 10:44:48 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 1/2] Revert "f2fs: don't clear
 CP_QUOTA_NEED_FSCK_FLAG"
Message-ID: <20190522174448.GA81051@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190521180625.10562-1-jaegeuk@kernel.org>
 <8e9a4cac-c81b-11ce-0a5a-c6f5caf716c4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e9a4cac-c81b-11ce-0a5a-c6f5caf716c4@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22, Chao Yu wrote:
> On 2019-5-22 2:06, Jaegeuk Kim wrote:
> > This reverts commit fb40d618b03978b7cc5820697894461f4a2af98b.
> > 
> > The original patch introduced # of fsck triggers.
> 
> How about pointing out the old issue has been fixed with below patch:
> 
> f2fs-tools: fix to check total valid block count before block allocation
> 
> Otherwise, user should keep kernel commit "f2fs: don't clear
> CP_QUOTA_NEED_FSCK_FLAG".

Actually, that didn't fix my testing issue, but I found we were not using
error control for quota_sysfile. Now I've seen no issue with the below patch.

From e1b7de7050fd87b7c20e033b062b1cc6505679d3 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 20 May 2019 16:17:56 -0700
Subject: [PATCH] f2fs: link f2fs quota ops for sysfile

This patch reverts:
commit fb40d618b039 ("f2fs: don't clear CP_QUOTA_NEED_FSCK_FLAG").

We were missing error handlers used in f2fs quota ops.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 6 ++----
 fs/f2fs/super.c      | 5 +----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index d0539ddad6e2..89825261d474 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1317,10 +1317,8 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
 		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
-	/*
-	 * TODO: we count on fsck.f2fs to clear this flag until we figure out
-	 * missing cases which clear it incorrectly.
-	 */
+	else
+		__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
 
 	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
 		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 856f9081c599..34f2adf191ed 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3169,10 +3169,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 #ifdef CONFIG_QUOTA
 	sb->dq_op = &f2fs_quota_operations;
-	if (f2fs_sb_has_quota_ino(sbi))
-		sb->s_qcop = &dquot_quotactl_sysfile_ops;
-	else
-		sb->s_qcop = &f2fs_quotactl_ops;
+	sb->s_qcop = &f2fs_quotactl_ops;
 	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
 
 	if (f2fs_sb_has_quota_ino(sbi)) {
-- 
2.19.0.605.g01d371f741-goog

