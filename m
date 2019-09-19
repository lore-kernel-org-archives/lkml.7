Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65432C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0AC21907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931370;
	bh=vXaRYenn3fpJc/5HchT0ZUQjlU+0iYGXGNJoMVlceuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ni3NPmKJL1Hy9edjJ23fzrYHN96wOE8jOS1zmQ7tWm6BuvEQlHspfIPV+7iX7bWM7
	 1fhrO1fjkN7LiAghSnpTirQyfGLAHwI/NTnQh/npB0HLlUDzpecvON4e3eS7xw4A7N
	 UX0RWTC/O6FP7OM2L6IdRFGdobwIjqkaPmeMP5Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406268AbfISWQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:16:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406238AbfISWQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:16:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9564217D6;
        Thu, 19 Sep 2019 22:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931359;
        bh=vXaRYenn3fpJc/5HchT0ZUQjlU+0iYGXGNJoMVlceuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e6tWYuGxUXvq7jqpe+ke5xV4YhHX8TogPNJ4euWe7Xtt5/RWcGEMZNWBhggLpKxWr
         dupmjE1Km7w7EVu+KhUgK77fZQz+v5QCjx4SHhIfil7/gt27RpvpnzQ729kWhRiIEe
         aqlISXVIqc+4jSoDT35Na5x+A5v7HhwlJVWH4yG0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Faiz Abbas <faiz_abbas@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 18/59] ARM: dts: dra74x: Fix iodelay configuration for mmc3
Date:   Fri, 20 Sep 2019 00:03:33 +0200
Message-Id: <20190919214801.192356892@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214755.852282682@linuxfoundation.org>
References: <20190919214755.852282682@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

[ Upstream commit 07f9a8be66a9bd86f9eaedf8f8aeb416195adab8 ]

According to the latest am572x[1] and dra74x[2] data manuals, mmc3
default, hs, sdr12 and sdr25 modes use iodelay values given in
MMC3_MANUAL1. Set the MODE_SELECT bit for these so that manual mode is
selected and correct iodelay values can be configured.

[1] http://www.ti.com/lit/ds/symlink/am5728.pdf
[2] http://www.ti.com/lit/ds/symlink/dra746.pdf

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi | 50 +++++++++++------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi b/arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi
index 28ebb4eb884a9..214b9e6de2c35 100644
--- a/arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi
+++ b/arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi
@@ -32,7 +32,7 @@
  *
  * Datamanual Revisions:
  *
- * AM572x Silicon Revision 2.0: SPRS953B, Revised November 2016
+ * AM572x Silicon Revision 2.0: SPRS953F, Revised May 2019
  * AM572x Silicon Revision 1.1: SPRS915R, Revised November 2016
  *
  */
