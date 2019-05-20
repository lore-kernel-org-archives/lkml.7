Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67AAC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E0A20656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IYdJ/Ycl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733036AbfETLez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:34:55 -0400
Received: from mail-eopbgr50087.outbound.protection.outlook.com ([40.107.5.87]:55871
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730659AbfETLey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNl2AGubCe73+hSHZ3dKYBozudCA3qObyu2EOlvhDsg=;
 b=IYdJ/YclCZaFkTT5h81qH2dTufaWp4zCPU9Kpoq/oUECoQ2WAhAX1s/hPFjjF7u1xEO6Zcgv/1xMwdfP4zOSRui+/UZlc0kN7VN74mKH4mAb/6lOEjrJGlnPO9tRE60L82TbxA7XcfUYUeOp93YESnfNhX1DKCJwpEKtKCfG8pw=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB4496.eurprd04.prod.outlook.com (20.177.54.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Mon, 20 May 2019 11:34:49 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40%7]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 11:34:49 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     Robin Murphy <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>,
        "JuergenUrban@gmx.de" <JuergenUrban@gmx.de>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/3] prerequisites for device reserved local mem
 rework
Thread-Topic: [RFC PATCH v2 0/3] prerequisites for device reserved local mem
 rework
Thread-Index: AQHVCmKoDp6AVawLEEugEGZuSLgHU6Zqu4uAgAA1oICAAQ5TAIAAYlQAgAFEQACAADmjAIABSOCAgAByTYCABFBmgA==
Date:   Mon, 20 May 2019 11:34:48 +0000
Message-ID: <3c8897e9-218e-3fff-1735-816ffd30e908@nxp.com>
References: <20190514143807.7745-1-laurentiu.tudor@nxp.com>
 <9d34015d-c219-179b-3141-4b0de3530ac3@arm.com> <20190514182931.GA2559@sx9>
 <0e5f3b86-7a80-eec7-691b-34a123194208@nxp.com> <20190515162858.GB17162@sx9>
 <ed63c117-610c-ea49-f45e-727be220745f@nxp.com> <20190516151548.GB53952@sx9>
 <5fa97254-3038-6fe7-a7e7-a267262049c6@nxp.com> <20190517174159.GA32450@sx9>
