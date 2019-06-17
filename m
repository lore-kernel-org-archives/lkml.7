Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8F6C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52BB218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="djNFXoDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfFQHSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 03:18:36 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:38687 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725826AbfFQHSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 03:18:35 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5H7G0ZS016840;
        Mon, 17 Jun 2019 09:18:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=Ia2/UrCUbgT3bw0BUTt336OAmpb+nVhfRSlDq35fcEs=;
 b=djNFXoDB4cGYOdCBR/WaJaQgc3IkLbr6gG3WsKXYywl2EAUpnCglQjTOgMM3NgTdcALz
 RnyxPh/XODS35rQRIAjo1GYk5FJto0TGQ53PiJItJY2wRMFfvAZMdCihDAVFxzhTwpII
 sQ0yUGmVo4AX4apALbfQbpXmJ0vzkqNRS4KYccRtdBEP6MJaCHobWu9Lla2hxtkktYDZ
 CHvFLsHbYqO/4n6bO6cD1IRs51HsaYrmZdKvYANqCjepEBGKuDPgSR9CvfoUbw7G7k97
 RC5yVFldo0CzjKjNEBoaNniM2SmKQ7oJM50d/KITK4TyI5x9OY5n9bngEEOhonkb1mDL rw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t4peu0wyj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 17 Jun 2019 09:18:22 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0C73034;
        Mon, 17 Jun 2019 07:18:20 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A7417155B;
        Mon, 17 Jun 2019 07:18:20 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 17 Jun
 2019 09:18:20 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 17 Jun 2019 09:18:20
 +0200
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] drm/stm: drv: fix suspend/resume
Date:   Mon, 17 Jun 2019 09:18:17 +0200
Message-ID: <1560755897-5002-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this fix, the system can not go in "suspend" mode
due to an error in drv_suspend function.

Fixes: 35ab6cf ("drm/stm: support runtime power management")

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/drv.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 5659572..9dee4e4 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -136,8 +136,7 @@ static __maybe_unused int drv_suspend(struct device *dev)
 	struct ltdc_device *ldev = ddev->dev_private;
 	struct drm_atomic_state *state;
 
-	if (WARN_ON(!ldev->suspend_state))
-		return -ENOENT;
+	WARN_ON(ldev->suspend_state);
 
 	state = drm_atomic_helper_suspend(ddev);
 	if (IS_ERR(state))
@@ -155,15 +154,17 @@ static __maybe_unused int drv_resume(struct device *dev)
 	struct ltdc_device *ldev = ddev->dev_private;
 	int ret;
 
+	if (WARN_ON(!ldev->suspend_state))
+		return -ENOENT;
+
 	pm_runtime_force_resume(dev);
 	ret = drm_atomic_helper_resume(ddev, ldev->suspend_state);
-	if (ret) {
+	if (ret)
 		pm_runtime_force_suspend(dev);
-		ldev->suspend_state = NULL;
-		return ret;
-	}
 
-	return 0;
+	ldev->suspend_state = NULL;
+
+	return ret;
 }
 
 static __maybe_unused int drv_runtime_suspend(struct device *dev)
-- 
2.7.4

