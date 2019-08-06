Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307CCC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4542147A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZvkjljPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbfHFF7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 01:59:53 -0400
Received: from mail-eopbgr150051.outbound.protection.outlook.com ([40.107.15.51]:19776
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfHFF7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:59:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuE7zQQhPqSnEr14j3huGeGEh57Psq6dLcKGwzxS3taG5F/ekEC64Jw3bBP7DUV6VrmRWlW8yYYrMmFgERM0EB608gGtgMjWF6CrCd6hrDL5BQ9HCRHWYo9XUW1sybHs+Nn6vdiWPtp7NKlknnFJB/JyvFahxQ7dOyt+bbKnjt51FuUu4xLa8vo73SK+mg1lBUwa/SoyaL93hoEIUqpBhU2NX9ImNrLx61iQWu72Wd28YeACFq0o6KIJDfzUblre06FC3r2SDNmLdUM/7nVuUpc6bK+aMkbedTMBm0lZIxJIhheeO/cjOKkm9jqfYxIHUZ1fQJ2f+MCI/xf5V3Vs4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GcMyhvE+5eLLg+b/U06AzQs+m/saK1tkaSMk7DeU0s=;
 b=QuoLBPJeQ0r8HtsxXrbZbxOtYZjmaV2X5mhE0b/PjVP6R0sgnveVdUyAJF9q/tF6WQY7Ogf9zGWRCtNMuk2QiZ8EhV3NXBzP7J+Bc8qhwiBOEkxF/oz070SmAIZ7ys3g1P1BbHuWNbL4x8zihb/sCDo7sVQ6f3IBlDSK940olNNYqyIjo8VbyQjOgsfIBt1KtrNvVAGBJo+BkcK6+1h7e4AO/SfPtXtYvowtD/mgjYvuvwmlpSZIYiO5YYYqtTfaGkWtgh8k+YX9E0eSDReYNBP+rCmQ3Fw7EcRFcW7dMzor9L4EkpfxuBltTH0qbTMHVMJx7mSLSKuFp5zbzrCWSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GcMyhvE+5eLLg+b/U06AzQs+m/saK1tkaSMk7DeU0s=;
 b=ZvkjljPuK17d5TOczKXR62ggPYAAJCFTcfP+3rSFvBoKJo5LpTx6iyw3luqa1k5KIfMIIYTscYyPTjSYpckXNfUpCw2qJqgllpxNYh7BtCW5wh8dSs6MfR4KD65wbBLyyzCrVdC1QrnmoZf/l390Hmj5AG5XdtY1Ti8HTiTL92Y=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3642.eurprd04.prod.outlook.com (52.134.65.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Tue, 6 Aug 2019 05:59:49 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e%4]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 05:59:49 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] dt-bindings: imx-ocotp: Add i.MX8MN compatible
