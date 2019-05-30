Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC3DC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E882D251A5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189916;
	bh=5pDeNerl/1DxJPk5v26/hzMb2wiiuMRCLy2pj8wIa3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vyw7dQ2FvnGjTJifNH5a3hDzChD+1CigLI309jCGVJAF43yWQv2ann01duxfV2mmg
	 /mXd9YrJdu8kVq6LmMLuGEtCpQ8Iw7VKou26H625Q9wjCXp8CvRXAmALhE7jvImtT0
	 pOAyqcXzqyXuvc4pWooUX0tcXbvkVHvk9yCCa/og=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbfE3DPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:15:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728221AbfE3DMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:55 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A66C024528;
        Thu, 30 May 2019 03:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185974;
        bh=5pDeNerl/1DxJPk5v26/hzMb2wiiuMRCLy2pj8wIa3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eIBRR4qu4dKVC8RWfQRHyvqaAJ1Rx6LBef8Z+GxQc63h4kA10jBZrLLj+cPn1/Igd
         ZeDQQA4JGchG0p5VdWWElIhx5cmenW1mKOvenRFsXfzNTfIonl5sSl/xPo6gonssig
         KXJGil/41fLgVvOtf8Ovy69Fv7SWaoHC2zNk2P3c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 387/405] regulator: wm831x: Fix notifier mutex lock warning
Date:   Wed, 29 May 2019 20:06:25 -0700
Message-Id: <20190530030600.258027127@linuxfoundation.org>
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

[ Upstream commit 119c4f5085c45b60cb23c5595e45d06135b89518 ]

The mutex for the regulator_dev must be controlled by the caller of
the regulator_notifier_call_chain(), as described in the comment
for that function.

Failure to mutex lock and unlock surrounding the notifier call results
in a kernel WARN_ON_ONCE() which will dump a backtrace for the
regulator_notifier_call_chain() when that function call is first made.
The mutex can be controlled using the regulator_lock/unlock() API.

Fixes: e4ee831f949a ("regulator: Add WM831x DC-DC buck convertor support")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/wm831x-dcdc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/regulator/wm831x-dcdc.c b/drivers/regulator/wm831x-dcdc.c
index 12b422373580c..d1873f94bca74 100644
--- a/drivers/regulator/wm831x-dcdc.c
+++ b/drivers/regulator/wm831x-dcdc.c
@@ -183,9 +183,11 @@ static irqreturn_t wm831x_dcdc_uv_irq(int irq, void *data)
 {
 	struct wm831x_dcdc *dcdc = data;
 
+	regulator_lock(dcdc->regulator);
 	regulator_notifier_call_chain(dcdc->regulator,
 				      REGULATOR_EVENT_UNDER_VOLTAGE,
 				      NULL);
+	regulator_unlock(dcdc->regulator);
 
 	return IRQ_HANDLED;
 }
@@ -194,9 +196,11 @@ static irqreturn_t wm831x_dcdc_oc_irq(int irq, void *data)
 {
 	struct wm831x_dcdc *dcdc = data;
 
+	regulator_lock(dcdc->regulator);
 	regulator_notifier_call_chain(dcdc->regulator,
 				      REGULATOR_EVENT_OVER_CURRENT,
 				      NULL);
+	regulator_unlock(dcdc->regulator);
 
 	return IRQ_HANDLED;
 }
-- 
2.20.1



