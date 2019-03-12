Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CF9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC49205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414003;
	bh=Uk4iqmBDYLtNIa+P153a9gANNlJN7zEmi7NhygaMZZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A2i8nJ0zUK3zhM/SMcR4K4zZ9D4wUV6KWIGhM3o9hNAn/FK2ya2gYtb3I0ZvPvT9U
	 PPcOvO7Q7h75j2J8mHev1qUSWWmbbhaYPdiNBInmj7+ieOgeecGPfwkv27T3Y8H8rp
	 ShPee8OnOvydzJryrl3KR0HF5+/N1O6p0rVFW1kQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfCLSGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:06:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfCLRM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:28 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E03492184D;
        Tue, 12 Mar 2019 17:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410748;
        bh=Uk4iqmBDYLtNIa+P153a9gANNlJN7zEmi7NhygaMZZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jay+6VrnMkhXzfpXl5WAhvedrjPcrJpwFZKUHjHX3KLYH8436m5FKWpSGzcNOrrMC
         sen6hip4jRNcaRdsRjWx9YZsI4sdzBcshCGOGE29O/76tgtxDVWIrJS8iXjjCu4LzP
         02YwQ/nhM92A23WPD/Jtg7zcTWJGwSVdsORZlCwU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Anand Moon <linux.amoon@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 075/171] ARM: dts: meson8b: odroidc1: mark the SD card detection GPIO active-low
Date:   Tue, 12 Mar 2019 10:07:35 -0700
Message-Id: <20190312170354.566264969@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index a951a6632d0c..0f0a46ddf3ff 100644
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



