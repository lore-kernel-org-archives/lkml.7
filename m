Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834F1C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8282196F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="lpplQUI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391584AbfISQHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 12:07:21 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:36303 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391567AbfISQHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 12:07:20 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: A5zdj9bnStJv6G5plUwnE1/q7yt88CWVYvJfwPqtfafBbW4H+knJ9hJwdMdPGlZx5X4AYaMkYC
 MYU9jY2SoocTOcNdJlVJxWgUPL33UUcG8gs5BaHuw9XQU4PpMe/ZQt3i72hekKHk2aV6CzEZ/X
 sz7y6WBUpNswhKVa/Dy056KGwdbV+OdnUXleWkJSLk3yyBvUmbB4K3kakp/0FKSqtLiwU11I9I
 6GYCR3D0WhHyWfVO7FxrU+u16+i0vtPEmRh+1u2VNqP+ZPuOJbBOr0Jn4JoAMJ7kFCFtOUeap0
 7xw=
X-IronPort-AV: E=Sophos;i="5.64,524,1559545200"; 
   d="scan'208";a="49763308"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Sep 2019 09:07:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Sep 2019 09:07:17 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 19 Sep 2019 09:07:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVYXFhtE3GHXT1HIht+7WKIUU0NSyKmbNN3q1uLZbmNGJ3DgskVULpDGv3P4NDk/ltp6Qsbzn7Yqit0osUnlXUiBcWbEv2D2YIUcBJYg2SESWfbakKPm5PqBkH1uWjrmiOt9BcFKVNeAb6woWwrgXx/qOqRaOUCXgT/j5CNRyddRiRdywCcbP/ofCMa5/AS3AjpAWxd1G4ST9jBe12lHCsYKwR5JWeWEe9Gja1fJBjs6fBP6Wkv6twubxAAq2oOU1TrxuD9MDsws3hYNOjD1sk+GfK5uDL3fBtDl0nf/0jtLa1YnhTb0NQDy9NlDt+3GvVKEdG3PYg8vOBLYevNFsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6rTOV3oI4O8UoBzes02kYPYcAGHCN9su6uBFF8j7Jc=;
 b=ha8Y+lgTi5E5gYYn60wsZsD+vy3gGsDDWmecjeS1qA/IPyINymQNvCB4KF0XaliNLZbmd3bFxKgLT6aPz8J9HFsYOvKQqwP3gk9qNqC0sH4Yk+/DV9LM2gHFHKZp9UORtiHsikeVIjyP24pL9ayXvzF05QUYAYQiRB98yFQrHSEuX68M30dl3cdLUGbb6e5voY1/mwYZV+Weze9o3LlUFUj1BPZVk0hKBvMu15QQdFCQWMq5Am7pJ8Jf00H3SK+SPRYga2+seTh6kZ/SIhwMPRGKlWbeG7CFw9tDwxcd7yOFmq9e6VixGiL7i4n3quHARf9g6PUIU83acLC3Wzn6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6rTOV3oI4O8UoBzes02kYPYcAGHCN9su6uBFF8j7Jc=;
 b=lpplQUI0mrTGiyPYMzgziWthROF3h3pwcBv+K1s13gZCMdgNRAEcWNfRQszpawgsbzldjaE6cM1D6UsWRQomHdMaHqWgWPDleXTr99CVh+ZR0qlMk6G2ZN9KPJp7vdUkJW2o903z0OLLpchhLgf/9BxFF/QMafEQnikGrTEzLmk=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3839.namprd11.prod.outlook.com (20.178.254.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.21; Thu, 19 Sep 2019 16:07:16 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2263.023; Thu, 19 Sep 2019
 16:07:16 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>
CC:     <linux-aspeed@lists.ozlabs.org>, <andrew@aj.id.au>,
        <linux-kernel@vger.kernel.org>, <vz@mleia.com>,
        <linux-mediatek@lists.infradead.org>, <joel@jms.id.au>,
        <matthias.bgg@gmail.com>, <computersforpeace@gmail.com>,
        <dwmw2@infradead.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 00/23] mtd: spi-nor: Quad Enable and (un)lock methods
