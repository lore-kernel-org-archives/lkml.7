Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745E1C2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F49C207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=openedev.com header.i=@openedev.com header.b="b1T/pbK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLQH7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 02:59:15 -0500
Received: from se14o.web-hosting.com ([198.54.122.232]:47255 "EHLO
        se14o.web-hosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfLQH7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:59:14 -0500
Received: from [68.65.123.203] (helo=server153.web-hosting.com)
        by se17.registrar-servers.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <akash@openedev.com>)
        id 1ih7kq-0001qs-Vx; Mon, 16 Dec 2019 23:59:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=openedev.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R87a5RKkPMIXSDaMNn8B5V31G8d9qxBmgAHocZfiGXE=; b=b1T/pbK6+PUKG4pumNpmxYKYL
        7CCgmSqVSwcxKOwKi968iCUa6Bi+i/iFRtctA8YHkU1ghnoWBT9BCHt42LAPYE5UJ6cgsSwAtXcZt
        2awgCvs/12QVwTyXyu0o70mrLRHUoXoB5trLPd1sSA4YviuYORcv87h4YfFtM7gFSrm3g6VFZH621
        m5bTd53otp5FqRxjfqRBRq14m33BXqtUCSpK+qYqEIvbtGCmxHIEaxBHk71XCO/wzpCdPy3lYgXVb
        5TVVWJ9utg886vf45jnowyLI832oBKmrGrQKtkH9LpLj/La1Dcn5JuGxXXM1874qAbZnSmSxpy1BK
        QjUFNQecw==;
Received: from nat-inn.mentorg.com ([192.94.34.34]:44656 helo=akash-vm.inn-wifi.mentorg.com)
        by server153.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <akash@openedev.com>)
        id 1ih7kj-003CWq-Tv; Tue, 17 Dec 2019 02:58:50 -0500
From:   Akash Gajjar <akash@openedev.com>
To:     heiko@sntech.de
Cc:     jagan@openedev.com, tom@radxa.com, kever.yang@rock-chips.com,
        Akash Gajjar <akash@openedev.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 1/2] arch: arm64: rockchip: add usb node for RK3308
Date:   Tue, 17 Dec 2019 13:27:14 +0530
Message-Id: <20191217075722.11646-2-akash@openedev.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191217075722.11646-1-akash@openedev.com>
References: <20191217075722.11646-1-akash@openedev.com>
X-OutGoing-Spam-Status: No, score=-0.5
X-Originating-IP: 68.65.123.203
X-SpamExperts-Domain: nctest.net
X-SpamExperts-Username: whmcalls3
Authentication-Results: registrar-servers.com; auth=pass (login) smtp.auth=whmcalls3@nctest.net
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0c2Pj46HODYmpAMVAv0J1pOpSDasLI4SayDByyq9LIhVkl0/6mQtv7IQ
 5XyI/N9/JkTNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3Kk502M/hntTzIKfCMISdhHQGg
 t7nAtP8WjkKKy9v/mXRkty7kshl0qfjNTiHz6D+lTs1OFZCJnqICuBP35KwNAmisedSHrV8USIJy
 ZKu4Q0eBPJf4fBJswECxJoMRbkC3SF2DuTVJlHUR2BtY80W8dG60QfvEMzMeJ6Rw9B2oZpcFefeT
 nKVTea+Z7pU/97kaMRINxtYvoDPmxBEirO18GFgbEtxGbfWvsckv3Tqu01KJGGjsNnBvKhksFPgp
 Ju7VRAUaZyvXYsGqun+gsnRrw40vpN++k/mRssszRiW/L+aVL5CXNSk/AzmiJysF8dLHRyryw85/
 rAZb27+VZ3biGtaW8qQvbDNe5IP3ZP124DrwHHYNWMFQ3rxmq0HUMfG+c6Hob6r/eV86ndcww4rw
 I1KDXPI3WaJIMv23OVswOmanvHgTJm4rUod0ueKDsCR8lJjuWToZaiaFIvhnz77Y+k6uhs/Q2KE1
 Lby4XA9T8Bmj3saNZ0eUp3kqVmG1d7Vk62I39gyxRzRbm/p7lH0AcjkjHv8L1XCo8f/lClCdnQEw
 egH725V8o9NmtwsOgq00IT3zX/Zzh6cpDYUl6c6Y0/5r1yWIc3jXLVN/s8cHerYtW55yLfDen/wr
 oS11FXNac8XwfSk5a6wPi3PS+6vBhpISIqK1GdyQE0WyMBODOy30v1Op0AWqhD2stjbU32pojN4X
 8zAZfIZ8CjT9GInTMPN38Uyq3PQ8yDScr+8662B3D4UT/bdQYZMqtJwVgGaPV8GdcLPofFI165s+
 Fi8oQNCwxvxuh+xtfMocbqMn/Qow8uvbAccZ4WWjZTIX9MhLKTjECb0PwpN4olPuA0AI93gbcx8Z
 jKXXCSz+ofgapDj5Myrxgk8zlzkZR8hg4/tjCwvQy21RlJtzRtySOaj2KCrPuddk5deGGf9NlAkc
 UjHoLHmfXm3j/a1RIl7l4OMYRnxfIvD0xWRSasqqxNnWfwc3A8r6JfNzxEm+Adh5Il9bsJFhaqar
 dOLrAnCsmfJ3HSl/Lt1pDXWpU9yav05pkpLqd/jLmlb2xnK8kGSBOf+0oVhjP8JfMDDGeyVJfXrM
 Z3+qi/5h4DZCfPGWm7MoPBOavov9A2tPRpxsJ/Ez2OT1H/aAwarQpYDOYx/6JtUOkfNK1xk8kTd1
 Ny+HuiOkN2mAdCO+RVfxIo7mcAZ9GMPEl9B+0hmmdOnbSMz7Y9ZIgfFrL3927nPLXidUYhzTL/6b
 zJY8ZLbVls9GTjTyP2j0DLjHCOlbYrvqvTn3lmAWHSgj8REt1LPAYpi/k8cuog==
