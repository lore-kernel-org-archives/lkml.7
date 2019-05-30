Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37C9C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D93425F1D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559192164;
	bh=Yr1NWBa2ygGEK+iU7YFpXLjJuhvl7ZvsAVvfPbvqE5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fBgogKNpK96r4DaEUDtXYwE5HE0BPepsRqRSre3KvFFlaGo+PkT2tTwbp8pfNR+nE
	 n6YR8aKIF+azwJXGQoTOql3Jk90PbyCTirKLbREBgRH9F/y6SgMCFF6TSQtLDGs/x+
	 dIWYZRnq3nAZqvCQCM8SGNFX6YL6pDpfiSqS/k8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389056AbfE3E4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbfE3DKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:10:12 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A33A72449D;
        Thu, 30 May 2019 03:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185811;
        bh=Yr1NWBa2ygGEK+iU7YFpXLjJuhvl7ZvsAVvfPbvqE5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yoX+J0K5S7spT/ZIyAuc9xM2Yl2xsx1z0O84MyZOT0AYZJD/aT8bv+DCF6yHtrw6j
         YrWx2WUELODgw7Z3p9fBThJ5rybvkiivcxkMlI14/D/Nb+Vow4Znd6q2e35x3FxUwj
         ZXkS4/Xzj/UbsqaRBlS1TzKDE+Ar2tG+JWtOIIW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabien Dessenne <fabien.dessenne@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 101/405] rtc: stm32: manage the get_irq probe defer case
Date:   Wed, 29 May 2019 20:01:39 -0700
Message-Id: <20190530030546.132040989@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit cf612c5949aca2bd81a1e28688957c8149ea2693 ]

Manage the -EPROBE_DEFER error case for the wake IRQ.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Acked-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-stm32.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index c5908cfea2340..8e6c9b3bcc29a 100644
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
2.20.1



