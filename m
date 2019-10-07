Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6BDC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9557E2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfJGTVw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:21:52 -0400
Received: from mail-oln040092067037.outbound.protection.outlook.com ([40.92.67.37]:34791
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729119AbfJGTVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:21:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnoD+86XFqVf4Yy/M/EJPHUCCP9/h1kPqs7mkxQfblqYKAl7ZxAq6iYdBNUF6L9fW/zoonhVBUd7I8mlXRLPvZiOYX35Q6yLFoZYOT698opg6Rv3IxXetXRw5azS6xp2oKAU2zT0C987am0ugrih9XQ0zsKv1sHykI50dhJLfb4i6i9mwmKup+LXkltKJp/wHeU5ypakbNNKQ2dczYDQLIdyd9S9rCr1M3vQCUGge5dLSL633ZMMQ5WZJDEjpaI8KW1MBR76w76EPggop8zvfRJ2G8Qgk0rJQGqVpaDuC91Dj6rFSjc10JxjIQzSuA+HiS3io/oqY9Xn4AejokOVUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnXj0bICwjFFFTZYWcocvCHmrP5bwb9fqSgT6TUAkSk=;
 b=G0mSLlJ4/zhOVgF5Mt8hiLPmfvUQIxekmc073k5om7Fvu3o8Ea6FfQ98cgNKq0HKh6bi4wMRKbXnM9Nd+rxuhwAjPDh78aZyZJfuXltztlSQbQ/7RMFegzAn5QjaMIadJLfVm/QXs3ryRybDM8RTzG2QWd74x6lafe34QPZrYV0J5GpLjzJuzp2c4Fuy20+QnZAAgv12HaVkguIB5pmynNCpho1JxWJxa6QKCT+teR4v0ogSVXMmEQGqpqfynbsOmMt8+WY86u/rGyuZskDj0uAPa2Itu7o0FhF0VnRKNG++2mb17FkjGw53+fL9w/EZsDv7l3QCdRTZlQ8t6KIjDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM5EUR02FT039.eop-EUR02.prod.protection.outlook.com
 (10.152.8.53) by AM5EUR02HT237.eop-EUR02.prod.protection.outlook.com
 (10.152.8.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.20; Mon, 7 Oct
 2019 19:21:49 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com (10.152.8.55) by
 AM5EUR02FT039.mail.protection.outlook.com (10.152.9.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.20 via Frontend Transport; Mon, 7 Oct 2019 19:21:49 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::5c5a:1160:a2e0:43d8]) by HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::5c5a:1160:a2e0:43d8%4]) with mapi id 15.20.2305.023; Mon, 7 Oct 2019
 19:21:49 +0000
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
Subject: [PATCH v2 2/4] drm/rockchip: Enable DRM InfoFrame support on RK3328
 and RK3399
Thread-Topic: [PATCH v2 2/4] drm/rockchip: Enable DRM InfoFrame support on
 RK3328 and RK3399
Thread-Index: AQHVfUR3JXY5xQIOykGs74DZOna4XQ==
Date:   Mon, 7 Oct 2019 19:21:49 +0000
Message-ID: <HE1PR06MB4011C9579CA6BBCD96C87810AC9B0@HE1PR06MB4011.eurprd06.prod.outlook.com>
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
x-incomingtopheadermarker: OriginalChecksum:5B4191A7D513587D91584953D25E71089F789E8C9B84D3AB94C404A59F6E4FB4;UpperCasedChecksum:4C7E7BF373A2D39586CBA1A8B452FB28FAB477C199FA7A95DEEC584251568002;SizeAsReceived:8097;Count:51
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [Ik4UVVWh8enDFLkh6mvDKU4vxxATQVVJ]
x-microsoft-original-message-id: <20191007192135.4525-2-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 51
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: AM5EUR02HT237:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ow4zPY79ymRpJptUu+nFn5y3wmL2LexQoFASdvU3V/4aIMrRTA0IXM+lrIg+RffJe0L0bJ36SsYVwus3gMIuk35CkEo+QDS7i/0pG/4gMI5WizynHOc5GuldcQmkgUw0TNe628UkgeQUsfbuPj03sfS9n61mgxYbKLgpYLW4h0OSqwVU1C3PRGwyhBQ6Njmx
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 46408731-acc1-47b7-c856-08d74b5b99e1
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 19:21:49.5660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables Dynamic Range and Mastering InfoFrame on RK3328 and RK3399.

Cc: Sandy Huang <hjc@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 906891b03a38..7f56d8c3491d 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -450,6 +450,7 @@ static const struct dw_hdmi_plat_data rk3328_hdmi_drv_data = {
 	.phy_ops = &rk3328_hdmi_phy_ops,
 	.phy_name = "inno_dw_hdmi_phy2",
 	.phy_force_vendor = true,
+	.use_drm_infoframe = true,
 };
 
 static struct rockchip_hdmi_chip_data rk3399_chip_data = {
@@ -464,6 +465,7 @@ static const struct dw_hdmi_plat_data rk3399_hdmi_drv_data = {
 	.cur_ctr    = rockchip_cur_ctr,
 	.phy_config = rockchip_phy_config,
 	.phy_data = &rk3399_chip_data,
+	.use_drm_infoframe = true,
 };
 
 static const struct of_device_id dw_hdmi_rockchip_dt_ids[] = {
-- 
2.17.1

