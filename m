Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D6BC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3FF21848
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118979;
	bh=14EbOH0XAvEPQOaJJj0L0hn8plnIwTmS2PmGUyKvBX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bExhbM0759zJnb5BPUYsckXMNnFxmdcaXeXIPqedzHY3wJg/TeOL1peINuNwY+oJm
	 twMi8k3ryHirE0b3rL2+Qok9DujfwEoiLaLN73KFiDuEnrStLEY/QOFqpp4pQ62wIk
	 Kxl8tKxFfcaEncjXB8G+TmzDf8FhObOULnzZkFJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387489AbfJCQJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:09:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733205AbfJCQJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:09:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BCA5215EA;
        Thu,  3 Oct 2019 16:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118975;
        bh=14EbOH0XAvEPQOaJJj0L0hn8plnIwTmS2PmGUyKvBX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dky9YNolcp5NZ1MF1din0No/EKQBNPG6xIkKFFCZnnTXQ86L/Fsw10vL4tm+sZWeG
         OTpvluryxH1CX2NNl6raGjT8OX1VgXcWUlignRa8I6/WSFJLCPm6Yst2hP+ZCOKUBV
         nsp+QZdlrVfMvu6E0J7m1g2wwJL9kAc6msCcfrRk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 078/185] md: dont set In_sync if array is frozen
Date:   Thu,  3 Oct 2019 17:52:36 +0200
Message-Id: <20191003154455.019955860@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index d185725e100c0..f86082ee62a69 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1763,8 +1763,15 @@ static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
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



