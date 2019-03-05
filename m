Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B5FC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5AC206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="bhSAsVO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfCEKHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:07:47 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:2666 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfCEKHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:07:46 -0500
X-IronPort-AV: E=Sophos;i="5.58,443,1544511600"; 
   d="scan'208";a="27662189"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Mar 2019 03:07:45 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Mar 2019 03:07:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zkVpyiWck4iv0VjBI3T28y9cihO2TVG7cnvYn59DdU=;
 b=bhSAsVO7FOxfLOxKMqq61jTsTdZB5ZFUTm+UFf+kcywHslYko2lkAN6v6eer7XmaZfFxz/9vLa9TC7gzm7wVXOp6N/C0d24FYoV6vTz+AgecbeOEylefIZu07MdstsRUbIxyLv3uDSkX8XbbLn4VNv1vSx5XRucWrmMpUgoKPhw=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1647.namprd11.prod.outlook.com (10.172.55.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Tue, 5 Mar 2019 10:07:43 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%9]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 10:07:43 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <bbrezillon@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-pwm@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 2/7] drm: atmel-hlcdc: avoid initializing cfg with zero
Thread-Topic: [PATCH v2 2/7] drm: atmel-hlcdc: avoid initializing cfg with
 zero
Thread-Index: AQHU0ztG4BRXLYfxrk2A4BtI6D5/UA==
Date:   Tue, 5 Mar 2019 10:07:43 +0000
Message-ID: <1551780434-4580-3-git-send-email-claudiu.beznea@microchip.com>
References: <1551780434-4580-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1551780434-4580-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0011.eurprd05.prod.outlook.com
 (2603:10a6:803:1::24) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd1ab314-e2b4-4283-7e6c-08d6a1526860
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1647;
x-ms-traffictypediagnostic: MWHPR11MB1647:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1647;23:D6J8n+GcEgC1qMSW27Z9U8rwoAyiUf7vZt574Vx?=
 =?iso-8859-1?Q?7ouSd5cltFrZi9huiddy76U4EZjtHPJrRMl9qyvYLjICEbCg88Zptzu41Y?=
 =?iso-8859-1?Q?hKPDYqLdOp9lYBuO4cPtly7slQM9HK8tNe/5uP+TmjriS0csDnVUT0JKJx?=
 =?iso-8859-1?Q?r2EBTA6/SjEDyNH1AgGpybH7OZDkOOl5Liv1W90uqX0IKzzfHYcm+VDxQV?=
 =?iso-8859-1?Q?gUlqJhvRT4Cp9m/FHARSbq8CEsh4vnqIypBY3rbqhly1DrxNaC38kDdY4h?=
 =?iso-8859-1?Q?dXGgfC7OUZw4nZjj7BO8Sv/e6XaG/ymQhmuBZGKhJpqD59Mr0UH5x2yGVS?=
 =?iso-8859-1?Q?U3iZzkPmm9+BWOI2oUjMQIrVP2Fq70O981RYIPyYc9a2VcG35D42ghV0pS?=
 =?iso-8859-1?Q?fN3AnsR+MO5M2GrYvHgIQzw90d7OU/peGCPaZ6UPbSWdWjS+/LEV0vl5cm?=
 =?iso-8859-1?Q?588gc7h2OTyXPdiyz9RGl47PpquuD2IIcNiWkcRUhA8oslX5vxb3GPzw6k?=
 =?iso-8859-1?Q?x6bgVgIO/AJbq3SHgWa5eRN9gPFzUtwIi5d8Wpj1HwZcE/8v8aJCABauI4?=
 =?iso-8859-1?Q?ryuoG1N6II7wv/lXblvsiLy240rUJYrcaxd4NLZ+jqGEOYE4DdLwDRZmsF?=
 =?iso-8859-1?Q?cak9YxokTAU8tBcHMCK1z+JkoodJPGVpnw3Nyvd28WmPeDl/H5WKu7HOg0?=
 =?iso-8859-1?Q?YXxdsENPFLc8Og7Rd0XKzMT7w2dwcdlIZYVludl3PuE0hW6yNp5FC3fPBD?=
 =?iso-8859-1?Q?TbXVY7hc8OgKBq/7RwVp0TqnnCO+A2M4aukZWc+MYAtmSoiKkSp+3SnY6f?=
 =?iso-8859-1?Q?VeZVuynID+yQCt1isL1J5spfofC1ON6itvvYUuGFNqheySo878iyndNz7+?=
 =?iso-8859-1?Q?DE1N486D7S4Z9EL0ser0G2sNvNkW6CitscReQ9IdiVYIk8EDI09Rrd0pGe?=
 =?iso-8859-1?Q?mrfMwzKenHcd/VKKZUHR+tMmqzj9Eb+/3MlG7PqwBCPkykMv0fcEv/cxTo?=
 =?iso-8859-1?Q?SpL0J+1hb/LXul5tmIqH3TchZpa2pLkln2yU4Vkoj9TLveKXkFIBG8VmTE?=
 =?iso-8859-1?Q?+luJQ852RmR4K9QwJ1WMIyb4eQWintZOJLApMvUarKGv7WNEi5Dsvrwooq?=
 =?iso-8859-1?Q?HuxJVFYF+3ehMyHo9mIew+PCjaNnxZODiEv33LjL+ISGCiznNPeOgV3ubU?=
 =?iso-8859-1?Q?huqsjdrHKV3WHajujknygcJoiCAgFKMollpqWODEi54QMSKu6Szzg+oNpu?=
 =?iso-8859-1?Q?CYNMIIlHz6Zo6Gokp/BQqU0FVsRdeYWoAdbhZFfybpoHKYQ8+BpNglBnUd?=
 =?iso-8859-1?Q?yBVF13XmJMgAHk0p748KIcvmCr6mPdRgidfXte2kjjILXqjWk0UbODYdYT?=
 =?iso-8859-1?Q?KNDvgBAS2wtMyCaOQWzRpEXlkBtf6?=
