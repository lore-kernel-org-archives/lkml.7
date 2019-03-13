Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BC8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933152177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kXIyEM/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfCMIOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 04:14:12 -0400
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:48741
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726720AbfCMIOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 04:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/arKJ+3O3wx72D4cN+w3EKXhZuI44/pnixdrc8ohmQ=;
 b=kXIyEM/OyhpcYkTrmtmXn8DuODgA6xwYdwegsxvt8MSPvAlg0C3S35h1s+Koc9RVODScTpYGEArBw3InccQsDmHmExQAtwywHdGr22hBfsHS8/fRgGo6MC9Zrh89MRKvDgiGnDdVvF5TbS1wtfsa7mdttjlrCQ90Aw+zjssvsSg=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3734.eurprd04.prod.outlook.com (52.133.29.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.17; Wed, 13 Mar 2019 08:12:14 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::e052:f2d5:93f2:5f52]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::e052:f2d5:93f2:5f52%4]) with mapi id 15.20.1686.021; Wed, 13 Mar 2019
 08:12:14 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Rob Herring <robh@kernel.org>,
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
        Aisheng Dong <aisheng.dong@nxp.com>,
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
Thread-Index: AQHUznjp1VM2Vv0vQ0qLNAgNlgUeAaX0UrqAgAALZRCAAO51AIAAsZeggAgessCACy7wIA==
Date:   Wed, 13 Mar 2019 08:12:14 +0000
Message-ID: <AM6PR0402MB39111B82FAE76449785EDF90F54A0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1551256894-21954-1-git-send-email-Anson.Huang@nxp.com>
 <20190227235455.GA15211@bogus>
 <DB3PR0402MB391673518C43A0ABE9BDB55FF5750@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAL_JsqJct4BztHEak+=iNK3G7dwYR-pQPeUqb4kBnEdRQMLr6A@mail.gmail.com>
 <DB3PR0402MB3916D67D2CA6C33D27371F58F5760@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39166061B0712B30E443DA07F5730@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39166061B0712B30E443DA07F5730@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f018a15-c5f8-447e-c1ef-08d6a78b99eb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3734;
