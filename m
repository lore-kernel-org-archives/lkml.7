Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18F1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941AD218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=thinciit.onmicrosoft.com header.i=@thinciit.onmicrosoft.com header.b="wOE44mTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbfDXOWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:22:07 -0400
Received: from rout6.hes.trendmicro.com ([54.219.188.12]:56454 "EHLO
        rout6.hes.trendmicro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDXOWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:22:06 -0400
X-Greylist: delayed 3573 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Apr 2019 10:22:06 EDT
Received: from 0.0.0.0_hes.trendmicro.com (unknown [10.64.10.65])
        by rout6.hes.trendmicro.com (Postfix) with SMTP id 62C9DC6607D;
        Wed, 24 Apr 2019 14:22:05 +0000 (UTC)
Received: from IND01-BO1-obe.outbound.protection.outlook.com (unknown [104.47.101.52])
        by relay2.hes.trendmicro.com (TrendMicro Hosted Email Security) with ESMTPS id A458D9F60F3;
        Wed, 24 Apr 2019 14:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thinciit.onmicrosoft.com; s=selector1-thinci-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQsDyqzFdmfnjPxTeUuZE1VK4NsD9O0nClLHke4c5Ec=;
 b=wOE44mTQeWB/jLVsintTR+LtyCAgs+q2lqt8mlAK0e38JcmOxmOWz0DdTykey6ecwGiygFZ8u4Q8gXbt3r+xzlkTJl851gQc7qiQnIZfDpuFbUI0MENaCKcXLOkXHhZifNJjCuOBQP0lCOavs/84M96aaCtrZYnu0pXH0ljtpUE=
Received: from MA1PR01MB3770.INDPRD01.PROD.OUTLOOK.COM (20.179.238.86) by
 MA1PR01MB3194.INDPRD01.PROD.OUTLOOK.COM (10.255.215.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Wed, 24 Apr 2019 14:22:00 +0000
Received: from MA1PR01MB3770.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f0fa:29f3:9933:7d7a]) by MA1PR01MB3770.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f0fa:29f3:9933:7d7a%3]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 14:22:00 +0000
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
Subject: [PATCH] drm/bridge/synopsys: dsi: Don't blindly call post_disable
Thread-Topic: [PATCH] drm/bridge/synopsys: dsi: Don't blindly call
 post_disable
Thread-Index: AQHU+qkUj1HzsBP9eU2naClnjE4Oug==
Date:   Wed, 24 Apr 2019 14:22:00 +0000
Message-ID: <20190424142148.25927-1-matt.redfearn@thinci.com>
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
x-ms-office365-filtering-correlation-id: 01f325b7-b6c9-4a1d-02fc-08d6c8c036c2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MA1PR01MB3194;
x-ms-traffictypediagnostic: MA1PR01MB3194:
x-microsoft-antispam-prvs: <MA1PR01MB3194ECBCCD9BE922ABDBD1DDF13C0@MA1PR01MB3194.INDPRD01.PROD.OUTLOOK.COM>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39850400004)(396003)(376002)(366004)(346002)(189003)(199004)(8676002)(316002)(2906002)(2616005)(486006)(476003)(66066001)(36756003)(81166006)(14454004)(81156014)(478600001)(6506007)(256004)(14444005)(386003)(26005)(68736007)(186003)(66946007)(73956011)(5660300002)(64756008)(66476007)(3846002)(6116002)(66556008)(50226002)(7416002)(66446008)(8936002)(102836004)(6512007)(71190400001)(1076003)(71200400001)(52116002)(97736004)(53936002)(4326008)(6436002)(25786009)(7736002)(305945005)(99286004)(6486002)(110136005)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:MA1PR01MB3194;H:MA1PR01MB3770.INDPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: thinci.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sg3dx2+o+UUHuRtsoVFW/0iuwk0H6KyjAeElq9qO7ChA8wvTc7Xf8cTRsEdUetV6vZjotTgKFcwzx19RpEiPahSUX8uH25iKAh2hVS2kph+r/PeLZ1kL1mhLHKrcF3onJBrVTmB/4KdPEcW6aD2GaINtofLObs3m8ckbkQbnYI+2hQFC0EazW7WOtZST+VjANvUN3SRhTTnL0HJTG6KYxhvuDC5+5V9uv4gOwTIQXi3GEx6N1LzXBHs8nrVztd3Xjso9vlEx+pRkU+bRHbDWuaOG5WYzjvT1GXY/t/KNLvx+1M8ulbUiR+yxqi+MKH7AR2Q5UOV1JurnUup32Zg+o8sJklIdl6a2Nm5HQWZm9Zn92eD5PHkRl6AOtAnb5T3m9mJwNXaIftWnrmGWe8WwCRaJyZr+8GCC1aeDDZVbE/I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: thinci.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f325b7-b6c9-4a1d-02fc-08d6c8c036c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 14:22:00.0666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PR01MB3194
X-TMASE-Version: StarCloud-1.3-8.2.1013-24572.000
X-TMASE-Result: 10--2.280300-4.000000
X-TMASE-MatchedRID: 3DCWtTm2Z9+T4QuBHRkf9pN3sInxtjDTZn7KXuDApb5+YesuCgkiXHbk
        pdDhAgYmo2jEjZ+uot3kAOn8zTy8vHrSP9RtGZYoQ4srjeRbxTZCX8V1FiRRkt9RlPzeVuQQ+1B
        ysa1PtqSdE6czz+eVhdeS5VWUkyw98Nk4qYUuW8jghWDeMRWA/X0tCKdnhB58kS/ZvrGh80FzqE
        fyvgNYMCKDrFoK/LNdjoczmuoPCq3BUnDL4C6uf8M978+ZKU/PGHHSjzp4a9o5MSHZbTN+ihPUS
        PPaUOyAZE94MvHK5c/oWOGxHQO6LibrOVhfmLpYXnWDJ6BvyeaN1XIGgb30UjMO7WwucqsLGtMi
        kpjqoh07bMumEHVdMRfqtr5XQz6G
X-TM-Deliver-Signature: 3DEC359A54C2D4F0FB6BC97639A56A68
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRM documentation states that post_disable is an optional callback.
As such an implementing device may not populate it. To avoid panicing
the kernel by calling a NULL function pointer, we should NULL check it
before blindy calling it.

Signed-off-by: Matt Redfearn <matt.redfearn@thinci.com>

---

 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/dr=
m/bridge/synopsys/dw-mipi-dsi.c
index 38e88071363..0ee440216b8 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -805,7 +805,8 @@ static void dw_mipi_dsi_bridge_post_disable(struct drm_=
bridge *bridge)
 	 * This needs to be fixed in the drm_bridge framework and the API
 	 * needs to be updated to manage our own call chains...
 	 */
-	dsi->panel_bridge->funcs->post_disable(dsi->panel_bridge);
+	if (dsi->panel_bridge->funcs->post_disable)
+		dsi->panel_bridge->funcs->post_disable(dsi->panel_bridge);
=20
 	if (dsi->slave) {
 		dw_mipi_dsi_disable(dsi->slave);
--=20
2.17.1

