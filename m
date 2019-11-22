Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB24C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CD220409
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403925;
	bh=ATdpP1jroSqfhMeDCo6/WeKsVd5kpYFW/d4hqYGvmMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Np4SYzgpvS3dbB19o+a5f7DgycTXXaccs/RMD5V3Y/COa2HG+2tir7FmiCMc9BWrJ
	 6x3OC5TiJZLxmKdH6K7/ex6awKQhemdySB/UBFvFPJNWMIYy5icwcn5SorwcKe2hl4
	 MiaghWwMaMUO7nrGEEc+YN8361l/4hud2xjfn/MA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfKVFvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:51:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727977AbfKVFvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:51:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 972DE2068F;
        Fri, 22 Nov 2019 05:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401864;
        bh=ATdpP1jroSqfhMeDCo6/WeKsVd5kpYFW/d4hqYGvmMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2OJ4UDDrpHX4rxdE8IZA9pjJlyxHQMwpFkWGTT6mqunS/e6KKKTFZFTKIXztxAU6
         s73cFdD9wxmW4b3qxe36JXQSfifgPhZuTAHE1BOtplK8r8+7X4CkBytnQbUTnjHycy
         gdXwEZVx/z/4E9eafsMhOHvs1iG8WY0OL2piiWTA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heinz Mauelshagen <heinzm@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>, dm-devel@redhat.com
Subject: [PATCH AUTOSEL 4.19 100/219] dm raid: fix false -EBUSY when handling check/repair message
Date:   Fri, 22 Nov 2019 00:47:12 -0500
Message-Id: <20191122054911.1750-93-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heinz Mauelshagen <heinzm@redhat.com>

[ Upstream commit 74694bcbdf7e28a5ad548cdda9ac56d30be00d13 ]

Sending a check/repair message infrequently leads to -EBUSY instead of
properly identifying an active resync.  This occurs because
raid_message() is testing recovery bits in a racy way.

Fix by calling decipher_sync_action() from raid_message() to properly
identify the idle state of the RAID device.

Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-raid.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index b78a8a4d061ca..416998523d455 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3690,8 +3690,7 @@ static int raid_message(struct dm_target *ti, unsigned int argc, char **argv,
 			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 			md_reap_sync_thread(mddev);
 		}
-	} else if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
-		   test_bit(MD_RECOVERY_NEEDED, &mddev->recovery))
+	} else if (decipher_sync_action(mddev, mddev->recovery) != st_idle)
 		return -EBUSY;
 	else if (!strcasecmp(argv[0], "resync"))
 		; /* MD_RECOVERY_NEEDED set below */
-- 
2.20.1

