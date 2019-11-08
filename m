Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ED1FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5250020869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214396;
	bh=wa7YDgehiZ0AGsCxw7mUn8MD6uR/Hfws7/JZg4+w6Mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hJmkLFqk6OJ3X81IfJqoUJFgGvVfovyS3duWOTB9plCpCewv9nYKgBXf011MqJnUZ
	 6S4wRS5g10wXi8xwfjgI9H4cVocxi6Q9weqWjttB3LGh3lziww5nV63OMCk9ccLGnI
	 lAru7ZNjwMsvfCalns1xtlvvqwjUZ7L8OUey3hug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391613AbfKHL7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:59:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:58776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390645AbfKHLoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:44:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E9B9222C4;
        Fri,  8 Nov 2019 11:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213443;
        bh=wa7YDgehiZ0AGsCxw7mUn8MD6uR/Hfws7/JZg4+w6Mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dKyixJ7orJKDAM02MQHbef5iWXC1/NxoZaO6lk+XLaHM+QW4QdYwvhdbc5wbFEcIy
         PUiigw3v2S125JLGyFcF4lIdSOeig8QroQb0bcKpDjPao1E8DqlWktIRIwk3f2LwEz
         K1hSUgXvyViWk/fwQGPJ6apFP0iutygpfXue8e/k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 037/103] ARM: dts: meson8: fix the clock controller register size
Date:   Fri,  8 Nov 2019 06:42:02 -0500
Message-Id: <20191108114310.14363-37-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit f7f9da89bc4f61e33f7b9f5c75c4efdc1f0455d8 ]

The clock controller registers are not 0x460 wide because the reset
controller starts at CBUS 0x4404. This currently overlaps with the
clock controller (which is at CBUS 0x4000).

There is no public documentation available on the actual size of the
clock controller's register area (also called "HHI"). However, in
Amlogic's GPL kernel sources the last "HHI" register is
HHI_HDMI_PHY_CNTL2 at CBUS + 0x43a8. 0x400 was chosen because that size
doesn't seem unlikely.

Fixes: 2c323c43a3d619 ("ARM: dts: meson8: add and use the real clock controller")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/meson8.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index b98d44fde6b60..e3ae85d65b39b 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -170,7 +170,7 @@
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 		compatible = "amlogic,meson8-clkc";
-		reg = <0x8000 0x4>, <0x4000 0x460>;
+		reg = <0x8000 0x4>, <0x4000 0x400>;
 	};
 
 	pwm_ef: pwm@86c0 {
-- 
2.20.1

