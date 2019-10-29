Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66470CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B8B21924
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RG/aWfaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732887AbfJ2Lnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:43:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40377 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732175AbfJ2Lnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:43:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so2031499wmm.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 04:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m5BWL4uLZfII39sBFsMSEuxt9lkItf+Jxy+LDkHo3cc=;
        b=RG/aWfaAz2nKNwtWIv7eNOgsTfOzsRHLmOyeyQc8g5Ao9rRqngpHEDDkSrgfeV5Ax0
         B+gOddG1M8KlDlu0/NPx5RCnL82uqTAGUCHUSJ2wcMkI0vHezAagnR+PTlzKX6Jtfw5h
         a1Zk9WxjTEBhdMWVJtJ8HVkJrXre5/bYDCxPeoEkWr47DtAwDWT4lCJQbTTev1uJAs7r
         XgBjvTBWyPbuFFD2H1lkQSVwdU1/jYuVEm+Fg+FNt6Gs69elT5KqXbftG/A1gslo7saf
         kk17e+6TnZ4mJcmT71tePngz9PY9kQWKbNgGZBnRcTn6VKbPUS2CsRhxqxRCfugoFgyT
         D+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m5BWL4uLZfII39sBFsMSEuxt9lkItf+Jxy+LDkHo3cc=;
        b=P9bHASRdW1quPa+qQSCf/EDGKtxs3irsmuonRqo0/LmtGfJ9rPkl4Z/64cCObh5Kb5
         lzEjU2gTbqXLqtpVqx78S74kJPDl1/re31Qeh32Ntef/9VhDf3ndzWuH4v0+Ox3iud/e
         2DZwdCh2/WvGspESq4R0hnWV13XLo4+BUQakliTBWFvxOZ4lObhGhUmn1i0w4tNfmWAt
         hyJvNh81ghav8hjA/qNn9uVstxLdmJ404Iw78KziItH89JqoQdSceFX9rLFGJodMiqeT
         Hyj/BgZYkWNIARAbWiw8Clv2td3liJ7Mq8CnVrgWKsht49dFFh5QyFxCBUSeLWYebEnX
         VN0g==
X-Gm-Message-State: APjAAAUE11rZRf9WqXllUIyIFUqnE2faXeamsNrP/xs0bTacfLR9fkoh
        k7xQcpQ7kphGALzsfjCTc2t5FbDBWuc=
X-Google-Smtp-Source: APXvYqwZoY3rjF/0AfGaWYl6/rpGT3Z5fc24u5shJGeWD50tNSAJRYCTsRM1VbO3ejXh+mvo+LiuDw==
X-Received: by 2002:a7b:c011:: with SMTP id c17mr3765294wmb.95.1572349416437;
        Tue, 29 Oct 2019 04:43:36 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q25sm26559864wra.3.2019.10.29.04.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 04:43:35 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/10] nvmem: imx: scu: support write
Date:   Tue, 29 Oct 2019 11:42:34 +0000
Message-Id: <20191029114240.14905-5-srinivas.kandagatla@linaro.org>
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

The fuse programming from non-secure world is blocked, so we could
only use Arm Trusted Firmware SIP call to let ATF program fuse.

Because there is ECC region that could only be programmed once,
so add a heler in_ecc to check the ecc region.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp-scu.c | 73 ++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
index 030e27ba4dfb..03f1ab23ad51 100644
--- a/drivers/nvmem/imx-ocotp-scu.c
+++ b/drivers/nvmem/imx-ocotp-scu.c
@@ -7,6 +7,7 @@
  * Peng Fan <peng.fan@nxp.com>
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/firmware/imx/sci.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
@@ -14,6 +15,9 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#define IMX_SIP_OTP			0xC200000A
+#define IMX_SIP_OTP_WRITE		0x2
+
 enum ocotp_devtype {
 	IMX8QXP,
 	IMX8QM,
@@ -46,6 +50,8 @@ struct imx_sc_msg_misc_fuse_read {
 	u32 word;
 } __packed;
 
+static DEFINE_MUTEX(scu_ocotp_mutex);
+
 static struct ocotp_devtype_data imx8qxp_data = {
 	.devtype = IMX8QXP,
 	.nregs = 800,
@@ -84,6 +90,23 @@ static bool in_hole(void *context, u32 index)
 	return false;
 }
 
+static bool in_ecc(void *context, u32 index)
+{
+	struct ocotp_priv *priv = context;
+	const struct ocotp_devtype_data *data = priv->data;
+	int i;
+
+	for (i = 0; i < data->num_region; i++) {
+		if (data->region[i].flag & ECC_REGION) {
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
@@ -127,6 +150,8 @@ static int imx_scu_ocotp_read(void *context, unsigned int offset,
 	if (!p)
 		return -ENOMEM;
 
+	mutex_lock(&scu_ocotp_mutex);
+
 	buf = p;
 
 	for (i = index; i < (index + count); i++) {
@@ -137,6 +162,7 @@ static int imx_scu_ocotp_read(void *context, unsigned int offset,
 
 		ret = imx_sc_misc_otp_fuse_read(priv->nvmem_ipc, i, buf);
 		if (ret) {
+			mutex_unlock(&scu_ocotp_mutex);
 			kfree(p);
 			return ret;
 		}
@@ -145,18 +171,63 @@ static int imx_scu_ocotp_read(void *context, unsigned int offset,
 
 	memcpy(val, (u8 *)p + offset % 4, bytes);
 
+	mutex_unlock(&scu_ocotp_mutex);
+
 	kfree(p);
 
 	return 0;
 }
 
+static int imx_scu_ocotp_write(void *context, unsigned int offset,
+			       void *val, size_t bytes)
+{
+	struct ocotp_priv *priv = context;
+	struct arm_smccc_res res;
+	u32 *buf = val;
+	u32 tmp;
+	u32 index;
+	int ret;
+
+	/* allow only writing one complete OTP word at a time */
+	if ((bytes != 4) || (offset % 4))
+		return -EINVAL;
+
+	index = offset >> 2;
+
+	if (in_hole(context, index))
+		return -EINVAL;
+
+	if (in_ecc(context, index)) {
+		pr_warn("ECC region, only program once\n");
+		mutex_lock(&scu_ocotp_mutex);
+		ret = imx_sc_misc_otp_fuse_read(priv->nvmem_ipc, index, &tmp);
+		mutex_unlock(&scu_ocotp_mutex);
+		if (ret)
+			return ret;
+		if (tmp) {
+			pr_warn("ECC region, already has value: %x\n", tmp);
+			return -EIO;
+		}
+	}
+
+	mutex_lock(&scu_ocotp_mutex);
+
+	arm_smccc_smc(IMX_SIP_OTP, IMX_SIP_OTP_WRITE, index, *buf,
+		      0, 0, 0, 0, &res);
+
+	mutex_unlock(&scu_ocotp_mutex);
+
+	return res.a0;
+}
+
 static struct nvmem_config imx_scu_ocotp_nvmem_config = {
 	.name = "imx-scu-ocotp",
-	.read_only = true,
+	.read_only = false,
 	.word_size = 4,
 	.stride = 1,
 	.owner = THIS_MODULE,
 	.reg_read = imx_scu_ocotp_read,
+	.reg_write = imx_scu_ocotp_write,
 };
 
 static const struct of_device_id imx_scu_ocotp_dt_ids[] = {
-- 
2.21.0

