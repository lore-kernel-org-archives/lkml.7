Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF46CC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD2F20869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zpU7S8VU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfDMKdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 06:33:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43747 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfDMKdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 06:33:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id k17so10468244wrx.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 03:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nNPpw+rYp+nE314xH14BqLfXGNb/4oweWZkI/NC8IjY=;
        b=zpU7S8VUTR5+V/055bQG1wq6vOiKakxbSFIT5RpW9xJ64Jiy3HansEgBcZAUVJkplR
         uAzW10x7KClD4jttOOA0yWjMry+WuoUio3C3W01FZZNKQrSvjTc5wj5CxRIwgTKAVlWS
         I5WueUuKOeapaAxisqg+8yciLWQWeZ7xq/bXA+zDklW7K0XH6f/vJImuQS1/O6PLuKOR
         VvUcJxQ32HYMqU5kSusPP0lXHQEAKbL4jyYYVNxBDgYR90rNb9zZ7wRLL/bfY0Rop5le
         OAvh0aeRHT298XF7hj7xOB3O0c4ekxrmCuw1l76SFyNPRJ7ze74rzsgmTOTx8E9EVfA8
         ZOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nNPpw+rYp+nE314xH14BqLfXGNb/4oweWZkI/NC8IjY=;
        b=NOZEE5gsRPREDcqP6vTdq5FVAHY0yQESlXRUvhaP12Iiyn6RLbEq4R4GX7JBr98y5a
         vjduHnq3TSSOqQ34Wo39o2dZEh92B8lL6aGQJjLVIhyhhEJ9xIT4DGVDiMflCheoo/Zt
         x9UypZ7cYdGQ+Ltw/EawsADdaebr9B4vDpXmc6kOxR3Hmnzp7b/yK64vdcxpAJNOgaLw
         Z3COn/6uisabQGZe9BuqOJozorqNpesZe/atMjkT1sK8BCPfM69ThPTPNgaKhXVos9S/
         LswsgipcZXISfU21FAA5MO81u74OhzfsHZYtlODzakTBVWY3Q0IX/bt+FUN6hs+nImja
         hTgQ==
X-Gm-Message-State: APjAAAXDZQr54/FNF1a+wYeyRdKnWwBUw9U/Uq0x7f2OmriMco8tsuKW
        Uhp7p8ZmZ4wZdDM5AgZwa80VWQ==
X-Google-Smtp-Source: APXvYqzGHslE8VYl6eN/176zRfufS8HjtQ8Lez2XvAo4HSyJLtlXqfg95FOchE/CrVdGOHa7Iji0/A==
X-Received: by 2002:adf:f98d:: with SMTP id f13mr40243264wrr.98.1555151590781;
        Sat, 13 Apr 2019 03:33:10 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u17sm19547303wmu.36.2019.04.13.03.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 03:33:10 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [RESEND PATCH 04/20] nvmem: sunxi_sid: Read out SID for randomness without looping
Date:   Sat, 13 Apr 2019 11:32:49 +0100
Message-Id: <20190413103305.9576-5-srinivas.kandagatla@linaro.org>
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

Since the reg_read callbacks already support arbitrary, but 4-byte
aligned. offsets and lengths into the SID, there is no need for another
for loop just to use it to read 1 byte at a time.

Read out the whole SID block in one go.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sunxi_sid.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 570a2e354f30..704c35edf796 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -154,7 +154,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct nvmem_device *nvmem;
 	struct sunxi_sid *sid;
-	int i, size;
+	int size;
 	char *randomness;
 	const struct sunxi_sid_cfg *cfg;
 
@@ -189,8 +189,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 	if (!randomness)
 		return -ENOMEM;
 
-	for (i = 0; i < size; i++)
-		econfig.reg_read(sid, i, &randomness[i], 1);
+	econfig.reg_read(sid, 0, randomness, size);
 
 	add_device_randomness(randomness, size);
 	kfree(randomness);
-- 
2.21.0

