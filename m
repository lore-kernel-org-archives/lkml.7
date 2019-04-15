Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F73C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E18D218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355093;
	bh=xgvKZYD66knx/aZGfraYqnq0uu476vr307LekRl5buk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VDjBW0iBdbpJNoMOF59ZGE2y8iRBZaRluJKmxZJEoI2reiZMtb+/P9abYf9Uoffbn
	 JPbNc1qcNSWbgkednp4uXaHaS6I0/eyCv8LsUt4ZCr7l/LDb9F4iymzR8D37uhfuIu
	 3A/gBvD5Lp7LOC9uynWcASp8bGrg9uZWPpAy/4fQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbfDOTEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:04:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729618AbfDOTEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:04:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 147EB218A1;
        Mon, 15 Apr 2019 19:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355087;
        bh=xgvKZYD66knx/aZGfraYqnq0uu476vr307LekRl5buk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pDggVpkOUCpeZ62vp3oYzn6uwK7TH+QU/tOLOeb7Ov6kvOycTyo6WI3lHv5phYDV5
         iA67mDr9ulPOPEO5XjYiLDzwBLbbQcKRFEH3FXBgmuYR8K8KQ33MJaHJxlAPt7nlYW
         cqqwZoTSaCvPOJXpeyWx7N2VixmE/hNgz8VSSYuQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.14 58/69] arm64: dts: rockchip: fix rk3328 rgmii high tx error rate
Date:   Mon, 15 Apr 2019 20:59:16 +0200
Message-Id: <20190415183735.389842336@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Geis <pgwipeout@gmail.com>

commit 6fd8b9780ec1a49ac46e0aaf8775247205e66231 upstream.

Several rk3328 based boards experience high rgmii tx error rates.
This is due to several pins in the rk3328.dtsi rgmii pinmux that are
missing a defined pull strength setting.
This causes the pinmux driver to default to 2ma (bit mask 00).

These pins are only defined in the rk3328.dtsi, and are not listed in
the rk3328 specification.
The TRM only lists them as "Reserved"
(RK3328 TRM V1.1, 3.3.3 Detail Register Description, GRF_GPIO0B_IOMUX,
GRF_GPIO0C_IOMUX, GRF_GPIO0D_IOMUX).
However, removal of these pins from the rgmii pinmux definition causes
the interface to fail to transmit.

Also, the rgmii tx and rx pins defined in the dtsi are not consistent
with the rk3328 specification, with tx pins currently set to 12ma and
rx pins set to 2ma.

Fix this by setting tx pins to 8ma and the rx pins to 4ma, consistent
with the specification.
Defining the drive strength for the undefined pins eliminated the high
tx packet error rate observed under heavy data transfers.
Aligning the drive strength to the TRM values eliminated the occasional
packet retry errors under iperf3 testing.
This allows much higher data rates with no recorded tx errors.

Tested on the rk3328-roc-cc board.

Fixes: 52e02d377a72 ("arm64: dts: rockchip: add core dtsi file for RK3328 SoCs")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi |   44 +++++++++++++++----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -1530,50 +1530,50 @@
 			rgmiim1_pins: rgmiim1-pins {
 				rockchip,pins =
 					/* mac_txclk */
-					<1 RK_PB4 2 &pcfg_pull_none_12ma>,
+					<1 RK_PB4 2 &pcfg_pull_none_8ma>,
 					/* mac_rxclk */
-					<1 RK_PB5 2 &pcfg_pull_none_2ma>,
+					<1 RK_PB5 2 &pcfg_pull_none_4ma>,
 					/* mac_mdio */
-					<1 RK_PC3 2 &pcfg_pull_none_2ma>,
+					<1 RK_PC3 2 &pcfg_pull_none_4ma>,
 					/* mac_txen */
-					<1 RK_PD1 2 &pcfg_pull_none_12ma>,
+					<1 RK_PD1 2 &pcfg_pull_none_8ma>,
 					/* mac_clk */
-					<1 RK_PC5 2 &pcfg_pull_none_2ma>,
+					<1 RK_PC5 2 &pcfg_pull_none_4ma>,
 					/* mac_rxdv */
-					<1 RK_PC6 2 &pcfg_pull_none_2ma>,
+					<1 RK_PC6 2 &pcfg_pull_none_4ma>,
 					/* mac_mdc */
-					<1 RK_PC7 2 &pcfg_pull_none_2ma>,
+					<1 RK_PC7 2 &pcfg_pull_none_4ma>,
 					/* mac_rxd1 */
-					<1 RK_PB2 2 &pcfg_pull_none_2ma>,
+					<1 RK_PB2 2 &pcfg_pull_none_4ma>,
 					/* mac_rxd0 */
-					<1 RK_PB3 2 &pcfg_pull_none_2ma>,
+					<1 RK_PB3 2 &pcfg_pull_none_4ma>,
 					/* mac_txd1 */
-					<1 RK_PB0 2 &pcfg_pull_none_12ma>,
+					<1 RK_PB0 2 &pcfg_pull_none_8ma>,
 					/* mac_txd0 */
-					<1 RK_PB1 2 &pcfg_pull_none_12ma>,
+					<1 RK_PB1 2 &pcfg_pull_none_8ma>,
 					/* mac_rxd3 */
-					<1 RK_PB6 2 &pcfg_pull_none_2ma>,
+					<1 RK_PB6 2 &pcfg_pull_none_4ma>,
 					/* mac_rxd2 */
-					<1 RK_PB7 2 &pcfg_pull_none_2ma>,
+					<1 RK_PB7 2 &pcfg_pull_none_4ma>,
 					/* mac_txd3 */
-					<1 RK_PC0 2 &pcfg_pull_none_12ma>,
+					<1 RK_PC0 2 &pcfg_pull_none_8ma>,
 					/* mac_txd2 */
-					<1 RK_PC1 2 &pcfg_pull_none_12ma>,
+					<1 RK_PC1 2 &pcfg_pull_none_8ma>,
 
 					/* mac_txclk */
-					<0 RK_PB0 1 &pcfg_pull_none>,
+					<0 RK_PB0 1 &pcfg_pull_none_8ma>,
 					/* mac_txen */
-					<0 RK_PB4 1 &pcfg_pull_none>,
+					<0 RK_PB4 1 &pcfg_pull_none_8ma>,
 					/* mac_clk */
-					<0 RK_PD0 1 &pcfg_pull_none>,
+					<0 RK_PD0 1 &pcfg_pull_none_4ma>,
 					/* mac_txd1 */
-					<0 RK_PC0 1 &pcfg_pull_none>,
+					<0 RK_PC0 1 &pcfg_pull_none_8ma>,
 					/* mac_txd0 */
-					<0 RK_PC1 1 &pcfg_pull_none>,
+					<0 RK_PC1 1 &pcfg_pull_none_8ma>,
 					/* mac_txd3 */
-					<0 RK_PC7 1 &pcfg_pull_none>,
+					<0 RK_PC7 1 &pcfg_pull_none_8ma>,
 					/* mac_txd2 */
-					<0 RK_PC6 1 &pcfg_pull_none>;
+					<0 RK_PC6 1 &pcfg_pull_none_8ma>;
 			};
 
 			rmiim1_pins: rmiim1-pins {


