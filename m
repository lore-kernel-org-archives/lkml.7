Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA5CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB8B21783
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210985;
	bh=19DK42xMFXFJqJtl0anLycud8kNLzCwwMFq8BCP7JqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1V0zIVevWqbng2uYce88e9uVuNtJERP/vIMn/8MEzV/lzu0Vi1SKMI1yJaMzAP4sh
	 2IG4uMfgeMfiQUtnfvDi/lkWZcFmj8YsCJR/Ak424FgDj379YDIe/0iaEthksT5g/H
	 I9Wm+q9Azqkq9hCoxVizy8NEk2UeBzqi69XBiYmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbfJ0VQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:16:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730810AbfJ0VQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:16:21 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26D7121783;
        Sun, 27 Oct 2019 21:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210980;
        bh=19DK42xMFXFJqJtl0anLycud8kNLzCwwMFq8BCP7JqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AGEgiuvJtDYm/o8wMB7SWXWEjYeyFv+PW06uYKsEgNJVX6gfpthJC0PLiXFdwf3A6
         QEDJKKList3yhWIpZfZ2jwNQLyxVCUSWBZSOXsjBYApE6bJmYCSBsbs2P/55Mo0QCW
         NhrQYUClyX0GGYQo5jW8HeTPi9Eg8yZjf15s5yqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 85/93] Btrfs: add missing extents release on file extent cluster relocation error
Date:   Sun, 27 Oct 2019 22:01:37 +0100
Message-Id: <20191027203314.601523054@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203251.029297948@linuxfoundation.org>
References: <20191027203251.029297948@linuxfoundation.org>
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
@@ -3187,6 +3187,8 @@ static int relocate_file_extent_cluster(
 			if (!page) {
 				btrfs_delalloc_release_metadata(BTRFS_I(inode),
 							PAGE_SIZE, true);
+				btrfs_delalloc_release_extents(BTRFS_I(inode),
+							PAGE_SIZE, true);
 				ret = -ENOMEM;
 				goto out;
 			}


