Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00930C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C8A2067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="k7HaQpMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfKLUsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:48:16 -0500
Received: from mail-eopbgr30082.outbound.protection.outlook.com ([40.107.3.82]:33926
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726718AbfKLUsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:48:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILmLsM393gt+hUkdb4iiWt31MQTwC5d2Z084RjiqVB3nltOSyh03anXvBbeEVkPI94WRUY7Ea9eEA4MVKXaskzDj8PEdCYwHslbF1KCoY9Erf0oMjDcQ3bYIqTFvs5al63SqUWITt9Vxq5MDDYqz1dag4WPhKWu+KLWmGaEU9uBbRcVZGSeLM8JLH5yHUmS8ffFPThYJbdGvuzdBDghXguIeio/0FIDKwpWIc02VNkazu+Hcn515b9i9bbf9FAuiat5Tual6AzzcrAvzsq2o98gm9ptQxvYvdkVGE0O48J4e2+EyhiT0HzaTEas7tNS/2FTqmpzGDKe8QieJpRHitw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ06Csxo66vnRQURV1AbzE7WogxlgCTM8oYlNtf3Uts=;
 b=F5eBGYr0UgSIHCZrc6ttnxk0bCA94zJfDzCvjlBrePr/YittPqeGdso2SFhulU3kw4WYv/RND8wyUDJay8uJXYWX7QKP2YB62F/KAa76TG76iiLXyIWNO+CcYxMZ9ETMx4I/sUzVr/y12aw7ItM9I9PEd6pjPUEcUhz5p2Q82EPX66TGub+YjVh9oHa/sVSwVfIak/oQL8+O6zB55yPwJ66JZpSGkkBnB15RhpZ80qq9HSXFkpq17qoTQKSxt1kEQiO4P1/hQCsvCKPZ+xdj6iYNwFdbARaaKgraQCSMwm/j+a/hitbBr4rX723anF7xK6pWQtBwojxRvzwD92SwzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ06Csxo66vnRQURV1AbzE7WogxlgCTM8oYlNtf3Uts=;
 b=k7HaQpMCi90K3MsPm8YTuWtfUecqMZGx0uY7FIJyZ+14ayAxAnRf4g7tOdeDDmFf+1anw3FxVqQE3C+9KJz4kYVNssaD/ijY6bdl1HcNRPl3pyK4VfopD2HGof21dGCP1TAIv/q/wOn9Z6iuSpecxyVgj27tSFCA+2/2ybohkSc=
Received: from DB6PR0501MB2712.eurprd05.prod.outlook.com (10.172.225.17) by
 DB6PR0501MB2488.eurprd05.prod.outlook.com (10.168.73.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 20:48:06 +0000
Received: from DB6PR0501MB2712.eurprd05.prod.outlook.com
 ([fe80::99be:5f3a:9871:ecd1]) by DB6PR0501MB2712.eurprd05.prod.outlook.com
 ([fe80::99be:5f3a:9871:ecd1%12]) with mapi id 15.20.2430.027; Tue, 12 Nov
 2019 20:48:06 +0000
From:   Asmaa Mnebhi <Asmaa@mellanox.com>
To:     "minyard@acm.org" <minyard@acm.org>,
        Vijay Khemka <vijaykhemka@fb.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cminyard@mvista.com" <cminyard@mvista.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>
Subject: RE: [PATCH 2/2] drivers: ipmi: Modify max length of IPMB packet
Thread-Topic: [PATCH 2/2] drivers: ipmi: Modify max length of IPMB packet
Thread-Index: AQHVmQJk8sCJH6Uy7E6qy5eNUr7iE6eHfQWAgAB3iACAAAk2AIAAA93w
Date:   Tue, 12 Nov 2019 20:48:06 +0000
Message-ID: <DB6PR0501MB2712E7F87DD479BE23A99E21DA770@DB6PR0501MB2712.eurprd05.prod.outlook.com>
References: <20191112023610.3644314-1-vijaykhemka@fb.com>
 <20191112023610.3644314-2-vijaykhemka@fb.com>
 <20191112124845.GE2882@minyard.net>
 <7BC487D6-6ACA-46CE-A751-8367FEDEE647@fb.com>
 <20191112202932.GJ2882@minyard.net>
In-Reply-To: <20191112202932.GJ2882@minyard.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Asmaa@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7b747f8c-d5ea-487c-495f-08d767b19ec9
x-ms-traffictypediagnostic: DB6PR0501MB2488:
x-microsoft-antispam-prvs: <DB6PR0501MB248839C313BC0B8EB2215178DA770@DB6PR0501MB2488.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(13464003)(199004)(189003)(80792005)(26005)(53546011)(6246003)(76176011)(11346002)(99286004)(186003)(5660300002)(6506007)(102836004)(25786009)(446003)(486006)(476003)(66556008)(2906002)(64756008)(66476007)(2501003)(86362001)(3846002)(66446008)(6116002)(54906003)(71190400001)(316002)(110136005)(305945005)(66066001)(7736002)(478600001)(8676002)(81166006)(81156014)(74316002)(7416002)(6436002)(229853002)(8936002)(66946007)(9686003)(52536014)(4326008)(55016002)(14444005)(14454004)(33656002)(76116006)(7696005)(71200400001)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2488;H:DB6PR0501MB2712.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Nlyr22QM30KF5qQS0GR0ot4TLuwQXo4kwXuMmrHaXv546vCIkeioTj4zMdzy/fOdq+fuQ8J0OMV3zLx3LpvK2WPuB1J5vrFqvNrsH/37rb0eKMO81VmyvjeyRuZwuH0pknTy2SREDHqh6GxyAl2YSEc3SmQ5/PGTeM/o/0MOL4yXdTbJpNayKAiuW1wv7n2aP0LlKJWXzmCUaBrxLPn5sdRhDDO+5rrHTnrhNpDrPgAPrSfS9FwbltnUPYIeSl6cMuEDi8Eli93uHzVQx8kmX1nVLuPrhQvY1sxHjH+6Isx5DAYSfkxZaJ57LbtrSEBxqlIQvLb/fPJhYFo81ik4ijwZuFs+ovepYhT33ZnFWqMBIaUieLMX+VR17SG3+NYm5VRLgzNQ2j5jmdBroaD9zTcRxT35hN4SOcGIAhZnrDOmKqilq8QB8m0FdTynR8e
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b747f8c-d5ea-487c-495f-08d767b19ec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 20:48:06.6538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fPaXIkdurq4sQlZiIL1s24Qdsrg3lOmoEZxhtvV1z4cxRt2urVl5Ky0zBOfAsYUNMsoIkMEJMNB2GkFkKHq+gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2488
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDb3JleSBNaW55YXJkIDx0Y21p
bnlhcmRAZ21haWwuY29tPiBPbiBCZWhhbGYgT2YgQ29yZXkgTWlueWFyZA0KU2VudDogVHVlc2Rh
eSwgTm92ZW1iZXIgMTIsIDIwMTkgMzozMCBQTQ0KVG86IFZpamF5IEtoZW1rYSA8dmlqYXlraGVt
a2FAZmIuY29tPg0KQ2M6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+OyBHcmVnIEtyb2Fo
LUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgb3BlbmlwbWktZGV2ZWxvcGVy
QGxpc3RzLnNvdXJjZWZvcmdlLm5ldDsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgY21p
bnlhcmRAbXZpc3RhLmNvbTsgQXNtYWEgTW5lYmhpIDxBc21hYUBtZWxsYW5veC5jb20+OyBqb2Vs
QGptcy5pZC5hdTsgbGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5vcmc7IFNhaSBEYXNhcmkgPHNk
YXNhcmlAZmIuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGRyaXZlcnM6IGlwbWk6IE1v
ZGlmeSBtYXggbGVuZ3RoIG9mIElQTUIgcGFja2V0DQoNCk9uIFR1ZSwgTm92IDEyLCAyMDE5IGF0
IDA3OjU2OjM0UE0gKzAwMDAsIFZpamF5IEtoZW1rYSB3cm90ZToNCj4gDQo+IA0KPiDvu79PbiAx
MS8xMi8xOSwgNDo0OCBBTSwgIkNvcmV5IE1pbnlhcmQiIDx0Y21pbnlhcmRAZ21haWwuY29tIG9u
IGJlaGFsZiBvZiBtaW55YXJkQGFjbS5vcmc+IHdyb3RlOg0KPiANCj4gICAgIE9uIE1vbiwgTm92
IDExLCAyMDE5IGF0IDA2OjM2OjEwUE0gLTA4MDAsIFZpamF5IEtoZW1rYSB3cm90ZToNCj4gICAg
ID4gQXMgcGVyIElQTUIgc3BlY2lmaWNhdGlvbiwgbWF4aW11bSBwYWNrZXQgc2l6ZSBzdXBwb3J0
ZWQgaXMgMjU1LA0KPiAgICAgPiBtb2RpZmllZCBNYXggbGVuZ3RoIHRvIDI0MCBmcm9tIDEyOCB0
byBhY2NvbW1vZGF0ZSBtb3JlIGRhdGEuDQo+ICAgICANCj4gICAgIEkgY291bGRuJ3QgZmluZCB0
aGlzIGluIHRoZSBJUE1CIHNwZWNpZmljYXRpb24uDQo+ICAgICANCj4gICAgIElJUkMsIHRoZSBt
YXhpbXVtIG9uIEkyQyBpcyAzMiBieXRzLCBhbmQgdGFibGUgNi05IGluIHRoZSBJUE1JIHNwZWMs
DQo+ICAgICB1bmRlciAiSVBNQiBPdXRwdXQiIHN0YXRlczogVGhlIElQTUIgc3RhbmRhcmQgbWVz
c2FnZSBsZW5ndGggaXMNCj4gICAgIHNwZWNpZmllZCBhcyAzMiBieXRlcywgbWF4aW11bSwgaW5j
bHVkaW5nIHNsYXZlIGFkZHJlc3MuDQo+IA0KPiBXZSBhcmUgdXNpbmcgSVBNSSBPRU0gbWVzc2Fn
ZXMgYW5kIG91ciByZXNwb25zZSBzaXplIGlzIGFyb3VuZCAxNTAgDQo+IGJ5dGVzIEZvciBzb21l
IG9mIHJlc3BvbnNlcy4gVGhhdCdzIHdoeSBJIGhhZCBzZXQgaXQgdG8gMjQwIGJ5dGVzLg0KDQpI
bW0uICBXZWxsLCB0aGF0IGlzIGEgcHJldHR5IHNpZ25pZmljYW50IHZpb2xhdGlvbiBvZiB0aGUg
c3BlYywgYnV0IHRoZXJlJ3Mgbm90aGluZyBoYXJkIGluIHRoZSBwcm90b2NvbCB0aGF0IHByb2hp
Yml0cyBpdCwgSSBndWVzcy4NCg0KSWYgQXNtYWEgaXMgb2sgd2l0aCB0aGlzLCBJJ20gb2sgd2l0
aCBpdCwgdG9vLg0KDQpJdCBkb2Vzbid0IGJvdGhlciBtZSBlaXRoZXIuIEJ1dCBJIHdvdWxkIGxp
a2UgdG8gZG8gc29tZSBleHBlcmltZW50L3Rlc3RpbmcgZmlyc3QgYmVmb3JlIHZhbGlkYXRpbmcg
aXQuIEkgd2lsbCBnZXQgYmFjayB0byB5b3UuIFZpamF5LCBob3cgYXJlIHlvdSBkb2luZyB5b3Vy
IHRlc3Rpbmc/DQoNCi1jb3JleQ0KDQo+ICAgICANCj4gICAgIEknbSBub3Qgc3VyZSB3aGVyZSAx
MjggY2FtZSBmcm9tLCBidXQgbWF5YmUgaXQgc2hvdWxkIGJlIHJlZHVjZWQgdG8gMzEuDQo+ICAg
ICANCj4gICAgIC1jb3JleQ0KPiAgICAgDQo+ICAgICA+IA0KPiAgICAgPiBTaWduZWQtb2ZmLWJ5
OiBWaWpheSBLaGVta2EgPHZpamF5a2hlbWthQGZiLmNvbT4NCj4gICAgID4gLS0tDQo+ICAgICA+
ICBkcml2ZXJzL2NoYXIvaXBtaS9pcG1iX2Rldl9pbnQuYyB8IDIgKy0NCj4gICAgID4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiAgICAgPiANCj4gICAg
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci9pcG1pL2lwbWJfZGV2X2ludC5jIGIvZHJpdmVy
cy9jaGFyL2lwbWkvaXBtYl9kZXZfaW50LmMNCj4gICAgID4gaW5kZXggMjQxOWI5YTkyOGIyLi43
ZjkxOThiYmNlOTYgMTAwNjQ0DQo+ICAgICA+IC0tLSBhL2RyaXZlcnMvY2hhci9pcG1pL2lwbWJf
ZGV2X2ludC5jDQo+ICAgICA+ICsrKyBiL2RyaXZlcnMvY2hhci9pcG1pL2lwbWJfZGV2X2ludC5j
DQo+ICAgICA+IEBAIC0xOSw3ICsxOSw3IEBADQo+ICAgICA+ICAjaW5jbHVkZSA8bGludXgvc3Bp
bmxvY2suaD4NCj4gICAgID4gICNpbmNsdWRlIDxsaW51eC93YWl0Lmg+DQo+ICAgICA+ICANCj4g
ICAgID4gLSNkZWZpbmUgTUFYX01TR19MRU4JCTEyOA0KPiAgICAgPiArI2RlZmluZSBNQVhfTVNH
X0xFTgkJMjQwDQo+ICAgICA+ICAjZGVmaW5lIElQTUJfUkVRVUVTVF9MRU5fTUlOCTcNCj4gICAg
ID4gICNkZWZpbmUgTkVURk5fUlNQX0JJVF9NQVNLCTB4NA0KPiAgICAgPiAgI2RlZmluZSBSRVFV
RVNUX1FVRVVFX01BWF9MRU4JMjU2DQo+ICAgICA+IC0tIA0KPiAgICAgPiAyLjE3LjENCj4gICAg
ID4NCj4gICAgIA0KPiANCg==
