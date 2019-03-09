Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C48C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 16:12:53 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDD92081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 16:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=iris.mystia.org header.i=@iris.mystia.org header.b="QeW7Pr1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDD92081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iris.mystia.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfCIQKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 11:10:15 -0500
Received: from lyra.margatroid.com ([118.27.33.189]:59090 "EHLO
        lyra.margatroid.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfCIQKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 11:10:15 -0500
From:   Tomohiro Mayama <parly-gh@iris.mystia.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iris.mystia.org;
        s=lyra-20180701; t=1552147807;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=K/8lgeC4S8yVpWvC3p4dQTc0mOaa+Q7Kb0NBvrbE8NE=;
        b=QeW7Pr1woPoLOSEvkeC0lUHlgz+qbJ8uVewzIlwz7oyxZWNtdLbAq5AbUPE2hWWSmpT0Ze
        T6etvExkwFaC4A4l1ScYNsogycuasjYqbDdL+GznV9rYHXzLGSmIwoDTSGSMEsoBtaivwT
        zmAG+6XzAQ4Kf/4bAT4rS0kngC+KFBsqxgVuzszQLx9uMaTBk7I/MhIsvksy6KU48mRooG
        Q2+fxCVx8LQ6GzGE/6LXejJeVz/Yv3C/SNSkyn9j4tC+YYKKL99iWjgUchqeyjjE9JuwiP
        tAcaedklR7ymWmuaxV4ARzuM22GeZtS7rcvTnmnhwb+8BxeoIptXDkM78cnpbQ==
Subject: [PATCH v2] arm64: dts: rockchip: Fix vcc_host1_5v GPIO polarity on
 rk3328-rock64
To:     heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <4e9800cd-ac6d-9eb8-60d4-8e4b1aa761b9@iris.mystia.org>
Message-ID: <22e82bfa-8044-d126-59cc-6e6f42ca4b9c@iris.mystia.org>
Date:   Sun, 10 Mar 2019 01:10:12 +0900
MIME-Version: 1.0
In-Reply-To: <4e9800cd-ac6d-9eb8-60d4-8e4b1aa761b9@iris.mystia.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes USB ports functioning again.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Tomohiro Mayama <parly-gh@iris.mystia.org>
Tested-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
v2:
* Added Suggested-by and Tested-by tags
---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 21107d0f4378..7f365e448867 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -45,8 +45,7 @@
 
 	vcc_host1_5v: vcc_otg_5v: vcc-host1-5v-regulator {
 		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&usb20_host_drv>;
 		regulator-name = "vcc_host1_5v";
-- 
2.21.0

