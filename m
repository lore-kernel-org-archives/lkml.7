Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D110C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AFA246AF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012204;
	bh=RY7/22cQdS0rro6ZXYKwL+zVZFVFfSfqinoLihuH4yI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e5bB/sAioiQxBZkHq8Y19vKQ8SQYRRCaetYSul7GOFW3juE+/7Ql4mibQFrdFGItf
	 OzhFR/BLwhrwdBDCcqOuZLEH3wvx78hPXZTJWlw9XjQ9zsCJbBsEbkooI0RbsE7QuE
	 lSk40vIUjgoney5VjL8D/wpfSAaOFoaXXE03Dw1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfLJVKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:10:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:58968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728307AbfLJVJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:09:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD4E3246AF;
        Tue, 10 Dec 2019 21:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012192;
        bh=RY7/22cQdS0rro6ZXYKwL+zVZFVFfSfqinoLihuH4yI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W19lcYS8Vr0O4/QJC5SOil5QqDrt1R+xNj27gZgF6ipfOxpF9rSeqXhQoKScw1YuJ
         jY5EAOOtv4PnbRoiy3cufZbz0C3+sotlGUy3+U/I6EnQ6rbDm9CwPE6WafmNVDeGRR
         U8BQpGPOlyFPQc89maZJP8zJC2n7fCAGfIClcICA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 147/350] media: ov6650: Fix stored frame interval not in sync with hardware
Date:   Tue, 10 Dec 2019 16:04:12 -0500
Message-Id: <20191210210735.9077-108-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Janusz Krzysztofik <jmkrzyszt@gmail.com>

[ Upstream commit 57822068dd120386b98891cb151dc20107b63ba7 ]

The driver stores a frame interval value supposed to be in line with
hardware state in a device private structure.  Since the driver initial
submission, the respective field of the structure has never been
initialised on device probe.  Moreover, if updated from
.s_frame_interval(), a new value is stored before it is applied on
hardware.  If an error occurs during device update, the stored value
may no longer reflect hardware state and consecutive calls to
.g_frame_interval() may return incorrect information.

Assuming a failed update of the device means its actual state hasn't
changed, update the frame interval field of the device private
structure with a new value only after it is successfully applied on
hardware so it always reflects actual hardware state to the extent
possible.  Also, initialise the field with hardware default frame
interval on device probe.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov6650.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index 43c3f1b6e19ac..a5b2448c0abc2 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -130,6 +130,7 @@
 #define CLKRC_24MHz		0xc0
 #define CLKRC_DIV_MASK		0x3f
 #define GET_CLKRC_DIV(x)	(((x) & CLKRC_DIV_MASK) + 1)
+#define DEF_CLKRC		0x00
 
 #define COMA_RESET		BIT(7)
 #define COMA_QCIF		BIT(5)
@@ -758,19 +759,17 @@ static int ov6650_s_frame_interval(struct v4l2_subdev *sd,
 	else if (div > GET_CLKRC_DIV(CLKRC_DIV_MASK))
 		div = GET_CLKRC_DIV(CLKRC_DIV_MASK);
 
-	/*
-	 * Keep result to be used as tpf limit
-	 * for subsequent clock divider calculations
-	 */
-	priv->tpf.numerator = div;
-	priv->tpf.denominator = FRAME_RATE_MAX;
+	tpf->numerator = div;
+	tpf->denominator = FRAME_RATE_MAX;
 
-	clkrc = to_clkrc(&priv->tpf, priv->pclk_limit, priv->pclk_max);
+	clkrc = to_clkrc(tpf, priv->pclk_limit, priv->pclk_max);
 
 	ret = ov6650_reg_rmw(client, REG_CLKRC, clkrc, CLKRC_DIV_MASK);
 	if (!ret) {
-		tpf->numerator = GET_CLKRC_DIV(clkrc);
-		tpf->denominator = FRAME_RATE_MAX;
+		priv->tpf.numerator = GET_CLKRC_DIV(clkrc);
+		priv->tpf.denominator = FRAME_RATE_MAX;
+
+		*tpf = priv->tpf;
 	}
 
 	return ret;
@@ -1011,6 +1010,10 @@ static int ov6650_probe(struct i2c_client *client,
 	priv->code	  = MEDIA_BUS_FMT_YUYV8_2X8;
 	priv->colorspace  = V4L2_COLORSPACE_JPEG;
 
+	/* Hardware default frame interval */
+	priv->tpf.numerator   = GET_CLKRC_DIV(DEF_CLKRC);
+	priv->tpf.denominator = FRAME_RATE_MAX;
+
 	priv->subdev.internal_ops = &ov6650_internal_ops;
 
 	ret = v4l2_async_register_subdev(&priv->subdev);
-- 
2.20.1

