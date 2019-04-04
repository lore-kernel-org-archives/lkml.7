Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA466C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77222205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370403;
	bh=iTkadlmVPSaaQcSS9pkXLvzqAvXkQ5rej7hrT4aCC6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JQD2+di7WnR5yQPwFBh3JhK2TmHgfQET3KK1fvPnHN3wfkv/OxFSLdvkISRmylSwT
	 UEAItC9LqKFT659Zlg7yqnIphz7MKHr9UYgcu1O8zRN5EYMRgHAY8dq6reXjytG/x4
	 tdwjcrBdoAyhtMf1sSqJ3Vl9pUg7kQP7701wzD08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732878AbfDDJdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:33:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732429AbfDDJIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:08:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2702C218FE;
        Thu,  4 Apr 2019 09:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368895;
        bh=iTkadlmVPSaaQcSS9pkXLvzqAvXkQ5rej7hrT4aCC6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCCwmnL3S0n9rmlCH4FXGpmB/R4kg7B+R8SFXULefwfJsYZ5LUEtoMtJsyrwrdIcR
         QReh5EFMuNEd5oIrXoyNZwHByjUnEX4eqYwOOg/SNr9l6VlFA3R8ippu20pTzvEje5
         qkPEcp8emCWPb17em9efBZxwxdBqpOyVJHYux1C0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 021/246] scsi: hisi_sas: Set PHY linkrate when disconnected
Date:   Thu,  4 Apr 2019 10:45:21 +0200
Message-Id: <20190404084619.888493629@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
index bc17fa0d8375..88ae415e907a 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -10,6 +10,7 @@
  */
 
 #include "hisi_sas.h"
+#include "../libsas/sas_internal.h"
 #define DRV_NAME "hisi_sas"
 
 #define DEV_IS_GONE(dev) \
@@ -1972,9 +1973,18 @@ static int hisi_sas_write_gpio(struct sas_ha_struct *sha, u8 reg_type,
 
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



