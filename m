Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A531CC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB0D20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ISEqTBeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfCEKHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:07:38 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:23320 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfCEKHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:07:37 -0500
X-IronPort-AV: E=Sophos;i="5.58,443,1544511600"; 
   d="scan'208";a="28727094"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Mar 2019 03:07:36 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Mar 2019 03:07:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaw68Rl3UuDim1lz/KTbO2V5e8dtXKeRnBjx2C5lsag=;
 b=ISEqTBeUxJofZS3CS5bp/osv0IBTzCYwigYJEwvIoStO3r4i5p/BmEcNdGDe5GtDuR5lXheTyQXeOdnxCuyOspnQbe6JjU/DBbsocL7ej90EGmSxpa1jRA3zik0qfS1+zJmJz5QvCzgswPePJaFh1mehBTxZBfvFscfL00e6nKg=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1647.namprd11.prod.outlook.com (10.172.55.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Tue, 5 Mar 2019 10:07:34 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%9]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 10:07:34 +0000
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
Subject: [PATCH v2 0/7] add LCD support for SAM9X60
Thread-Topic: [PATCH v2 0/7] add LCD support for SAM9X60
Thread-Index: AQHU0ztA2NnaqPrxL0+V3bCNg5e8sw==
Date:   Tue, 5 Mar 2019 10:07:34 +0000
Message-ID: <1551780434-4580-1-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: 3843c570-6477-443b-9064-08d6a15262d2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1647;
x-ms-traffictypediagnostic: MWHPR11MB1647:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1647;23:pS2SsCv/+MZ5jzCA2V/HELP9KZhtRlcB+TnUQn1?=
 =?iso-8859-1?Q?vQxEK3rGupZSnZmJ+ZKpm8fEzhOCWjnxM8n3KjeIvqafg6glIeXMQyqLpc?=
 =?iso-8859-1?Q?DjnIFMHHAbyxdfkhUjD5SsLNXlAwyJtvHsVJwtw2DguUf1jUpY8RPtYM6c?=
 =?iso-8859-1?Q?HpbKBU0XB+UW7bNqxHlOTOPWiBYILa+KYtRULQph2jNV9WARRHrRrELdah?=
 =?iso-8859-1?Q?KyqZYyeWSACP5rTxerryQn3ctf89qg/s1/QZZ8pf+1aWmT4xytLT8VQ0I3?=
 =?iso-8859-1?Q?2uyX1K5CX7/j2EzTRzO9JSSVV11879h9gxopMqMkG1sOGoeJPqsBYlPyvY?=
 =?iso-8859-1?Q?a7bVqD+lus3upKqubNrRUcJoLczHHnlPExnQM5u7WLQj/EaLTaTJzYLlby?=
 =?iso-8859-1?Q?8WPeLQKqT4WjXL1OkMwZ0dlo2jUlh+04KMgAifUevaCg9EVYEP2uJzf9xV?=
 =?iso-8859-1?Q?2gFTsaDPSo3waYOJyZA0LA8OFJWKiLfPf/0x0lrbp17EX5OCxxKfjM/sle?=
 =?iso-8859-1?Q?B0dmf2NNJrPx4txicIJVi14fwJC/rLDwx0TfYXDyqayPr2wlPg1ZX5CBVD?=
 =?iso-8859-1?Q?BSVrqq+ARsdwYIPrXN9PY/kLob3Ixq9DQfHe2rSvpUrz64Ms70YxAI6Ker?=
 =?iso-8859-1?Q?Hx6+cQeQM05OwCYmVtlE1QeMZ20w2WogLIb04/JBX7aXPfo+rLruRcCSs1?=
 =?iso-8859-1?Q?Ur8tE3hSy75SKR+RhM+Pk1MbcT/VQTgjAK/263wRUQDEZL9bvU8IDfzejM?=
 =?iso-8859-1?Q?1km3IqX4wVFRPBfHDCBk2X7kZ1opM75Qmy+ZzxfmyU/lLyxxrtTZt76NzK?=
 =?iso-8859-1?Q?+9pK1YMvp8i6vzh3HDhJDvcXMQP4JB41W+csvK3zLqEbnqW61WiyamBOOs?=
 =?iso-8859-1?Q?9EkX+RR4LHbMzEFL41Gc5By59byakeXec4RQ6m930uwuD21wCT3Ww7v64g?=
 =?iso-8859-1?Q?hNiqPrJ5UEtL/ba1BI2cXRWzIbaWo0NYwLoWX4VYl3GO0zb+kHFlwc5gHW?=
 =?iso-8859-1?Q?66iVGReQH1d8W+QXQv6w9n5Qhb6it/JxbcWdqLKS0niinnp773fUhQgWVT?=
 =?iso-8859-1?Q?kCcFd86Mte5DvfGhT2q+qQQ9OzKcXcTysy7xYo1Gm1gFu0v5HwETjZ0W34?=
 =?iso-8859-1?Q?rYw6G2ha1bT4u3ZNZmG/cgYJ3P63zi69fwQ9ucdy8chP33cbxjbivN5Vjb?=
 =?iso-8859-1?Q?Bn/Z6UOxTNfZj5UHm/t4f5pIR8z3QBFoyXYd6RbFZILPAAsg4AtgWTDfMa?=
 =?iso-8859-1?Q?zF7eg1HqRjauuRyKg8dUVS0or6VOSuNuUwf3MDRndMDK8EiiGLH/UwAZUr?=
 =?iso-8859-1?Q?ycstp8uJzBDm0fQtPP2jH+MRV180CEeFHdowCj/RDIuZw=3D=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB1647556572C55477233C1BAE87720@MWHPR11MB1647.namprd11.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(136003)(366004)(199004)(189003)(106356001)(72206003)(3846002)(99286004)(81156014)(52116002)(36756003)(14454004)(81166006)(66066001)(8676002)(110136005)(6116002)(105586002)(6486002)(7736002)(5660300002)(8936002)(305945005)(25786009)(102836004)(54906003)(97736004)(316002)(2906002)(7416002)(2501003)(2616005)(186003)(71190400001)(6506007)(386003)(256004)(476003)(68736007)(71200400001)(6512007)(2201001)(107886003)(53936002)(50226002)(486006)(4326008)(86362001)(6436002)(478600001)(14444005)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1647;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vFPvyINCS+t/oBQbeKabMFhWXDfwC16et5IXN6HqHV36CczEfxaWjJFXdL6gdhw3oAtIRvASqRePs/bvHy82JtnUtQ1mBBF3YaQxy5ay5nPmHc7Xo5Rx9STQvTdVEG2VqZtlhzuBMmS/D+wR2pi5mn+y7LAOmmd9dnttOG2eozICOCKqRkk12rq+P90fo9a+86Qc7+CiSwrzfTUb8+6mtUSGYSNb1d7mwEd+bZz/0nEVxRbpaOfb401Vb1t61pOXXnJaPP44KAAhX4Ruyepi8w8WBVbi79Gdf0kgBfOO1oJ9tR0rL1UvG2sSXrDf/llTzbcS721KYDhqiQtn+YmMB7qkXTxiqbBoUhre7K4uvhOKAruFXdE+2gzii+bZ+XBXJmcjsfTPZ9d9TpNeQf0veQCI7PAYw2irulDl0kia+Wk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3843c570-6477-443b-9064-08d6a15262d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 10:07:34.0673
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

