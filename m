Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F52C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 02:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22BE2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 02:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PSIXPy9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfCRCbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 22:31:39 -0400
Received: from mail-eopbgr130078.outbound.protection.outlook.com ([40.107.13.78]:6274
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726828AbfCRCbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 22:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qu1XYKv/fZUREoycztnTktuidPi0FAGMMyGhp1kI2a4=;
 b=PSIXPy9saj4+qnX4AXmX6Ke1m693dxMf3lVZzilmXKv9gpIe3WJ3sqD+AhZ71DmWQ46DRy1vi38DoZzZvfeS9Sv/cZf3i0Axw9CKt8ivUX1H5pgbszfsOIAtcsTVIUQ1ZQNtraHEI/ZNZghnE7BxUUM+2Gr9XXaT/sJvT2AamGs=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5602.eurprd04.prod.outlook.com (20.178.118.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 02:31:34 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185%5]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 02:31:34 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH 1/2] ARM: imx: drop uneccessary
 of_platform_default_populate
Thread-Topic: [PATCH 1/2] ARM: imx: drop uneccessary
 of_platform_default_populate
Thread-Index: AQHU2Xv1SFnRc4p0SkOOn59vTkEkO6YMepnAgAAsWECAAA3s4IAD+k9w
Date:   Mon, 18 Mar 2019 02:31:34 +0000
Message-ID: <AM0PR04MB448101B88810300ABAFD8DE488470@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190313091757.16410-1-peng.fan@nxp.com>
 <AM0PR04MB4211DC74D7E72F886A4333D680440@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4481232D83340F894644673C88440@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <AM0PR04MB421176101FD9525175463D5F80440@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB421176101FD9525175463D5F80440@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7254ea27-d6aa-41c8-f0be-08d6ab49d6f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5602;
