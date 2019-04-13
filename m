Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB609C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712E52082E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kdl1SMFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfDMKdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 06:33:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39224 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfDMKdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 06:33:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id j9so15130702wrn.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 03:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ha/EwT9JIQJ8acUTtqE5mB27okMdtBeOqTiWB8z6ahU=;
        b=kdl1SMFYKVzRFDhoZyx9G2BqRlRt6ezTS1kO5zgFoNRukLeaRNX6x2E6w+fW9GLJnc
         WCDrg0aPR3zqo89okobQc1HijhB69sVPiZ8PDIBWshPgjL2HJzPG835Tg2I9V4PXL+yZ
         fov5VtjY2ScWC37vkzVdbipsiKDCDO5n2MQfSevlNHt8YAG4jqWbJ5dZqbIzIl1uzYMU
         wUE4kMUWfZScuJFU//EaWx7HcXYl5fqevJGJcVbbUgObhKaFE+qal3M2s1d4zjO0Bm5C
         rEFqNsH92MkYzK5O7Y4TwbktZ2zwoTJew2EzhdJppS5w1RVgjcyN9MHGvVE3FoKgV/0b
         1Ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ha/EwT9JIQJ8acUTtqE5mB27okMdtBeOqTiWB8z6ahU=;
        b=mFzTaF1JdGu4n65GhmBQaLSizo0xcK+v5gseVp3gGLdQOy793X0W44ebDJSxUoJtHN
         4V5iXp154cDjNTTiGc2SRejPQLGLew3YooTJAYsFTI5UkEgGkIKmbiPwSii4G6pfnjGC
         gNcNcT1wyrJ25OGY6MoznIrmHNhIyF5YDr2P9Viy7DvOkKPkqtsOvH06jcFXXBDEM9PR
         FrLixqeKXam7In+LnFyy9TfkMKOgbBLB0prlI+x8WtxdrSa7KJD2xi+8hV4S/kL6jkSK
         fdoR3P+QmJrDYVMg7qUE+bP2P5YSySxXIIDEsF61jOfcv6ughABMSXzB5Pre3Qso6Nwe
         hX3Q==
X-Gm-Message-State: APjAAAXkfuANRMbdJhIKh6X5pFPk0y7CK8RdUUQdOUjvwuobV78DO8fX
        OY60qrjFJsP9+DW3sKvQJ62jtQ==
X-Google-Smtp-Source: APXvYqwuoup90r4R1WbN5QHMJ2gC0Z695fuqPKVdrlhYZDu7KFCuAeK/ywh+OdwOOUQERJ5vlvtFiA==
X-Received: by 2002:adf:ef91:: with SMTP id d17mr38390472wro.78.1555151591792;
        Sat, 13 Apr 2019 03:33:11 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u17sm19547303wmu.36.2019.04.13.03.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 03:33:11 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [RESEND PATCH 05/20] nvmem: sunxi_sid: Optimize register read-out method
Date:   Sat, 13 Apr 2019 11:32:50 +0100
Message-Id: <20190413103305.9576-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
References: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

SID cells are 32-bit aligned, and a multiple of 32 bits in length. The
only outlier is the thermal sensor calibration data, which is 16 bits
per sensor. However a whole 64 bits is allocated for this purpose, so
we could consider it conforming to the rule above.

Also, the register read-out method assumes native endian, unlike the
direct MMIO method, which assumes big endian. Thus no endian conversion
is involved.

Under these assumptions, the register read-out method can be slightly
optimized. Instead of reading one word then discarding 3 bytes, read
the whole word directly into the buffer. However, for reads under 4
bytes or trailing bytes, we still use a scratch buffer to extract the
requested bytes.

We could go one step further if .word_size was 4, but changing that
would affect the sysfs interface's behavior.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sunxi_sid.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 704c35edf796..15fbfab62595 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -115,36 +115,34 @@ static int sun8i_sid_register_readout(const struct sunxi_sid *sid,
  * to be not reliable at all.
  * Read by the registers instead.
  */
-static int sun8i_sid_read_byte_by_reg(const struct sunxi_sid *sid,
-				      const unsigned int offset,
-				      u8 *out)
-{
-	u32 word;
-	int ret;
-
-	ret = sun8i_sid_register_readout(sid, offset & ~0x03, &word);
-
-	if (ret)
-		return ret;
-
-	*out = (word >> ((offset & 0x3) * 8)) & 0xff;
-
-	return 0;
-}
-
 static int sun8i_sid_read_by_reg(void *context, unsigned int offset,
 				 void *val, size_t bytes)
 {
 	struct sunxi_sid *sid = context;
-	u8 *buf = val;
+	u32 word;
 	int ret;
 
-	while (bytes--) {
-		ret = sun8i_sid_read_byte_by_reg(sid, offset++, buf++);
+	/* .stride = 4 so offset is guaranteed to be aligned */
+	while (bytes >= 4) {
+		ret = sun8i_sid_register_readout(sid, offset, val);
 		if (ret)
 			return ret;
+
+		val += 4;
+		offset += 4;
+		bytes -= 4;
 	}
 
+	if (!bytes)
+		return 0;
+
+	/* Handle any trailing bytes */
+	ret = sun8i_sid_register_readout(sid, offset, &word);
+	if (ret)
+		return ret;
+
+	memcpy(val, &word, bytes);
+
 	return 0;
 }
 
-- 
2.21.0

