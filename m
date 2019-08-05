Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA59C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFC820880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565011271;
	bh=jJs/ZGRveEr6EqdpW7NbSDpFdrYqj5xsHv9wAFDLWEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gpWyh6GH65ekQ3ceX06Z0emulOjVVGq5AlHITxtxYYbIb7Fm2n/r+vpEtRY19SojL
	 5eqPSjoe/HgoGJ5w8hI0CqfXbLrcyDcjFFq9mkzwLXaln5Wdu4S4k5cv3hQEFTwfqb
	 bRQSiUvaJfYDxp7NSaN+Og21nk9clgbtitnkR7Wg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbfHENVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729423AbfHENVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:21:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB71720657;
        Mon,  5 Aug 2019 13:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565011264;
        bh=jJs/ZGRveEr6EqdpW7NbSDpFdrYqj5xsHv9wAFDLWEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JPrH+HAHmmqGSa+cyJjsOMzh3ko2yMiBT4pYKIbDjXfiMJxWkhUWC6oaMuIbGSENK
         WyF53ATRgGfxQ1bWedUBAbM+0eUF1BwQSvqDKMgpm13VRzDhqf9ZLji5exge8Xvp5o
         Doc09qTB6N7f6tPXclvE1cV97TWlOjOfbQ3H2KVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 026/131] btrfs: tree-checker: Check if the file extent end overflows
Date:   Mon,  5 Aug 2019 15:01:53 +0200
Message-Id: <20190805124953.190420246@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124951.453337465@linuxfoundation.org>
References: <20190805124951.453337465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 4c094c33c9ed4b8d0d814bd1d7ff78e123d15d00 ]

Under certain conditions, we could have strange file extent item in log
tree like:

  item 18 key (69599 108 397312) itemoff 15208 itemsize 53
	extent data disk bytenr 0 nr 0
	extent data offset 0 nr 18446744073709547520 ram 18446744073709547520

The num_bytes + ram_bytes overflow 64 bit type.

For num_bytes part, we can detect such overflow along with file offset
(key->offset), as file_offset + num_bytes should never go beyond u64.

For ram_bytes part, it's about the decompressed size of the extent, not
directly related to the size.
In theory it is OK to have a large value, and put extra limitation
on RAM bytes may cause unexpected false alerts.

So in tree-checker, we only check if the file offset and num bytes
overflow.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-checker.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 96fce4bef4e7d..ccd5706199d76 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -132,6 +132,7 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	struct btrfs_file_extent_item *fi;
 	u32 sectorsize = fs_info->sectorsize;
 	u32 item_size = btrfs_item_size_nr(leaf, slot);
+	u64 extent_end;
 
 	if (!IS_ALIGNED(key->offset, sectorsize)) {
 		file_extent_err(leaf, slot,
@@ -207,6 +208,16 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	    CHECK_FE_ALIGNED(leaf, slot, fi, num_bytes, sectorsize))
 		return -EUCLEAN;
 
+	/* Catch extent end overflow */
+	if (check_add_overflow(btrfs_file_extent_num_bytes(leaf, fi),
+			       key->offset, &extent_end)) {
+		file_extent_err(leaf, slot,
+	"extent end overflow, have file offset %llu extent num bytes %llu",
+				key->offset,
+				btrfs_file_extent_num_bytes(leaf, fi));
+		return -EUCLEAN;
+	}
+
 	/*
 	 * Check that no two consecutive file extent items, in the same leaf,
 	 * present ranges that overlap each other.
-- 
2.20.1



