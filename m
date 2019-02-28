Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771CBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455AC2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551368087;
	bh=/gXx+sHByFhAxCM4gt0GeWtBOcR9/XWDE9CcRP0bQPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uDd4nKjYnsZUS8A1eqXzC0Dimazpw3wuvxL+myNPqtzPMznY6z8FOXTVlzj+mlkBZ
	 zwIP+we5lzgBgrpPts6ia7QzwlMo+BUw3oYLf4yuiYUOu/iWG9tQ1TYonsnnJIvCED
	 2c92QKTmkPCfTY9WLFwuTgHhWgcoSAaRk95gjRSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731454AbfB1Pep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:34:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732492AbfB1PIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:08:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABA8C218D3;
        Thu, 28 Feb 2019 15:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366501;
        bh=/gXx+sHByFhAxCM4gt0GeWtBOcR9/XWDE9CcRP0bQPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IXTRLKk2F7QOSaEfH7CAjwJVVypMrQPJGZlJgzwtLt/7IbCY29+lMS5kUl/R1MJrc
         cdKe+dInf0FsqUtonlGSMU3hszzDJtG//tZ7OjhUheNseHyy9B7sz7S+1jwW/WQ9AG
         TQJ1HczWkEtxTwf3fAOiWFMng1tOowSDeIq/iAJc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.20 06/81] ARM: dts: meson8b: ec100: mark the SD card detection GPIO active-low
Date:   Thu, 28 Feb 2019 10:06:58 -0500
Message-Id: <20190228150813.10256-6-sashal@kernel.org>
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

[ Upstream commit c8bfe65fb1fb7a43d766df1dfa379406112cba61 ]

After commit 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device
tree") SD cards are not detected anymore.

The CD GPIO is "active low" on the EC-100. The MMC dt-bindings specify:
"[...] using the "cd-inverted" property means, that the CD line is active
high, i.e. it is high, when a card is inserted".

Fix the description of the SD card by marking it as GPIO_ACTIVE_LOW and
drop the "cd-inverted" property. This makes the definition consistent
with the existing dt-bindings and fixes the check whether an SD card is
inserted.

Fixes: bbedc1f1d90e33 ("ARM: dts: meson8b: Add support for the Endless Mini (EC-100)")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/meson8b-ec100.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b-ec100.dts b/arch/arm/boot/dts/meson8b-ec100.dts
index 0872f6e3abf56..d50fc2f60fa31 100644
--- a/arch/arm/boot/dts/meson8b-ec100.dts
+++ b/arch/arm/boot/dts/meson8b-ec100.dts
@@ -205,8 +205,7 @@
 		cap-sd-highspeed;
 		disable-wp;
 
-		cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-		cd-inverted;
+		cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 		vmmc-supply = <&vcc_3v3>;
 	};
-- 
2.19.1

