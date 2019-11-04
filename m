Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ED9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4379E21D81
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3aoDOIb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfKDLaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:30:02 -0500
Received: from mail-eopbgr720053.outbound.protection.outlook.com ([40.107.72.53]:14885
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727236AbfKDLaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:30:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BddsdrTSGth7XT9El7ZbrAu+SWtiVyeWFJ4qBhWEZAP7FCtbLrH5ewB+rhH1XqL6Lu353OA9Gm6NSzbc5PM8lGrY5lxoPVu2H0laMIgGk13D76tNX6nLuu3gT6sVmfj+VRhdU3cyuEwH+tNxrgHUo3IMLB+bNRcNw/ue006ypQtRxORgCJscwIojyaFPLeNAzrXze+Q2Zkint36wlpuhK5GyHE8dUsGPQhEAkuS053gov1fu39m/fcGoczOhLslsJ7eSBBQAQC4VzfX34hSvRmaOwmMXAo47CXCWf4T4p6WGK0yrgMlu1iSV/Aaj6PTcDE8KfghKt2DORemkde/BVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyClaT7mkYetK81GBlHcjh57yyg6ncBSTj5qwVvtqO8=;
 b=E86uADnscjG/stFq0kXkVVzp1JayFyL6Gdg+51hBgat8LqZZ+sSNq8EIZvQusudvWlAaHpYIG0eJse7GK11Zm8kpupJv+aj93du+338G4GHlkuyvtwwbLkr94y0o4+5j9NTWGZNW3hdyKcTQFAjvRt0+XTJzvo46JJs1u6UqvvWx+m9s67B0o1aNg2D9sDTa8u0vILOuqUBQA4lr+dA9G3rUsXGjTCqyyT5ZfuW9hMpMjWbRPeGGiYpAHECN0ULY2zV0f5LF0eAlI6XUgT1nzjRUQ7Imy4gNAE639tnDKmR7nTK/mo/YD69mG3y6XML+4iPTZE+aLR0Sj6Wyul13Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyClaT7mkYetK81GBlHcjh57yyg6ncBSTj5qwVvtqO8=;
 b=3aoDOIb9GmHpI7zSmC9Y+wqu4w2pPelrOQNS/6Kt29LDXrHB3uxQdvEhs/dXAGBsHkVD6S8ZJ1gIlHvR8ZcQnle4AWPrMq0NNh92SAha7wYQCaVj+EIMEKS5Msw363xw+ICrCqwcPbi/ZsAo/whGEnzSklzOp4ZiuYBmWADmMVM=
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1627.namprd12.prod.outlook.com (10.172.40.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Mon, 4 Nov 2019 11:29:58 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933%7]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 11:29:58 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     =?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0gKFZNd2FyZSk=?= 
        <thomas_os@shipmail.org>, Christoph Hellwig <hch@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dma coherent memory user-space maps
Thread-Topic: dma coherent memory user-space maps
Thread-Index: AQHVfdS44axl2pLo1kigeR8OBE2v9ad1b8+AgAVJiQCAAAWGAIAAS9CA
Date:   Mon, 4 Nov 2019 11:29:57 +0000
Message-ID: <84ff140f-8162-6c27-1f4a-b25651652212@amd.com>
References: <b811f66d-2353-23c6-c9fa-e279cdb0f832@shipmail.org>
 <20191031215415.GA9809@infradead.org>
 <7d5f8ec3-41a2-2ceb-aaa1-0bf3aa03d9a1@shipmail.org>
 <f7e76770-e716-6bcb-6b33-8f156e51ee2e@shipmail.org>
In-Reply-To: <f7e76770-e716-6bcb-6b33-8f156e51ee2e@shipmail.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM3PR03CA0067.eurprd03.prod.outlook.com
 (2603:10a6:207:5::25) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2dd57178-6971-4aa8-84d9-08d7611a5270
x-ms-traffictypediagnostic: DM5PR12MB1627:
x-microsoft-antispam-prvs: <DM5PR12MB162752E5F6198A8E08CAFA44837F0@DM5PR12MB1627.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(199004)(189003)(66446008)(81156014)(386003)(66946007)(6436002)(316002)(58126008)(4326008)(64756008)(71190400001)(5660300002)(486006)(229853002)(14444005)(7736002)(31686004)(8676002)(81166006)(6246003)(6486002)(110136005)(71200400001)(305945005)(476003)(2906002)(6116002)(99286004)(66476007)(31696002)(102836004)(65956001)(65806001)(86362001)(6512007)(478600001)(8936002)(256004)(36756003)(6506007)(53546011)(66556008)(76176011)(25786009)(66574012)(52116002)(46003)(186003)(14454004)(11346002)(446003)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1627;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: osM3yErTE2i7z/+dL7drJZMR0gIUUlynyi9amH9x5cU9ckKFekmlaMRIkPZ+QoOUSEOg5hKYRYRxqGECn2vSo6dwEeA4QkAJTz6Bxbxs3hvN3DJZWBx+iEGCb3vAoOuVYNkADCuWrlXMkTyuol6PlVE2mtHg/sa0gJhQzeqBPJwjutNj6BLrricSU3fGfhyL3G0ea+QPSVdZ2HRNcXNOHBMXG5fGTv4ZcoMMSmqyBHi1Cx4D+ILhoMvdlijwYrpcRa+Zu/HgwBxmCA3JClASp47942jJVd8gaH0gszAKtTMhIPny/G5dqV/L3MeoBkMRMJXTrx1sIyBZB2HL5Q7IiFys/RbLU0tn36J3/eTzu8/NGUsjKH8O+A9rFisX9NTo2kadXUDB0GvKFJ+MLGpS2spEVmhqsnflcA4zNVzeJYa9q0SQ+8RWdoVkPtnNlh25
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCE972B673C277498347C1C06BCD8E2A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd57178-6971-4aa8-84d9-08d7611a5270
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 11:29:58.0242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m4xXhKTuN15FvsEalKSDwDICqyP3XizFMwPbPQ5VP0EHKfJvfySVc77PgZtEAQOL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1627
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMDQuMTEuMTkgdW0gMDc6NTggc2NocmllYiBUaG9tYXMgSGVsbHN0csO2bSAoVk13YXJlKToN
Cj4gT24gMTEvNC8xOSA3OjM4IEFNLCBUaG9tYXMgSGVsbHN0csO2bSAoVk13YXJlKSB3cm90ZToN
Cj4+IEhpLCBDcmhpc3RvcGgsDQo+Pg0KPj4gT24gMTAvMzEvMTkgMTA6NTQgUE0sIENocmlzdG9w
aCBIZWxsd2lnIHdyb3RlOg0KPj4+IEhpIFRob21hcywNCj4+Pg0KPj4+IHNvcnJ5IGZvciB0aGUg
ZGVsYXkuwqAgSSd2ZSBiZWVuIHRyYXZlbGxpbmcgd2F5IHRvIG11Y2ggbGF0ZXJseSBhbmQgaGFk
DQo+Pj4gYSBoYXJkIHRpbWUga2VlcGluZyB1cC4NCj4+Pg0KPj4+IE9uIFR1ZSwgT2N0IDA4LCAy
MDE5IGF0IDAyOjM0OjE3UE0gKzAyMDAsIFRob21hcyBIZWxsc3Ryw7ZtIChWTXdhcmUpIA0KPj4+
IHdyb3RlOg0KPj4+PiAvKiBPYnRhaW4gc3RydWN0IGRtYV9wZm4gcG9pbnRlcnMgZnJvbSBhIGRt
YSBjb2hlcmVudCBhbGxvY2F0aW9uICovDQo+Pj4+IGludCBkbWFfZ2V0X2RwZm5zKHN0cnVjdCBk
ZXZpY2UgKmRldiwgdm9pZCAqY3B1X2FkZHIsIGRtYV9hZGRyX3QgDQo+Pj4+IGRtYV9hZGRyLA0K
Pj4+PiDCoMKgwqDCoCDCoMKgwqAgwqAgcGdvZmZfdCBvZmZzZXQsIHBnb2ZmX3QgbnVtLCBkbWFf
cGZuX3QgZHBmbnNbXSk7DQo+Pj4+DQo+Pj4+IEkgZmlndXJlLCBmb3IgbW9zdCBpZiBub3QgYWxs
IGFyY2hpdGVjdHVyZXMgd2UgY291bGQgdXNlIGFuIA0KPj4+PiBvcmRpbmFyeSBwZm4gYXMNCj4+
Pj4gZG1hX3Bmbl90LCBidXQgdGhlIGRtYSBsYXllciB3b3VsZCBzdGlsbCBoYXZlIGNvbnRyb2wg
b3ZlciBob3cgDQo+Pj4+IHRob3NlIHBmbnMNCj4+Pj4gYXJlIG9idGFpbmVkIGFuZCBob3cgdGhl
eSBhcmUgdXNlZCBpbiB0aGUga2VybmVsJ3MgbWFwcGluZyBBUElzLg0KPj4+Pg0KPj4+PiBJZiBz
bywgSSBjb3VsZCBzdGFydCBsb29raW5nIGF0IHRoaXMsIHRpbWUgcGVybWl0dGluZyzCoCBmb3Ig
dGhlIA0KPj4+PiBjYXNlcyB3aGVyZQ0KPj4+PiB0aGUgcGZuIGNhbiBiZSBvYnRhaW5lZCBmcm9t
IHRoZSBrZXJuZWwgYWRkcmVzcyBvciBmcm9tDQo+Pj4+IGFyY2hfZG1hX2NvaGVyZW50X3RvX3Bm
bigpLCBhbmQgYWxzbyB0aGUgbmVlZGVkIHdvcmsgdG8gaGF2ZSBhIA0KPj4+PiB0YWlsb3JlZA0K
Pj4+PiB2bWFwX3BmbigpLg0KPj4+IEknbSBub3Qgc3VyZSB0aGF0IGluZnJhc3RydWN0dXJlIGlz
IGFsbCB0aGF0IGhlbHBmdWwgdW5mb3J0dW5hdGVseSwgDQo+Pj4gZXZlbg0KPj4+IGlmIGl0IGVu
ZGVkIHVwIHdvcmtpbmcuwqAgVGhlIHByb2JsZW0gd2l0aCB0aGUgJ2NvaGVyZW50JyBETUEgbWFw
cGluZ3MNCj4+PiBpcyB0aGF0IHdlIHRoZXkgaGF2ZSBhIGZldyBkaWZmZXJlbnQgYmFja2VuZHMu
wqAgRm9yIGFyY2hpdGVjdHVyZXMgdGhhdA0KPj4+IGFyZSBETUEgY29oZXJlbnQgZXZlcnl0aGlu
ZyBpcyBlYXN5IGFuZCB3ZSB1c2UgdGhlIG5vcm1hbCBwYWdlDQo+Pj4gYWxsb2NhdG9yLCBhbmQg
eW91ciBhYm92ZSBpcyB0cml2aWFsbHkgZG9hYmxlIGFzIHdyYXBwZXJzIGFyb3VuZCB0aGUNCj4+
PiBleGlzdGluZyBmdW5jdGlvbmFsaXR5LsKgIE90aGVyIHJlbWFwIHB0ZXMgdG8gYmUgdW5jYWNo
ZWQsIGVpdGhlcg0KPj4+IGluLXBsYWNlIG9yIHVzaW5nIHZtYXAsIGFuZCB0aGUgcmVtYWluaW5n
IG9uZXMgdXNlIHdlaXJkIHNwZWNpYWwNCj4+PiBhbGxvY2F0b3JzIGZvciB3aGljaCBhbG1vc3Qg
ZXZlcnl0aGluZyB3ZSBjYW4gbW9ybWFsbHkgZG8gaW4gdGhlIFZNDQo+Pj4gd2lsbCBmYWlsLg0K
Pj4NCj4+IEhtbSwgeWVzIEkgd2FzIGhvcGluZyBvbmUgY291bGQgaGlkZSB0aGF0IGJlaGluZCB0
aGUgZG1hX3Bmbl90IGFuZCANCj4+IHRoZSBpbnRlcmZhY2UsIHNvIHRoYXQgbm9uLXRyaXZpYWwg
YmFja2VuZHMgd291bGQgYmUgYWJsZSB0byBkZWZpbmUgDQo+PiB0aGUgZG1hX3Bmbl90IGFzIG5l
ZWRlZCBhbmQgYWxzbyBpZiBuZWVkZWQgaGF2ZSB0aGVpciBvd24gc3BlY2lhbCANCj4+IGltcGxl
bWVudGF0aW9uIG9mIHRoZSBpbnRlcmZhY2UgZnVuY3Rpb25zLiBUaGUgaW50ZXJmYWNlIHdhcyBz
cGVjJ2VkIA0KPj4gZnJvbSB0aGUgdXNlcidzIChUVE0pIHBvaW50IG9mIHZpZXcgYXNzdW1pbmcg
dGhhdCB3aXRoIGEgcGFnZS1wcm90IA0KPj4gYW5kIGFuIG9wYXF1ZSBkbWFfcGZuX3Qgd2UnZCBi
ZSBhYmxlIHRvIHN1cHBvcnQgbW9zdCBub24tdHJpdmlhbCANCj4+IGJhY2tlbmRzLCBidXQgdGhh
dCdzIHBlcmhhcHMgbm90IHRoZSBjYXNlPw0KPj4NCj4+Pg0KPj4+IEkgcHJvbWlzZWQgQ2hyaXN0
aWFuIGFuIHVuY2FjaGVkIERNQSBhbGxvY2F0b3IgYSB3aGlsZSBhZ28sIGFuZCBzdGlsbA0KPj4+
IGhhdmVuJ3QgZmluaXNoZWQgdGhhdCBlaXRoZXIgdW5mb3J0dW5hdGVseS7CoCBCdXQgYmFzZWQg
b24gbG9va2luZyBhdA0KPj4+IHRoZSB4ODYgcGFnZWF0dHIgY29kZSBJJ20gbm93IGZpcm1seSBk
b3duIHRoZSByb2FkIG9mIHVzaW5nIHRoZQ0KPj4+IHNldF9tZW1vcnlfKiBoZWxwZXJzIHRoYXQg
Y2hhbmdlIHRoZSBwdGUgYXR0cmlidXRlcyBpbiBwbGFjZSwgYXMNCj4+PiBldmVyeXRoaW5nIGVs
c2UgY2FuJ3QgYWN0dWFsbHkgd29yayBvbiB4ODYgd2hpY2ggZG9lc24ndCBhbGxvdw0KPj4+IGFs
aWFzaW5nIG9mIFBURXMgd2l0aCBkaWZmZXJlbnQgY2FjaGluZyBhdHRyaWJ1dGVzLsKgIFRoZSBh
cm02NCBmb2xrcw0KPj4+IGFsc28gd291bGQgcHJlZmVyIGluLXBsYWNlIHJlbWFwcGluZyBldmVu
IGlmIHRoZXkgZG9uJ3Qgc3VwcG9ydCBpdA0KPj4+IHlldCwgYW5kIHRoYXQgaXMgc29tZXRoaW5n
IHRoZSBpOTE1IGNvZGUgYWxyZWFkeSBkb2VzIGluIGEgc29tZXdoYXQNCj4+PiBoYWNreSB3YXks
IGFuZCBzb21ldGhpbmcgdGhlIG1zbSBkcm0gZHJpdmVyIHdhbnRzLsKgIFNvIEkgZGVjaWRlZCB0
bw0KPj4+IGNvbWUgdXAgd2l0aCBhbiBBUEkgdGhhdCBnaXZlcyBiYWNrICdjb2hlcmVudCcgcGFn
ZXMgb24gdGhlDQo+Pj4gYXJjaGl0ZWN0dXJlcyB0aGF0IHN1cHBvcnQgaXQgYW5kIG90aGVyd2lz
ZSBqdXN0IGZhaWwuDQo+Pj4NCj4+PiBEbyB5b3UgY2FyZSBhYm91dCBhcmNoaXRlY3R1cmVzIG90
aGVyIHRoYW4geDg2IGFuZCBhcm02ND/CoCBJZiBub3QgSSdsbA0KPj4+IGhvcGVmdWxseSBoYXZl
IHNvbWV0aGluZyBmb3IgeW91IHNvb24uDQo+Pg0KPj4gRm9yIFZNd2FyZSB3ZSBvbmx5IGNhcmUg
YWJvdXQgeDg2IGFuZCBhcm02NCwgYnV0IGkgdGhpbmsgQ2hyaXN0aWFuIA0KPj4gbmVlZHMgdG8g
ZmlsbCBpbiBoZXJlLg0KDQpUaGUgcHJvYmxlbSBpcyB0aGF0IHg4NiBpcyB0aGUgcGxhdGZvcm0g
d2hlcmUgbW9zdCBvZiB0aGUgc3RhbmRhcmRzIGFyZSANCmRlZmluZWQgYW5kIGF0IHRoZSBzYW1l
IHRpbWUgaXQgaXMgcmVsYXRpdmUgZ3JhY2VmdWwgYW5kIGZvcmdpdmluZyB3aGVuIA0KeW91IGRv
IHNvbWV0aGluZyBvZGQuDQoNCkZvciBleGFtcGxlIG9uIHg4NiBpdCBkb2Vzbid0IG1hdHRlciBp
ZiBhIGRldmljZSBhY2NpZGVudGFsbHkgc25vb3BzIHRoZSANCkNQVSBjYWNoZSBvbiBhbiBhY2Nl
c3MgZXZlbiBpZiB0aGUgQ1BVIHRoaW5ncyB0aGF0IGJpdCBvZiBtZW1vcnkgaXMgDQp1bmNhY2hl
ZC4gT24gdGhlIG90aGVyIGhhbmQgb24gQVJNIHRoYXQgY2FuIHJlc3VsdCBpbiBhIHJhdGhlciBo
YXJkIHRvIA0KZGV0ZWN0IGRhdGEgY29ycnVwdGlvbi4gVGhhdCdzIHRoZSByZWFzb24gd2h5IHdl
IGhhdmUgZGlzYWJsZWQgdW5jYWNoZWQgDQpETUEgZm9yIG5vdyBvbiBhcm0zMiBhbmQgb25seSB1
c2UgaXQgcmF0aGVyIHJlc3RyaWN0aXZlIG9uIGFybTY0Lg0KDQpBcyBmYXIgYXMgSSBrbm93IHRo
ZSBzaXR1YXRpb24gT24gUG93ZXJQQyBpcyBub3QgZ29vZCBlaXRoZXIuIEhlcmUgeW91IA0KZ290
IG9sZCBzeXN0ZW1zIHdpdGggQUdQLCBzbyBpbiB1bmNhY2hlZCBzeXN0ZW0gbWVtb3J5IERNQSBk
ZWZpbml0ZWx5IA0Kd29ya3Mgc29tZWhvdywgYnV0IHNvIGZhciBub2JvZHkgY291bGQgZXhwbGFp
biB0byBtZSBob3cuDQoNClRoZW4gbGFzdCBidXQgbm90IGxlYXN0IHlvdSBnb3QgdGhvc2UgTG9v
bmdzb24vTUlQUyBndXlzIHdoaWNoIHNlZW1zIHRvIA0KZ290IHJhZGVvbi9hbWRncHUgd29ya2lu
ZyB3aXRoIHRoZWlyIGFyY2hpdGVjdHVyZSBhcyB3ZWxsLCBidXQgDQplc3NlbnRpYWxseSBJIGhh
dmUgbm8gaWRlYSBob3cuDQoNCldlIGNhcmUgYXQgbGVhc3QgYWJvdXQgeDg2LCBhcm02NCBhbmQg
UG93ZXJQQy4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg0KDQo+DQo+IEFuZCBhbHNvIGZvciBW
TXdhcmUgdGhlIG1vc3QgaW1wb3J0YW50IG1pc3NpbmcgZnVuY3Rpb25hbGl0eSBpcyB2bWFwKCkg
DQo+IG9mIGEgY29tYmluZWQgc2V0IG9mIGNvaGVyZW50IG1lbW9yeSBhbGxvY2F0aW9ucywgYXMg
VFRNIGJ1ZmZlciANCj4gb2JqZWN0cyBhcmUsIHdoZW4gdXNpbmcgY29oZXJlbnQgbWVtb3J5LCBi
dWlsdCBieSBjb2FsZXNjaW5nIGNvaGVyZW50IA0KPiBtZW1vcnkgYWxsb2NhdGlvbnMgZnJvbSBh
IHBvb2wuDQo+DQo+IFRoYW5rcywNCj4gL1Rob21hcw0KPg0KPg0KPj4NCj4+IFRoYW5rcywNCj4+
DQo+PiBUaG9tYXMNCj4+DQo+DQoNCg==
