Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCB7C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B78620684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kIjprVmz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfCFOkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:40:35 -0500
Received: from mail-eopbgr130082.outbound.protection.outlook.com ([40.107.13.82]:34017
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726913AbfCFOkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCIIEC/oKgGWxW+isMf8jTVxuMz/tdztkYK06cO5uKU=;
 b=kIjprVmzSEOPZz/XvgYGTdlRsxb7dzdBF4AbdB7eoo2sJQy52pWxJG2smmlgk3ysoHpgyPB0us16iBFxl0Janz1M0RHukDkPLG53YFnd/akDG+VBV0ef2MFNbz9hyueMoO/aslx4+hb+FabJIrA0/IW4FF2szXD35sWE9vzbXzs=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6673.eurprd04.prod.outlook.com (20.179.255.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.17; Wed, 6 Mar 2019 14:40:23 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79%2]) with mapi id 15.20.1686.016; Wed, 6 Mar 2019
 14:40:23 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>, Rob Herring <robh@kernel.org>,
        "edubezval@gmail.com" <edubezval@gmail.com>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V10 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V10 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHUznjp1VM2Vv0vQ0qLNAgNlgUeAaX0UrqAgAALZRCAAO51AIAAsZeggAi3lgA=
Date:   Wed, 6 Mar 2019 14:40:22 +0000
Message-ID: <AM0PR04MB4211F00DF5BF24BB982AFB3280730@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1551256894-21954-1-git-send-email-Anson.Huang@nxp.com>
 <20190227235455.GA15211@bogus>
 <DB3PR0402MB391673518C43A0ABE9BDB55FF5750@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAL_JsqJct4BztHEak+=iNK3G7dwYR-pQPeUqb4kBnEdRQMLr6A@mail.gmail.com>
 <DB3PR0402MB3916D67D2CA6C33D27371F58F5760@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916D67D2CA6C33D27371F58F5760@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a02f20d-8b5c-4489-09eb-08d6a241aa1f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6673;
