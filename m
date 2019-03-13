Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D8CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E691A213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504704;
	bh=vsmukZjwr341I39UlMjrYziHYGjCzjZMmH/QkjEgf84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LczdnCHqcTGZ3VLwE6k4PrPAWVIcm59aUUZti5NkNwf4Tlv9yNexVUapQoNTjhsWA
	 KrnF5aeRP5EveriIjAQkeuDsz7KzyRFX0i+ITiFkbWigRTNzZbl+CU5HVBgP8P7Wnm
	 byGMvR/EVUtPt2n4pShxTUiNAqSlGAt8+05HP8dA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfCMTSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729033AbfCMTSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:18:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC3452171F;
        Wed, 13 Mar 2019 19:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504699;
        bh=vsmukZjwr341I39UlMjrYziHYGjCzjZMmH/QkjEgf84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KdTc5LeQ0iz5gn4EKhlys8pP3iT93XTHnubzdfDcb8VtyOyKJqvtnkx1EW0rRUv7E
         kbk7J+0H/um1q8APS4LxZRYpBff6utZg0myGwmtfWx5Spd9pwudVZwcGnf+H+2g0i4
         neBbROQ54FangdKVeacq6810/Zf8eE1Urn57tPjM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Garry <john.garry@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 04/15] scsi: libsas: Fix rphy phy_identifier for PHYs with end devices attached
Date:   Wed, 13 Mar 2019 15:17:50 -0400
Message-Id: <20190313191806.160547-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191806.160547-1-sashal@kernel.org>
References: <20190313191806.160547-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

[ Upstream commit ffeafdd2bf0b280d67ec1a47ea6287910d271f3f ]

The sysfs phy_identifier attribute for a sas_end_device comes from the rphy
phy_identifier value.

Currently this is not being set for rphys with an end device attached, so
we see incorrect symlinks from systemd disk/by-path:

root@localhost:~# ls -l /dev/disk/by-path/
total 0
lrwxrwxrwx 1 root root  9 Feb 13 12:26 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy0-lun-0 -> ../../sdb
lrwxrwxrwx 1 root root 10 Feb 13 12:26 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy0-lun-0-part1 -> ../../sdb1
lrwxrwxrwx 1 root root 10 Feb 13 12:26 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy0-lun-0-part2 -> ../../sdb2
lrwxrwxrwx 1 root root 10 Feb 13 12:26 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy0-lun-0-part3 -> ../../sdc3

Indeed, each sas_end_device phy_identifier value is 0:

root@localhost:/# more sys/class/sas_device/end_device-0\:0\:2/phy_identifier
0
root@localhost:/# more sys/class/sas_device/end_device-0\:0\:10/phy_identifier
0

This patch fixes the discovery code to set the phy_identifier.  With this,
we now get proper symlinks:

root@localhost:~# ls -l /dev/disk/by-path/
total 0
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy10-lun-0 -> ../../sdg
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy11-lun-0 -> ../../sdh
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy2-lun-0 -> ../../sda
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy2-lun-0-part1 -> ../../sda1
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy3-lun-0 -> ../../sdb
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy3-lun-0-part1 -> ../../sdb1
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy3-lun-0-part2 -> ../../sdb2
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy4-lun-0 -> ../../sdc
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy4-lun-0-part1 -> ../../sdc1
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy4-lun-0-part2 -> ../../sdc2
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy4-lun-0-part3 -> ../../sdc3
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy5-lun-0 -> ../../sdd
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy7-lun-0 -> ../../sde
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy7-lun-0-part1 -> ../../sde1
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy7-lun-0-part2 -> ../../sde2
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy7-lun-0-part3 -> ../../sde3
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy8-lun-0 -> ../../sdf
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy8-lun-0-part1 -> ../../sdf1
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy8-lun-0-part2 -> ../../sdf2
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy8-lun-0-part3 -> ../../sdf3

Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
Reported-by: dann frazier <dann.frazier@canonical.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
Tested-by: dann frazier <dann.frazier@canonical.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libsas/sas_expander.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 12886f96b286..7be581f7c35d 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -818,6 +818,7 @@ static struct domain_device *sas_ex_discover_end_dev(
 		rphy = sas_end_device_alloc(phy->port);
 		if (!rphy)
 			goto out_free;
+		rphy->identify.phy_identifier = phy_id;
 
 		child->rphy = rphy;
 		get_device(&rphy->dev);
@@ -845,6 +846,7 @@ static struct domain_device *sas_ex_discover_end_dev(
 
 		child->rphy = rphy;
 		get_device(&rphy->dev);
+		rphy->identify.phy_identifier = phy_id;
 		sas_fill_in_rphy(child, rphy);
 
 		list_add_tail(&child->disco_list_node, &parent->port->disco_list);
-- 
2.19.1

