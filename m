Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF43C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AF520850
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMT/cp2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfDTLg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 07:36:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36586 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDTLg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 07:36:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id r24so6601605ljg.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 04:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mNE0aOPV+S7Gbu4CUOfa+icowuG1l0JynCHHFRvDBQY=;
        b=IMT/cp2vcR9SLiRqsEv0hJQvIkvGUFDDGmYwZeBvQ/xuqpIHVhu7aavX22SpAdlUEu
         Qu8gWp5e91+F1AY9EMs7ppg9Hg8NwEWHKNtrLXgsQN54gpz9fPnA0he1Ve2Za56v4n9o
         E6TO2T9KA70Zqx+oTVdNzVCTWrOexIj1CXG3PZFQeuGiRXBGVc8kIMiR1f4xVroDV35/
         flFOwnkW84zgBmAPFGNxiy4LO6G2RN20cRjb3ube8CCgw/Mbw7a58Dz/cfsGNVVI6aPm
         OZRagZR6dYItgsPAr/N3VJOBViAVvEumsj2Ay8XMBUM4CRHPVnHwFHjtxFYV0AnHRYuF
         sbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mNE0aOPV+S7Gbu4CUOfa+icowuG1l0JynCHHFRvDBQY=;
        b=RHA8mmLisSGSc+SPwMPY73IprgIVRdq9OOMzfxgJXKFyTNagfCkMqjaAOueJDDEtvz
         NI+/3K0u7XZGmVa6bGaCdHD8I0A7UYsfQs0f3o40dmu859PY0Y2gRW+EqQuPEZY2vV1H
         5ioaJ5PJGV9SyxC+C+qi92aDm/mFrS79g9QX8j40IY2WC2id9QfLmLH22D9DevDUmZ3c
         TX+iXRe/5lsVHim3dk5HiaBUmHZBGO5VyxxKhKRe0pviFVBAq6N2rLrXGpRwO/7DkjsU
         HLbs2cPE+ZkJJoVogI11nrtfWyDiktGM89kPHb1c9Hx13/B2FKBjtopqZvqACtqUIRCK
         yDEQ==
X-Gm-Message-State: APjAAAX8IrRrKJ84A6J4+Axwu360r4qDZ3JXlzulJXwxYRO7osLcGPvd
        ajIHETiZQYObZ2ipg+eSfc743GzBVQQ=
X-Google-Smtp-Source: APXvYqyiWcGrxsOphC2LDrAC4L0699FbdduwxMFaAucr/yXKaDOioGPGOUgfNlOzTCZfy32IE9colQ==
X-Received: by 2002:a2e:b01a:: with SMTP id y26mr4849606ljk.38.1555760217262;
        Sat, 20 Apr 2019 04:36:57 -0700 (PDT)
Received: from localhost.localdomain (c-c5d3225c.014-348-6c756e10.bbcust.telenor.se. [92.34.211.197])
        by smtp.gmail.com with ESMTPSA id e18sm1633994ljb.12.2019.04.20.04.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Apr 2019 04:36:55 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] regulator: core: Actually put the gpiod after use
Date:   Sat, 20 Apr 2019 13:34:30 +0200
Message-Id: <20190420113430.9856-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I went to great lengths to hand over the management of the GPIO
descriptors to the regulator core, and some stray rebased
oneliner in the old patch must have been assuming the devices
were still doing devres management of it.

We handed the management over to the regulator core, so of
course the regulator core shall issue gpiod_put() when done.

Sorry for the descriptor leak.

Fixes: 541d052d7215 ("regulator: core: Only support passing enable GPIO descriptors")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 68473d0cc57e..362f34e73a3f 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2256,6 +2256,7 @@ static void regulator_ena_gpio_free(struct regulator_dev *rdev)
 		if (pin->gpiod == rdev->ena_pin->gpiod) {
 			if (pin->request_count <= 1) {
 				pin->request_count = 0;
+				gpiod_put(pin->gpiod);
 				list_del(&pin->list);
 				kfree(pin);
 				rdev->ena_pin = NULL;
-- 
2.20.1

