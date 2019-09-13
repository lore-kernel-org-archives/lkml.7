Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A7DC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F04205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381473;
	bh=QuVe6d5LdFxeyz/vanqYXnbMCvw8HZFJkhzvjfWyPao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CCBJD16B7vHe/yeVFg3Yo1G6RW8GGwInCNvu/lIY7/wxJ52qDV1dWyFsi0ILbydqE
	 PqJEhnebyloVeAmPRGVIuVy4N+yy1gXQRT5VN8369DHe6uxT/8J5greJSy6ze8Sem8
	 l/Ju5/YbHsFGBzP5F51aWB/P42JGNmvFap+T9LX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391709AbfIMNbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:31:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388745AbfIMNPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:15:25 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4F5A208C2;
        Fri, 13 Sep 2019 13:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380525;
        bh=QuVe6d5LdFxeyz/vanqYXnbMCvw8HZFJkhzvjfWyPao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cDj+Axa9+WD6K+VNkp3wBb75mscCKNiiwR9+8EFhixgfplmCtnkTcaPJZlb+bYaxN
         TT8dwVXqfmGJFWauKKGeI74pNrMDHWOMMgyapgtiIYwkmFqAQ9DUpPx+oZ0JInoHe1
         pSMC/wo0gKTbc5BA0PgZjNvDV1KdMR4Bk7UOQSok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 074/190] btrfs: Use real device structure to verify dev extent
Date:   Fri, 13 Sep 2019 14:05:29 +0100
Message-Id: <20190913130605.491752937@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1b3922a8bc74231f9a767d1be6d9a061a4d4eeab ]

[BUG]
Linux v5.0-rc1 will fail fstests/btrfs/163 with the following kernel
message:

  BTRFS error (device dm-6): dev extent devid 1 physical offset 13631488 len 8388608 is beyond device boundary 0
  BTRFS error (device dm-6): failed to verify dev extents against chunks: -117
  BTRFS error (device dm-6): open_ctree failed

[CAUSE]
Commit cf90d884b347 ("btrfs: Introduce mount time chunk <-> dev extent
mapping check") introduced strict check on dev extents.

We use btrfs_find_device() with dev uuid and fs uuid set to NULL, and
only dependent on @devid to find the real device.

For seed devices, we call clone_fs_devices() in open_seed_devices() to
allow us search seed devices directly.

However clone_fs_devices() just populates devices with devid and dev
uuid, without populating other essential members, like disk_total_bytes.

This makes any device returned by btrfs_find_device(fs_info, devid,
NULL, NULL) is just a dummy, with 0 disk_total_bytes, and any dev
extents on the seed device will not pass the device boundary check.

[FIX]
This patch will try to verify the device returned by btrfs_find_device()
and if it's a dummy then re-search in seed devices.

Fixes: cf90d884b347 ("btrfs: Introduce mount time chunk <-> dev extent mapping check")
CC: stable@vger.kernel.org # 4.19+
Reported-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/volumes.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c20708bfae561..a8297e7489d98 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7469,6 +7469,18 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 		ret = -EUCLEAN;
 		goto out;
 	}
+
+	/* It's possible this device is a dummy for seed device */
+	if (dev->disk_total_bytes == 0) {
+		dev = find_device(fs_info->fs_devices->seed, devid, NULL);
+		if (!dev) {
+			btrfs_err(fs_info, "failed to find seed devid %llu",
+				  devid);
+			ret = -EUCLEAN;
+			goto out;
+		}
+	}
+
 	if (physical_offset + physical_len > dev->disk_total_bytes) {
 		btrfs_err(fs_info,
 "dev extent devid %llu physical offset %llu len %llu is beyond device boundary %llu",
-- 
2.20.1



