Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE33C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD62120880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355573;
	bh=7PJd7/N1OXxoYFuPagzOBgACDWWNgT6akGG+6BvaXms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Hih8R48nTpG+8eNHbgbDJE5kcXZQFdE3G+/lYDgv5rXALk7+8eunhfQCBDEHSvRp
	 2RHkpK29cb1EIAqkgIVFtk6kAHsbmbQ/sHsnExei+6kJxl7x9ExR39P2TFoJfFQXxH
	 vRhTSJTh/VGQ5cRQ1sSzUSISnji0ALypElaUD8PM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbfDOTMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728625AbfDOTMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:12:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC6A820880;
        Mon, 15 Apr 2019 19:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355568;
        bh=7PJd7/N1OXxoYFuPagzOBgACDWWNgT6akGG+6BvaXms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VUMbtRCdrQxTHFeuiG8BpGBFAFu6LWa6nXHQcV5kbzwywYzpty4I/o3lsIW+ntOYQ
         S5E00xBHeJoIr/224XBQw2+0+KWDC8AcmlVD3H4Ij2P/2YEiPEu7cX6AaS6u7Btt7W
         ZqAkBM6YVavdfV+71pccjr2r8zssv7cNBNTn9S+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 5.0 059/117] arm64: dts: rockchip: fix rk3328 sdmmc0 write errors
Date:   Mon, 15 Apr 2019 21:00:29 +0200
Message-Id: <20190415183747.924354884@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Geis <pgwipeout@gmail.com>

commit 09f91381fa5de1d44bc323d8bf345f5d57b3d9b5 upstream.

Various rk3328 based boards experience occasional sdmmc0 write errors.
This is due to the rk3328.dtsi tx drive levels being set to 4ma, vs
8ma per the rk3328 datasheet default settings.

Fix this by setting the tx signal pins to 8ma.
Inspiration from tonymac32's patch,
https://github.com/ayufan-rock64/linux-kernel/commit/dc1212b347e0da17c5460bcc0a56b07d02bac3f8

Fixes issues on the rk3328-roc-cc and the rk3328-rock64 (as per the
above commit message).

Tested on the rk3328-roc-cc board.

Fixes: 52e02d377a72 ("arm64: dts: rockchip: add core dtsi file for RK3328 SoCs")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -1431,11 +1431,11 @@
 
 		sdmmc0 {
 			sdmmc0_clk: sdmmc0-clk {
-				rockchip,pins = <1 RK_PA6 1 &pcfg_pull_none_4ma>;
+				rockchip,pins = <1 RK_PA6 1 &pcfg_pull_none_8ma>;
 			};
 
 			sdmmc0_cmd: sdmmc0-cmd {
-				rockchip,pins = <1 RK_PA4 1 &pcfg_pull_up_4ma>;
+				rockchip,pins = <1 RK_PA4 1 &pcfg_pull_up_8ma>;
 			};
 
 			sdmmc0_dectn: sdmmc0-dectn {
@@ -1447,14 +1447,14 @@
 			};
 
 			sdmmc0_bus1: sdmmc0-bus1 {
-				rockchip,pins = <1 RK_PA0 1 &pcfg_pull_up_4ma>;
+				rockchip,pins = <1 RK_PA0 1 &pcfg_pull_up_8ma>;
 			};
 
 			sdmmc0_bus4: sdmmc0-bus4 {
-				rockchip,pins = <1 RK_PA0 1 &pcfg_pull_up_4ma>,
-						<1 RK_PA1 1 &pcfg_pull_up_4ma>,
-						<1 RK_PA2 1 &pcfg_pull_up_4ma>,
-						<1 RK_PA3 1 &pcfg_pull_up_4ma>;
+				rockchip,pins = <1 RK_PA0 1 &pcfg_pull_up_8ma>,
+						<1 RK_PA1 1 &pcfg_pull_up_8ma>,
+						<1 RK_PA2 1 &pcfg_pull_up_8ma>,
+						<1 RK_PA3 1 &pcfg_pull_up_8ma>;
 			};
 
 			sdmmc0_gpio: sdmmc0-gpio {