Hi,

These patches adds support for SAM9X60's LCD controller.

First patches add option to specify if controller clock source is fixed.
Second patch avoid a variable initialization in atmel_hlcdc_crtc_mode_set_n=
ofb().
The 3rd one adds specific bindings for SAM9X60 LCD controller.
The 4th and 5th add compatibles in the driver.
The 6th patch enables sys_clk in probe since SAM9X60 needs this.
Specific support was added also in suspend/resume hooks.
The work in the 6th patch was done based on support added in 1st patch.
The 7th patch adds SAM9X60's LCD configuration and enabled it.=20

I kept a big series including PWM, MFD, LCD changes due to shared DT
bindings. If you prefer, I'm available to send them separately. Please let
me know.

Thank you,
Claudiu Beznea

Changes in v2:
- use "|" operator in patch 1/7 to set ATMEL_HLCDC_CLKSEL on cfg
- collect Acked-by, Reviewed-by tags

Claudiu Beznea (5):
  drm: atmel-hlcdc: add config option for clock selection
  drm: atmel-hlcdc: avoid initializing cfg with zero
  dt-bindings: mfd: add bindings for SAM9X60 HLCD controller
  mfd: atmel-hlcdc: add compatible for SAM9X60 HLCD controller
  pwm: atmel-hlcdc: add compatible for SAM9X60 HLCDC's PWM

Sandeep Sheriker Mallikarjun (2):
  drm: atmel-hlcdc: enable sys_clk during initalization.
  drm: atmel-hlcdc: add sam9x60 LCD controller

 .../devicetree/bindings/mfd/atmel-hlcdc.txt        |   1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |  18 ++--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       | 120 +++++++++++++++++=
+++-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |   2 +
 drivers/mfd/atmel-hlcdc.c                          |   1 +
 drivers/pwm/pwm-atmel-hlcdc.c                      |   3 +
 6 files changed, 135 insertions(+), 10 deletions(-)

--=20
2.7.4