x-ms-traffictypediagnostic: AM0PR04MB5602:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB5602DDCFBD3212C1C049078D88470@AM0PR04MB5602.eurprd04.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(396003)(136003)(376002)(189003)(199004)(13464003)(76176011)(55016002)(53936002)(6506007)(6306002)(53546011)(9686003)(6246003)(52536014)(97736004)(2906002)(68736007)(486006)(86362001)(33656002)(478600001)(2201001)(11346002)(446003)(966005)(476003)(66066001)(6436002)(105586002)(106356001)(102836004)(186003)(26005)(229853002)(14454004)(25786009)(305945005)(316002)(74316002)(256004)(7736002)(93886005)(5660300002)(14444005)(99286004)(81166006)(2501003)(110136005)(8676002)(71200400001)(71190400001)(6116002)(81156014)(3846002)(8936002)(4326008)(7696005)(44832011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5602;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tU2CgN3NPet6Z7I8+NlrFFGN1tVvJSWMf9DHr3p40YOnj4lv4XZ107HjRtyOD8SXnMKAi+DlwMmK809XEfseQUlPOpbYWGqlYYGvCppeQT6fZow0XLS85JPnAXymfrqdKda9F21Vh/I8vab9OM0RoLd+FBy+lBDAD5tCUR33wKYvTc9bTkivu9pcaXkVQcOIug/cTzywv2H4AdYjlfLkbdLaAIxqQvOd213yQXceFDn3UNAY1eo7oQ47LLwhE6amQVxM0vSfNkzdg6e9hPlp32W1NJU2wo0PRKF8xNyNAVv8GQdkAXYuV7jOqurKtS6Tv06o+KTj6KgDWImhA1/GsUrMYstv9Xvrsi9lmfoeuaRBrC/cb7euFpiw7xN4dkgSazVqWzCszqPMPol/gHAhMoY985D47FNUBLZqPqe6X68=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7254ea27-d6aa-41c8-f0be-08d6ab49d6f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 02:31:34.5832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5602
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWlzaGVuZyBEb25nDQo+
IFNlbnQ6IDIwMTnE6jPUwjE1yNUgMjE6MzkNCj4gVG86IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPjsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2Vy
bmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+OyBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47DQo+
IGFybmRAYXJuZGIuZGU7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4g
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogdmFuLmZyZWVuaXhAZ21haWwuY29t
DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMS8yXSBBUk06IGlteDogZHJvcCB1bmVjY2Vzc2FyeQ0K
PiBvZl9wbGF0Zm9ybV9kZWZhdWx0X3BvcHVsYXRlDQo+IA0KPiBbLi4uXQ0KPiANCj4gPiA+IE9y
aWdpbmFsbHkgZGV2aWNlcyBhcmUgcmVnaXN0ZXJlZCBpbiBhcmNoX2luaXRjYWxsLiBOb3cgaXQg
d2lsbCBiZSBhDQo+ID4gPiBiaXQgbGF0ZXIgaW4gYXJjaF9pbml0Y2FsbF9zeW5jIGFuZCB0aGlz
IG1heSBjYXVzZSBhIGJpdCByaXNrIGlmIHRoZQ0KPiA+ID4gY29kZSB1bmRlciB0aGUgZGVmYXVs
dF9wb3B1bGF0ZSB3YW50IHRvIGFjY2VzcyB0aGUgZGV2aWNlIHNlcnZpY2UNCj4gPiA+IHByb3Zp
ZGVkDQo+ID4gYnkgZWFybHkgcHJvYmUuDQo+ID4gPg0KPiA+ID4gUHJvYmFibHkgaXQncyBtb3Jl
IHNhZmUgdG8gbGVhdmUgYXMgaXQgaXMgdW5sZXNzIHlvdSBjYW4gZG91YmxlDQo+ID4gPiBjb25m
aXJtIHRoZXJlJ3JlIG5vIHN1Y2ggY29kZSBkZXBlbmRzIG9uIGFjY2Vzc2luZyBlYXJseSBwcm9i
ZWQNCj4gPiA+IGRldmljZXMgYXMgZm9sbG93cyBiZWZvcmUgd2UgY2FuIG1ha2UgdGhlIGNoYW5n
ZS4NCj4gPg0KPiA+IFRoaXMgaGFzIGJlZW4gYm9vdCB0ZXN0ZWQgb24gNlEtU0RCLzZVTC1FVksv
NlNMLUVWSyBib2FyZC4NCj4gPiBGb3IgaS5NWCwgSSBvbmx5IHNlZSBwaW5jdHJsIGRyaXZlciB1
c2UgYXJjaF9pbml0Y2FsbCBmcm9tIHRoZSBsaW5rLA0KPiA+IGh0dHBzOi8vZWxpeGlyLmJvb3Rs
aW4uY29tL2xpbnV4L2xhdGVzdC9pZGVudC9hcmNoX2luaXRjYWxsDQo+ID4NCj4gPiBGcm9tIG15
IGJvb3QgdGVzdCwgdGhlIHBpbmN0cmwgZHJpdmVyIHByb2JlIHdpbGwgYmUgZGVsYXllZCBhIGJp
dCwgYnV0DQo+ID4gSSBkbyBub3Qgc2VlIGlzc3Vlcy4NCj4gPg0KPiANCj4gRnJvbSB3aGF0IEkg
c2F3LCBpbXg2cV8xNTg4X2luaXQoKSBhbmQgaW14NnFfYXhpX2luaXQoKSB3aWxsIHVzZSBzeXNj
b24gd2hpY2gNCj4gaXMgcmVnaXN0ZXJlZCB3aXRoIHBvc3Rjb3JlX2luaXRjYWxsLiBXaXRob3V0
IGhhdmluZyBzeXNjb24gZGV2aWNlcyBwb3B1bGF0ZWQsDQo+IEkgd29uZGVyIHRob3NlIGNhbGxz
IG1heSBmYWxsLg0KPiBDYW4geW91IGRvdWJsZSBjaGVjayBpdD8NCg0KSSBkbyBub3Qgc2VlIGZh
aWx1cmUgaW4gaW14NnFfMTU4OF9pbml0IGJ5IGFkZGluZyBhIHJldHVybiB2YWx1ZSBjaGVjayBv
Zg0KcmVnbWFwX3VwZGF0ZV9iaXRzLCBCdXQgdGhlIGlteDZxX3BtX2luaXQgd2lsbCBmaW5kIG9j
cmFtIGRldmljZSBmb3INCnN1c3BlbmQgdXNhZ2UsIHBvc3Rwb25lIHRoZSBkZXZpY2UgcG9wdWxh
dGlvbiB3aWxsIG1ha2UgaW14NnFfcG1faW5pdA0KZmFpbCwgc28gZHJvcCB0aGlzIHBhdGNoIGFu
ZCBsZWF2ZSB0aGUgY29kZSBhcyBpdCBpcy4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gUmVn
YXJkcw0KPiBEb25nIEFpc2hlbmcNCg==