x-ms-traffictypediagnostic: AM6PR0402MB3734:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTZQUjA0MDJNQjM3MzQ7MjM6cFZNayt1MWNhK21nc0JzMGo2WGxGbGNp?=
 =?utf-8?B?SmRWYktTelNoeTYvSG5ha292S20vM2R5K3dXNnVLMVliV1FNbzhweDlUc2lF?=
 =?utf-8?B?MmRFOFo1V2I1WWhIbjRhejgvWXdOTm93Ly9oSDJFK1ZwdXVWU0NwRmdUcHJH?=
 =?utf-8?B?UTZqK25vUTRNMkFoSXRQcGlMK2xxOHZSZ3lRNkEvM2pTZlR0c3h3RXRXRW5I?=
 =?utf-8?B?QVFGdGdXbHlqOWt4RzdtYkp0T3A3ZENtbGpzaUtlSGI0eEh0WEI0V0Y0N251?=
 =?utf-8?B?QkFlMGJ4WVFxQ3NYQlhIZ0QvamNqcEJMK0NNNzdEU3pMT1JCYmozZkRwTnd3?=
 =?utf-8?B?VEh2NTBzOC92TEFnUCt0cndzenFoVTJydW5jbWFHT2Q1RnYxYjZtZ0t3cW9m?=
 =?utf-8?B?T05lVEIxZnI1S0IxNlBVSm0vOFFtZHliNDduNnZXclNMZFhrY1ZTZzBuVEV0?=
 =?utf-8?B?UDJjVFd4dk5EQXd4cmNPNE45U1lPSldmeDQvanVDakpTLzAyTHZFN2VNdFRD?=
 =?utf-8?B?OWUxOVdTTTJQRm5VSWJua0lvTW5KRS9jK3dyVGJOTndsdWlpdHBkRHk0b3Iw?=
 =?utf-8?B?bGk0QUtxdStGSytscFQ1RENadjNoZGMxYUtsL3RSbnoyNDIwdSt2MmtDaDZn?=
 =?utf-8?B?aGpzdnhSU3dhdCsvMWsxUktwMnlnV2wxMXcxc2FGcm9JQWE4Y2dZM2c2R1RG?=
 =?utf-8?B?LzVYSDlNQU9ra1BQSEJMRjBUYmE4VERQK2s1T0ZlQVQ4eHl3NHFjQXhmTmpu?=
 =?utf-8?B?Z1NqQzB0WmduS0NkcER5RUc5d25VWk9qOTRXNE9Ld0FMSG1KUndoK1kzcWp4?=
 =?utf-8?B?Zld5NEZBNk1tS0cvZDdja0RRRnQ0YzNvbnN1MVVzVFA1NDhhY0pRaHRFZGtj?=
 =?utf-8?B?N3c1VHZTSHlYNVE0QjJhVFByd3hIS3dtZWRnSkJGRkhGQTNxTXoxN0RlRFl3?=
 =?utf-8?B?cFFxSWJTUVNhTndWb2wrM0l2WncyVDBidnN4VUErckVES3d2dk9TQW9DbzJQ?=
 =?utf-8?B?cTRGQWlzYXRvaTRLamlIeWV2b2h1dEtuSmxGYVQ3cm5mcTlpbEtwZnBFd3dU?=
 =?utf-8?B?ZFh3MVBTd1doRk9scE5WTWZWaXJ1Nm4wSFliVlFHZ1JQRUtYOWJ6UE5oTG5J?=
 =?utf-8?B?c2NkeVdlVVVUOWVyM0F3ajJOUnlZcUNkNUttdlFuMmFGNXUrRTQzVkZWaTlI?=
 =?utf-8?B?eHYrdXFlRDN2TlBSUXd6YS9uYW5mVFptWUtVZ3orUngxQVA0aUQ3V0srRVYw?=
 =?utf-8?B?Y0FVUklncWhGOWpTaFE2QzJKeUdqS0lBT3dRZlRtcktOOXEyOE9SNUZqRjZB?=
 =?utf-8?B?NEdPWERyV3EwUDRLOWFYZFlKRWp6dURUSHc5eDdaQjRoN0FOUFh2NGV1VytO?=
 =?utf-8?B?bkFabmphQ2lTcHVidHFkQXEyWFYwelAraXhjb3JTQTJ4OC82NjhQbXZVaVNr?=
 =?utf-8?B?TllRSmxhNkd4MlVLNUVsMWlpNTFVd0hUSGpOY2t6cm9YYk9sdWY4UUpMd1R6?=
 =?utf-8?B?UE9xZU9rR3ZOU20wV3FQQ1FXSnRaSFcwZGFWOGRwQlZmT1F3aFk1NFV1UHRE?=
 =?utf-8?B?bzhpKzMyTDVkQ0xWZGxNYlFhLzF0WHlRZkp2bjJGSGRxeFdkNHp0TzhzNE5I?=
 =?utf-8?B?NG9vSTZaNDZoL0hmejBzMGVYKzBqdXZFVGJwQzBuWG12REhCWWJ2OHJPWlJr?=
 =?utf-8?B?cEtyYmpoSk1vL1M4ZS9WaHZ0bjFDYXZob0ZHd2ZENGVQSDN6OGtRMGVmWDh6?=
 =?utf-8?B?Z29XOXhoVXVjMnlJdVVuSG5pSGkvaVVBL1paanJJTWlIS3EranU4cXRLSjF0?=
 =?utf-8?B?T28vTlZyY2pteDhGeWtpTytPbWZIQnhZMW1JVTZiTEV3M0ZLTDBTMWo1R0lz?=
 =?utf-8?Q?n6Z/+RHcZdCTZVSFnImQryF0u2WGe2i+JV?=
