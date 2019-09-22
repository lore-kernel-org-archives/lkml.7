Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE098C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F5D2053B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179945;
	bh=skgGzswSz24HtRMDnCp6Kk1bFMF4TPrE0bKwgDLKF0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gOEagZtZHtq3cSQmFHO5GJGdChyIWh9Jejx1X+77vfPsojNUBK2gxO47TWodIwIV7
	 JgB0gYKzQcCdkDAS5kSV/GHXN8q9svfot2xubIjvFel+gJqq7S3eDYH/u0gartj5wz
	 SSWDv6rqi0vnahtysiPZdOL0VzpO8Fx2S8+B2cg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437286AbfIVTTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:19:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436478AbfIVSzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:55:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE9522190F;
        Sun, 22 Sep 2019 18:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178500;
        bh=skgGzswSz24HtRMDnCp6Kk1bFMF4TPrE0bKwgDLKF0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xVsXsFZOXqMTCLWXMx5G8VYItTmPcSog9sFL2iborJCyQRjdP+rVHtudWg8qAgGwR
         SiVBA7Cu+5PiE6m+NgIYc2LNH75LFr3CS1Atcg/bAGVZXZl0xcxbtkKby2twjReY8i
         zxXubLbVcJy44Svmv1dfGwRKoWlIJ1t7XfIpw0Fc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guoqing Jiang <jgq516@gmail.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 033/128] md: don't set In_sync if array is frozen
Date:   Sun, 22 Sep 2019 14:52:43 -0400
Message-Id: <20190922185418.2158-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185418.2158-1-sashal@kernel.org>
References: <20190922185418.2158-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guoqing Jiang <jgq516@gmail.com>

[ Upstream commit 062f5b2ae12a153644c765e7ba3b0f825427be1d ]

When a disk is added to array, the following path is called in mdadm.

Manage_subdevs -> sysfs_freeze_array
               -> Manage_add
               -> sysfs_set_str(&info, NULL, "sync_action","idle")

Then from kernel side, Manage_add invokes the path (add_new_disk ->
validate_super = super_1_validate) to set In_sync flag.

Since In_sync means "device is in_sync with rest of array", and the new
added disk need to resync thread to help the synchronization of data.
And md_reap_sync_thread would call spare_active to set In_sync for the
new added disk finally. So don't set In_sync if array is in frozen.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 73758b3679a11..277025784d6c0 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1770,8 +1770,15 @@ static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
 				if (!(le32_to_cpu(sb->feature_map) &
 				      MD_FEATURE_RECOVERY_BITMAP))
 					rdev->saved_raid_disk = -1;
-			} else
-				set_bit(In_sync, &rdev->flags);
+			} else {
+				/*
+				 * If the array is FROZEN, then the device can't
+				 * be in_sync with rest of array.
+				 */
+				if (!test_bit(MD_RECOVERY_FROZEN,
+					      &mddev->recovery))
+					set_bit(In_sync, &rdev->flags);
+			}
 			rdev->raid_disk = role;
 			break;
 		}
-- 
2.20.1

