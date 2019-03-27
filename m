Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18896C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB88205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712892;
	bh=v7lxcPmZewZKfj39MpbVFT8/4MdP9w//ZBaoy98qYPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bjOdYMqn46d+VIK+gTIZy+ILq04ik4w+4a013q+gHOB18MiL0M946s3S3ReAqBb2L
	 X8ZfgBXL8pqbb3xOAS1Zaj7yxlhI3b7vhwS4RJyzHKsWrwsnMiHm82GnZ7yNvDLHB3
	 mx158upDhUV1m2S7DMyfZwCDDf19YLwbRSjIAkKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390400AbfC0Syu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:32892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390132AbfC0SQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:16:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 109322184C;
        Wed, 27 Mar 2019 18:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710607;
        bh=v7lxcPmZewZKfj39MpbVFT8/4MdP9w//ZBaoy98qYPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nQ00pmvYS7wcs7lsNeqPE7gOSCxUhRaM9j4ciyiWwsLyseC8SEHq1IxRaWSknaqyY
         waRbOrGABkugNmJxh4CjCXb+DDnkrvElaNdbzY569/H3TPHtAxgjREVDBEt3qWS9Ro
         pHTDnZOK7UTddCfQlhjecDxmGvtFgPF5hbTKbv3s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Garry <john.garry@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 012/123] scsi: hisi_sas: Set PHY linkrate when disconnected
Date:   Wed, 27 Mar 2019 14:14:36 -0400
Message-Id: <20190327181628.15899-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

[ Upstream commit efdcad62e7b8a02fcccc5ccca57806dce1482ac8 ]

When the PHY comes down, we currently do not set the negotiated linkrate:

root@(none)$ pwd
/sys/class/sas_phy/phy-0:0
root@(none)$ more enable
1
root@(none)$ more negotiated_linkrate
12.0 Gbit
root@(none)$ echo 0 > enable
root@(none)$ more negotiated_linkrate
12.0 Gbit
root@(none)$

This patch fixes the driver code to set it properly when the PHY comes
down.

If the PHY had been enabled, then set unknown; otherwise, flag as disabled.

The logical place to set the negotiated linkrate for this scenario is PHY
down routine, which is called from the PHY down ISR.

However, it is not possible to know if the PHY comes down due to PHY
disable or loss of link, as sas_phy.enabled member is not set until after
the transport disable routine is complete, which races with the PHY down
ISR.

As an imperfect solution, use sas_phy_data.enable as the flag to know if
the PHY is down due to disable. It's imperfect, as sas_phy_data is internal
to libsas.

I can't see another way without adding a new field to hisi_sas_phy and
managing it, or changing SCSI SAS transport.

Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 8fa9bb336ad4..b167411580ba 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -10,6 +10,7 @@
  */
 
 #include "hisi_sas.h"
+#include "../libsas/sas_internal.h"
 #define DRV_NAME "hisi_sas"
 
 #define DEV_IS_GONE(dev) \
@@ -1508,9 +1509,18 @@ static void hisi_sas_port_formed(struct asd_sas_phy *sas_phy)
 
 static void hisi_sas_phy_disconnected(struct hisi_sas_phy *phy)
 {
+	struct asd_sas_phy *sas_phy = &phy->sas_phy;
+	struct sas_phy *sphy = sas_phy->phy;
+	struct sas_phy_data *d = sphy->hostdata;
+
 	phy->phy_attached = 0;
 	phy->phy_type = 0;
 	phy->port = NULL;
+
+	if (d->enable)
+		sphy->negotiated_linkrate = SAS_LINK_RATE_UNKNOWN;
+	else
+		sphy->negotiated_linkrate = SAS_PHY_DISABLED;
 }
 
 void hisi_sas_phy_down(struct hisi_hba *hisi_hba, int phy_no, int rdy)
-- 
2.19.1

