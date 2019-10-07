Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598BEECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9E42070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfJGTTv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:19:51 -0400
Received: from mail-oln040092068093.outbound.protection.outlook.com ([40.92.68.93]:34860
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728187AbfJGTTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:19:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjmgCzaUG9jSZiWnOSiBV+xmIavg/NkJXNSJ37qSk3knVCu4kwQsun2NABwF2OGJ3FOLybnKhCaDWXXtRd/CZwP79+VGS5nd4DKNVo0uzpjJIvXz8+EadKjkvypwcAyPcaNSA5AS0GbjVjRnotc0ruSY/VgTM5q9TRbABBZ3l7znqVVp6vCYTSUQyL+FrgtXE459rfddjxr1CT/n6gVt7U9JWn/PjOc8Jvzd0b7+ENatOxWdcpsWONz4n58hwXbR0gqSpyGK7ny0xCwR19ncjZxKQ0ZaEcPpAluJR8UJNKRPk4bEvcX87wyHWPSTHpoItNk1wT6vHq4qcC+ZeRqlIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLEu1xc3P3RKdxFXu+vKgEYK/PW5YgadoJmbGU1SOvE=;
 b=DmJJ+SpxGxhmeO27XYZvhkRZRBoCVTcxHFxeTuUstDsE9s0fi11QkWf8i+7xZSwRez0ZAAE/EOewpAiiwJMW1wprziV/O5LPEGUgmpub7lG+52LpNWjtotMuvwZ1kapSmFZUkfSMO+v5HPuY7Og6szPy1jAoYDVNdLYGw625o1tgRN8XjZT3VITHUqMIG7m04rbTgnwN/Phqtv+LHfxzDe+Jnbn24c01F4glId0U5/6ERTGwzZgc0W4B4+5GePD0n8KUJUiOTEIBPOvCQUdPiRaWOS9IDy7n3tiLPmRlgx7fckhfcYaZ7M7EJYk7liTkyG42uV/3ZG4nM/G5HBscgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM5EUR02FT039.eop-EUR02.prod.protection.outlook.com
 (10.152.8.57) by AM5EUR02HT213.eop-EUR02.prod.protection.outlook.com
 (10.152.9.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2327.20; Mon, 7 Oct
 2019 19:19:47 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com (10.152.8.55) by
 AM5EUR02FT039.mail.protection.outlook.com (10.152.9.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.20 via Frontend Transport; Mon, 7 Oct 2019 19:19:47 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::5c5a:1160:a2e0:43d8]) by HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::5c5a:1160:a2e0:43d8%4]) with mapi id 15.20.2305.023; Mon, 7 Oct 2019
 19:19:47 +0000
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
Subject: [PATCH v2 0/4] drm/bridge: dw-hdmi: Add support for HDR metadata
Thread-Topic: [PATCH v2 0/4] drm/bridge: dw-hdmi: Add support for HDR metadata
Thread-Index: AQHVfUQurFQBzCU6+EuK40TBL0GPJw==
Date:   Mon, 7 Oct 2019 19:19:47 +0000
Message-ID: <HE1PR06MB401113BF395C06E96503344FAC9B0@HE1PR06MB4011.eurprd06.prod.outlook.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0334.eurprd05.prod.outlook.com
 (2603:10a6:7:92::29) To HE1PR06MB4011.eurprd06.prod.outlook.com
 (2603:10a6:7:9c::32)
x-incomingtopheadermarker: OriginalChecksum:4CBAF161DB2D60BAC2CD9CF55CE156D41B210AF0B530EBD8D2D5913312D2F003;UpperCasedChecksum:4D66C1F43DF28FDD1B8F0104EBD516A1F69A8FB08B341AA2DC8F309BEB042DAD;SizeAsReceived:7861;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [67XXOCwNI9MGz6/R2TSwEOErznrlI/wG]
x-microsoft-original-message-id: <20191007191930.4471-1-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: AM5EUR02HT213:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9KjcubaKobG3SOMZc9cr0ZbZnrDafEWbqkCuVYPGtQQ8goPvm79jRbBpFlGQ/xCJtx3mMzRqLikg3gZDz/HxXpdYouEQdosP93sLox+iEEak49zGsstSlQWmHLVe3Ny44aV6ujNMudiH10Fdj/9wBOCDmMVGmh4pUQpT7bLuYQZm/UaZWRJE9qPwrVnCE8T2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: be8b4149-eb69-473c-9c54-08d74b5b5134
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 19:19:47.6242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for HDR metadata using the hdr_output_metadata connector property,
configure Dynamic Range and Mastering InfoFrame accordingly.

A use_drm_infoframe flag is added to dw_hdmi_plat_data that platform drivers
can use to signal when Dynamic Range and Mastering infoframes is supported.
This flag is needed because Amlogic GXBB and GXL report same DW-HDMI version,
and only GXL support DRM InfoFrame.

The first patch add functionality to configure DRM InfoFrame based on the
hdr_output_metadata connector property.

The remaining patches sets the use_drm_infoframe flag on some SoCs supporting
Dynamic Range and Mastering InfoFrame.

v2 has been runtime tested on a Rock64 (RK3328) and Rock Pi 4 (RK3399),
only build tested for Amlogic and Allwinner.

Changes in v2:
  * address comments from Andrzej Hajda
  - renamed blob_equal to hdr_metadata_equal
  - renamed drm_infoframe flag to use_drm_infoframe
  - use hdmi_drm_infoframe_pack and a loop to write regs
  - remove hdmi version check in hdmi_config_drm_infoframe

Jonas Karlman (4):
  drm/bridge: dw-hdmi: Add Dynamic Range and Mastering InfoFrame support
  drm/rockchip: Enable DRM InfoFrame support on RK3328 and RK3399
  drm/meson: Enable DRM InfoFrame support on GXL, GXM and G12A
  drm/sun4i: Enable DRM InfoFrame support on H6

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c   | 81 +++++++++++++++++++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.h   | 37 ++++++++++
 drivers/gpu/drm/meson/meson_dw_hdmi.c       |  5 ++
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c |  2 +
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c       |  2 +
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h       |  1 +
 include/drm/bridge/dw_hdmi.h                |  1 +
 7 files changed, 129 insertions(+)

-- 
2.17.1