Thread-Topic: [PATCH 00/23] mtd: spi-nor: Quad Enable and (un)lock methods
Thread-Index: AQHVbXA3ZsB/BVyqVUKkLPfzQhFGC6czFKwAgAAY8wA=
Date:   Thu, 19 Sep 2019 16:07:15 +0000
Message-ID: <041440d2-1f10-4ab3-ec36-53bd23aed739@microchip.com>
References: <20190917155426.7432-1-tudor.ambarus@microchip.com>
 <920a9946-af0d-1190-d59c-0b4acee71931@ti.com>
In-Reply-To: <920a9946-af0d-1190-d59c-0b4acee71931@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR02CA0065.eurprd02.prod.outlook.com
 (2603:10a6:802:14::36) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.240.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ea901e3-9d6e-4536-5d2f-08d73d1b7086
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3839;
x-ms-traffictypediagnostic: MN2PR11MB3839:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR11MB3839A6F6DED5D9B6B0DF6A5AF0890@MN2PR11MB3839.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(396003)(376002)(199004)(189003)(6116002)(3846002)(2906002)(14454004)(31686004)(99286004)(7736002)(305945005)(478600001)(66066001)(36756003)(52116002)(26005)(76176011)(25786009)(102836004)(7416002)(966005)(66946007)(186003)(6506007)(53546011)(386003)(316002)(66476007)(110136005)(64756008)(6246003)(66556008)(2501003)(54906003)(66446008)(2616005)(486006)(8676002)(446003)(11346002)(476003)(4326008)(31696002)(6512007)(14444005)(256004)(6436002)(6306002)(6486002)(71190400001)(71200400001)(8936002)(86362001)(81156014)(81166006)(5660300002)(229853002)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3839;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Dp9NsT+ErjleBIijYmcF/S1B7QV13c8zY3z2bHhCFr0LXhPSMDU0ThVQa7cbaRWLZ+ZqmIQAhOVDz6vGir3yETHhiKiXDsLxoLP0QZMZlvs03LEJrCCiS0wjUSUItQTQqPjVepicNP/teu0xGxD0hQoIBP7vuOTrZhPLZY0F1MX3j7aVo8zIWLurBBZVbvWIp1ukz+Ym17hv9cfwywgJG6N1eRNRxVCHopc8JzW8OOXJMwhQYYiTX4FcT55i3oDrcjMSkB++wbwpM0npvP6XuJGUGP0SLkpT/3+G/fWDIOLqZRmsKZXi0F1ZgqeKnVSWnq/a/8km2jUWlTsPmyz8yjCzlNWnnA068VAhC7v7QKVU/mFjjdEAAZIb7y9JYIcAsQa1yjZ6lXGqnpdZp2oBQ2Dnufixhu+JPkh0Uf+9ni4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <50F76EBD626F514E9CCA7D8FE5358417@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea901e3-9d6e-4536-5d2f-08d73d1b7086
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 16:07:15.9948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hIN/pTAYR6UVCWe6cJzGU/B2gDAJUVL7o2Xe7B86hdyDNa/Ir8qvdQpnpf9APPfUkSaegsUld+dIaUWxQGU5AySa24OqEfGFGrfeE2XVVQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA5LzE5LzIwMTkgMDU6MzcgUE0sIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+
IEV4dGVybmFsIEUtTWFpbA0KPiANCj4gDQo+IEhpLA0KDQpIaSwgdGhhbmtzIGZvciByZXZpZXdp
bmchDQoNCj4gDQo+IE9uIDE3LVNlcC0xOSA5OjI0IFBNLCBUdWRvci5BbWJhcnVzQG1pY3JvY2hp
cC5jb20gd3JvdGU6DQo+PiBGcm9tOiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3Jv
Y2hpcC5jb20+DQo+Pg0KPiBbLi4uXQ0KPj4gVHVkb3IgQW1iYXJ1cyAoMjMpOg0KPj4gICBtdGQ6
IHNwaS1ub3I6IGhpc2ktc2ZjOiBEcm9wIG5vci0+ZXJhc2UgTlVMTCBhc3NpZ25tZW50DQo+PiAg
IG10ZDogc3BpLW5vcjogSW50cm9kdWNlICdzdHJ1Y3Qgc3BpX25vcl9jb250cm9sbGVyX29wcycN
Cj4+ICAgbXRkOiBzcGktbm9yOiBjYWRlbmNlLXF1YWRzcGk6IEZpeCBjcXNwaV9jb21tYW5kX3Jl
YWQoKSBkZWZpbml0aW9uDQo+PiAgIG10ZDogc3BpLW5vcjogUmVuYW1lIG5vci0+cGFyYW1zIHRv
IG5vci0+Zmxhc2gNCj4+ICAgbXRkOiBzcGktbm9yOiBSZXdvcmsgcmVhZF9zcigpDQo+PiAgIG10
ZDogc3BpLW5vcjogUmV3b3JrIHJlYWRfZnNyKCkNCj4+ICAgbXRkOiBzcGktbm9yOiBSZXdvcmsg
cmVhZF9jcigpDQo+PiAgIG10ZDogc3BpLW5vcjogUmV3b3JrIHdyaXRlX2VuYWJsZS9kaXNhYmxl
KCkNCj4+ICAgbXRkOiBzcGktbm9yOiBGaXggcmV0bGVuIGhhbmRsaW5nIGluIHNzdF93cml0ZSgp
DQo+PiAgIG10ZDogc3BpLW5vcjogUmV3b3JrIHdyaXRlX3NyKCkNCj4+ICAgbXRkOiBzcGktbm9y
OiBSZXdvcmsgc3BpX25vcl9yZWFkL3dyaXRlX3NyMigpDQo+PiAgIG10ZDogc3BpLW5vcjogUmVw
b3J0IGVycm9yIGluIHNwaV9ub3JfeHJlYWRfc3IoKQ0KPj4gICBtdGQ6IHNwaS1ub3I6IFZvaWQg
cmV0dXJuIHR5cGUgZm9yIHNwaV9ub3JfY2xlYXJfc3IvZnNyKCkNCj4+ICAgbXRkOiBzcGktbm9y
OiBEcm9wIGR1cGxpY2F0ZWQgbmV3IGxpbmUNCj4+ICAgbXRkOiBzcGktbm9yOiBEcm9wIHNwYW5z
aW9uX3F1YWRfZW5hYmxlKCkNCj4+ICAgbXRkOiBzcGktbm9yOiBGaXggZXJybm8gb24gcXVhZF9l
bmFibGUgbWV0aG9kcw0KPj4gICBtdGQ6IHNwaS1ub3I6IEZpeCBjbGVhcmluZyBvZiBRRSBiaXQg
b24gbG9jaygpL3VubG9jaygpDQo+PiAgIG10ZDogc3BpLW5vcjogUmV3b3JrIG1hY3Jvbml4X3F1
YWRfZW5hYmxlKCkNCj4+ICAgbXRkOiBzcGktbm9yOiBSZXdvcmsgc3BhbnNpb24oX25vKV9yZWFk
X2NyX3F1YWRfZW5hYmxlKCkNCj4+ICAgbXRkOiBzcGktbm9yOiBVcGRhdGUgc3IyX2JpdDdfcXVh
ZF9lbmFibGUoKQ0KPj4gICBtdGQ6IHNwaS1ub3I6IFJld29yayB0aGUgZGlzYWJsaW5nIG9mIGJs
b2NrIHdyaXRlIHByb3RlY3Rpb24NCj4+ICAgbXRkOiBzcGktbm9yOiBBZGQgR2xvYmFsIEJsb2Nr
IFVubG9jayBzdXBwb3J0DQo+PiAgIG10ZDogc3BpLW5vcjogVW5sb2NrIGdsb2JhbCBibG9jayBw
cm90ZWN0aW9uIG9uIHNzdDI2dmYwNjRiDQo+IA0KPiBXaXRoIHdob2xlIHNlcmllcyBhcHBsaWVk
LCBJIHNlZToNCj4gDQo+IGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jOjUyMDogd2Fybmlu
ZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnY3InIG5vdCBkZXNjcmliZWQgaW4gJ3Nw
aV9ub3JfcmVhZF9jcicNCj4gZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmM6NTIwOiB3YXJu
aW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1ldGVyICdmc3InIGRlc2NyaXB0aW9uIGluICdzcGlf
bm9yX3JlYWRfY3InDQo+IGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jOjc0Mjogd2Fybmlu
ZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnbGVuJyBub3QgZGVzY3JpYmVkIGluICdz
cGlfbm9yX3dyaXRlX3NyJw0KPiBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYzo4ODk6IHdh
cm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ3N0YXR1c19uZXcnIG5vdCBkZXNj
cmliZWQgaW4gJ3NwaV9ub3Jfd3JpdGVfc3IxX2FuZF9jaGVjaycNCj4gZHJpdmVycy9tdGQvc3Bp
LW5vci9zcGktbm9yLmM6ODg5OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVy
ICdtYXNrJyBub3QgZGVzY3JpYmVkIGluICdzcGlfbm9yX3dyaXRlX3NyMV9hbmRfY2hlY2snDQo+
IGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jOjkyMzogd2FybmluZzogRnVuY3Rpb24gcGFy
YW1ldGVyIG9yIG1lbWJlciAnc3RhdHVzX25ldycgbm90IGRlc2NyaWJlZCBpbiAnc3BpX25vcl93
cml0ZV8xNmJpdF9zcl9hbmRfY2hlY2snDQo+IGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5j
OjkyMzogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnbWFzaycgbm90IGRl
c2NyaWJlZCBpbiAnc3BpX25vcl93cml0ZV8xNmJpdF9zcl9hbmRfY2hlY2snDQo+IGRyaXZlcnMv
bXRkL3NwaS1ub3Ivc3BpLW5vci5jOjk5Nzogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9y
IG1lbWJlciAnc3RhdHVzX25ldycgbm90IGRlc2NyaWJlZCBpbiAnc3BpX25vcl93cml0ZV9zcl9h
bmRfY2hlY2snDQo+IGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jOjk5Nzogd2FybmluZzog
RnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnbWFzaycgbm90IGRlc2NyaWJlZCBpbiAnc3Bp
X25vcl93cml0ZV9zcl9hbmRfY2hlY2snDQo+IA0KPiBDb3VsZCB5b3UgcGxlYXNlIGZpeCB1cCBk
b2NzIG5leHQgdGltZSBhcm91bmQ/DQoNCkknbGwgZml4IHRoZXNlLCB0aGFua3MhDQoNCkkndmUg
anVzdCBjb21waWxlZCB0aGUgY29kZSBhbmQgSSBjYW4ndCBzZWUgdGhlIHdhcm5pbmdzLiBXaGF0
IHNob3VsZCBJIGRvIHRvDQpnZXQgdGhlc2Ugd2FybmluZ3M/DQoNClRoYW5rcywNCnRhDQoNCj4g
DQo+IFJlZ2FyZHMNCj4gVmlnbmVzaA0KPj4NCj4+ICBkcml2ZXJzL210ZC9zcGktbm9yL2FzcGVl
ZC1zbWMuYyAgICAgIHwgICAyMyArLQ0KPj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY2FkZW5jZS1x
dWFkc3BpLmMgfCAgIDU0ICstDQo+PiAgZHJpdmVycy9tdGQvc3BpLW5vci9oaXNpLXNmYy5jICAg
ICAgICB8ICAgMjMgKy0NCj4+ICBkcml2ZXJzL210ZC9zcGktbm9yL2ludGVsLXNwaS5jICAgICAg
IHwgICAyNCArLQ0KPj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvbXRrLXF1YWRzcGkuYyAgICAgfCAg
IDI1ICstDQo+PiAgZHJpdmVycy9tdGQvc3BpLW5vci9ueHAtc3BpZmkuYyAgICAgICB8ICAgMjMg
Ky0NCj4+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyAgICAgICAgIHwgMTY5NyArKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4+ICBpbmNsdWRlL2xpbnV4L210ZC9zcGkt
bm9yLmggICAgICAgICAgIHwgICA3NSArLQ0KPj4gIDggZmlsZXMgY2hhbmdlZCwgMTA1MCBpbnNl
cnRpb25zKCspLCA4OTQgZGVsZXRpb25zKC0pDQo+Pg0KPiANCj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IExpbnV4IE1URCBkaXNjdXNz
aW9uIG1haWxpbmcgbGlzdA0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW10ZC8NCj4gDQo+IA0K
