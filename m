Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564CEC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBFF206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sLM1xDEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfEPLJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:09:34 -0400
Received: from mail-eopbgr130045.outbound.protection.outlook.com ([40.107.13.45]:36526
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726363AbfEPLJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ha2NsyKgYgQ1gbTS+hR677Dg5idbqKDTX/U4xyPZ/0=;
 b=sLM1xDEbdsm3cmv+RDMXenUNENxj4khcvTX0+X1v+84MQQRxpXKEB/Jjkph/lcXO+yMP7QhHl8QpdeZPyP9W+Q9y1H6TYRDzlfFnStgyM7dsf53rD06c05u+0U7l2D6yVou/6vxY1DxiplKqlAH6bn24W9SCIDStdBCTrezXNYQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3945.eurprd04.prod.outlook.com (52.134.65.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 11:09:29 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 11:09:29 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 1/2] soc: imx: Add SCU SoC info driver support
Thread-Topic: [PATCH V3 1/2] soc: imx: Add SCU SoC info driver support
Thread-Index: AQHVC5bqk1P5MqRzRU2gqcSUyb18B6ZtleYw
Date:   Thu, 16 May 2019 11:09:29 +0000
Message-ID: <DB3PR0402MB3916C57857BC1064FD4295B5F50A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1557976777-8304-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB6434E01AD0A18405A9E0DDF8EE0A0@AM0PR04MB6434.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB6434E01AD0A18405A9E0DDF8EE0A0@AM0PR04MB6434.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cecb6db5-c70a-48c0-b9b1-08d6d9eef749
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3945;
x-ms-traffictypediagnostic: DB3PR0402MB3945:
x-microsoft-antispam-prvs: <DB3PR0402MB394513EC19918715390266D7F50A0@DB3PR0402MB3945.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(39860400002)(366004)(13464003)(189003)(199004)(53936002)(6436002)(2906002)(2501003)(9686003)(110136005)(54906003)(14454004)(316002)(7416002)(99286004)(5660300002)(229853002)(74316002)(86362001)(478600001)(33656002)(6246003)(55016002)(8936002)(102836004)(446003)(81156014)(8676002)(476003)(66066001)(81166006)(64756008)(66556008)(66446008)(68736007)(76116006)(11346002)(66476007)(305945005)(7736002)(76176011)(26005)(7696005)(486006)(71190400001)(71200400001)(186003)(3846002)(6116002)(73956011)(52536014)(66946007)(44832011)(256004)(25786009)(4326008)(6506007)(53546011)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3945;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Zt29hRZUbDamH7107o/fRAPBcyStR8659eEDhj/i94mmd7PCaklQVtWPJTfJjivmTuzAy6KGQW1j56Uh3hv1R2WhMlfCK++FnpmRIRTUJCfIHx2oSYrZgdvYENbMJPTQ36TxDIxptE+s4Ut+HFawkkkZ6JwJYR96Tu0QFXTLRm1IJyFQjhS2yAAbOwE1GexnjnjNn6hJVAsKnM9s97y14aLlcjoRgSTM/B+LWxbwx+ykPg2M7Y4xvZ4lD7szKK7fRpGe994hhLOJAFFqdnHbzbQ2CHjFogizwpgL9HU8Sb92Sj3PMV+uaQAFUcLPUI/fviSLQh1yZMi2VXSiUjfiDcJa87nKb4bhOOU87TsE9pkKqyyUWJ9HIdmsbbpCt1tYeLuO6zco7COE337ubdgCl3tF66qHYWDWYgwtSl9W/ag=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cecb6db5-c70a-48c0-b9b1-08d6d9eef749
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 11:09:29.1980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3945
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIExlb25hcmQNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMZW9u
YXJkIENyZXN0ZXoNCj4gU2VudDogVGh1cnNkYXksIE1heSAxNiwgMjAxOSA2OjA3IFBNDQo+IFRv
OiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47IHNoYXduZ3VvQGtlcm5lbC5vcmcN
Cj4gQ2M6IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxsLmRlYWNvbkBhcm0uY29tOw0KPiBz
LmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdt
YWlsLmNvbTsNCj4gYWdyb3NzQGtlcm5lbC5vcmc7IG1heGltZS5yaXBhcmRAYm9vdGxpbi5jb207
IG9sb2ZAbGl4b20ubmV0Ow0KPiBob3JtcytyZW5lc2FzQHZlcmdlLm5ldC5hdTsgamFnYW5AYW1h
cnVsYXNvbHV0aW9ucy5jb207DQo+IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBtYXJjLncu
Z29uemFsZXpAZnJlZS5mcjsNCj4gZGluZ3V5ZW5Aa2VybmVsLm9yZzsgZW5yaWMuYmFsbGV0Ym9A
Y29sbGFib3JhLmNvbTsNCj4gbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgQWlzaGVuZyBEb25nIDxh
aXNoZW5nLmRvbmdAbnhwLmNvbT47IEFiZWwgVmVzYQ0KPiA8YWJlbC52ZXNhQG54cC5jb20+OyBy
b2JoQGtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14
QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMS8yXSBzb2M6IGlteDogQWRkIFND
VSBTb0MgaW5mbyBkcml2ZXIgc3VwcG9ydA0KPiANCj4gT24gMTYuMDUuMjAxOSAwNjoyNCwgQW5z
b24gSHVhbmcgd3JvdGU6DQo+ID4gQWRkIGkuTVggU0NVIFNvQyBpbmZvIGRyaXZlciB0byBzdXBw
b3J0IGkuTVg4UVhQIFNvQywgaW50cm9kdWNlIGRyaXZlcg0KPiA+IGRlcGVuZGVuY3kgaW50byBL
Y29uZmlnIGFzIENPTkZJR19JTVhfU0NVIG11c3QgYmUgc2VsZWN0ZWQgdG8gc3VwcG9ydA0KPiA+
IGkuTVggU0NVIFNvQyBkcml2ZXIsIGFsc28gbmVlZCB0byB1c2UgcGxhdGZvcm0gZHJpdmVyIG1v
ZGVsIHRvIG1ha2UNCj4gPiBzdXJlIElNWF9TQ1UgZHJpdmVyIGlzIHByb2JlZCBiZWZvcmUgaS5N
WCBTQ1UgU29DIGRyaXZlci4NCj4gDQo+ID4gKyNkZWZpbmUgaW14X3NjdV9yZXZpc2lvbihzb2Nf
cmV2KSBcDQo+ID4gKwlzb2NfcmV2ID8gXA0KPiA+ICsJa2FzcHJpbnRmKEdGUF9LRVJORUwsICIl
ZC4lZCIsIChzb2NfcmV2ID4+IDQpICYgMHhmLCAgc29jX3JldiAmDQo+IDB4ZikgOiBcDQo+ID4g
KwkidW5rbm93biINCj4gDQo+ID4gKwlpZCA9IG9mX21hdGNoX25vZGUoaW14X3NjdV9zb2NfbWF0
Y2gsIHBkZXYtPmRldi5vZl9ub2RlKTsNCj4gPiArCWRhdGEgPSBpZC0+ZGF0YTsNCj4gPiArCWlm
IChkYXRhKSB7DQo+ID4gKwkJc29jX2Rldl9hdHRyLT5zb2NfaWQgPSBkYXRhLT5uYW1lOw0KPiA+
ICsJCWlmIChkYXRhLT5zb2NfcmV2aXNpb24pDQo+ID4gKwkJCXNvY19yZXYgPSBkYXRhLT5zb2Nf
cmV2aXNpb24oKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlzb2NfZGV2X2F0dHItPnJldmlzaW9u
ID0gaW14X3NjdV9yZXZpc2lvbihzb2NfcmV2KTsNCj4gPiArCWlmICghc29jX2Rldl9hdHRyLT5y
ZXZpc2lvbikNCj4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gDQo+IFRoZSBpbXhfc2N1X3Jldmlz
aW9uIG1hY3JvIHJldHVybnMgZWl0aGVyIGthc3ByaW50ZiBvciAidW5rbm93biIsIG5ldmVyDQo+
IE5VTEwuIFNvIGl0J3Mgbm90IGNsZWFyIHdoYXQgdGhpcyByZXR1cm4gLUVOT0RFViBkb2VzIGV4
YWN0bHkuDQoNClRoZSBrYXNwcmludGYgY291bGQgcmV0dXJuIE5VTEwgdGhvdWdoLg0KDQo+IA0K
PiBJdCBtYWtlcyBtb3JlIHNlbnNlIHRvIHJldHVybiAtRU5PREVWIGlmIGdldF9zb2NfcmV2aXNp
b24gZmFpbHMsIHNvIG1heWJlDQo+IGNoZWNrICJzb2NfcmV2ICE9IDAiIGluc3RlYWQ/DQo+IA0K
PiBJZiB5b3UgcmVhbGx5IHdhbnQgdG8gY2hlY2sgdGhlIGthc3ByaW50ZiByZXN1bHQgdGhlbiB5
b3Ugc2hvdWxkIHJldHVybiAtDQo+IEVOT01FTSBmb3IgaXQuIEl0IHdvdWxkIGJlIGNsZWFyZXIg
aWYgeW91IGRyb3BwZWQgdGhlIGlteF9zY3VfcmV2aXNpb24NCj4gcmV2aXNpb24gbWFjcm8gYW5k
IG9wZW4tY29kZWQgaW5zdGVhZC4NCg0KVGhpcyBtYWtlcyBtb3JlIHNlbnNlLCBJIHRoaW5rIG1h
eWJlIHdlIGNhbiByZW1vdmUgdGhlIGlteF9zY3VfcmV2aXNpb24gbWFjcm8sDQpqdXN0IHVzZSBi
ZWxvdyBjb2RlIGluc3RlYWQsIGFuZCByZXR1cm4gLUVOT01FTSBpZiBrYXNwcmludGYgcmV0dXJu
cyBOVUxMLg0KDQoxMTMgICAgICAgICBzb2NfZGV2X2F0dHItPnJldmlzaW9uID0gc29jX3JldiA/
IGthc3ByaW50ZihHRlBfS0VSTkVMLA0KMTE0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIiVkLiVkIiwNCjExNSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChzb2NfcmV2ID4+IDQpICYgMHhmLA0K
MTE2ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c29jX3JldiAmIDB4ZikgOiAidW5rbm93biI7DQoxMTcgICAgICAgICBpZiAoIXNvY19kZXZfYXR0
ci0+cmV2aXNpb24pDQoxMTggICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KDQpCVFcs
IHRoZSBzb2MtaW14OC5jIGxvb2tzIGxpa2UgYWxzbyBoYXZpbmcgc2FtZSBpc3N1ZSwgZG8geW91
IHRoaW5rIHdlIHNob3VsZCBmaXggaXQNCmFzIHdlbGw/DQoNCkFuc29uDQoNCj4gDQo+IC0tDQo+
IFJlZ2FyZHMsDQo+IExlb25hcmQNCg==
