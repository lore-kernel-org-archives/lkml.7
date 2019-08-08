Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA44CC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C3E2166E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AmB/7KVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404879AbfHHWh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 18:37:56 -0400
Received: from mail-eopbgr700056.outbound.protection.outlook.com ([40.107.70.56]:44257
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404581AbfHHWhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:37:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bh/SHjf4q4ojeIdVMFcrohGmAVehyNjhQsf2dGqlLrI54c44IYQTQTNSUni6iRmRg/sC4nFOZk14owQoX2/AX0CDnHP8A4y9jwhUBCuDqOayjwlrNbGoEXvVUkJDMUJNwa52bytkEg9IB3ZGcWTUTEMdvf4kpyT3QZAt9twnVgaAZk1TDndPb49/QdXXW4d1D4coOo4pxKaLhJPLTAfCQ5GG7CeYV2nL4Ia1+3+kO6Q6wYyOGXudbUqB4rnyRt5khP+z8SmLFBN2Ps+CFm2ylex0mM9F6EYekT0uQlhpSXcb1ET9PO63tECXJSi4mz6Xb7lM++LCEvedaVnIn100sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lapq56wkDO8qurDEZtxcOVJqTYkZvfQ4AJtfpRLEIDY=;
 b=jpEAxzXN3u8yic3u63kXrZ6h3DL7N0EGh1IW+GrvPayNDyx9hChO907qxsOvmA1OZiVTeycGbEzRaTICKx2LXMQxtkG5yj/GkWk6EQZvCVmDo0l68gTz73V9tMervXN4QYhIa/7EYRDKX++waGd6+VDDKeQTY0KkAvFKonR5PRuonxpWkeJwGFFT34ndOnAqM2G62CrJHpJiQeJgmozvFXzlPciarFEpfswCUcKKM8n6g06BcRJqfNB3f85PLDjg4bIP9s3k+SYtIOE4GtWCGg90x/u63ohrjjQHK+Sf7yerEnSLOaWIDvuO9w7bvqk58SLQBtSZ9YjGxk8H1mdMuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lapq56wkDO8qurDEZtxcOVJqTYkZvfQ4AJtfpRLEIDY=;
 b=AmB/7KVI0WySjYeUavmWckB5gk5OKO5N8gfSImBucMQ4RGfXY/A0fVm50sKsAvGtn/D9kygj5xgX/yo+coZzGpMaWOMSQqUFPCRJAeYPeV8vrsX7jE6rYgSeQ+FAwvcl88dofeVO4artEAnr9kAa2xw0gopTvP7Gh6JMfr4sZ4o=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3836.namprd12.prod.outlook.com (10.255.173.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Thu, 8 Aug 2019 22:37:53 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 22:37:53 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Dave Young <dyoung@redhat.com>, lijiang <lijiang@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Anderson <anderson@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>
Subject: Re: crash: `kmem -s` reported "kmem: dma-kmalloc-512: slab:
 ffffe192c0001000 invalid freepointer: e5ffef4e9a040b7e" on a dumped vmcore
Thread-Topic: crash: `kmem -s` reported "kmem: dma-kmalloc-512: slab:
 ffffe192c0001000 invalid freepointer: e5ffef4e9a040b7e" on a dumped vmcore
Thread-Index: AQHVSHo224T5ol7hA0egv05Ed4x+JKbnC9YAgArW+YA=
Date:   Thu, 8 Aug 2019 22:37:53 +0000
Message-ID: <5d91e856-01de-bc80-e4bc-497d57652072@amd.com>
References: <e640b50a-a962-8e56-33a2-2ba2eb76e813@redhat.com>
 <20190802010538.GA2202@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190802010538.GA2202@dhcp-128-65.nay.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:805:ca::16) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3de5f93d-a440-42e1-af87-08d71c510d20
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3836;
x-ms-traffictypediagnostic: DM6PR12MB3836:
x-microsoft-antispam-prvs: <DM6PR12MB383642141F39CE011FB31B79ECD70@DM6PR12MB3836.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(40224003)(199004)(189003)(51444003)(486006)(316002)(76176011)(5660300002)(66446008)(478600001)(71190400001)(6486002)(305945005)(7736002)(99286004)(66476007)(81156014)(81166006)(26005)(71200400001)(25786009)(53546011)(66556008)(6436002)(6506007)(386003)(11346002)(2616005)(476003)(186003)(64756008)(53936002)(446003)(110136005)(54906003)(66946007)(31686004)(6512007)(86362001)(14454004)(229853002)(14444005)(66066001)(31696002)(52116002)(6116002)(102836004)(4326008)(2906002)(3846002)(8676002)(8936002)(256004)(36756003)(6246003)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3836;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ELkJqgWRQORqJoZoOhXAuSER4koWgQB2IvaKQbyyQ4lPt+9QPUBWX0W7KlJWk/QbIiB4eDVPxDsW03t5hsJihqphRBlzHuYu9sM6cO9aiDjZPL1NuhCw23Y+SWtosQRGYJmuy+DZ2TnnlxqJ2pWtuAQzG8QYG9oZ5fHN/0fWjGAhRotMVVM0cBKu4h0WKbhO1b7odNaQJ5AQq36fcQr2H9XrJQ+JscT20vvtdM5vPq/ySEiRacg93nXA8KcyXYBQ5w6TwJfbGOVJIJtAqQIaI+/Y/d9o6+bn2RQ7DyZcmwQZAo97hQ5+cFKooGAZB8p4GaDDNQ1wNdLzTsSBn50CRoQqxAX2XwtfvA2rF/F+vtVyK43H+5JoTAcklZ/81DVKFMXqFFZbdmvj6gjfdj6Sg0ebU4p7EXNFpGTQ5T6P3uA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <90AF5D7FF1C0014A9F7C643F3BE5F454@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de5f93d-a440-42e1-af87-08d71c510d20
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 22:37:53.6447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v83NFPWIIo25YTeRDTY1x3XCA3/eEI23GsWOdM6jDGS1DCKKU9MsQBu4/hpp1qYiZDUbJFW9T2dfKbI8HF8UEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3836
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xLzE5IDg6MDUgUE0sIERhdmUgWW91bmcgd3JvdGU6DQo+IEFkZCBrZXhlYyBjYyBsaXN0
Lg0KPiBPbiAwOC8wMS8xOSBhdCAxMTowMnBtLCBsaWppYW5nIHdyb3RlOg0KPj4gSGksIFRvbQ0K
Pj4NCj4+IFJlY2VudGx5LCBpIHJhbiBpbnRvIGEgcHJvYmxlbSBhYm91dCBTTUUgYW5kIHVzZWQg
Y3Jhc2ggdG9vbCB0byBjaGVjayB0aGUgdm1jb3JlIGFzIGZvbGxvdzoNCj4+DQo+PiBjcmFzaD4g
a21lbSAtcyB8IGdyZXAgLWkgaW52YWxpZA0KPj4ga21lbTogZG1hLWttYWxsb2MtNTEyOiBzbGFi
OiBmZmZmZTE5MmMwMDAxMDAwIGludmFsaWQgZnJlZXBvaW50ZXI6IGU1ZmZlZjRlOWEwNDBiN2UN
Cj4+IGttZW06IGRtYS1rbWFsbG9jLTUxMjogc2xhYjogZmZmZmUxOTJjMDAwMTAwMCBpbnZhbGlk
IGZyZWVwb2ludGVyOiBlNWZmZWY0ZTlhMDQwYjdlDQo+Pg0KPj4gQW5kIHRoZSBjcmFzaCB0b29s
IHJlcG9ydGVkIHRoZSBhYm92ZSBlcnJvciwgcHJvYmFibHksIHRoZSBtYWluIHJlYXNvbiBpcyB0
aGF0IGtlcm5lbCBkb2VzIG5vdA0KPj4gY29ycmVjdGx5IGhhbmRsZSB0aGUgZmlyc3QgNjQwayBy
ZWdpb24gd2hlbiBTTUUgaXMgZW5hYmxlZC4NCj4+DQo+PiBXaGVuIFNNRSBpcyBlbmFibGVkLCB0
aGUga2VybmVsIGFuZCBpbml0cmFtZnMgaW1hZ2VzIGFyZSBsb2FkZWQgaW50byB0aGUgZGVjcnlw
dGVkIG1lbW9yeSwgYW5kDQo+PiB0aGUgYmFja3VwIGFyZWEoZmlyc3QgNjQwaykgaXMgYWxzbyBt
YXBwZWQgYXMgZGVjcnlwdGVkLCBidXQgdGhlIGZpcnN0IDY0MGsgZGF0YSBpcyBjb3BpZWQgdG8N
Cj4+IHRoZSBiYWNrdXAgYXJlYSBpbiBwdXJnYXRvcnkoKS4gUGxlYXNlIHJlZmVyIHRvIHRoaXMg
ZmlsZTogYXJjaC94ODYvcHVyZ2F0b3J5L3B1cmdhdG9yeS5jDQo+PiAuLi4uLi4NCj4+IHN0YXRp
YyBpbnQgY29weV9iYWNrdXBfcmVnaW9uKHZvaWQpDQo+PiB7DQo+PiAgICAgICAgICBpZiAocHVy
Z2F0b3J5X2JhY2t1cF9kZXN0KSB7DQo+PiAgICAgICAgICAgICAgICAgIG1lbWNweSgodm9pZCAq
KXB1cmdhdG9yeV9iYWNrdXBfZGVzdCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICh2b2lk
ICopcHVyZ2F0b3J5X2JhY2t1cF9zcmMsIHB1cmdhdG9yeV9iYWNrdXBfc3opOw0KPj4gICAgICAg
ICAgfQ0KPj4gICAgICAgICAgcmV0dXJuIDA7DQo+PiB9DQo+PiAuLi4uLi4NCj4+DQo+PiBhcmNo
L3g4Ni9rZXJuZWwvbWFjaGluZV9rZXhlY182NC5jDQo+PiAuLi4uLi4NCj4+IG1hY2hpbmVfa2V4
ZWNfcHJlcGFyZSgpLT4NCj4+IGFyY2hfdXBkYXRlX3B1cmdhdG9yeSgpLT4NCj4+IC4uLi4uDQo+
Pg0KPj4gQWN0dWFsbHksIHRoZSBmaXJzIDY0MGsgYXJlYSBpcyBlbmNyeXB0ZWQgaW4gdGhlIGZp
cnN0IGtlcm5lbCB3aGVuIFNNRSBpcyBlbmFibGVkLCBoZXJlIGtlcm5lbA0KPj4gY29waWVzIHRo
ZSBmaXJzdCA2NDBrIGRhdGEgdG8gdGhlIGJhY2t1cCBhcmVhIGluIHB1cmdhdG9yeSgpLCBiZWNh
dXNlIHRoZSBiYWNrdXAgYXJlYSBpcyBtYXBwZWQNCj4+IGFzIGRlY3J5cHRlZCwgdGhpcyBjb3B5
aW5nIG9wZXJhdGlvbiBtYWtlcyB0aGF0IHRoZSBmaXJzdCA2NDBrIGRhdGEgaXMgZGVjcnlwdGVk
KGRlY29kZWQpIGFuZA0KPj4gc2F2ZWQgdG8gdGhlIGJhY2t1cCBhcmVhLCBidXQgcHJvYmFibHkg
a2VybmVsIGNhbiBub3QgYXdhcmUgb2YgU01FIGluIHB1cmdhdG9yeSgpLCB3aGljaCBjYXVzZXMN
Cj4+IGtlcm5lbCBtaXN0YWtlbmx5IHJlYWQgb3V0IHRoZSBmaXJzdCA2NDBrLg0KPj4NCj4+IElu
IGFkZGl0aW9uLCBpIGhhY2tlZCBrZXJuZWwgY29kZSBhcyBmb2xsb3c6DQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2ZzL3Byb2Mvdm1jb3JlLmMgYi9mcy9wcm9jL3ZtY29yZS5jDQo+PiBpbmRleCA3YmNj
OTJhZGQ3MmMuLmE1MTYzMWQzNmE3YSAxMDA2NDQNCj4+IC0tLSBhL2ZzL3Byb2Mvdm1jb3JlLmMN
Cj4+ICsrKyBiL2ZzL3Byb2Mvdm1jb3JlLmMNCj4+IEBAIC0zNzcsNiArMzc4LDE2IEBAIHN0YXRp
YyBzc2l6ZV90IF9fcmVhZF92bWNvcmUoY2hhciAqYnVmZmVyLCBzaXplX3QgYnVmbGVuLCBsb2Zm
X3QgKmZwb3MsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBtLT5vZmZzZXQgKyBtLT5zaXplIC0gKmZwb3MsDQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBidWZsZW4pOw0KPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgIHN0YXJ0ID0gbS0+cGFkZHIgKyAqZnBvcyAtIG0tPm9mZnNldDsNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGlmIChtLT5wYWRkciA9PSAweDczZjYwMDAwKSB7Ly90aGUgYmFja3VwIGFy
ZWEncyBzdGFydCBhZGRyZXNzOjB4NzNmNjAwMDANCj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdG1wID0gcmVhZF9mcm9tX29sZG1lbShidWZmZXIsIHRzeiwgJnN0YXJ0LA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdXNlcmJ1Ziwg
ZmFsc2UpOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNlDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB0bXAgPSByZWFkX2Zyb21fb2xkbWVtKGJ1ZmZlciwgdHN6
LCAmc3RhcnQsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1c2VyYnVmLCBtZW1fZW5jcnlwdF9hY3RpdmUoKSk7DQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKHRtcCA8IDApDQo+Pg0KPj4gSGVyZSwgaSB1c2VkIHRoZSBjcmFzaCB0b29s
IHRvIGNoZWNrIHRoZSB2bWNvcmUsIGkgY2FuIHNlZSB0aGF0IHRoZSBiYWNrdXAgYXJlYSBpcyBk
ZWNyeXB0ZWQsDQo+PiBleGNlcHQgZm9yIHRoZSBkbWEta21hbGxvYy01MTIuIFNvIGkgc3VzcGVj
dCB0aGF0IGtlcm5lbCBkaWQgbm90IGNvcnJlY3RseSByZWFkIG91dCB0aGUgZmlyc3QNCj4+IDY0
MGsgZGF0YSB0byBiYWNrdXAgYXJlYS4gRG8geW91IGhhcHBlbiB0byBrbm93IGhvdyB0byBkZWFs
IHdpdGggdGhlIGZpcnN0IDY0MGsgYXJlYSBpbiBwdXJnYXRvcnkoKQ0KPj4gd2hlbiBTTUUgaXMg
ZW5hYmxlZD8gQW55IGlkZWE/DQoNCkknbSBub3QgYWxsIHRoYXQgZmFtaWxpYXIgd2l0aCBrZXhl
YyBhbmQgcHVyZ2F0b3J5LCBldGMuLCBidXQgSSB0aGluaw0KdGhhdCB5b3Ugd2FudCB0byBzZXR1
cCB0aGUgcGFnZSB0YWJsZSB0aGF0IGlzIGFjdGl2ZSB3aGVuIHB1cmdhdG9yeSBydW5zDQpzbyB0
aGF0IHRoZSBzcmMgYW5kIGRlc3QgYm90aCBoYXZlIHRoZSBTTUUgZW5jcnlwdGlvbiBtYXNrIHNl
dCBpbiB0aGVpcg0KcmVzcGVjdGl2ZSBwYWdlIHRhYmxlIGVudHJpZXMuIFRoaXMgd2F5LCB3aGVu
IHRoZSBjb3B5IGlzIHBlcmZvcm1lZCwNCmV2ZXJ5dGhpbmcgaXMgY29waWVkIGNvcnJlY3RseS4g
IFJlbWVtYmVyLCBlbmNyeXB0ZWQgZGF0YSBmcm9tIG9uZSBwYWdlDQpjYW5ub3QgYmUgZGlyZWN0
bHkgY29waWVkIGFzIHVuZW5jcnlwdGVkIGRhdGEgYW5kIGRlY3J5cHRlZCBwcm9wZXJseSBpbg0K
dGhlIG5ldyBsb2NhdGlvbiAoZS5nLiBhIHBhZ2Ugb2YgemVyb2VzIGVuY3J5cHRlZCBhdCBvbmUg
YWRkcmVzcyB3aWxsIG5vdA0KYXBwZWFyIHRoZSBzYW1lIGFzIGEgcGFnZSBvZiB6ZXJvZXMgZW5j
cnlwdGVkIGF0IGEgZGlmZmVyZW50IGFkZHJlc3MpLg0KDQpUaGFua3MsDQpUb20NCg0KPj4NCj4+
IEJUVzogSScgY3VyaW91cyB0aGUgcmVhc29uIHdoeSB0aGUgYWRkcmVzcyBvZiBkbWEta21hbGxv
Yy01MTJrIGFsd2F5cyBmYWxscyBpbnRvIHRoZSBmaXJzdCA2NDBrDQo+PiByZWdpb24sIGFuZCBp
IGRpZCBub3Qgc2VlIHRoZSBzYW1lIGlzc3VlIG9uIGFub3RoZXIgbWFjaGluZS4NCj4+DQo+PiBN
YWNoaW5lOg0KPj4gU2VyaWFsIE51bWJlciAJZGllc2VsLXN5czkwNzktMDAwMQ0KPj4gTW9kZWwg
ICAgICAgICAgIEFNRCBEaWVzZWwgKEEwQykNCj4+IENQVSAgICAgICAgICAgICBBTUQgRVBZQyA3
NjAxIDMyLUNvcmUgUHJvY2Vzc29yDQo+Pg0KPj4NCj4+IEJhY2tncm91bmQ6DQo+PiBPbiB4ODZf
NjQsIHRoZSBmaXJzdCA2NDBrIHJlZ2lvbiBpcyBzcGVjaWFsIGJlY2F1c2Ugb2Ygc29tZSBoaXN0
b3JpY2FsIHJlYXNvbnMuIEFuZCBrZHVtcCBrZXJuZWwgd2lsbA0KPj4gcmV1c2UgdGhlIGZpcnN0
IDY0MGsgcmVnaW9uLCBzbyBrZXJuZWwgd2lsbCBiYWNrIHVwKGNvcHkpIHRoZSBmaXJzdCA2NDBr
IHJlZ2lvbiB0byBhIGJhY2t1cCBhcmVhIGluDQo+PiBwdXJnYXRvcnkoKSwgaW4gb3JkZXIgbm90
IHRvIHJld3JpdGUgdGhlIG9sZCByZWdpb24oNjQwaykgaW4ga2R1bXAga2VybmVsLCB3aGljaCBt
YWtlcyBzdXJlIHRoYXQga2R1bXANCj4+IGNhbiByZWFkIG91dCB0aGUgb2xkIG1lbW9yeSBmcm9t
IHZtY29yZS4NCj4+DQo+Pg0KPj4gVGhhbmtzLg0KPj4gTGlhbmJvDQo=
