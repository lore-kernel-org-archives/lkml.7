Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9975FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F89218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=thinciit.onmicrosoft.com header.i=@thinciit.onmicrosoft.com header.b="Kbe3qpoy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbfDXOVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:21:51 -0400
Received: from rout2.hes.trendmicro.com ([54.67.38.140]:51665 "EHLO
        rout2.hes.trendmicro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbfDXOVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:21:50 -0400
X-Greylist: delayed 3539 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Apr 2019 10:21:49 EDT
Received: from 0.0.0.0_hes.trendmicro.com (unknown [10.64.10.65])
        by rout2.hes.trendmicro.com (Postfix) with SMTP id 8EC27EFC034;
        Wed, 24 Apr 2019 14:21:49 +0000 (UTC)
Received: from IND01-BO1-obe.outbound.protection.outlook.com (unknown [104.47.101.55])
        by relay1.hes.trendmicro.com (TrendMicro Hosted Email Security) with ESMTPS id 2F316142C0B5;
        Wed, 24 Apr 2019 14:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thinciit.onmicrosoft.com; s=selector1-thinci-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSwHz5rve35WG41Mz2OaqLjLAqNFp1GP2l3kfXM3f9s=;
 b=Kbe3qpoy4CqLypceIMa9Wdo4uhesWGOJavmCQ9nMJksBCEpXAU7vZqgaNJdlETFpO5Wtu9YD8tvTDC5yPXLZg35R5lsW8T2YE4AuNZEsVAjpwlmd4nblk52hjjJWSg0ox+lwxnZjxac3aHvjrFyXzVZig22y2FrTEVa68Qj7w9w=
Received: from MA1PR01MB3770.INDPRD01.PROD.OUTLOOK.COM (20.179.238.86) by
 MA1PR01MB3194.INDPRD01.PROD.OUTLOOK.COM (10.255.215.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Wed, 24 Apr 2019 14:21:40 +0000
Received: from MA1PR01MB3770.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f0fa:29f3:9933:7d7a]) by MA1PR01MB3770.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f0fa:29f3:9933:7d7a%3]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 14:21:40 +0000
From:   Matt Redfearn <matt.redfearn@thinci.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Philippe Cornu <philippe.cornu@st.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Matthew Redfearn <matthew.redfearn@thinci.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Archit Taneja <architt@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/bridge/synopsys: dsi: Wait for all active lanes to reach
 stop
Thread-Topic: [PATCH] drm/bridge/synopsys: dsi: Wait for all active lanes to
 reach stop
Thread-Index: AQHU+qkIdYdzVBhVUEOlClcEU/eg/w==
Date:   Wed, 24 Apr 2019 14:21:40 +0000
Message-ID: <20190424142124.25776-1-matt.redfearn@thinci.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6P193CA0016.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::26)
 To MA1PR01MB3770.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:7b::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=matthew.redfearn@thinci.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [87.242.198.86]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 820878b5-bf5f-426d-8f70-08d6c8c02b17
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MA1PR01MB3194;
x-ms-traffictypediagnostic: MA1PR01MB3194:
x-microsoft-antispam-prvs: <MA1PR01MB319466076B2EE9453B138B66F13C0@MA1PR01MB3194.INDPRD01.PROD.OUTLOOK.COM>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39850400004)(396003)(376002)(366004)(346002)(189003)(199004)(8676002)(316002)(2906002)(2616005)(486006)(476003)(66066001)(36756003)(81166006)(14454004)(81156014)(478600001)(6506007)(256004)(14444005)(386003)(26005)(68736007)(186003)(66946007)(73956011)(5660300002)(64756008)(66476007)(3846002)(6116002)(66556008)(50226002)(7416002)(66446008)(8936002)(102836004)(6512007)(71190400001)(1076003)(71200400001)(52116002)(97736004)(53936002)(4326008)(6436002)(25786009)(7736002)(305945005)(99286004)(6486002)(110136005)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:MA1PR01MB3194;H:MA1PR01MB3770.INDPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: thinci.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: P9/Z/7BlToXBmSSyaGlMKpoMexfsTEeGzN3mmlVkdzjZwQse3JedpISC/xkKTbCj3djho2xzgTuehokrBg6scn5RWMaZojfbchH1cwcd39RMamyoSzt1s88cwQrWCbUEGxpSdbpbzLoaFSpYyDqFy857nxmv+lyW44N33LGoJdXbx5X/zV4ahGssEzJuIO9Ya3mPlK2Iwwdw9ntmX7WyhJyhvBXJep2vOobcT4AO2mRRxd5x66N0FXXI3bVtMn7pc3OQnul61km16TmhwK6D5Gy7/k29iV1ibzPrE3lFwriYrGJlPmHc/pmitjfJt2BKCJR21rY0mGNhpNphEKcIVEo4D3wR+CAuj1LCDRYoB0kl+ItTLOtspMP1IVb5eAcQfPHcaQyx+Dv0pV+ncjDi5jmh25nEWIjheF0bWvGMZE4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: thinci.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820878b5-bf5f-426d-8f70-08d6c8c02b17
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 14:21:40.3535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PR01MB3194
X-TMASE-Version: StarCloud-1.3-8.2.1013-24572.000
X-TMASE-Result: 10--0.878200-4.000000
X-TMASE-MatchedRID: zgaLmhMzJJS+YICiYwDgGRz2MDiYujy5kKAa/khZ3iT7efdnqtsaEx9Y
        5WQrOqCXo5qw/iFKtvYBtjkcfRMmqe3NIrNSYNRXS3OTftLNfg36Vf9FxCgbYTb9TB28Ubki+lM
        TBggE22Hi8zVgXoAlttUfIakorPe9T6cNbCp0hFxqHXONfTwSQsRB0bsfrpPIcSqbxBgG0w7IRb
        WdBCMsjs4DJ3/ByS2DxxoQfEOw/34l5kC9tkv6slsiQ4mr4segZd0iQ4jvVcJYZuXuhxBJBzDh0
        5MOYuzrPK+rRaMT815cO9B/xExylnaERdAplYSnCe1QEhIfRoDrAQ1iKyyQ4g==