x-microsoft-antispam-prvs: <MWHPR11MB1647A1421B41D6CBC7DFF2B187720@MWHPR11MB1647.namprd11.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(136003)(366004)(199004)(189003)(106356001)(72206003)(3846002)(99286004)(81156014)(52116002)(36756003)(76176011)(14454004)(81166006)(66066001)(8676002)(110136005)(6116002)(105586002)(6486002)(7736002)(5660300002)(8936002)(305945005)(25786009)(102836004)(54906003)(97736004)(316002)(2906002)(7416002)(2501003)(2616005)(186003)(71190400001)(6506007)(386003)(256004)(476003)(68736007)(11346002)(71200400001)(6512007)(2201001)(107886003)(53936002)(446003)(50226002)(486006)(4326008)(86362001)(6436002)(478600001)(14444005)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1647;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xi2y6bEtQGeZ7/cjrLtOf52mOLRR6dyJ4P7s0XStC/7+oAtiVWfvHTR/GeC0/m7nVmFP5ZG1y541GEA+B1N0rTVkzjVuYiAM6ylRHO6dQpGYea0naN/BMbrHmf7Is+dDhYlB5/TMc2/j0/U1IFubktq8kf6x5AjAe1YST8/pqPpQfifT9pdOSwNnhe7pob/Y1yKDx77KqgxBxjrY2Bav1awcyNJ79srrer58CtSOJXZAxythXtUyG48adEEy9xPIWqqQrY536LWEm/gj+quzJp0C0wcpet5Y82MwoqGAS4NKcM7dXZ/t1ecHaoa8b7yuyZGigto+RdN/ydcloksUU4UZVHHem5GfAyKvRZtnNg3WJR0zWOJ2zFWhNbsiptZBPyNEg7vY6XqeQooeiI+GuJT0h11XFZKh30CZ0YExyDI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1ab314-e2b4-4283-7e6c-08d6a1526860
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 10:07:43.3501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1647
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Remove cfg initialization with zero and read state with
drm_crtc_state_to_atmel_hlcdc_crtc_state() so that cfg to be initialized
with state's output_mode.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/d=
rm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 957e6d2fb00f..81c50772df05 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -138,7 +138,8 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_c=
rtc *c)
=20
 	regmap_update_bits(regmap, ATMEL_HLCDC_CFG(0), mask, cfg);
=20
-	cfg =3D 0;
+	state =3D drm_crtc_state_to_atmel_hlcdc_crtc_state(c->state);
+	cfg =3D state->output_mode << 8;
=20
 	if (adj->flags & DRM_MODE_FLAG_NVSYNC)
 		cfg |=3D ATMEL_HLCDC_VSPOL;
@@ -146,9 +147,6 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_c=
rtc *c)
 	if (adj->flags & DRM_MODE_FLAG_NHSYNC)
 		cfg |=3D ATMEL_HLCDC_HSPOL;
=20
-	state =3D drm_crtc_state_to_atmel_hlcdc_crtc_state(c->state);
-	cfg |=3D state->output_mode << 8;
-
 	regmap_update_bits(regmap, ATMEL_HLCDC_CFG(5),
 			   ATMEL_HLCDC_HSPOL | ATMEL_HLCDC_VSPOL |
 			   ATMEL_HLCDC_VSPDLYS | ATMEL_HLCDC_VSPDLYE |
--=20
2.7.4

