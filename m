Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B65CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0FD2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710865;
	bh=MKWLuuAZsmOExOOCjpwUIYglaDYe4yMjxfDfPuAvdDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c/uZjsnt05qgIKNzSmeCWuVJS3wzjwQTsz1zRb/ht/7v6bGq2irtajLwIFaRLMDkz
	 jsQYjyzo2Xv03lrsHDx5/HTk931NKZ7Qwo+CtV1+ZGu5F4Wq+y0hXcnihW3ScDo/pZ
	 0szvR8jRohEjKjHY8dXq4o5lErWFSCe5x1Ul/dGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391036AbfC0SVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:21:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391055AbfC0SU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:20:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 089412177E;
        Wed, 27 Mar 2019 18:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710855;
        bh=MKWLuuAZsmOExOOCjpwUIYglaDYe4yMjxfDfPuAvdDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WoqRzRA0l/VXD85M6nsiZdpIIXzW9Y+x60H5s/fif+C2LwAeDhMkSaRZ/1YiAz4Gf
         iZwfpfRKqf01Qn2LsoSaJyxOlsHiLY6YYav1s7GkpTmWyWkeeQV0cLQSSPyGlxuF2R
         cLWbbyFnmNkItS4POfZCnrivQWP8b8p3EQi5CKY0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Garry <john.garry@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 09/87] scsi: hisi_sas: Set PHY linkrate when disconnected
Date:   Wed, 27 Mar 2019 14:19:22 -0400
Message-Id: <20190327182040.17444-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182040.17444-1-sashal@kernel.org>
References: <20190327182040.17444-1-sashal@kernel.org>
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
index 2f872f784e10..5252dd5d3f4b 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -10,6 +10,7 @@
  */
 
 #include "hisi_sas.h"
+#include "../libsas/sas_internal.h"
 #define DRV_NAME "hisi_sas"
 
 #define DEV_IS_GONE(dev) \
@@ -1128,9 +1129,18 @@ static void hisi_sas_port_deformed(struct asd_sas_phy *sas_phy)
 
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

