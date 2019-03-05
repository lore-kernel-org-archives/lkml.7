Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981B1C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D60820842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="T6zWMFnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfCEKHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:07:43 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:56009 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfCEKHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:07:42 -0500
X-IronPort-AV: E=Sophos;i="5.58,443,1544511600"; 
   d="scan'208";a="27273021"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Mar 2019 03:07:41 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Mar 2019 03:07:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnDJrc2fWj+kuXChfYNe6+4J490v2101XUkGUY/F7c4=;
 b=T6zWMFnM4h2itcg9To2uLJsqowOpv0qUJvihx+OOeKHN0Qo9DV3qeO1zMkCcJamRChOnn2vyDg2c8RN2nuvtNZlU2nHRs9pesjtXaSLf2jTiHa9i7oNVPN90vrHxTZXZwdHbHWuvohS00tOViryg9tZcalAffELUc4LLof66B1w=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1647.namprd11.prod.outlook.com (10.172.55.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Tue, 5 Mar 2019 10:07:38 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%9]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 10:07:38 +0000
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
Subject: [PATCH v2 1/7] drm: atmel-hlcdc: add config option for clock
 selection
Thread-Topic: [PATCH v2 1/7] drm: atmel-hlcdc: add config option for clock
 selection
Thread-Index: AQHU0ztD+/wMXaZ0tESQW5wKZocGmw==
Date:   Tue, 5 Mar 2019 10:07:38 +0000
Message-ID: <1551780434-4580-2-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: f06c76a5-6c0e-4908-fc09-08d6a152658f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1647;
x-ms-traffictypediagnostic: MWHPR11MB1647:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1647;23:m1Xx5t+3hGCqxGtM8tbA0gPI+HQZ24zrkOX4+3y?=
 =?iso-8859-1?Q?LzglgRE+3rSMIitqTAJM7BuwOIemKz/kqIi0JAMk/oTm0KNjB6YglimR2+?=
 =?iso-8859-1?Q?bIcrB4cxiKI+gZqcufEQKta0XQIuisDQN3yhhve2odIZeEuBpcelszIMf1?=
 =?iso-8859-1?Q?mg9MBNnFgnUPqwOOq1KgzN+M0AKuvjMDIEkUMJBv/aCFGqjcqRT1ZdN2jB?=
 =?iso-8859-1?Q?3PuCmSDZo94RteIElopQRm13FwXpXgR13rLDnSbUuMO9f7f4psijrvQYoZ?=
 =?iso-8859-1?Q?VpttrpChXHMG0NG6ttrFt4uS9/oIAKgjleXLGbuSrehsu64jZjIWrpnIWc?=
 =?iso-8859-1?Q?nSZH/VCwElvI+xp8zWYNCSVOyS1AFpfcjlp429D5Kr2AaCzJDqeSJbQCl+?=
 =?iso-8859-1?Q?iuYRL/0gloSIobnurT6hnbZlu9XudwbneYMTviU3mLhhSvBHHDHoXLt3Lb?=
 =?iso-8859-1?Q?vjdzl4vaC5y0nTeYNokrun0TmrSAGvfmgBkXyHf3qzuLT4DEL5Ivj0mxEC?=
 =?iso-8859-1?Q?PHEyooXnKMUtNGcMP6MXIvp4QbA1Af9NA7/bSRkg75vWRMmT5fncDQliFb?=
 =?iso-8859-1?Q?vUg9mpKtbyczmfRRP6N6MsypTTnwb0MWbxpTPmo+pMYCGlV4qwp2V1xQ2N?=
 =?iso-8859-1?Q?JVBy0jLPDI+vnNlNj0x9CrjrW1UdM1YeKDn9nFbLOryK5oMRxvDS+oe3Jx?=
 =?iso-8859-1?Q?Xyh8ZDXEc66OuaHhYoLeDNqL4Y2ImTW242Yf0mFFeQaPlEByJqs8bGcgv4?=
 =?iso-8859-1?Q?hQHTtD2YV+03SRKN3uIafW2EEzJZPMu5D/hmjasaammJCQG+JKIharjcPB?=
 =?iso-8859-1?Q?Ppiuwpa5pmugjVdU5crfptExgnMV1Z8X+04iEQLy6pNciguFpt5MW80BpA?=
 =?iso-8859-1?Q?wT8CA/gRGTpaOuQjLV8HW+/awUhfRxMRynMO53Alj5bQVZDiG1Uxd5urqR?=
 =?iso-8859-1?Q?A/FyTxWBgsRfF15Q3HM/ZyjAUmi9EZMJ5RShZIsoe60oHA/0XPluCkUb1X?=
 =?iso-8859-1?Q?ID8sLslLwbymXdA3ylS+sPu7s/mHNYkZduNuhZTCnDZL8oljcql50Y8IHL?=
 =?iso-8859-1?Q?ScYkYEWZmwC6ZUkbgswkiL1Q5jhmxmB7j6h3JPA/vS7ZceNCKFhJu6ThGF?=
 =?iso-8859-1?Q?+/pZnJwzsvZgyiOwPxf19PR+dDMVqEGjyJ5AZyeXY2yGC/f1ddGi/XCrCQ?=
 =?iso-8859-1?Q?HJ4KZsxdMtVXcFRfax8dSYnqh9ADakqTLMRF4KFpGHoBUkCsYGLRAKedRG?=
 =?iso-8859-1?Q?kfs9ZDKxVoAIgkwXIyqcm40b3IHwIfKYluGLrOXHZD/tuet1BDUlF063Y7?=
 =?iso-8859-1?Q?yOs7dDU78o/tRIqM0EQAruEI+9Xpbo1meulqDEgCT0nQ5q3gek7jHZaKVu?=
 =?iso-8859-1?Q?pcZgmf6xYgyNZqo24L9DeHx0vrKg+?=