x-ms-traffictypediagnostic: AM0PR04MB6673:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI2NjczOzIzOjFtNDZ0VVNNWE90cEtxWlhOM0dhcy9pdkVr?=
 =?utf-8?B?S0NFb1doTTNvTm9oVmRSdU1ncTY0NjZ2b2hCUGFkaDl0d0ljTnU3UTMxWjVz?=
 =?utf-8?B?TW9kY3M5a0p4ZVhlOEVOUFRXZndWUTV0VGVoelZmY0YzejFqc1JKall6aU41?=
 =?utf-8?B?azdnTERLU01CQ1Zsb2p0YTRoS05MVlJMb0hWa1dZZzlzT3VKS0lXWG5YdG94?=
 =?utf-8?B?NHZSZk5WUGx0ZUlvaHV4Ymx6VmVTR0poc1E4cTFQa3dvUE9kOGNDUkFxQXMy?=
 =?utf-8?B?MTBteEROclVHbzdUU2NkV21CQ3prQk5LU1pUS1o4VWFoeDNRVXNXYWI5dlZi?=
 =?utf-8?B?cERTdkJTVnoyWm1OaXRpVnpVMVVreUUvT203N3FUMHpVVjFUY1Fab1gyc1Vp?=
 =?utf-8?B?Zi94VWFrQmUwZ3FtN0VUa1BHOVJTcTFiYUlsNGVZTWVVempQRHh4Qi9lU0Nt?=
 =?utf-8?B?LytjZEtNZnVqY1VFeExRSEtwN21vVHJtLytuUzhkMWJVZEhwUnk2eEdlSFVG?=
 =?utf-8?B?Q2VwemZBUVlFWFVWZlB1eTRBdFM1Y1Q4Rm5oVkh6VXFEdy9NaU1CZ2hTN2RR?=
 =?utf-8?B?TnRzQ3NRbDIyNmNJb21hMC9yNkpla293NUhtc0pHRktXSUNDa2FkVmtDUTd3?=
 =?utf-8?B?TzQrclRKNm01YWZpT3djRFplblhXZG9la2ltbGUwVWt6ZkR5Ky9RakRVZXJu?=
 =?utf-8?B?Ni9YckxuZ3p5VDVueStEYnplMEhNK2VjVCtyLzRjZTRENHpFYjU3QWcvbUpm?=
 =?utf-8?B?dWNxQXNZL2I4R1FOYWNIelhvem0yMFpOSkZtQjkxY1lLM1NKUlVRdjNIZEZk?=
 =?utf-8?B?bkxJNzlKTTJOaDU3eE5ZbVNTYmZya3N5ck8rN3dXbVE4RC9DVFJ5cy9lYllt?=
 =?utf-8?B?QzY0OFloWjBmUGlOSTFUemphVXJBY2lzT1orekdNZWRacHo4Znc1YVRnak1X?=
 =?utf-8?B?b0pDeE1FS3N3Y0pPTjBBUU5LcmU4STZRT2h0VWtVZlAwa3F2c0w4RUNmZlFy?=
 =?utf-8?B?b2NXZ3J2TithLy9Ja2M0TnpnOVIrWmE2d0diaXZwVEJSeUxibXpUbzM5T0NZ?=
 =?utf-8?B?Z2J2aE1Ya2ZoSE5VeEdRWnpTYWpubGhHQW91Mnd6WG5xdjlUNjM2dlNaem13?=
 =?utf-8?B?My9ub3FRUEN1MGU5eERuTmVsZno1NmlaaDVoL01zZEtQbW90WldaTTZrV2dx?=
 =?utf-8?B?MWp4aWxlU01qN1cxWG5OdkhJY2tsRG53VlNHRVo2RE1hanFzVjB4bTFsdEZS?=
 =?utf-8?B?SGRKMjhKMHpxSytNeXE0eTJqVWlXMXpmc2NrdWU3aHNTeDNQOEM3TEJFTXNo?=
 =?utf-8?B?LzdQVjE1c005aG0zbGVDcFBTS3J4ZGhjS0pwNWZ6Ky85TERLaFBZbzNvS3Jm?=
 =?utf-8?B?K0h0c2VjcVNPNzFFTWV2cDBCWFNseHczbU5mZFlBaEJpY041K1FDTHliNzdn?=
 =?utf-8?B?NVlJR2V0VzFCV2l2akFpeEcwc1I1Qk1zcVJGR1VOZUdpcHJlV3o4OXRhRExZ?=
 =?utf-8?B?MFVrbmg4MTNRR2Z1Yk00TnhOM0swbVN0TVk4SEZGdmEyUjZ4cGtpWG4vaHd5?=
 =?utf-8?B?dUpOSUxTeHpyQWpWUGxLK0RRMjVwMDU1amlhb2JVUDQvVGduOWFlVnV2bzZr?=
 =?utf-8?B?Q1JxVGh6REhwbmN3K1BNcmVBeTk3Y0tuNFhqV0xjd1dLRGV2eHVacThJN3F1?=
 =?utf-8?B?cGRLTktrcjRHdjlFZFZwL1o4ZkRJakVzM3YveCtBamVVVHA3Z1p5UzVOV056?=
 =?utf-8?B?YXZRK3hEVGpjc1p4c0lpRVhSaGVXdU1DTkhnQWlMU1lDMDYzQ2ZDeVZKeUVj?=
 =?utf-8?Q?2ii52ZbGZTExX?=
