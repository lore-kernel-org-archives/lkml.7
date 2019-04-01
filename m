Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24064C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA48820880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pEl6uOBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfDAKV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:21:28 -0400
Received: from mail-eopbgr20083.outbound.protection.outlook.com ([40.107.2.83]:26415
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725868AbfDAKV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHfEIkpP9pyQzdYgV2U830jdznSimbIU9TQ+sx6cs7M=;
 b=pEl6uOBbwyuKL3pjvzpxKv2objolqvb3uNFhI6+/b3O+9L/4xNwRD7UghEDnBRUWUNEb1mfxs8dGoAkHvaAD997UNiAGYvJKDHwWJ1mqkCfyR2WDYbQiT2srYYQ6dlq8CFj7EBa9Dxs9jgBlV1SMXdW661ykHHpCKkmqwBfHk8I=
Received: from DB7PR04MB5132.eurprd04.prod.outlook.com (20.176.235.28) by
 DB7PR04MB4363.eurprd04.prod.outlook.com (52.135.131.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Mon, 1 Apr 2019 10:21:23 +0000
Received: from DB7PR04MB5132.eurprd04.prod.outlook.com
 ([fe80::2cac:cc2f:6528:54f7]) by DB7PR04MB5132.eurprd04.prod.outlook.com
 ([fe80::2cac:cc2f:6528:54f7%5]) with mapi id 15.20.1750.021; Mon, 1 Apr 2019
 10:21:23 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>
CC:     Netdev <netdev@vger.kernel.org>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        Camelia Alexandra Groza <camelia.groza@nxp.com>,
        David Miller <davem@davemloft.net>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 01/13] soc/fsl/qman: fixup liodns only on ppc targets
Thread-Topic: [PATCH 01/13] soc/fsl/qman: fixup liodns only on ppc targets
Thread-Index: AQHU5je+a7OsmojLfkyVmXpChDagwKYjJmKAgAP2VdA=
Date:   Mon, 1 Apr 2019 10:21:22 +0000
Message-ID: <DB7PR04MB5132EF28E1CAB23EBF0238B0EC550@DB7PR04MB5132.eurprd04.prod.outlook.com>
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
 <20190329140014.8126-2-laurentiu.tudor@nxp.com>
 <CADRPPNQ9AGRvq8XDjeTerUBry+_hO-U=shCXFaqHhtc9QvMvng@mail.gmail.com>
In-Reply-To: <CADRPPNQ9AGRvq8XDjeTerUBry+_hO-U=shCXFaqHhtc9QvMvng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a94f429-f109-418d-bbd9-08d6b68bca59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4363;
x-ms-traffictypediagnostic: DB7PR04MB4363:
x-microsoft-antispam-prvs: <DB7PR04MB43630954C259DB95A4820E1AEC550@DB7PR04MB4363.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(396003)(136003)(376002)(13464003)(189003)(199004)(14454004)(6636002)(106356001)(7736002)(81156014)(81166006)(8676002)(86362001)(76176011)(71190400001)(256004)(6116002)(3846002)(71200400001)(102836004)(478600001)(9686003)(99286004)(316002)(105586002)(6506007)(53546011)(54906003)(25786009)(5660300002)(305945005)(33656002)(74316002)(53936002)(52536014)(44832011)(186003)(55016002)(66066001)(97736004)(6246003)(7696005)(446003)(11346002)(476003)(6436002)(8936002)(26005)(2906002)(4326008)(6862004)(68736007)(229853002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4363;H:DB7PR04MB5132.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MwGt4rg2OHiT5gyVHf6/Akjqp5rW9pyiELo6aa3XrTmYbxPuo130Jz+uwQQgDUB1vCiEqOJAAJHNuzUXD+cIaY/vxDOmSbrVDH5ItfBXQZTrQxjAbDQA7Yu55AKjdVRc4NW8t6p9Wb+IU7v5iTMfGrZuPqMAUxlPyRP3QxrBxFnJzkZu5g3MqlTATmCZFqPjQZ2s21R05KFn48Tr8hzIczxy+ToobQaSm1O4OHZXTPJeKWl5Q1CEn9d4bHaE5775ifOxZR+3JUItjQ96yxWZB3tTEh4bLMd4ID8bfcYu1W2bRNX1EHngxvGvkfsvDdMymhvlsHSxpJs8PedoIU5auoRsv6IgNEoOzL3PCapKKT5qb10ewYSmbDqwFBYKpXPFqy/gJCfdOwxcGNQp1Xj+emSgwKqbMSprgvBOgCQFzqg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a94f429-f109-418d-bbd9-08d6b68bca59
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 10:21:23.0261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4363
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVvLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExpIFlhbmcg
W21haWx0bzpsZW95YW5nLmxpQG54cC5jb21dDQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMjksIDIw
MTkgMTE6NTAgUE0NCj4gVG86IExhdXJlbnRpdSBUdWRvciA8bGF1cmVudGl1LnR1ZG9yQG54cC5j
b20+DQo+IENjOiBOZXRkZXYgPG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+OyBNYWRhbGluLWNyaXN0
aWFuIEJ1Y3VyDQo+IDxtYWRhbGluLmJ1Y3VyQG54cC5jb20+OyBSb3kgUGxlZGdlIDxyb3kucGxl
ZGdlQG54cC5jb20+OyBDYW1lbGlhDQo+IEFsZXhhbmRyYSBHcm96YSA8Y2FtZWxpYS5ncm96YUBu
eHAuY29tPjsgRGF2aWQgTWlsbGVyDQo+IDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgTGludXggSU9N
TVUgPGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnPjsNCj4gbW9kZXJhdGVkIGxpc3Q6
QVJNL0ZSRUVTQ0FMRSBJTVggLyBNWEMgQVJNIEFSQ0hJVEVDVFVSRSA8bGludXgtYXJtLQ0KPiBr
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IGxpbnV4cHBjLWRldiA8bGludXhwcGMtZGV2QGxp
c3RzLm96bGFicy5vcmc+Ow0KPiBsa21sIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIDAxLzEzXSBzb2MvZnNsL3FtYW46IGZpeHVwIGxpb2RucyBv
bmx5IG9uIHBwYyB0YXJnZXRzDQo+IEltcG9ydGFuY2U6IEhpZ2gNCj4gDQo+IE9uIEZyaSwgTWFy
IDI5LCAyMDE5IGF0IDk6MDEgQU0gPGxhdXJlbnRpdS50dWRvckBueHAuY29tPiB3cm90ZToNCj4g
Pg0KPiA+IEZyb206IExhdXJlbnRpdSBUdWRvciA8bGF1cmVudGl1LnR1ZG9yQG54cC5jb20+DQo+
ID4NCj4gPiBBUk0gU29DcyB1c2UgU01NVSBzbyB0aGUgbGlvZG4gZml4dXAgZG9uZSBpbiB0aGUg
cW1hbiBkcml2ZXIgaXMgbm8NCj4gPiBsb25nZXIgbWFraW5nIHNlbnNlIGFuZCBpdCBhbHNvIGJy
ZWFrcyB0aGUgSUNJRCBzZXR0aW5ncyBpbmhlcml0ZWQNCj4gPiBmcm9tIHUtYm9vdC4gRG8gdGhl
IGZpeHVwcyBvbmx5IGZvciBQUEMgdGFyZ2V0cy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExh
dXJlbnRpdSBUdWRvciA8bGF1cmVudGl1LnR1ZG9yQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvc29jL2ZzbC9xYm1hbi9xbWFuX2Njc3IuYyB8IDIgKysNCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2Zz
bC9xYm1hbi9xbWFuX2Njc3IuYw0KPiBiL2RyaXZlcnMvc29jL2ZzbC9xYm1hbi9xbWFuX2Njc3Iu
Yw0KPiA+IGluZGV4IDEwOWIzOGRlMzE3Ni4uMTJlNDE0Y2EzYjAzIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvc29jL2ZzbC9xYm1hbi9xbWFuX2Njc3IuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29j
L2ZzbC9xYm1hbi9xbWFuX2Njc3IuYw0KPiA+IEBAIC01OTgsNiArNTk4LDcgQEAgc3RhdGljIGlu
dCBxbWFuX2luaXRfY2NzcihzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gICNkZWZpbmUgTElPX0NG
R19MSU9ETl9NQVNLIDB4MGZmZjAwMDANCj4gPiAgdm9pZCBxbWFuX2xpb2RuX2ZpeHVwKHUxNiBj
aGFubmVsKQ0KPiA+ICB7DQo+ID4gKyNpZmRlZiBDT05GSUdfUFBDDQo+ID4gICAgICAgICBzdGF0
aWMgaW50IGRvbmU7DQo+ID4gICAgICAgICBzdGF0aWMgdTMyIGxpb2RuX29mZnNldDsNCj4gPiAg
ICAgICAgIHUzMiBiZWZvcmUsIGFmdGVyOw0KPiA+IEBAIC02MTcsNiArNjE4LDcgQEAgdm9pZCBx
bWFuX2xpb2RuX2ZpeHVwKHUxNiBjaGFubmVsKQ0KPiA+ICAgICAgICAgICAgICAgICBxbV9jY3Ny
X291dChSRUdfUkVWM19RQ1NQX0xJT19DRkcoaWR4KSwgYWZ0ZXIpOw0KPiA+ICAgICAgICAgZWxz
ZQ0KPiA+ICAgICAgICAgICAgICAgICBxbV9jY3NyX291dChSRUdfUUNTUF9MSU9fQ0ZHKGlkeCks
IGFmdGVyKTsNCj4gPiArI2VuZGlmDQo+IA0KPiBBY2NvcmRpbmcgdG8gdGhlIExpbnV4IGNvZGlu
ZyBzdHlsZSByZWNvbW1lbmRhdGlvbiwgaXQgd291bGQgYmUgYmV0dGVyDQo+IHRvIHB1dCB0aGUg
I2lmZGVmIGludG8gdGhlIGhlYWRlciBmaWxlcw0KPiAiZHJpdmVycy9zb2MvZnNsL3FibWFuL3Ft
YW5fcHJpdi5oIi4gIEFuZCBJJ20gbm90IHN1cmUgaWYgdGhpcyBpcw0KPiBuZWVkZWQgb24gUFBD
IHdoZW4gSU9NTVUoUEFNVSkgZHJpdmVyIGlzIG5vdCBjb21waWxlZCwgaWYgbm90LA0KPiBwcm9i
YWJseSB1c2luZyBDT05GSUdfUEFNVSBhcyBjb25kaXRpb24gd291bGQgYmUgZXZlbiBiZXR0ZXIu
DQoNCkdvb2QgcG9pbnQsIHdpbGwgc28gaW4gdGhlIG5leHQgc3Bpbi4NCg0KLS0tDQpCZXN0IFJl
Z2FyZHMsIExhdXJlbnRpdQ0KDQo+ID4gIH0NCj4gPg0KPiA+ICAjZGVmaW5lIElPX0NGR19TREVT
VF9NQVNLIDB4MDBmZjAwMDANCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+DQo=
