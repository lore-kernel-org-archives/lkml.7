Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966DFC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6378420862
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570124055;
	bh=JJbMQfpMauqVXlGCP9Pm3PKD3ws3yenQ8bc1ewOia6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J4Q5oZE3sPbziBBdtK5/DGWNdgKHFX7H2qsD+0xNTOS4Iszj3w39BQ9RiNDv3MefQ
	 eQPICZF4vt6ehz2+VvMeAi3A33/eWx0qFmFzSXjmhNs82QCnHYnKh+FHv2/PC5RhKp
	 vk7J6mRDUBQkTib3ePS4gGsTFflkFbURN8uxYeCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733238AbfJCReN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:34:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732869AbfJCQHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:07:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62F3321783;
        Thu,  3 Oct 2019 16:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118822;
        bh=JJbMQfpMauqVXlGCP9Pm3PKD3ws3yenQ8bc1ewOia6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZGQ0+921YSoqc7/sx1uSN/wV0dwu1kamtr6GST2jEPgibZaz5wKfDCqnB4SzGf2NX
         bbQLtYjadM1WXS6R4PrcMeET/mzoF4wXPbHgW4iWuhk254Qywsj7u8sKYz3Xl9llhX
         ZVbvm7cIZ4VK70AbqFCfLTI3DCjCG5tiXvxiO2gg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Surbhi Palande <csurbhi@gmail.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 022/185] f2fs: check all the data segments against all node ones
Date:   Thu,  3 Oct 2019 17:51:40 +0200
Message-Id: <20191003154442.632619357@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Surbhi Palande <f2fsnewbie@gmail.com>

[ Upstream commit 1166c1f2f69117ad254189ca781287afa6e550b6 ]

As a part of the sanity checking while mounting, distinct segment number
assignment to data and node segments is verified. Fixing a small bug in
this verification between node and data segments. We need to check all
the data segments with all the node segments.

Fixes: 042be0f849e5f ("f2fs: fix to do sanity check with current segment number")
Signed-off-by: Surbhi Palande <csurbhi@gmail.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4c169ba50c0f4..ad839a7996e9b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2027,11 +2027,11 @@ int sanity_check_ckpt(struct f2fs_sb_info *sbi)
 		}
 	}
 	for (i = 0; i < NR_CURSEG_NODE_TYPE; i++) {
-		for (j = i; j < NR_CURSEG_DATA_TYPE; j++) {
+		for (j = 0; j < NR_CURSEG_DATA_TYPE; j++) {
 			if (le32_to_cpu(ckpt->cur_node_segno[i]) ==
 				le32_to_cpu(ckpt->cur_data_segno[j])) {
 				f2fs_msg(sbi->sb, KERN_ERR,
-					"Data segment (%u) and Data segment (%u)"
+					"Node segment (%u) and Data segment (%u)"
 					" has the same segno: %u", i, j,
 					le32_to_cpu(ckpt->cur_node_segno[i]));
 				return 1;
-- 
2.20.1