X-Report-Abuse-To: spam@se16.registrar-servers.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ehci/ochi usb node support for the RK3308 soc.

Signed-off-by: Akash Gajjar <akash@openedev.com>
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 49 ++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index 8bdc66c62975..4e51362b5373 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -243,6 +243,33 @@
 		status = "disabled";
 	};
 
+	usb2phy_grf: syscon@ff008000 {
+		compatible = "rockchip,rk3308-usb2phy-grf", "syscon",
+			"simple-mfd";
+		reg = <0x0 0xff008000 0x0 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		u2phy: usb2-phy@100 {
+			compatible = "rockchip,rk3308-usb2phy";
+			reg = <0x100 0x10>;
+			clocks = <&cru SCLK_USBPHY_REF>;
+			clock-names = "phyclk";
+			#clock-cells = <0>;
+			assigned-clocks = <&cru USB480M>;
+			assigned-clock-parents = <&u2phy>;
+			clock-output-names = "usb480m_phy";
+			status = "disabled";
+
+			u2phy_host: host-port {
+				#phy-cells = <0>;
+				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "linestate";
+				status = "disabled";
+			};
+		};
+	};
+
 	wdt: watchdog@ff080000 {
 		compatible = "snps,dw-wdt";
 		reg = <0x0 0xff080000 0x0 0x100>;
@@ -584,6 +611,28 @@
 		status = "disabled";
 	};
 
+	usb_host_ehci: usb@ff440000 {
+		compatible = "generic-ehci";
+		reg = <0x0 0xff440000 0x0 0x10000>;
+		interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST>, <&cru HCLK_HOST_ARB>, <&u2phy>;
+		clock-names = "usbhost", "arbiter", "utmi";
+		phys = <&u2phy_host>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
+	usb_host_ohci: usb@ff450000 {
+		compatible = "generic-ohci";
+		reg = <0x0 0xff450000 0x0 0x10000>;
+		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST>, <&cru HCLK_HOST_ARB>, <&u2phy>;
+		clock-names = "usbhost", "arbiter", "utmi";
+		phys = <&u2phy_host>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
 	sdmmc: dwmmc@ff480000 {
 		compatible = "rockchip,rk3308-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff480000 0x0 0x4000>;
-- 
2.17.1

