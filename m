Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0C4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FA320872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aWzaZ5KD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfCRUrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:47:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50466 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfCRUrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:47:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id z11so5974066wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 13:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gTFecInQYP9wwQj812Skvi7oL3bq5LWKLMuFYZPP1Fw=;
        b=aWzaZ5KD2byT04qun1TNGBXfcx+En48cCP1ycdeUE8xD7chQW38vxt7jkkE/Hs78O9
         FIpluGwpjRIZDbTOrh+0dzzkBI/mYBwzt3VXj1bV+o6+RANctLylQwmqv74UHzYp7Xa7
         Zw5v0OWk8pPOW7oTR+Hgp/EQxj5MKmHjFostPcrdNrbyLUBbB6psN1T33l2dHEk5FfcU
         liIhRDgS0fRwJ7QdnxAdD8VOR+F/GOGYgLKRykWRDRCsjbyHgcI4hhqjamNbclw6wn7q
         EuS/w8Wh0LS/xOfxOdwGxlv1Ph8fpX6I6d0mcCOL+GUKe/ihjtYFzbM3r4CU9X+Kp87C
         zJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gTFecInQYP9wwQj812Skvi7oL3bq5LWKLMuFYZPP1Fw=;
        b=Mg28ylkglLc4KsUkR4noJz0zLtnxtGp3fsXTvcQjkXWlRgzAe2eIlvRR6p2QAY30Pl
         OV36G+0u272AP3ezgvEyBp35xPxZR9aHaJ6HKOeHvji3Z1N5t0XIlRdtPTEOgVj25VTS
         7m2cksHpylBTwKYMSOiVpC1Yban3aaU+tGTKdowGMKBzE7uFWApIdVElPmLjnaUZeS3S
         iexTp8hdRjagDbfwH5VfDnIUMqOARYi3huFW4tdP4+QY888x8Jse6H/tS1ofu//y3kYN
         3d7LoTTAYv3riPgi4y2uhSMYSzdVIsUIbD3IcSmF2gvbjgU7KgKRWVzFddl5rfB/MRp9
         N1Pw==
X-Gm-Message-State: APjAAAWYmsIzk2bg+ILEI+NGzpPAAee7dPPJ0bqhF/mtAS4nb+CD6Vc7
        gYaPwDmPbgiU/gkRCPXDdIM=
X-Google-Smtp-Source: APXvYqzOc9VNDbIX90H22bol5C6f4c1+BmYF1lTwu47Lth9itBXQhxsE2FeL557FDL+RUmR2PEqSCg==
X-Received: by 2002:a1c:7c0c:: with SMTP id x12mr627498wmc.38.1552942048819;
        Mon, 18 Mar 2019 13:47:28 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD7399900918378ACFECF051C.dip0.t-ipconnect.de. [2003:dc:d739:9900:9183:78ac:fecf:51c])
        by smtp.googlemail.com with ESMTPSA id y12sm224849wma.44.2019.03.18.13.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 13:47:28 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-mtd@lists.infradead.org,
        bbrezillon@kernel.org, miquel.raynal@bootlin.com
Cc:     liang.yang@amlogic.com, richard@nod.at, jianxin.pan@amlogic.com,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/2] mtd: rawnand: meson: add missing ENOMEM check in meson_nfc_read_buf()
Date:   Mon, 18 Mar 2019 21:47:21 +0100
Message-Id: <20190318204722.9901-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318204722.9901-1-martin.blumenstingl@googlemail.com>
References: <20190318204722.9901-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kzalloc() can return NULL if memory could not be allocated. Check the
return value of the kzalloc() call in meson_nfc_read_buf() to make it
consistent with other memory allocations within the meson_nand driver.

Fixes: 8fae856c53500a ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Liang Yang <liang.yang@amlogic.com>
---
 drivers/mtd/nand/raw/meson_nand.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 3e8aa71407b5..a1d8506b61c7 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -528,6 +528,9 @@ static int meson_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
 	u8 *info;
 
 	info = kzalloc(PER_INFO_BYTE, GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
 	ret = meson_nfc_dma_buffer_setup(nand, buf, len, info,
 					 PER_INFO_BYTE, DMA_FROM_DEVICE);
 	if (ret)
-- 
2.21.0

