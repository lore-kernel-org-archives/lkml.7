Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B347C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA27206DD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551368054;
	bh=Lg04C9W5fRkzvTOg9yLlQTCMd01n/IXsK9ogwGodBgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PxziAvK9ff2gKHekD7i8xJTUXyGE36BQHxYKbZ5qmAXuNcujuS5xd/Y3WDDI9m8SU
	 bQrmwJDD5vcH1UAs/hPxD64KlpqjNh6oJY67C4z0EU51CBoy4iMwWz27RwI/KZjDZl
	 HpSZgyiGqi3/O9O8uy3hJfrJ2sYiEoeNRV03zl/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbfB1PIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:08:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:40394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732121AbfB1PIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:08:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99F07218C3;
        Thu, 28 Feb 2019 15:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366500;
        bh=Lg04C9W5fRkzvTOg9yLlQTCMd01n/IXsK9ogwGodBgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LBhV4fWyKK/aJOUukEBM3K8EM9VTnDroat5yklHpWz8wewYGnuvGK/0gORIHYhnbr
         iOZRt9GmTPxZtovxjFW7hSrKrHpiFwMr9CCnusmGwlzOqz8BvEQg932Sfu8r+9Vjvo
         YcE+7f7/+heRPZRW9Fr2NgF0D7fWnOA8ElFTZZdQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.20 05/81] ARM: dts: meson8b: odroidc1: mark the SD card detection GPIO active-low
Date:   Thu, 28 Feb 2019 10:06:57 -0500
Message-Id: <20190228150813.10256-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 3fb348e030319f20ebbde082a449d4bf8a96f2fd ]

After commit 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device
tree") SD cards are not detected anymore.

The CD GPIO is "active low" on Odroid-C1. The MMC dt-bindings specify:
"[...] using the "cd-inverted" property means, that the CD line is active
high, i.e. it is high, when a card is inserted".

Fix the description of the SD card by marking it as GPIO_ACTIVE_LOW and
drop the "cd-inverted" property. This makes the definition consistent
with the existing dt-bindings and fixes the check whether an SD card is
inserted.

Fixes: e03efbce6bebf5 ("ARM: dts: meson8b-odroidc1: add microSD support")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Anand Moon <linux.amoon@gmail.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index a951a6632d0c7..0f0a46ddf3ff2 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -272,8 +272,7 @@
 		cap-sd-highspeed;
 		disable-wp;
 
-		cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-		cd-inverted;
+		cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 		vmmc-supply = <&tflash_vdd>;
 		vqmmc-supply = <&tf_io>;
-- 
2.19.1

