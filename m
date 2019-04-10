Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC960C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDE52084F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VDZr6h/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfDJBrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:47:35 -0400
Received: from mail-eopbgr130057.outbound.protection.outlook.com ([40.107.13.57]:49859
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726577AbfDJBre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 21:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvNOP5KctiIpCRJy3YjIizn1F1dxQD7tFIQfoRG7ZyE=;
 b=VDZr6h/fL2hPOL6anXSkPtH2nN6t0TN+/oabClTh+5wi4B8g7mHmtoS04hxRctcM13u55tJRoIKMfTj3i2q6KohGQ5+0Dg4ojd6+GG96yhi4yw5Vohzho87blDjOm6ONQjHJRSoxrlGt9oy0BhfqfJMTVpt+IcWfKepA8r514Co=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3721.eurprd04.prod.outlook.com (52.134.67.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Wed, 10 Apr 2019 01:47:29 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 01:47:29 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V11 0/5] Add i.MX7ULP EVK PWM backlight support
Thread-Topic: [PATCH V11 0/5] Add i.MX7ULP EVK PWM backlight support
Thread-Index: AQHU7z9bBIw0J0eEykuFfv84e8UBBw==
Date:   Wed, 10 Apr 2019 01:47:28 +0000
Message-ID: <1554860547-18237-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::14) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa4667a9-15b9-4b3e-99c0-08d6bd567d19
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3721;
x-ms-traffictypediagnostic: DB3PR0402MB3721:
x-microsoft-antispam-prvs: <DB3PR0402MB37219BAE6D8FCA1035BCF493F52E0@DB3PR0402MB3721.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(2201001)(71190400001)(71200400001)(97736004)(105586002)(68736007)(6436002)(14454004)(8676002)(8936002)(478600001)(50226002)(81166006)(81156014)(7736002)(256004)(53936002)(25786009)(6512007)(305945005)(4326008)(6486002)(26005)(7416002)(106356001)(36756003)(66066001)(186003)(3846002)(6116002)(52116002)(316002)(102836004)(4744005)(6506007)(386003)(486006)(2906002)(110136005)(86362001)(2616005)(476003)(2501003)(5660300002)(99286004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3721;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GC8CAhNReNL+bI3obr8UnqawubcLEULb/zTO//Ehg1Uy6cTKPKNPYRly1aeTkScNJUzzED3V5P2p41wU6fOgH0+5eOuQsTBMmFI2iNAuCaInit51ITft+lIsF+XBeIXSV7OhbxNV5ZuOYQ5511TCOLylWUXu5Kxuhx7srIYLh4IglMe8LNSkITsGukl9nRd7u/i6E9qXdV/3cUbvSORC2qFFYINz0CrYta4ojKJe11zAca0h1iBXi9u5iFf4LzlLZMi4mutRuGQUxZ/j4iMbcecEYqiUpiJ0wJl6nGb40EKNRTzlbMY8aj0GjtkfNoxpy1hu4mByfTGpb2Lvs1oaH309tu9DEs8/sJeeyr5ipnm4HNRJSrCkQL/5i6YgucIt3bFxnI+sZWKni8bSYL2qfsnpcO3IVXQ8M3fLg+HJlkM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4667a9-15b9-4b3e-99c0-08d6bd567d19
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 01:47:29.0045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aS5NWDdVTFAgRVZLIGJvYXJkIGhhcyBNSVBJLURTSSBkaXNwbGF5LCBpdHMgYmFja2xpZ2h0IGlz
IHN1cHBsaWVkIGJ5DQpUUE0gUFdNIG1vZHVsZSwgdGhpcyBwYXRjaCBzZXQgZW5hYmxlcyBpLk1Y
N1VMUCBUUE0gUFdNIGRyaXZlciBzdXBwb3J0DQphbmQgYWxzbyBhZGQgYmFja2xpZ2h0IHN1cHBv
cnQgZm9yIE1JUEktRFNJIGRpc3BsYXkuDQoNCkNoYW5nZXMgc2luY2UgVjEwOg0KCS0gT05MWSBj
aGFuZ2UgdGhlIHB3bSBkcml2ZXIgcGF0Y2guDQoNCkFuc29uIEh1YW5nICg1KToNCiAgZHQtYmlu
ZGluZ3M6IHB3bTogQWRkIGkuTVggVFBNIFBXTSBiaW5kaW5nDQogIHB3bTogQWRkIGkuTVggVFBN
IFBXTSBkcml2ZXIgc3VwcG9ydA0KICBBUk06IGlteF92Nl92N19kZWZjb25maWc6IEFkZCBUUE0g
UFdNIHN1cHBvcnQgYnkgZGVmYXVsdA0KICBBUk06IGR0czogaW14N3VscDogQWRkIHRwbSBwd20g
c3VwcG9ydA0KICBBUk06IGR0czogaW14N3VscC1ldms6IEFkZCBiYWNrbGlnaHQgc3VwcG9ydA0K
DQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2lteC10cG0tcHdtLnR4dCAgICAgICAgfCAg
MjIgKw0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAtZXZrLmR0cyAgICAgICAgICAgICAgICAg
IHwgIDIxICsNCiBhcmNoL2FybS9ib290L2R0cy9pbXg3dWxwLmR0c2kgICAgICAgICAgICAgICAg
ICAgICB8ICAxMCArDQogYXJjaC9hcm0vY29uZmlncy9pbXhfdjZfdjdfZGVmY29uZmlnICAgICAg
ICAgICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvcHdtL0tjb25maWcgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDExICsNCiBkcml2ZXJzL3B3bS9NYWtlZmlsZSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgMSArDQogZHJpdmVycy9wd20vcHdtLWlteC10cG0uYyAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCA0NDIgKysrKysrKysrKysrKysrKysrKysrDQogNyBmaWxl
cyBjaGFuZ2VkLCA1MDggaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2lteC10cG0tcHdtLnR4dA0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL3B3bS9wd20taW14LXRwbS5jDQoNCi0tIA0KMi43LjQNCg0K
