Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC09C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 05:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC1E2064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 05:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AmLSpRES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfCFF1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 00:27:25 -0500
Received: from mail-eopbgr130045.outbound.protection.outlook.com ([40.107.13.45]:29314
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728897AbfCFF1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 00:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D51Txds46Z+KRxVOn67uv6rYUhVtJT0KDnVTOUybqxI=;
 b=AmLSpRESAtmhDxI5tEWtDhSHnqiU5lqb08N0yyFz8CNYpOWaGV38eGs7R0AZfHAWUXhqoWHg6dn3tIU4M/BEpqWN8jP3XKkUnQWROuACgv2QpDWgY9306xkaz+HXTPfMFdUNCo9ZkhBUhgAwd/yx19sj+DjsbOv8UA1f2FrFFtQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3722.eurprd04.prod.outlook.com (52.134.70.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 05:27:15 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1686.016; Wed, 6 Mar 2019
 05:27:15 +0000
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
Thread-Index: AQHUznjp1VM2Vv0vQ0qLNAgNlgUeAaX0UrqAgAALZRCAAO51AIAAsZeggAgessA=
Date:   Wed, 6 Mar 2019 05:27:15 +0000
Message-ID: <DB3PR0402MB39166061B0712B30E443DA07F5730@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1551256894-21954-1-git-send-email-Anson.Huang@nxp.com>
 <20190227235455.GA15211@bogus>
 <DB3PR0402MB391673518C43A0ABE9BDB55FF5750@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAL_JsqJct4BztHEak+=iNK3G7dwYR-pQPeUqb4kBnEdRQMLr6A@mail.gmail.com>
 <DB3PR0402MB3916D67D2CA6C33D27371F58F5760@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916D67D2CA6C33D27371F58F5760@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6680e115-b6f0-4c70-9172-08d6a1f46508
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3722;
x-ms-traffictypediagnostic: DB3PR0402MB3722:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjNQUjA0MDJNQjM3MjI7MjM6b0diNVpDbGU0SkF0SEljeWdpb1Z4Y0RG?=
 =?utf-8?B?T3RibmZNbXh2NHl6TmxQNDJBYWFYbUNWeVZtbHpiZ0ZCQkdlTHZaY2RpV3dY?=
 =?utf-8?B?MGhGU0NlNTBqWE5EVkJCd1pkOVd4Nnhheis5M1JoV3ZDa3pabUFLeVdsZzM3?=
 =?utf-8?B?ZkNGQjJaV2VKN1VjV2Q5ZXlFSVVGdlpxR1kzdFFmc2xZeTJxamVaSUNvQVQy?=
 =?utf-8?B?VG1BaXdCVXM5a3ZvTTVYZzlQdEdEV3VmcmcwNWxaVVRtQ0M0US9NdlF4aG16?=
 =?utf-8?B?d2dCbmRENnZTcEk2ZHlZeDMyU3NMN3ZqQlJOdEtCVGx5U2NjT093ZFhlTUNy?=
 =?utf-8?B?azM5Z2YrRmRMTFVKT0lLR3ZobU5rN3lTaUtZdEVtNFR4dkdUZGZiTmZuMXVh?=
 =?utf-8?B?YVRxMThNN3Nqcy9pWjE0djAzd3lob2NwRGxlTDBFN21adFJCakhqNnN5clJ0?=
 =?utf-8?B?cVFpYUhkUmdKYk5wMER2MEdCcisyQTdIaVlYcGVFT0FBS2RweVFIdm5WRlRU?=
 =?utf-8?B?ZGdTN1c1cVZmTm5Pby9ZcVpIWHhrdWNkU1B4L2hETDlkOEN1d1JXNGhPWTFY?=
 =?utf-8?B?MEdYdWUrbFcyM1dETkZEbnMxdS9RU0wvcTczNnZoV1YxRFgxSVA1VWhxc0x6?=
 =?utf-8?B?TWdyQUdzNkdkVktKMlB5OXBuVDU2TWVMQUNCM2FUL3AzeDlEU3N6eFdROWlh?=
 =?utf-8?B?QU9Fdzg3UTJ1djd4eTRYODlBZTJpMmdwOVNuMlZKV3d4cXUwV25BSjBDWmNU?=
 =?utf-8?B?ajNlcFp0RUhOU2xsOWdIQWRESzBHV0Q2dTFFYjlNbkVUUU1hck8yaU92eTMz?=
 =?utf-8?B?S2RleDNwSzAvSnhSTVdwa1VaRWZ2VFpLU3ByYmQxNXdGRHRBVXdzR2YyVjhr?=
 =?utf-8?B?cGtZd0liVFVNVGVxOXN3U20wRXd0eERrOVgzTVhTT0MzbVJwaHBHQUpaSWk3?=
 =?utf-8?B?dFJNZXp1TTRVSEhUVERrR1VJSzIrOGdrWGZJR2VVemdpekd5WU5GaXNPVmlj?=
 =?utf-8?B?STd1SzU4UU5penZYN1ZLNGJuRjVxUjNocDZReGtLamFHcnVPYTM0VEQvZ0xk?=
 =?utf-8?B?NVVia253SUt0RFRkMGhxSlY0bHhYOFdzcFRGN3d1RS9BM3k5TXo0aUhUQWkw?=
 =?utf-8?B?VGd0ejJmNiswNk1KMSszaVBqaWNVU0lzTFEyZjNEcHBoUW05TXZ0eTRFL0du?=
 =?utf-8?B?TXR6bjZDblBiNVh4OEJqb043VUQ4RUY0dkxkci9Od3RYUmtyMXp2Z3YrUmYy?=
 =?utf-8?B?TFhkZFY4QVZJd05Ba3RtVkxza1VzRlJUNTRqcVNNQjJBeVdmRkE5QVZUQkFo?=
 =?utf-8?B?cDhoRlErSFg2OGNTNlNTMkU0V2FiUXQ2TVZkVjdnNURWamI0UTlsQWk3NkJX?=
 =?utf-8?B?d3N6RWx6SXRwaER6U3JPaDlmdEdEWExoNjVEblREN1ErbExHbXlDQUc0b3lS?=
 =?utf-8?B?ZzIzS0Y2V3hrNVlzeVdEN1BSbFExNE56SC9na2ZPTkNGaXFEcHZ2VnE3bkp2?=
 =?utf-8?B?Y3h6ZUE3dTNzVy8zd0tneEhacVp5anNuTHFXcTRzWUd0WXNwSktDd1JGM3Iy?=
 =?utf-8?B?QmU1Z2wvMHQyQ2RjQ296a20rRFFDRVdjQk1LQ2tqTkM5Vk5HUWQ5OW52cEVC?=
 =?utf-8?B?OXVOWGc0K2p1Z09UNEVENjhsRmFyQk5qZ25tOXcyOGM1QVNyNUxqZmdxTTdK?=
 =?utf-8?B?dGZSdGlzMnhhOUFzSjJ2U3FyV1VRYlZqaXBsZGRxaGJPdjk2Rk9sVS9IUlMw?=
 =?utf-8?B?K3ZiWmNRV1gzaVA2V2UyMmJ3RXVDNHRNa1Z6Z0x3d3YzdVYzU0hqcUJLWitl?=
 =?utf-8?B?WXRoUTdzU0laWVBrak1vcmNtTXR4eHpjeXFwc2pqb3JzVWlteUZHcEs5T2NG?=
 =?utf-8?Q?z8wmTLrs1L0jTV1m9yQ4FQHVYKj3iT7odc?=
x-microsoft-antispam-prvs: <DB3PR0402MB37220E97262BEFF4F67C934EF5730@DB3PR0402MB3722.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(13464003)(199004)(189003)(6306002)(9686003)(5660300002)(54906003)(110136005)(52536013)(316002)(53936002)(93886005)(76176011)(8936002)(2501003)(186003)(446003)(44832011)(229853002)(486006)(6436002)(97736004)(7696005)(99286004)(476003)(11346002)(55016002)(26005)(6506007)(102836004)(53546011)(256004)(74316002)(14454004)(305945005)(33656002)(4326008)(86362001)(3846002)(6116002)(81166006)(81156014)(8676002)(66066001)(7416002)(2906002)(6246003)(106356001)(105586002)(71190400001)(71200400001)(7736002)(25786009)(966005)(68736007)(478600001)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3722;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ozz+SiTQx8A3E9obvyn4cOJG35EFzMWlqLqGtmfWJk351TvHOSZJHqAcelcJ+MWkJj5zBPSjbrW6CFqfj6hzTzvTmWxl+k4+Ouk3qNy/CJ8A4vMGM2Q4vndO35BB7EAwHC+iYi7PPytQ1smosN8BhktaX1B2zmizX1DeF9sNkFKH55n6E/Ii1rjhaUjInGBN9WQn/JgGPtE3EeCqgyX7I+OLXaC9qs7+SsKAbJ6Y0Hjhnwn/g5k4p/mmUsr4IZSvFdzyfCofbycc5elB9ubKlSJqM+tZmaDU83gDwjx/SWjKxz2g+NdmQFYJ7Cq7VMZft0dsLjxgvspPoTKn98PcYG1V8tHj4gccpqORAjVRJ1DYhxoZItio3N8LhCnX1LQj4m2Z219YUl2sjSEPlVP5WDh8UzBupnR1e81G7EjcESw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6680e115-b6f0-4c70-9172-08d6a1f46508
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 05:27:15.6564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3722
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZy4uLg0KDQpIaSwgRWR1YXJkbw0KCUxvb2tzIGxpa2Ugd2UgYXJlIGdvaW5nIGFyb3VuZCBp
biBjaXJjbGUsIGNhbiB3ZSBtYWtlIGRlY2lzaW9uIG9mIHdoaWNoIGRpcmVjdGlvbiB0byBnbz8N
Cg0KQmVzdCBSZWdhcmRzIQ0KQW5zb24gSHVhbmcNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiAyMDE55bm0M+aciDHml6UgOTo0MQ0K
PiBUbzogJ1JvYiBIZXJyaW5nJyA8cm9iaEBrZXJuZWwub3JnPjsgZWR1YmV6dmFsQGdtYWlsLmNv
bQ0KPiBDYzogbWFyay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMu
aGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21h
aWwuY29tOw0KPiBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsg
cnVpLnpoYW5nQGludGVsLmNvbTsNCj4gZWR1YmV6dmFsQGdtYWlsLmNvbTsgZGFuaWVsLmxlemNh
bm9AbGluYXJvLm9yZzsgQWlzaGVuZyBEb25nDQo+IDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc7IHNib3lkQGtlcm5lbC5vcmc7DQo+IERhbmllbCBCYWx1dGEg
PGRhbmllbC5iYWx1dGFAbnhwLmNvbT47IEFuZHkgR3Jvc3MNCj4gPGFuZHkuZ3Jvc3NAbGluYXJv
Lm9yZz47IGhvcm1zK3JlbmVzYXNAdmVyZ2UubmV0LmF1OyBoZWlrb0BzbnRlY2guZGU7DQo+IGFy
bmRAYXJuZGIuZGU7IG1heGltZS5yaXBhcmRAYm9vdGxpbi5jb207IGJqb3JuLmFuZGVyc3NvbkBs
aW5hcm8ub3JnOw0KPiBqYWdhbkBhbWFydWxhc29sdXRpb25zLmNvbTsgZW5yaWMuYmFsbGV0Ym9A
Y29sbGFib3JhLmNvbTsNCj4gbWFyYy53LmdvbnphbGV6QGZyZWUuZnI7IG9sb2ZAbGl4b20ubmV0
OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4gcG1A
dmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJq
ZWN0OiBSRTogW1BBVENIIFYxMCAxLzRdIGR0LWJpbmRpbmdzOiBmc2w6IHNjdTogYWRkIHRoZXJt
YWwgYmluZGluZw0KPiANCj4gSGksIFJvYi9FZHVhcmRvDQo+IA0KPiBCZXN0IFJlZ2FyZHMhDQo+
IEFuc29uIEh1YW5nDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJv
bTogUm9iIEhlcnJpbmcgW21haWx0bzpyb2JoQGtlcm5lbC5vcmddDQo+ID4gU2VudDogMjAxOeW5
tDLmnIgyOOaXpSAyMjo0OQ0KPiA+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNv
bT4NCj4gPiBDYzogbWFyay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+
IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+ID4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0
ZXZhbUBnbWFpbC5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0KPiA+IHdpbGwuZGVhY29u
QGFybS5jb207IHJ1aS56aGFuZ0BpbnRlbC5jb207IGVkdWJlenZhbEBnbWFpbC5jb207DQo+ID4g
ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsgQWlzaGVuZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhw
LmNvbT47DQo+ID4gdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgc2JveWRAa2VybmVsLm9yZzsgRGFu
aWVsIEJhbHV0YQ0KPiA+IDxkYW5pZWwuYmFsdXRhQG54cC5jb20+OyBBbmR5IEdyb3NzIDxhbmR5
Lmdyb3NzQGxpbmFyby5vcmc+Ow0KPiA+IGhvcm1zK3JlbmVzYXNAdmVyZ2UubmV0LmF1OyBoZWlr
b0BzbnRlY2guZGU7IGFybmRAYXJuZGIuZGU7DQo+ID4gbWF4aW1lLnJpcGFyZEBib290bGluLmNv
bTsgYmpvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc7DQo+ID4gamFnYW5AYW1hcnVsYXNvbHV0aW9u
cy5jb207IGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb207DQo+ID4gbWFyYy53LmdvbnphbGV6
QGZyZWUuZnI7IG9sb2ZAbGl4b20ubmV0OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4g
PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7DQo+ID4gbGludXgtIHBtQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14
IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIFYxMCAxLzRdIGR0
LWJpbmRpbmdzOiBmc2w6IHNjdTogYWRkIHRoZXJtYWwNCj4gPiBiaW5kaW5nDQo+ID4NCj4gPiBP
biBXZWQsIEZlYiAyNywgMjAxOSBhdCA2OjQ4IFBNIEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0Bu
eHAuY29tPg0KPiA+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IEhpLCBSb2INCj4gPiA+DQo+ID4gPiBC
ZXN0IFJlZ2FyZHMhDQo+ID4gPiBBbnNvbiBIdWFuZw0KPiA+ID4NCj4gPiA+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gRnJvbTogUm9iIEhlcnJpbmcgW21haWx0bzpyb2Jo
QGtlcm5lbC5vcmddDQo+ID4gPiA+IFNlbnQ6IDIwMTnlubQy5pyIMjjml6UgNzo1NQ0KPiA+ID4g
PiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+ID4gPiA+IENjOiBtYXJr
LnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gPiA+ID4gcy5oYXVlckBw
ZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5j
b207DQo+ID4gPiA+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxsLmRlYWNvbkBhcm0uY29t
Ow0KPiBydWkuemhhbmdAaW50ZWwuY29tOw0KPiA+ID4gPiBlZHViZXp2YWxAZ21haWwuY29tOyBk
YW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnOyBBaXNoZW5nIERvbmcNCj4gPiA+ID4gPGFpc2hlbmcu
ZG9uZ0BueHAuY29tPjsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgc2JveWRAa2VybmVsLm9yZzsN
Cj4gPiA+ID4gRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPjsgQW5keSBHcm9z
cw0KPiA+ID4gPiA8YW5keS5ncm9zc0BsaW5hcm8ub3JnPjsgaG9ybXMrcmVuZXNhc0B2ZXJnZS5u
ZXQuYXU7DQo+ID4gPiA+IGhlaWtvQHNudGVjaC5kZTsgYXJuZEBhcm5kYi5kZTsgbWF4aW1lLnJp
cGFyZEBib290bGluLmNvbTsNCj4gPiA+ID4gYmpvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc7IGph
Z2FuQGFtYXJ1bGFzb2x1dGlvbnMuY29tOw0KPiA+ID4gPiBlbnJpYy5iYWxsZXRib0Bjb2xsYWJv
cmEuY29tOyBtYXJjLncuZ29uemFsZXpAZnJlZS5mcjsNCj4gPiA+ID4gb2xvZkBsaXhvbS5uZXQ7
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiA+ID4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
DQo+ID4gPiA+IGxpbnV4LSBwbUB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgt
aW14QG54cC5jb20+DQo+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjEwIDEvNF0gZHQtYmlu
ZGluZ3M6IGZzbDogc2N1OiBhZGQgdGhlcm1hbA0KPiA+ID4gPiBiaW5kaW5nDQo+ID4gPiA+DQo+
ID4gPiA+IE9uIFdlZCwgRmViIDI3LCAyMDE5IGF0IDA4OjQ2OjIxQU0gKzAwMDAsIEFuc29uIEh1
YW5nIHdyb3RlOg0KPiA+ID4gPiA+IE5YUCBpLk1YOFFYUCBpcyBhbiBBUk12OCBTb0Mgd2l0aCBh
IENvcnRleC1NNCBjb3JlIGluc2lkZSBhcw0KPiA+ID4gPiA+IHN5c3RlbSBjb250cm9sbGVyLCB0
aGUgc3lzdGVtIGNvbnRyb2xsZXIgaXMgaW4gY2hhcmdlIG9mIHN5c3RlbQ0KPiA+ID4gPiA+IHBv
d2VyLCBjbG9jayBhbmQgdGhlcm1hbCBzZW5zb3JzIGV0Yy4gbWFuYWdlbWVudCwgTGludXgga2Vy
bmVsDQo+ID4gPiA+ID4gaGFzIHRvIGNvbW11bmljYXRlIHdpdGggc3lzdGVtIGNvbnRyb2xsZXIg
dmlhIE1VIChtZXNzYWdlIHVuaXQpDQo+ID4gPiA+ID4gSVBDIHRvIGdldCB0ZW1wZXJhdHVyZSBm
cm9tIHRoZXJtYWwgc2Vuc29ycywgdGhpcyBwYXRjaCBhZGRzDQo+ID4gPiA+ID4gYmluZGluZyBk
b2MgZm9yIGkuTVggc3lzdGVtIGNvbnRyb2xsZXIgdGhlcm1hbCBkcml2ZXIuDQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNv
bT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiBDaGFuZ2VzIHNpbmNlIFY5Og0KPiA+ID4gPiA+
ICAgICAtIGNoYW5nZSAjdGhlcm1hbC1zZW5zb3ItY2VsbHMgdmFsdWUgaW4gZXhhbXBsZSB0byAx
LCBzaW5jZQ0KPiA+ID4gPiA+IHRoZXJlIGFyZQ0KPiA+ID4gPiBvdGhlcg0KPiA+ID4gPiA+ICAg
ICAgIHRoZXJtYWwgc2Vuc29ycyBpbnNpZGUgc3lzdGVtIGNvbnRyb2xsZXIsIGl0IGlzIGp1c3QN
Cj4gPiA+ID4gPiBiZWNhdXNlIHRoZXJlIGFyZQ0KPiA+ID4gPiBzdGlsbA0KPiA+ID4gPiA+ICAg
ICAgIHNvbWUgaXNzdWUsIHNvIHN5c3RlbSBjb250cm9sbGVyIGRvZXMgTk9UIGV4cG9zZSB0aGVt
IGZvcg0KPiA+ID4gPiA+IG5vdywNCj4gPiA+ID4gdGhleSBjb3VsZA0KPiA+ID4gPiA+ICAgICAg
IGJlIGV4cG9zZWQgbGF0ZXIsIHNvIGl0IHNob3VsZCBiZSAxIGZyb20gSFcgcGVyc3BlY3RpdmUu
DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9m
cmVlc2NhbGUvZnNsLHNjdS50eHQgICB8IDIxDQo+ID4gPiA+ICsrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4gPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQNCj4gPiA+ID4gPiBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+
ID4gPiA+ID4gaW5kZXggNzJkNDgxYy4uODU1MjcwYiAxMDA2NDQNCj4gPiA+ID4gPiAtLS0NCj4g
PiA+ID4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxl
L2ZzbCxzY3UudHh0DQo+ID4gPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eA0KPiA+ID4gPiA+ICsrKyB0DQo+ID4gPiA+
ID4gQEAgLTEyMiw2ICsxMjIsMjEgQEAgUlRDIGJpbmRpbmdzIGJhc2VkIG9uIFNDVSBNZXNzYWdl
DQo+IFByb3RvY29sDQo+ID4gPiA+ID4gUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiA+ID4gPiAg
LSBjb21wYXRpYmxlOiBzaG91bGQgYmUgImZzbCxpbXg4cXhwLXNjLXJ0YyI7DQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiArVGhlcm1hbCBiaW5kaW5ncyBiYXNlZCBvbiBTQ1UgTWVzc2FnZSBQcm90b2Nv
bA0KPiA+ID4gPiA+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gK1JlcXVpcmVkIHByb3Bl
cnRpZXM6DQo+ID4gPiA+ID4gKy0gY29tcGF0aWJsZTogICAgICAgICAgICAgICAgICAgICAgU2hv
dWxkIGJlIDoNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiZnNsLGlt
eDhxeHAtc2MtdGhlcm1hbCINCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
Zm9sbG93ZWQgYnkgImZzbCxpbXgtc2MtdGhlcm1hbCI7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+
ICstICN0aGVybWFsLXNlbnNvci1jZWxsczogICBTZWUNCj4gPiA+ID4gRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwvdGhlcm1hbC50eHQNCj4gPiA+ID4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZm9yIGEgZGVzY3JpcHRpb24uDQo+ID4gPiA+ID4gKw0KPiA+
ID4gPiA+ICstIGlteCxzZW5zb3ItcmVzb3VyY2UtaWQ6ICBBIHNpbmdsZSBpbnRlZ2VyIGZvciBz
aW5nbGUgdGhlcm1hbA0KPiA+ID4gPiA+ICt6b25lJ3MNCj4gPiA+ID4gcmVzb3VyY2UgSUQgb3IN
Cj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgYW4gYXJyYXkgb2YgaW50ZWdl
cnMgdG8gc3BlY2lmeSBlYWNoDQo+ID4gPiA+ID4gKyB0aGVybWFsDQo+ID4gPiA+IHpvbmUncyBz
ZW5zb3INCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVzb3VyY2UgSUQu
DQo+ID4gPiA+DQo+ID4gPiA+IENhbid0IHlvdSBwdXQgdGhlIHJlc291cmNlIGlkcyBpbiB0aGUg
dGhlcm1hbC1zZW5zb3IgY2VsbHM/IFdoeSBkbw0KPiA+ID4gPiB5b3UgbmVlZCB0byBsaXN0IHRo
ZW0gaGVyZT8NCj4gPiA+DQo+ID4gPiBGb3IgdGhlIHRoZXJtYWwtc2Vuc29yIGNlbGxzLCBpZiB5
b3UgbWVhbnQgdGhlIGFyZ3VtZW50IG9mIHRzZW5zDQo+ID4gPiBwaGFuZGxlLCB0aGVuIHRoZSBy
ZWFzb24gaXMgdGhhdCBhcmd1bWVudCBpcyBmb3Igc2Vuc29yIGluZGV4DQo+ID4gPiBzdGFydGlu
ZyBmcm9tIDAsIHByZXZpb3VzIEkgdXNlIGl0IGZvciBvdXIgcmVzb3VyY2UgSUQsIGJ1dCBpdCBs
b29rcw0KPiA+ID4gY29uZnVzZWQsIHNpbmNlIHVzZXIgd2lsbCB0aGluayB0aGVyZSBhcmUgbWFu
eSBzZW5zb3JzIHRoZXJlIHBlcg0KPiBFZHVhcmRvJ3MgY29tbWVudC4NCj4gPiA+DQo+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICB0aGVybWFsLXNlbnNvcnMgPSA8JnRzZW5zIDA+Ow0KPiA+
ID4NCj4gPiA+IElmIHlvdSBtZWFudCBwdXR0aW5nIGl0IGluIGVhY2ggdGhlcm1hbCBzZW5zb3Ig
bm9kZSBpbnN0ZWFkIG9mICJ0c2VucyINCj4gPiA+IG5vZGUsIHRoZW4gaW4gcHJldmlvdXMgcGF0
Y2ggc2VyaWVzLCBJIHB1dCB0aGlzICINCj4gPiA+IGlteCxzZW5zb3ItcmVzb3VyY2UtaWQgIiBw
cm9wZXJ0eSBpbiBlYWNoIHRoZXJtYWwgc2Vuc29yIG5vZGUsIGJ1dA0KPiA+ID4gdGhlIHRoZXJt
YWwgc2Vuc29yIG5vZGVzIGFyZSBwYXJzZWQgYnkgY29tbW9uIHRoZXJtYWwgZnJhbWV3b3JrLA0K
PiA+ID4gdGhlcm1hbCBkcml2ZXIgd2lsbCBuZWVkIHRvIGZpbmQgdGhlIHRoZXJtYWwgem9uZSBu
b2RlIGFuZCBnbw0KPiA+ID4gdGhyb3VnaCBldmVyeSBjaGlsZCBub2RlIHRvIGdldCB0aGUgcmVz
b3VyY2UgaWQgYWdhaW4sIHNvIEVkdWFyZG8NCj4gPiA+IHN1Z2dlc3RlZCB0byBwdXQgaXQgaW4N
Cj4gPiBvdXIgcGxhdGZvcm0gdHNlbnMgbm9kZSwgdGhhdCBtYWtlcyBvdXIgdGhlcm1hbCBkcml2
ZXIgY29kZSBtdWNoIG1vcmUNCj4gPiBzaW1wbGUuDQo+ID4NCj4gPiBUaGUgcGhhbmRsZSBhcmdz
IGFyZSBtZWFudCB0byBiZSBhbiBpZCB0eXBpY2FsbHkuIFRoZXJlJ3MgYWJzb2x1dGVseQ0KPiA+
IG5vIHJlcXVpcmVtZW50IHRoZXkgYXJlIDAtTiBiYXNlZC4gVGhleSBvZnRlbiBhcmUgYmVjYXVz
ZSB0aGluZ3MgbGlrZQ0KPiA+IGludGVycnVwdHMgYXJlIDAtTiBvciBjbG9ja3MgaGF2ZSBubyBo
L3cgaWQuIElmIHlvdSBhbHJlYWR5IGhhdmUgYW4gaWQsIHVzZSBpdC4NCj4gPiBEb24ndCBpbnZl
bnQgeW91ciBvd24uDQo+IA0KPiBBdCB0aGUgYmVnaW5uaW5nLCBJIHB1dCB0aGUgSFcgcmVzb3Vy
Y2UgSUQgaW4gdGhlICJ0c2VucyIgcGhhbmRsZSBhcmd1bWVudA0KPiBvZiAidGhlcm1hbC1zZW5z
b3JzIiBub2RlLCBzZWUgIGJlbG93IHBhdGNoIEkgc2VudCBiZWZvcmUsIHRoZSBiZW5lZml0IGlz
IEkgZG8NCj4gTk9UIG5lZWQgdG8gYWRkIG5ldyBwcm9wZXJ0eSBmb3IgcGFzc2luZyBIVyByZXNv
dXJjZSBJRCB0byBkcml2ZXIsIHRoZQ0KPiBkaXNhZHZhbnRhZ2UgaXMsIEkgaGF2ZSB0byBwYXJz
ZSB0aGUgdGhlcm1hbF96b25lcycgZWFjaCBjaGlsZCBub2RlIGFuZCBnZXQNCj4gdGhlIEhXIHJl
c291cmNlIElEIGZyb20gcGhhbmRsZSBhcmd1bWVudChzZWFyaW5nIHRoZXJtYWxfem9uZXMgbm9k
ZQ0KPiBhbmQgZ28gdGhyb3VnaCBhbGwgaXRzIGNoaWxkIG5vZGUsIGFuZCBnZXQgdGhlIHBoYW5k
bGUgYXJndW1lbnQpLCB0aGV5IGFyZSBieQ0KPiBkZWZhdWx0IE9OTFkgcGFyc2VkIGJ5IHRoZXJt
YWwgY29yZSBkcml2ZXIuIFdoZW4gd2UgcmVnaXN0ZXIgdGhlcm1hbCB6b25lLA0KPiB3ZSBoYXZl
IHRvIHBhc3MgdGhlIEhXIHJlc291cmNlIElEIHdoZW4gY2FsbGluZw0KPiBkZXZtX3RoZXJtYWxf
em9uZV9vZl9zZW5zb3JfcmVnaXN0ZXIoKSwgaWYgd2UgYWRkIG91ciBvd24gcHJvcGVydHkgdG8N
Cj4gcGFzcyB0aGUgSFcgcmVzb3VyY2UgSUQsIHRoZW4gbm8gbmVlZCB0byBkbyBzbywgd2UganVz
dCBwYXNzIHRoZSBpbmRleCAwLU4NCj4gZm9yIGVhY2ggdGhlcm1hbCBzZW5zb3JzIGluIGRldmlj
ZXRyZWUgd2hpY2ggYWxzbyB3aXRoIHBoYW5kbGUgYXJndW1lbnQgMC0NCj4gTi4gU28gdXNpbmcg
b3VyIG93biBwcm9wZXJ0eSBtYWtlcyB0aGUgZHJpdmVyIG11Y2ggbW9yZSBzaW1wbGUuDQo+IA0K
PiBTbywgQEVkdWFyZG8sIHdoaWNoIGRpcmVjdGlvbiBJIHNob3VsZCBnbz8gTG9va3MgbGlrZSBS
b2Igc3VnZ2VzdHMganVzdCBwdXQNCj4gdGhlIEhXIHJlc291cmNlIElEIGluIHRoZSBwaGFuZGxl
IGFyZ3VtZW50IGxpa2Ugd2hhdCBJIGRpZCBhdCB0aGUgYmVnaW5uaW5nLA0KPiBjYW4geW91IGFk
dmlzZT8NCj4gDQo+IFRoYW5rcywNCj4gQW5zb24uDQo+IA0KPiBodHRwczovL3BhdGNod29yay5r
ZXJuZWwub3JnL3BhdGNoLzEwNzAzODQ5Lw0KPiA+ICsJdGhlcm1hbF96b25lczogdGhlcm1hbC16
b25lcyB7DQo+ID4gKwkJY3B1LXRoZXJtYWwwIHsNCj4gPiArCQkJcG9sbGluZy1kZWxheS1wYXNz
aXZlID0gPDI1MD47DQo+ID4gKwkJCXBvbGxpbmctZGVsYXkgPSA8MjAwMD47DQo+ID4gKwkJCXRo
ZXJtYWwtc2Vuc29ycyA9IDwmdHNlbnMgMzU1PjsNCj4gPiArCQkJdHJpcHMgew0KPiA+ICsJCQkJ
Y3B1X2FsZXJ0MDogdHJpcDAgew0KPiA+ICsJCQkJCXRlbXBlcmF0dXJlID0gPDEwNzAwMD47DQo+
ID4gKwkJCQkJaHlzdGVyZXNpcyA9IDwyMDAwPjsNCj4gPiArCQkJCQl0eXBlID0gInBhc3NpdmUi
Ow0KPiA+ICsJCQkJfTsNCj4gDQo+ID4NCj4gPiBSb2INCg==
