Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CD0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DCA20835
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="v4EphHoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfCROmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:42:06 -0400
Received: from mail-eopbgr150053.outbound.protection.outlook.com ([40.107.15.53]:41806
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727457AbfCROmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6BvIrILYRIBPCb3KOEKKgJhdYG51U3hZduCIoFftLI=;
 b=v4EphHoR9XiVbavO+y1bwqa++keHFSlUte++f9qV8jjjUQ0o54TG0jC7KGC6tEDqTo2iIRrlwDJ7eQxEPqzz68Hdq5+oHanCU3f4qcIUwLfEnzHZ/1J3NmsXMoVWmn73EpzMIwfrLHp2A5+447zEt4EMAXufw4emjuCcaIeGovw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3770.eurprd04.prod.outlook.com (52.134.73.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 14:42:00 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 14:42:00 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 2/5] pwm: Add i.MX TPM PWM driver support
Thread-Topic: [PATCH V4 2/5] pwm: Add i.MX TPM PWM driver support
Thread-Index: AQHU2siU0bWGOMWkiUi6PBGed50RsKYMb0wAgARM6KCAAFGOgIAAHj9ggAA/s6CAAAeDgIAAB+Tg
Date:   Mon, 18 Mar 2019 14:42:00 +0000
Message-ID: <DB3PR0402MB391633E42A4139C10A0A226DF5470@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1552610505-13568-1-git-send-email-Anson.Huang@nxp.com>
 <1552610505-13568-3-git-send-email-Anson.Huang@nxp.com>
 <20190315093532.xw5ivfkxrwvrkvix@pengutronix.de>
 <DB3PR0402MB39161B062231C59842595374F5470@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190318080743.xumj6e72bzumszvp@pengutronix.de>
 <DB3PR0402MB391627A8C741C84A2057E576F5470@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39161A9884D5768F7280024FF5470@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190318141051.t2x2ddz73fmksadq@pengutronix.de>
In-Reply-To: <20190318141051.t2x2ddz73fmksadq@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d899a85-25d0-4643-bdd0-08d6abafe15d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3770;
x-ms-traffictypediagnostic: DB3PR0402MB3770:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0402MB37703EB91A39EC9D586EF527F5470@DB3PR0402MB3770.eurprd04.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(13464003)(199004)(6116002)(3846002)(446003)(66574012)(33656002)(11346002)(68736007)(186003)(81166006)(26005)(8676002)(81156014)(14454004)(478600001)(6916009)(6506007)(8936002)(256004)(5660300002)(102836004)(229853002)(53546011)(305945005)(45080400002)(6246003)(53936002)(14444005)(7736002)(52536014)(86362001)(76176011)(2906002)(74316002)(4326008)(25786009)(99286004)(7696005)(9686003)(66066001)(6306002)(55016002)(476003)(6436002)(71190400001)(105586002)(93886005)(97736004)(71200400001)(486006)(966005)(106356001)(44832011)(316002)(54906003)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3770;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 29wevhqTkq5to6PmpqrHBWqCUDjc83LLTKAJ/MtSghuiEgNC41TsqwxnbUqK/L6avmrls6h1AF4MKbzLQVtaToUa6CxzFJ3vb8KFoI98+gt2+kMJQg2IKbuI+YjPv7CNnPW8/Aee11zHO0v1UES4iFdggvPDngNiNgb2UG5QDTJWJE0cM3QeQ44au1UXErZgP45tnCD3Hvb5BTBtCIduW3cQ0aGgvMPWS4U0spugB7slsQ2YbnmsrZqlxrzfae5CnBtXcQbUABEPdHIZKBVChvS2lbKkB1s4D224U87hJ8WkO+WaBJApet7d2k/PlrL8FDceySzPm1d3/4D4o/VUTxViLG1PpPA7O0ILG0r8j5+ZqNzA7UV5gMM7VUOQVcrTlcK1LHCvvPfusU6oCDPOCeh3oGKQWaIAKymxywx9dQw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d899a85-25d0-4643-bdd0-08d6abafe15d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 14:42:00.7096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3770
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFV3ZQ0KCVllcywgSSB3aWxsIHBvc3QgYSBWNiwgYnV0IGJlZm9yZSBzZW5kaW5nIFY2LCBj
YW4geW91IGhlbHAgY29uZmlybSBpZiB5b3UgYWdyZWUgbXkgMiBhbnN3ZXJzIGZvciB5b3VyIGxh
c3QgY29tbWVudHMsIHN1Y2ggYXMgdGhlIGNvdW50ZXIgZGlzYWJsZSBmb3IgY2hhbmdpbmcgcHJl
c2NhbGUgYW5kIHRoZSBtdXRleCBsb2NrIGluIC5hcHBseSBmdW5jdGlvbj8NCg0KQmVzdCBSZWdh
cmRzIQ0KQW5zb24gSHVhbmcNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBVd2UgS2xlaW5lLUvDtm5pZyBbbWFpbHRvOnUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5k
ZV0NCj4gU2VudDogMjAxOeW5tDPmnIgxOOaXpSAyMjoxMQ0KPiBUbzogQW5zb24gSHVhbmcgPGFu
c29uLmh1YW5nQG54cC5jb20+DQo+IENjOiB0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb207IHJvYmgr
ZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5v
cmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZmVz
dGV2YW1AZ21haWwuY29tOyBsaW51eEBhcm1saW51eC5vcmcudWs7IG90YXZpb0Bvc3N5c3RlbXMu
Y29tLmJyOw0KPiBzdGVmYW5AYWduZXIuY2g7IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVz
dGV6QG54cC5jb20+Ow0KPiBzY2huaXR6ZWx0b255QGdtYWlsLmNvbTsgamFuLnR1ZXJrQGVtdHJp
b24uY29tOyBSb2JpbiBHb25nDQo+IDx5aWJpbi5nb25nQG54cC5jb20+OyBsaW51eC1wd21Admdl
ci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCBWNCAyLzVdIHB3bTogQWRkIGkuTVggVFBNIFBXTSBkcml2ZXIgc3VwcG9ydA0KPiANCj4gSGVs
bG8sDQo+IA0KPiBhcyB5b3UgZ290IHNvbWUgZmVlZGJhY2sgZm9yIHY1IGFscmVhZHkgSSBhc3N1
bWUgeW91IHdpbGwgcG9zdCBhIHY2Lg0KPiBJJ2xsIHNraXAgcmV2aWV3aW5nIHY1IHRoZW4uDQo+
IA0KPiBCZXN0IHJlZ2FyZHMNCj4gVXdlDQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCBVd2UgS2xlaW5lLUvDtm5pZyAgICAgICAgICAgIHwN
Cj4gSW5kdXN0cmlhbCBMaW51eCBTb2x1dGlvbnMgICAgICAgICAgICAgICAgIHwNCj4gaHR0cHM6
Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYl
MkZ3d3cucA0KPiBlbmd1dHJvbml4LmRlJTJGJmFtcDtkYXRhPTAyJTdDMDElN0NhbnNvbi5odWFu
ZyU0MG54cC5jb20lN0M3OQ0KPiA3NTE0YWZmZmNiNGY3OTliZjQwOGQ2YWJhYjkxODglN0M2ODZl
YTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNQ0KPiAlN0MwJTdDMCU3QzYzNjg4NTE1MDcwNjQx
NzIwMSZhbXA7c2RhdGE9a1Z1dDFYOEp0akdkR09NMmN6eVJSYw0KPiA1ZGk3N0kySHU4ZFF0dGY4
REpuMUElM0QmYW1wO3Jlc2VydmVkPTAgIHwNCg==
