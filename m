Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2186FC04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD471216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DOrQVVyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389306AbfETNlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:41:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52525 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731144AbfETNlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:41:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id y3so13381900wmm.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a7cfIiCWiicKqtrPSknAcBLN0KCAEwC5ns6XxWqRMAE=;
        b=DOrQVVyiOmSy1XrUQsrfKhDXCtzEAde/ZUwe0lqGPHxkY88sbqHxmd1xZzurOC6la9
         uufgFNhf6Z+zDMzkRFkeApC6qXyvsUy1fev56SUjkXrNRFBbCL46d4wsXPrvixlG5YKw
         GAG9ZR9NfMQzy7O2HnOuTJ0Q3CKzTBqctqKBHoJQZ2qX/wdb9EaJ7qSEKQB//xaTuLug
         EJ/08r60d8mAl8uaFOa0gUSPvn1pRuEjHuX3n5du4CeAEq0LFAROPIBOd8kPNojGKqz1
         WahhBljCfbqL1r0Bx51vvFwJBG1zOEYoO1LyOWFv3rY9kM3H207yZaJXrACDQJ1FEn7E
         brkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a7cfIiCWiicKqtrPSknAcBLN0KCAEwC5ns6XxWqRMAE=;
        b=fTImCOFWIpI3+R+TF0equAldY2RO6TjbCkqzfwc7eOoadIVOHnPNCIJAZqd86IlAAc
         m33hUuF8Ts3xRug+M2emmBXMgD6NB+vJXQ0hlJeC9vaovV74IpKMgxsICNWtf2Gq9gqD
         5XCtYwZ6c3pUoZ2WLAo9IehIwIRV3LS07gX8a7Bf5/MbjEiq+e32ePoGQoXJ0Nxv5r27
         JL9GxXFFCHqyg38SVxr086hIQXkGd/1SuuPE1pCgKsN8eSfJ3HGAbsN6rTobWKdpkxB2
         tCGkzMrawbnYJcuceXJuKie432BwbvJXBIOprNKERQvSoU8yvnEb9m9a0TOhBqh9G9cn
         91iA==
X-Gm-Message-State: APjAAAVm6G6Sy/aRB9IxPLFteCIv5P2QpObFfu5G8fIyKZFgX2vEDvnP
        VY1UY2zjCbh0+39t2dgBLenCZA==
X-Google-Smtp-Source: APXvYqyNGp4vfLo3G057FlGQGxZbnPryHolj/aJnovIvWRHGyJ4Ald96z+gZgFe/8GEp9irFPlv9hQ==
X-Received: by 2002:a1c:c144:: with SMTP id r65mr36553133wmf.24.1558359679306;
        Mon, 20 May 2019 06:41:19 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o11sm5406678wrp.23.2019.05.20.06.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 06:41:18 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btbcm: Add entry for BCM4359C0 UART bluetooth
Date:   Mon, 20 May 2019 15:41:04 +0200
Message-Id: <20190520134104.24575-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM4359C0 BT/Wi-Fi compo chip needs an entry to be discovered
by the btbcm driver.

Tested using an AP6398S module from Ampak.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/bluetooth/btbcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index d5d6e6e5da3b..b9eac94c503d 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -342,6 +342,7 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x230f, "BCM4356A2"	},	/* 001.003.015 */
 	{ 0x220e, "BCM20702A1"  },	/* 001.002.014 */
 	{ 0x4217, "BCM4329B1"   },	/* 002.002.023 */
+	{ 0x6106, "BCM4359C0"	},	/* 003.001.006 */
 	{ }
 };
 
-- 
2.21.0