x-microsoft-antispam-prvs: <AM6PR0402MB3734FB832B64AEAEA518CA15F54A0@AM6PR0402MB3734.eurprd04.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(376002)(396003)(39860400002)(199004)(189003)(13464003)(305945005)(71200400001)(7736002)(7696005)(2501003)(6246003)(71190400001)(44832011)(186003)(8676002)(53936002)(9686003)(55016002)(6436002)(54906003)(110136005)(11346002)(81166006)(74316002)(229853002)(76176011)(14454004)(478600001)(81156014)(33656002)(66066001)(8936002)(4326008)(316002)(68736007)(86362001)(5660300002)(6116002)(106356001)(105586002)(3846002)(256004)(6306002)(99286004)(966005)(6506007)(446003)(52536013)(97736004)(53546011)(476003)(25786009)(486006)(7416002)(102836004)(2906002)(26005)(93886005)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3734;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7EeVkhgIiGbD2Jo0QXnJaCC4Ze761lX3xpospTOgvFfxrgcy7VMTSSv6uZuu8hKvmBKLMjFSKoNVDiixjpd4TMd83AgzykSb0QXZ0UOm44GFJkLgG8vvAJQhzXT8JzBs3ddMteZJw2VNKWNyIDviMZlBNNn1IHNa9+EoprbafFzLyvTmh16oLFOT+2x+We4vwmMrm6Xj8kOgHqFUEgZ995DyFFs86fYPOTwd+qG1Ek5U/zFB+G2dPjKDrR4SfETbpWyQTI1rQZpldAJC0OH+JDpz9lDROk+zPdhdBb9GSaGGZPUK/EPyOnr4eLCnp9bAJMvDxX9ey6JjCV8q/nFaAjP0Y29Q3Zht7Ghk228bLYhcoiu/vC2tcmX7D9nozTaCVv2t7cuCPAqcfbYKTABwwOD6JgjO01xweYu/8ASXaJY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f018a15-c5f8-447e-c1ef-08d6a78b99eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 08:12:14.2840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3734
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZy4uLg0KSGksIEVkdWFyZG8NCglDYW4geW91IHRha2UgYSBsb29rIGF0IHRoaXMgdGhyZWFk
PyBUaGFua3MuDQoNCg0KQmVzdCBSZWdhcmRzIQ0KQW5zb24gSHVhbmcNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiAyMDE55bm0M+ac
iDbml6UgMTM6MjcNCj4gVG86ICdSb2IgSGVycmluZycgPHJvYmhAa2VybmVsLm9yZz47ICdlZHVi
ZXp2YWxAZ21haWwuY29tJw0KPiA8ZWR1YmV6dmFsQGdtYWlsLmNvbT4NCj4gQ2M6ICdtYXJrLnJ1
dGxhbmRAYXJtLmNvbScgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsNCj4gJ3NoYXduZ3VvQGtlcm5l
bC5vcmcnIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgJ3MuaGF1ZXJAcGVuZ3V0cm9uaXguZGUnDQo+
IDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsgJ2tlcm5lbEBwZW5ndXRyb25peC5kZScNCj4gPGtl
cm5lbEBwZW5ndXRyb25peC5kZT47ICdmZXN0ZXZhbUBnbWFpbC5jb20nIDxmZXN0ZXZhbUBnbWFp
bC5jb20+Ow0KPiAnY2F0YWxpbi5tYXJpbmFzQGFybS5jb20nIDxjYXRhbGluLm1hcmluYXNAYXJt
LmNvbT47DQo+ICd3aWxsLmRlYWNvbkBhcm0uY29tJyA8d2lsbC5kZWFjb25AYXJtLmNvbT47ICdy
dWkuemhhbmdAaW50ZWwuY29tJw0KPiA8cnVpLnpoYW5nQGludGVsLmNvbT47ICdlZHViZXp2YWxA
Z21haWwuY29tJyA8ZWR1YmV6dmFsQGdtYWlsLmNvbT47DQo+ICdkYW5pZWwubGV6Y2Fub0BsaW5h
cm8ub3JnJyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz47IEFpc2hlbmcgRG9uZw0KPiA8YWlz
aGVuZy5kb25nQG54cC5jb20+OyAndWxmLmhhbnNzb25AbGluYXJvLm9yZycNCj4gPHVsZi5oYW5z
c29uQGxpbmFyby5vcmc+OyAnc2JveWRAa2VybmVsLm9yZycgPHNib3lkQGtlcm5lbC5vcmc+OyBE
YW5pZWwNCj4gQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+OyBBbmR5IEdyb3NzIDxhbmR5
Lmdyb3NzQGxpbmFyby5vcmc+Ow0KPiAnaG9ybXMrcmVuZXNhc0B2ZXJnZS5uZXQuYXUnIDxob3Jt
cytyZW5lc2FzQHZlcmdlLm5ldC5hdT47DQo+ICdoZWlrb0BzbnRlY2guZGUnIDxoZWlrb0BzbnRl
Y2guZGU+OyAnYXJuZEBhcm5kYi5kZScgPGFybmRAYXJuZGIuZGU+Ow0KPiAnbWF4aW1lLnJpcGFy
ZEBib290bGluLmNvbScgPG1heGltZS5yaXBhcmRAYm9vdGxpbi5jb20+Ow0KPiAnYmpvcm4uYW5k
ZXJzc29uQGxpbmFyby5vcmcnIDxiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZz47DQo+ICdqYWdh
bkBhbWFydWxhc29sdXRpb25zLmNvbScgPGphZ2FuQGFtYXJ1bGFzb2x1dGlvbnMuY29tPjsNCj4g
J2VucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb20nIDxlbnJpYy5iYWxsZXRib0Bjb2xsYWJvcmEu
Y29tPjsNCj4gJ21hcmMudy5nb256YWxlekBmcmVlLmZyJyA8bWFyYy53LmdvbnphbGV6QGZyZWUu
ZnI+OyAnb2xvZkBsaXhvbS5uZXQnDQo+IDxvbG9mQGxpeG9tLm5ldD47ICdkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZycNCj4gPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgJ2xpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcnIDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz47
ICdsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcnIDxsaW51eC1hcm0tDQo+IGtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgJ2xpbnV4LXBtQHZnZXIua2VybmVsLm9yZycgPGxp
bnV4LQ0KPiBwbUB2Z2VyLmtlcm5lbC5vcmc+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIFYxMCAxLzRdIGR0LWJpbmRpbmdzOiBmc2w6IHNj
dTogYWRkIHRoZXJtYWwgYmluZGluZw0KPiANCj4gUGluZy4uLg0KPiANCj4gSGksIEVkdWFyZG8N
Cj4gCUxvb2tzIGxpa2Ugd2UgYXJlIGdvaW5nIGFyb3VuZCBpbiBjaXJjbGUsIGNhbiB3ZSBtYWtl
IGRlY2lzaW9uIG9mDQo+IHdoaWNoIGRpcmVjdGlvbiB0byBnbz8NCj4gDQo+IEJlc3QgUmVnYXJk
cyENCj4gQW5zb24gSHVhbmcNCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
PiBGcm9tOiBBbnNvbiBIdWFuZw0KPiA+IFNlbnQ6IDIwMTnlubQz5pyIMeaXpSA5OjQxDQo+ID4g
VG86ICdSb2IgSGVycmluZycgPHJvYmhAa2VybmVsLm9yZz47IGVkdWJlenZhbEBnbWFpbC5jb20N
Cj4gPiBDYzogbWFyay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMu
aGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+ID4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZh
bUBnbWFpbC5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0KPiA+IHdpbGwuZGVhY29uQGFy
bS5jb207IHJ1aS56aGFuZ0BpbnRlbC5jb207IGVkdWJlenZhbEBnbWFpbC5jb207DQo+ID4gZGFu
aWVsLmxlemNhbm9AbGluYXJvLm9yZzsgQWlzaGVuZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNv
bT47DQo+ID4gdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgc2JveWRAa2VybmVsLm9yZzsgRGFuaWVs
IEJhbHV0YQ0KPiA+IDxkYW5pZWwuYmFsdXRhQG54cC5jb20+OyBBbmR5IEdyb3NzIDxhbmR5Lmdy
b3NzQGxpbmFyby5vcmc+Ow0KPiA+IGhvcm1zK3JlbmVzYXNAdmVyZ2UubmV0LmF1OyBoZWlrb0Bz
bnRlY2guZGU7IGFybmRAYXJuZGIuZGU7DQo+ID4gbWF4aW1lLnJpcGFyZEBib290bGluLmNvbTsg
Ympvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc7DQo+ID4gamFnYW5AYW1hcnVsYXNvbHV0aW9ucy5j
b207IGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb207DQo+ID4gbWFyYy53LmdvbnphbGV6QGZy
ZWUuZnI7IG9sb2ZAbGl4b20ubmV0OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gPiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7DQo+ID4gbGludXgtIHBtQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxs
aW51eC1pbXhAbnhwLmNvbT4NCj4gPiBTdWJqZWN0OiBSRTogW1BBVENIIFYxMCAxLzRdIGR0LWJp
bmRpbmdzOiBmc2w6IHNjdTogYWRkIHRoZXJtYWwNCj4gPiBiaW5kaW5nDQo+ID4NCj4gPiBIaSwg
Um9iL0VkdWFyZG8NCj4gPg0KPiA+IEJlc3QgUmVnYXJkcyENCj4gPiBBbnNvbiBIdWFuZw0KPiA+
DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogUm9iIEhlcnJp
bmcgW21haWx0bzpyb2JoQGtlcm5lbC5vcmddDQo+ID4gPiBTZW50OiAyMDE55bm0MuaciDI45pel
IDIyOjQ5DQo+ID4gPiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+ID4g
PiBDYzogbWFyay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+ID4gcy5o
YXVlckBwZW5ndXRyb25peC5kZTsNCj4gPiA+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2
YW1AZ21haWwuY29tOw0KPiBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsNCj4gPiA+IHdpbGwuZGVh
Y29uQGFybS5jb207IHJ1aS56aGFuZ0BpbnRlbC5jb207IGVkdWJlenZhbEBnbWFpbC5jb207DQo+
ID4gPiBkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnOyBBaXNoZW5nIERvbmcgPGFpc2hlbmcuZG9u
Z0BueHAuY29tPjsNCj4gPiA+IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IHNib3lkQGtlcm5lbC5v
cmc7IERhbmllbCBCYWx1dGENCj4gPiA+IDxkYW5pZWwuYmFsdXRhQG54cC5jb20+OyBBbmR5IEdy
b3NzIDxhbmR5Lmdyb3NzQGxpbmFyby5vcmc+Ow0KPiA+ID4gaG9ybXMrcmVuZXNhc0B2ZXJnZS5u
ZXQuYXU7IGhlaWtvQHNudGVjaC5kZTsgYXJuZEBhcm5kYi5kZTsNCj4gPiA+IG1heGltZS5yaXBh
cmRAYm9vdGxpbi5jb207IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOw0KPiA+ID4gamFnYW5A
YW1hcnVsYXNvbHV0aW9ucy5jb207IGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb207DQo+ID4g
PiBtYXJjLncuZ29uemFsZXpAZnJlZS5mcjsgb2xvZkBsaXhvbS5uZXQ7IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOw0KPiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gbGludXgtIHBtQHZnZXIua2Vy
bmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gPiA+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggVjEwIDEvNF0gZHQtYmluZGluZ3M6IGZzbDogc2N1OiBhZGQgdGhlcm1hbA0K
PiA+ID4gYmluZGluZw0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgRmViIDI3LCAyMDE5IGF0IDY6NDgg
UE0gQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+
ID4NCj4gPiA+ID4gSGksIFJvYg0KPiA+ID4gPg0KPiA+ID4gPiBCZXN0IFJlZ2FyZHMhDQo+ID4g
PiA+IEFuc29uIEh1YW5nDQo+ID4gPiA+DQo+ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPiA+ID4gPiBGcm9tOiBSb2IgSGVycmluZyBbbWFpbHRvOnJvYmhAa2VybmVsLm9y
Z10NCj4gPiA+ID4gPiBTZW50OiAyMDE55bm0MuaciDI45pelIDc6NTUNCj4gPiA+ID4gPiBUbzog
QW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+ID4gPiA+ID4gQ2M6IG1hcmsucnV0
bGFuZEBhcm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiA+ID4gPiA+IHMuaGF1ZXJAcGVu
Z3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gPiBmZXN0ZXZhbUBnbWFpbC5j
b207DQo+ID4gPiA+ID4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGwuZGVhY29uQGFybS5j
b207DQo+ID4gcnVpLnpoYW5nQGludGVsLmNvbTsNCj4gPiA+ID4gPiBlZHViZXp2YWxAZ21haWwu
Y29tOyBkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnOyBBaXNoZW5nIERvbmcNCj4gPiA+ID4gPiA8
YWlzaGVuZy5kb25nQG54cC5jb20+OyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOw0KPiA+ID4gPiA+
IHNib3lkQGtlcm5lbC5vcmc7IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT47
IEFuZHkNCj4gPiA+ID4gPiBHcm9zcyA8YW5keS5ncm9zc0BsaW5hcm8ub3JnPjsgaG9ybXMrcmVu
ZXNhc0B2ZXJnZS5uZXQuYXU7DQo+ID4gPiA+ID4gaGVpa29Ac250ZWNoLmRlOyBhcm5kQGFybmRi
LmRlOyBtYXhpbWUucmlwYXJkQGJvb3RsaW4uY29tOw0KPiA+ID4gPiA+IGJqb3JuLmFuZGVyc3Nv
bkBsaW5hcm8ub3JnOyBqYWdhbkBhbWFydWxhc29sdXRpb25zLmNvbTsNCj4gPiA+ID4gPiBlbnJp
Yy5iYWxsZXRib0Bjb2xsYWJvcmEuY29tOyBtYXJjLncuZ29uemFsZXpAZnJlZS5mcjsNCj4gPiA+
ID4gPiBvbG9mQGxpeG9tLm5ldDsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiA+
ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+ID4gPiBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiA+ID4gbGludXgtIHBtQHZnZXIua2VybmVs
Lm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gPiA+ID4gPiBTdWJqZWN0
OiBSZTogW1BBVENIIFYxMCAxLzRdIGR0LWJpbmRpbmdzOiBmc2w6IHNjdTogYWRkIHRoZXJtYWwN
Cj4gPiA+ID4gPiBiaW5kaW5nDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBPbiBXZWQsIEZlYiAyNywg
MjAxOSBhdCAwODo0NjoyMUFNICswMDAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiA+ID4gPiA+
IE5YUCBpLk1YOFFYUCBpcyBhbiBBUk12OCBTb0Mgd2l0aCBhIENvcnRleC1NNCBjb3JlIGluc2lk
ZSBhcw0KPiA+ID4gPiA+ID4gc3lzdGVtIGNvbnRyb2xsZXIsIHRoZSBzeXN0ZW0gY29udHJvbGxl
ciBpcyBpbiBjaGFyZ2Ugb2YNCj4gPiA+ID4gPiA+IHN5c3RlbSBwb3dlciwgY2xvY2sgYW5kIHRo
ZXJtYWwgc2Vuc29ycyBldGMuIG1hbmFnZW1lbnQsIExpbnV4DQo+ID4gPiA+ID4gPiBrZXJuZWwg
aGFzIHRvIGNvbW11bmljYXRlIHdpdGggc3lzdGVtIGNvbnRyb2xsZXIgdmlhIE1VDQo+ID4gPiA+
ID4gPiAobWVzc2FnZSB1bml0KSBJUEMgdG8gZ2V0IHRlbXBlcmF0dXJlIGZyb20gdGhlcm1hbCBz
ZW5zb3JzLA0KPiA+ID4gPiA+ID4gdGhpcyBwYXRjaCBhZGRzIGJpbmRpbmcgZG9jIGZvciBpLk1Y
IHN5c3RlbSBjb250cm9sbGVyIHRoZXJtYWwNCj4gZHJpdmVyLg0KPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0K
PiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiBDaGFuZ2VzIHNpbmNlIFY5Og0KPiA+ID4gPiA+
ID4gICAgIC0gY2hhbmdlICN0aGVybWFsLXNlbnNvci1jZWxscyB2YWx1ZSBpbiBleGFtcGxlIHRv
IDEsDQo+ID4gPiA+ID4gPiBzaW5jZSB0aGVyZSBhcmUNCj4gPiA+ID4gPiBvdGhlcg0KPiA+ID4g
PiA+ID4gICAgICAgdGhlcm1hbCBzZW5zb3JzIGluc2lkZSBzeXN0ZW0gY29udHJvbGxlciwgaXQg
aXMganVzdA0KPiA+ID4gPiA+ID4gYmVjYXVzZSB0aGVyZSBhcmUNCj4gPiA+ID4gPiBzdGlsbA0K
PiA+ID4gPiA+ID4gICAgICAgc29tZSBpc3N1ZSwgc28gc3lzdGVtIGNvbnRyb2xsZXIgZG9lcyBO
T1QgZXhwb3NlIHRoZW0NCj4gPiA+ID4gPiA+IGZvciBub3csDQo+ID4gPiA+ID4gdGhleSBjb3Vs
ZA0KPiA+ID4gPiA+ID4gICAgICAgYmUgZXhwb3NlZCBsYXRlciwgc28gaXQgc2hvdWxkIGJlIDEg
ZnJvbSBIVyBwZXJzcGVjdGl2ZS4NCj4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gIC4uLi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQgICB8IDIxDQo+ID4g
PiA+ID4gKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQs
IDIxIGluc2VydGlvbnMoKykNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0DQo+
ID4gPiA+ID4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNj
YWxlL2ZzbCxzY3UudHh0DQo+ID4gPiA+ID4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+ID4gPiA+ID4gPiBpbmRleCA3MmQ0
ODFjLi44NTUyNzBiIDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+
ID4gPiA+ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2Zy
ZWVzY2FsZS9mc2wsc2N1Lg0KPiA+ID4gPiA+ID4gKysrIHR4DQo+ID4gPiA+ID4gPiArKysgdA0K
PiA+ID4gPiA+ID4gQEAgLTEyMiw2ICsxMjIsMjEgQEAgUlRDIGJpbmRpbmdzIGJhc2VkIG9uIFND
VSBNZXNzYWdlDQo+ID4gUHJvdG9jb2wNCj4gPiA+ID4gPiA+IFJlcXVpcmVkIHByb3BlcnRpZXM6
DQo+ID4gPiA+ID4gPiAgLSBjb21wYXRpYmxlOiBzaG91bGQgYmUgImZzbCxpbXg4cXhwLXNjLXJ0
YyI7DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gK1RoZXJtYWwgYmluZGluZ3MgYmFzZWQgb24g
U0NVIE1lc3NhZ2UgUHJvdG9jb2wNCj4gPiA+ID4gPiA+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ID4gPiA+ICsNCj4g
PiA+ID4gPiA+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ID4gPiA+ID4gKy0gY29tcGF0aWJs
ZTogICAgICAgICAgICAgICAgICAgICAgU2hvdWxkIGJlIDoNCj4gPiA+ID4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICJmc2wsaW14OHF4cC1zYy10aGVybWFsIg0KPiA+ID4gPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGZvbGxvd2VkIGJ5ICJmc2wsaW14LXNjLXRo
ZXJtYWwiOw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKy0gI3RoZXJtYWwtc2Vuc29yLWNl
bGxzOiAgIFNlZQ0KPiA+ID4gPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90
aGVybWFsL3RoZXJtYWwudHh0DQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZm9yIGEgZGVzY3JpcHRpb24uDQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArLSBpbXgs
c2Vuc29yLXJlc291cmNlLWlkOiAgQSBzaW5nbGUgaW50ZWdlciBmb3Igc2luZ2xlDQo+ID4gPiA+
ID4gPiArdGhlcm1hbCB6b25lJ3MNCj4gPiA+ID4gPiByZXNvdXJjZSBJRCBvcg0KPiA+ID4gPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGFuIGFycmF5IG9mIGludGVnZXJzIHRvIHNw
ZWNpZnkNCj4gPiA+ID4gPiA+ICsgZWFjaCB0aGVybWFsDQo+ID4gPiA+ID4gem9uZSdzIHNlbnNv
cg0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlc291cmNlIElELg0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gQ2FuJ3QgeW91IHB1dCB0aGUgcmVzb3VyY2UgaWRzIGluIHRo
ZSB0aGVybWFsLXNlbnNvciBjZWxscz8gV2h5DQo+ID4gPiA+ID4gZG8geW91IG5lZWQgdG8gbGlz
dCB0aGVtIGhlcmU/DQo+ID4gPiA+DQo+ID4gPiA+IEZvciB0aGUgdGhlcm1hbC1zZW5zb3IgY2Vs
bHMsIGlmIHlvdSBtZWFudCB0aGUgYXJndW1lbnQgb2YgdHNlbnMNCj4gPiA+ID4gcGhhbmRsZSwg
dGhlbiB0aGUgcmVhc29uIGlzIHRoYXQgYXJndW1lbnQgaXMgZm9yIHNlbnNvciBpbmRleA0KPiA+
ID4gPiBzdGFydGluZyBmcm9tIDAsIHByZXZpb3VzIEkgdXNlIGl0IGZvciBvdXIgcmVzb3VyY2Ug
SUQsIGJ1dCBpdA0KPiA+ID4gPiBsb29rcyBjb25mdXNlZCwgc2luY2UgdXNlciB3aWxsIHRoaW5r
IHRoZXJlIGFyZSBtYW55IHNlbnNvcnMgdGhlcmUNCj4gPiA+ID4gcGVyDQo+ID4gRWR1YXJkbydz
IGNvbW1lbnQuDQo+ID4gPiA+DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHRoZXJt
YWwtc2Vuc29ycyA9IDwmdHNlbnMgMD47DQo+ID4gPiA+DQo+ID4gPiA+IElmIHlvdSBtZWFudCBw
dXR0aW5nIGl0IGluIGVhY2ggdGhlcm1hbCBzZW5zb3Igbm9kZSBpbnN0ZWFkIG9mICJ0c2VucyIN
Cj4gPiA+ID4gbm9kZSwgdGhlbiBpbiBwcmV2aW91cyBwYXRjaCBzZXJpZXMsIEkgcHV0IHRoaXMg
Ig0KPiA+ID4gPiBpbXgsc2Vuc29yLXJlc291cmNlLWlkICIgcHJvcGVydHkgaW4gZWFjaCB0aGVy
bWFsIHNlbnNvciBub2RlLCBidXQNCj4gPiA+ID4gdGhlIHRoZXJtYWwgc2Vuc29yIG5vZGVzIGFy
ZSBwYXJzZWQgYnkgY29tbW9uIHRoZXJtYWwgZnJhbWV3b3JrLA0KPiA+ID4gPiB0aGVybWFsIGRy
aXZlciB3aWxsIG5lZWQgdG8gZmluZCB0aGUgdGhlcm1hbCB6b25lIG5vZGUgYW5kIGdvDQo+ID4g
PiA+IHRocm91Z2ggZXZlcnkgY2hpbGQgbm9kZSB0byBnZXQgdGhlIHJlc291cmNlIGlkIGFnYWlu
LCBzbyBFZHVhcmRvDQo+ID4gPiA+IHN1Z2dlc3RlZCB0byBwdXQgaXQgaW4NCj4gPiA+IG91ciBw
bGF0Zm9ybSB0c2VucyBub2RlLCB0aGF0IG1ha2VzIG91ciB0aGVybWFsIGRyaXZlciBjb2RlIG11
Y2gNCj4gPiA+IG1vcmUgc2ltcGxlLg0KPiA+ID4NCj4gPiA+IFRoZSBwaGFuZGxlIGFyZ3MgYXJl
IG1lYW50IHRvIGJlIGFuIGlkIHR5cGljYWxseS4gVGhlcmUncyBhYnNvbHV0ZWx5DQo+ID4gPiBu
byByZXF1aXJlbWVudCB0aGV5IGFyZSAwLU4gYmFzZWQuIFRoZXkgb2Z0ZW4gYXJlIGJlY2F1c2Ug
dGhpbmdzDQo+ID4gPiBsaWtlIGludGVycnVwdHMgYXJlIDAtTiBvciBjbG9ja3MgaGF2ZSBubyBo
L3cgaWQuIElmIHlvdSBhbHJlYWR5IGhhdmUgYW4gaWQsDQo+IHVzZSBpdC4NCj4gPiA+IERvbid0
IGludmVudCB5b3VyIG93bi4NCj4gPg0KPiA+IEF0IHRoZSBiZWdpbm5pbmcsIEkgcHV0IHRoZSBI
VyByZXNvdXJjZSBJRCBpbiB0aGUgInRzZW5zIiBwaGFuZGxlDQo+ID4gYXJndW1lbnQgb2YgInRo
ZXJtYWwtc2Vuc29ycyIgbm9kZSwgc2VlICBiZWxvdyBwYXRjaCBJIHNlbnQgYmVmb3JlLA0KPiA+
IHRoZSBiZW5lZml0IGlzIEkgZG8gTk9UIG5lZWQgdG8gYWRkIG5ldyBwcm9wZXJ0eSBmb3IgcGFz
c2luZyBIVw0KPiA+IHJlc291cmNlIElEIHRvIGRyaXZlciwgdGhlIGRpc2FkdmFudGFnZSBpcywg
SSBoYXZlIHRvIHBhcnNlIHRoZQ0KPiA+IHRoZXJtYWxfem9uZXMnIGVhY2ggY2hpbGQgbm9kZSBh
bmQgZ2V0IHRoZSBIVyByZXNvdXJjZSBJRCBmcm9tIHBoYW5kbGUNCj4gPiBhcmd1bWVudChzZWFy
aW5nIHRoZXJtYWxfem9uZXMgbm9kZSBhbmQgZ28gdGhyb3VnaCBhbGwgaXRzIGNoaWxkIG5vZGUs
DQo+ID4gYW5kIGdldCB0aGUgcGhhbmRsZSBhcmd1bWVudCksIHRoZXkgYXJlIGJ5IGRlZmF1bHQg
T05MWSBwYXJzZWQgYnkNCj4gPiB0aGVybWFsIGNvcmUgZHJpdmVyLiBXaGVuIHdlIHJlZ2lzdGVy
IHRoZXJtYWwgem9uZSwgd2UgaGF2ZSB0byBwYXNzDQo+ID4gdGhlIEhXIHJlc291cmNlIElEIHdo
ZW4gY2FsbGluZw0KPiA+IGRldm1fdGhlcm1hbF96b25lX29mX3NlbnNvcl9yZWdpc3RlcigpLCBp
ZiB3ZSBhZGQgb3VyIG93biBwcm9wZXJ0eSB0bw0KPiA+IHBhc3MgdGhlIEhXIHJlc291cmNlIElE
LCB0aGVuIG5vIG5lZWQgdG8gZG8gc28sIHdlIGp1c3QgcGFzcyB0aGUgaW5kZXgNCj4gPiAwLU4g
Zm9yIGVhY2ggdGhlcm1hbCBzZW5zb3JzIGluIGRldmljZXRyZWUgd2hpY2ggYWxzbyB3aXRoIHBo
YW5kbGUNCj4gYXJndW1lbnQgMC0gTi4gU28gdXNpbmcgb3VyIG93biBwcm9wZXJ0eSBtYWtlcyB0
aGUgZHJpdmVyIG11Y2ggbW9yZQ0KPiBzaW1wbGUuDQo+ID4NCj4gPiBTbywgQEVkdWFyZG8sIHdo
aWNoIGRpcmVjdGlvbiBJIHNob3VsZCBnbz8gTG9va3MgbGlrZSBSb2Igc3VnZ2VzdHMNCj4gPiBq
dXN0IHB1dCB0aGUgSFcgcmVzb3VyY2UgSUQgaW4gdGhlIHBoYW5kbGUgYXJndW1lbnQgbGlrZSB3
aGF0IEkgZGlkIGF0DQo+ID4gdGhlIGJlZ2lubmluZywgY2FuIHlvdSBhZHZpc2U/DQo+ID4NCj4g
PiBUaGFua3MsDQo+ID4gQW5zb24uDQo+ID4NCj4gPiBodHRwczovL3BhdGNod29yay5rZXJuZWwu
b3JnL3BhdGNoLzEwNzAzODQ5Lw0KPiA+ID4gKwl0aGVybWFsX3pvbmVzOiB0aGVybWFsLXpvbmVz
IHsNCj4gPiA+ICsJCWNwdS10aGVybWFsMCB7DQo+ID4gPiArCQkJcG9sbGluZy1kZWxheS1wYXNz
aXZlID0gPDI1MD47DQo+ID4gPiArCQkJcG9sbGluZy1kZWxheSA9IDwyMDAwPjsNCj4gPiA+ICsJ
CQl0aGVybWFsLXNlbnNvcnMgPSA8JnRzZW5zIDM1NT47DQo+ID4gPiArCQkJdHJpcHMgew0KPiA+
ID4gKwkJCQljcHVfYWxlcnQwOiB0cmlwMCB7DQo+ID4gPiArCQkJCQl0ZW1wZXJhdHVyZSA9IDwx
MDcwMDA+Ow0KPiA+ID4gKwkJCQkJaHlzdGVyZXNpcyA9IDwyMDAwPjsNCj4gPiA+ICsJCQkJCXR5
cGUgPSAicGFzc2l2ZSI7DQo+ID4gPiArCQkJCX07DQo+ID4NCj4gPiA+DQo+ID4gPiBSb2INCg==
