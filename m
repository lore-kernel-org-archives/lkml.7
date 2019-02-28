Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4ABC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2854620C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367649;
	bh=3PTBFZ8XtEXLFzv3SCqZfblweenlE5Sk6LrY8xgasGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dubZCb+TPxqZlCC8PHLIYUC1DXHQYSuPrV2jqtVSXO002sDT2sJ97VuaOeENNRC5p
	 h7ffyBliqn6Nq81C5DuhFhaGqqbnB3JhihoEs9zBSQKWLdOT4TGLtj++ydhUIg088n
	 zgrLkwAWTdNptBm/4YsQVHubVcU1O6QSZ5CdKbfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388414AbfB1P11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:27:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387923AbfB1PLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:11:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31634218C3;
        Thu, 28 Feb 2019 15:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366672;
        bh=3PTBFZ8XtEXLFzv3SCqZfblweenlE5Sk6LrY8xgasGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P1GB+wA3imEIT1hl5qxOg6i3VW4SiNsz+YofinNjWu60xTQjGnHjb7D1+MTuWnMsn
         8stJ1/CLYFP9RT9sU52+bC4YZv/uljeveKpY8il2vYAuQLumFOYmVea1TYtiToxR81
         xBqvGRa51CIdUcbNl9qlg76PjqCReyefzyu3CLuw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 06/64] ARM: dts: meson8m2: mxiii-plus: mark the SD card detection GPIO active-low
Date:   Thu, 28 Feb 2019 10:10:07 -0500
Message-Id: <20190228151105.11277-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 8615f5596335db0978cea593dcd0070dc5f8b116 ]

After commit 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device
tree") SD cards are not detected anymore.

The CD GPIO is "active low" on the MXIII-Plus. The MMC dt-bindings
specify: "[...] using the "cd-inverted" property means, that the CD line
is active high, i.e. it is high, when a card is inserted".

Fix the description of the SD card by marking it as GPIO_ACTIVE_LOW and
drop the "cd-inverted" property. This makes the definition consistent
with the existing dt-bindings and fixes the check whether an SD card is
inserted.

Fixes: 35ee52bea66c74 ("ARM: dts: meson8m2: add support for the Tronsmart MXIII Plus")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
index f5853610b20b8..6ac02beb5fa72 100644
--- a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
+++ b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
@@ -206,8 +206,7 @@
 		cap-sd-highspeed;
 		disable-wp;
 
-		cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-		cd-inverted;
+		cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 		vmmc-supply = <&vcc_3v3>;
 	};
-- 
2.19.1

