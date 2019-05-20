Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B095C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CC120862
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q5kl7vMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbfETLid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:38:33 -0400
Received: from mail-eopbgr780052.outbound.protection.outlook.com ([40.107.78.52]:22263
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733189AbfETLiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ri41Hk2PeTEYPfX3rLrPJt/RkFPdxeWVJHmvEMfJ558=;
 b=Q5kl7vMeQDBRmF88RXANEnCDDfwbvNimUdGh4VVl17FWhJbitNYcDwUMvOMxZ28SS8SIji4ixwNwHJ7mMS+/nNnNR/q5yXiY9DL3JcjDr6Ue/o1BuSdqX2/48FLVTORfZqaYwAwvRChK5THR/vOYeCJVBTm79dYqYnkY8FfzQaQ=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB1497.namprd12.prod.outlook.com (10.172.38.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Mon, 20 May 2019 11:38:07 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::e1b1:5b6f:b2df:afa5]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::e1b1:5b6f:b2df:afa5%7]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 11:38:07 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Daniel Vetter <daniel@ffwll.ch>
Subject: Re: Confusing lockdep message
Thread-Topic: Confusing lockdep message
Thread-Index: AQHVDv3eZSxJAKf8tkC9hTFvn+DMEKZz4vmA
Date:   Mon, 20 May 2019 11:38:07 +0000
Message-ID: <2f4fb196-e66e-bb0e-c5b2-d9072561f648@amd.com>
References: <386d7978-18fd-318e-ddc9-784266b75d9e@amd.com>
In-Reply-To: <386d7978-18fd-318e-ddc9-784266b75d9e@amd.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM3PR05CA0100.eurprd05.prod.outlook.com
 (2603:10a6:207:1::26) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe891905-63f1-4ed7-44c5-08d6dd17a0e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1497;
