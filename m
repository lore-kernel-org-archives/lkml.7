Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA21C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6548920842
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="sGbl0xvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbfI3NXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:23:24 -0400
Received: from mail-eopbgr780075.outbound.protection.outlook.com ([40.107.78.75]:46400
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728214AbfI3NXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:23:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFqZIDmchfh30iTyS1RHz7HlOO3lNcwvG5v14ovQDtX1GWIZgQvcT7Jk4Lpq2CWHR40vEBcfCRx0plfe8XNzhm3vTxk9J7/cGG6bEY24ImYMNacBhGxw9g1YUSbAzqf6Ae4h6Dp8O1Lg3twYQwSclpvjVJp0+G5pMuEp3eB5/s4GEFi/sPmEuNAinGl5aYeOSwkB+BBQF/wY5PAVO5FAH4DeoaJItnCOz5tjSa8Ui0IWBNmLCJ+e7UrT1wRn5SDHYaqU+Kmgx0zOF+d6tgWbegub0YYGbd/aoTkXSswLMkuDsvDtvkQgSb5zY2S3xl7q7l4Gf2H/VL3U5gEwVIqCTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoCDARwYj6s/Z4ennEhQ61RUwsahB2v3brcTD77C9MQ=;
 b=YU2RND76tTuvX+U5s9IPOy1bmin/H3k5tqZB6NYxAwHLBdmQDMK+tMm2MokVfvOtMyFN2HHB+CIu9imTpIkIzcMruf11Cn8PJt1Oiad5hO5pQxF4mDoXWMEMvBle9BTM09+22SxvRPS86F2PntA3tIIXjRhS5P2634PjwuRKepUEXPtLx7Z005TyulubPVo4A9vKk0YLG3YX2flj+De4N96pYkysjR8TzsErLS1Zkb6oy7oDym9yniXGUdLtYYRiQp44uiFEM3Pir86ak8U+2TDUHP80I3WQjPN2itDt2aS98E2OtiYsoiQzsWINdA0G3FxpUTm9AfNC7gDqLM68hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoCDARwYj6s/Z4ennEhQ61RUwsahB2v3brcTD77C9MQ=;
 b=sGbl0xvY2q0rW8bQr+aRHneqBoo882mvwfC2TOAOYNCTg68GCoKit99UIrBqO+HsrXtCJXI3VNn07vMBJDHVNLwwQ2vgs4iF+YZG0BEbOmsa1pK7KIS4cjPRC2gp0hCfa2gbt2bkBQ2n7Fxh1wxfScAVJgtnOyrKQEKyFHdeSDw=
Received: from MN2PR08MB6397.namprd08.prod.outlook.com (52.132.171.78) by
 MN2PR08MB5806.namprd08.prod.outlook.com (20.179.87.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 13:23:20 +0000
Received: from MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::ac7d:ddc1:cbf0:8895]) by MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::ac7d:ddc1:cbf0:8895%2]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 13:23:20 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     'Miquel Raynal' <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Kletsky <git-commits@allycomm.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: RE: [EXT] Re: [PATCH 4/8] mtd: spinand: enabled parameter page
 support
Thread-Topic: [EXT] Re: [PATCH 4/8] mtd: spinand: enabled parameter page
 support
Thread-Index: AQHVTQVYHbcWWzA3wEWlNijlLbbUXqcCOMrwgAAMFQCALBeSUA==
Date:   Mon, 30 Sep 2019 13:23:19 +0000
Message-ID: <MN2PR08MB63970BCC1F65518917E08610B8820@MN2PR08MB6397.namprd08.prod.outlook.com>
References: <20190722055621.23526-1-sshivamurthy@micron.com>
        <20190722055621.23526-5-sshivamurthy@micron.com>
        <20190807114855.35f26229@xps13>
        <MN2PR08MB59511E352AE382D103DA56CBB8A80@MN2PR08MB5951.namprd08.prod.outlook.com>
 <20190819112118.56b2f9ea@xps13>
