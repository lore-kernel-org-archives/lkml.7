Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8D8C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8921A24679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576780753;
	bh=pOaiTSfXfkzb4yCkG99q6kYmRc3WfbW5SLo/nngysWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WIdR1ugZY6S8MlRchrGSnDdRy5HTom3xzlFMD23+Znic1IrC44/daISAfE5ajA09m
	 xEEanOCVma/yJZPZmbJKvKQW9P1G7xdzEC+ry9dErDVdxTlYcFiC/WU8WDBAuglRIx
	 2mtgAu0xPKPCqTmleegMNKGYghiXb9Xaj8YA3ft0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfLSSjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:39:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbfLSSjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:39:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80A1D222C2;
        Thu, 19 Dec 2019 18:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780749;
        bh=pOaiTSfXfkzb4yCkG99q6kYmRc3WfbW5SLo/nngysWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sKbN3QlA20O6/IXaYeioVqnbZ7+7UoW43ehBHpN0goFQbSUlgYEUoWaAYtr7vDP3i
         eKRNT9KLs/X62Yw2ye2ZTGNmstiFN6kHIzRHht+hyYmommBSZTiw7ML2WVnkE+uxq7
         8pAfuPhyALY0I4e42AdHx9s0kueAca6xcYoU7NOo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.4 100/162] btrfs: Remove btrfs_bio::flags member
Date:   Thu, 19 Dec 2019 19:33:28 +0100
Message-Id: <20191219183213.864044070@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

commit 34b127aecd4fe8e6a3903e10f204a7b7ffddca22 upstream.

The last user of btrfs_bio::flags was removed in commit 326e1dbb5736
("block: remove management of bi_remaining when restoring original
bi_end_io"), remove it.

(Tagged for stable as the structure is heavily used and space savings
are desirable.)

CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/volumes.h |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -312,7 +312,6 @@ struct btrfs_bio {
 	u64 map_type; /* get from map_lookup->type */
 	bio_end_io_t *end_io;
 	struct bio *orig_bio;
-	unsigned long flags;
 	void *private;
 	atomic_t error;
 	int max_errors;


