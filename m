Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02470C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8C7217D9
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ntpfG7gv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfHGBuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 21:50:44 -0400
Received: from mail-eopbgr130052.outbound.protection.outlook.com ([40.107.13.52]:54399
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728601AbfHGBuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 21:50:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcVk5fmLtSD9t0j1tWpUqM3cu1IO4pXmmRP7NfNdRaioFJ77izcPmvo2EithgHUUpN6C3X+YUzgdqZmGNiqXsRU/qiCrU9wM9Rw+ynUHVRuJJM0VIEtmPLE7x5iyOBZiuIBgbWE0rkWUYQiJZQalTyaZ5QTPHhgme30odZ6igjtxiZpVEXqp7V3fHi2/2NhFhBUOsscZq5OdzNnFvBBavL9MNARhX1JekWsfQvBCxXrNw06KWqpBhdUUJpL2I0wILtjtmRzGfQYGOZQtowsMIov7fPl5sPqND5lV8DJkup3C2PLwYwPt0y0ezdUgZ4b3jh5GCY2ZNmtD74YDBwaO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDOihdqEgCzHCLukQuB6lKGR46ShL3XZknhM0ULksjE=;
 b=aijqQQc8w8tkYgpmpc4U+yxlSs00VVFp7itFUVzLrnrK3ZjmcYIqTV+PWVoZQsZgoHQNmXvsXE5OIm64tN/LYG87oAfafxNtQ1sZDeZJy6RSSnky4RUNzQMiOa3XMrNs9iP6o6j+w4jcJOZ+Rq6glBHCm9i4hBJSXp3CDk8Z1pKY+LcrHWsc7VmU0MDDeM+Z3TNgVf0OcPOgYu9Y7YLOroZC+sHYM8F1CH8m6paWQGo8k8pYmqOgleOg6MwobDSoaQzGML271D3c1TPE/Odrr0AWkCpNt3YqPYxoF6ylYpxG75PtaOUNf108CFlsNTPt7CBfDZ2XZy1o3rIxXM6Ufw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDOihdqEgCzHCLukQuB6lKGR46ShL3XZknhM0ULksjE=;
 b=ntpfG7gvbtUYjSVybqwduBInzMAk0ipTS6fMfuwFP8LtQL4psFC8hEfG0TF0x1v4qJsWTQkQdNlMD1luvfKSkTML/zLaoAp6tB2SUpXHEMY2drE5z03s4INVNy6fijnppqnyQ7rPD/V4oNxh34cH/3ByCqZOwCganTS10/5qLuc=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB3807.eurprd04.prod.outlook.com (52.134.16.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Wed, 7 Aug 2019 01:50:39 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::8026:902c:16d9:699d]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::8026:902c:16d9:699d%7]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 01:50:39 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH nvmem 1/1] nvmem: imx: add i.MX8QM platform
 support
Thread-Topic: [EXT] Re: [PATCH nvmem 1/1] nvmem: imx: add i.MX8QM platform
 support
Thread-Index: AQHVMnTq2F+gGEqIWEi9imTz4TJ3wKbuF3yAgAEBoAA=
Date:   Wed, 7 Aug 2019 01:50:39 +0000
Message-ID: <VI1PR0402MB3600B31267E45EE4EA21FE24FFD40@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20190704142032.10745-1-fugang.duan@nxp.com>
 <65afeaaf-f703-02f2-a918-90a8bb8f58b6@linaro.org>