X-TM-Deliver-Signature: 42E5E377544E3B789E728AC624520790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Synopsys manual states that software should wait for all active
lanes to reach stop state (User manual section 3.1.5). Currently the
driver only waits for / checks that the clock lane is in stop state. Fix
this by waiting for the mask of PHY STATUS bits corresponding to the
active lanes to be set.

Signed-off-by: Matt Redfearn <matt.redfearn@thinci.com>

---

 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/dr=
m/bridge/synopsys/dw-mipi-dsi.c
index bd15c21a177..38e88071363 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -189,6 +189,10 @@
 #define DSI_PHY_TX_TRIGGERS		0xac
=20
 #define DSI_PHY_STATUS			0xb0
+#define PHY_STOP_STATE_LANE_3		BIT(11)
+#define PHY_STOP_STATE_LANE_2		BIT(9)
+#define PHY_STOP_STATE_LANE_1		BIT(7)
+#define PHY_STOP_STATE_LANE_0		BIT(4)
 #define PHY_STOP_STATE_CLK_LANE		BIT(2)
 #define PHY_LOCK			BIT(0)
=20
@@ -752,7 +756,7 @@ static void dw_mipi_dsi_dphy_init(struct dw_mipi_dsi *d=
si)
=20
 static void dw_mipi_dsi_dphy_enable(struct dw_mipi_dsi *dsi)
 {
-	u32 val;
+	u32 val, mask;
 	int ret;
=20
 	dsi_write(dsi, DSI_PHY_RSTZ, PHY_ENFORCEPLL | PHY_ENABLECLK |
@@ -763,11 +767,16 @@ static void dw_mipi_dsi_dphy_enable(struct dw_mipi_ds=
i *dsi)
 	if (ret)
 		DRM_DEBUG_DRIVER("failed to wait phy lock state\n");
=20
+	mask =3D PHY_STOP_STATE_CLK_LANE | PHY_STOP_STATE_LANE_0;
+	mask |=3D (dsi->lanes >=3D 2) ? PHY_STOP_STATE_LANE_1 : 0;
+	mask |=3D (dsi->lanes >=3D 3) ? PHY_STOP_STATE_LANE_2 : 0;
+	mask |=3D (dsi->lanes =3D=3D 4) ? PHY_STOP_STATE_LANE_3 : 0;
+
 	ret =3D readl_poll_timeout(dsi->base + DSI_PHY_STATUS,
-				 val, val & PHY_STOP_STATE_CLK_LANE, 1000,
+				 val, (val & mask) =3D=3D mask, 1000,
 				 PHY_STATUS_TIMEOUT_US);
 	if (ret)
-		DRM_DEBUG_DRIVER("failed to wait phy clk lane stop state\n");
+		DRM_DEBUG_DRIVER("failed to wait phy stop state\n");
 }
=20
 static void dw_mipi_dsi_clear_err(struct dw_mipi_dsi *dsi)
--=20
2.17.1