x-microsoft-antispam-prvs: <MWHPR11MB164789DC0763617B44B43C5487720@MWHPR11MB1647.namprd11.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(136003)(366004)(199004)(189003)(106356001)(72206003)(3846002)(99286004)(81156014)(52116002)(36756003)(76176011)(14454004)(81166006)(66066001)(8676002)(110136005)(6116002)(105586002)(6486002)(7736002)(5660300002)(8936002)(305945005)(25786009)(102836004)(54906003)(97736004)(316002)(2906002)(7416002)(2501003)(2616005)(186003)(71190400001)(6506007)(386003)(256004)(476003)(68736007)(11346002)(71200400001)(6512007)(2201001)(107886003)(53936002)(446003)(50226002)(486006)(4326008)(86362001)(6436002)(478600001)(14444005)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1647;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aLMnhcwbijCslvDfdkdmH0KOsBXeX6yBGleXF76uzeJ48MO1EKGTG+dWagXK3rO7wmFGvQnz1gR8GOA7Y59L/JRYO6ucNZhSWYvA6ZK0ZVg9jMqKqi4GlX/UhAc0il81KRbArGg1YMjUppfKFsmT2L3bwPfTRDiMoXbyd2v6cRSh/5A38EMbOxE4UfCaaYmA2jp4V/mXrSxJFISWUFGJKczLQSQN96HMGGL3lC7GjEuXRgZ3gxdbLKwM52sWbaVFNru23BWTEyq95EUDV8olfuYZBPhtrcNQdzQBl2Bw9nktt7rODcp4JHG2RsnOR6r6kegOCs4nUhEsJXCJnmnuNLk2EgTx/s1JmABRGVvdZbcBBcmWomVeR2KmkXoTdUzHEnQBiz4P+ZfHbGNTP8TSj4Q3lCF1E1IeQYfAWgoFS8s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f06c76a5-6c0e-4908-fc09-08d6a152658f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 10:07:38.6652
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

SAM9x60 LCD Controller has no option to select clock source as previous
controllers have. To be able to use the same driver even for this LCD
controller add a config option to know if controller supports this.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 12 +++++++-----
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h   |  2 ++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/d=
rm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 8070a558d7b1..957e6d2fb00f 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -78,7 +78,8 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crt=
c *c)
 	unsigned long mode_rate;
 	struct videomode vm;
 	unsigned long prate;
-	unsigned int cfg;
+	unsigned int mask =3D ATMEL_HLCDC_CLKDIV_MASK | ATMEL_HLCDC_CLKPOL;
+	unsigned int cfg =3D 0;
 	int div;
=20
 	vm.vfront_porch =3D adj->crtc_vsync_start - adj->crtc_vdisplay;
@@ -101,7 +102,10 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_=
crtc *c)
 		     (adj->crtc_hdisplay - 1) |
 		     ((adj->crtc_vdisplay - 1) << 16));
=20
-	cfg =3D ATMEL_HLCDC_CLKSEL;
+	if (!crtc->dc->desc->fixed_clksrc) {
+		cfg |=3D ATMEL_HLCDC_CLKSEL;
+		mask |=3D ATMEL_HLCDC_CLKSEL;
+	}
=20
 	prate =3D 2 * clk_get_rate(crtc->dc->hlcdc->sys_clk);
 	mode_rate =3D adj->crtc_clock * 1000;
@@ -132,9 +136,7 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_c=
rtc *c)
=20
 	cfg |=3D ATMEL_HLCDC_CLKDIV(div);
=20
-	regmap_update_bits(regmap, ATMEL_HLCDC_CFG(0),
-			   ATMEL_HLCDC_CLKSEL | ATMEL_HLCDC_CLKDIV_MASK |
-			   ATMEL_HLCDC_CLKPOL, cfg);
+	regmap_update_bits(regmap, ATMEL_HLCDC_CFG(0), mask, cfg);
=20
 	cfg =3D 0;
=20
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm=
/atmel-hlcdc/atmel_hlcdc_dc.h
index 70bd540d644e..0155efb9c443 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -328,6 +328,7 @@ atmel_hlcdc_layer_to_plane(struct atmel_hlcdc_layer *la=
yer)
  * @max_hpw: maximum horizontal back/front porch width
  * @conflicting_output_formats: true if RGBXXX output formats conflict wit=
h
  *				each other.
+ * @fixed_clksrc: true if clock source is fixed
  * @layers: a layer description table describing available layers
  * @nlayers: layer description table size
  */
@@ -340,6 +341,7 @@ struct atmel_hlcdc_dc_desc {
 	int max_vpw;
 	int max_hpw;
 	bool conflicting_output_formats;
+	bool fixed_clksrc;
 	const struct atmel_hlcdc_layer_desc *layers;
 	int nlayers;
 };
--=20
2.7.4

