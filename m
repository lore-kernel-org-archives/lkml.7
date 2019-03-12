Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1364C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A06205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413155;
	bh=UY4sQtI/RwRrKg7VD/Pbm06wmDUuHTgERBt6Ts9nwrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CLZCCUIZsHBzDh6PggHSZ0PqYsUhRWGqEh+t0QBhNlZB4Pq5tDGCjyDUZWPpzXGqW
	 UwHXqE+BwaeC4wlHAtctdjW6UuJAN7QiDQxA8cuF9IWWucZa5YkWwDgVFM6ZpwEdiB
	 aTl27DrAloLcXrfb7sufYbvKSAEZM+uc55H6gilc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfCLRwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:52:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbfCLRO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:26 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2551F21850;
        Tue, 12 Mar 2019 17:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410866;
        bh=UY4sQtI/RwRrKg7VD/Pbm06wmDUuHTgERBt6Ts9nwrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RAKMS2gOpsM/UbaFP4G+MHfbiy8wsbAJbN6ROlPG6rA3uziNx2/vcpuhep8zLHSnH
         z+SCaO0TMnGy6xGFsZI6TomqysweTwoBmqGR59ECpsool5jy/mav63T0Lp7O8Qnlsp
         dkgwqwPQPJEbh/JckLMY2p0/rol9ysnrc1SD1CGQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Anand Moon <linux.amoon@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 066/149] ARM: dts: meson8b: odroidc1: mark the SD card detection GPIO active-low
Date:   Tue, 12 Mar 2019 10:08:04 -0700
Message-Id: <20190312170355.238969846@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 9e48936e2d8d..8fdeeffecbdb 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -171,8 +171,7 @@
 		cap-sd-highspeed;
 		disable-wp;
 
-		cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-		cd-inverted;
+		cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 		vmmc-supply = <&tflash_vdd>;
 		vqmmc-supply = <&tf_io>;
-- 
2.19.1



