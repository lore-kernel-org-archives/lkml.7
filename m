Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653B1C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377392177B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="mcYefJHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfEJPDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:03:33 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:28986 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727545AbfEJPDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:03:33 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4AErvPO005029;
        Fri, 10 May 2019 17:03:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=JVoxbgxa8NXBZqIYaDfKlj5ecVvDm4yDrgscf7mPaSA=;
 b=mcYefJHbsTucP8ibCTTp45khN/3G5jE9jIn5cX/yU+Qh/nm5pf7hDl7S4MuJSxDTBS/V
 Kgdm40nE+3q+Wtf6FgJMHqH2w0kYPTWC7ZU0Tx30AMBYxKypAqE7sdvXF4vxOfHSPIR9
 w+3LRDCblFiocJZZHuFJjUmVPk9ZNMrF05HB0NOb7VdpUxc/fW3BtCfsz+k6UXb+s8IY
 zjPOLQLUeFy2Ie8Akr5wACqvdVs125QYNbKAMa/jDERqfwChKAqUQGG0kdW2l6MjU7Pr
 feEpTJo94+ejVm4jsYzFTAgOUf+f7Y2GmmEyylBe8Pj8keSqcuCiIBkf5iYKkK+QJGe7 Og== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sc9s4k4b1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 10 May 2019 17:03:23 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CAF1634;
        Fri, 10 May 2019 15:03:22 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AF54E2AB9;
        Fri, 10 May 2019 15:03:22 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 10 May
 2019 17:03:22 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 10 May 2019 17:03:21
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
Subject: [PATCH] drm/stm: ltdc: remove clk_round_rate comment
Date:   Fri, 10 May 2019 17:03:20 +0200
Message-ID: <1557500600-19771-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clk_round_rate returns rounded clock without changing
the hardware in any way.
This function couldn't replace set_rate/get_rate calls.
Todo comment has been removed & a new log inserted.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 97912e2..2f8aa2e 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -507,20 +507,16 @@ static bool ltdc_crtc_mode_fixup(struct drm_crtc *crtc,
 	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
 	int rate = mode->clock * 1000;
 
-	/*
-	 * TODO clk_round_rate() does not work yet. When ready, it can
-	 * be used instead of clk_set_rate() then clk_get_rate().
-	 */
-
-	clk_disable(ldev->pixel_clk);
 	if (clk_set_rate(ldev->pixel_clk, rate) < 0) {
 		DRM_ERROR("Cannot set rate (%dHz) for pixel clk\n", rate);
 		return false;
 	}
-	clk_enable(ldev->pixel_clk);
 
 	adjusted_mode->clock = clk_get_rate(ldev->pixel_clk) / 1000;
 
+	DRM_DEBUG_DRIVER("requested clock %dkHz, adjusted clock %dkHz\n",
+			 mode->clock, adjusted_mode->clock);
+
 	return true;
 }
 
-- 
2.7.4

