Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA54C41514
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7243E2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565010668;
	bh=ZUSXdUx7NCiZjfW6EQPeX81N8ijA32Mv2/ErVjajlaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bEFSNx0jhT4uATHEXuAr4a0REQJyhawvLtJZcC2z94QYTDnZpXzOUQPddCWeRfgQN
	 0Du+ER+E8/IfP6YJFw5UKXRUQppmSBEe7HP15G4B6K1ZpwmEKNHzRq5NXm682Brvmc
	 BIdrfCzJUzUpU61NXEDutJWTUlhOw16s2h4NJp+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbfHENLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:11:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730448AbfHENLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:11:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B4212067D;
        Mon,  5 Aug 2019 13:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565010663;
        bh=ZUSXdUx7NCiZjfW6EQPeX81N8ijA32Mv2/ErVjajlaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ic2vwzqDEzx7eQGmd14qpvT11EFk9V3wY015o+41pDcFgAFf2Z6ZVWEHKJUxarWQ/
         gvIsy7et56ugJ4QiuCetN+FtE4Q2010zZ/voxzwqNHxgL4qlbQkDCnFtbZsMlS+tLr
         kAWm73oATMiqzrXQjxZeERmaTECmWiQW6LmqOJDc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 15/74] btrfs: fix minimum number of chunk errors for DUP
Date:   Mon,  5 Aug 2019 15:02:28 +0200
Message-Id: <20190805124937.023183875@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124935.819068648@linuxfoundation.org>
References: <20190805124935.819068648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 0ee5f8ae082e1f675a2fb6db601c31ac9958a134 ]

The list of profiles in btrfs_chunk_max_errors lists DUP as a profile
DUP able to tolerate 1 device missing. Though this profile is special
with 2 copies, it still needs the device, unlike the others.

Looking at the history of changes, thre's no clear reason why DUP is
there, functions were refactored and blocks of code merged to one
helper.

d20983b40e828 Btrfs: fix writing data into the seed filesystem
  - factor code to a helper

de11cc12df173 Btrfs: don't pre-allocate btrfs bio
  - unrelated change, DUP still in the list with max errors 1

a236aed14ccb0 Btrfs: Deal with failed writes in mirrored configurations
  - introduced the max errors, leaves DUP and RAID1 in the same group

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/volumes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2fd000308be76..6e008bd5c8cd1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5040,8 +5040,7 @@ static inline int btrfs_chunk_max_errors(struct map_lookup *map)
 
 	if (map->type & (BTRFS_BLOCK_GROUP_RAID1 |
 			 BTRFS_BLOCK_GROUP_RAID10 |
-			 BTRFS_BLOCK_GROUP_RAID5 |
-			 BTRFS_BLOCK_GROUP_DUP)) {
+			 BTRFS_BLOCK_GROUP_RAID5)) {
 		max_errors = 1;
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID6) {
 		max_errors = 2;
-- 
2.20.1



