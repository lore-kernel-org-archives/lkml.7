Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD300C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929362146E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgAFUtg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:49:36 -0500
Received: from mail-oln040092071081.outbound.protection.outlook.com ([40.92.71.81]:50634
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727190AbgAFUtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:49:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bT6TWdbHggoL6v3HiOFrUGk2yW/QopX4fQdqPYoRKmwSik0NpUBV4A0tVZbltJPQ4+w26tEyy5341sWnlkELYB8rz6ebCYuL9nRqwFEJVMS6FNL/RLCwGWwJUzJ/H1utlMTbV4P5GWUZLZCBC5KXuRJGE2ENaxGlafvk3Bn2CFRzzjJqa1ttWacoCNj0WcEf4AUvYFwis5iBEEceT+XUCfKW1ejEx5pqLwlAhgVtdESrEZPXCbOuKVe70QIAjFY2h2SuYR2Vt9QldxEgG7ynCAV/NRnqNTqb0KHdKSx4RrPaDGUm64BL38mq5D3je+u2wGFqJBGXD9o4LpQLsmDlDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlD+lb2+s5vXTOJcA+vSQmtgg7NBO70nuQiMUOUpq6o=;
 b=Ns8i4Tj0W9kOJrgQNqoYjI7ujD3Qq06MirwxRwtj0DBzQBlESEArUdpf/SCdX3sWyBtcZDSSRVv5nZ7iqDpUEOgNONIThW+peaEbJ/EL1ltzUtLmoIlKqLFB8QGpI0tSmnVRj+4JRVpNvSQ7pOH0iEb7+gy+TdvNXIW9PxzxW2hT+OnEodFQ/0V9Ef9vG9qBXnCOLzt754YDdFgkFijxN7ucLYVad0C1zn4SaXs5ts2DZUbOJcXL+V8Uo88XmTY2kRuEPZF9dabH/h6WlOWkI/qHC4weKXvT6taVzXFddKmYXrHT9w5jhG4XgRc2VlkGhl9HTUYgYxt5FFF+KJkHpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VE1EUR03FT047.eop-EUR03.prod.protection.outlook.com
 (10.152.18.55) by VE1EUR03HT083.eop-EUR03.prod.protection.outlook.com
 (10.152.19.4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Mon, 6 Jan
 2020 20:49:28 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com (10.152.18.51) by
 VE1EUR03FT047.mail.protection.outlook.com (10.152.19.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Mon, 6 Jan 2020 20:49:28 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::b957:6908:9f62:c28b]) by HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::b957:6908:9f62:c28b%5]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 20:49:28 +0000
Received: from bionic.localdomain (98.128.173.80) by AM6PR0202CA0044.eurprd02.prod.outlook.com (2603:10a6:20b:3a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend Transport; Mon, 6 Jan 2020 20:49:26 +0000
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
Subject: [PATCH 11/15] arm64: dts: rockchip: add vpll clock to hdmi node on
 rk3328
Thread-Topic: [PATCH 11/15] arm64: dts: rockchip: add vpll clock to hdmi node
 on rk3328
Thread-Index: AQHVxNLIPXNzMpgWYEWcgimerV+R7w==
Date:   Mon, 6 Jan 2020 20:49:27 +0000
Message-ID: <HE1PR06MB4011274027CCF289492C661BAC3C0@HE1PR06MB4011.eurprd06.prod.outlook.com>
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
x-incomingtopheadermarker: OriginalChecksum:15B49EAFB42C065ED6E3AB32E3E856C0A8DD973539FB6F293B42ADFE30C0DDDC;UpperCasedChecksum:C9D816159C03312FC3FEFD18F8EA332F9EEACA38F463C6EA0FBFE101FB34B1BB;SizeAsReceived:8200;Count:51
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [+7aKVEjOmhORr4ffoiIFenJVTwTVf4VR]
x-microsoft-original-message-id: <20200106204914.6001-3-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 51
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: c9b8dde1-fb81-4d4f-1e0c-08d792e9eb2f
x-ms-traffictypediagnostic: VE1EUR03HT083:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PaeeUe6BqnOZeDyZED2GyezvwNnfFHemdvhAVREp+c59UwXNKNG+QSnYhK5VULxNl0vawvKcE6UAklo2Gjomn1WJOpiFdSUesuyW+9RIecCAy4PSdI65jYha8DPCFvNAKu1mL0JI31KcPnvO/AKXfqGmjeN2WYNuglaDrEOUVel5XDBbRuuxf7+1XCmWg6+R
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b8dde1-fb81-4d4f-1e0c-08d792e9eb2f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 20:49:27.1610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the hdmiphy clock as the vpll in hdmi node.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index ee4b6170a9e6..987c04abb387 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -703,9 +703,11 @@
 			     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru PCLK_HDMI>,
 			 <&cru SCLK_HDMI_SFC>,
+			 <&hdmiphy>,
 			 <&cru SCLK_RTC32K>;
 		clock-names = "iahb",
 			      "isfr",
+			      "vpll",
 			      "cec";
 		phys = <&hdmiphy>;
 		phy-names = "hdmi";
-- 
2.17.1

