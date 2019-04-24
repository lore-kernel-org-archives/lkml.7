Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC83AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C76B21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=thinciit.onmicrosoft.com header.i=@thinciit.onmicrosoft.com header.b="pdhaiip9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbfDXNiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:38:04 -0400
Received: from rfout2.hes.trendmicro.com ([54.67.111.2]:58410 "EHLO
        rfout2.hes.trendmicro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfDXNiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:38:03 -0400
X-Greylist: delayed 929 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Apr 2019 09:38:03 EDT
Received: from 0.0.0.0_hes.trendmicro.com (unknown [10.64.14.197])
        by rfout2.hes.trendmicro.com (Postfix) with ESMTPS id 73E20110B690
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 13:22:33 +0000 (UTC)
Received: from 0.0.0.0_hes.trendmicro.com (unknown [10.64.10.30])
        by rout6.hes.trendmicro.com (Postfix) with SMTP id 886F6C66077;
        Wed, 24 Apr 2019 13:22:32 +0000 (UTC)
Received: from IND01-BO1-obe.outbound.protection.outlook.com (unknown [104.47.101.59])
        by relay1.hes.trendmicro.com (TrendMicro Hosted Email Security) with ESMTPS id 4F359142C182;
        Wed, 24 Apr 2019 13:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thinciit.onmicrosoft.com; s=selector1-thinci-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RkJiMyxsqMKC7iTJD9sE1Fz1vh0E5zUdKNnBSSvvUw=;
 b=pdhaiip9VzdhQWTF/ROSxX8hJJFOOQP5hBd5z//pdyFDsli3kfZlj8yrxDyOfJKRUrVMqsONEnrSt7cOg+neTIw10PpCiOIkwTM0MTeTv7Vb3blAEwlzhXa9HFbkfBWAjM7seh8Eyu/No4DJkk4dnZtlzfRBVAuCKZdvh0N1azk=
Received: from MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM (52.134.158.84) by
 MAXSPR01MB0004.INDPRD01.PROD.OUTLOOK.COM (52.134.155.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Wed, 24 Apr 2019 13:22:27 +0000
Received: from MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8c8f:543a:ccd6:fe7a]) by MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8c8f:543a:ccd6:fe7a%2]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 13:22:27 +0000
From:   Matt Redfearn <matt.redfearn@thinci.com>
To:     Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Matthew Redfearn <matthew.redfearn@thinci.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/bridge: adv7511: Fix low refresh rate selection
Thread-Topic: [PATCH] drm/bridge: adv7511: Fix low refresh rate selection
Thread-Index: AQHU+qDCf6J6wtpe9EGvx8PuTtFI+Q==
Date:   Wed, 24 Apr 2019 13:22:27 +0000
Message-ID: <20190424132210.26338-1-matt.redfearn@thinci.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB7PR03CA0049.eurprd03.prod.outlook.com
 (2603:10a6:5:2a::26) To MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:64::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=matthew.redfearn@thinci.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [87.242.198.86]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1ff5687-effa-4683-e146-08d6c8b7e554
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MAXSPR01MB0004;
x-ms-traffictypediagnostic: MAXSPR01MB0004:
x-microsoft-antispam-prvs: <MAXSPR01MB0004393D31FFC00E2A13BF84F13C0@MAXSPR01MB0004.INDPRD01.PROD.OUTLOOK.COM>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39840400004)(346002)(396003)(376002)(189003)(199004)(68736007)(97736004)(305945005)(478600001)(1076003)(26005)(486006)(7736002)(3846002)(6116002)(66446008)(64756008)(73956011)(66476007)(71190400001)(66946007)(66556008)(6486002)(476003)(71200400001)(8936002)(14454004)(256004)(53936002)(2616005)(66066001)(6436002)(6512007)(2906002)(25786009)(50226002)(36756003)(5660300002)(52116002)(81156014)(316002)(4326008)(186003)(102836004)(99286004)(81166006)(8676002)(386003)(7416002)(6506007)(110136005)(54906003)(16453002);DIR:OUT;SFP:1102;SCL:1;SRVR:MAXSPR01MB0004;H:MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: thinci.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3dnwvtCbWibzfyKBY9keTPKOMLttz1rL4GlWf2Xcva15eR9Ms+792EhHWP1lSw+uf8pO30N1U33fUAKWL9xQF9Szt8tmIytAfIlg2nyfjjX94WvDOn8ZlL1WGoVUGavLMlqc4KtnzFo37c0OVtkLJlvy3jz9dZDNGaYnw4pTLaVoJme7jCk+C6pnL6gFOcWKzsqWz1obPdSw7vr4m30sWODt3xscZkmO4lVHUyZQZteWrmn8D1wJczS3vjsPAGuNHk9f1VsGzDKVzwMn/9390ndWCjh6rr+zODlYdwGsIpJkm63eiT7Dbsq/v7bsdNvI3u3sYOQBmJKvfZ5ENO3h3d/j0sZ7OlzBAdrvCEftZTc5XUCb9bYytGqvmnAptqJl2vVSh3+L+M1GPVYlh0s8lHSm/KKriApDfllRUmZ8qvE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: thinci.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ff5687-effa-4683-e146-08d6c8b7e554
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 13:22:27.3931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXSPR01MB0004
X-TMASE-Version: StarCloud-1.3-8.2.1013-24570.007
X-TMASE-Result: 10--3.090100-4.000000
X-TMASE-MatchedRID: r2UsUYnETSJM4VjZ76ar2MnUT+eskUQPojQrbrPpzzq7qpOHKudqc8it
        /eCfvDyiigmxhv5wbosPXNIyBkp9I2yeGFxbrq7l/bxP0FQ1eSFQCOsAlaxN7wZbeEWcL03V7DH
        CQTNvCpajmrD+IUq29gG2ORx9EyapkfRhdidsajMYVPSqPTOLvZmyjlLF2zdknFK7VE/xL0n6C0
        ePs7A07bxtFR53UcYCgeMEYTPpuAzdhnvxN4JXQRhcCEaDYLrAq11bpYbTmquECKpZQF7etg5I8
        j7jFkWLduRdzJY/tO8FpBT5xpiQ0DaRObpDlI/TwLkctwy8ORb6oIFDlFyvNyejhF9Zk39fSgLy
        dMok6QM=
