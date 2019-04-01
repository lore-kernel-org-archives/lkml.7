Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A46C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EE6206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfDAIz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:55:26 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:16107 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728945AbfDAIzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:55:25 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x318k11S006552;
        Mon, 1 Apr 2019 10:55:13 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rhxt4hjx7-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 01 Apr 2019 10:55:13 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EAECF3F;
        Mon,  1 Apr 2019 08:55:09 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C8D2E165B;
        Mon,  1 Apr 2019 08:55:09 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.435.0; Mon, 1 Apr 2019
 10:55:09 +0200
Received: from localhost (10.201.23.19) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.435.0; Mon, 1 Apr 2019 10:55:07
 +0200
From:   Hugues Fruchet <hugues.fruchet@st.com>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
CC:     <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe CORNU <philippe.cornu@st.com>,
        "Hugues Fruchet" <hugues.fruchet@st.com>
Subject: [PATCH 1/2] media: stm32-dcmi: fix error messages
Date:   Mon, 1 Apr 2019 10:54:59 +0200
Message-ID: <1554108900-30705-2-git-send-email-hugues.fruchet@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554108900-30705-1-git-send-email-hugues.fruchet@st.com>
References: <1554108900-30705-1-git-send-email-hugues.fruchet@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.19]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-01_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revisit and add some error messages.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index 098431d..693415c 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -1611,7 +1611,7 @@ static int dcmi_graph_init(struct stm32_dcmi *dcmi)
 	/* Parse the graph to extract a list of subdevice DT nodes. */
 	ret = dcmi_graph_parse(dcmi, dcmi->dev->of_node);
 	if (ret < 0) {
-		dev_err(dcmi->dev, "Graph parsing failed\n");
+		dev_err(dcmi->dev, "Failed to parse graph\n");
 		return ret;
 	}
 
@@ -1620,6 +1620,7 @@ static int dcmi_graph_init(struct stm32_dcmi *dcmi)
 	ret = v4l2_async_notifier_add_subdev(&dcmi->notifier,
 					     &dcmi->entity.asd);
 	if (ret) {
+		dev_err(dcmi->dev, "Failed to add subdev notifier\n");
 		of_node_put(dcmi->entity.node);
 		return ret;
 	}
@@ -1628,7 +1629,7 @@ static int dcmi_graph_init(struct stm32_dcmi *dcmi)
 
 	ret = v4l2_async_notifier_register(&dcmi->v4l2_dev, &dcmi->notifier);
 	if (ret < 0) {
-		dev_err(dcmi->dev, "Notifier registration failed\n");
+		dev_err(dcmi->dev, "Failed to register notifier\n");
 		v4l2_async_notifier_cleanup(&dcmi->notifier);
 		return ret;
 	}
-- 
2.7.4

