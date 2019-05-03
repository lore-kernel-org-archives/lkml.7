Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65FEC004C9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4F02089E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VoE5CMwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfECNBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 09:01:06 -0400
Received: from mail-eopbgr130077.outbound.protection.outlook.com ([40.107.13.77]:52965
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbfECNBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 09:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bGCSRBedFExNob9USjPhrev+AeBnxxUlE1UwuDJV2g=;
 b=VoE5CMwA1qZqYzPaOIWfWDU3msZjKg2iEgHdFQsi/4W8Mvj7fqlOM7vHIWGURIa/lxCdjJQJx5NAc1kZX1CBvg4IvJNb1M7dsCp72RqYTcrqVEvlt6NksLoizhf+1hcDig29w8J8Czlxt7xNAHOyeVsKWxiK3VQpSw9szXy2J9g=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Fri, 3 May 2019 13:00:59 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1856.012; Fri, 3 May 2019
 13:00:59 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] clk: imx: pllv4: add fractional-N pll support
Thread-Topic: [PATCH V2] clk: imx: pllv4: add fractional-N pll support
Thread-Index: AQHU/u+rfzNhsf6HmUqZui5Dk6oOlaZWxBSAgAKeEQA=
Date:   Fri, 3 May 2019 13:00:58 +0000
Message-ID: <DB3PR0402MB3916CB92026E67F0D7BE045BF5350@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1556585557-28795-1-git-send-email-Anson.Huang@nxp.com>
 <155674445915.200842.2835083854881674143@swboyd.mtv.corp.google.com>
In-Reply-To: <155674445915.200842.2835083854881674143@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e74dbac-2209-4e79-700a-08d6cfc76360
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3659;
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-microsoft-antispam-prvs: <DB3PR0402MB36595F2C2B82A00660A6717AF5350@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(199004)(13464003)(189003)(81166006)(8676002)(81156014)(52536014)(3846002)(8936002)(6116002)(55016002)(9686003)(7736002)(6436002)(316002)(305945005)(6636002)(229853002)(53936002)(110136005)(6246003)(5660300002)(478600001)(99286004)(66066001)(73956011)(102836004)(66946007)(76176011)(53546011)(6506007)(71200400001)(71190400001)(7696005)(76116006)(66446008)(64756008)(66556008)(66476007)(256004)(14444005)(33656002)(186003)(2201001)(4326008)(25786009)(86362001)(14454004)(68736007)(2906002)(45080400002)(2501003)(11346002)(26005)(476003)(446003)(44832011)(74316002)(486006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3659;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zXjDiLjeG47ZlMy1yeU0mpdvEBjHVPC1zwixJ59d+jEIZCTVuhNeus36GkSCuUBcEM2egO30gEqs9ZN73SeiDh9H/1QMaaEIkJNzrNXdTSBzSt4+BvH1htFB5MU5bAohC7x7kG1ANzaGnQU/6ptxbCaq9WypVmgOsISt2x1VdNn87293OXBb7TZqLsbz4GKaj26pTNeb8wk9T1KK5YIjakDaH+9Y+J58JHsF2BqOKVVdZgVvQBx0qsthn8lQFVdJoQeZL+0NbMfCYaFzusrS9yXMwNoglP0wdv2aIHAAuj+5nWot4tzJWZPNDleEeuVS8XJFQISMC9UwsE074+LtaJxs06GdQ6d5Uefng+s+/ppk0H88+M5rehItr3kUsAbumBBkmXQXUIUulkrdxwiZKpUfgUUTr8YCeDV3+ZYDod4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e74dbac-2209-4e79-700a-08d6cfc76360
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 13:00:59.1159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZXBoZW4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVw
aGVuIEJveWQgW21haWx0bzpzYm95ZEBrZXJuZWwub3JnXQ0KPiBTZW50OiBUaHVyc2RheSwgTWF5
IDIsIDIwMTkgNTowMSBBTQ0KPiBUbzogZmVzdGV2YW1AZ21haWwuY29tOyBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4
LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBt
dHVycXVldHRlQGJheWxpYnJlLmNvbTsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsgc2hhd25n
dW9Aa2VybmVsLm9yZzsgQWlzaGVuZyBEb25nDQo+IDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IEFu
c29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiBDYzogZGwtbGludXgtaW14IDxsaW51
eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMl0gY2xrOiBpbXg6IHBsbHY0
OiBhZGQgZnJhY3Rpb25hbC1OIHBsbCBzdXBwb3J0DQo+IA0KPiBUaGUgQ29udGVudC10cmFuc2Zl
ci1lbmNvZGluZyBoZWFkZXIgaXMgc3RpbGwgYmFzZTY0LiBJIGd1ZXNzIGl0IGNhbid0IGJlIGZp
eGVkLg0KDQpCZWxvdyBpcyBteSBnaXQgc2VuZG1haWwgY29uZmlndXJhdGlvbiwgdGhlIGVuY29k
aW5nIGlzIHNldCB0byBVVEYtOCwgSSBkb24ndCBrbm93DQp3aHkgaXQgaXMgc3RpbGwgYmFzZTY0
LCBsZXQgbWUga25vdyBpZiB5b3Uga25vdyBob3cgdG8gZml4IGl0LCB0aGFua3MuIEFuZCwgd2ls
bCB5b3Ugc3RpbGwNCnJldmlldyB0aGlzIHBhdGNoPyANCg0KQW5zb24uDQoNCiAgNiBbc2VuZGVt
YWlsXQ0KICA3ICAgICAgICAgc210cHNlcnZlciA9IG91dGxvb2sub2ZmaWNlMzY1LmNvbQ0KICA4
ICAgICAgICAgc210cGVuY3J5cHRpb24gPSB0bHMNCiAgOSAgICAgICAgIHNtdHB1c2VyID0gQW5z
b24uSHVhbmdAbnhwLmNvbQ0KIDEwICAgICAgICAgc210cHNlcnZlcnBvcnQgPSA1ODcNCiAxMSAg
ICAgICAgIGNvbmZpcm0gPSBuZXZlcg0KIDEyICAgICAgICAgYXNzdW1lOGJpdEVuY29kaW5nID0g
VVRGLTgNCg0KDQo+IA0KPiBRdW90aW5nIEFuc29uIEh1YW5nICgyMDE5LTA0LTI5IDE3OjU3OjIy
KQ0KPiA+IFRoZSBwbGx2NCBzdXBwb3J0cyBmcmFjdGlvbmFsLU4gZnVuY3Rpb24sIHRoZSBmb3Jt
dWxhIGlzOg0KPiA+DQo+ID4gUExMIG91dHB1dCBmcmVxID0gaW5wdXQgKiAobXVsdCArIG51bS9k
ZW5vbSksDQo+ID4NCj4gPiBUaGlzIHBhdGNoIGFkZHMgZnJhY3Rpb25hbC1OIGZ1bmN0aW9uIHN1
cHBvcnQsIGluY2x1ZGluZyBjbG9jayByb3VuZA0KPiA+IHJhdGUsIGNhbGN1bGF0ZSByYXRlIGFu
ZCBzZXQgcmF0ZSwgd2l0aCB0aGlzIHBhdGNoLCB0aGUgY2xvY2sgcmF0ZSBvZg0KPiA+IEFQTEwg
aW4gY2xvY2sgdHJlZSBpcyBtb3JlIGFjY3VyYXRlIHRoYW4gYmVmb3JlOg0KPiA+DQo=
