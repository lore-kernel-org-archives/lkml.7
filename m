Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6A1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84CC21902
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="c2xayF8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfDXODo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:03:44 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44408 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726830AbfDXODn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:03:43 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3ODvPjQ007033;
        Wed, 24 Apr 2019 16:03:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=qXf9zSeCvuTI38sMjpBYmuv1URETMTuq+Zbz/Qww5nE=;
 b=c2xayF8c+om7kgzyMRCCIlh80x9z8usXGimjzq4k/8awR7J2OkfNDFc93tihxAQaG0UT
 BlUMy0i/0APy3yR3Pyj6xtSKREMr68XfWxOKP5IIXLzhXYecfSDvOLtRSwC31PbSoziU
 CcvJ5mk8a2raYo2HPiUNlj9VY2OSLZQPiGfuHo+tHwjyVVBzc82+UZiFgJ0yMevBfwrw
 8G6De1E6nTB5v/6LT+rAUw0rtp386m39XpMQvBF52yCt7dGP8pO0VV8E7FwIx/zg6MhL
 Y8cqF7kAtuVOfh/s5rUv4YuwtbSsGniBQ/lSwVxe5BNJMV0Jo12gKwEcaGN0PqxhTQcH FA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rytad6yy4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 16:03:30 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 464C334;
        Wed, 24 Apr 2019 14:03:30 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2B22F2726;
        Wed, 24 Apr 2019 14:03:30 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 24 Apr
 2019 16:03:29 +0200
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Apr 2019 16:03:29
 +0200
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>
Subject: [PATCH 1/2] drm/stm: ltdc: manage the get_irq probe defer case
Date:   Wed, 24 Apr 2019 16:03:20 +0200
Message-ID: <1556114601-30936-2-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556114601-30936-1-git-send-email-fabien.dessenne@st.com>
References: <1556114601-30936-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manage the -EPROBE_DEFER error case for the ltdc IRQ.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 566b0d8..521ba83 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -1174,6 +1174,9 @@ int ltdc_load(struct drm_device *ddev)
 
 	for (i = 0; i < MAX_IRQ; i++) {
 		irq = platform_get_irq(pdev, i);
+		if (irq == -EPROBE_DEFER)
+			goto err;
+
 		if (irq < 0)
 			continue;
 
-- 
2.7.4