X-TM-Deliver-Signature: A79490A106642E3427360BC6FEA601E0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver currently sets register 0xfb (Low Refresh Rate) based on the
value of mode->vrefresh. Firstly, this field is specified to be in Hz,
but the magic numbers used by the code are Hz * 1000. This essentially
leads to the low refresh rate always being set to 0x01, since the
vrefresh value will always be less than 24000. Fix the magic numbers to
be in Hz.
Secondly, according to the comment in drm_modes.h, the field is not
supposed to be used in a functional way anyway. Instead, use the helper
function drm_mode_vrefresh().

Fixes: 9c8af882bf12 ("drm: Add adv7511 encoder driver")
Signed-off-by: Matt Redfearn <matt.redfearn@thinci.com>

---

 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm=
/bridge/adv7511/adv7511_drv.c
index 85c2d407a52..e7ddd3e3db9 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -747,11 +747,11 @@ static void adv7511_mode_set(struct adv7511 *adv7511,
 			vsync_polarity =3D 1;
 	}
=20
-	if (mode->vrefresh <=3D 24000)
+	if (drm_mode_vrefresh(mode) <=3D 24)
 		low_refresh_rate =3D ADV7511_LOW_REFRESH_RATE_24HZ;
-	else if (mode->vrefresh <=3D 25000)
+	else if (drm_mode_vrefresh(mode) <=3D 25)
 		low_refresh_rate =3D ADV7511_LOW_REFRESH_RATE_25HZ;
-	else if (mode->vrefresh <=3D 30000)
+	else if (drm_mode_vrefresh(mode) <=3D 30)
 		low_refresh_rate =3D ADV7511_LOW_REFRESH_RATE_30HZ;
 	else
 		low_refresh_rate =3D ADV7511_LOW_REFRESH_RATE_NONE;
--=20
2.17.1

