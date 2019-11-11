Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6ABC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC312196E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BZcOE/p1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfKKOwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:52:15 -0500
Received: from mail-eopbgr140113.outbound.protection.outlook.com ([40.107.14.113]:36930
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726878AbfKKOwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:52:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZW2iWGli6PNRM1/I0jknMFaq/OI4zSDG6No9xsrC+Vv2vPmTaBHCC20YHQxCuJTCsaAy4MlZwe8PsZfynJlLqFRxXcVDemeLu72GOg3uAtTOl2FM5Oi39OpxsSNWda6Ik7VAK0peT/rljdvyHqPabYJWJP9EMjRaXEskJB2lfCdSDdoT5/QTpUkgZc1q1PFJTeVSKTji+qu1GIkucLH8wSsraOTELZIlPP3OaGlGjcy7q4fO+/Ya2iRDw+jxhgDWOH+a6cMIEu5npGPDBxB5Mpa9MPHs2qPkRIIVPD8spkX7KBVEcJTGMlWtT+B/RO4/oRUYzHAsRGtY5BR5gA7Jug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6tHqjmWHOdza+9vSMA47IYrzvPhJEbmCxGy2WzfrJI=;
 b=D1IQt1FYC0elp4N4xC5xNabpBfPfQmQkk3FeVgzzHtUEkpKycgBX8oUANe02Aktp1s8LWqOhjx3cgSycJ69FvfRZuYZ/UKrJKdbUJNz69crmCtsrBcWw7yRd75cGYIOo6yv1HnLi2qYdTGvtgIC6gvoCEBvVmVh04xvnP3KabLmLMVLZClsmqTZwcQlf5z7sKDIu3V677S8JDPw0aIxjWRtFDsjIEnUqHAipyQ7grzMexUgdDQ3GGGApRjKWkon5NVR2CqYcYCVH7GC5piSbH4xGX25unimmtmTVjKsKWAsxZ0w7sWQc5MqDLuS1P3ud5gkdvvz9fhjZr746k+hICQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6tHqjmWHOdza+9vSMA47IYrzvPhJEbmCxGy2WzfrJI=;
 b=BZcOE/p1/mbEnI/ikNq6t1KOv3WYrM56bjLrLsA3BZ5If35CzI++yfAvWCQtzwHtXhM+vriZ70N+r5kTD1nKyA3ho//sJrT+dqzqKioV9tJT5la3zK0z0Yn3QjNKeIdldnKAFQwYqKZpSKE0fcq1JFPV9jqFwQj1QfAGGOX8m74=
Received: from AM0PR08MB5332.eurprd08.prod.outlook.com (52.132.212.72) by
 AM0PR08MB3795.eurprd08.prod.outlook.com (20.178.23.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Mon, 11 Nov 2019 14:52:10 +0000
Received: from AM0PR08MB5332.eurprd08.prod.outlook.com
 ([fe80::a55d:53b6:474e:68d5]) by AM0PR08MB5332.eurprd08.prod.outlook.com
 ([fe80::a55d:53b6:474e:68d5%3]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 14:52:10 +0000
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Oleg Nesterov <oleg@redhat.com>, Omar Sandoval <osandov@fb.com>
Subject: Re: mm/swap: possible problem introduced when replacing REQ_NOIDLE
 with REQ_IDLE
Thread-Topic: mm/swap: possible problem introduced when replacing REQ_NOIDLE
 with REQ_IDLE
Thread-Index: AQHVTo3urAN1e3lix0GUel1ztnMEfaeGohIA
Date:   Mon, 11 Nov 2019 14:52:10 +0000
Message-ID: <0de49643-f437-3ef8-e16d-ca57838649d9@virtuozzo.com>
References: <d5faac47-8a8c-90ff-877d-b793b715ac4d@virtuozzo.com>
In-Reply-To: <d5faac47-8a8c-90ff-877d-b793b715ac4d@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P195CA0003.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::13)
 To AM0PR08MB5332.eurprd08.prod.outlook.com (2603:10a6:208:17e::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ptikhomirov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 124139ca-05fe-4055-f3fe-08d766b6bae3
x-ms-traffictypediagnostic: AM0PR08MB3795:
x-microsoft-antispam-prvs: <AM0PR08MB37954EB95A0CE21627827BADB7740@AM0PR08MB3795.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:327;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(136003)(366004)(346002)(376002)(396003)(199004)(189003)(51874003)(316002)(6486002)(54906003)(6436002)(11346002)(76176011)(2906002)(446003)(256004)(36756003)(81156014)(81166006)(8676002)(66066001)(186003)(8936002)(229853002)(99286004)(52116002)(6512007)(6116002)(486006)(6916009)(3846002)(14454004)(5660300002)(66946007)(2616005)(476003)(102836004)(26005)(31696002)(7416002)(66556008)(66476007)(386003)(66446008)(64756008)(478600001)(6246003)(6506007)(86362001)(31686004)(53546011)(305945005)(7736002)(71190400001)(4326008)(25786009)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3795;H:AM0PR08MB5332.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iUq8Yya1JV/LeaGoMre9I0+5ltMXH7UcYAcIFYn56a3SAD61Ch2DZfvJhJXFw4iqHp7kuheYct+mURShdPhW++Ysa3ixp9OS31R2nuv5PLMAHR8IsTg2PqKbhZNG/Y0gPPzuOK27PvpMfnr7iir2LJgmXyl+6I1zPXyBkDs+67Al25/sJ7v//qDn1vuw9Xwj2fBn6diqdsh9OzFmNqCdGMdBddMTmr7YPhnvQicIX6KtJEyLYg6kcwCPbIyJ4hN27oEqoznWyHzoncnFxbQrXqEJZzyba9bM+M3EypMb1LAx6TcjqYsGA6DjWfJIbqc3/D6JVOVKkFWAeld9844ZQVaaCfDIoTS8bTHkShEe5DBCpyrWTR5A1fHO3F/basTRWszEptUj40BCUEoROVL1Vha3tI3gm+dTqwNZ/YUxZWvqg/GNowi0DBQBs7qgEUKP
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD7287C345B2244DADDD4FB42BC85105@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 124139ca-05fe-4055-f3fe-08d766b6bae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 14:52:10.4564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V3MU0zEOAYcQNJeF8+9nIKod0tZpPugIW4Tqd/19Zz6X1pFCBTOFEYYQbHU64II95v8IzRnOeGR1W25yEWp/6OB5bXdhGp4yxdw6PNm/bUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3795
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hyaXN0b3BoLCBhMmI4MDk2NzJlZTYgaXMgeW91ciBwYXRjaCwgbWF5YmUgeW91IGhhdmUgc29t
ZSBpZGVhcyBhYm91dCANCnRoZXNlIHByb2JsZW0/DQoNCnBpbmcNCg0KT24gOC85LzE5IDExOjM5
IEFNLCBQYXZlbCBUaWtob21pcm92IHdyb3RlOg0KPiBIaSwgYWxsLg0KPiANCj4gVGhlbiBwb3J0
aW5nIHBhdGNoZXMgZnJvbSBtYWluc3RyZWFtIEkndmUgZm91bmQgc29tZSBzdHJhbmdlIGNvZGU6
DQo+IA0KPiAgID4gY29tbWl0IGEyYjgwOTY3MmVlNmZjYjRkNTc1NmVhODE1NzI1YjNkYmFlYTY1
NGUNCj4gICA+IEF1dGhvcjogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+ICAgPiBE
YXRlOiAgIFR1ZSBOb3YgMSAwNzo0MDowOSAyMDE2IC0wNjAwDQo+ICAgPg0KPiAgID4gICAgIGJs
b2NrOiByZXBsYWNlIFJFUV9OT0lETEUgd2l0aCBSRVFfSURMRQ0KPiAgID4NCj4gICA+ICAgICBO
b2lkbGUgc2hvdWxkIGJlIHRoZSBkZWZhdWx0IGZvciB3cml0ZXMgYXMgc2VlbiBieSBhbGwgdGhl
IGNvbXBvdW5kcw0KPiAgID4gICAgIGRlZmluaXRpb25zIGluIGZzLmggdXNpbmcgaXQuICBJbiBm
YWN0IG9ubHkgZGlyZWN0IEkvTyByZWFsbHkgc2hvdWxkDQo+ICAgPiAgICAgYmUgdXNpbmcgTk9E
SUxFLCBzbyB0dXJuIHRoZSB3aG9sZSBmbGFnIGFyb3VuZCB0byBnZXQgdGhlIGRlZmF1bHRzDQo+
ICAgPiAgICAgcmlnaHQsIHdoaWNoIHdpbGwgbWFrZSBvdXIgbGlmZSBtdWNoIGVhc2llciBlc3Bl
Y2lhbGx5IG9uY2VzIHRoZQ0KPiAgID4gICAgIFdSSVRFXyogZGVmaW5lcyBnbyBhd2F5Lg0KPiAg
ID4NCj4gICA+ICAgICBUaGlzIGFzc3VtZXMgYWxsIHRoZSBleGlzdGluZyAicmF3IiB1c2VycyBv
ZiBSRVFfU1lOQyBmb3Igd3JpdGVzDQo+ICAgPiAgICAgd2FudCBub2lkbGUgYmVoYXZpb3IsIHdo
aWNoIHNlZW1zIHRvIGJlIHNwb3Qgb24gZnJvbSBhIHF1aWNrIGF1ZGl0Lg0KPiAgID4NCj4gICA+
ICAgICBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gICA+
ICAgICBTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBmYi5jb20+DQo+ICAgPg0KPiAg
ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZnMuaCBiL2luY2x1ZGUvbGludXgvZnMuaA0K
PiAgID4gaW5kZXggY2NlZGNjYjI4ZWM4Li40NmE3NDIwOTkxN2YgMTAwNjQ0DQo+ICAgPiAtLS0g
YS9pbmNsdWRlL2xpbnV4L2ZzLmgNCj4gICA+ICsrKyBiL2luY2x1ZGUvbGludXgvZnMuaA0KPiAg
ID4gQEAgLTE5NywxMSArMTk3LDExIEBAIHR5cGVkZWYgaW50IChkaW9faW9kb25lX3QpKHN0cnVj
dCBraW9jYiAqaW9jYiwNCj4gbG9mZl90IG9mZnNldCwNCj4gICA+ICAjZGVmaW5lIFdSSVRFICAg
ICAgICAgICAgICAgICAgUkVRX09QX1dSSVRFDQo+ICAgPg0KPiAgID4gICNkZWZpbmUgUkVBRF9T
WU5DICAgICAgICAgICAgICAwDQo+ICAgPiAtI2RlZmluZSBXUklURV9TWU5DICAgICAgICAgICAg
IChSRVFfU1lOQyB8IFJFUV9OT0lETEUpDQo+ICAgPiAtI2RlZmluZSBXUklURV9PRElSRUNUICAg
ICAgICAgIFJFUV9TWU5DDQo+ICAgPiAtI2RlZmluZSBXUklURV9GTFVTSCAgICAgICAgICAgIChS
RVFfTk9JRExFIHwgUkVRX1BSRUZMVVNIKQ0KPiAgID4gLSNkZWZpbmUgV1JJVEVfRlVBICAgICAg
ICAgICAgICAoUkVRX05PSURMRSB8IFJFUV9GVUEpDQo+ICAgPiAtI2RlZmluZSBXUklURV9GTFVT
SF9GVUEgICAgICAgICAgICAgICAgKFJFUV9OT0lETEUgfCBSRVFfUFJFRkxVU0ggfA0KPiBSRVFf
RlVBKQ0KPiAgID4gKyNkZWZpbmUgV1JJVEVfU1lOQyAgICAgICAgICAgICBSRVFfU1lOQw0KPiAg
ID4gKyNkZWZpbmUgV1JJVEVfT0RJUkVDVCAgICAgICAgICAoUkVRX1NZTkMgfCBSRVFfSURMRSkN
Cj4gICA+ICsjZGVmaW5lIFdSSVRFX0ZMVVNIICAgICAgICAgICAgUkVRX1BSRUZMVVNIDQo+ICAg
PiArI2RlZmluZSBXUklURV9GVUEgICAgICAgICAgICAgIFJFUV9GVUENCj4gICA+ICsjZGVmaW5l
IFdSSVRFX0ZMVVNIX0ZVQSAgICAgICAgICAgICAgICAoUkVRX1BSRUZMVVNIIHwgUkVRX0ZVQSkN
Cj4gICA+DQo+ICAgPiAgLyoNCj4gICA+ICAgKiBBdHRyaWJ1dGUgZmxhZ3MuICBUaGVzZSBzaG91
bGQgYmUgb3ItZWQgdG9nZXRoZXIgdG8gZmlndXJlIG91dCB3aGF0DQo+IA0KPiBUaGUgYWJvdmUg
Y29tbWl0IGNoYW5nZXMgdGhlIG1lYW5pbmcgb2YgdGhlIFJFUV9TWU5DIGZsYWcsIGJlZm9yZSB0
aGUNCj4gcGF0Y2ggaXQgd2FzIGVxdWFsIHRvIFdSSVRFX09ESVJFQ1QgYW5kIGFmdGVyIHRoZSBw
YXRjaCBpdCBpcyBlcXVhbCB0bw0KPiBXUklURV9TWU5DLiBBbmQgdGh1cyBJIHRoaW5rIGl0IGJl
Y2FtZSB0cmVhdGVkIGRpZmZlcmVudGx5IChJIHNlZSBvbmx5DQo+IG9uZSBwbGFjZSBsZWZ0IGlu
IHdidF9zaG91bGRfdGhyb3R0bGUuKS4NCj4gDQo+IEJ1dCBpbiBfX3N3YXBfd3JpdGVwYWdlKCkg
Ym90aCBiZWZvcmUgYW5kIGFmdGVyIHRoZSBtZW50aW9uZWQgcGF0Y2ggd2UNCj4gc3RpbGwgcGFz
cyBhIHNpbmdsZSBSRVFfU1lOQyB3aXRob3V0IGFueSBSRVFfSURMRS9SRVFfVU5JRExFOg0KPiAN
Cj4gICA+IFtzbm9yY2hAc25vcmNoIGxpbnV4XSQgZ2l0IGJsYW1lDQo+IGEyYjgwOTY3MmVlNmZj
YjRkNTc1NmVhODE1NzI1YjNkYmFlYTY1NGVeIG1tL3BhZ2VfaW8uYyB8IGdyZXAgLWE1IFJFUV9T
WU5DDQo+ICAgPiBeMWRhMTc3ZTRjM2Y0IChMaW51cyBUb3J2YWxkcyAgICAgICAgMjAwNS0wNC0x
NiAxNToyMDozNiAtMDcwMCAzMTkpDQo+ICAgICAgICAgICB1bmxvY2tfcGFnZShwYWdlKTsNCj4g
ICA+IF4xZGExNzdlNGMzZjQgKExpbnVzIFRvcnZhbGRzICAgICAgICAyMDA1LTA0LTE2IDE1OjIw
OjM2IC0wNzAwIDMyMCkNCj4gICAgICAgICAgIHJldCA9IC1FTk9NRU07DQo+ICAgPiBeMWRhMTc3
ZTRjM2Y0IChMaW51cyBUb3J2YWxkcyAgICAgICAgMjAwNS0wNC0xNiAxNToyMDozNiAtMDcwMCAz
MjEpDQo+ICAgICAgICAgICBnb3RvIG91dDsNCj4gICA+IF4xZGExNzdlNGMzZjQgKExpbnVzIFRv
cnZhbGRzICAgICAgICAyMDA1LTA0LTE2IDE1OjIwOjM2IC0wNzAwIDMyMikgICB9DQo+ICAgPiBe
MWRhMTc3ZTRjM2Y0IChMaW51cyBUb3J2YWxkcyAgICAgICAgMjAwNS0wNC0xNiAxNToyMDozNiAt
MDcwMCAzMjMpDQo+IGlmICh3YmMtPnN5bmNfbW9kZSA9PSBXQl9TWU5DX0FMTCkNCj4gICA+IGJh
MTNlODNlYzMzNGMgKEplbnMgQXhib2UgICAgICAgICAgICAyMDE2LTA4LTAxIDA5OjM4OjQ0IC0w
NjAwIDMyNCkNCj4gICAgICAgICAgIGJpb19zZXRfb3BfYXR0cnMoYmlvLCBSRVFfT1BfV1JJVEUs
IFJFUV9TWU5DKTsNCj4gICA+IGJhMTNlODNlYzMzNGMgKEplbnMgQXhib2UgICAgICAgICAgICAy
MDE2LTA4LTAxIDA5OjM4OjQ0IC0wNjAwIDMyNSkNCj4gZWxzZQ0KPiAgID4gYmExM2U4M2VjMzM0
YyAoSmVucyBBeGJvZSAgICAgICAgICAgIDIwMTYtMDgtMDEgMDk6Mzg6NDQgLTA2MDAgMzI2KQ0K
PiAgICAgICAgICAgYmlvX3NldF9vcF9hdHRycyhiaW8sIFJFUV9PUF9XUklURSwgMCk7DQo+ICAg
PiBmODg5MWU1ZTFmOTNhIChDaHJpc3RvcGggTGFtZXRlciAgICAgMjAwNi0wNi0zMCAwMTo1NTo0
NSAtMDcwMCAzMjcpDQo+IGNvdW50X3ZtX2V2ZW50KFBTV1BPVVQpOw0KPiAgID4gXjFkYTE3N2U0
YzNmNCAoTGludXMgVG9ydmFsZHMgICAgICAgIDIwMDUtMDQtMTYgMTU6MjA6MzYgLTA3MDAgMzI4
KQ0KPiBzZXRfcGFnZV93cml0ZWJhY2socGFnZSk7DQo+ICAgPiBeMWRhMTc3ZTRjM2Y0IChMaW51
cyBUb3J2YWxkcyAgICAgICAgMjAwNS0wNC0xNiAxNToyMDozNiAtMDcwMCAzMjkpDQo+IHVubG9j
a19wYWdlKHBhZ2UpOw0KPiAgID4gW3Nub3JjaEBzbm9yY2ggbGludXhdJCBnaXQgYmxhbWUNCj4g
YTJiODA5NjcyZWU2ZmNiNGQ1NzU2ZWE4MTU3MjViM2RiYWVhNjU0ZSBtbS9wYWdlX2lvLmMgfCBn
cmVwIC1hNSBSRVFfU1lOQw0KPiAgID4gXjFkYTE3N2U0YzNmNCAoTGludXMgVG9ydmFsZHMgICAg
ICAgIDIwMDUtMDQtMTYgMTU6MjA6MzYgLTA3MDAgMzE5KQ0KPiAgICAgICAgICAgdW5sb2NrX3Bh
Z2UocGFnZSk7DQo+ICAgPiBeMWRhMTc3ZTRjM2Y0IChMaW51cyBUb3J2YWxkcyAgICAgICAgMjAw
NS0wNC0xNiAxNToyMDozNiAtMDcwMCAzMjApDQo+ICAgICAgICAgICByZXQgPSAtRU5PTUVNOw0K
PiAgID4gXjFkYTE3N2U0YzNmNCAoTGludXMgVG9ydmFsZHMgICAgICAgIDIwMDUtMDQtMTYgMTU6
MjA6MzYgLTA3MDAgMzIxKQ0KPiAgICAgICAgICAgZ290byBvdXQ7DQo+ICAgPiBeMWRhMTc3ZTRj
M2Y0IChMaW51cyBUb3J2YWxkcyAgICAgICAgMjAwNS0wNC0xNiAxNToyMDozNiAtMDcwMCAzMjIp
ICAgfQ0KPiAgID4gXjFkYTE3N2U0YzNmNCAoTGludXMgVG9ydmFsZHMgICAgICAgIDIwMDUtMDQt
MTYgMTU6MjA6MzYgLTA3MDAgMzIzKQ0KPiBpZiAod2JjLT5zeW5jX21vZGUgPT0gV0JfU1lOQ19B
TEwpDQo+ICAgPiBiYTEzZTgzZWMzMzRjIChKZW5zIEF4Ym9lICAgICAgICAgICAgMjAxNi0wOC0w
MSAwOTozODo0NCAtMDYwMCAzMjQpDQo+ICAgICAgICAgICBiaW9fc2V0X29wX2F0dHJzKGJpbywg
UkVRX09QX1dSSVRFLCBSRVFfU1lOQyk7DQo+ICAgPiBiYTEzZTgzZWMzMzRjIChKZW5zIEF4Ym9l
ICAgICAgICAgICAgMjAxNi0wOC0wMSAwOTozODo0NCAtMDYwMCAzMjUpDQo+IGVsc2UNCj4gICA+
IGJhMTNlODNlYzMzNGMgKEplbnMgQXhib2UgICAgICAgICAgICAyMDE2LTA4LTAxIDA5OjM4OjQ0
IC0wNjAwIDMyNikNCj4gICAgICAgICAgIGJpb19zZXRfb3BfYXR0cnMoYmlvLCBSRVFfT1BfV1JJ
VEUsIDApOw0KPiAgID4gZjg4OTFlNWUxZjkzYSAoQ2hyaXN0b3BoIExhbWV0ZXIgICAgIDIwMDYt
MDYtMzAgMDE6NTU6NDUgLTA3MDAgMzI3KQ0KPiBjb3VudF92bV9ldmVudChQU1dQT1VUKTsNCj4g
ICA+IF4xZGExNzdlNGMzZjQgKExpbnVzIFRvcnZhbGRzICAgICAgICAyMDA1LTA0LTE2IDE1OjIw
OjM2IC0wNzAwIDMyOCkNCj4gc2V0X3BhZ2Vfd3JpdGViYWNrKHBhZ2UpOw0KPiAgID4gXjFkYTE3
N2U0YzNmNCAoTGludXMgVG9ydmFsZHMgICAgICAgIDIwMDUtMDQtMTYgMTU6MjA6MzYgLTA3MDAg
MzI5KQ0KPiB1bmxvY2tfcGFnZShwYWdlKTsNCj4gDQo+IEl0IGxvb2tzIGxpa2Ugd2UndmUgY2hh
bmdlZCB0aGUgd2F5IGhvdyB3ZSBoYW5kbGUgc3dhcCBwYWdlIHdyaXRlcyBmcm9tDQo+ICJvZGly
ZWN0IiB3YXkgdG8gInJlZ3VsYXIiIHN5bmMgd3JpdGUgd2F5LCB0aGVzZSBjYW4gYmUgd3Jvbmcu
IFRoaXMgbWF5DQo+IGFsc28gYWZmZWN0IGRlcHJlY2F0ZWQgY2ZxIGlvLXNjaGVkdWxlciBvbiBv
bGRlciBrZXJuZWxzLg0KPiANCj4gVGhhbmtzIGluIGFkdmFuY2UgZm9yIGFueSBhZHZpY2Ugb24g
d2hhdCB0byBkbyB3aXRoIHRoZXNlLCBtYXkgYmUgSSBtaXNzDQo+IHNvbWV0aGluZy4NCj4gDQoN
Ci0tIA0KQmVzdCByZWdhcmRzLCBUaWtob21pcm92IFBhdmVsDQpTb2Z0d2FyZSBEZXZlbG9wZXIs
IFZpcnR1b3p6by4NCg==
