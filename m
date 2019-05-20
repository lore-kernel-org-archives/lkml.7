Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579D2C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242A320645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oeaNask4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387590AbfETMRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:17:35 -0400
Received: from mail-eopbgr780085.outbound.protection.outlook.com ([40.107.78.85]:2080
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387523AbfETMRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCj7GbY19CLBrglx94cRC9EukNGC0Zs28OvxQfFv1SY=;
 b=oeaNask4JTJeq3zFJf7Fvs78BZ8OymGUUAFvSFLZEbH/v4/TS13+SB+GdtVQz5oAjz6dLbWCVggcnywV/t7qI45Q7CKPLf9GRLP8kQPfA5uPvcWnRyvTxeDfGInIoXjXRJs4wiEmdeawy9+vgGgRK2+9uNDowUJwZB7dhRmacGE=
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB4013.namprd12.prod.outlook.com (10.255.239.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Mon, 20 May 2019 12:17:29 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::792c:727b:e40f:3a49]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::792c:727b:e40f:3a49%7]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 12:17:29 +0000
From:   Sanjay R Mehta <sanmehta@amd.com>
To:     Jon Mason <jdmason@kudzu.us>, "Mehta, Sanju" <Sanju.Mehta@amd.com>
CC:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] NTB: ntb_perf: Increased the number of message
 retries to 1000
Thread-Topic: [PATCH 1/4] NTB: ntb_perf: Increased the number of message
 retries to 1000
Thread-Index: AQHUxQ+kzcBLircFnkWwMPFTZUsE7qYVAJwAgF+BMwA=
Date:   Mon, 20 May 2019 12:17:28 +0000
Message-ID: <e67dce79-bd64-9dd2-927c-124a34fcdcfc@amd.com>
References: <1550222279-27216-1-git-send-email-Sanju.Mehta@amd.com>
 <20190320175011.GA27156@kudzu.us>