x-microsoft-antispam-prvs: <AM0PR04MB6673EEA227E1AB6B56D75A8A80730@AM0PR04MB6673.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(39860400002)(346002)(136003)(199004)(189003)(229853002)(316002)(81166006)(2906002)(4326008)(7736002)(76176011)(54906003)(7696005)(110136005)(446003)(97736004)(476003)(93886005)(11346002)(8676002)(81156014)(86362001)(8936002)(74316002)(33656002)(486006)(66066001)(71200400001)(7416002)(5660300002)(2501003)(44832011)(55016002)(99286004)(105586002)(6436002)(52536013)(71190400001)(68736007)(9686003)(6306002)(106356001)(14454004)(6246003)(26005)(3846002)(305945005)(6116002)(25786009)(478600001)(6506007)(102836004)(53936002)(966005)(256004)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6673;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XzMhN17Bfh0eXgjUTwhZl67fKg0w/DMASLvfhG3+3JwNW4dz0+vptOuwxApHDa5jy7k62Q69/+D/VA1zEVvr8lirvWH7jLoavexMB1jtFW/yBqz49Gi+4kY08hl6DmgtyA9uoNCOlsenLd3DdfESWX6sNkV/S3nwj1ZyuctHhMg+hPB5+DGltdBwD7nc4Fyu6mcea9KrBJ/JOGcRFf0seDrClicNT2xnD0UqVjP/VFDoBdMsRxg+0g+MiCopi0GQwf1I9tdP0cUApLAR4VSUsytv6H1DIqa0cpg+7asluii6pt0ou8tHqbUggDVmek0nHOnGYnr6J4UkikCjwDIy121mZpAfnCfGV2il+vNVpk3XjULUs2ftC5nTsw0x3nnMB9tkcLzq4xO5VdwSqJOFjUcitFFfTZxVtXrb6J2LJhw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a02f20d-8b5c-4489-09eb-08d6a241aa1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 14:40:22.8957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wy4uLl0NCg0KPiA+ID4gPiA+IGRpZmYgLS1naXQNCj4gPiA+ID4gPiBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+ID4gPiA+ID4g
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1
LnR4dA0KPiA+ID4gPiA+IGluZGV4IDcyZDQ4MWMuLjg1NTI3MGIgMTAwNjQ0DQo+ID4gPiA+ID4g
LS0tDQo+ID4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2Zy
ZWVzY2FsZS9mc2wsc2N1LnR4dA0KPiA+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHgNCj4gPiA+ID4gPiArKysgdA0K
PiA+ID4gPiA+IEBAIC0xMjIsNiArMTIyLDIxIEBAIFJUQyBiaW5kaW5ncyBiYXNlZCBvbiBTQ1Ug
TWVzc2FnZSBQcm90b2NvbA0KPiA+ID4gPiA+IFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gPiA+
ID4gIC0gY29tcGF0aWJsZTogc2hvdWxkIGJlICJmc2wsaW14OHF4cC1zYy1ydGMiOw0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gK1RoZXJtYWwgYmluZGluZ3MgYmFzZWQgb24gU0NVIE1lc3NhZ2UgUHJv
dG9jb2wNCj4gPiA+ID4gPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICtSZXF1aXJlZCBw
cm9wZXJ0aWVzOg0KPiA+ID4gPiA+ICstIGNvbXBhdGlibGU6ICAgICAgICAgICAgICAgICAgICAg
IFNob3VsZCBiZSA6DQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImZz
bCxpbXg4cXhwLXNjLXRoZXJtYWwiDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGZvbGxvd2VkIGJ5ICJmc2wsaW14LXNjLXRoZXJtYWwiOw0KPiA+ID4gPiA+ICsNCj4gPiA+
ID4gPiArLSAjdGhlcm1hbC1zZW5zb3ItY2VsbHM6ICAgU2VlDQo+ID4gPiA+IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy90aGVybWFsL3RoZXJtYWwudHh0DQo+ID4gPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGZvciBhIGRlc2NyaXB0aW9uLg0KPiA+ID4gPiA+ICsN
Cj4gPiA+ID4gPiArLSBpbXgsc2Vuc29yLXJlc291cmNlLWlkOiAgQSBzaW5nbGUgaW50ZWdlciBm
b3Igc2luZ2xlIHRoZXJtYWwNCj4gPiA+ID4gPiArem9uZSdzDQo+ID4gPiA+IHJlc291cmNlIElE
IG9yDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGFuIGFycmF5IG9mIGlu
dGVnZXJzIHRvIHNwZWNpZnkgZWFjaA0KPiA+ID4gPiA+ICsgdGhlcm1hbA0KPiA+ID4gPiB6b25l
J3Mgc2Vuc29yDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlc291cmNl
IElELg0KPiA+ID4gPg0KPiA+ID4gPiBDYW4ndCB5b3UgcHV0IHRoZSByZXNvdXJjZSBpZHMgaW4g
dGhlIHRoZXJtYWwtc2Vuc29yIGNlbGxzPyBXaHkgZG8NCj4gPiA+ID4geW91IG5lZWQgdG8gbGlz
dCB0aGVtIGhlcmU/DQo+ID4gPg0KPiA+ID4gRm9yIHRoZSB0aGVybWFsLXNlbnNvciBjZWxscywg
aWYgeW91IG1lYW50IHRoZSBhcmd1bWVudCBvZiB0c2Vucw0KPiA+ID4gcGhhbmRsZSwgdGhlbiB0
aGUgcmVhc29uIGlzIHRoYXQgYXJndW1lbnQgaXMgZm9yIHNlbnNvciBpbmRleA0KPiA+ID4gc3Rh
cnRpbmcgZnJvbSAwLCBwcmV2aW91cyBJIHVzZSBpdCBmb3Igb3VyIHJlc291cmNlIElELCBidXQg
aXQgbG9va3MNCj4gPiA+IGNvbmZ1c2VkLCBzaW5jZSB1c2VyIHdpbGwgdGhpbmsgdGhlcmUgYXJl
IG1hbnkgc2Vuc29ycyB0aGVyZSBwZXIgRWR1YXJkbydzDQo+IGNvbW1lbnQuDQo+ID4gPg0KPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgdGhlcm1hbC1zZW5zb3JzID0gPCZ0c2VucyAwPjsN
Cj4gPiA+DQo+ID4gPiBJZiB5b3UgbWVhbnQgcHV0dGluZyBpdCBpbiBlYWNoIHRoZXJtYWwgc2Vu
c29yIG5vZGUgaW5zdGVhZCBvZiAidHNlbnMiDQo+ID4gPiBub2RlLCB0aGVuIGluIHByZXZpb3Vz
IHBhdGNoIHNlcmllcywgSSBwdXQgdGhpcyAiDQo+ID4gPiBpbXgsc2Vuc29yLXJlc291cmNlLWlk
ICIgcHJvcGVydHkgaW4gZWFjaCB0aGVybWFsIHNlbnNvciBub2RlLCBidXQNCj4gPiA+IHRoZSB0
aGVybWFsIHNlbnNvciBub2RlcyBhcmUgcGFyc2VkIGJ5IGNvbW1vbiB0aGVybWFsIGZyYW1ld29y
aywNCj4gPiA+IHRoZXJtYWwgZHJpdmVyIHdpbGwgbmVlZCB0byBmaW5kIHRoZSB0aGVybWFsIHpv
bmUgbm9kZSBhbmQgZ28NCj4gPiA+IHRocm91Z2ggZXZlcnkgY2hpbGQgbm9kZSB0byBnZXQgdGhl
IHJlc291cmNlIGlkIGFnYWluLCBzbyBFZHVhcmRvDQo+ID4gPiBzdWdnZXN0ZWQgdG8gcHV0IGl0
IGluDQo+ID4gb3VyIHBsYXRmb3JtIHRzZW5zIG5vZGUsIHRoYXQgbWFrZXMgb3VyIHRoZXJtYWwg
ZHJpdmVyIGNvZGUgbXVjaCBtb3JlDQo+ID4gc2ltcGxlLg0KPiA+DQo+ID4gVGhlIHBoYW5kbGUg
YXJncyBhcmUgbWVhbnQgdG8gYmUgYW4gaWQgdHlwaWNhbGx5LiBUaGVyZSdzIGFic29sdXRlbHkN
Cj4gPiBubyByZXF1aXJlbWVudCB0aGV5IGFyZSAwLU4gYmFzZWQuIFRoZXkgb2Z0ZW4gYXJlIGJl
Y2F1c2UgdGhpbmdzIGxpa2UNCj4gPiBpbnRlcnJ1cHRzIGFyZSAwLU4gb3IgY2xvY2tzIGhhdmUg
bm8gaC93IGlkLiBJZiB5b3UgYWxyZWFkeSBoYXZlIGFuIGlkLCB1c2UgaXQuDQo+ID4gRG9uJ3Qg
aW52ZW50IHlvdXIgb3duLg0KPiANCj4gQXQgdGhlIGJlZ2lubmluZywgSSBwdXQgdGhlIEhXIHJl
c291cmNlIElEIGluIHRoZSAidHNlbnMiIHBoYW5kbGUgYXJndW1lbnQgb2YNCj4gInRoZXJtYWwt
c2Vuc29ycyIgbm9kZSwgc2VlICBiZWxvdyBwYXRjaCBJIHNlbnQgYmVmb3JlLCB0aGUgYmVuZWZp
dCBpcyBJIGRvDQo+IE5PVCBuZWVkIHRvIGFkZCBuZXcgcHJvcGVydHkgZm9yIHBhc3NpbmcgSFcg
cmVzb3VyY2UgSUQgdG8gZHJpdmVyLCB0aGUNCj4gZGlzYWR2YW50YWdlIGlzLCBJIGhhdmUgdG8g
cGFyc2UgdGhlIHRoZXJtYWxfem9uZXMnIGVhY2ggY2hpbGQgbm9kZSBhbmQgZ2V0IHRoZQ0KPiBI
VyByZXNvdXJjZSBJRCBmcm9tIHBoYW5kbGUgYXJndW1lbnQoc2VhcmluZyB0aGVybWFsX3pvbmVz
IG5vZGUgYW5kIGdvDQo+IHRocm91Z2ggYWxsIGl0cyBjaGlsZCBub2RlLCBhbmQgZ2V0IHRoZSBw
aGFuZGxlIGFyZ3VtZW50KSwgdGhleSBhcmUgYnkgZGVmYXVsdA0KPiBPTkxZIHBhcnNlZCBieSB0
aGVybWFsIGNvcmUgZHJpdmVyLiBXaGVuIHdlIHJlZ2lzdGVyIHRoZXJtYWwgem9uZSwgd2UgaGF2
ZQ0KPiB0byBwYXNzIHRoZSBIVyByZXNvdXJjZSBJRCB3aGVuIGNhbGxpbmcNCj4gZGV2bV90aGVy
bWFsX3pvbmVfb2Zfc2Vuc29yX3JlZ2lzdGVyKCksIGlmIHdlIGFkZCBvdXIgb3duIHByb3BlcnR5
IHRvIHBhc3MNCj4gdGhlIEhXIHJlc291cmNlIElELCB0aGVuIG5vIG5lZWQgdG8gZG8gc28sIHdl
IGp1c3QgcGFzcyB0aGUgaW5kZXggMC1OIGZvciBlYWNoDQo+IHRoZXJtYWwgc2Vuc29ycyBpbiBk
ZXZpY2V0cmVlIHdoaWNoIGFsc28gd2l0aCBwaGFuZGxlIGFyZ3VtZW50IDAtTi4gU28gdXNpbmcN
Cj4gb3VyIG93biBwcm9wZXJ0eSBtYWtlcyB0aGUgZHJpdmVyIG11Y2ggbW9yZSBzaW1wbGUuDQo+
IA0KPiBTbywgQEVkdWFyZG8sIHdoaWNoIGRpcmVjdGlvbiBJIHNob3VsZCBnbz8gTG9va3MgbGlr
ZSBSb2Igc3VnZ2VzdHMganVzdCBwdXQNCj4gdGhlIEhXIHJlc291cmNlIElEIGluIHRoZSBwaGFu
ZGxlIGFyZ3VtZW50IGxpa2Ugd2hhdCBJIGRpZCBhdCB0aGUgYmVnaW5uaW5nLA0KPiBjYW4geW91
IGFkdmlzZT8NCj4gDQoNCkkgcHJlZmVyIHRvIFJvYiBzdWdnZXN0ZWQgd2F5IHRoYXQgZGlyZWN0
bHkgdXNlIHJlc291cmNlIGlkIGZvciB0aGVybWFsLXNlbnNvciBjZWxscy4NCg0KRm9yIFNXIGlt
cGxlbWVudGF0aW9uLCB3ZSBjYW4gZWl0aGVyIHBhcnNlIHRoZSBzZW5zb3IgcmVzb3VyY2UgaWQg
ZnJvbSBkZXZpY2UgdHJlZQ0Kb3Igc3RhdGljYWxseSBkZWZpbmUgaXQgaW4gZHJpdmVyLg0KUGFy
c2luZyBmcm9tIERUIGNvdWxkIG1ha2UgdGhlIGRyaXZlciBtb3JlIGdlbmVyaWMgYW5kIGRvIG5v
dCBuZWVkIGNoYW5nZSBmb3IgdGhlIG51bWJlcg0KT2Ygc2Vuc29yIGNoYW5nZXMgaW4gZnVydHVy
ZSBTb0NzIHdoaWNoIHByb2JhYmx5IGlzIGJldHRlci4NCg0KT25lIG1vcmUgc3VnZ2VzdGlvbiBp
cyBwbGVhc2UgbGlzdCBhbGwgc3VwcG9ydGVkIHNlbnNvcnMgaW4gYmluZGluZyBkb2MgdG8gYXZv
aWQgY29uZnVzaW5nLg0KDQpSZWdhcmRzDQpEb25nIEFpc2hlbmcNCg0KPiBUaGFua3MsDQo+IEFu
c29uLg0KPiANCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDcwMzg0OS8N
Cj4gPiArCXRoZXJtYWxfem9uZXM6IHRoZXJtYWwtem9uZXMgew0KPiA+ICsJCWNwdS10aGVybWFs
MCB7DQo+ID4gKwkJCXBvbGxpbmctZGVsYXktcGFzc2l2ZSA9IDwyNTA+Ow0KPiA+ICsJCQlwb2xs
aW5nLWRlbGF5ID0gPDIwMDA+Ow0KPiA+ICsJCQl0aGVybWFsLXNlbnNvcnMgPSA8JnRzZW5zIDM1
NT47DQo+ID4gKwkJCXRyaXBzIHsNCj4gPiArCQkJCWNwdV9hbGVydDA6IHRyaXAwIHsNCj4gPiAr
CQkJCQl0ZW1wZXJhdHVyZSA9IDwxMDcwMDA+Ow0KPiA+ICsJCQkJCWh5c3RlcmVzaXMgPSA8MjAw
MD47DQo+ID4gKwkJCQkJdHlwZSA9ICJwYXNzaXZlIjsNCj4gPiArCQkJCX07DQo+IA0KPiA+DQo+
ID4gUm9iDQo=
