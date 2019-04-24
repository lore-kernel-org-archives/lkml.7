Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25529C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE296218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=thinciit.onmicrosoft.com header.i=@thinciit.onmicrosoft.com header.b="nAGvYvMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbfDXNi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:38:29 -0400
Received: from rfout2.hes.trendmicro.com ([54.67.111.2]:33130 "EHLO
        rfout2.hes.trendmicro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfDXNi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:38:29 -0400
Received: from 0.0.0.0_hes.trendmicro.com (unknown [10.64.4.116])
        by rfout2.hes.trendmicro.com (Postfix) with ESMTPS id 0921E110B818
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 13:22:51 +0000 (UTC)
Received: from 0.0.0.0_hes.trendmicro.com (unknown [10.64.10.217])
        by rout2.hes.trendmicro.com (Postfix) with SMTP id AF331EFC06A;
        Wed, 24 Apr 2019 13:22:50 +0000 (UTC)
Received: from IND01-BO1-obe.outbound.protection.outlook.com (unknown [104.47.101.55])
        by relay1.hes.trendmicro.com (TrendMicro Hosted Email Security) with ESMTPS id 5F75D142C1A9;
        Wed, 24 Apr 2019 13:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thinciit.onmicrosoft.com; s=selector1-thinci-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0Q3f9arMPsTs47lX4twv38isowvQuDeOXOd5Spm6G4=;
 b=nAGvYvMdB6UhTll8NJQgokhlz+fuUgvohtS5xJ8zrsnCKZoVI6wlPeo5zEl+ztCMsKeHJ+hqrc4pZI+hJVNfUgWYaBVbFaO/RqReSKCjbaWpEcr9QK0GWiVm4qu3oXGWZCiADY1xQptVX8vNg2dLp7YL53K4wMwaa3MZ8mNs7kk=
Received: from MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM (52.134.158.84) by
 MAXSPR01MB0004.INDPRD01.PROD.OUTLOOK.COM (52.134.155.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Wed, 24 Apr 2019 13:22:46 +0000
Received: from MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8c8f:543a:ccd6:fe7a]) by MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8c8f:543a:ccd6:fe7a%2]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 13:22:46 +0000
From:   Matt Redfearn <matt.redfearn@thinci.com>
To:     Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Matthew Redfearn <matthew.redfearn@thinci.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/bridge: adv7511: Attach to DSI host at probe time
Thread-Topic: [PATCH] drm/bridge: adv7511: Attach to DSI host at probe time
Thread-Index: AQHU+qDOBH/FCPbc60C2cd3c/xdrZA==
Date:   Wed, 24 Apr 2019 13:22:46 +0000
Message-ID: <20190424132233.26435-1-matt.redfearn@thinci.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0084.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::24) To MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:64::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=matthew.redfearn@thinci.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [87.242.198.86]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5eebe4ef-5a3f-4060-d1ae-08d6c8b7f0e3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MAXSPR01MB0004;
x-ms-traffictypediagnostic: MAXSPR01MB0004:
x-microsoft-antispam-prvs: <MAXSPR01MB0004EECFD82A7A81F7E1D6BCF13C0@MAXSPR01MB0004.INDPRD01.PROD.OUTLOOK.COM>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39840400004)(346002)(396003)(376002)(189003)(199004)(68736007)(97736004)(305945005)(478600001)(1076003)(26005)(486006)(7736002)(3846002)(6116002)(66446008)(64756008)(73956011)(66476007)(71190400001)(5024004)(66946007)(14444005)(66556008)(6486002)(476003)(71200400001)(8936002)(14454004)(256004)(53936002)(2616005)(66066001)(6436002)(6512007)(2906002)(25786009)(50226002)(36756003)(5660300002)(52116002)(81156014)(316002)(4326008)(186003)(102836004)(99286004)(81166006)(8676002)(386003)(7416002)(6506007)(110136005)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:MAXSPR01MB0004;H:MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: thinci.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LhIYm46cL8LQYQotRmyXanqJGhkUYnU/Um95V/3uYlU9JfUPHNVYP+NQkwnggsFadKxqjoinsFZw4RBCeWXFL3KFu7GInv9bPg04zgiyRSMK8Rj+he7xI8a3/HYjgSmkF23yC3LOMqHUQG1CI1r7j4r1RFyC/cZOgmJXmflqH4xWtEBqVBQEpZcYCQukQt4avmPyTiI6dzNxfdi6BuZj9rkDIdJ3h0dh+5EKZb2Tim9oO4s50ZFYV5ROofBq/85R5UhnilBN8kM4ulQhL6bWDJAR8F0iecyd3O2bY6jgZYGN9S6iJfMY9nDy4AoQvUWEd2MxPa3EDThPOdzipLbfVzR60D3/8nTm9qUxq4CMqiUV0Ya/YfShlpvoH+KLxpEoVypUtDw535Y1IufwBtWdoGmHa0B0iIthOlEITBPNDjA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: thinci.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eebe4ef-5a3f-4060-d1ae-08d6c8b7f0e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 13:22:46.7748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXSPR01MB0004
X-TMASE-Version: StarCloud-1.3-8.2.1013-24570.007
X-TMASE-Result: 10--2.598600-4.000000
X-TMASE-MatchedRID: LpOvGexFwgtcgzmua3ALxhWCVBr+Ay989xIiieITJajHkH7uosEn7McR
        JRrz9JX4kVsBuujJ0lElnaVFxTqQZFlT1+MC6aFYWY+5JA3gUBs2FTl/w/5BZzydvUg+VfSm+Vi
        hXqn9xLEZ7OxyTB7kb+aigIs9vJgVBOzLkK2T9qNc/msUC5wFQX0tCKdnhB58kS/ZvrGh80FzqE
        fyvgNYMCKDrFoK/LNdjoczmuoPCq3yClz8nTKjIJDAR+RLG58YKnO+kZB/q5JsCmp9d/ttgMK+8
        qmW5oBZQagCXfU+F+H8amx+B2dErqKa2eyoJoe5qmzkUbYuEryN1XIGgb30UjMO7WwucqsLGtMi
        kpjqoh07bMumEHVdMcPFOVn4xwUmlExlQIQeRG0=
