Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F771CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FECB21924
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e6u70EtU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbfJ2Lni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:43:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51098 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732186AbfJ2Lnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:43:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id 11so2230504wmk.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 04:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BV9LuV+mEUNPyp8KDYlq7uwIWu6H/ILCOoWhmeflRas=;
        b=e6u70EtU3vtcsFAGBCYUyhSMUHxapYcdd6VLpCgmt7Z9eJD9ov8o8bqwk7uWi72J8h
         Hjw7IlYEMhkOv0sfh5aQzF7Uji1TJUIauV7gcBPaVlI0fUJhIiJwvE7RDSTQ8THRCDFt
         dcHHxKMmuZZHaQ73sZRTrgNelpM7lpfd0+JB0fHFznfULYEXcnlBYNApVJERAa/f7BGl
         nPFskfi71zTvj4UxTrzq0Bakz1EYKOUM1qKBZ6Fzsh1cp7er0kO8Hy5vawVMWqOzhtfG
         AKCxPaiGXe3X2CUlYoaBVHldA9oi/bdChMZobfUCSqkoobMHMwsNIYIlQTByb2kahql0
         vi7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BV9LuV+mEUNPyp8KDYlq7uwIWu6H/ILCOoWhmeflRas=;
        b=Gu8ybPgUAn83MFyQINV8fzKBwKu7iARqxlZjeYRa6BUTamU+zvf9HLiDJpxQbznJOW
         HP35kQwo0jyZFRjH16A5C8inxY39PV341GS2E2SsRPI8mf3nO/9JWSeVB4Mn0rrUdDxv
         u7ehS1cZhFzo1fI5b7tiJyTBP/C3jEa8391kSTYErzrE1XOJ2ZWisN5TvY2highuPCsl
         hnB25d3mfXeUV60UzGbBoT0gVVWJur1kXIMpyXKgFvz493YOp1cuDHm+1f1XNeOfzB9f
         Ai7KFmQU+YVfVNvv4kTkDXmKFJGzLwfXGhLs07RP14mmioHVRFZmOJipe8sB9djQnCIv
         D1KA==
X-Gm-Message-State: APjAAAVbUCUPcuzBh2ATwZOiALfKthuj/HCSxwYmCOfGV5sKVTUJHyvu
        1Awgl4kNhQJ3xzUsbo3jOpiG1Q==
X-Google-Smtp-Source: APXvYqxrrjqgDQBZbqcerfe/OHtw4xZ6XvSF/FHbqhiF+kCypy8sR9iC8mWk/NjYtXhvktZLG/wblw==
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr3776169wmb.125.1572349415217;
        Tue, 29 Oct 2019 04:43:35 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q25sm26559864wra.3.2019.10.29.04.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 04:43:34 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 03/10] nvmem: imx: scu: support hole region check
Date:   Tue, 29 Oct 2019 11:42:33 +0000
Message-Id: <20191029114240.14905-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029114240.14905-1-srinivas.kandagatla@linaro.org>
References: <20191029114240.14905-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Introduce HOLE/ECC_REGION flag and in_hole helper to ease the check
of hole region. The ECC_REGION is also introduced here which is
preparing for programming support. ECC_REGION could only be programmed
once, so need take care.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp-scu.c | 47 +++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
index 61a17f943f47..030e27ba4dfb 100644
--- a/drivers/nvmem/imx-ocotp-scu.c
+++ b/drivers/nvmem/imx-ocotp-scu.c
@@ -19,9 +19,20 @@ enum ocotp_devtype {
 	IMX8QM,
 };
 
+#define ECC_REGION	BIT(0)
+#define HOLE_REGION	BIT(1)
+
+struct ocotp_region {
+	u32 start;
+	u32 end;
+	u32 flag;
+};
+
 struct ocotp_devtype_data {
 	int devtype;
 	int nregs;
+	u32 num_region;
+	struct ocotp_region region[];
 };
 
 struct ocotp_priv {
@@ -38,13 +49,41 @@ struct imx_sc_msg_misc_fuse_read {
 static struct ocotp_devtype_data imx8qxp_data = {
 	.devtype = IMX8QXP,
 	.nregs = 800,
+	.num_region = 3,
+	.region = {
+		{0x10, 0x10f, ECC_REGION},
+		{0x110, 0x21F, HOLE_REGION},
+		{0x220, 0x31F, ECC_REGION},
+	},
 };
 
 static struct ocotp_devtype_data imx8qm_data = {
 	.devtype = IMX8QM,
 	.nregs = 800,
+	.num_region = 2,
+	.region = {
+		{0x10, 0x10f, ECC_REGION},
+		{0x1a0, 0x1ff, ECC_REGION},
+	},
 };
 
+static bool in_hole(void *context, u32 index)
+{
+	struct ocotp_priv *priv = context;
+	const struct ocotp_devtype_data *data = priv->data;
+	int i;
+
+	for (i = 0; i < data->num_region; i++) {
+		if (data->region[i].flag & HOLE_REGION) {
+			if ((index >= data->region[i].start) &&
+			    (index <= data->region[i].end))
+				return true;
+		}
+	}
+
+	return false;
+}
+
 static int imx_sc_misc_otp_fuse_read(struct imx_sc_ipc *ipc, u32 word,
 				     u32 *val)
 {
@@ -91,11 +130,9 @@ static int imx_scu_ocotp_read(void *context, unsigned int offset,
 	buf = p;
 
 	for (i = index; i < (index + count); i++) {
-		if (priv->data->devtype == IMX8QXP) {
-			if ((i > 271) && (i < 544)) {
-				*buf++ = 0;
-				continue;
-			}
+		if (in_hole(context, i)) {
+			*buf++ = 0;
+			continue;
 		}
 
 		ret = imx_sc_misc_otp_fuse_read(priv->nvmem_ipc, i, buf);
-- 
2.21.0