In-Reply-To: <65afeaaf-f703-02f2-a918-90a8bb8f58b6@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb95cc65-d078-4389-ba38-08d71ad9a648
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3807;
x-ms-traffictypediagnostic: VI1PR0402MB3807:
x-microsoft-antispam-prvs: <VI1PR0402MB380701633FB059019FEA3672FFD40@VI1PR0402MB3807.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(189003)(199004)(6506007)(26005)(6116002)(76176011)(3846002)(7696005)(71200400001)(68736007)(316002)(6436002)(55016002)(53546011)(9686003)(102836004)(71190400001)(256004)(2501003)(52536014)(7736002)(76116006)(66946007)(305945005)(66556008)(66476007)(66446008)(64756008)(8676002)(25786009)(14454004)(8936002)(4326008)(81166006)(81156014)(5660300002)(86362001)(486006)(53936002)(99286004)(11346002)(476003)(446003)(74316002)(2201001)(186003)(229853002)(54906003)(66066001)(6246003)(478600001)(2906002)(110136005)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3807;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HbAkkZME74gcITpd+cMupuSWMrMrKKyYe515dAlAQyT3niPj8xCOO/m7qPUXPTMZDori4H/mW5Q+bdl5kkvh5snKlng6VVYLXjZXR38zZ0et3kn34vm2+M3so8DD3pr5eDDd0ZSUg4vG1M4tNccXYfhEmRbL7c+4v3R4rrvBg4G8URL0cmfcuABUH7E6ZGaYghk+mci7V+Bz5T/gkHIi55RVLq4jjIIKx3K+8fRSkHrTHHICm5RZuNIxV/RbFhRDajcV3R/9LynkAEr7j+/377vSVkyAfWx0a8P9mCJfPosetOPmhM0WvThDCCzhtzWG4IU3MqQhOKvefLQjzibee0S+dl62UUMYl5peJ5lQ7WyXY8H/mmNgBC3MIo79Sbh6AgF4sQnHKt+jBeoBHZ0sYBMO1N3nFHEfIuKNC3ko+vw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb95cc65-d078-4389-ba38-08d71ad9a648
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 01:50:39.5204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fugang.duan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3807
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3Jpbml2YXMgS2FuZGFnYXRsYSA8c3Jpbml2YXMua2FuZGFnYXRsYUBsaW5hcm8ub3Jn
PiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgNiwgMjAxOSA2OjA0IFBNDQo+IE9uIDA0LzA3LzIwMTkg
MTU6MjAsIGZ1Z2FuZy5kdWFuQG54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogRnVnYW5nIER1YW4g
PGZ1Z2FuZy5kdWFuQG54cC5jb20+DQo+ID4NCj4gPiBpLk1YOFFNIGVmdXNlIHRhYmxlIGhhcyBz
b21lIGRpZmZlcmVuY2Ugd2l0aCBpLk1YOFFYUCBwbGF0Zm9ybSwgc28gYWRkDQo+ID4gaS5NWDhR
TSBwbGF0Zm9ybSBzdXBwb3J0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRnVnYW5nIER1YW4g
PGZ1Z2FuZy5kdWFuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL252bWVtL2lteC1v
Y290cC1zY3UuYyB8IDcgKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZW0vaW14LW9jb3RwLXNjdS5j
DQo+ID4gYi9kcml2ZXJzL252bWVtL2lteC1vY290cC1zY3UuYyBpbmRleCBiZTJmNWYwLi4wZDc4
YWI0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbnZtZW0vaW14LW9jb3RwLXNjdS5jDQo+ID4g
KysrIGIvZHJpdmVycy9udm1lbS9pbXgtb2NvdHAtc2N1LmMNCj4gPiBAQCAtMTYsNiArMTYsNyBA
QA0KPiA+DQo+ID4gICBlbnVtIG9jb3RwX2RldnR5cGUgew0KPiA+ICAgICAgIElNWDhRWFAsDQo+
ID4gKyAgICAgSU1YOFFNLA0KPiA+ICAgfTsNCj4gPg0KPiA+ICAgc3RydWN0IG9jb3RwX2RldnR5
cGVfZGF0YSB7DQo+ID4gQEAgLTM5LDYgKzQwLDExIEBAIHN0YXRpYyBzdHJ1Y3Qgb2NvdHBfZGV2
dHlwZV9kYXRhIGlteDhxeHBfZGF0YSA9IHsNCj4gPiAgICAgICAubnJlZ3MgPSA4MDAsDQo+ID4g
ICB9Ow0KPiA+DQo+ID4gK3N0YXRpYyBzdHJ1Y3Qgb2NvdHBfZGV2dHlwZV9kYXRhIGlteDhxbV9k
YXRhID0gew0KPiA+ICsgICAgIC5kZXZ0eXBlID0gSU1YOFFNLA0KPiA+ICsgICAgIC5ucmVncyA9
IDgwMCwNCj4gPiArfTsNCj4gPiArDQo+ID4gICBzdGF0aWMgaW50IGlteF9zY19taXNjX290cF9m
dXNlX3JlYWQoc3RydWN0IGlteF9zY19pcGMgKmlwYywgdTMyIHdvcmQsDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1MzIgKnZhbCkNCj4gPiAgIHsNCj4gPiBAQCAtMTE4
LDYgKzEyNCw3IEBAIHN0YXRpYyBzdHJ1Y3QgbnZtZW1fY29uZmlnDQo+ID4gaW14X3NjdV9vY290
cF9udm1lbV9jb25maWcgPSB7DQo+ID4NCj4gPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2
aWNlX2lkIGlteF9zY3Vfb2NvdHBfZHRfaWRzW10gPSB7DQo+ID4gICAgICAgeyAuY29tcGF0aWJs
ZSA9ICJmc2wsaW14OHF4cC1zY3Utb2NvdHAiLCAodm9pZCAqKSZpbXg4cXhwX2RhdGENCj4gPiB9
LA0KPiA+ICsgICAgIHsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDhxbS1zY3Utb2NvdHAiLCAodm9p
ZCAqKSZpbXg4cW1fZGF0YSB9LA0KPiA+ICAgICAgIHsgfSwNCj4gDQo+IExvb2tzIGxpa2UgeW91
IGZvcmdvdCB0byBhZGQgdGhpcyBuZXcgY29tcGF0aWJsZSB0byBkZXZpY2UgdHJlZSBiaW5kaW5n
cw0KPiBhdCAuL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9udm1lbS9pbXgtb2Nv
dHAudHh0IG9yIGZvcmdvdCB0bw0KPiBhZGQgbWUgdG8gQ0MuDQo+IA0KPiBQbGVhc2UgcmVzZW5k
IHRoZSBwYXRjaCB3aXRoIGl0LCBJIGNhbiBub3QgYXBwbHkgdGhpcyBhcyBpdCBpcy4NCj4gDQo+
IFRoYW5rcywNCj4gc3JpbmkNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCkkgd2lsbCBzZW5k
IHRoZSBWMiB2ZXJzaW9uIGluY2x1ZGluZyB0aGUgc2VwYXJhdGVkIGRldmljZSB0cmVlIGJpbmRp
bmdzIHBhdGNoLg0KDQo+IA0KPiA+ICAgfTsNCj4gPiAgIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2Ys
IGlteF9zY3Vfb2NvdHBfZHRfaWRzKTsNCj4gPg0K
