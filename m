Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF33FC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFE7208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="wtBDntCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387462AbfIRSQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 14:16:16 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:16730 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726900AbfIRSQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:16:16 -0400
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8II0KqD016658
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 14:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id; s=smtpout1;
 bh=A/GA2kt9PkFSXOdi/VLlD9hTYzR2T4fpkhomChyE9Co=;
 b=wtBDntCf5Mg7NkwRO3z1NSwe+wwKrvyJ1tO4RyzGpkjZmVAU8SyKMLn3x5ypui8BY6ol
 bfPdT3dlID39LPQ7hQfVE6jzfqgUIkuwu6AjkdnwEiSuoRfbqcNe1pfqqkXcJls6Gao7
 8pM3Iw49DJT6l551+PfrbkHNyDhXDMEQY5euUBhbh74bY9H9yV4RB977Vpdyc7EAm3Un
 ibT8iZaRP9RVkhR7/XSA+ad/1td7qZfWvPbqWuW5l5pxayStpcTD6OE5eZ+CY9F4GOmB
 YvduR+pfjd2vQzLIDb+zVAVyx4qxb1MXaFcWayKuweuRv2izOq2scZcZXsC1wBTtBLMj hQ== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2v37p0wt4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 14:16:15 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8II2vBp082587
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 14:16:14 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0b-00154901.pphosted.com with ESMTP id 2v37hs7vyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 14:16:14 -0400
X-LoopCount0: from 10.173.37.27
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1299619002"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ryan Hong <Ryan.Hong@Dell.com>, Crag Wang <Crag.Wang@dell.com>,
        sjg@google.com, Jared Dominguez <jared.dominguez@dell.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH v2] nvme-pci: Save PCI state before putting drive into deepest state
Date:   Wed, 18 Sep 2019 13:15:55 -0500
Message-Id: <1568830555-11531-1-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-18_09:2019-09-18,2019-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=3 mlxlogscore=567
 clxscore=1015 malwarescore=0 mlxscore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 lowpriorityscore=3 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909180161
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=6 bulkscore=6 suspectscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=710 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909180161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The action of saving the PCI state will cause numerous PCI configuration
space reads which depending upon the vendor implementation may cause
the drive to exit the deepest NVMe state.

In these cases ASPM will typically resolve the PCIe link state and APST
may resolve the NVMe power state.  However it has also been observed
that this register access after quiesced will cause PC10 failure
on some device combinations.

To resolve this, move the PCI state saving to before SetFeatures has been
called.  This has been proven to resolve the issue across a 5000 sample
test on previously failing disk/system combinations.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/nvme/host/pci.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

Changes from v1:
 * Discard saved state in error scenario
 * Removed unneeded goto statement in error scenario

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 732d5b6..ef69013 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2894,11 +2894,21 @@ static int nvme_suspend(struct device *dev)
 	if (ret < 0)
 		goto unfreeze;
 
+	/*
+	 * A saved state prevents pci pm from generically controlling the
+	 * device's power. If we're using protocol specific settings, we don't
+	 * want pci interfering.
+	 */
+	pci_save_state(pdev);
+
 	ret = nvme_set_power_state(ctrl, ctrl->npss);
 	if (ret < 0)
 		goto unfreeze;
 
 	if (ret) {
+		/* discard the saved state */
+		pci_load_saved_state(pdev, NULL);
+
 		/*
 		 * Clearing npss forces a controller reset on resume. The
 		 * correct value will be resdicovered then.
@@ -2906,14 +2916,7 @@ static int nvme_suspend(struct device *dev)
 		nvme_dev_disable(ndev, true);
 		ctrl->npss = 0;
 		ret = 0;
-		goto unfreeze;
 	}
-	/*
-	 * A saved state prevents pci pm from generically controlling the
-	 * device's power. If we're using protocol specific settings, we don't
-	 * want pci interfering.
-	 */
-	pci_save_state(pdev);
 unfreeze:
 	nvme_unfreeze(ctrl);
 	return ret;
-- 
2.7.4

