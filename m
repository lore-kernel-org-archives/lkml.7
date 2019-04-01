Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943C2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B59A218FF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbfDAIzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:55:21 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51131 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728196AbfDAIzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:55:20 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x318k8Fr005388;
        Mon, 1 Apr 2019 10:55:13 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rjee26xfy-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 01 Apr 2019 10:55:13 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6F8093D;
        Mon,  1 Apr 2019 08:55:12 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 34C791662;
        Mon,  1 Apr 2019 08:55:12 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 1 Apr 2019
 10:55:12 +0200
Received: from localhost (10.201.23.19) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.435.0; Mon, 1 Apr 2019 10:55:10
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
Subject: [PATCH 2/2] media: stm32-dcmi: do not emit error trace in case of few overrun
Date:   Mon, 1 Apr 2019 10:55:00 +0200
Message-ID: <1554108900-30705-3-git-send-email-hugues.fruchet@st.com>
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

Report overrun error only when it exceeds a given threshold.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index 693415c..b63d57c 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -97,6 +97,8 @@ enum state {
 
 #define TIMEOUT_MS	1000
 
+#define OVERRUN_ERROR_THRESHOLD	3
+
 struct dcmi_graph_entity {
 	struct device_node *node;
 
@@ -446,11 +448,13 @@ static irqreturn_t dcmi_irq_thread(int irq, void *arg)
 
 	spin_lock_irq(&dcmi->irqlock);
 
-	if ((dcmi->misr & IT_OVR) || (dcmi->misr & IT_ERR)) {
-		dcmi->errors_count++;
-		if (dcmi->misr & IT_OVR)
-			dcmi->overrun_count++;
+	if (dcmi->misr & IT_OVR) {
+		dcmi->overrun_count++;
+		if (dcmi->overrun_count > OVERRUN_ERROR_THRESHOLD)
+			dcmi->errors_count++;
 	}
+	if (dcmi->misr & IT_ERR)
+		dcmi->errors_count++;
 
 	if (dcmi->sd_format->fourcc == V4L2_PIX_FMT_JPEG &&
 	    dcmi->misr & IT_FRAME) {
-- 
2.7.4

