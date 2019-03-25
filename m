Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E25FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72E0206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Xrt/uQVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbfCYSRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:17:30 -0400
Received: from mail-eopbgr800089.outbound.protection.outlook.com ([40.107.80.89]:37081
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726217AbfCYSR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScieUZp3/VJMtquacViPIA0KcLZUdNkVsd+PTffSEnk=;
 b=Xrt/uQVbtVK61ScKEbaLfR0sCpfJWBtFAZgqX2PncVyBnyNfzf+LUxIlyfxhvBsDDM3GPKTwLAS2Q/ZHWuoy2CACbkFVLFZikWwzGb3DtH5bQaPKB9d24UO7T/MGHIwvWvRyQ3jHWkbgosKJmaTDeRxEiyUXvThk833ILxVs8OE=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6SPR01MB0022.namprd12.prod.outlook.com (20.176.117.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Mon, 25 Mar 2019 18:17:26 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::4dd7:e79:1607:b755]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::4dd7:e79:1607:b755%5]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 18:17:26 +0000
From:   "Singh, Brijesh" <brijesh.singh@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
CC:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        lijiang <lijiang@redhat.com>,
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
Thread-Index: AQHU2xpoydGH9EgTSE63Me6gexO1K6Ya7nQAgAC3uICAAE4dAIAAst0AgAAEIYCAAAyAgA==
Date:   Mon, 25 Mar 2019 18:17:26 +0000
Message-ID: <11013ad2-2eab-5a7a-d4e2-a9da4920cfab@amd.com>
References: <20190315103203.13128-1-lijiang@redhat.com>
 <20190315103203.13128-2-lijiang@redhat.com> <20190324150034.GH23289@zn.tnic>
 <7b115829-40d9-e55e-dee3-ec8e4766971f@redhat.com>
 <20190325063742.GA12016@zn.tnic>
 <652b9166-f06e-c210-3c3f-c9e80a97db18@amd.com>
 <20190325173239.GO12016@zn.tnic>
