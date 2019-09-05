Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F24C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E126720870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="aGcnV3R3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389188AbfIEO1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 10:27:34 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37384 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389046AbfIEO13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:27:29 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x85EQC1b002067;
        Thu, 5 Sep 2019 16:27:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=I25v1nGgd0oB934K7CvEPzrYGTMEjRKegcH/B1pV2tE=;
 b=aGcnV3R3g8lgKmTYEM6XrDWRO/ZY8NjnWR1BNmyaKMNhkx5KQNO2J5lKDq+2ra1fASoq
 wGPKGkNfG659b+Dg/GCFs/3TaLWgn5qM0ukuby+kTMDumhnjZmlYVNOj4RFHa7kic4Xn
 VLmiO5b62cjs/Zc3BdpVLLy57QU40ufQ+Z+BmwkjGjU8+NOV3yau5eB9DEuEHhLa6mNZ
 b64CjFK/SgXEHa/hZjXYEMFaCYPW2FZ7wZIIeZXJyGzlZ4oZIvvTybFTjVR6QExknJEY
 MiYwJ22QdVneXdXgevGxXfteJPWDnPnkUnlPaLUQQlcmYxkW6NpQUnNiF28Uws5o44pO yQ== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2uqec38u1s-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Sep 2019 16:27:24 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 51E7124;
        Thu,  5 Sep 2019 14:27:21 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AEFCB2D6C48;
        Thu,  5 Sep 2019 16:27:20 +0200 (CEST)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 5 Sep 2019
 16:27:20 +0200
Received: from localhost (10.48.0.131) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 5 Sep 2019 16:27:20 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <arnaud.pouliquen@st.com>, Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 3/3] rpmsg: smd: implement get_mtu ops
Date:   Thu, 5 Sep 2019 16:27:10 +0200
Message-ID: <1567693630-27544-4-git-send-email-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567693630-27544-1-git-send-email-arnaud.pouliquen@st.com>
References: <1567693630-27544-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.131]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-05_04:2019-09-04,2019-09-05 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the get_mtu ops to return the maximum size of
the message that can be sent.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/rpmsg/qcom_smd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 4abbeea782fa..f233f8d85062 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -989,6 +989,13 @@ static __poll_t qcom_smd_poll(struct rpmsg_endpoint *ept,
 	return mask;
 }
 
+static ssize_t qcom_smd_get_mtu(struct rpmsg_endpoint *ept)
+{
+	struct qcom_smd_endpoint *qsept = to_smd_endpoint(ept);
+
+	return qcom_smd_get_tx_avail(qsept->qsch);
+}
+
 /*
  * Finds the device_node for the smd child interested in this channel.
  */
@@ -1040,6 +1047,7 @@ static const struct rpmsg_endpoint_ops qcom_smd_endpoint_ops = {
 	.send = qcom_smd_send,
 	.trysend = qcom_smd_trysend,
 	.poll = qcom_smd_poll,
+	.get_mtu = qcom_smd_get_mtu,
 };
 
 static void qcom_smd_release_device(struct device *dev)
-- 
2.7.4

