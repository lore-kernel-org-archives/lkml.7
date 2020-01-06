Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E5CC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E357824689
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgAFUsc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:48:32 -0500
Received: from mail-oln040092067015.outbound.protection.outlook.com ([40.92.67.15]:64539
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726683AbgAFUsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:48:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEgQNIIiKleJSe7ycBQ5wtEeI5esJbqqczYmvUpnGpkqoyK2WRSTo/j2RprUAeEaDYqsqNgBWUvbwd8VUiI2ZlR7SIVDnBBqQzwdAV6XiHpRdUxnl2034JdjVyk0iFSmc++CHCeoXt2QcneDoGfWKbDSE0i4Z7gbPQBdpmGq+8HgkPkw1U5l4hDeCVaO06KBVawgmXoLt7Kt6bg9gPZ04a2NgyBSBOtYO10N3phN3PIfC9DtcWwv+PulMqNo9M/737NxSapUiBqm0arlGSfZnxustCgJYGpolYgWw4qV4e/jCBSN8N4lUyh67NDtQ/BhLEKSKEKuHcQWWdg6bwdv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bz7zdJ2g6Cfathp4V9IAfu7oi4sCymZHFj3PJ7xFMH0=;
 b=JC9+EdPoRmaVhpelLHtIs+9F9C4mYwDADeqLTMDpAkvQownOILei0L45aqo8IxT8OmWTrvEuWdOrlG/ywa04j4a0g763pNsmke6YrTMLrJA02qmBbTtg1s6/+LGtRGTEZ6t1RUHuZS1M6vRT0Kx6lVlDfS+W0ua5MGDPzFz+johxHWrBtXQ/26n5AQV7nETj0mnJmPzO24YKQVz7I+v8AooseIBZOaYIxNMWOkiWmPUZolxxKSh84AxiGQegr4VHMr74ISpP3sw0CpCxisj03kfFFlgkmt9jUZHKPzgRNmswtbCDnHPrEPcCIXG4+2hOcNYj1XzDozPF57Iolct0WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VE1EUR02FT060.eop-EUR02.prod.protection.outlook.com
 (10.152.12.52) by VE1EUR02HT104.eop-EUR02.prod.protection.outlook.com
 (10.152.13.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Mon, 6 Jan
 2020 20:48:27 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com (10.152.12.60) by
 VE1EUR02FT060.mail.protection.outlook.com (10.152.13.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Mon, 6 Jan 2020 20:48:27 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::b957:6908:9f62:c28b]) by HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::b957:6908:9f62:c28b%5]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 20:48:27 +0000
Received: from bionic.localdomain (98.128.173.80) by BEXP281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend Transport; Mon, 6 Jan 2020 20:48:25 +0000
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
Subject: [PATCH 07/15] drm/rockchip: dw-hdmi: allow high tmds bit rates
Thread-Topic: [PATCH 07/15] drm/rockchip: dw-hdmi: allow high tmds bit rates
Thread-Index: AQHVxNKkeAgLW4fg0km1/R3lpurfaA==
Date:   Mon, 6 Jan 2020 20:48:26 +0000
Message-ID: <HE1PR06MB40112CF884D970B0E7C45969AC3C0@HE1PR06MB4011.eurprd06.prod.outlook.com>
References: <HE1PR06MB4011254424EDB4485617513CAC3C0@HE1PR06MB4011.eurprd06.prod.outlook.com>
 <20200106204812.5944-1-jonas@kwiboo.se>
In-Reply-To: <20200106204812.5944-1-jonas@kwiboo.se>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BEXP281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::14)
 To HE1PR06MB4011.eurprd06.prod.outlook.com (2603:10a6:7:9c::32)
x-incomingtopheadermarker: OriginalChecksum:FB902BBF3D2881926EE816FD8F36B41BB7B4B3D3C372D2E3186D2AAC316EF4B3;UpperCasedChecksum:8225127E07E57F9F417102B355F26304ACF9103D9125A3696E54680E84951F4F;SizeAsReceived:8151;Count:51
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [vVoqW0qdInTAr9onLaiti0enbf81W7Sz]
x-microsoft-original-message-id: <20200106204812.5944-3-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 51
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: cb547982-72c6-4a2b-5c13-08d792e9c6ec
x-ms-traffictypediagnostic: VE1EUR02HT104:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jv8BpL8GmG2vSPWBeXwI6le1sFoYUtbMuPgTC5yI+BAiYFgLBlXK4lvcbZ2MoAv6CqTwrmCYulkh6ZVde1mDt7ehVOuu1hVtGjwj309TNNMuvzBCed6K6bNuie0UbVVBayFHuzCwLQJcZyPQfeZ/Yq4sM0zDom7JcX0emZIG3z91vHg+eoYCkJCkNGXYpVKp
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: cb547982-72c6-4a2b-5c13-08d792e9c6ec
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 20:48:27.0311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR02HT104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare support for High TMDS Bit Rates used by HDMI2.0 display modes.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 7f56d8c3491d..fae38b323a0c 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -318,6 +318,8 @@ static int dw_hdmi_rockchip_genphy_init(struct dw_hdmi *dw_hdmi, void *data,
 {
 	struct rockchip_hdmi *hdmi = (struct rockchip_hdmi *)data;
 
+	dw_hdmi_set_high_tmds_clock_ratio(dw_hdmi);
+
 	return phy_power_on(hdmi->phy);
 }
 
-- 
2.17.1

