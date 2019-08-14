Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA10C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C732084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="ewaZL/m7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfHNUIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 16:08:37 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:35480 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726522AbfHNUIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:08:36 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7EK5HJf003387
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 16:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id; s=smtpout1;
 bh=fXpVluUplGl9HfVo+OrHKDg67y75U27zIUI7apa/eeA=;
 b=ewaZL/m7PEgrfaZXrWUD/kVLUb5q7rO7jawWy3zcsEjW+Fv47bvltNenjuhKlbz6OHHg
 wKSzdGu7xRJX9nsezI/YVXRZUnxG6ToftjiZ2gQ3LJkwL6rWVWNnHgfZBQRpFNAyBSsO
 2qsPXamtCGJicnC00PMtqM5gDab1ljHSHeGoJ9/dlY4rOHT3xnUYaNEWSYMDpkJ1uKMy
 TC3wez1ydu3smuPDPv+VZU4RQkfS+c4BMigi4bu76OKOC+MTK3Otbp3WsYz3lBPIqtWr
 hr6S3Q9Tjm2j2F+0GXJ9CFudJOFW7miR+IxA5q1Yg6/irH/cJSIxN3ZnXj6dv10f6tO7 YQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2uc42nwcbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 16:08:35 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7EK7kTk132468
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 16:08:34 -0400
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com [143.166.85.200])
        by mx0b-00154901.pphosted.com with ESMTP id 2ucp0tu33q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 16:08:34 -0400
X-LoopCount0: from 10.173.37.27
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="843845849"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ryan Hong <Ryan.Hong@Dell.com>, Crag Wang <Crag.Wang@dell.com>,
        sjg@google.com, Charles Hyde <charles.hyde@dellteam.com>,
        Jared Dominguez <jared.dominguez@dell.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH v2] nvme: Add quirk for LiteON CL1 devices running FW 22301111
Date:   Wed, 14 Aug 2019 15:08:24 -0500
Message-Id: <1565813304-16710-1-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=770 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140183
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=885 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908140182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the components in LiteON CL1 device has limitations that
can be encountered based upon boundary race conditions using the
nvme bus specific suspend to idle flow.

When this situation occurs the drive doesn't resume properly from
suspend-to-idle.

LiteON has confirmed this problem and fixed in the next firmware
version.  As this firmware is already in the field, avoid running
nvme specific suspend to idle flow.

Fixes: d916b1be94b6 ("nvme-pci: use host managed power state for suspend")
Link: http://lists.infradead.org/pipermail/linux-nvme/2019-July/thread.html
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
Signed-off-by: Charles Hyde <charles.hyde@dellteam.com>
---
 drivers/nvme/host/core.c | 10 ++++++++++
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  |  3 ++-
 3 files changed, 17 insertions(+), 1 deletion(-)

This patch is the spiritual successor to the previously submitted
patch "[PATCH] drivers/nvme: save/restore HMB on suspend/resume".

After discussion with LiteON, they agreed to resolve the issue
in their next firmware release.

changes from v1:
 * Group all 3 possible CL1 strings together
 * Remove the resume code because it's
   already implied by ndev->last_ps = U32_MAX
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8f3fbe5..02770d6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2251,6 +2251,16 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
 		.vid = 0x1179,
 		.mn = "THNSF5256GPUK TOSHIBA",
 		.quirks = NVME_QUIRK_NO_APST,
+	},
+	/*
+	 * This LiteON CL1-3D*-Q11 firmware version has a race condition
+	 * associated with actions related to suspend to idle.  LiteON has
+	 * resolved the problem in future firmware.
+	 */
+	{
+		.vid = 0x14a4,
+		.fr = "22301111",
+		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
 	}
 };
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 26b563f..fe1ca0d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -92,6 +92,11 @@ enum nvme_quirks {
 	 * Broken Write Zeroes.
 	 */
 	NVME_QUIRK_DISABLE_WRITE_ZEROES		= (1 << 9),
+
+	/*
+	 * Force simple suspend/resume path.
+	 */
+	NVME_QUIRK_SIMPLE_SUSPEND		= (1 << 10),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 108e109..b366f54 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2875,7 +2875,8 @@ static int nvme_suspend(struct device *dev)
 	 * state (which may not be possible if the link is up).
 	 */
 	if (pm_suspend_via_firmware() || !ctrl->npss ||
-	    !pcie_aspm_enabled(pdev)) {
+	    !pcie_aspm_enabled(pdev) ||
+	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND)) {
 		nvme_dev_disable(ndev, true);
 		return 0;
 	}
-- 
2.7.4

