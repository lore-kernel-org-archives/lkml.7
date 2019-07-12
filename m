Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F822C742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A312080A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562935257;
	bh=/Jar8IeLznHx4REKRYSjt26qWLrEXBuOcKDnIMhnuzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hG6Ww6zeqrPHRvNZKPkSBCacIkrM2Pw0fvbY9qXXgJSbDP4vVUMzNLGlg4Y2DCo0h
	 PlskK02ga+/JwS/APYKbHdUbV5KAOzMuet25hx3ScNBHhSNOwPRAZGf9wcSVG0iuo3
	 WeZdTOxHcJ2qd79tef6VIF1oh24sGtfPnvHdWjwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfGLMk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:40:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbfGLMYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:24:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E22E2084B;
        Fri, 12 Jul 2019 12:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934283;
        bh=/Jar8IeLznHx4REKRYSjt26qWLrEXBuOcKDnIMhnuzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qJ3hPk+y4BOBk+dwXvTWEI5GFh5g1Es/VR3yKwpoQ7vkrak9IgyRMppOW9mYPLOOu
         sclhleKEx2mySXN0oCB/8DPXlunarLfZPZrH07AfHfAPTRPVD/7WZL76AM2Xess6rR
         AEVMYLt4Gt80UDtSMEnUYwLTcmxRJOBzu6MmfE4Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, yangerkun <yangerkun@huawei.com>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 52/91] quota: fix a problem about transfer quota
Date:   Fri, 12 Jul 2019 14:18:55 +0200
Message-Id: <20190712121624.453621208@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121621.422224300@linuxfoundation.org>
References: <20190712121621.422224300@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c6d9c35d16f1bafd3fec64b865e569e48cbcb514 ]

Run below script as root, dquot_add_space will return -EDQUOT since
__dquot_transfer call dquot_add_space with flags=0, and dquot_add_space
think it's a preallocation. Fix it by set flags as DQUOT_SPACE_WARN.

mkfs.ext4 -O quota,project /dev/vdb
mount -o prjquota /dev/vdb /mnt
setquota -P 23 1 1 0 0 /dev/vdb
dd if=/dev/zero of=/mnt/test-file bs=4K count=1
chattr -p 23 test-file

Fixes: 7b9ca4c61bc2 ("quota: Reduce contention on dq_data_lock")
Signed-off-by: yangerkun <yangerkun@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/quota/dquot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index fc20e06c56ba..dd1783ea7003 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1993,8 +1993,8 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 				       &warn_to[cnt]);
 		if (ret)
 			goto over_quota;
-		ret = dquot_add_space(transfer_to[cnt], cur_space, rsv_space, 0,
-				      &warn_to[cnt]);
+		ret = dquot_add_space(transfer_to[cnt], cur_space, rsv_space,
+				      DQUOT_SPACE_WARN, &warn_to[cnt]);
 		if (ret) {
 			spin_lock(&transfer_to[cnt]->dq_dqb_lock);
 			dquot_decr_inodes(transfer_to[cnt], inode_usage);
-- 
2.20.1



