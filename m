Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052F5C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D9B20811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="iU1/aiQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbfDXM1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:27:14 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51044 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726880AbfDXM1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:27:13 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OC6eQN024358;
        Wed, 24 Apr 2019 14:26:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=h9D+RmnNCvP7dwWVcYtp3MBpjBes7RInZNX3mwfwoo8=;
 b=iU1/aiQTc/ikYT7DchSugv7ll+UijXK1m05lk2SWXlxczUnjSsO5OZHgbN+hMNQ33eo/
 vtRzQhZoe39oWMBznj5tCPI4EEPrZfsAWHSjD5VAwZ5+JyVsQAEfVHLI6WmlsAoZ+Ww8
 kiLXyV5RnscLnOuzG0W77Nf6rv802g+yOAHBc9vTekTFw1Fx559yGIXCH8kIw/MM+BKM
 axoEJukU4PK7+MutFY6XpGCYmdl4+eAmsqq839gcOlsZiVXb+xdbNFfC+nV6gR8UT2Gm
 ZoRjldpibfpqt15lNZCTvrQUEASZg/5UrKEbliVEGIl4Gk53wJN8rjYTS8xW8Uq5d5oR 7g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rytad6fg8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 14:26:56 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1492D31;
        Wed, 24 Apr 2019 12:26:55 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DA84C254E;
        Wed, 24 Apr 2019 12:26:54 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Apr
 2019 14:26:54 +0200
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Apr 2019 14:26:54
 +0200
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        <linux-rtc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>
Subject: [PATCH] rtc: stm32: manage the get_irq probe defer case
Date:   Wed, 24 Apr 2019 14:26:48 +0200
Message-ID: <1556108808-32722-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manage the -EPROBE_DEFER error case for the wake IRQ.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/rtc/rtc-stm32.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index c5908cf..8e6c9b3 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -788,11 +788,14 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 	ret = device_init_wakeup(&pdev->dev, true);
 	if (rtc->data->has_wakeirq) {
 		rtc->wakeirq_alarm = platform_get_irq(pdev, 1);
-		if (rtc->wakeirq_alarm <= 0)
-			ret = rtc->wakeirq_alarm;
-		else
+		if (rtc->wakeirq_alarm > 0) {
 			ret = dev_pm_set_dedicated_wake_irq(&pdev->dev,
 							    rtc->wakeirq_alarm);
+		} else {
+			ret = rtc->wakeirq_alarm;
+			if (rtc->wakeirq_alarm == -EPROBE_DEFER)
+				goto err;
+		}
 	}
 	if (ret)
 		dev_warn(&pdev->dev, "alarm can't wake up the system: %d", ret);
-- 
2.7.4