In-Reply-To: <20190517174159.GA32450@sx9>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93168338-5747-41a0-306e-08d6dd172ace
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4496;
x-ms-traffictypediagnostic: VI1PR04MB4496:
x-microsoft-antispam-prvs: <VI1PR04MB4496B68E1BC699B7D420EDDBEC060@VI1PR04MB4496.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(136003)(396003)(43544003)(199004)(189003)(8676002)(73956011)(71200400001)(71190400001)(8936002)(81166006)(81156014)(76116006)(14454004)(31686004)(478600001)(66476007)(66556008)(64756008)(66446008)(66946007)(91956017)(7736002)(305945005)(316002)(26005)(6916009)(25786009)(102836004)(76176011)(68736007)(4326008)(186003)(53546011)(6506007)(36756003)(31696002)(229853002)(5024004)(6486002)(256004)(6246003)(66066001)(6436002)(86362001)(53936002)(44832011)(99286004)(6512007)(5660300002)(11346002)(54906003)(476003)(446003)(3846002)(6116002)(2616005)(486006)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4496;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2S+dsljc5iYcZtf+1jD2rFOL2TLRrb2/3jlHT/PSBbnLp/SC2aFv+4sODDKmz93UNZ35+HkE1YH0hNxb1DXy5sn99PtVO5ajcvaM275T6DCq6pKDQcX0GmrJ19RyzNpcPipLrRKAmuN0tBnaHyh22X4nChQ2aVs2nI1nvA6H5OCufWE8Ax2SXKI9WLsrA0tQtZ9IQ3vJHzqTEngA2Rp9dSSlMrRxL2kiRsfsN/k3hWvtoZGMfHg7haU/QOaQ+sG/cO6KOORZ3zrtFxNitAiqJP1qWzG16D+n3ScmZgOJ02cCGNH/knx2SWETJZ5afMAE6CNW6swcP8MzW7ABHH1UenVf54Q6LrobxAz8jYaSgVql0FqhjpRhyrZjJMg9o7m/kQklj4+SiIn7yfrqyjtTOjw+/qutLTZWOQJO61XTS5I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4743EC49162E8C4D973BB16B3013C0AE@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93168338-5747-41a0-306e-08d6dd172ace
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 11:34:49.0626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4496
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gRnJlZHJpaywNCg0KT24gMTcuMDUuMjAxOSAyMDo0MSwgRnJlZHJpayBOb3Jpbmcgd3Jv
dGU6DQo+IEhpIExhdXJlbnRpdSwNCj4gDQo+Pj4gdGhhdCBJIHRyYWNrZWQgZG93biB0byB0aGUg
Y2FsbHMNCj4+Pg0KPj4+IAkgICBodWJfcG9ydF9pbml0DQo+Pj4gCS0+IHVzYl9jb250cm9sX21z
Zw0KPj4+IAktPiB1c2JfaW50ZXJuYWxfY29udHJvbF9tc2cNCj4+PiAJLT4gdXNiX3N0YXJ0X3dh
aXRfdXJiDQo+Pj4gCS0+IHVzYl9zdWJtaXRfdXJiDQo+Pj4gCS0+IHVzYl9oY2Rfc3VibWl0X3Vy
Yg0KPj4+IAktPiBoY2QtPmRyaXZlci0+dXJiX2VucXVldWUNCj4+PiAJLT4gb2hjaV91cmJfZW5x
dWV1ZQ0KPj4+IAktPiBlZF9nZXQNCj4+PiAJLT4gZWRfYWxsb2MNCj4gDQo+IEkgZm91bmQgdGhh
dCB0aGUgZ2VuZXJpYyBPSENJIGRyaXZlciB0YWtlcyBhIHdyb25nIHR1cm4gaGVyZSwgaW4gZWRf
YWxsb2MsDQo+IGFuZCBldmVudHVhbGx5IGFsc28gaW4gdGRfYWxsb2MuIEZvcnR1bmF0ZWx5LCB5
b3VyIHBhdGNoIGNhbiBiZSBlYXNpbHkNCj4gZXh0ZW5kZWQgdG8gZml4IHRoZW0gYXMgd2VsbC4g
UGxlYXNlIHNlZSBhdHRhY2hlZCBwYXRjaCBiZWxvdy4NCj4gDQo+IFdpdGggdGhhdCwgdGhlIE9I
Q0kgc2VlbXMgdG8gd29yayBhcyBleHBlY3RlZCB3aXRoIEhDRF9MT0NBTF9NRU0uIDopDQoNCldv
dywgdGhhdCdzIGV4Y2VsbGVudCBuZXdzISBUaGFua3MgYSBsb3QgZm9yIGxvb2tpbmcgaW50byB0
aGlzLg0KQXJlIHlvdSBvayBpZiBJIGFkZCB5b3VyIFNpZ25lZC1PZmYtYnkgYW5kIG1heWJlIGFs
c28gVGVzdGVkLWJ5IGluIHRoZSANCmZpcnN0IHBhdGNoIG9mIHRoZSBzZXJpZXM/DQpBcyBhIHNp
ZGUgbm90ZSwgSSBwbGFuIHRvIGFkZCBhIG5ldyBIQ0QgZnVuY3Rpb24gYW5kIG5hbWUgaXQgc29t
ZXRoaW5nIA0KbGlrZSBoY2Rfc2V0dXBfbG9jYWxfbWVtKCkgdGhhdCB3b3VsZCB0YWtlIGNhcmUg
b2Ygc2V0dGluZyB1cCB0aGUgDQpnZW5hbGxvYyBmb3IgZHJpdmVycy4NCg0KPiBXb3VsZCB5b3Ug
bGlrZSBtZSB0byBzdWJtaXQgZ2VuX3Bvb2xfZG1hX3phbGxvYyBhcyBhIHNlcGFyYXRlIHBhdGNo
Pw0KDQpZZXMsIEkgdGhpbmsgaXQgd291bGQgbWFrZSBzZW5zZSB0byBwdXQgdGhlIG5ldyBBUEkg
aW4gYSBkaXN0aW5jdCBwYXRjaC4gDQpJIHRoaW5rIHdlIGNhbiBlaXRoZXIgaW5jbHVkZSBpdCBp
biB0aGUgbmV4dCB2ZXJzaW9uIG9mIHRoZSBwYXRjaCBzZXJpZXMgDQpvciB5b3UgY2FuIHN1Ym1p
dCBzZXBhcmF0ZWx5IGFuZCBJJ2xsIG1lbnRpb24gaXQgYXMgZGVwZW5kZW5jeSBmb3IgdGhpcyAN
CnBhdGNoIHNlcmllcywgaG93ZXZlciB5b3UgcHJlZmVyLg0KDQoNCi0tLQ0KVGhhbmtzICYgQmVz
dCBSZWdhcmRzLCBMYXVyZW50aXU=
