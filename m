Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9E7C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DC8205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519191;
	bh=vcw8e7sa05RyMhS4Kpi3imk8mmXPeDfeCjey1rZECiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MdEeWnhW+nSExqZIMK6CVtrXmfrZ6ClIBg7wj3bkz4wjDHVI/3k2+R+ETRMeVsXw9
	 m9FHDNEMK2VLuaTpiFPxxAuT/t/hCtzaohYyHPsV+6Gh1VJTY/bgyy7b4eOLyAH2tg
	 wLl2IEN4JgyXfq/CO9yHYjkklSJpJuvpcSKirDKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfLPR7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:59:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:33080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728806AbfLPR7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:59:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AF35206B7;
        Mon, 16 Dec 2019 17:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519187;
        bh=vcw8e7sa05RyMhS4Kpi3imk8mmXPeDfeCjey1rZECiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rffLCONMqvstCrFpZhKIKHyKkY7NK4LgTp+0oan1ZAYo8uCEE51m1/dwwTLFc6daI
         pH3xLXCnmmYYgj93Di1qcHP31fnNJiClexN+s1cOtnZJdbcQKDX/J41d/gEn0JpCsm
         Kv8x7eoARQLRHBYLiv5T8IQpkbF6ttyD1cS4LAVo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 190/267] btrfs: record all roots for rename exchange on a subvol
Date:   Mon, 16 Dec 2019 18:48:36 +0100
Message-Id: <20191216174912.935577828@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

commit 3e1740993e43116b3bc71b0aad1e6872f6ccf341 upstream.

Testing with the new fsstress support for subvolumes uncovered a pretty
bad problem with rename exchange on subvolumes.  We're modifying two
different subvolumes, but we only start the transaction on one of them,
so the other one is not added to the dirty root list.  This is caught by
btrfs_cow_block() with a warning because the root has not been updated,
however if we do not modify this root again we'll end up pointing at an
invalid root because the root item is never updated.

Fix this by making sure we add the destination root to the trans list,
the same as we do with normal renames.  This fixes the corruption.

Fixes: cdd1fedf8261 ("btrfs: add support for RENAME_EXCHANGE and RENAME_WHITEOUT")
CC: stable@vger.kernel.org # 4.9+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/inode.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9839,6 +9839,9 @@ static int btrfs_rename_exchange(struct
 		goto out_notrans;
 	}
 
+	if (dest != root)
+		btrfs_record_root_in_trans(trans, dest);
+
 	/*
 	 * We need to find a free sequence number both in the source and
 	 * in the destination directory for the exchange.


