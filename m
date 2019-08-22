Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8469C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 05:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C33233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 05:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d+XGRDvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbfHVF6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 01:58:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46473 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731525AbfHVF6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 01:58:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id q139so3137852pfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 22:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kn51c4iVY6vEKLBAUEgNeUWaRLfBi8NFzSwtDO3qJPo=;
        b=d+XGRDvs6km5uuLibtMj+3KC3ZkxqZYWOsU2LWeCn9xko3LMBY/ZiIalGDExdpPNkv
         2hL3j0jv/IRmHQ2CmCsOqXHykpFCzIX2ZmXO2/s20zJg9nYkd2fXr37b9m5qc4mNgd4k
         KQ6QB3GyCnueCJccC3fjLqL+gRTgY6o1l4ZZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kn51c4iVY6vEKLBAUEgNeUWaRLfBi8NFzSwtDO3qJPo=;
        b=QTKK/ZEnqXxlKoP+xVz4xcz6y211yxzmaHLnMXpZ7Ck+QYGe3Ddd78Z2SH+hF1L54e
         xITa0J4P/UtQChph0DMquEn4SB6uNOPhxpgXhcBuf66fSpz94BXNxgWafRsW++FOatS9
         pWUiAeeApa+ck5a8WHOB1s2/W+9f3zsEqMDzIhb7/fTh7UTahEljZB1KLcN3AbXq1aUE
         Hu0Cstr/gsDlBfi0Fqhbg34Uw8XnSzRP7ppAxoLsO580M7n3B6UE5QCY7+Rh1hRXV8cB
         k3H40Tk0l1Pf1yBg8yQNpYudEwGlswD/mckkYNSfKGotuvoBR84X853o/6Til0xjUylt
         o5hA==
X-Gm-Message-State: APjAAAUHelygPfQJnH9KBJdCMvgRNowEkY0Z19O+3v6KRxaJ99k1O3OF
        kvVVcaQWcCRwQxlg3mT5+IHi2w==
X-Google-Smtp-Source: APXvYqzL8tM2JbDNSwlC6qNUOLwrEHhxUu03EMAJx/fBuHRv6q5B+0v8WjvhppnsEoQ2SVVVq/TgTQ==
X-Received: by 2002:a62:cec4:: with SMTP id y187mr39225066pfg.84.1566453480758;
        Wed, 21 Aug 2019 22:58:00 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id e6sm24867338pfn.71.2019.08.21.22.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Aug 2019 22:58:00 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Qii Wang <qii.wang@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jun Gao <jun.gao@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandru M Stan <amstan@chromium.org>
Subject: [PATCH RESEND] i2c: mediatek: disable zero-length transfers for mt8183
Date:   Thu, 22 Aug 2019 13:57:37 +0800
Message-Id: <20190822055737.142384-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing i2cdetect quick write mode, we would get transfer
error ENOMEM, and i2cdetect shows there's no device at the address.
Quoting from mt8183 datasheet, the number of transfers to be
transferred in one transaction should be set to bigger than 1,
so we should forbid zero-length transfer and update functionality.

Incorrect return:
localhost ~ # i2cdetect -q -y 0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

After this patch:
localhost ~ #  i2cdetect -q -y 0
Error: Can't use SMBus Quick Write command on this bus

localhost ~ #  i2cdetect -y 0
Warning: Can't use SMBus Quick Write command, will skip some addresses
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:
10:
20:
30: -- -- -- -- -- -- -- --
40:
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60:
70:

Reported-by: Alexandru M Stan <amstan@chromium.org>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
Previous patch and discussion:
http://patchwork.ozlabs.org/patch/1042684/
---
 drivers/i2c/busses/i2c-mt65xx.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 252edb433fdf..2842ca4b8c3b 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -234,6 +234,10 @@ static const struct i2c_adapter_quirks mt7622_i2c_quirks = {
 	.max_num_msgs = 255,
 };
 
+static const struct i2c_adapter_quirks mt8183_i2c_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
+};
+
 static const struct mtk_i2c_compatible mt2712_compat = {
 	.regs = mt_i2c_regs_v1,
 	.pmic_i2c = 0,
@@ -298,6 +302,7 @@ static const struct mtk_i2c_compatible mt8173_compat = {
 };
 
 static const struct mtk_i2c_compatible mt8183_compat = {
+	.quirks = &mt8183_i2c_quirks,
 	.regs = mt_i2c_regs_v2,
 	.pmic_i2c = 0,
 	.dcm = 0,
@@ -870,7 +875,11 @@ static irqreturn_t mtk_i2c_irq(int irqno, void *dev_id)
 
 static u32 mtk_i2c_functionality(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+	if (adap->quirks->flags & I2C_AQ_NO_ZERO_LEN)
+		return I2C_FUNC_I2C |
+			(I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
+	else
+		return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
 static const struct i2c_algorithm mtk_i2c_algorithm = {
@@ -933,8 +942,8 @@ static int mtk_i2c_probe(struct platform_device *pdev)
 	i2c->dev = &pdev->dev;
 	i2c->adap.dev.parent = &pdev->dev;
 	i2c->adap.owner = THIS_MODULE;
-	i2c->adap.algo = &mtk_i2c_algorithm;
 	i2c->adap.quirks = i2c->dev_comp->quirks;
+	i2c->adap.algo = &mtk_i2c_algorithm;
 	i2c->adap.timeout = 2 * HZ;
 	i2c->adap.retries = 1;
 
-- 
2.20.1