In-Reply-To: <20190320175011.GA27156@kudzu.us>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::24) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.157.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccef33c1-9166-4688-5ff7-08d6dd1d2062
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR12MB4013;
x-ms-traffictypediagnostic: MN2PR12MB4013:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MN2PR12MB4013E24DB38E12BA27391948E5060@MN2PR12MB4013.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(366004)(199004)(189003)(66946007)(73956011)(26005)(66446008)(64756008)(66556008)(186003)(66476007)(68736007)(25786009)(15650500001)(6436002)(71190400001)(71200400001)(36756003)(229853002)(446003)(6512007)(6306002)(6636002)(486006)(6486002)(2616005)(476003)(305945005)(11346002)(7736002)(31686004)(52116002)(53546011)(6506007)(386003)(14454004)(76176011)(102836004)(54906003)(110136005)(6246003)(5660300002)(478600001)(6116002)(99286004)(53936002)(3846002)(72206003)(256004)(966005)(316002)(14444005)(2906002)(8936002)(81166006)(81156014)(66066001)(8676002)(4326008)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4013;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MhhZRDIc+onUd0Rb19jJmig3eGocfxx4ycIBJtSJFZloUCabDVFb7XAIrp0o1I00hSK92mSrRlL6TuU73e3oLXwVCxEF2KMtqCb6ZtVPoJ7plG9n/fU8OqPQldWVdAxfAABknUeXsQqWXVtqYopPNgoPQNcT3WtJrnInPmtAWcTYZBUFCnkLEsFt1D0Lbx5B1UjB7c2Q1WZMeDTniAd5n3+a7gNhmnVbyCxfKvrMnBGKM3vZQG6hxtbu1AhA1Wubt2+ZzvU42vC2Dxp2ZgrV6DnckFxP0gAuWADsAFekzeVP7R59cKnFHbOJeZLCN2BR5jUpErF/bqdyPX+XVhWe4vruELGXjrO5PntufaVYDcLi3UTrswz/pI8m0FSF3hytCingoi3E/Eb6+/eBhP7a0R7KNRm/DdjtZLg3AnfvZvY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A37FF114949484F96A13A70D522105A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccef33c1-9166-4688-5ff7-08d6dd1d2062
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 12:17:29.0239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAzLzIwLzIwMTkgMTE6MjAgUE0sIEpvbiBNYXNvbiB3cm90ZToNCj4gT24gRnJpLCBGZWIg
MTUsIDIwMTkgYXQgMDk6MjA6MDdBTSArMDAwMCwgTWVodGEsIFNhbmp1IHdyb3RlOg0KPj4gRnJv
bTogU2FuamF5IFIgTWVodGEgPHNhbmp1Lm1laHRhQGFtZC5jb20+DQo+Pg0KPj4gd2hpbGUgd2Fp
dGluZyBmb3IgdGhlIHBlZXIgbnRiX3BlcmYgdG8gaW5pdGlhbGl6ZSBzY3JhdGNocGFkDQo+PiBy
ZWdpc3RlcnMsIGxvY2FsIHNpZGUgbnRiX3BlcmYgIG1pZ2h0IGhhdmUgYWxyZWFkeSBleGhhdXN0
ZWQgdGhlDQo+PiBtYXhpbXVtIG51bWJlciBvZiByZXRyaWVzIHdoaWNoIGlzIGN1cnJlbnRseSBz
ZXQgdG8gNTAwLiBUbyBhdm9pZA0KPj4gdGhpcyBhbmQgdG8gZ2l2ZSBsaXR0bGUgbW9yZSB0aW1l
IHRvIHRoZSBwZWVyIG50Yl9wZXJmIGZvciBzY3JhdGNocGFkDQo+PiBpbml0aWFsaXphdGlvbiwg
aW5jcmVhc2VkIHRoZSBudW1iZXIgb2YgcmV0cmllcyB0byAxMDAwDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogU2FuamF5IFIgTWVodGEgPHNhbmp1Lm1laHRhQGFtZC5jb20+DQo+IFNlcmllcyBhcHBs
aWVkIHRvIG15IG50YiBicmFuY2guDQoNCkhpIEpvbiwNCg0KVGhlIGFib3ZlIHBhdGNoIHNlcmll
cyBpcyBub3QgdmlzaWJsZSBpbiA1LjItcmMxIGJyYW5jaC4gUGxlYXNlIGxldCBtZSBrbm93IHdo
ZW4gSSBjYW4gZXhwZWN0IHRoZW0gaW4gdXBzdHJlYW0ga2VybmVsLg0KDQpUaGFua3MgJiBSZWdh
cmRzLA0KDQpTYW5qYXkgTWVodGENCg0KPg0KPiBUaGFua3MsDQo+IEpvbg0KPg0KPg0KPj4gLS0t
DQo+PiAgZHJpdmVycy9udGIvdGVzdC9udGJfcGVyZi5jIHwgMiArLQ0KPj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL250Yi90ZXN0L250Yl9wZXJmLmMgYi9kcml2ZXJzL250Yi90ZXN0L250Yl9wZXJmLmMN
Cj4+IGluZGV4IDJhOWQ2YjAuLmE4MjhkMGUgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL250Yi90
ZXN0L250Yl9wZXJmLmMNCj4+ICsrKyBiL2RyaXZlcnMvbnRiL3Rlc3QvbnRiX3BlcmYuYw0KPj4g
QEAgLTEwMCw3ICsxMDAsNyBAQCBNT0RVTEVfREVTQ1JJUFRJT04oIlBDSWUgTlRCIFBlcmZvcm1h
bmNlIE1lYXN1cmVtZW50IFRvb2wiKTsNCj4+ICAjZGVmaW5lIERNQV9UUklFUwkJMTAwDQo+PiAg
I2RlZmluZSBETUFfTURFTEFZCQkxMA0KPj4gIA0KPj4gLSNkZWZpbmUgTVNHX1RSSUVTCQk1MDAN
Cj4+ICsjZGVmaW5lIE1TR19UUklFUwkJMTAwMA0KPj4gICNkZWZpbmUgTVNHX1VERUxBWV9MT1cJ
CTEwMDANCj4+ICAjZGVmaW5lIE1TR19VREVMQVlfSElHSAkJMjAwMA0KPj4gIA0KPj4gLS0gDQo+
PiAyLjcuNA0KPj4NCj4+IC0tIA0KPj4gWW91IHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBiZWNhdXNl
IHlvdSBhcmUgc3Vic2NyaWJlZCB0byB0aGUgR29vZ2xlIEdyb3VwcyAibGludXgtbnRiIiBncm91
cC4NCj4+IFRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBncm91cCBhbmQgc3RvcCByZWNlaXZpbmcg
ZW1haWxzIGZyb20gaXQsIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnRiK3Vuc3Vic2NyaWJlQGdv
b2dsZWdyb3Vwcy5jb20uDQo+PiBUbyBwb3N0IHRvIHRoaXMgZ3JvdXAsIHNlbmQgZW1haWwgdG8g
bGludXgtbnRiQGdvb2dsZWdyb3Vwcy5jb20uDQo+PiBUbyB2aWV3IHRoaXMgZGlzY3Vzc2lvbiBv
biB0aGUgd2ViIHZpc2l0IGh0dHBzOi8vZ3JvdXBzLmdvb2dsZS5jb20vZC9tc2dpZC9saW51eC1u
dGIvMTU1MDIyMjI3OS0yNzIxNi0xLWdpdC1zZW5kLWVtYWlsLVNhbmp1Lk1laHRhJTQwYW1kLmNv
bS4NCj4+IEZvciBtb3JlIG9wdGlvbnMsIHZpc2l0IGh0dHBzOi8vZ3JvdXBzLmdvb2dsZS5jb20v
ZC9vcHRvdXQuDQo=
