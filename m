Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EDFC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909EE20830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="YPn34W6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfEFMpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:45:07 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60216 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726037AbfEFMpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:45:07 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x46CaeeK004677;
        Mon, 6 May 2019 14:44:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=ePramUuugRjelkjbhu7MX3ckPvU758bFiYwYbfLUL6o=;
 b=YPn34W6aCQcpXFdfWgM++nsc9OYFu5Fe+WDkUy00ha31Mj/pIUCN8pmhxSRRTV+80Wsn
 DPF5hkKxPWysJDXyxXbWaoakFAMni6vXOXsNtxX2hnF05N1jUj1FQ7nVzHQhU2cafc/2
 pQHqcf2DBJ4/stq93ESDTnFWxXWqYaDwJYIFP12d9qDLbk4lJquhz+d4BthHh6+ToPok
 IeK42KdNvlUIHDplcwc6BBhkhXA8w8mqWPN1y+YF0BUSemwvOHqJGsYi8o8P5Gd2Vq6I
 2facXitW4GVi3YEARnxAiyyDxHz+EbwqgA2mwGzW2ocTRpnlx7milZhuC7cbGfldwO3w /w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2s94c39ey7-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 06 May 2019 14:44:15 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8AE6D34;
        Mon,  6 May 2019 12:44:14 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 501E02583;
        Mon,  6 May 2019 12:44:14 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 6 May 2019
 14:44:14 +0200
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 6 May 2019 14:44:13
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>,
        <arnaud.pouliquen@st.com>
CC:     <benjamin.gaignard@st.com>
Subject: [PATCH 3/3] ASoC: stm32: spdifrx: manage identification registers
Date:   Mon, 6 May 2019 14:44:06 +0200
Message-ID: <1557146646-18150-4-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557146646-18150-1-git-send-email-olivier.moysan@st.com>
References: <1557146646-18150-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-06_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of identification registers in STM32 SPDIFRX.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_spdifrx.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index 3d64200edbb5..4a3fad4a711f 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -16,6 +16,7 @@
  * details.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
@@ -36,6 +37,9 @@
 #define STM32_SPDIFRX_DR	0x10
 #define STM32_SPDIFRX_CSR	0x14
 #define STM32_SPDIFRX_DIR	0x18
+#define STM32_SPDIFRX_VERR	0x3F4
+#define STM32_SPDIFRX_IDR	0x3F8
+#define STM32_SPDIFRX_SIDR	0x3FC
 
 /* Bit definition for SPDIF_CR register */
 #define SPDIFRX_CR_SPDIFEN_SHIFT	0
@@ -169,6 +173,18 @@
 #define SPDIFRX_SPDIFEN_SYNC	0x1
 #define SPDIFRX_SPDIFEN_ENABLE	0x3
 
+/* Bit definition for SPDIFRX_VERR register */
+#define SPDIFRX_VERR_MIN_MASK	GENMASK(3, 0)
+#define SPDIFRX_VERR_MAJ_MASK	GENMASK(7, 4)
+
+/* Bit definition for SPDIFRX_IDR register */
+#define SPDIFRX_IDR_ID_MASK	GENMASK(31, 0)
+
+/* Bit definition for SPDIFRX_SIDR register */
+#define SPDIFRX_SIDR_SID_MASK	GENMASK(31, 0)
+
+#define SPDIFRX_IPIDR_NUMBER	0x00130041
+
 #define SPDIFRX_IN1		0x1
 #define SPDIFRX_IN2		0x2
 #define SPDIFRX_IN3		0x3
@@ -607,6 +623,9 @@ static bool stm32_spdifrx_readable_reg(struct device *dev, unsigned int reg)
 	case STM32_SPDIFRX_DR:
 	case STM32_SPDIFRX_CSR:
 	case STM32_SPDIFRX_DIR:
+	case STM32_SPDIFRX_VERR:
+	case STM32_SPDIFRX_IDR:
+	case STM32_SPDIFRX_SIDR:
 		return true;
 	default:
 		return false;
@@ -642,10 +661,11 @@ static const struct regmap_config stm32_h7_spdifrx_regmap_conf = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.max_register = STM32_SPDIFRX_DIR,
+	.max_register = STM32_SPDIFRX_SIDR,
 	.readable_reg = stm32_spdifrx_readable_reg,
 	.volatile_reg = stm32_spdifrx_volatile_reg,
 	.writeable_reg = stm32_spdifrx_writeable_reg,
+	.num_reg_defaults_raw = STM32_SPDIFRX_SIDR / sizeof(u32) + 1,
 	.fast_io = true,
 	.cache_type = REGCACHE_FLAT,
 };
@@ -912,6 +932,7 @@ static int stm32_spdifrx_probe(struct platform_device *pdev)
 	struct stm32_spdifrx_data *spdifrx;
 	struct reset_control *rst;
 	const struct snd_dmaengine_pcm_config *pcm_config = NULL;
+	u32 ver, idr;
 	int ret;
 
 	spdifrx = devm_kzalloc(&pdev->dev, sizeof(*spdifrx), GFP_KERNEL);
@@ -968,7 +989,19 @@ static int stm32_spdifrx_probe(struct platform_device *pdev)
 		goto error;
 	}
 
-	return 0;
+	ret = regmap_read(spdifrx->regmap, STM32_SPDIFRX_IDR, &idr);
+	if (ret)
+		goto error;
+
+	if (idr == SPDIFRX_IPIDR_NUMBER) {
+		ret = regmap_read(spdifrx->regmap, STM32_SPDIFRX_VERR, &ver);
+
+		dev_dbg(&pdev->dev, "SPDIFRX version: %lu.%lu registered\n",
+			FIELD_GET(SPDIFRX_VERR_MAJ_MASK, ver),
+			FIELD_GET(SPDIFRX_VERR_MIN_MASK, ver));
+	}
+
+	return ret;
 
 error:
 	if (!IS_ERR(spdifrx->ctrl_chan))
-- 
2.7.4