X-TM-Deliver-Signature: 64B046D98C613FFE5F1953A27C6F1C0F
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In contrast to all of the DSI panel drivers in drivers/gpu/drm/panel
which attach to the DSI host via mipi_dsi_attach() at probe time, the
ADV7533 bridge device does not. Instead it defers this to the point that
the upstream device connects to its bridge via drm_bridge_attach().
The generic Synopsys MIPI DSI host driver does not register it's own
drm_bridge until the MIPI DSI has attached. But it does not call
drm_bridge_attach() on the downstream device until the upstream device
has attached. This leads to a chicken and the egg failure and the DRM
pipeline does not complete.
Since all other mipi_dsi_device drivers call mipi_dsi_attach() in
probe(), make the adv7533 mipi_dsi_device do the same. This ensures that
the Synopsys MIPI DSI host registers it's bridge such that it is
available for the upstream device to connect to.

Signed-off-by: Matt Redfearn <matt.redfearn@thinci.com>

---

 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm=
/bridge/adv7511/adv7511_drv.c
index e7ddd3e3db9..ea36ac3a3de 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -874,9 +874,6 @@ static int adv7511_bridge_attach(struct drm_bridge *bri=
dge)
 				 &adv7511_connector_helper_funcs);
 	drm_connector_attach_encoder(&adv->connector, bridge->encoder);
=20
-	if (adv->type =3D=3D ADV7533)
-		ret =3D adv7533_attach_dsi(adv);
-
 	if (adv->i2c_main->irq)
 		regmap_write(adv->regmap, ADV7511_REG_INT_ENABLE(0),
 			     ADV7511_INT0_HPD);
@@ -1222,7 +1219,11 @@ static int adv7511_probe(struct i2c_client *i2c, con=
st struct i2c_device_id *id)
 	drm_bridge_add(&adv7511->bridge);
=20
 	adv7511_audio_init(dev, adv7511);
-	return 0;
+
+	if (adv7511->type =3D=3D ADV7533)
+		return adv7533_attach_dsi(adv7511);
+	else
+		return 0;
=20
 err_unregister_cec:
 	i2c_unregister_device(adv7511->i2c_cec);
--=20
2.17.1

