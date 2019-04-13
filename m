Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C844C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A0D2082E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gaTf/Kz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfDMKdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 06:33:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51656 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfDMKdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 06:33:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so14208215wmf.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 03:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NSmhCvxGmxJOFjEyMP/iqXk2ZY7OelNbJh9A4LaXIZg=;
        b=gaTf/Kz5tbpMYnMmKTPqjpDTgXLUIJVJnlOrsb0+Wj73hdN4xlAAfyN2P438hH37zi
         7DEp69vV5K8Gu0pxeGqCL3K10aC3s3ed+w+/XjCENhNwZvy9loVeCkjghTt/XflEwBbI
         /QJVK2EAjgGmKY7BIJNNXOmS8+Hm/ogNZA6E2ChR6QU8RMDrgztVOOSXiaTjRr+jesk6
         eezO54eysEZArvDy9APJxoxYrIqCo3dsyjvc/J4+u6yhZBJV0V8yNB5bnUSbUQaWHtjM
         nORz7JpuNmcQ1x7s9vhVeFds90deDFTbBMkdj7WKPZmR9dtfLlS81TAfDNNufMi20I/1
         24Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NSmhCvxGmxJOFjEyMP/iqXk2ZY7OelNbJh9A4LaXIZg=;
        b=SVkpz5QOx0N6znJmsrmNL3ILerZpwef1NeadYagETCePVZJix/R6GY15ZmA+FMnBeG
         vC0cxdGi5cFYhoU25tkFnnR4pRfK8dlgIkW3gSKgwtmGsX/7RNhCzeDvJEZdOgt+18OJ
         M+IWKKijHets5FfQjh/mF0FKT65v3i19J615TlZfWuEmElqflHKehlelvunGgO5z/Lmi
         ra7iSUS0CZSJgW3m1UbmybPMsX16VXEuoTmqTch07UVVuahU4jlGfZzOJkczyjxUC2h5
         Wq3kBRAhj7XjLTssm8hmNqiJ8kvPsnIjypGYVJnKtyFAK3+KmTJmF/K9mqMZSzOdgtqT
         CX1Q==
X-Gm-Message-State: APjAAAWudQ8pbNBH7t3ZR8henurcrnz2MixnyFup/zA2+NdblyLYaBzQ
        8AJocLmkOPPY2Qn7pxuRVMECpg==
X-Google-Smtp-Source: APXvYqwNmXkjG7OwQ2d1uZ2Dzcu6GGScNP4WiFn5OChDdxzHK0rKETSeWUy7DhcyrMqZLP2UIK8+8g==
X-Received: by 2002:a7b:c304:: with SMTP id k4mr15112053wmj.22.1555151594984;
        Sat, 13 Apr 2019 03:33:14 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u17sm19547303wmu.36.2019.04.13.03.33.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 03:33:14 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [RESEND PATCH 07/20] nvmem: sunxi_sid: Read out data in native format
Date:   Sat, 13 Apr 2019 11:32:52 +0100
Message-Id: <20190413103305.9576-8-srinivas.kandagatla@linaro.org>
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

Originally the SID e-fuses were thought to be in big-endian format.
Later sources show that they are in fact native or little-endian.
The most compelling evidence is the thermal sensor calibration data,
which is a set of one to three 16-bit values. In native-endian they
are in 16-bit cells with increasing offsets, whereas with big-endian
they are in the wrong order, and a gap with no data will show if there
are one or three cells.

Switch to a native endian representation for the nvmem device. For the
H3, the register read-out method was already returning data in native
endian. This only affects the other SoCs.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sunxi_sid.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 75c1f48cb3d0..14c114620ed6 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -46,33 +46,12 @@ struct sunxi_sid {
 	u32			value_offset;
 };
 
-/* We read the entire key, due to a 32 bit read alignment requirement. Since we
- * want to return the requested byte, this results in somewhat slower code and
- * uses 4 times more reads as needed but keeps code simpler. Since the SID is
- * only very rarely probed, this is not really an issue.
- */
-static u8 sunxi_sid_read_byte(const struct sunxi_sid *sid,
-			      const unsigned int offset)
-{
-	u32 sid_key;
-
-	sid_key = ioread32be(sid->base + round_down(offset, 4));
-	sid_key >>= (offset % 4) * 8;
-
-	return sid_key; /* Only return the last byte */
-}
-
 static int sunxi_sid_read(void *context, unsigned int offset,
 			  void *val, size_t bytes)
 {
 	struct sunxi_sid *sid = context;
-	u8 *buf = val;
-
-	/* Offset the read operation to the real position of SID */
-	offset += sid->value_offset;
 
-	while (bytes--)
-		*buf++ = sunxi_sid_read_byte(sid, offset++);
+	memcpy_fromio(val, sid->base + sid->value_offset + offset, bytes);
 
 	return 0;
 }
-- 
2.21.0

