Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F774C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BE42081C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P9CRLOfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfEULIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 07:08:18 -0400
Received: from mail-eopbgr140057.outbound.protection.outlook.com ([40.107.14.57]:45219
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726042AbfEULIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 07:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pE2EU3lgODu82kcoAcc0br0fi3b8mMOu/pFJv/daZAM=;
 b=P9CRLOfaf/9D20p7GTkPHyG1erR619Au5zZG0si8QGTJxObJ2N/Ym7tbvhhGc5GQHwjMwGj1YsTE14Co6vIlpjxj/wg3kRkvADPRvn5fo10uzZqzc8tBkomCTSoe84lpGIVQFcFgS4OwE4TxgppfGRdKHos67ltCxRoFRtIgJV0=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB4477.eurprd04.prod.outlook.com (20.177.53.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Tue, 21 May 2019 11:08:14 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40%7]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 11:08:14 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>, Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "noring@nocrew.org" <noring@nocrew.org>,
        "JuergenUrban@gmx.de" <JuergenUrban@gmx.de>
Subject: Re: [PATCH v4 2/3] usb: host: ohci-sm501: init genalloc for local
 memory
Thread-Topic: [PATCH v4 2/3] usb: host: ohci-sm501: init genalloc for local
 memory
Thread-Index: AQHVC918CMHW2f+9DkGhkpqP1i9ONKZ1a1IAgAAH6YA=
Date:   Tue, 21 May 2019 11:08:14 +0000
Message-ID: <dac48dcd-c676-4161-e38b-11bbcf8d2a8f@nxp.com>
References: <20190516114721.27694-1-laurentiu.tudor@nxp.com>
 <20190516114721.27694-3-laurentiu.tudor@nxp.com>
 <20190521103954.GC1973@lst.de>
In-Reply-To: <20190521103954.GC1973@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18f38b4d-b2e4-49a9-76d3-08d6dddc9e88
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4477;
x-ms-traffictypediagnostic: VI1PR04MB4477:
x-microsoft-antispam-prvs: <VI1PR04MB4477D45F5808669A8E728A28EC070@VI1PR04MB4477.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(39860400002)(136003)(54094003)(189003)(199004)(446003)(6116002)(11346002)(86362001)(2616005)(476003)(53936002)(7736002)(305945005)(44832011)(3846002)(6916009)(186003)(486006)(91956017)(76116006)(8676002)(102836004)(14444005)(256004)(8936002)(36756003)(26005)(73956011)(66446008)(64756008)(66946007)(4326008)(81166006)(81156014)(5660300002)(2906002)(76176011)(66066001)(25786009)(99286004)(6246003)(31696002)(54906003)(6506007)(53546011)(316002)(66476007)(31686004)(478600001)(229853002)(14454004)(71200400001)(68736007)(6486002)(6436002)(66556008)(71190400001)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4477;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JaC15F4tI7aYwMjn1swp8JKmgFta/PuV2fePErmKzoRoV7gkNV7noJVtHbV9c/1AGH6bj9yE/YooeGRMjIGgU3xZx9u4AKjbT7tYdFwMWie2cmSdQ5L2r7vJ4bh2FpxUcQWnCi4IZeyf8ufqkzr6rJwxP9GjRmVvfVfmeZc84ImkIvr5zXwDEtBn+CDi7TOCDnw+nYMCMCac/cnpv/0/+DkZO7xJLJb0A9rqyFnUNVbT9JdUrAS+t8tov9pwsjGfgE6zdC7Hq60JMi1Ca2YbIvd+NcLj6WKP7yLzCpR45WamYAC+u6Tv6SaffQnoaEz9ecAyPe8kjCVeokSFMHVa0qJChjq0sN/vPlJ0MmpFa8vKGI5CDB9wWTo0ZuTRdun7c/GVylXkEdLATm4AhJVQsiu8I9w+Ob+uxJtLuM3tplM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <424B790242CB6D4F8A25AD6DA5878354@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f38b4d-b2e4-49a9-76d3-08d6dddc9e88
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 11:08:14.0291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4477
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIxLjA1LjIwMTkgMTM6MzksIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBU
aHUsIE1heSAxNiwgMjAxOSBhdCAwMjo0NzoyMFBNICswMzAwLCBsYXVyZW50aXUudHVkb3JAbnhw
LmNvbSB3cm90ZToNCj4+ICsJaGNkLT5sb2NhbG1lbV9wb29sID0gZGV2bV9nZW5fcG9vbF9jcmVh
dGUoZGV2LCBQQUdFX1NISUZULA0KPj4gKwkJCQkJCSAgZGV2X3RvX25vZGUoZGV2KSwNCj4+ICsJ
CQkJCQkgICJvaGNpLXNtNTAxIik7DQo+PiArCWlmIChJU19FUlIoaGNkLT5sb2NhbG1lbV9wb29s
KSkgew0KPj4gKwkJcmV0dmFsID0gUFRSX0VSUihoY2QtPmxvY2FsbWVtX3Bvb2wpOw0KPj4gKwkJ
Z290byBlcnI1Ow0KPj4gKwl9DQo+PiArDQo+PiArCWxvY2FsX21lbSA9IGRldm1faW9yZW1hcChk
ZXYsIG1lbS0+c3RhcnQsIHJlc291cmNlX3NpemUobWVtKSk7DQo+PiArCWlmICghbG9jYWxfbWVt
KSB7DQo+PiArCQlyZXR2YWwgPSAtRU5PTUVNOw0KPj4gKwkJZ290byBlcnI1Ow0KPj4gKwl9DQo+
PiArDQo+PiArCXJldHZhbCA9IGdlbl9wb29sX2FkZF92aXJ0KGhjZC0+bG9jYWxtZW1fcG9vbCwN
Cj4+ICsJCQkJICAgKHVuc2lnbmVkIGxvbmcpbG9jYWxfbWVtLA0KPj4gKwkJCQkgICBtZW0tPnN0
YXJ0IC0gbWVtLT5wYXJlbnQtPnN0YXJ0LA0KPj4gKwkJCQkgICByZXNvdXJjZV9zaXplKG1lbSks
DQo+PiArCQkJCSAgIGRldl90b19ub2RlKGRldikpOw0KPiANCj4gSSB3b25kZXIgaWYgaGF2aW5n
IGEgaGVscGVyIGZvciB0aGVzZSBvcGVyYXRpb25zIHdvdWxkIGJlIHVzZWZ1bCwNCj4gZXhwbGFp
bmluZyB3aGF0IHdlIGRvIGhlcmUuICBUaGF0IGlzIGNyZWF0ZSBhIHBvb2wgZm9yIGEgcmVzb3Vy
Y2UsDQo+IHdoZXJlIHRoZSB2aXJ0dWFsIGFkZHJlc3MgaXMgdGhlIGlvcmVtYXAgb2Ygc2FpZCBy
ZXNvdXJjZS4gIFdlDQo+IGNvdWxkIGFsc28gbWFrZSB0aGF0IGEgbWFuYWdlZCBBUEkgc28gdGhh
dCB5b3UgY2FuIGdldCByaWQgb2YgdGhlDQo+IGNsZWFudXAgcGF0aC4NCg0KVGhpcyBpcyBjbG9z
ZSB0byB3aGF0IEkndmUgYWxyZWFkeSBwcmVwYXJlZCBpbiB0aGUgbmV4dCBzcGluLiBJdCdzIGEg
bmV3IA0KdXNiIGhjZCBhcGkgc28gaXQncyBub3QgYXMgYWJzdHJhY3QgYXMgeW91ciBpZGVhLiBJ
IHRoaW5rIHdlIGNhbiBkaXNjdXNzIA0Kb24gaXQgYWZ0ZXIgSSdsbCBzZW5kIGl0Lg0KDQotLS0N
CkJlc3QgUmVnYXJkcywgTGF1cmVudGl1
