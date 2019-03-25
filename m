Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC242C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41C220850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="5ZxlS0Q0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbfCYT7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:59:33 -0400
Received: from mail-eopbgr680046.outbound.protection.outlook.com ([40.107.68.46]:54579
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728912AbfCYT7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2f7+vCtCGYZqKD7q19c7Y2xs8uqe0AOMB/PY1TTG2U=;
 b=5ZxlS0Q0FpnR6vHtBM+l4eWQlKBJ2yn+Z1qVNXcaAYeeBEojD9GQ6NNttsvebeoEoa+79m4oRqaqDAouJ9BQHLtQTon3lZIJQksmTG9a9afjBBvFCIosXGvjjdHFBtWpZKj/+CvzOMVpMcc54ACgQDBApBrwFNGpjl+x+qvZJHc=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2810.namprd12.prod.outlook.com (20.176.117.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 19:59:29 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89%6]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 19:59:28 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        Borislav Petkov <bp@alien8.de>
CC:     lijiang <lijiang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH 1/3] kexec: Do not map the kexec area as decrypted when
 SEV is active
Thread-Topic: [PATCH 1/3] kexec: Do not map the kexec area as decrypted when
 SEV is active
Thread-Index: AQHU2xpoSs3WgtcWjUWUiL4VzQYPkqYa7nQAgAC3uICAAE4dAIAAsuCAgAAEHoCAAAyDAIAAHIAA
Date:   Mon, 25 Mar 2019 19:59:28 +0000
Message-ID: <be457f42-40b0-6d21-0f0c-2a5e3860d4d5@amd.com>
References: <20190315103203.13128-1-lijiang@redhat.com>
 <20190315103203.13128-2-lijiang@redhat.com> <20190324150034.GH23289@zn.tnic>
 <7b115829-40d9-e55e-dee3-ec8e4766971f@redhat.com>
 <20190325063742.GA12016@zn.tnic>
 <652b9166-f06e-c210-3c3f-c9e80a97db18@amd.com>
 <20190325173239.GO12016@zn.tnic>
 <11013ad2-2eab-5a7a-d4e2-a9da4920cfab@amd.com>
