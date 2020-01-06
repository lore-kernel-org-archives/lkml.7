Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FF6C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FDC24676
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgAFUte convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:49:34 -0500
Received: from mail-oln040092070047.outbound.protection.outlook.com ([40.92.70.47]:59278
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727196AbgAFUtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:49:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRKdRIJ6gxJO5kKz3DeJRzLm4h47Mfqeh0fYXDn6P1BQr3Saa6M9tu+LXtQNhuT3sorU1l3WpE6nRlLMthIMfmNIOYE+xCs/y5gxvtCCO6VIaNA43rT+hYDNk7GlG5+YDHHN4ZkSHkLmgfiNESJ9jX7cLVRJ2kqol4AgXgdNLBJNOZ/tur/V3vPgPqP6NVTRlCgM6Hkx4jz/EmsmiM8rv2e1nJlqR26uxMDPzyU7f/7TCSUL5QGkHPCh2I9Bp4w9ZQtoUbeWTvDPrAxbXZEI4iDwaP4XTUjA0h+dmeKaYeMaLxHHlO9Ux0s0Fm/vpO9txgSNGoJ2Khyx7BAS+LWLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+YdaZYtdFVyeVuI/irLI8X5/pacT8Cd9YWrdrOdJRA=;
 b=WO8pIgfKpy/CKoCiXR2MhN75jS3xjIXrXCwuDknoNLzHpI5k/IOrRXl/e1Y8Ykeo99qT4bZ02/AkWx7BqD3BVMx21JweJc9KglQ0VQSgotCZlWxdhzdEq7oyKqqL57mEj8BLvCKOVEvpVCx1IFQGRJQ/E2EAvL9qBKG1bWMpJkj0RQp2AHlC+1GsDG2t2qN0MFBFFovOqQrJWN+DFZ8Pi5d//JG3Px/WscdWZ68a2RmDIPTErwLFQL3TlPqumyIRLhBSMKvgnna/Ij1MMdRqdfc99RMAJw8/NJBt8E7AVkqPDjQYn5C3abl2rED3TvODMTjyh6PtfOeoUE9yEIxzzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VE1EUR03FT047.eop-EUR03.prod.protection.outlook.com
 (10.152.18.58) by VE1EUR03HT118.eop-EUR03.prod.protection.outlook.com
 (10.152.19.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Mon, 6 Jan
 2020 20:49:29 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com (10.152.18.51) by
 VE1EUR03FT047.mail.protection.outlook.com (10.152.19.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Mon, 6 Jan 2020 20:49:29 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::b957:6908:9f62:c28b]) by HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::b957:6908:9f62:c28b%5]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 20:49:29 +0000
Received: from bionic.localdomain (98.128.173.80) by AM6PR0202CA0044.eurprd02.prod.outlook.com (2603:10a6:20b:3a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend Transport; Mon, 6 Jan 2020 20:49:27 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>
CC:     Jonas Karlman <jonas@kwiboo.se>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Zheng Yang <zhengyang@rock-chips.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 12/15] ARM: dts: rockchip: add vpll clock to hdmi node on
 rk3228
Thread-Topic: [PATCH 12/15] ARM: dts: rockchip: add vpll clock to hdmi node on
 rk3228
Thread-Index: AQHVxNLKqcAXKFIB4kWzhI86odn8Gw==
Date:   Mon, 6 Jan 2020 20:49:28 +0000
Message-ID: <HE1PR06MB4011C04CC6107E2EC0696E91AC3C0@HE1PR06MB4011.eurprd06.prod.outlook.com>
References: <HE1PR06MB4011254424EDB4485617513CAC3C0@HE1PR06MB4011.eurprd06.prod.outlook.com>
 <20200106204914.6001-1-jonas@kwiboo.se>
In-Reply-To: <20200106204914.6001-1-jonas@kwiboo.se>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0202CA0044.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::21) To HE1PR06MB4011.eurprd06.prod.outlook.com
 (2603:10a6:7:9c::32)
x-incomingtopheadermarker: OriginalChecksum:744B46965BCEC379E2768CE590DA8F2BD04A59661322E3C38B4DDC1953E2F1FA;UpperCasedChecksum:BD049B6A67A2EDA589E51468867EEF4B53B8412CC05382C0EE0F26BF9C4E9C9A;SizeAsReceived:8196;Count:51
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [91rEW8ftuDEtVolZA6ZRrwLISVymYVXb]
x-microsoft-original-message-id: <20200106204914.6001-4-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 51
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: aa573841-4b63-4a62-49fa-08d792e9ebe4
x-ms-traffictypediagnostic: VE1EUR03HT118:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6nes0s1inIS4W/WJRmR6cUvZVGQ2CvMOmYdo71F6kJvQ4/4dsfr0+peZBArDThdC/oNrdH6HNraHktLZrBHrtUzaXWPm6qH9PfYeBFe+0XiJZLwr9z3SJuNXGTd+auGwuamrDBLdIhcP1peUazKGyuqLgXwlt+tEoEKUBnyZyrh6ze9L+Qf9eW3rhqu8UwB2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: aa573841-4b63-4a62-49fa-08d792e9ebe4
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 20:49:29.0420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the hdmiphy clock as the vpll in hdmi node.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/boot/dts/rk322x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 340ed6ccb08f..16ad240d5f7f 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -639,8 +639,8 @@
 		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 		assigned-clocks = <&cru SCLK_HDMI_PHY>;
 		assigned-clock-parents = <&hdmi_phy>;
-		clocks = <&cru SCLK_HDMI_HDCP>, <&cru PCLK_HDMI_CTRL>, <&cru SCLK_HDMI_CEC>;
-		clock-names = "isfr", "iahb", "cec";
+		clocks = <&cru SCLK_HDMI_HDCP>, <&cru PCLK_HDMI_CTRL>, <&hdmi_phy>, <&cru SCLK_HDMI_CEC>;
+		clock-names = "isfr", "iahb", "vpll", "cec";
 		pinctrl-names = "default";
 		pinctrl-0 = <&hdmii2c_xfer &hdmi_hpd &hdmi_cec>;
 		resets = <&cru SRST_HDMI_P>;
-- 
2.17.1

