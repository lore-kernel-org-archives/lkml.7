Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PI_IMPORTANCE_HIGH,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8417CC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436E721880
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="YFX1qfbC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfGZTX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:23:58 -0400
Received: from mail-eopbgr740082.outbound.protection.outlook.com ([40.107.74.82]:9296
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbfGZTX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:23:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gk+tnftBboOIh2PZHNqLEz57tJLpZ+CJuU4fcXMW+Ic7UmXpv/j50jRCoX8cqS/XOMWo2Il6+9Z1PmKDAHYyQ4PdHAMgAdPjfukS9He8kxN1iVusJ3cQIBJgo/DOp5hfrHqmxJ1jidolOxvnjxGzhqIvD/0SwyOo4Udv2nL8/yyZzu1+b1yvgKdwhBY9iNTTuFFm0scjmWlHiUFHEegVTdgnvtDovSYSztaqKIbBMGT5ag1ImbivEXUgo02vka5kuFw/rZYuUqSTi/PI1wVTFBEkE04a+SrKLQ/RyzDdi+ivAvgTvATHvw1QHCWXeYD73fYXi0DukYLeouChcK4ZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=os+zMRpBOrKbtBMcluQuz2CqADICRmeDPVmw7qj86Xg=;
 b=EFr3xA1tkXT8Qcw4emvt/fToCCXJQzLHEGIk5ncydBlt1Y45yKukagywWYX76BD/1ef2xxhgu5yhYbVrKpQDZM+dsYPFXcbH2KRgyBaUvq6ftt0ypXoGZ0E0RAwuK1pBsPNydxHw0VnzUDOH3ShVzShA7jRAV0aMmDNKsseeTqwVQl7hSwSM/jwkeYKISVyaSckEgPcwcxsRzlJH5lmAn6gB4+j3ZkcYJz3UPB2e2eJFDlE9jWcq7o4TdfD+9zUn30irFV4/0NTUDnFipISV+NGbhmowqETHh21O6hieuOzhe3TlAk4iSEGA1/YuZvH5OIobideCy+tvqeDiVukZzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=os+zMRpBOrKbtBMcluQuz2CqADICRmeDPVmw7qj86Xg=;
 b=YFX1qfbCde5JI0ZPn7iSutWM+bb2GiIs2Aax+BvD7EQNdqw7bx0ZDzqoteumOT9ydNPuV1E54YpueJVZJWaJQhqc+gorrm25kGC5QeMV1kPeT0EtnIfZRzZoIzVISGW5Gv5GqLAiZioykZesyCqzLn0wWG7cUIqLpfuomhS2PFE=
Received: from CY4PR05MB3494.namprd05.prod.outlook.com (10.171.246.163) by
 CY4PR05MB3672.namprd05.prod.outlook.com (10.171.249.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 26 Jul 2019 19:23:15 +0000
Received: from CY4PR05MB3494.namprd05.prod.outlook.com
 ([fe80::84f3:3266:347a:26bf]) by CY4PR05MB3494.namprd05.prod.outlook.com
 ([fe80::84f3:3266:347a:26bf%4]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 19:23:15 +0000
From:   Matt Helsley <mhelsley@vmware.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 04/13] recordmcount: Rewrite error/success handling
Thread-Topic: [PATCH v3 04/13] recordmcount: Rewrite error/success handling
Thread-Index: AQHVQmOIZ4Qum/C9LEe1t5ZS+gGHcKbdLwWAgAAOeACAAAGtAIAACzOA
Importance: high
X-Priority: 1
Date:   Fri, 26 Jul 2019 19:23:15 +0000
Message-ID: <B522B4E8-B107-4763-AA39-FA71A193C02C@vmware.com>
References: <cover.1563992889.git.mhelsley@vmware.com>
 <316706a0e2727af0a2639b8e90366746d7a3a84a.1563992889.git.mhelsley@vmware.com>
 <20190726134523.4e7afd55@gandalf.local.home>
 <4F0912A7-345E-46EE-B58F-CF7E8EE2AB65@vmware.com>
 <20190726144310.5c62925b@gandalf.local.home>
In-Reply-To: <20190726144310.5c62925b@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mhelsley@vmware.com; 
x-originating-ip: [73.25.163.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99ccbf2d-cd19-4700-cadd-08d711feb565
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR05MB3672;
x-ms-traffictypediagnostic: CY4PR05MB3672:
x-microsoft-antispam-prvs: <CY4PR05MB367222CD80BAD75417A334E9A0C00@CY4PR05MB3672.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(199004)(189003)(25786009)(66476007)(3846002)(8936002)(68736007)(76116006)(6116002)(14454004)(229853002)(256004)(66446008)(64756008)(66556008)(478600001)(66066001)(476003)(11346002)(486006)(66946007)(6246003)(2616005)(305945005)(99286004)(76176011)(6486002)(316002)(186003)(6512007)(81156014)(81166006)(36756003)(446003)(6916009)(6436002)(8676002)(53936002)(33656002)(81686011)(71190400001)(71200400001)(4326008)(102836004)(91956017)(5660300002)(7736002)(53546011)(86362001)(6506007)(54906003)(26005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR05MB3672;H:CY4PR05MB3494.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pgqGPhYp7OZ/kvhOkDFZUge1YwqiFHr1RIWsZZAGKWinyghnbjO884jjSWsne/hKNz1w610cHWDw0Q1/c5HZO7v5uYf+Znrtrdg4Ec2B1jYFagJ036FBehl4HSUnbkW3za1Ul+YFF8s+pgQW5+Ml9ix1jAYj4YWZbj8poyhifkTXQMM1QXv/3spmmFraNblfKw9F8wgwULcJbGPMMFmUxsCRm5IlYmxY1iBkat4JIC3P9sQH9xPN5qZsl+fE2st9b9OkB+fxZ9u6Sj7lyT201uZLMqG/mOV1GgAk2G/W6dDmWGCxeQrEigxYjFAOAC6iiYe1GWP7iSYq7NamyvhXUNslJO/fa9Z1HEtnsZyMudBQEvLMpPNZhFt7++2BBpAlPVLOmF7n/1AOSA23jgH496XH+JUu6MTqV/K8yP0vwL4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B099C55CD099C4D8AC3BA528521EFEE@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ccbf2d-cd19-4700-cadd-08d711feb565
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 19:23:15.7767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhelsley@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR05MB3672
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gSnVsIDI2LCAyMDE5LCBhdCAxMTo0MyBBTSwgU3RldmVuIFJvc3RlZHQgPHJvc3Rl
ZHRAZ29vZG1pcy5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJpLCAyNiBKdWwgMjAxOSAxODozNzox
MSArMDAwMA0KPiBNYXR0IEhlbHNsZXkgPG1oZWxzbGV5QHZtd2FyZS5jb20+IHdyb3RlOg0KPiAN
Cj4+Pj4gZGlmZiAtLWdpdCBhL3NjcmlwdHMvcmVjb3JkbWNvdW50LmggYi9zY3JpcHRzL3JlY29y
ZG1jb3VudC5oDQo+Pj4+IGluZGV4IGMxZTFiMDRiNDg3MS4uOTA5YTNlNDc3NWMyIDEwMDY0NA0K
Pj4+PiAtLS0gYS9zY3JpcHRzL3JlY29yZG1jb3VudC5oDQo+Pj4+ICsrKyBiL3NjcmlwdHMvcmVj
b3JkbWNvdW50LmgNCj4+Pj4gQEAgLTI0LDcgKzI0LDkgQEANCj4+Pj4gI3VuZGVmIG1jb3VudF9h
ZGp1c3QNCj4+Pj4gI3VuZGVmIHNpZnRfcmVsX21jb3VudA0KPj4+PiAjdW5kZWYgbm9wX21jb3Vu
dA0KPj4+PiArI3VuZGVmIG1pc3Npbmdfc3ltDQo+Pj4+ICN1bmRlZiBmaW5kX3NlY3N5bV9uZHgN
Cj4+Pj4gKyN1bmRlZiBhbHJlYWR5X2hhc19yZWxfbWNvdW50ICANCj4+PiANCj4+PiBXaHkgZG8g
d2UgbmVlZCB0aGVzZSBhcyBkZWZpbmVzPyBDYW4ndCB5b3UganVzdCBoYXZlIGEgc2luZ2xlOg0K
Pj4+IA0KPj4+IGNvbnN0IGNoYXIgKmFscmVhZHlfaGFzX21jb3VudCA9ICJzdWNjZXNzIjsNCj4+
PiANCj4+PiBpbiByZWNvcmRtY291bnQuYyBiZWZvcmUgcmVjb3JkbWNvdW50LmggaXMgaW5jbHVk
ZWQ/DQo+Pj4gDQo+Pj4gQW5kIHNhbWUgZm9yIG1pc3Npbmdfc3ltLiAgDQo+PiANCj4+IFllcywg
dGhhdOKAmXMgYSBnb29kIHBvaW50LiBJ4oCZdmUgYmVlbiB0cnlpbmcgdG8gc2VwYXJhdGUgdGhl
IGNoYW5nZXMgdG8NCj4+IHRoZSBmdW5jdGlvbnMgZnJvbSBtb3ZpbmcgcGFydHMgb3V0IGJ1dCBp
biB0aGlzIGNhc2UgaXQgd291bGQgbWFrZQ0KPj4ganVzdCBhcyBtdWNoIHNlbnNlIHRvIGFkZCB0
aGVtIHRvIHJlY29yZG1jb3VudC5jIGluIHRoZSBmaXJzdCBwbGFjZS4NCj4+IA0KPj4gVWx0aW1h
dGVseSwgdGhpcyB1Z2xpbmVzcyBnZXRzIHJlbW92ZWQgYXMgdGhlIG5leHQgc2VyaWVzIHJlbW92
ZXMNCj4+IHJlY29yZG1jb3VudC5oIGVudGlyZWx5IGFuZCBvbmUgb2YgdGhlIHN0ZXBzIGlzIG1v
dmluZw0KPj4gZmluZF9zZWNzeW1fbmR4KCkgb3V0IHdoaWxlIGVsaW1pbmF0aW5nIHRoZXNlIHJl
ZHVuZGFudCBwaWVjZXMuDQo+IA0KPiBZZWFoLCB0aGlzIGNvZGUgd2lsbCBiZSBjbGVhbmVkIHVw
IGxhdGVyLCBidXQgbGV0J3MgaGF2ZSB0aGUgc3RlcHMgaW4NCj4gYmV0d2VlbiBsb29rIGZpbmUg
YXMgd2VsbC4NCg0KTWFrZXMgc2Vuc2UuDQoNCj4gDQo+IA0KPj4gDQo+Pj4gDQo+Pj4gQW5vdGhl
ciwgcHJvYmFibHkgbW9yZSByb2J1c3Qgd2F5IG9mIGRvaW5nIHRoaXMsIGlzIGNoYW5nZQ0KPj4+
IGZpbmRfc2Vjc3ltX25keCgpIHRvIHJldHVybiAwIG9uIHN1Y2Nlc3MgYW5kIC0xIG9uIG1pc3Np
bmcgc3ltYm9sLA0KPj4+IGFuZCBqdXN0IHBhc3MgYSBwb2ludGVyIGJ5IHJlZmVyZW5jZSB0byBm
aWxsIHRoZSByZWNzeW0gKHdoaWNoDQo+Pj4gZG9lc24ndCBoYXZlIHRvIGJlIGEgY29uc3RhbnQp
LiAgDQo+PiANCj4+IFRoYXTigJlzIGVhc3kgZW5vdWdoIHRvIGRvICBhbmQgIEkgZG8gbGlrZSBz
ZXBhcmF0aW5nIHRoZSBlcnJvci9zdWNjZXNzDQo+PiByZXR1cm4gZnJvbSByZXR1cm5pbmcgIHRo
ZSBpbmRleC4gSSBjYW4gc2VuZCB0aGF0IG91dCBub3cgb3IgdGFjayBpdA0KPj4gb250byB0aGUg
bmV4dCBSRkMgc2VyaWVzIEnigJltIGFib3V0IHRvIHNlbmQgd2hpY2ggY29tcGxldGVzIHRoZQ0K
Pj4gY29udmVyc2lvbiBpZiB0aGF04oCZcyBwcmVmZXJhYmxlLg0KPj4gDQo+PiBZZWFoLCB0aGUg
b3JpZ2luYWwgY29kZSBhcHBsaWVzIOKAnGNvbnN04oCdIGluIGxvdHMgb2YgcGxhY2VzIC0tIEkN
Cj4+IHByZXN1bWUgaXTigJlzIGFuIGF0dGVtcHQgdG8gZWVrIG91dCBldmVyeSBsYXN0IGJpdCBv
ZiBwZXJmb3JtYW5jZSBmcm9tDQo+PiB0aGUgY29tcGlsZXIuDQo+IA0KPiBBcyBJIHNhaWQgYmVm
b3JlLCBJJ3ZlIGFwcGxpZWQgcGF0Y2hlcyAxLTMsIHNvIHlvdSBkb24ndCBuZWVkIHRvIHJlc2Vu
ZA0KPiB0aGVtLiBJIGZpbmlzaGVkIGxvb2tpbmcgYXQgdGhlIHJlc3QsIGFuZCBvbmx5IHRoaXMg
cGF0Y2ggbmVlZHMgdG8gYmUNCj4gZml4ZWQsIGFuZCBzaW5jZSB5b3UgYXJlIHJlc2VuZGluZywg
Y291bGQgeW91IGZpeCB0aGUgInVwc2lkZS1kb3duDQo+IHgtbWFzIiB0cmVlIGRlY2xhcmF0aW9u
IEkgbWVudGlvbmVkIGluIHBhdGNoIDguDQoNCldpbGwgZG8uDQoNCkNoZWVycywNCiAgICAgIC1N
YXR0
