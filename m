Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB77C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956A920815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="m5PI7Y0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732611AbfETLTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:19:25 -0400
Received: from mail-eopbgr750085.outbound.protection.outlook.com ([40.107.75.85]:4537
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730640AbfETLTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJFTd+jWXryHYxZVi/oj5WOmswkG1lBeUZrT9XXnca8=;
 b=m5PI7Y0aB0a2PUjvZIsFvx2hJw9q0ods2+YF1aJrGo0gmWEkcbANWULr8rtwitEGyq+okWxbWOn/cfRnSw/1dhWfTr93lAuQrtdelZXrgdB7C1flz5R9nrYuhNPvUcMTv2TJ/NSnVnOTx8m1ov4xqPaezjYYfX3otT6btPnE2cQ=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Mon, 20 May 2019 11:19:20 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::e1b1:5b6f:b2df:afa5]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::e1b1:5b6f:b2df:afa5%7]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 11:19:20 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Daniel Vetter <daniel@ffwll.ch>
Subject: Confusing lockdep message
Thread-Topic: Confusing lockdep message
Thread-Index: AQHVDv3eZSxJAKf8tkC9hTFvn+DMEA==
Date:   Mon, 20 May 2019 11:19:20 +0000
Message-ID: <386d7978-18fd-318e-ddc9-784266b75d9e@amd.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM0PR06CA0067.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::44) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f895c516-6f30-4c23-e9ca-08d6dd1500f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB2456;
x-ms-traffictypediagnostic: DM5PR12MB2456:
x-microsoft-antispam-prvs: <DM5PR12MB245621236C4556D3E0F73D8C83060@DM5PR12MB2456.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(136003)(376002)(51874003)(199004)(189003)(65806001)(305945005)(65826007)(15650500001)(7736002)(65956001)(81166006)(8676002)(81156014)(71200400001)(7116003)(316002)(86362001)(71190400001)(8936002)(2906002)(256004)(110136005)(31696002)(14444005)(58126008)(25786009)(4326008)(68736007)(72206003)(6116002)(6436002)(102836004)(6506007)(6486002)(53936002)(3480700005)(6512007)(14454004)(64126003)(73956011)(66556008)(64756008)(66946007)(31686004)(186003)(46003)(99286004)(478600001)(36756003)(386003)(5660300002)(66446008)(66476007)(476003)(2616005)(52116002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2456;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6CIeMxZtJ8/gihKOVpr1FLVUrd9Y7EpE80NuAYWPU1dLnWQnXQPfeh7ONmtW04MbbFN/cmzdUa7UuUIoVqkeh32Ng0+egjrmtdNCAt8JLUsLXfAmiWS2OJ7GsZV/ahfYfEw+im9SrSOjxDQMTQ2lV7giIYz08d0avU27HYEJ2OBFfrLHDQ2fRWDp+nnTFBzOgVaxKE6iRNQknc5mz46tZRUc+kXdeC8EmZaD+44UgnFujE/SypVQ02NhGtbY6OIf5KOD3NKQGvg08aLXxxK7wFGmzVI77kZOmEEsbJKy0Nf6mMM3SlxHesaIVMqZn1pEtZfBej2YN7gpnct605N8z+HtZRiZfhSWRl/zpyaG9sLsrAlXm4LduxeQ4aVs8k4QCm8O5Mn0HGuuTW3WOPeB4UJZVfCk05rxcd9nhjGWDBQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6537C245DCF33E44B1FAF271A3C28A96@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f895c516-6f30-4c23-e9ca-08d6dd1500f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 11:19:20.2008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2456
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgZ3V5cywNCg0Kd3JpdGluZyB0aGUgdXN1YWwgc3VzcGVjdHMgYWJvdXQgbG9ja2luZy9sb2Nr
ZGVwIHN0dWZmIGFuZCBhbHNvIERhbmllbCANCmluIENDIGJlY2F1c2UgaGUgbWlnaHQgaGF2ZSBz
dHVtYmxlZCBvdmVyIHRoaXMgYXMgd2VsbC4NCg0KSXQgdG9vayBtZSBhIHdoaWxlIHRvIGZpZ3Vy
aW5nIG91dCB3aGF0IHRoZSBoZWNrIGxvY2tkZXAgd2FzIGNvbXBsYWluaW5nIA0KYWJvdXQuIFRo
ZSByZWxldmFudCBkbWVzZyB3YXMgdGhlIGZvbGxvd2luZzoNCj4gW8KgIDE0NS42MjMwMDVdID09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gW8KgIDE0NS42MjMwOTRdIFdBUk5J
Tkc6IE5lc3RlZCBsb2NrIHdhcyBub3QgdGFrZW4NCj4gW8KgIDE0NS42MjMxODRdIDUuMC4wLXJj
MSsgIzE0NCBOb3QgdGFpbnRlZA0KPiBbwqAgMTQ1LjYyMzI2MV0gLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiBbwqAgMTQ1LjYyMzM1MV0gYW1kZ3B1X3Rlc3QvMTQxMSBpcyB0
cnlpbmcgdG8gbG9jazoNCj4gW8KgIDE0NS42MjM0NDJdIDAwMDAwMDAwOThhMWM0ZDMgKHJlc2Vy
dmF0aW9uX3d3X2NsYXNzX211dGV4KXsrLisufSwgDQo+IGF0OiB0dG1fZXVfcmVzZXJ2ZV9idWZm
ZXJzKzB4NDZlLzB4OTEwIFt0dG1dDQo+IFvCoCAxNDUuNjIzNjUxXQ0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGJ1dCB0aGlzIHRhc2sgaXMgbm90IGhvbGRpbmc6DQo+IFvCoCAxNDUu
NjIzNzU4XSByZXNlcnZhdGlvbl93d19jbGFzc19hY3F1aXJlDQo+IFvCoCAxNDUuNjIzODM2XQ0K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YWNrIGJhY2t0cmFjZToNCj4gW8KgIDE0
NS42MjM5MjRdIENQVTogNCBQSUQ6IDE0MTEgQ29tbTogYW1kZ3B1X3Rlc3QgTm90IHRhaW50ZWQg
DQo+IDUuMC4wLXJjMSsgIzE0NA0KPiBbwqAgMTQ1LjYyNDA1OF0gSGFyZHdhcmUgbmFtZTogU3lz
dGVtIG1hbnVmYWN0dXJlciBTeXN0ZW0gUHJvZHVjdCANCj4gTmFtZS9QUklNRSBYMzk5LUEsIEJJ
T1MgMDgwOCAxMC8xMi8yMDE4DQo+IFvCoCAxNDUuNjI0MjM0XSBDYWxsIFRyYWNlOg0KPiAuLi4N
Cg0KVGhlIHByb2JsZW0gaXMgbm93IHRoYXQgdGhlIG1lc3NhZ2UgaXMgdmVyeSBjb25mdXNpb24g
YmVjYXVzZSB0aGUgaXNzdWUgDQp3YXMgKm5vdCogdGhhdCBJIHRyaWVkIHRvIGFjcXVpcmUgYSBs
b2NrLCBidXQgcmF0aGVyIHRoYXQgSSBhY2NpZGVudGFsbHkgDQpyZWxlYXNlZCBhIGxvY2sgdHdp
Y2UuDQoNCk5vdyByZWxlYXNpbmcgYSBsb2NrIHR3aWNlIGlzIGEgcmF0aGVyIGNvbW1vbiBtaXN0
YWtlIGFuZCBJJ20gcmVhbGx5IA0Kc3VycHJpc2VkIHRoYXQgSSBkaWRuJ3QgZ2V0IHRoYXQgcG9p
bnRlZCBvdXQgYnkgbG9ja2RlcCBpbW1lZGlhdGVseS4NCg0KQWRkaXRpb25hbCB0byB0aGF0IEkn
bSBwcmV0dHkgc3VyZSB0aGF0IHRoaXMgdXNlZCB0byB3b3JrIGNvcnJlY3RseSANCnNvbWV0aW1l
cyBpbiB0aGUgcGFzdCwgc28gSSdtIGVpdGhlciBoaXR0aW5nIGEgcmFyZSBjb3JuZXIgY2FzZSBv
ciB0aGlzIA0KYnJva2UganVzdCByZWNlbnRseS4NCg0KQW55d2F5IGNhbiBzb21lYm9keSB0YWtl
IGEgbG9vaz8gSSBjYW4gdHJ5IHRvIHByb3ZpZGUgYSB0ZXN0IGNhc2UgaWYgDQpyZXF1aXJlZC4N
Cg0KVGhhbmtzIGluIGFkdmFuY2UsDQpDaHJpc3RpYW4uDQo=
