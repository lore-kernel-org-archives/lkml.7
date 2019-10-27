Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403CACA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125DB21D7F
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211576;
	bh=8zOiwY3KowzDw7wOpnwU1HLCpcB7b8/Mfnq0T6Kahf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=buDk1UkhYhps/VFtaeh4oD+3oUIpIi30gTije+zpFqJXG7sQKq+GPTfyMdZdOHxQb
	 n0Q7imazRQxRPzHcsVccaylFxZFjA6xlmZc6Ojx48bjAPCNmKMcCCBea3JxmY7Jume
	 kcV5UPHP4/2n02hsuDBcb5jYsQl/t1gl0f8sBm+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732893AbfJ0V0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732270AbfJ0V0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:26:11 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9625421D80;
        Sun, 27 Oct 2019 21:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211571;
        bh=8zOiwY3KowzDw7wOpnwU1HLCpcB7b8/Mfnq0T6Kahf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rrZzmm8ZMX4J6tUg8GIhOwAN3TZHVC9sOo2/66MOJH+6/NlWOrV7RwSAT4B5BcFCa
         CjP4fS/A8HgRGI7uUD0lx4KuQmFRlNOIWTAmAuLI1/e+L5XjnecoWEsmXZxeProLlD
         iqXU3jAana0oG04Xi5Sw80Tkd/QzOT29xezx5JiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.3 182/197] Btrfs: add missing extents release on file extent cluster relocation error
Date:   Sun, 27 Oct 2019 22:01:40 +0100
Message-Id: <20191027203406.119457603@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

commit 44db1216efe37bf670f8d1019cdc41658d84baf5 upstream.

If we error out when finding a page at relocate_file_extent_cluster(), we
need to release the outstanding extents counter on the relocation inode,
set by the previous call to btrfs_delalloc_reserve_metadata(), otherwise
the inode's block reserve size can never decrease to zero and metadata
space is leaked. Therefore add a call to btrfs_delalloc_release_extents()
in case we can't find the target page.

Fixes: 8b62f87bad9c ("Btrfs: rework outstanding_extents")
CC: stable@vger.kernel.org # 4.19+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/relocation.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3276,6 +3276,8 @@ static int relocate_file_extent_cluster(
 			if (!page) {
 				btrfs_delalloc_release_metadata(BTRFS_I(inode),
 							PAGE_SIZE, true);
+				btrfs_delalloc_release_extents(BTRFS_I(inode),
+							PAGE_SIZE, true);
 				ret = -ENOMEM;
 				goto out;
 			}


