Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC51C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7B32085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214996;
	bh=1lS/UyAtBNQsiqwWb7YJnxOKYosA1o14gN2Xh6864as=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i2FmLBiZYnh5GhbLQHvwicsjxZPirGUUUifOKM0rIrE2Bu3M10XBw2rkR3Gh+BwXx
	 oNqMl3XN/QfLyUjEpdQjbeaWtA2hM4a577zjuzI0A6TVswb96hHpZHaDRrDmPmGCmm
	 m73Ai+xjDzbVBZJzRI3W997c6KBebBs+hmxQDP5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391734AbfKHMJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:09:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:52704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388062AbfKHLjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:39:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 845D2222C6;
        Fri,  8 Nov 2019 11:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213189;
        bh=1lS/UyAtBNQsiqwWb7YJnxOKYosA1o14gN2Xh6864as=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rlySRmJ7dFJE/53CUFKqx0ccIP1X07TKmgThaZpmrG3/O50F4BS3/eXDBQvduMqRv
         7g+64joarbD6QSeIcXwkeTgaI0Qn9nsbjx+Idk1dc/NUQOH5Bzm7FYMbKFdCyO3C60
         UKebh9z8vQWZE7ngnVvRseslsWpflILdShNELSkY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 079/205] ARM: dts: meson8b: fix the clock controller register size
Date:   Fri,  8 Nov 2019 06:35:46 -0500
Message-Id: <20191108113752.12502-79-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit f31094fe8c16fbd2ca47921acf93b744b045aace ]

The clock controller registers are not 0x460 wide because the reset
controller starts at CBUS 0x4404. This currently overlaps with the
clock controller (which is at CBUS 0x4000).

There is no public documentation available on the actual size of the
clock controller's register area (also called "HHI"). However, in
Amlogic's GPL kernel sources the last "HHI" register is
HHI_HDMI_PHY_CNTL2 at CBUS + 0x43a8. 0x400 was chosen because that size
doesn't seem unlikely.

Fixes: 4a69fcd3a10803 ("ARM: meson: Add DTS for Odroid-C1 and Tronfy MXQ boards")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/meson8b.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 5b3e5c50c72f7..4293047a4b76b 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -163,7 +163,7 @@
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 		compatible = "amlogic,meson8b-clkc";
-		reg = <0x8000 0x4>, <0x4000 0x460>;
+		reg = <0x8000 0x4>, <0x4000 0x400>;
 	};
 
 	reset: reset-controller@4404 {
-- 
2.20.1

