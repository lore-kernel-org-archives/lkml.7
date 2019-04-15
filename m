Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5E0C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F7C20651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356434;
	bh=hpiqTd/P6BMJYi+6k9w4PAG0tK+1UoYNrV4EHNNNZak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hFxoZgQUvcC9P53Pv8F8eUExyIuZV7BbzC9FV6a3dVMN1wzkbHwSM67/V9bZ6gx2y
	 +BLslxfEyfv6N2rpPNSmRSUvDNip2bupmcsy5eMkLegc3rctJnRClpWz5uznv0pzIT
	 7lYufXwdaUeqUF9Z53M2u7t9oVbBPcFRASEZX/tA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfDOTEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:04:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729384AbfDOTEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:04:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB00B218A1;
        Mon, 15 Apr 2019 19:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355040;
        bh=hpiqTd/P6BMJYi+6k9w4PAG0tK+1UoYNrV4EHNNNZak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1OI+pAZN1wQDC/go7ohqmdTvx4OnqU8UvZ/k3wcsEfAHoOn8iqBcYzMrnGth74NNW
         oAU/QdMIagSErZ8oJeZx73Dxdf+l+MUCdojKGKueGCOl8GIv+o6A6hiLqw0M9q59Uy
         PiIRGfT8GUSU+5ysLzEPof1PEG6/2qp1UzKVCKWo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 46/69] Btrfs: do not allow trimming when a fs is mounted with the nologreplay option
Date:   Mon, 15 Apr 2019 20:59:04 +0200
Message-Id: <20190415183733.564505537@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

commit f35f06c35560a86e841631f0243b83a984dc11a9 upstream.

Whan a filesystem is mounted with the nologreplay mount option, which
requires it to be mounted in RO mode as well, we can not allow discard on
free space inside block groups, because log trees refer to extents that
are not pinned in a block group's free space cache (pinning the extents is
precisely the first phase of replaying a log tree).

So do not allow the fitrim ioctl to do anything when the filesystem is
mounted with the nologreplay option, because later it can be mounted RW
without that option, which causes log replay to happen and result in
either a failure to replay the log trees (leading to a mount failure), a
crash or some silent corruption.

Reported-by: Darrick J. Wong <darrick.wong@oracle.com>
Fixes: 96da09192cda ("btrfs: Introduce new mount option to disable tree log replay")
CC: stable@vger.kernel.org # 4.9+
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/ioctl.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -357,6 +357,16 @@ static noinline int btrfs_ioctl_fitrim(s
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	/*
+	 * If the fs is mounted with nologreplay, which requires it to be
+	 * mounted in RO mode as well, we can not allow discard on free space
+	 * inside block groups, because log trees refer to extents that are not
+	 * pinned in a block group's free space cache (pinning the extents is
+	 * precisely the first phase of replaying a log tree).
+	 */
+	if (btrfs_test_opt(fs_info, NOLOGREPLAY))
+		return -EROFS;
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(device, &fs_info->fs_devices->devices,
 				dev_list) {


