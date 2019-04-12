Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4F0C282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 02:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D82621721
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 02:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i2cIAXTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfDLCdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 22:33:00 -0400
Received: from mail-eopbgr50076.outbound.protection.outlook.com ([40.107.5.76]:2574
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726636AbfDLCdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 22:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2Jc+qzouzp7yeg1VmlMpeydRc6iSiByV/V6CqW0bZc=;
 b=i2cIAXTGoH4Jl6z1+Tp7fMxcu1fv9fNVt+NosE22En0AkvOrtQiH/I6XTwzuzHdMWADqaUoN7C7iDO5r24rRUlKaNXcNkWwy7r952f3EbxTqhuaehSTcIU0xm13+IKJx3YhCBvyB74RJFuDCUWe29YP6kXnXU9Sgj3gChtaC1xc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3819.eurprd04.prod.outlook.com (52.134.71.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Fri, 12 Apr 2019 02:32:54 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1792.016; Fri, 12 Apr 2019
 02:32:54 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [EXT] Re: [PATCH V7 2/4] firmware: imx: enable imx scu general
 irq function
Thread-Topic: [EXT] Re: [PATCH V7 2/4] firmware: imx: enable imx scu general
 irq function
Thread-Index: AQHU7pESFiPArqSQREy0TQYaxheiu6Y2lGmAgAElItCAABdgAIAAAZZg
Date:   Fri, 12 Apr 2019 02:32:54 +0000
Message-ID: <DB3PR0402MB39162D194A2B5B79211C1774F5280@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1554785675-8090-1-git-send-email-Anson.Huang@nxp.com>
 <1554785675-8090-2-git-send-email-Anson.Huang@nxp.com>
 <20190411073252.GC3050@dragon>
 <DB3PR0402MB3916B67E6DA995AB70C29799F5280@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM0PR04MB4211816EDBEF23F7B330CCCB80280@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211816EDBEF23F7B330CCCB80280@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 030bd3a3-a5af-410e-8091-08d6beef2ac5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3819;
x-ms-traffictypediagnostic: DB3PR0402MB3819:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0402MB3819F4CA15214654A25D0664F5280@DB3PR0402MB3819.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(376002)(396003)(366004)(189003)(199004)(13464003)(54906003)(478600001)(316002)(93886005)(256004)(52536014)(66066001)(5660300002)(486006)(7736002)(14444005)(97736004)(2906002)(44832011)(6116002)(3846002)(305945005)(74316002)(476003)(11346002)(229853002)(6436002)(8936002)(106356001)(53936002)(68736007)(26005)(966005)(71200400001)(186003)(4326008)(446003)(86362001)(71190400001)(81156014)(81166006)(105586002)(7416002)(7696005)(25786009)(6506007)(9686003)(53546011)(76176011)(33656002)(102836004)(6306002)(110136005)(55016002)(99286004)(2501003)(14454004)(6246003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3819;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tH0HfsQzRa8IqQibL0cxBJjKETo4zvohb2rH45wLNrLWB4mQfP7HBNjQ+Iu7bef/ShgXXQ7qDocYzRfpl6+GP6HwNUhw2dYGOZ7vSmmowvLjgDmTnyiMTApWhPC658E0KCQYLqE7hWUvw8Kpfno4ps2ovLL2oyRkslO/i4AqtTcuU9bX0Hk0FbkeT8EHFD2iSa/tORLCXqhGm91ks9Hzd0SaHgqcnt23OVlCDWAXFPmp8NQUGo7+SkIpuBOLkFaOtANmrYBezpboqQaQssE5p2tCpW8+8c5hGI1rjD77gCcRJxHlVj1B3NZ7/XUi20zoc2IUPpi5Su6oQCOCQDl0G7wLvrd9hebLblClTeSFyvf6DEwUSRs0nIyz//rl+NG5b4Ttuk+KO9tYGXn/Cpm2WUNbys7FdMQA8q9S0mSL07w=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030bd3a3-a5af-410e-8091-08d6beef2ac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 02:32:54.1700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3819
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogQWlzaGVuZyBEb25nDQo+IFNlbnQ6IDIwMTnE6jTUwjEyyNUgMTA6MjYN
Cj4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPjsgU2hhd24gR3VvDQo+IDxz
aGF3bmd1b0BrZXJuZWwub3JnPjsgYWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20NCj4gQ2M6
IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IHMuaGF1ZXJAcGVuZ3V0
cm9uaXguZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBh
Lnp1bW1vQHRvd2VydGVjaC5pdDsNCj4gYWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb207IHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc7IHNib3lkQGtlcm5lbC5vcmc7DQo+IFBlbmcgRmFuIDxwZW5n
LmZhbkBueHAuY29tPjsgRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPjsNCj4g
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXJ0Y0B2Z2Vy
Lmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtDQo+IGlteEBueHAuY29tPg0KPiBTdWJq
ZWN0OiBSRTogW0VYVF0gUmU6IFtQQVRDSCBWNyAyLzRdIGZpcm13YXJlOiBpbXg6IGVuYWJsZSBp
bXggc2N1IGdlbmVyYWwNCj4gaXJxIGZ1bmN0aW9uDQo+IA0KPiA+IEZyb206IEFuc29uIEh1YW5n
DQo+ID4gU2VudDogRnJpZGF5LCBBcHJpbCAxMiwgMjAxOSA5OjA2IEFNDQo+ID4NCj4gPiBIZWxs
bywgQWxleGFuZHJlDQo+ID4gCUFzIGkuTVggU0NVIGdlbmVyYWwgaXJxIGZ1bmN0aW9uIGlzIHBp
Y2tlZCB1cCBieSBTaGF3biwgY291bGQgeW91DQo+ID4gcGxlYXNlIGFsc28gcGljayB1cCBiZWxv
dyBpLk1YIFNDIFJUQyBhbGFybSBzdXBwb3J0IHBhdGNoID8NCj4gPiAJaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wYXRjaC8xMDg5MDUyNS8NCj4gPg0KPiANCj4gTm8sIGl0IGNhbid0IGdv
IHRocm91Z2ggQWxleGFuZHJlJ3MgdHJlZSBkdWUgdG8gZGVwZW5kZW5jeSBpc3N1ZS4NCj4gDQo+
IFNoYXduLA0KPiBEbyB5b3UgdGhpbmsgeW91IGNhbiBwaWNrIGl0IHVwPyBBbGV4YW5kcmUgYWxy
ZWFkeSBnYXZlIHRoZSBBY2suDQo+IA0KPiBBRkFJSyB0aGVyZSdzIG5vIG90aGVyIFNDVSBSVEMg
cGF0Y2hlcyBzaW5jZSB2NS4xLXJjMSBpbiBBbGV4YW5kcmUncyB0cmVlLg0KDQpZZXMsIG5lZWQg
dG8gbWFrZSBzdXJlIHRoZSBkZXBlbmRlbmN5IGlzIGhhbmRsZWQsIHRoZSBSVEMgYWxhcm0gcGF0
Y2ggTVVTVCBiZSBwaWNrZWQgdXANCk9OTFkgd2hlbiBzY3UgaXJxIHBhdGNoIGlzIHJlYWR5LCBO
T1Qgc3VyZSBob3cgdG8gaGFuZGxlIHRoaXMgY2FzZSBmb3Igc3VjaCBzY2VuYXJpbz8NCg0KQW5z
b24uDQoNCj4gDQo+IFJlZ2FyZHMNCj4gRG9uZyBBaXNoZW5nDQo+IA0KPiA+ID4gT24gVHVlLCBB
cHIgMDksIDIwMTkgYXQgMDQ6NTk6NTVBTSArMDAwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4g
PiA+IFRoZSBTeXN0ZW0gQ29udHJvbGxlciBGaXJtd2FyZSAoU0NGVykgY29udHJvbHMgUlRDLCB0
aGVybWFsIGFuZA0KPiA+ID4gPiBXRE9HIGV0Yy4sIHRoZXNlIHJlc291cmNlcycgaW50ZXJydXB0
IGZ1bmN0aW9uIGFyZSBtYW5hZ2VkIGJ5IFNDVS4NCj4gPiA+ID4gV2hlbiBhbnkgSVJRIHBlbmRp
bmcsIFNDVSB3aWxsIG5vdGlmeSBMaW51eCB2aWEgTVUgZ2VuZXJhbA0KPiA+ID4gPiBpbnRlcnJ1
cHQgY2hhbm5lbCAjMywgYW5kIExpbnV4IGtlcm5lbCBuZWVkcyB0byBjYWxsIFNDVSBBUElzIHRv
DQo+ID4gPiA+IGdldCBJUlEgc3RhdHVzIGFuZCBub3RpZnkgZWFjaCBtb2R1bGUgdG8gaGFuZGxl
IHRoZSBpbnRlcnJ1cHQuDQo+ID4gPiA+DQo+ID4gPiA+IFNpbmNlIHRoZXJlIGlzIG5vIGRhdGEg
dHJhbnNtaXNzaW9uIGZvciBTQ1UgSVJRIG5vdGlmaWNhdGlvbiwgc28NCj4gPiA+ID4gZG9vcmJl
bGwgbW9kZSBpcyB1c2VkIGZvciB0aGlzIE1VIGNoYW5uZWwsIGFuZCBTQ1UgZHJpdmVyIHdpbGwg
dXNlDQo+ID4gPiA+IG5vdGlmaWVyIG1lY2hhbmlzbSB0byBicm9hZGNhc3QgdG8gZXZlcnkgbW9k
dWxlIHdoaWNoIHJlZ2lzdGVycw0KPiA+ID4gPiB0aGUgU0NVIGJsb2NrIG5vdGlmaWVyLg0KPiA+
ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhw
LmNvbT4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54
cC5jb20+DQo+ID4gPg0KPiA+ID4gQXBwbGllZCwgdGhhbmtzLg0K