@@ -229,45 +229,45 @@
 
 	mmc3_pins_default: mmc3_pins_default {
 		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x377c, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_clk.mmc3_clk */
-			DRA7XX_CORE_IOPAD(0x3780, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_cmd.mmc3_cmd */
-			DRA7XX_CORE_IOPAD(0x3784, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_dat0.mmc3_dat0 */
-			DRA7XX_CORE_IOPAD(0x3788, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_dat1.mmc3_dat1 */
-			DRA7XX_CORE_IOPAD(0x378c, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_dat2.mmc3_dat2 */
-			DRA7XX_CORE_IOPAD(0x3790, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_dat3.mmc3_dat3 */
+			DRA7XX_CORE_IOPAD(0x377c, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_clk.mmc3_clk */
+			DRA7XX_CORE_IOPAD(0x3780, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_cmd.mmc3_cmd */
+			DRA7XX_CORE_IOPAD(0x3784, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_dat0.mmc3_dat0 */
+			DRA7XX_CORE_IOPAD(0x3788, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_dat1.mmc3_dat1 */
+			DRA7XX_CORE_IOPAD(0x378c, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_dat2.mmc3_dat2 */
+			DRA7XX_CORE_IOPAD(0x3790, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_dat3.mmc3_dat3 */
 		>;
 	};
 
 	mmc3_pins_hs: mmc3_pins_hs {
 		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x377c, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_clk.mmc3_clk */
-			DRA7XX_CORE_IOPAD(0x3780, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_cmd.mmc3_cmd */
-			DRA7XX_CORE_IOPAD(0x3784, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_dat0.mmc3_dat0 */
-			DRA7XX_CORE_IOPAD(0x3788, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_dat1.mmc3_dat1 */
-			DRA7XX_CORE_IOPAD(0x378c, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_dat2.mmc3_dat2 */
-			DRA7XX_CORE_IOPAD(0x3790, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_dat3.mmc3_dat3 */
+			DRA7XX_CORE_IOPAD(0x377c, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_clk.mmc3_clk */
+			DRA7XX_CORE_IOPAD(0x3780, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_cmd.mmc3_cmd */
+			DRA7XX_CORE_IOPAD(0x3784, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_dat0.mmc3_dat0 */
+			DRA7XX_CORE_IOPAD(0x3788, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_dat1.mmc3_dat1 */
+			DRA7XX_CORE_IOPAD(0x378c, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_dat2.mmc3_dat2 */
+			DRA7XX_CORE_IOPAD(0x3790, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_dat3.mmc3_dat3 */
 		>;
 	};
 
 	mmc3_pins_sdr12: mmc3_pins_sdr12 {
 		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x377c, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_clk.mmc3_clk */
-			DRA7XX_CORE_IOPAD(0x3780, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_cmd.mmc3_cmd */
-			DRA7XX_CORE_IOPAD(0x3784, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_dat0.mmc3_dat0 */
-			DRA7XX_CORE_IOPAD(0x3788, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_dat1.mmc3_dat1 */
-			DRA7XX_CORE_IOPAD(0x378c, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_dat2.mmc3_dat2 */
-			DRA7XX_CORE_IOPAD(0x3790, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_dat3.mmc3_dat3 */
+			DRA7XX_CORE_IOPAD(0x377c, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_clk.mmc3_clk */
+			DRA7XX_CORE_IOPAD(0x3780, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_cmd.mmc3_cmd */
+			DRA7XX_CORE_IOPAD(0x3784, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_dat0.mmc3_dat0 */
+			DRA7XX_CORE_IOPAD(0x3788, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_dat1.mmc3_dat1 */
+			DRA7XX_CORE_IOPAD(0x378c, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_dat2.mmc3_dat2 */
+			DRA7XX_CORE_IOPAD(0x3790, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_dat3.mmc3_dat3 */
 		>;
 	};
 
 	mmc3_pins_sdr25: mmc3_pins_sdr25 {
 		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x377c, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_clk.mmc3_clk */
-			DRA7XX_CORE_IOPAD(0x3780, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_cmd.mmc3_cmd */
-			DRA7XX_CORE_IOPAD(0x3784, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_dat0.mmc3_dat0 */
-			DRA7XX_CORE_IOPAD(0x3788, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_dat1.mmc3_dat1 */
-			DRA7XX_CORE_IOPAD(0x378c, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_dat2.mmc3_dat2 */
-			DRA7XX_CORE_IOPAD(0x3790, (PIN_INPUT_PULLUP | MUX_MODE0)) /* mmc3_dat3.mmc3_dat3 */
+			DRA7XX_CORE_IOPAD(0x377c, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_clk.mmc3_clk */
+			DRA7XX_CORE_IOPAD(0x3780, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_cmd.mmc3_cmd */
+			DRA7XX_CORE_IOPAD(0x3784, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_dat0.mmc3_dat0 */
+			DRA7XX_CORE_IOPAD(0x3788, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_dat1.mmc3_dat1 */
+			DRA7XX_CORE_IOPAD(0x378c, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_dat2.mmc3_dat2 */
+			DRA7XX_CORE_IOPAD(0x3790, (PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE0)) /* mmc3_dat3.mmc3_dat3 */
 		>;
 	};
 
-- 
2.20.1



