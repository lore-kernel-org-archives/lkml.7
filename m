Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5677EC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FBA20693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370995;
	bh=qWevxc1nSbbuFpapfW3dmvkK6GZ7vAYk+0BfaiYiDH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MxZ46Od8QlOduOciqzBIg3GjTRnSvVOLhi8PCbGU/o++lTcf4QAYZWcZ2twNFbbJU
	 b+1KyRtxuili0eBD19TpH3O8KoIi8xhfeUG9mZIwewB0dIW83/6nEBWhXWNv+3Gkbp
	 ndVXjUSJnJ2OqC3bHA+KUDLwrrWND2hPZWhm9vAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbfDDJAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:00:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731300AbfDDJAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:00:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43F0321855;
        Thu,  4 Apr 2019 09:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368447;
        bh=qWevxc1nSbbuFpapfW3dmvkK6GZ7vAYk+0BfaiYiDH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jQwe6xrhEi256gVCMMCYXEYE8VmqDiOZBRujQS5FewhonLBusbvx3wLslHb9Xw84v
         N6+ZMKlmZ2U+14N6Lf/niVIt3SuvhUrIGNopti6rhvZpYhvUGkDElCVw5asMuUfSeS
         z22dhoTWC4c5LQCZkArm+Upm/4wIgFFD75Qxggg4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 018/187] scsi: hisi_sas: Set PHY linkrate when disconnected
Date:   Thu,  4 Apr 2019 10:45:55 +0200
Message-Id: <20190404084603.951238295@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index a4e2e6aa9a6b..c25f3a9b0b9f 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -10,6 +10,7 @@
  */
 
 #include "hisi_sas.h"
+#include "../libsas/sas_internal.h"
 #define DRV_NAME "hisi_sas"
 
 #define DEV_IS_GONE(dev) \
@@ -1879,9 +1880,18 @@ static int hisi_sas_write_gpio(struct sas_ha_struct *sha, u8 reg_type,
 
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



