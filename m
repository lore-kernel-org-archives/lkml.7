Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F532C282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 20:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD3C20896
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 20:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=uwy.onmicrosoft.com header.i=@uwy.onmicrosoft.com header.b="CQBvns6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfDGU6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 16:58:16 -0400
Received: from mail-eopbgr680138.outbound.protection.outlook.com ([40.107.68.138]:37573
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726366AbfDGU6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 16:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uwy.onmicrosoft.com;
 s=selector1-uwyo-edu;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtP60vdhK6aiGW39fe9JfsXhAiRV9WmnxPD1yQdQD20=;
 b=CQBvns6gmId88WTCzYA7IwhYSPA+eqMIuQZwx7iH25TRYMgWlJ+RuzkjB5/RauuTnEfidiBLkfhNSq55OkdpSJJMI80tpY4EdN1VXumRbYLOd7KdbI1yXwipOsI2TZzxuVEwHL7R2MvnVb+q/wVYzpwMm6K/EaLuezLtjJ6bimU=
Received: from DM6PR05MB5259.namprd05.prod.outlook.com (20.177.223.223) by
 DM6PR05MB5628.namprd05.prod.outlook.com (20.176.123.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.11; Sun, 7 Apr 2019 20:58:12 +0000
Received: from DM6PR05MB5259.namprd05.prod.outlook.com
 ([fe80::ed6e:ffe4:83a:29c7]) by DM6PR05MB5259.namprd05.prod.outlook.com
 ([fe80::ed6e:ffe4:83a:29c7%4]) with mapi id 15.20.1792.007; Sun, 7 Apr 2019
 20:58:12 +0000
From:   "Robert R. Howell" <RHowell@uwyo.edu>
To:     Hans de Goede <hdegoede@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
Thread-Topic: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
Thread-Index: AQHU6eBClqunF/byekqefGejWfaC+aYqIfOAgAcThIA=
Date:   Sun, 7 Apr 2019 20:58:12 +0000
Message-ID: <b6cd67d7-a4de-0fab-4512-25d732190d17@uwyo.edu>
References: <20190403054352.30120-1-kai.heng.feng@canonical.com>
 <eb1462c9-ebef-7bd6-c263-3f4f2e8ba63d@redhat.com>
In-Reply-To: <eb1462c9-ebef-7bd6-c263-3f4f2e8ba63d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-originating-ip: [208.45.14.217]
x-clientproxiedby: SN6PR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:805:a2::49) To DM6PR05MB5259.namprd05.prod.outlook.com
 (2603:10b6:5:7f::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RHowell@uwyo.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c3163c1-e24e-4479-b0e6-08d6bb9bbf07
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:DM6PR05MB5628;
x-ms-traffictypediagnostic: DM6PR05MB5628:
x-microsoft-antispam-prvs: <DM6PR05MB56282487583495AF18D830C9D3530@DM6PR05MB5628.namprd05.prod.outlook.com>
x-forefront-prvs: 00003DBFE7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(39850400004)(376002)(346002)(199004)(189003)(36756003)(26005)(2616005)(305945005)(2501003)(256004)(14444005)(7736002)(99286004)(476003)(72206003)(6246003)(31686004)(64126003)(6436002)(110136005)(53936002)(54906003)(14454004)(3846002)(106356001)(105586002)(2906002)(186003)(6116002)(446003)(6512007)(58126008)(11346002)(76176011)(786003)(386003)(53546011)(486006)(6486002)(97736004)(75432002)(80792005)(88552002)(8936002)(8676002)(478600001)(71200400001)(71190400001)(81156014)(81166006)(68736007)(4326008)(86362001)(316002)(229853002)(102836004)(25786009)(65826007)(31696002)(52116002)(66066001)(5660300002)(65956001)(6506007)(65806001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR05MB5628;H:DM6PR05MB5259.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: uwyo.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wbVGcfMx/EUZoqo7MZlOVteMtCHxVlX8v5BREOxoh9a8981iWIoycfzb1D/Rn5mdv8WNt4GnFmCplnxTnidnmuEyQRuxgXiCa4jdU0NLXBicULiT0oaLyJWjjOSeejuwk1bypCNBZyU/6DhiSGZlf9thspP2fqhhrSAE8eMw3No+/dx/AVUEY6saBP1+rTCqQ5WXpqs7EO5m6GFmnYuy9jGAhpYrLATRqRZAtGVHpl4KXxYYvJgvDffELJ8Nws/Om7Zy0AhVHxeCu5Vs2wTX4Wn9pZ9yUpgDcOwDYe88dGi7xjmhSeHT8OguoHLnYhJdpmHmAjvA4GPeMdAjPMnIKSbFUevtLfBXnbdIyuuCy+nm8bDNyRS4cmzLQVFjk2uAPHNZ/ayppp+za/dSIFWpMw32bumwWN3fFcQWup7VG6A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <080B9BC2A68AD44EADDB85C6560230C2@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: uwyo.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3163c1-e24e-4479-b0e6-08d6bb9bbf07
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2019 20:58:12.2713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f9cdd7ad-825d-4601-8e9c-a325e02d52da
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB5628
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8zLzE5IDI6NTQgQU0sIEhhbnMgZGUgR29lZGUgd3JvdGU6DQoNCj4gDQo+IEhpLA0KPiAN
Cj4gT24gMDMtMDQtMTkgMDc6NDMsIEthaS1IZW5nIEZlbmcgd3JvdGU6DQo+PiBpMmMtZGVzaWdu
d2FyZS1wbGF0ZHJ2IGZhaWxzIHRvIHdvcmsgYWZ0ZXIgdGhlIHN5c3RlbSByZXN0b3JlZCBmcm9t
DQo+PiBoaWJlcm5hdGlvbjoNCj4+IFsgMjcyLjc3NTY5Ml0gaTJjX2Rlc2lnbndhcmUgODA4NjBG
NDE6MDA6IFVua25vd24gU3lub3BzeXMgY29tcG9uZW50IHR5cGU6IDB4ZmZmZmZmZmYNCj4+DQo+
PiBDb21taXQgNDg0MDJjZWU2ODg5ICgiQUNQSSAvIExQU1M6IFJlc3VtZSBCWVQvQ0hUIEkyQyBj
b250cm9sbGVycyBmcm9tDQo+PiByZXN1bWVfbm9pcnEiKSBtYWtlcyBhY3BpX2xwc3Nfe3N1c3Bl
bmRfbGF0ZSxyZXN1bWVfZWFybHl9KCkgYmFpbCBlYXJseQ0KPj4gb24gQllUL0NIVCBhcyByZXN1
bWVfZnJvbV9ub2lycSBpcyBzZXQuIFRoaXMgbWVhbnMgZHdfaTJjX3BsYXRfcmVzdW1lKCkNCj4+
IGRvZXNuJ3QgZ2V0cyBjYWxsZWQgYnkgYWNwaV9scHNzX3Jlc3VtZV9lYXJseSgpLCBhbmQgdGhp
cyBjYXVzZXMgdGhlDQo+PiBpc3N1ZS4NCj4+DQouLi4NCj4gDQo+IFRoZSBvcmRlcmluZyBwcm9i
bGVtIGZpeGVkIGJ5IGNvbW1pdCA0ODQwMmNlZTY4ODkgY2FuIGhpdCBoaWJlcm5hdGUgdG9vLA0K
PiBzbyBJIHRoaW5rIGl0IHdvdWxkIGJlIGJldHRlciB0byBkbyB0aGlzIGluc3RlYWQgdG8gZml4
IHRoaXMgcHJvYmxlbToNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYWNwaV9scHNz
LmMgYi9kcml2ZXJzL2FjcGkvYWNwaV9scHNzLmMNCj4gaW5kZXggMWUyYTEwYTA2YjlkLi5jZjc2
ODYwODQzN2UgMTAwNjQ0DQouLi4NCj4gSWYgcGVvcGxlIGFmZmVjdGVkIGJ5IHRoZSBwcm9ibGVt
IGNhbiBnaXZlIG15IHZlcnNpb24gb2YgdGhlIGZpeCBhIHRlc3QsDQo+IHRoZW4gdGhhdCB3b3Vs
ZCBiZSBncmVhdC4NCj4gDQo+IFJlZ2FyZHMsDQo+IA0KPiBIYW5zDQoNCkkgZGlkIHRyeSBhcHBs
eWluZyB5b3VyIChIYW5zJykgcGF0Y2ggdG8gYSA1LjAuMCBhbmQgYSA1LjEtcmMzIGtlcm5lbCwg
aW5zdGVhZCBvZiB3aGF0IEkgaGFkIA0KYmVlbiBkb2luZyBwcmV2aW91c2x5LCB3aGljaCB3YXMg
cmV2ZXJ0aW5nIGNvbW1pdCAwMmU0NTY0NmQ1M2IuICBJIHRlc3RlZCBpdCBvbiBhbiBBU1VTIFQx
MDBUQSANCmFuZCB1bmZvcnR1bmF0ZWx5IHdpdGggYm90aCBrZXJuZWxzIGFmdGVyIHJlc3VtZSBm
cm9tIGhpYmVybmF0aW9uIEkgc3RpbGwgZ2V0IGVycm9ycyBsaWtlIHRob3NlIA0KbGlzdGVkIGJl
bG93LCBhbmQgc291bmQgbm8gbG9uZ2VyIHdvcmtzLiAgSSBhbHNvIHRyaWVkIGFwcGx5aW5nIHRo
ZSBwYXRjaCBmcm9tIEthaS1IZW5nIEZlbmcgDQooaW5zdGVhZCBvZiBIYW5zJyBwYXRjaCBvciBt
eSByZXZlcnQpIG9uIGJvdGgga2VybmVscyBhbmQgYWdhaW4gaW4gYm90aCBjYXNlcyBJIGdldCB0
aGVzZSBzYW1lIGVycm9ycy4NCg0KSW4gY29udHJhc3QsIG9uIHRoZSA1LjAuMCBrZXJuZWwgd2hl
biBJIHJldmVydCAwMmU0NTY0NmQ1M2IsIHRoZSBwcm9ibGVtIGlzIGZpeGVkLiAgQmVjYXVzZSAN
Cm9mIGNoYW5nZXMgaW4gYWRqYWNlbnQgY29kZSBpbiA1LjEtcmMzLCBJIGhhdmVuJ3QgeWV0IGZv
dW5kIGEgd2F5IHRvIG1lcmdlIHRoZSBuZXcgY29kZSANCmFuZCB0aGUgMDJlNDU2NDZkNTNiIHJl
dmVydCB3aXRob3V0IGNhdXNpbmcgd29yc2UgcHJvYmxlbXMuIEJ1dCB0aGF0J3MgcHJvYmFibHkg
YmVjYXVzZSANCkkgZG9uJ3QgcmVhbGx5IHVuZGVyc3RhbmQgdGhlIGRldGFpbHMgb2YgdGhhdCBj
b2RlLg0KDQpbICAxMjAuNjkwNDI4XSBpMmNfZGVzaWdud2FyZSA4MDg2MEY0MTowMTogdGltZW91
dCB3YWl0aW5nIGZvciBidXMgcmVhZHkNClsgIDEyMC42OTA0NDJdIHJ0NTY0MCBpMmMtMTBFQzU2
NDA6MDA6IEZhaWxlZCB0byB3cml0ZSAxM2QgPSAzNjAwOiAtMTEwDQpbICAxMjAuNzEyODYwXSBp
MmNfZGVzaWdud2FyZSA4MDg2MEY0MTowMTogdGltZW91dCB3YWl0aW5nIGZvciBidXMgcmVhZHkN
ClsgIDEyMC43MzczODldIGkyY19kZXNpZ253YXJlIDgwODYwRjQxOjAxOiB0aW1lb3V0IHdhaXRp
bmcgZm9yIGJ1cyByZWFkeQ0KWyAgMTIwLjc1OTY1N10gaTJjX2Rlc2lnbndhcmUgODA4NjBGNDE6
MDE6IHRpbWVvdXQgd2FpdGluZyBmb3IgYnVzIHJlYWR5DQpbICAxMjAuNzgxNzk3XSBpMmNfZGVz
aWdud2FyZSA4MDg2MEY0MTowMTogdGltZW91dCB3YWl0aW5nIGZvciBidXMgcmVhZHkNClsgIDEy
MC44MDQxNTNdIGkyY19kZXNpZ253YXJlIDgwODYwRjQxOjAxOiB0aW1lb3V0IHdhaXRpbmcgZm9y
IGJ1cyByZWFkeQ0KWyAgMTIwLjgyNjQ2N10gaTJjX2Rlc2lnbndhcmUgODA4NjBGNDE6MDE6IHRp
bWVvdXQgd2FpdGluZyBmb3IgYnVzIHJlYWR5DQpbICAxMjEuOTY1ODg2XSBpMmNfZGVzaWdud2Fy
ZSA4MDg2MEY0MTowMTogdGltZW91dCBpbiBkaXNhYmxpbmcgYWRhcHRlcg0KLi4uLi4NClsgIDEz
Mi43ODI2MzRdIGkyY19kZXNpZ253YXJlIDgwODYwRjQxOjAxOiBjb250cm9sbGVyIHRpbWVkIG91
dA0KWyAgMTMzLjgwNjUzOF0gaTJjX2Rlc2lnbndhcmUgODA4NjBGNDE6MDE6IGNvbnRyb2xsZXIg
dGltZWQgb3V0DQpbICAxMzQuODMwOTkxXSBpMmNfZGVzaWdud2FyZSA4MDg2MEY0MTowMTogY29u
dHJvbGxlciB0aW1lZCBvdXQNClsgIDEzNS44NTUxODNdIGkyY19kZXNpZ253YXJlIDgwODYwRjQx
OjAxOiBjb250cm9sbGVyIHRpbWVkIG91dA0KDQpMZXQgbWUga25vdyBpZiBJIGNhbiBkbyBhbnkg
b3RoZXIgdGVzdGluZyB0byBoZWxwLg0KDQpCb2IgSG93ZWxsDQoNCg==
