Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F940C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383472467E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgAFUrn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:47:43 -0500
Received: from mail-oln040092067093.outbound.protection.outlook.com ([40.92.67.93]:31069
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726701AbgAFUrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:47:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lheXsPWq7kAlO/cjlAzZEMkq8zaZ3SB3qZ/E3BqFolr38XlR1W8fBvFk9lPo2N/ugmiszuOm/ZTcYGOOAK6wLwDo87ZfGg5HlRGj5IBxNt8bqARQ/rAKHvaboJRjdenezdxmIO/zfbS0ciDcFqz4+z34G0aARNCkWxORMDZB6cbXfMCg/iVLNnp1hS8/irrkZtZGFHDaDgS74L55s8XsKTR3wMqlN1JU24TGeYLhkbBr0DroMxBN5eyj6TsjnN1El6KkPzxCZ+G3nmJJ4pQ58IkIl1dSlxPr960kS+PIjIuyKzfztjpMR6iULtYCg9QU850ffBivBmSFJc5MV2K6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzeqoTb7HrC2D++Zrc9X4kgWRYmyf+QsmJUCm5n6/cc=;
 b=VodbKgw8Or8GJX8uvw7GlIfN+ikqV7qaqjVhyjFr9GHAAwGJ9T/52i+vPJZ4PzIypPHZPRLXvFNpF8pwGZ71sDS8FX5ngivzTJmwkTiGJwVVzDInBy9BZs7Q2ag5m5RBNj1UD+FA33m3sLOIVMW7QRLbHcYNy6OJQt4SBZUkw8V7v3Y8WNsREy/3UknidPQG1wgG0/5E61nJYPmJVPeL85XmFglp9S1aFBgc1gk3pSIZQfLkJ86ToZjCSYaydIG8FLQIzwYaUw3LA+hdowbUPgngAWIK5xHA47+0fPRiMDOblrfZIuulgtKX5lIh6cAKKeetSY5FCSAKTx4vMhoXBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VE1EUR02FT060.eop-EUR02.prod.protection.outlook.com
 (10.152.12.55) by VE1EUR02HT216.eop-EUR02.prod.protection.outlook.com
 (10.152.13.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Mon, 6 Jan
 2020 20:47:38 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com (10.152.12.60) by
 VE1EUR02FT060.mail.protection.outlook.com (10.152.13.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Mon, 6 Jan 2020 20:47:38 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::b957:6908:9f62:c28b]) by HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::b957:6908:9f62:c28b%5]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 20:47:38 +0000
Received: from bionic.localdomain (98.128.173.80) by AM6P195CA0080.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:86::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.10 via Frontend Transport; Mon, 6 Jan 2020 20:47:37 +0000
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
Subject: [PATCH 01/15] phy/rockchip: inno-hdmi: use correct vco_div_5 macro on
 rk3328
Thread-Topic: [PATCH 01/15] phy/rockchip: inno-hdmi: use correct vco_div_5
 macro on rk3328
Thread-Index: AQHVxNKIFXnraCQbrkqwiVZY6H3oBw==
Date:   Mon, 6 Jan 2020 20:47:38 +0000
Message-ID: <HE1PR06MB401135F38CD28AD4BB12EEF7AC3C0@HE1PR06MB4011.eurprd06.prod.outlook.com>
References: <HE1PR06MB4011254424EDB4485617513CAC3C0@HE1PR06MB4011.eurprd06.prod.outlook.com>
In-Reply-To: <HE1PR06MB4011254424EDB4485617513CAC3C0@HE1PR06MB4011.eurprd06.prod.outlook.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P195CA0080.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:86::21) To HE1PR06MB4011.eurprd06.prod.outlook.com
 (2603:10a6:7:9c::32)
x-incomingtopheadermarker: OriginalChecksum:6F6DD20A0899AA729E98995BB36C89DE524FC4527F2FC37850CC72F0910B7041;UpperCasedChecksum:24501F4B5DB11B04EC99F511E91E7A4B56EF762341DC9417E6D0AA5F2789EBD1;SizeAsReceived:8201;Count:51
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [QWM3uovSw7zSNZ/TgRg8ckuZ0nZtU6XZ]
x-microsoft-original-message-id: <20200106204723.5889-1-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 51
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 9be13562-dda8-48c5-da52-08d792e9aa8e
x-ms-traffictypediagnostic: VE1EUR02HT216:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YO8OQP69R8HUHUZ8pknMWNTCHlInutCsmL8Is8Aa3Yd5UwaUkNBCamLAMfoWjyFaKUIigXJjk78yboeyPizrqNOj4Q0o4ZUK3YT/m/qUQ6NXFB/jVJZrZclUVkJNilTlLVPQmCg4P7soSFMvWBaNcpSefLasT0vbvFasuChyygAuXnUcKzT7tCxXPFVmw35d
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be13562-dda8-48c5-da52-08d792e9aa8e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 20:47:38.6546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR02HT216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inno_hdmi_phy_rk3328_clk_set_rate() is using the RK3228 macro
when configuring vco_div_5 on RK3328.

Fix this by using correct vco_div_5 macro for RK3328.

Fixes: 53706a116863 ("phy: add Rockchip Innosilicon hdmi phy")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
index 9ca20c947283..b0ac1d3ee390 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
@@ -790,8 +790,8 @@ static int inno_hdmi_phy_rk3328_clk_set_rate(struct clk_hw *hw,
 			 RK3328_PRE_PLL_POWER_DOWN);
 
 	/* Configure pre-pll */
-	inno_update_bits(inno, 0xa0, RK3228_PCLK_VCO_DIV_5_MASK,
-			 RK3228_PCLK_VCO_DIV_5(cfg->vco_div_5_en));
+	inno_update_bits(inno, 0xa0, RK3328_PCLK_VCO_DIV_5_MASK,
+			 RK3328_PCLK_VCO_DIV_5(cfg->vco_div_5_en));
 	inno_write(inno, 0xa1, RK3328_PRE_PLL_PRE_DIV(cfg->prediv));
 
 	val = RK3328_SPREAD_SPECTRUM_MOD_DISABLE;
-- 
2.17.1

