Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D633C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203B920657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nKySQ9h9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbfEOMGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:06:01 -0400
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:21558
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729041AbfEOLKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WVVNA4cKGt/UxrXGJFOcJZrjHtOZEc5fmxG/3Pxjo8=;
 b=nKySQ9h9Mk7Y/BdWsGtmWAaOIkkHzKcb9C+5SRvxHyJHghmF5yJapP/QN0zEYMUMsc7PuvOGUWMY5ateeUX4TdJMfEaEkBj1O8McfdPm9bGGgS5yoccby43bf29kyaOH6ABbVPCOP6FpluZurtXEEvpQ33NWAb9csaqgDXap29E=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3786.eurprd04.prod.outlook.com (52.134.71.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Wed, 15 May 2019 11:10:29 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 11:10:28 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
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
        Abel Vesa <abel.vesa@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH V2 1/2] soc: imx: Add SCU SoC info driver support
Thread-Topic: [PATCH V2 1/2] soc: imx: Add SCU SoC info driver support
Thread-Index: AQHVCvixb1MFrIDHlECOalYM+lyDeaZsB0hQ
Date:   Wed, 15 May 2019 11:10:28 +0000
Message-ID: <DB3PR0402MB3916D8523F78E0190AB3E9D6F5090@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1557908823-11349-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB6434C2BCE2116836CFC0FEBFEE090@AM0PR04MB6434.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB6434C2BCE2116836CFC0FEBFEE090@AM0PR04MB6434.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b9856ae-8022-4275-c88e-08d6d925f067
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3786;
x-ms-traffictypediagnostic: DB3PR0402MB3786:
x-microsoft-antispam-prvs: <DB3PR0402MB3786CE5792D0B35C2A836DE4F5090@DB3PR0402MB3786.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(376002)(346002)(39860400002)(13464003)(199004)(189003)(6246003)(81156014)(6506007)(53936002)(476003)(54906003)(102836004)(7696005)(2906002)(14444005)(256004)(76176011)(8936002)(6862004)(4326008)(316002)(5660300002)(99286004)(68736007)(33656002)(305945005)(7736002)(44832011)(3846002)(8676002)(25786009)(6116002)(53546011)(52536014)(7416002)(64756008)(66556008)(66476007)(66446008)(86362001)(73956011)(26005)(76116006)(186003)(14454004)(81166006)(66066001)(11346002)(486006)(446003)(74316002)(478600001)(71200400001)(71190400001)(6436002)(9686003)(55016002)(66946007)(229853002)(6636002)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3786;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /KXIOWlEYpFn3beA4CB6fHIyJEdEmPxI0PrNW2smrh7Rb3C0vJOfmvm6Wb7ftCiTHNHTM45C5lALeK90uhEDtRb/PbphILnrIjGCe6NGFSG0xSpsFSSHLD1g+a4ij7WqntWLJpz2hi93kHAQc8aemfnh3bzPSNv5OWU+Tq++yjydL7PIZIBrQc7lmTNQagMpd6gF3rrn76Mxow2mAngwAHJsHf3q+Q7B/oGADLjk3R1SHS25gxkZB+LnkDu8oC35D2PRqotOCMl9tlGnMisK7zhcDfXjgI+SxUPzBJETh16e/x4qjHBt5FI0Hy6uEMzvvH6LjQFloIgcqNSQjTHm7EEuJtwGrq3PQCH2aeMWziztEIKaBVprJ292kfxMgXzzCuD5O75iTTnQ2OYnf8auwTEadY6V/otsIJNsFTIvvEc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9856ae-8022-4275-c88e-08d6d925f067
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 11:10:28.8003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3786
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIExlb25hcmQNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMZW9u
YXJkIENyZXN0ZXoNCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgMTUsIDIwMTkgNjowNSBQTQ0KPiBU
bzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENjOiBjYXRhbGluLm1hcmlu
YXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsg
cy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZh
bUBnbWFpbC5jb207IGFncm9zc0BrZXJuZWwub3JnOyBtYXhpbWUucmlwYXJkQGJvb3RsaW4uY29t
Ow0KPiBvbG9mQGxpeG9tLm5ldDsgaG9ybXMrcmVuZXNhc0B2ZXJnZS5uZXQuYXU7DQo+IGphZ2Fu
QGFtYXJ1bGFzb2x1dGlvbnMuY29tOyBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZzsNCj4gbWFy
Yy53LmdvbnphbGV6QGZyZWUuZnI7IGRpbmd1eWVuQGtlcm5lbC5vcmc7DQo+IGVucmljLmJhbGxl
dGJvQGNvbGxhYm9yYS5jb207IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IEFiZWwgVmVzYQ0KPiA8
YWJlbC52ZXNhQG54cC5jb20+OyByb2JoQGtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxp
bnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyBBaXNoZW5nIERvbmcgPGFpc2hlbmcuZG9u
Z0BueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDEvMl0gc29jOiBpbXg6IEFkZCBT
Q1UgU29DIGluZm8gZHJpdmVyIHN1cHBvcnQNCj4gDQo+IE9uIDE1LjA1LjIwMTkgMTE6MzIsIEFu
c29uIEh1YW5nIHdyb3RlOg0KPiA+IEFkZCBpLk1YIFNDVSBTb0MgaW5mbyBkcml2ZXIgdG8gc3Vw
cG9ydCBpLk1YOFFYUCBTb0MsIGludHJvZHVjZSBkcml2ZXINCj4gPiBkZXBlbmRlbmN5IGludG8g
S2NvbmZpZyBhcyBDT05GSUdfSU1YX1NDVSBtdXN0IGJlIHNlbGVjdGVkIHRvIHN1cHBvcnQNCj4g
PiBpLk1YIFNDVSBTb0MgZHJpdmVyLCBhbHNvIG5lZWQgdG8gdXNlIHBsYXRmb3JtIGRyaXZlciBt
b2RlbCB0byBtYWtlDQo+ID4gc3VyZSBJTVhfU0NVIGRyaXZlciBpcyBwcm9iZWQgYmVmb3JlIGku
TVggU0NVIFNvQyBkcml2ZXIuDQo+ID4NCj4gPiBXaXRoIHRoaXMgcGF0Y2gsIFNvQyBpbmZvIGNh
biBiZSByZWFkIGZyb20gc3lzZnM6DQo+IA0KPiA+ICsJaWQgPSBvZl9tYXRjaF9ub2RlKGlteF9z
Y3Vfc29jX21hdGNoLCByb290KTsNCj4gPiArCWlmICghaWQpIHsNCj4gPiArCQlvZl9ub2RlX3B1
dChyb290KTsNCj4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiArCX0NCj4gDQo+IFBlcmhhcHMg
dGhpcyBjaGVjayBzaG91bGQgYmUgbW92ZWQgZnJvbSBpbXhfc2N1X3NvY19wcm9iZSB0bw0KPiBp
bXhfc2N1X3NvY19pbml0PyBBcyBmYXIgYXMgSSBjYW4gdGVsbCB0aGlzICJwcm9iZSIgZnVuY3Rp
b24gd2lsbCBiZSBhdHRlbXB0ZWQNCj4gb24gYWxsIFNPQ3MgKGV2ZW4gbm9uLWlteCkuIEJldHRl
ciB0byBjaGVjayBpZiB3ZSdyZSBvbiBhIFNDVS1iYXNlZCBzb2MgZWFybHkNCj4gYW5kIGF2b2lk
IHRlbXBvcmFyeSBhbGxvY2F0aW9ucy4NCg0KTWFrZSBzZW5zZSwgSSB3aWxsIG1vdmUgdGhpcyBj
aGVjayBibG9jayBpbnRvIGlteF9zY3Vfc29jX2luaXQoKSBmdW5jdGlvbiBhbmQNCk9OTFkgcmVn
aXN0ZXIgcGxhdGZvcm0gZHJpdmVyIHdoZW4gY2hlY2sgcGFzc2VkLg0KDQo+IA0KPiA+ICttb2R1
bGVfaW5pdChpbXhfc2N1X3NvY19pbml0KTsNCj4gPiArbW9kdWxlX2V4aXQoaW14X3NjdV9zb2Nf
ZXhpdCk7DQo+IA0KPiBQbGVhc2UgZG9uJ3QgbWFrZSB0aGlzIGEgbW9kdWxlDQoNCk9LLCB3aWxs
IGZpeCBpdCBpbiBWMy4NCg0KVGhhbmtzLA0KQW5zb24uDQoNCj4gDQo+IC0tDQo+IFJlZ2FyZHMs
DQo+IExlb25hcmQNCg==
