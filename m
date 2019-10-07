Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC64DECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7972070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbfJGTWI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:22:08 -0400
Received: from mail-oln040092067037.outbound.protection.outlook.com ([40.92.67.37]:34791
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729134AbfJGTVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:21:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xs4KXq4b8XdBdUDOdF4XHoKkdFvwlliggUhL95TdT3RA7l1mGiccUBp540tNhYSRLeBQ7Fl39konDQ6aETdNKsQde6vfxoY8WUVNM/PGp2Io1yFzuAOnl6HRqZHrPmJlqxJO/3ubJboZ66oTnBmEAnpJrqjY2gQQFCGKuoQaPjJd31N38oCiEXmc+9VgblGu2Q4mlHdXxqNz2r3fT/vI1DXYVGeXuLpoE8LzPbQf0FfLRqQjRm5QmlWTR5zavSGukQAP0rvZ3gq2sUDyLIFxzh58ESp84EIlAkCO2fp9bbTv8BXIFbmHq1z4icT3GXTtJpUwYXzvJlU1zVV+Ue+r6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLc8L5qQCi0pUmElDMGjHX2OonOIUPq279NDhdighZY=;
 b=F8dmQOosEWP2j3UQoya/DyJnAMrjY1pvZ2hJ7P4ZRESI3qIMUUe4dSZZDqxB7iW5TKAKWIzK+Ib0xupvlk84LhXPBHn5DV24xvuu2SZggifb9Gal9UtwoUojNy9KCNH/pCa2dI9UDOdpH4N1MLLE1/5iYP+I5f0yXXg4p/gM2FM4dKI0qaZ5eSty9jbI0vzZ0ZvOOh/QMrFHkh1y08iJr1QLP8jwSI+9L8wtb+2V5MoNp1k2GTLYAT6x0h2LS7U3hupGwqBs9akMc8mOkfrll14hYfBjYzSYsfXbyZO3CH/RbXcJeOhmdqqOKX48CV/WtMkBeWc3XcJ0doKnRCEhGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM5EUR02FT039.eop-EUR02.prod.protection.outlook.com
 (10.152.8.53) by AM5EUR02HT237.eop-EUR02.prod.protection.outlook.com
 (10.152.8.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.20; Mon, 7 Oct
 2019 19:21:50 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com (10.152.8.55) by
 AM5EUR02FT039.mail.protection.outlook.com (10.152.9.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.20 via Frontend Transport; Mon, 7 Oct 2019 19:21:50 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::5c5a:1160:a2e0:43d8]) by HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::5c5a:1160:a2e0:43d8%4]) with mapi id 15.20.2305.023; Mon, 7 Oct 2019
 19:21:50 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko Stubner <heiko@sntech.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "zhengyang@rock-chips.com" <zhengyang@rock-chips.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] drm/meson: Enable DRM InfoFrame support on GXL, GXM
 and G12A
Thread-Topic: [PATCH v2 3/4] drm/meson: Enable DRM InfoFrame support on GXL,
 GXM and G12A
Thread-Index: AQHVfUR4VXUsmRcTa0qRNMTEEkbniA==
Date:   Mon, 7 Oct 2019 19:21:50 +0000
Message-ID: <HE1PR06MB4011BB614A49253FD074BCCBAC9B0@HE1PR06MB4011.eurprd06.prod.outlook.com>
References: <HE1PR06MB401113BF395C06E96503344FAC9B0@HE1PR06MB4011.eurprd06.prod.outlook.com>
 <20191007192135.4525-1-jonas@kwiboo.se>
In-Reply-To: <20191007192135.4525-1-jonas@kwiboo.se>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::28) To HE1PR06MB4011.eurprd06.prod.outlook.com
 (2603:10a6:7:9c::32)
x-incomingtopheadermarker: OriginalChecksum:8897984F656CAFD5D019FF35F86727E7B16C96EB020469B996F045C8F555B2DD;UpperCasedChecksum:E5069E95D2C647470642CF3B56BE12BF0A7E9B2DC05CAAF1A22AF3A2456BD95B;SizeAsReceived:8107;Count:51
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [7dsOqHODkpSjBsJFfy5pzr072GXio++K]
x-microsoft-original-message-id: <20191007192135.4525-3-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 51
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: AM5EUR02HT237:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IvFVas48xPXWo/HMtHsEk6xoQjEgWzAppPfOttnymx76pYP54z5g0HmvvGfe4h72Twp1zEHYYP1bGqc9OiEgkAWcrOa50UATpU5B1gmiU78sWgUDHNWS9m8jfWpuPbJoHpmZYhokD8gQFQs6XBjkdLEKMlYxscYBn8u83J3cg/eGQUOWetfNkFk8R8lztVN6
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d77ad6c-e0df-4707-7194-08d74b5b9a5f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 19:21:50.5904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables Dynamic Range and Mastering InfoFrame on GXL, GXM and G12A.

Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 022286dc6ab2..3bb7ffe5fc39 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -977,6 +977,11 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	dw_plat_data->input_bus_format = MEDIA_BUS_FMT_YUV8_1X24;
 	dw_plat_data->input_bus_encoding = V4L2_YCBCR_ENC_709;
 
+	if (dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-gxl-dw-hdmi") ||
+	    dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-gxm-dw-hdmi") ||
+	    dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-g12a-dw-hdmi"))
+		dw_plat_data->use_drm_infoframe = true;
+
 	platform_set_drvdata(pdev, meson_dw_hdmi);
 
 	meson_dw_hdmi->hdmi = dw_hdmi_bind(pdev, encoder,
-- 
2.17.1