In-Reply-To: <20190819112118.56b2f9ea@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3NoaXZhbXVydGh5XGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNzYyNTQ1NGItZTM4NS0xMWU5LWIxZGMtOTgzYjhmNzQ1MjUxXGFtZS10ZXN0XDc2MjU0NTRkLWUzODUtMTFlOS1iMWRjLTk4M2I4Zjc0NTI1MWJvZHkudHh0IiBzej0iNzc3MCIgdD0iMTMyMTQzMjMzOTc0MDQxNzg1IiBoPSJydnJCV1FpdEVoczJNbXdyaUdCQnNpaStKRlE9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b5f282c-01f5-488a-06ac-08d745a95cb3
x-ms-traffictypediagnostic: MN2PR08MB5806:|MN2PR08MB5806:|MN2PR08MB5806:
x-microsoft-antispam-prvs: <MN2PR08MB5806D5D469CAE452511E68C5B8820@MN2PR08MB5806.namprd08.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(189003)(199004)(43544003)(14454004)(7696005)(6916009)(9686003)(8676002)(54906003)(76176011)(76116006)(66574012)(6436002)(66946007)(316002)(55016002)(66476007)(64756008)(4326008)(66556008)(66446008)(99286004)(6246003)(25786009)(74316002)(86362001)(486006)(55236004)(476003)(11346002)(102836004)(33656002)(52536014)(8936002)(2906002)(7416002)(7736002)(66066001)(446003)(229853002)(478600001)(71190400001)(71200400001)(305945005)(26005)(14444005)(256004)(81156014)(186003)(81166006)(3846002)(6116002)(5660300002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5806;H:MN2PR08MB6397.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FVYLfyuWCDaBKFRKCA2pkSoe9mhA+isyTxvD+4AjAJMz2Lc5Bp9/fmAg/9VqZdDvgtTTCICTgVPQ9KKcDN7LlDMwqABFW72UvUcUfHHqiWPaoRyEvet1qdmxa4JFxOWlQdOeThhFCIujgKBD4YlQURQpp3F2RkzrlCjbb2bpMPz3e8b4AnL0123Og6y7fA19H4Jd8x5ZNCKwDZXy58TqWELRu9rKc23lr7zs6gPbnpzdqSbwtj9fYnU3agf6IEp9/0/Bi9kRRiCQRLuepnzdlg2+jmIINBgrKZ9U6kjKu1A/nc6cejiGqZClRxb50ZsQPquxsxl43t68EneKhTyxwOjDKMMDN6ennIna+RLaWFRn1KqRsrmlfykqqQDobKK7mys49NTUIIkgFlSyQjoVA35SAO5kFQx5zyoEyQDJbps=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5f282c-01f5-488a-06ac-08d745a95cb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 13:23:20.0968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a+ll/U5gjMV1lxlDdpEYdyfgJxCge72qVj8KxZ6s+a72ngDwkeRM6YGBNnImZQ/+5Ta0JOn5rX9cpC1n6dUBzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5806
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTWlxdWVsICYgQm9yaXMsDQoNCkp1c3QgYSBnZW50bGUgcmVtaW5kZXIgdGhhdCBJJ2Qg
bGlrZSBzb21lIGZlZWRiYWNrLg0KDQpUaGFua3MsDQpTaGl2YQ0KDQo+IA0KPiBIaSBCb3JpcywN
Cj4gDQo+IEFub3RoZXIgcXVlc3Rpb24gZm9yIHlvdSA6KQ0KPiANCj4gIlNoaXZhbXVydGh5IFNo
YXN0cmkgKHNzaGl2YW11cnRoeSkiIDxzc2hpdmFtdXJ0aHlAbWljcm9uLmNvbT4gd3JvdGUNCj4g
b24NCj4gTW9uLCAxOSBBdWcgMjAxOSAwODo1MTo1MiArMDAwMDoNCj4gDQo+ID4gSGkgTWlxdWVs
LA0KPiA+DQo+ID4gPg0KPiA+ID4gSGkgU2hpdmEsDQo+ID4gPg0KPiA+ID4gc2hpdmEubGludXh3
b3Jrc0BnbWFpbC5jb20gd3JvdGUgb24gTW9uLCAyMiBKdWwgMjAxOSAwNzo1NjoxNyArMDIwMDoN
Cj4gPiA+DQo+ID4gPiAibXRkOiBzcGluYW5kOiBlbmFibGUgcGFyYW1ldGVyIHBhZ2Ugc3VwcG9y
dCINCj4gPiA+DQo+ID4gPiA+IEZyb206IFNoaXZhbXVydGh5IFNoYXN0cmkgPHNzaGl2YW11cnRo
eUBtaWNyb24uY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBTb21lIG9mIHRoZSBTUEkgTkFORCBkZXZp
Y2VzIGhhcyBwYXJhbWV0ZXIgcGFnZSwgd2hpY2ggaXMgc2ltaWxhciB0bw0KPiA+ID4gICAgICAg
ICAgICAgICAgICAtICAgICAgICAgICAgIGhhdmUgYQ0KPiA+ID4gPiBPTkZJIHRhYmxlLg0KPiA+
ID4gICByZWd1bGFyIHJhdyBOQU5EIE9ORkkgdGFibGVzLg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+
ID4gQnV0LCBpdCBtYXkgbm90IGJlIHNlbGYgc3VmZmljaWVudCB0byBwcm9wYWdhdGUgYWxsIHRo
ZSByZXF1aXJlZA0KPiA+ID4gICBBcyBpdCBtYXkgbm90IGJlDQo+ID4gPiA+IHBhcmFtZXRlcnMu
IEZpeHVwIGZ1bmN0aW9uIGhhcyBiZWVuIGFkZGVkIGluIHN0cnVjdCBtYW51ZmFjdHVyZXIgdG8N
Cj4gPiA+ICAgICAgICAgICAgICwgYSBmaXh1cCAgICAgICAgaXMgYmVpbmcgYWRkZWQgaW4gdGhl
IG1hbnVmYWN0dXJlciBzdHJ1Y3R1cmUNCj4gPiA+ID4gYWNjb21tb2RhdGUgdGhpcy4NCj4gPiA+
DQo+ID4gPiBUaGUgZml4dXAgZnVuY3Rpb24gc2VudGVuY2Ugc2hvdWxkIGJlIGRyb3BwZWQgZnJv
bSB0aGUgY29tbWl0DQo+IG1lc3NhZ2UsDQo+ID4gPiBzZWUgYmVsb3cuDQo+ID4NCj4gPiBPa2F5
LCBJIHdpbGwgY3JlYXRlIHNlcGFyYXRlIHBhdGNoIGZvciBmaXh1cCBmdW5jdGlvbi4NCj4gPg0K
PiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU2hpdmFtdXJ0aHkgU2hhc3Ry
aSA8c3NoaXZhbXVydGh5QG1pY3Jvbi5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVy
cy9tdGQvbmFuZC9zcGkvY29yZS5jIHwgMTM0DQo+ID4gPiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gPiA+ID4gIGluY2x1ZGUvbGludXgvbXRkL3NwaW5hbmQuaCB8ICAg
MyArDQo+ID4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDEzNyBpbnNlcnRpb25zKCspDQo+ID4gPiA+
DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9uYW5kL3NwaS9jb3JlLmMgYi9kcml2
ZXJzL210ZC9uYW5kL3NwaS9jb3JlLmMNCj4gPiA+ID4gaW5kZXggODlmNmJlZWZiMDFjLi43YWU3
NmRhYjkxNDEgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbXRkL25hbmQvc3BpL2NvcmUu
Yw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL210ZC9uYW5kL3NwaS9jb3JlLmMNCj4gPiA+ID4gQEAg
LTQwMCw2ICs0MDAsMTMxIEBAIHN0YXRpYyBpbnQgc3BpbmFuZF9sb2NrX2Jsb2NrKHN0cnVjdA0K
PiA+ID4gc3BpbmFuZF9kZXZpY2UgKnNwaW5hbmQsIHU4IGxvY2spDQo+ID4gPiA+ICAJcmV0dXJu
IHNwaW5hbmRfd3JpdGVfcmVnX29wKHNwaW5hbmQsIFJFR19CTE9DS19MT0NLLCBsb2NrKTsNCj4g
PiA+ID4gIH0NCj4gPiA+ID4NCj4gPiA+ID4gKy8qKg0KPiA+ID4gPiArICogc3BpbmFuZF9yZWFk
X3BhcmFtX3BhZ2Vfb3AgLSBSZWFkIHBhcmFtZXRlciBwYWdlIG9wZXJhdGlvbg0KPiA+ID4NCj4g
PiA+IEFnYWluLCB0aGUgbmFtZSBpbiB0aGUgZG9jIGRvZXMgbm90IGZpdCB0aGUgZnVuY3Rpb24g
eW91IGRlc2NyaWJlDQo+ID4gPg0KPiA+ID4gPiArICogQHNwaW5hbmQ6IHRoZSBzcGluYW5kDQo+
ID4gPiAgICAgICAgICAgICAgICAgICAgIFNQSS1OQU5EIGNoaXANCj4gPiA+DQo+ID4gPiBTaGl2
YSwgdGhlcmUgYXJlIHdheSB0b28gbXVjaCB0eXBvcyBhbmQgc2hvcnRjdXRzIGluIHlvdXIgc2Vy
aWVzLg0KPiA+ID4gUGxlYXNlIGJlIG1vcmUgY2FyZWZ1bCBvdGhlcndpc2Ugd2UgY2FuJ3QgZm9j
dXMgb24gdGhlIHRlY2huaWNhbA0KPiA+ID4gYXNwZWN0cy4gSSBhbSBub3QgYSBuYXRpdmUgRW5n
bGlzaCBzcGVha2VyIGF0IGFsbCBidXQgcGxlYXNlLCBwbGFpbg0KPiA+ID4gRW5nbGlzaCBpcyBu
b3QgQyBjb2RlLiBXZSB0YWxrIFNQSS1OQU5EIGFuZCBub3Qgc3BpbmFuZCwgd2Ugc2F5DQo+ID4g
PiBzdHJ1Y3R1cmUgYW5kIG5vdCBzdHJ1Y3QsIGFjcm9ueW1zIGFyZSB1cHBlcmNhc2UsIGV0Yy4N
Cj4gPiA+DQo+ID4NCj4gPiBTb3JyeSBmb3IgdGhlIGluY29udmVuaWVuY2UgY2F1c2VkLCBJIHdp
bGwgdGFrZSBjYXJlIGZyb20gbmV4dCB0aW1lLg0KPiA+DQo+ID4gPiA+ICsgKiBAcGFnZTogcGFn
ZSBudW1iZXIgd2hlcmUgcGFyYW1ldGVyIHBhZ2UgdGFibGVzIGNhbiBiZSBmb3VuZA0KPiA+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXiB0aGUNCj4gPiA+ID4gKyAqIEBidWY6IGJ1
ZmZlciB1c2VkIHRvIHN0b3JlIHRoZSBwYXJhbWV0ZXIgcGFnZQ0KPiA+ID4gPiArICogQGxlbjog
bGVuZ3RoIG9mIHRoZSBidWZmZXINCj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsgKiBSZWFkIHBhcmFt
ZXRlciBwYWdlDQo+ID4gPiAgICAgICAgICAgdGhlDQo+ID4gPiA+ICsgKg0KPiA+ID4gPiArICog
UmV0dXJucyAwIG9uIHN1Y2Nlc3MsIGEgbmVnYXRpdmUgZXJyb3IgY29kZSBvdGhlcndpc2UuDQo+
ID4gPiA+ICsgKi8NCj4gPiA+ID4gK3N0YXRpYyBpbnQgc3BpbmFuZF9wYXJhbWV0ZXJfcGFnZV9y
ZWFkKHN0cnVjdCBzcGluYW5kX2RldmljZQ0KPiAqc3BpbmFuZCwNCj4gPiA+ID4gKwkJCQkgICAg
ICAgdTggcGFnZSwgdm9pZCAqYnVmLCB1bnNpZ25lZCBpbnQgbGVuKQ0KPiA+ID4gPiArew0KPiA+
ID4gPiArCXN0cnVjdCBzcGlfbWVtX29wIHByZWFkX29wID0gU1BJTkFORF9QQUdFX1JFQURfT1Ao
cGFnZSk7DQo+ID4gPiA+ICsJc3RydWN0IHNwaV9tZW1fb3AgcHJlYWRfY2FjaGVfb3AgPQ0KPiA+
ID4gPiArDQo+ID4gPiAJU1BJTkFORF9QQUdFX1JFQURfRlJPTV9DQUNIRV9PUChmYWxzZSwNCj4g
PiA+ID4gKwkJCQkJCQkJMCwNCj4gPiA+ID4gKwkJCQkJCQkJMSwNCj4gPiA+ID4gKwkJCQkJCQkJ
YnVmLA0KPiA+ID4gPiArCQkJCQkJCQlsZW4pOw0KPiA+ID4NCj4gPiA+IFRoYXQncyBvayBpZiB5
b3UgY3Jvc3MgdGhlIDgwIGNoYXJhY3RlcnMgYm91bmRhcnkgaGVyZS4gWW91IG1heSBwdXQgIjAs
DQo+ID4gPiAxLCIgb24gdGhlIGZpcnN0IGxpbmUgYW5kICJidWYsIGxlbik7IiBvbiB0aGUgc2Vj
b25kLg0KPiA+ID4NCj4gPiA+ID4gKwl1OCBmZWF0dXJlOw0KPiA+ID4gPiArCXU4IHN0YXR1czsN
Cj4gPiA+ID4gKwlpbnQgcmV0Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJaWYgKGxlbiAmJiAhYnVm
KQ0KPiA+ID4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCXJldCA9
IHNwaW5hbmRfcmVhZF9yZWdfb3Aoc3BpbmFuZCwgUkVHX0NGRywNCj4gPiA+ID4gKwkJCQkgICZm
ZWF0dXJlKTsNCj4gPiA+ID4gKwlpZiAocmV0KQ0KPiA+ID4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+
ID4gPiArDQo+ID4gPiA+ICsJLyogQ0ZHX09UUF9FTkFCTEUgaXMgdXNlZCB0byBlbmFibGUgcGFy
YW1ldGVyIHBhZ2UgYWNjZXNzICovDQo+ID4gPiA+ICsJZmVhdHVyZSB8PSBDRkdfT1RQX0VOQUJM
RTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCXNwaW5hbmRfd3JpdGVfcmVnX29wKHNwaW5hbmQsIFJF
R19DRkcsIGZlYXR1cmUpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJcmV0ID0gc3BpX21lbV9leGVj
X29wKHNwaW5hbmQtPnNwaW1lbSwgJnByZWFkX29wKTsNCj4gPiA+ID4gKwlpZiAocmV0KQ0KPiA+
ID4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJcmV0ID0gc3BpbmFuZF93
YWl0KHNwaW5hbmQsICZzdGF0dXMpOw0KPiA+ID4gPiArCWlmIChyZXQgPCAwKQ0KPiA+ID4gPiAr
CQlyZXR1cm4gcmV0Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJcmV0ID0gc3BpX21lbV9leGVjX29w
KHNwaW5hbmQtPnNwaW1lbSwgJnByZWFkX2NhY2hlX29wKTsNCj4gPiA+ID4gKwlpZiAocmV0KQ0K
PiA+ID4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJcmV0ID0gc3BpbmFu
ZF9yZWFkX3JlZ19vcChzcGluYW5kLCBSRUdfQ0ZHLA0KPiA+ID4gPiArCQkJCSAgJmZlYXR1cmUp
Ow0KPiA+ID4gPiArCWlmIChyZXQpDQo+ID4gPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gPiA+ICsN
Cj4gPiA+ID4gKwlmZWF0dXJlICY9IH5DRkdfT1RQX0VOQUJMRTsNCj4gPiA+ID4gKw0KPiA+ID4g
PiArCXNwaW5hbmRfd3JpdGVfcmVnX29wKHNwaW5hbmQsIFJFR19DRkcsIGZlYXR1cmUpOw0KPiA+
ID4gPiArDQo+ID4gPiA+ICsJcmV0dXJuIDA7DQo+ID4gPiA+ICt9DQo+ID4gPiA+ICsNCj4gPiA+
IEFkZCB0aGUga2VybmVsIGRvYyBwbGVhc2UNCj4gPiA+DQo+ID4gPiBDaGFuZ2UgdGhlIGJlbG93
IGZ1bmN0aW9uIHNvIHRoYXQgaXQgcmV0dXJucyAxIGlmIHRoZSBwYWdlIHdhcw0KPiA+ID4gZGV0
ZWN0ZWQsIDAgaWYgaXQgZGlkIG5vdCwgYW4gbmVnYXRpdmUgZXJyb3IgY29kZSBvdGhlcndpc2Uu
DQo+ID4gPg0KPiA+ID4gPiArc3RhdGljIGludCBzcGluYW5kX3BhcmFtX3BhZ2VfZGV0ZWN0KHN0
cnVjdCBzcGluYW5kX2RldmljZQ0KPiAqc3BpbmFuZCkNCj4gPiA+ID4gK3sNCj4gPiA+ID4gKwlz
dHJ1Y3QgbXRkX2luZm8gKm10ZCA9IHNwaW5hbmRfdG9fbXRkKHNwaW5hbmQpOw0KPiA+ID4gPiAr
CXN0cnVjdCBuYW5kX21lbW9yeV9vcmdhbml6YXRpb24gKm1lbW9yZzsNCj4gPiA+ID4gKwlzdHJ1
Y3QgbmFuZF9vbmZpX3BhcmFtcyAqcDsNCj4gPiA+ID4gKwlzdHJ1Y3QgbmFuZF9kZXZpY2UgKmJh
c2UgPSBzcGluYW5kX3RvX25hbmQoc3BpbmFuZCk7DQo+ID4gPiA+ICsJaW50IGksIHJldDsNCj4g
PiA+ID4gKw0KPiA+ID4gPiArCW1lbW9yZyA9IG5hbmRkZXZfZ2V0X21lbW9yZyhiYXNlKTsNCj4g
PiA+ID4gKw0KPiA+ID4gPiArCS8qIEFsbG9jYXRlIGJ1ZmZlciB0byBob2xkIHBhcmFtZXRlciBw
YWdlICovDQo+ID4gPiA+ICsJcCA9IGt6YWxsb2MoKHNpemVvZigqcCkgKiAzKSwgR0ZQX0tFUk5F
TCk7DQo+ID4gPiA+ICsJaWYgKCFwKQ0KPiA+ID4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gPiA+
ID4gKw0KPiA+ID4gPiArCXJldCA9IHNwaW5hbmRfcGFyYW1ldGVyX3BhZ2VfcmVhZChzcGluYW5k
LCAweDAxLCBwLCBzaXplb2YoKnApICoNCj4gPiA+IDMpOw0KPiA+ID4gPiArCWlmIChyZXQpIHsN
Cj4gPiA+ID4gKwkJcmV0ID0gMDsNCj4gPiA+DQo+ID4gPiBObywgeW91IHNob3VsZCByZXR1cm4g
dGhlIGVycm9yIGluIGNhc2Ugb2YgZXJyb3IuIFlvdSB3aWxsIGxhdGVyIGhhbmRsZQ0KPiA+ID4g
dGhlIGZhY3QgdGhhdCB0aGVyZSBpcyBubyBwYXJhbWV0ZXIgcGFnZS4NCj4gPg0KPiA+IG9rYXku
DQo+ID4NCj4gPiA+DQo+ID4gPiA+ICsJCWdvdG8gZnJlZV9wYXJhbV9wYWdlOw0KPiA+ID4gPiAr
CX0NCj4gPiA+ID4gKw0KPiA+ID4gPiArCWZvciAoaSA9IDA7IGkgPCAzOyBpKyspIHsNCj4gPiA+
ID4gKwkJaWYgKG9uZmlfY3JjMTYoT05GSV9DUkNfQkFTRSwgKHU4ICopJnBbaV0sIDI1NCkgPT0N
Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXg0KPiA+ID4gSWYgeW91IGZvcmNlIHRoZSBwYXJhbWV0ZXIgcGFnZSB0byBiZSAy
NTQgYnl0ZXMgbG9uZyBpdCBtZWFucyB5b3UgbGltaXQNCj4gPiA+IHlvdXJzZWxmIHRvIE9ORkkg
c3RhbmRhcmQuIFRoYXQncyBub3QgYSBwcm9ibGVtLCBidXQgdGhlbiB5b3Ugc2hvdWxkDQo+ID4g
PiBtZW50aW9uIGl0IGluIHRoZSBmdW5jdGlvbiBuYW1lLg0KPiA+DQo+ID4gb2theSwgSSB3aWxs
IG1lbnRpb24gaW4ga2VybmVsIGRvYy4NCj4gPg0KPiA+ID4NCj4gPiA+ID4gKwkJCQlsZTE2X3Rv
X2NwdShwLT5jcmMpKSB7DQo+ID4gPiA+ICsJCQlpZiAoaSkNCj4gPiA+ID4gKwkJCQltZW1jcHko
cCwgJnBbaV0sIHNpemVvZigqcCkpOw0KPiA+ID4gPiArCQkJYnJlYWs7DQo+ID4gPiA+ICsJCX0N
Cj4gPiA+ID4gKwl9DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlpZiAoaSA9PSAzKSB7DQo+ID4gPiA+
ICsJCWNvbnN0IHZvaWQgKnNyY2J1ZnNbM10gPSB7cCwgcCArIDEsIHAgKyAyfTsNCj4gPiA+ID4g
Kw0KPiA+ID4gPiArCQlwcl93YXJuKCJDb3VsZCBub3QgZmluZCBhIHZhbGlkIE9ORkkgcGFyYW1l
dGVyIHBhZ2UsIHRyeWluZw0KPiA+ID4gYml0LXdpc2UgbWFqb3JpdHkgdG8gcmVjb3ZlciBpdFxu
Iik7DQo+ID4gPiA+ICsJCW5hbmRfYml0X3dpc2VfbWFqb3JpdHkoc3JjYnVmcywgQVJSQVlfU0la
RShzcmNidWZzKSwgcCwNCj4gPiA+ID4gKwkJCQkgICAgICAgc2l6ZW9mKCpwKSk7DQo+ID4gPiA+
ICsNCj4gPiA+ID4gKwkJaWYgKG9uZmlfY3JjMTYoT05GSV9DUkNfQkFTRSwgKHU4ICopcCwgMjU0
KSAhPQ0KPiA+ID4gPiArCQkJCWxlMTZfdG9fY3B1KHAtPmNyYykpIHsNCj4gPiA+ID4gKwkJCXBy
X2VycigiT05GSSBwYXJhbWV0ZXIgcmVjb3ZlcnkgZmFpbGVkLA0KPiA+ID4gYWJvcnRpbmdcbiIp
Ow0KPiA+ID4gPiArCQkJZ290byBmcmVlX3BhcmFtX3BhZ2U7DQo+ID4gPiA+ICsJCX0NCj4gPiA+
ID4gKwl9DQo+ID4gPg0KPiA+ID4gVGhlIHdob2xlIGZvci1sb29wIGFuZCB0aGUgaWYgKGk9PTMp
IGNvbmRpdGlvbiBpcyBleGFjdGx5IHRoZSBzYW1lIGFzDQo+ID4gPiBmb3IgcmF3IE5BTkRzIGFu
ZCBtdXN0IGJlIGV4dHJhY3RlZCBpbiBhIGdlbmVyaWMgZnVuY3Rpb246DQo+ID4gPiAxLyBleHRy
YWN0IHRoZSBmdW5jdGlvbiBmcm9tIG5hbmQvcmF3L25hbmRfb25maS5jIGFuZCBwdXQgaXQgaW4N
Cj4gPiA+IG5hbmQvb25maS5jLg0KPiA+ID4gMi8gdGhlbiB1c2UgaXQgaW4gdGhpcyBwYXRjaC4N
Cj4gPg0KPiA+IEkgaGF2ZSBkb25lIHRoaXMgaW50ZW50aW9uYWxseSwgYmVjYXVzZSBpbiByYXcg
TkFORCBjYXNlIHRoZXJlIGlzIGZ1bmN0aW9uDQo+ID4gIm5hbmRfcmVhZF9kYXRhX29wIiBjYWxs
ZWQgaW5zaWRlIGZvci1sb29wLiBJIGRvbid0IHRoaW5rIGp1c3QgZm9yIGlmIChpID09IDMpDQo+
ID4gaXQgaXMgbmVjZXNzYXJ5IHRvIGNyZWF0ZSBuZXcgZnVuY3Rpb24uDQo+ID4NCj4gPiBMZXQg
bWUga25vdyBpZiB5b3UgaGF2ZSBkaWZmZXJlbnQgb3Bpbmlvbi4NCj4gDQo+IEkgZG9uJ3QgaGF2
ZSBhIHN0cm9uZyBvcGluaW9uIG9uIHRoYXQuIEJvcmlzIHdoYXQgZG8geW91IHRoaW5rPyBTaGFs
bA0KPiB3ZSBkdXBsaWNhdGUgdGhlIGNvZGU/IEl0J3Mgbm90IGp1c3QgYWJvdXQgdGhlIGlmIGNv
bmRpdGlvbiwgaXQncyB0aGUNCj4gd2hvbGUgZm9yIGxvb3Agd2hpY2ggaXMgdmVyeSBzaW1pbGFy
Lg0KPiANCj4gDQo+IFRoYW5rcywNCj4gTWlxdcOobA0K