x-ms-traffictypediagnostic: DM5PR12MB1497:
x-microsoft-antispam-prvs: <DM5PR12MB149757523FD48C0C0206B07283060@DM5PR12MB1497.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(396003)(346002)(136003)(199004)(189003)(51874003)(52116002)(99286004)(76176011)(7116003)(6512007)(65806001)(65956001)(36756003)(102836004)(3480700005)(2906002)(6116002)(53936002)(86362001)(65826007)(8676002)(81156014)(81166006)(71190400001)(8936002)(305945005)(7736002)(71200400001)(316002)(6486002)(6436002)(229853002)(4326008)(478600001)(15650500001)(72206003)(386003)(64756008)(68736007)(46003)(31696002)(186003)(6246003)(73956011)(66946007)(66476007)(14454004)(66556008)(66446008)(11346002)(31686004)(446003)(5660300002)(476003)(66574012)(2616005)(256004)(14444005)(58126008)(64126003)(110136005)(25786009)(6506007)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1497;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pHkFoGwBwTkmmg4aGz7gCEijLU+JNRzmdzaeDJ8eXd3RpkjO/ILucbmr5lQjvn6DpeOOoePp+yc5BGs7votAh3nIp83e2D6rZBBsEoN/k7Vh8l1N8PtHf9cwhqGagrc90Y3k2qk1ZHEfSxhw4Ql5mNhrio6vajSSHyCLPJGsGq1FvLWPXX69WIAGka7xI0pRr50UIIvt41KaQ5yWmRoMGupDXWU6Wf/BDwtIn9NcVa1OXFdwvl6OqxpBkUoyQWVdACzWgRUp7SeAhUDd/ASK+0LqO3OvdicRIxa8SFWqI4o2953IeABUWFdRfaKyPgHK20hwWf2wqva9lmiywj2iPh3w2StDDij0WOidFuD2CCq16dZ9DpTN8L/o9Szk0L7FT/80xV3rxkdq69mHfqTd0GcIr3s4qd/dXGASYx4Y/Tk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77D0C8EE18AE0B4EB3D66FA21B50A68E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe891905-63f1-4ed7-44c5-08d6dd17a0e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 11:38:07.5867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1497
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGxlYXNlIGlnbm9yZSB0aGlzIG1haWwsDQoNCkkndmUgZml4ZWQgdGhlIGRvdWJsZSB1bmxvY2sg
YW5kIGxvY2tkZXAgaXMgc3RpbGwgY29tcGxhaW5pbmcgYWJvdXQgdGhlIA0KbmVzdGVkIGxvY2tp
bmcsIHNvIEknbSBhY3R1YWxseSBmYWNpbmcgbXVsdGlwbGUgaXNzdWVzIGhlcmUuDQoNClNvcnJ5
IHRvIHdhc3RlIHlvdXIgdGltZSwNCkNocmlzdGlhbi4NCg0KQW0gMjAuMDUuMTkgdW0gMTM6MTkg
c2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOg0KPiBIaSBndXlzLA0KPg0KPiB3cml0aW5nIHRoZSB1
c3VhbCBzdXNwZWN0cyBhYm91dCBsb2NraW5nL2xvY2tkZXAgc3R1ZmYgYW5kIGFsc28gRGFuaWVs
IA0KPiBpbiBDQyBiZWNhdXNlIGhlIG1pZ2h0IGhhdmUgc3R1bWJsZWQgb3ZlciB0aGlzIGFzIHdl
bGwuDQo+DQo+IEl0IHRvb2sgbWUgYSB3aGlsZSB0byBmaWd1cmluZyBvdXQgd2hhdCB0aGUgaGVj
ayBsb2NrZGVwIHdhcyANCj4gY29tcGxhaW5pbmcgYWJvdXQuIFRoZSByZWxldmFudCBkbWVzZyB3
YXMgdGhlIGZvbGxvd2luZzoNCj4+IFvCoCAxNDUuNjIzMDA1XSA9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09DQo+PiBbwqAgMTQ1LjYyMzA5NF0gV0FSTklORzogTmVzdGVkIGxvY2sg
d2FzIG5vdCB0YWtlbg0KPj4gW8KgIDE0NS42MjMxODRdIDUuMC4wLXJjMSsgIzE0NCBOb3QgdGFp
bnRlZA0KPj4gW8KgIDE0NS42MjMyNjFdIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4+IFvCoCAxNDUuNjIzMzUxXSBhbWRncHVfdGVzdC8xNDExIGlzIHRyeWluZyB0byBsb2Nr
Og0KPj4gW8KgIDE0NS42MjM0NDJdIDAwMDAwMDAwOThhMWM0ZDMgKHJlc2VydmF0aW9uX3d3X2Ns
YXNzX211dGV4KXsrLisufSwgDQo+PiBhdDogdHRtX2V1X3Jlc2VydmVfYnVmZmVycysweDQ2ZS8w
eDkxMCBbdHRtXQ0KPj4gW8KgIDE0NS42MjM2NTFdDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGJ1dCB0aGlzIHRhc2sgaXMgbm90IGhvbGRpbmc6DQo+PiBbwqAgMTQ1LjYyMzc1OF0g
cmVzZXJ2YXRpb25fd3dfY2xhc3NfYWNxdWlyZQ0KPj4gW8KgIDE0NS42MjM4MzZdDQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YWNrIGJhY2t0cmFjZToNCj4+IFvCoCAxNDUuNjIz
OTI0XSBDUFU6IDQgUElEOiAxNDExIENvbW06IGFtZGdwdV90ZXN0IE5vdCB0YWludGVkIA0KPj4g
NS4wLjAtcmMxKyAjMTQ0DQo+PiBbwqAgMTQ1LjYyNDA1OF0gSGFyZHdhcmUgbmFtZTogU3lzdGVt
IG1hbnVmYWN0dXJlciBTeXN0ZW0gUHJvZHVjdCANCj4+IE5hbWUvUFJJTUUgWDM5OS1BLCBCSU9T
IDA4MDggMTAvMTIvMjAxOA0KPj4gW8KgIDE0NS42MjQyMzRdIENhbGwgVHJhY2U6DQo+PiAuLi4N
Cj4NCj4gVGhlIHByb2JsZW0gaXMgbm93IHRoYXQgdGhlIG1lc3NhZ2UgaXMgdmVyeSBjb25mdXNp
b24gYmVjYXVzZSB0aGUgDQo+IGlzc3VlIHdhcyAqbm90KiB0aGF0IEkgdHJpZWQgdG8gYWNxdWly
ZSBhIGxvY2ssIGJ1dCByYXRoZXIgdGhhdCBJIA0KPiBhY2NpZGVudGFsbHkgcmVsZWFzZWQgYSBs
b2NrIHR3aWNlLg0KPg0KPiBOb3cgcmVsZWFzaW5nIGEgbG9jayB0d2ljZSBpcyBhIHJhdGhlciBj
b21tb24gbWlzdGFrZSBhbmQgSSdtIHJlYWxseSANCj4gc3VycHJpc2VkIHRoYXQgSSBkaWRuJ3Qg
Z2V0IHRoYXQgcG9pbnRlZCBvdXQgYnkgbG9ja2RlcCBpbW1lZGlhdGVseS4NCj4NCj4gQWRkaXRp
b25hbCB0byB0aGF0IEknbSBwcmV0dHkgc3VyZSB0aGF0IHRoaXMgdXNlZCB0byB3b3JrIGNvcnJl
Y3RseSANCj4gc29tZXRpbWVzIGluIHRoZSBwYXN0LCBzbyBJJ20gZWl0aGVyIGhpdHRpbmcgYSBy
YXJlIGNvcm5lciBjYXNlIG9yIA0KPiB0aGlzIGJyb2tlIGp1c3QgcmVjZW50bHkuDQo+DQo+IEFu
eXdheSBjYW4gc29tZWJvZHkgdGFrZSBhIGxvb2s/IEkgY2FuIHRyeSB0byBwcm92aWRlIGEgdGVz
dCBjYXNlIGlmIA0KPiByZXF1aXJlZC4NCj4NCj4gVGhhbmtzIGluIGFkdmFuY2UsDQo+IENocmlz
dGlhbi4NCg0K