In-Reply-To: <20190325173239.GO12016@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0093.namprd12.prod.outlook.com
 (2603:10b6:802:21::28) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6077c56c-f258-4766-f98d-08d6b14e2247
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6SPR01MB0022;
x-ms-traffictypediagnostic: DM6SPR01MB0022:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6SPR01MB002207F50BABB91EF5972641E55E0@DM6SPR01MB0022.namprd12.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(366004)(39860400002)(76094002)(199004)(189003)(6246003)(316002)(97736004)(305945005)(31686004)(256004)(6512007)(6306002)(6436002)(53936002)(5660300002)(54906003)(26005)(186003)(110136005)(31696002)(7416002)(966005)(2906002)(478600001)(25786009)(71200400001)(86362001)(8936002)(99286004)(52116002)(53546011)(6506007)(76176011)(4326008)(386003)(71190400001)(102836004)(229853002)(14454004)(6486002)(446003)(6116002)(8676002)(81156014)(81166006)(3846002)(6636002)(476003)(105586002)(486006)(106356001)(36756003)(68736007)(66066001)(2616005)(11346002)(7736002)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6SPR01MB0022;H:DM6PR12MB2682.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IFYOp67AwqJvdlvnEfUifcQO4KEov8DzvYRTMRBtkzgz0MEqdsfpSkgN9DLk5y5/vLn4LOGgngdqCTDOrIzBXXjyHJ9igwai4yjOZX/u4DgNzqwpkCAcWiIiuDHs/c/+QeCkga9NT6JS+co2v/eIoJ1WcYErSWYVpYnlD+xKEn5ARK/+VDnVS2ME682h0eGi8A+YbPu0GXjipPkmr6fRxbJrXjZ+JJ1ViWfyF7WvTxIiAnGrF5DBjfJhI9EJ1Uwuu/Q0obrkh7WXS5BkNTrLNLhEPiVzxVNWfHdht3upbP/2AnyX1kyPb4WYn4ct29wvYgoLXgzx03MRMF9Z54haGLiMqPcmx/Sa3N1icSR7EBO5V00dn6fpKXq8CqqbGoGjjmsgxbKSSH5A+gPcTL8XEDfomp4wmEb7XQegt6HbYeM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <988B63AB973B2941AB10948A11D11527@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6077c56c-f258-4766-f98d-08d6b14e2247
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 18:17:26.4314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6SPR01MB0022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDMvMjUvMTkgMTI6MzIgUE0sIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gTW9u
LCBNYXIgMjUsIDIwMTkgYXQgMDU6MTc6NTVQTSArMDAwMCwgU2luZ2gsIEJyaWplc2ggd3JvdGU6
DQo+PiBCeSBkZWZhdWx0IGFsbCB0aGUgbWVtb3J5IHJlZ2lvbnMgYXJlIG1hcHBlZCBlbmNyeXB0
ZWQuIFRoZQ0KPj4gc2V0X21lbW9yeV97ZW5jcnlwdCxkZWNyeXB0fSgpIGlzIGEgZ2VuZXJpYyBm
dW5jdGlvbiB3aGljaCBjYW4gYmUNCj4+IGNhbGxlZCBleHBsaWNpdGx5IHRvIGNsZWFyL3NldCB0
aGUgZW5jcnlwdGlvbiBtYXNrIGZyb20gdGhlIGV4aXN0aW5nDQo+PiBtZW1vcnkgbWFwcGluZy4g
VGhlIG1lbV9lbmNyeXB0X2FjdGl2ZSgpIHJldHVybnMgdHJ1ZSBpZiBlaXRoZXIgU0VWIG9yDQo+
PiBTTUUgaXMgYWN0aXZlLiBTbyB0aGUgX19zZXRfbWVtb3J5X2VuY19kZWMoKSB1c2VzIHRoZQ0K
Pj4gbWVtb3J5X2VuY3J5cHRfYWN0aXZlKCkgY2hlY2sgdG8gZW5zdXJlIHRoYXQgdGhlIGZ1bmN0
aW9uIGlzIG5vLW9wIHdoZW4NCj4+IFNNRS9TRVYgYXJlIG5vdCBhY3RpdmUuDQo+Pg0KPj4gQ3Vy
cmVudGx5LCB0aGUgYXJjaF9rZXhlY19wb3N0X2FsbG9jX3BhZ2VzKCkgdW5jb25kaXRpb25hbGx5
IGNsZWFyIHRoZQ0KPj4gZW5jcnlwdGlvbiBtYXNrIGZyb20gdGhlIGtleGVjIGFyZWEuIEluIGNh
c2Ugb2YgU0VWLCB3ZSBzaG91bGQgbm90IGNsZWFyDQo+PiB0aGUgZW5jcnlwdGlvbiBtYXNrLg0K
PiANCj4gQnJpamVzaCwgSSBrbm93IGFsbCB0aGF0Lg0KPiANCj4gUGxlYXNlIHJlYWQgd2hhdCBJ
IHNhaWQgaGVyZSBhdCB0aGUgZW5kOg0KPiANCj4gaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8y
MDE5MDMyNDE1MDAzNC5HSDIzMjg5QHpuLnRuaWMNCj4gDQo+IFdpdGggdGhpcyBjaGFuZ2UsIHRo
ZSBjb2RlIGxvb2tzIGxpa2UgdGhpczoNCj4gDQo+ICsgICAgICAgaWYgKHNtZV9hY3RpdmUoKSkN
Cj4gKyAgICAgICAgICAgICAgIHJldHVybiBzZXRfbWVtb3J5X2RlY3J5cHRlZCgodW5zaWduZWQg
bG9uZyl2YWRkciwgcGFnZXMpOw0KPiANCj4gbm93IGluIF9fc2V0X21lbW9yeV9lbmNfZGVjIHZp
YSBzZXRfbWVtb3J5X2RlY3J5cHRlZCgpOg0KPiANCj4gICAgICAgICAgLyogTm90aGluZyB0byBk
byBpZiBtZW1vcnkgZW5jcnlwdGlvbiBpcyBub3QgYWN0aXZlICovDQo+ICAgICAgICAgIGlmICgh
bWVtX2VuY3J5cHRfYWN0aXZlKCkpDQo+ICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+IA0K
PiANCj4gc28geW91IGhhdmU6DQo+IA0KPiAJaWYgKHNtZV9hY3RpdmUoKSkNCj4gDQo+IAkJLi4u
DQo+IA0KPiAJCWlmICghbWVtX2VuY3J5cHRfYWN0aXZlKCkpDQo+IA0KPiANCj4gbm93IG1heWJl
IHRoaXMgaXMgYWxsIGNsZWFyIHRvIHlvdSBhbmQgVG9tIGJ1dCBJIGJldGNoYSBvdGhlcnMgd2ls
bCBnZXQNCj4gY29uZnVzZWQuIFByb2JhYmx5IHNvbWV0aGluZyBsaWtlICJ3ZWxsLCB3aGF0IHNo
b3VsZCBiZSBhY3RpdmUgbm93LCBTTUUsDQo+IFNFViBvciBtZW1vcnkgZW5jcnlwdGlvbiBpbiBn
ZW5lcmFsIj8NCj4gDQo+IEkgaG9wZSB5b3UncmUgY2F0Y2hpbmcgbXkgZHJpZnQuDQo+IA0KPiBT
byBpZiB5b3Ugd2FudCB0byAqbm90KiBkZWNyeXB0IG1lbW9yeSBpbiB0aGUgU0VWIGNhc2UsIHRo
ZW4gZG9pbmcgc29tZXRoaW5nDQo+IGxpa2UgdGhpcyBzaG91bGQgbWFrZSBpdCBhIGJpdCBtb3Jl
IGNsZWFyOg0KPiANCj4gDQo+IAlpZiAoc2V2X2FjdGl2ZSgpKQ0KPiAJCXJldHVybjsNCj4gDQo+
IAlyZXR1cm4gc2V0X21lbW9yeV9kZWNyeXB0ZWQoKHVuc2lnbmVkIGxvbmcpdmFkZHIsIHBhZ2Vz
KTsNCj4gDQoNCg0KSSBzZWUgeW91ciBwb2ludC4gSSBhZ3JlZSBpdCBjYW4gZ2V0IGNvbmZ1c2lu
Zy4NCg0KDQo+IGFsb25nIHdpdGggYSBjb21tZW50ICp3aHkqIHdlJ3JlIGNoZWNraW5nIGhlcmUu
DQo+IA0KPiBCdXQgYWN0dWFsbHksIEknZCBwcmVmZXIgaWYgeW91IGhhZCBzZXBhcmF0ZSB3cmFw
cGVycyB3aGljaCBhcmUgY2FsbGVkDQo+IGZvciBTTUUgYW5kIGZvciBTRVYuDQoNCg0KSnVzdCBh
IHRob3VnaHQsIG1heWJlIHdlIGNhbiBtb3ZlIHRoZSBhYm92ZSBpZihzZXZfYWN0aXZlKCkpIGNo
ZWNrIHVwIGluDQprZXJuZWwva2V4ZWNfY29yZS5jIGJlY2F1c2Ugd2UgZG9uJ3QgbmVlZCB0byBz
ZXQvY2xlYXIgdGhlIGVuY3J5cHRpb24NCm1hc2tzIHdoZW4gU0VWIGlzIGFjdGl2ZSBzbyB0aGVy
ZSBpcyBubyBuZWVkIHRvIGNhbGwgdGhlIHdyYXBwZXIuDQoNCg0KPiANCj4gSSdsbCBsZXQgVG9t
IGNoaW1lIGluIHRvby4NCj4gDQoNCg==
