Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0135BC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F74214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565010299;
	bh=JKwcJRZkRAKgMmzGE5HGZFN8tWHhFzAl1WyKrGJDWGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cT9U3Trjn3H0XC29LkefrKPlAc/Zq72VNC/JZwlpFXaXvYRVj9AR85njbUXUZrhKb
	 BjOqAFsfU9I1kt8/4FAGQSmZ2+2PsHST+SqAvNWbjS3Tsbq8FQM4Trg5fYLaaY48NE
	 yqA6u5K9Xm2kyVT65shH8HIQXaaF5VlW2UqKol0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfHENE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:04:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729156AbfHENEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:04:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7377F214C6;
        Mon,  5 Aug 2019 13:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565010292;
        bh=JKwcJRZkRAKgMmzGE5HGZFN8tWHhFzAl1WyKrGJDWGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MghlLT8cIfJtQknBzZgm+drv/0lLSgdBtoH4eh2K39mYQUXAEFnRfTSRwu+PMofvk
         Uf1i6ctvv70gTdU/aOkDJgZA5U5ZnBJBcShdBMcNHeDET09TYFUx0zTRXD9ww9JdUD
         VTm6XmAXcnwiJs2KuEaQ+CMPGg+sJ5IgCyXVTBUg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 10/42] btrfs: fix minimum number of chunk errors for DUP
Date:   Mon,  5 Aug 2019 15:02:36 +0200
Message-Id: <20190805124926.055875161@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124924.788666484@linuxfoundation.org>
References: <20190805124924.788666484@linuxfoundation.org>
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
index 94b61afe996c8..70aa22a8a9cce 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5072,8 +5072,7 @@ static inline int btrfs_chunk_max_errors(struct map_lookup *map)
 
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



