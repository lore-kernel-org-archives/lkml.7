Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AF5C2D0D4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 08:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2013B206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 08:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfLWItY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 03:49:24 -0500
Received: from mail-vi1eur05olkn2031.outbound.protection.outlook.com ([40.92.90.31]:22401
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725905AbfLWItX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 03:49:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXnvOfvablAmxf+4uV85RCrowxcvtrrmUllw4yPOPq/hwp70RLh+83XfXxHNxU5/QiaK504mGskTCFxV6s2zujaBK+phOP9iy1AfdEKueijbApuDl1VTbye6pNvNiQ1FbhOQDhoPSX9T7FPwKZTjBLiF8TQ89RycoJF0wQC9uWpDTFIhbvgxK1ZDC+A36q6a6gTkL6UK0uP3XB7sa/13/qM3a4EHc3WrdYEDFyLXoMhIma2SJ77XhIbPgWSkdnTGpUJmMf8cU6rPnW6YvxlTmgDkJgUDqjSeRRWtLf4iy9xpPEyevC/JL9FVUr31mEoQftTCMhoVVnB1lm43fNqa7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggNN5hHqqS0M9a/BcgQlW6i8OVSrLyXQ/RZ7q96LmtI=;
 b=YzbWIrDLKeKqJ4H89LYr3gPEfkn5U461AS8aM/h18GnHu8eVAmF15rfA1oIVnREthdCnkIDLnVlbyZetRLdH0+ckMb+awSBOsIss4AblnyNB8J1NdbE/N22OQg004SZnA4vRIhq6s2pjggV93AnCvQfguAhVGCEFwv/t89oxomukMJhsOE42TpHw5SvxvDvCa73SBH38NQuwW70m45veoKEYyLEVTw0KgYoEZZlyq6QKcrjHABe5TIN+Kh+uYNfgzlOXYkkSiE5OXAhJwiMOw5bzdBdmSC4M8hA7sDIJBS/bZ2pvltJrt0lQdByHcxs3M/CwooHrYMrpH3bcMcEqSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VI1EUR05FT054.eop-eur05.prod.protection.outlook.com
 (10.233.242.58) by VI1EUR05HT106.eop-eur05.prod.protection.outlook.com
 (10.233.242.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14; Mon, 23 Dec
 2019 08:49:20 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com (10.233.242.51) by
 VI1EUR05FT054.mail.protection.outlook.com (10.233.242.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14 via Frontend Transport; Mon, 23 Dec 2019 08:49:19 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::b957:6908:9f62:c28b]) by HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::b957:6908:9f62:c28b%5]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 08:49:19 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Heiko Stuebner <heiko@sntech.de>
CC:     Jonas Karlman <jonas@kwiboo.se>,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH for 5.5] phy/rockchip: inno-hdmi: round clock rate down to
 closest 1000 Hz
Thread-Topic: [PATCH for 5.5] phy/rockchip: inno-hdmi: round clock rate down
 to closest 1000 Hz
Thread-Index: AQHVuW3dv4pef+0ne06IvIotxw0jCA==
Date:   Mon, 23 Dec 2019 08:49:19 +0000
Message-ID: <HE1PR06MB40118544456FC5461F49DDE8AC2E0@HE1PR06MB4011.eurprd06.prod.outlook.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P192CA0108.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::49) To HE1PR06MB4011.eurprd06.prod.outlook.com
 (2603:10a6:7:9c::32)
x-incomingtopheadermarker: OriginalChecksum:6C3EE6F5AD577A424FB4288D17BA7A3F48AD02ABDD3C1430651048F62472266F;UpperCasedChecksum:500C981098FB2F2D34FA996127DBECA1CE3F3CD3924556430468F49047C09246;SizeAsReceived:7595;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [qdWhVPRHQCXkaBlG15syyqeszHln1RBF]
x-microsoft-original-message-id: <20191223084905.13456-1-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: a0b0c36f-80a2-4e4d-07f9-08d78784ffa8
x-ms-traffictypediagnostic: VI1EUR05HT106:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gdltd54stm2KXiAN3WqUrtIAVGGOUTPQM4GPtnUUnAr1YejmqL30T6IbICh/1eVmE7QPKlIn4gUiV9Ekut2QPCXbMO3BSNez62KWxGA9/VZvfcoYBD9UKlRuAtwLUc8cGdyPhGuawemv5uLRy/SCPxuCprQsHl+3FZe5yVaidMaKjuIDuwWtffX8rE3oW6eK
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b0c36f-80a2-4e4d-07f9-08d78784ffa8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2019 08:49:19.9563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR05HT106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 287422a95fe2 ("drm/rockchip: Round up _before_ giving to the clock framework")
changed what rate clk_round_rate() is called with, an additional 999 Hz
added to the requsted mode clock. This has caused a regression on RK3328
and presumably also on RK3228 because the inno-hdmi-phy clock requires an
exact match of the requested rate in the pre pll config table.

When an exact match is not found the parent clock rate (24MHz) is returned
to the clk_round_rate() caller. This cause wrong pixel clock to be used and
result in no-signal when configuring a mode on RK3328.

Fix this by rounding the rate down to closest 1000 Hz in round_rate func,
this allows an exact match to be found in pre pll config table.

Fixes: 287422a95fe2 ("drm/rockchip: Round up _before_ giving to the clock framework")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
index 2b97fb1185a0..9ca20c947283 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
@@ -603,6 +603,8 @@ static long inno_hdmi_phy_rk3228_clk_round_rate(struct clk_hw *hw,
 {
 	const struct pre_pll_config *cfg = pre_pll_cfg_table;
 
+	rate = (rate / 1000) * 1000;
+
 	for (; cfg->pixclock != 0; cfg++)
 		if (cfg->pixclock == rate && !cfg->fracdiv)
 			break;
@@ -755,6 +757,8 @@ static long inno_hdmi_phy_rk3328_clk_round_rate(struct clk_hw *hw,
 {
 	const struct pre_pll_config *cfg = pre_pll_cfg_table;
 
+	rate = (rate / 1000) * 1000;
+
 	for (; cfg->pixclock != 0; cfg++)
 		if (cfg->pixclock == rate)
 			break;
-- 
2.17.1