In-Reply-To: <11013ad2-2eab-5a7a-d4e2-a9da4920cfab@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0081.namprd12.prod.outlook.com (52.132.192.144) To
 DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0811f786-53fe-485c-ec2b-08d6b15c6393
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2810;
x-ms-traffictypediagnostic: DM6PR12MB2810:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR12MB281089EC169FB52849FE86E8EC5E0@DM6PR12MB2810.namprd12.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(366004)(189003)(76094002)(199004)(6506007)(386003)(105586002)(106356001)(53546011)(68736007)(99286004)(66066001)(26005)(6346003)(102836004)(81156014)(81166006)(476003)(2616005)(186003)(446003)(8676002)(71200400001)(52116002)(6116002)(71190400001)(25786009)(3846002)(4326008)(478600001)(11346002)(76176011)(256004)(72206003)(5660300002)(14444005)(86362001)(31696002)(14454004)(966005)(7736002)(53936002)(7416002)(93886005)(110136005)(305945005)(54906003)(316002)(36756003)(8936002)(6246003)(6486002)(6512007)(6306002)(229853002)(97736004)(6436002)(2906002)(31686004)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2810;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: roWa4bTy1ScsHc0TAEDMGeZHnRtW4yC+TY70W5lbuV26PGjsnwTu5TYhM0eHoMkcMJEVVWVw+gh2c44DOSUpSxjIaLcNLdkqwsu5rwzAtfdECRItPZtxSeiOVm5949Mkcioqr06GwDp9Gq4oFGf7Dmp4MZ1lbsnvEAKrEV0I6trvjT3NxJh9t5J+4qMSH0PLqdwImZzGkxO+W1Eadu+wLpEoXx9j6CiQi1za5WQyY6ZGOioDwdLrU6C8YZ7r2ld2zohAVS9vBA94gOP8Mjjy2LJE/LbMybg1Y5hh84sbrjGzKxQIP/h4BmZlfWV9TfCZbr2tJDG6XqDcwSKrwlSOiRhMcsyPLuqPc2iI824NM5LVv6aCYcFecWhpDZ6AkQ+etll4RAxqNuMx07e/rXvr3LpUByYfrEhBuFUHHUrcs+Q=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55B1418933BAD443B6014793C219213B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0811f786-53fe-485c-ec2b-08d6b15c6393
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 19:59:28.8742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2810
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yNS8xOSAxOjE3IFBNLCBTaW5naCwgQnJpamVzaCB3cm90ZToNCj4gDQo+IA0KPiBPbiAz
LzI1LzE5IDEyOjMyIFBNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+PiBPbiBNb24sIE1hciAy
NSwgMjAxOSBhdCAwNToxNzo1NVBNICswMDAwLCBTaW5naCwgQnJpamVzaCB3cm90ZToNCj4+PiBC
eSBkZWZhdWx0IGFsbCB0aGUgbWVtb3J5IHJlZ2lvbnMgYXJlIG1hcHBlZCBlbmNyeXB0ZWQuIFRo
ZQ0KPj4+IHNldF9tZW1vcnlfe2VuY3J5cHQsZGVjcnlwdH0oKSBpcyBhIGdlbmVyaWMgZnVuY3Rp
b24gd2hpY2ggY2FuIGJlDQo+Pj4gY2FsbGVkIGV4cGxpY2l0bHkgdG8gY2xlYXIvc2V0IHRoZSBl
bmNyeXB0aW9uIG1hc2sgZnJvbSB0aGUgZXhpc3RpbmcNCj4+PiBtZW1vcnkgbWFwcGluZy4gVGhl
IG1lbV9lbmNyeXB0X2FjdGl2ZSgpIHJldHVybnMgdHJ1ZSBpZiBlaXRoZXIgU0VWIG9yDQo+Pj4g
U01FIGlzIGFjdGl2ZS4gU28gdGhlIF9fc2V0X21lbW9yeV9lbmNfZGVjKCkgdXNlcyB0aGUNCj4+
PiBtZW1vcnlfZW5jcnlwdF9hY3RpdmUoKSBjaGVjayB0byBlbnN1cmUgdGhhdCB0aGUgZnVuY3Rp
b24gaXMgbm8tb3Agd2hlbg0KPj4+IFNNRS9TRVYgYXJlIG5vdCBhY3RpdmUuDQo+Pj4NCj4+PiBD
dXJyZW50bHksIHRoZSBhcmNoX2tleGVjX3Bvc3RfYWxsb2NfcGFnZXMoKSB1bmNvbmRpdGlvbmFs
bHkgY2xlYXIgdGhlDQo+Pj4gZW5jcnlwdGlvbiBtYXNrIGZyb20gdGhlIGtleGVjIGFyZWEuIElu
IGNhc2Ugb2YgU0VWLCB3ZSBzaG91bGQgbm90IGNsZWFyDQo+Pj4gdGhlIGVuY3J5cHRpb24gbWFz
ay4NCj4+DQo+PiBCcmlqZXNoLCBJIGtub3cgYWxsIHRoYXQuDQo+Pg0KPj4gUGxlYXNlIHJlYWQg
d2hhdCBJIHNhaWQgaGVyZSBhdCB0aGUgZW5kOg0KPj4NCj4+IGh0dHBzOi8vbGttbC5rZXJuZWwu
b3JnL3IvMjAxOTAzMjQxNTAwMzQuR0gyMzI4OUB6bi50bmljDQo+Pg0KPj4gV2l0aCB0aGlzIGNo
YW5nZSwgdGhlIGNvZGUgbG9va3MgbGlrZSB0aGlzOg0KPj4NCj4+ICsgICAgICAgaWYgKHNtZV9h
Y3RpdmUoKSkNCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gc2V0X21lbW9yeV9kZWNyeXB0ZWQo
KHVuc2lnbmVkIGxvbmcpdmFkZHIsIHBhZ2VzKTsNCj4+DQo+PiBub3cgaW4gX19zZXRfbWVtb3J5
X2VuY19kZWMgdmlhIHNldF9tZW1vcnlfZGVjcnlwdGVkKCk6DQo+Pg0KPj4gICAgICAgICAgLyog
Tm90aGluZyB0byBkbyBpZiBtZW1vcnkgZW5jcnlwdGlvbiBpcyBub3QgYWN0aXZlICovDQo+PiAg
ICAgICAgICBpZiAoIW1lbV9lbmNyeXB0X2FjdGl2ZSgpKQ0KPj4gICAgICAgICAgICAgICAgICBy
ZXR1cm4gMDsNCj4+DQo+Pg0KPj4gc28geW91IGhhdmU6DQo+Pg0KPj4gCWlmIChzbWVfYWN0aXZl
KCkpDQo+Pg0KPj4gCQkuLi4NCj4+DQo+PiAJCWlmICghbWVtX2VuY3J5cHRfYWN0aXZlKCkpDQo+
Pg0KPj4NCj4+IG5vdyBtYXliZSB0aGlzIGlzIGFsbCBjbGVhciB0byB5b3UgYW5kIFRvbSBidXQg
SSBiZXRjaGEgb3RoZXJzIHdpbGwgZ2V0DQo+PiBjb25mdXNlZC4gUHJvYmFibHkgc29tZXRoaW5n
IGxpa2UgIndlbGwsIHdoYXQgc2hvdWxkIGJlIGFjdGl2ZSBub3csIFNNRSwNCj4+IFNFViBvciBt
ZW1vcnkgZW5jcnlwdGlvbiBpbiBnZW5lcmFsIj8NCj4+DQo+PiBJIGhvcGUgeW91J3JlIGNhdGNo
aW5nIG15IGRyaWZ0Lg0KPj4NCj4+IFNvIGlmIHlvdSB3YW50IHRvICpub3QqIGRlY3J5cHQgbWVt
b3J5IGluIHRoZSBTRVYgY2FzZSwgdGhlbiBkb2luZyBzb21ldGhpbmcNCj4+IGxpa2UgdGhpcyBz
aG91bGQgbWFrZSBpdCBhIGJpdCBtb3JlIGNsZWFyOg0KPj4NCj4+DQo+PiAJaWYgKHNldl9hY3Rp
dmUoKSkNCj4+IAkJcmV0dXJuOw0KPj4NCj4+IAlyZXR1cm4gc2V0X21lbW9yeV9kZWNyeXB0ZWQo
KHVuc2lnbmVkIGxvbmcpdmFkZHIsIHBhZ2VzKTsNCj4+DQo+IA0KPiANCj4gSSBzZWUgeW91ciBw
b2ludC4gSSBhZ3JlZSBpdCBjYW4gZ2V0IGNvbmZ1c2luZy4NCj4gDQo+IA0KPj4gYWxvbmcgd2l0
aCBhIGNvbW1lbnQgKndoeSogd2UncmUgY2hlY2tpbmcgaGVyZS4NCj4+DQo+PiBCdXQgYWN0dWFs
bHksIEknZCBwcmVmZXIgaWYgeW91IGhhZCBzZXBhcmF0ZSB3cmFwcGVycyB3aGljaCBhcmUgY2Fs
bGVkDQo+PiBmb3IgU01FIGFuZCBmb3IgU0VWLg0KPiANCj4gDQo+IEp1c3QgYSB0aG91Z2h0LCBt
YXliZSB3ZSBjYW4gbW92ZSB0aGUgYWJvdmUgaWYoc2V2X2FjdGl2ZSgpKSBjaGVjayB1cCBpbg0K
PiBrZXJuZWwva2V4ZWNfY29yZS5jIGJlY2F1c2Ugd2UgZG9uJ3QgbmVlZCB0byBzZXQvY2xlYXIg
dGhlIGVuY3J5cHRpb24NCj4gbWFza3Mgd2hlbiBTRVYgaXMgYWN0aXZlIHNvIHRoZXJlIGlzIG5v
IG5lZWQgdG8gY2FsbCB0aGUgd3JhcHBlci4NCg0KSUlSQywgdGhlIHdyYXBwZXIgd2FzIGNyZWF0
ZWQgdG8gYXZvaWQgY2hlY2tpbmcgaW4gdGhlIG1haW4ga2V4ZWMgc3VwcG9ydA0KYW5kIG1vdmUg
dGhlIGNoZWNrIGRvd24gdG8gdGhlIGFyY2ggc3BlY2lmaWMgc3VwcG9ydC4gU28gSSBkb24ndCB0
aGluayB3ZQ0Kc2hvdWxkIG1vdmUgaXQuDQoNCkknbSBub3Qgc3VyZSBhYm91dCB0aGUgc2VwYXJh
dGUgd3JhcHBlcnMsIEkgbGlrZSB0aGUgYWJvdmUgY29kZSB3aGVyZSB0aGUNCmFyY2ggY2FsbGJh
Y2sgcmV0dXJucyBpZiBzZXZfYWN0aXZlKCkgaXMgdHJ1ZS4NCg0KTWF5YmUgd2hhdCB3b3VsZCBo
ZWxwIGlzIHRvIGRlc2NyaWJlIHdoeSB0aGVyZSBpcyBhIGRpZmZlcmVuY2UgYmV0d2VlbiBTTUUN
CmFuZCBTRVYgaW4gcmVnYXJkcyB0byBrZXhlYy4gRHVyaW5nIGEgdHJhZGl0aW9uYWwgYm9vdCB1
bmRlciBTTUUsIFNNRSB3aWxsDQplbmNyeXB0IHRoZSBrZXJuZWwsIHNvIHRoZSBTTUUga2V4ZWMg
a2VybmVsIGFsc28gbmVlZHMgdG8gYmUgdW4tZW5jcnlwdGVkDQppbiBvcmRlciB0byByZXBsaWNh
dGUgYSBub3JtYWwgU01FIGJvb3QuIER1cmluZyBhIHRyYWRpdGlvbmFsIGJvb3QgdW5kZXINClNF
ViwgdGhlIGtlcm5lbCBoYXMgYWxyZWFkeSBiZWVuIGxvYWRlZCBlbmNyeXB0ZWQsIHNvIHRoZSBT
RVYga2V4ZWMga2VybmVsDQpuZWVkcyB0byBiZSBlbmNyeXB0ZWQgaW4gb3JkZXIgdG8gcmVwbGlj
YXRlIGEgbm9ybWFsIFNFViBib290Lg0KDQpUaGFua3MsDQpUb20NCg0KPiANCj4gDQo+Pg0KPj4g
SSdsbCBsZXQgVG9tIGNoaW1lIGluIHRvby4NCj4+DQo+IA0K