Thread-Topic: [PATCH 1/2] dt-bindings: imx-ocotp: Add i.MX8MN compatible
Thread-Index: AQHVN5LXMlVDxHijuUG4VBGBLZ+VOKbtyQUQ
Date:   Tue, 6 Aug 2019 05:59:49 +0000
Message-ID: <DB3PR0402MB391647D2B63F69C53BB6CE81F5D50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190711023714.16000-1-Anson.Huang@nxp.com>
In-Reply-To: <20190711023714.16000-1-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac1c9e7e-ae0d-436b-e2e8-08d71a334aa6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3642;
x-ms-traffictypediagnostic: DB3PR0402MB3642:
x-microsoft-antispam-prvs: <DB3PR0402MB3642272BC7732EBC3466EFE0F5D50@DB3PR0402MB3642.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(199004)(189003)(64756008)(66446008)(7416002)(71190400001)(71200400001)(44832011)(486006)(7696005)(476003)(74316002)(11346002)(446003)(68736007)(86362001)(14454004)(4326008)(2201001)(478600001)(25786009)(316002)(6246003)(6436002)(76116006)(33656002)(305945005)(7736002)(26005)(3846002)(5660300002)(110136005)(55016002)(186003)(9686003)(6116002)(66946007)(66556008)(2501003)(76176011)(229853002)(2906002)(66066001)(99286004)(53936002)(102836004)(52536014)(66476007)(8676002)(81156014)(81166006)(6506007)(256004)(8936002)(14444005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3642;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bWR1id5VTU59HXcIOfEIznZ0m7vkbkf9UnJZNhpRGkmtw69B/sa1tiJ1Drjn1GAZew52Si2WMAMOCDtN2slvb0nwmR9mSBl92J1+lFcwuRZ3a665GfM3sX08jjBfDOV32J/07S6vPIREfK6tEviPikbyS64l9VBmAp2dFA/s+g/3GhM7Ef9vzZw/ZdfDo4X0ITxs4TGQN06wZ/hJhECT9JyBL0DQi6d55WYUkxzEh9ej6PsOP2nQnEuul2VOQrfEI305obVau04NyUmtthRfza3aUVRBfmcplI6NFnPJJGZx6HREqrmC2IGSkSarhSTk1nwj2AvDaR43hpCyvsz5hg0N8uCiL23yi0Ge19io//6r2pT+jkF8uXYr27jhuZ09CbqydsKCVd+c9MkSmNJoxCw3Bz+krONvYKILJaAP4HI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1c9e7e-ae0d-436b-e2e8-08d71a334aa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 05:59:49.2900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3642
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VudGxlIFBpbmcuLi4NCg0KPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNv
bT4NCj4gDQo+IEFkZCBjb21wYXRpYmxlIGZvciBpLk1YOE1OIGFuZCBhZGQgaS5NWDhNTS9pLk1Y
OE1OIHRvIHRoZSBkZXNjcmlwdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5n
IDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9udm1lbS9pbXgtb2NvdHAudHh0IHwgMyArKy0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbnZtZW0vaW14LW9jb3RwLnR4dA0KPiBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9udm1lbS9pbXgtb2NvdHAudHh0DQo+IGlu
ZGV4IDk2ZmZkMDYuLjkwNGRhZGYgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9udm1lbS9pbXgtb2NvdHAudHh0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9udm1lbS9pbXgtb2NvdHAudHh0DQo+IEBAIC0yLDcgKzIsNyBA
QCBGcmVlc2NhbGUgaS5NWDYgT24tQ2hpcCBPVFAgQ29udHJvbGxlciAoT0NPVFApIGRldmljZQ0K
PiB0cmVlIGJpbmRpbmdzDQo+IA0KPiAgVGhpcyBiaW5kaW5nIHJlcHJlc2VudHMgdGhlIG9uLWNo
aXAgZUZ1c2UgT1RQIGNvbnRyb2xsZXIgZm91bmQgb24NCj4gaS5NWDZRL0QsIGkuTVg2REwvUywg
aS5NWDZTTCwgaS5NWDZTWCwgaS5NWDZVTCwgaS5NWDZVTEwvVUxaLCBpLk1YNlNMTCwgLQ0KPiBp
Lk1YN0QvUywgaS5NWDdVTFAgYW5kIGkuTVg4TVEgU29Dcy4NCj4gK2kuTVg3RC9TLCBpLk1YN1VM
UCwgaS5NWDhNUSwgaS5NWDhNTSBhbmQgaS5NWDhNTiBTb0NzLg0KPiANCj4gIFJlcXVpcmVkIHBy
b3BlcnRpZXM6DQo+ICAtIGNvbXBhdGlibGU6IHNob3VsZCBiZSBvbmUgb2YNCj4gQEAgLTE2LDYg
KzE2LDcgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4gIAkiZnNsLGlteDd1bHAtb2NvdHAiIChp
Lk1YN1VMUCksDQo+ICAJImZzbCxpbXg4bXEtb2NvdHAiIChpLk1YOE1RKSwNCj4gIAkiZnNsLGlt
eDhtbS1vY290cCIgKGkuTVg4TU0pLA0KPiArCSJmc2wsaW14OG1uLW9jb3RwIiAoaS5NWDhNTiks
DQo+ICAJZm9sbG93ZWQgYnkgInN5c2NvbiIuDQo+ICAtICNhZGRyZXNzLWNlbGxzIDogU2hvdWxk
IGJlIDENCj4gIC0gI3NpemUtY2VsbHMgOiBTaG91bGQgYmUgMQ0KPiAtLQ0KPiAyLjcuNA0KDQo=
