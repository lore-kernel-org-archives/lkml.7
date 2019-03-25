Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AE0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F08320896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fGcYAOa0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbfCYRSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:18:00 -0400
Received: from mail-eopbgr680053.outbound.protection.outlook.com ([40.107.68.53]:14849
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728991AbfCYRSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBVCUjMuTDyucMC0z6iAbmFEw5irQKYhC+XIVK1vxPM=;
 b=fGcYAOa0hrE9I85Ysa1S1nhaj2nNXHO5lKD7kk9Chwao4XPOquDe+rlJKt2fpOx1yB836hU943jsWSiJSm+vGTgDYm52ISZOjFMegYPO0DmcgH02RWQa8IbVNwK7tBCzbO1JxnTv7Be3GU6+9hXZQ6lADd+g2DoFIaHYFY+e+vw=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB2731.namprd12.prod.outlook.com (20.176.118.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Mon, 25 Mar 2019 17:17:55 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::4dd7:e79:1607:b755]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::4dd7:e79:1607:b755%5]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 17:17:55 +0000
From:   "Singh, Brijesh" <brijesh.singh@amd.com>
To:     Borislav Petkov <bp@alien8.de>, lijiang <lijiang@redhat.com>
CC:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH 1/3] kexec: Do not map the kexec area as decrypted when
 SEV is active
Thread-Topic: [PATCH 1/3] kexec: Do not map the kexec area as decrypted when
 SEV is active
Thread-Index: AQHU2xpoydGH9EgTSE63Me6gexO1K6Ya7nQAgAC3uICAAE4dAIAAst0A
Date:   Mon, 25 Mar 2019 17:17:55 +0000
Message-ID: <652b9166-f06e-c210-3c3f-c9e80a97db18@amd.com>
References: <20190315103203.13128-1-lijiang@redhat.com>
 <20190315103203.13128-2-lijiang@redhat.com> <20190324150034.GH23289@zn.tnic>
 <7b115829-40d9-e55e-dee3-ec8e4766971f@redhat.com>
 <20190325063742.GA12016@zn.tnic>
In-Reply-To: <20190325063742.GA12016@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:805:de::30) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 624751da-fd01-4c3f-01f0-08d6b145d1d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2731;
x-ms-traffictypediagnostic: DM6PR12MB2731:
x-microsoft-antispam-prvs: <DM6PR12MB27310BE23AF76C5C1CFB1382E55E0@DM6PR12MB2731.namprd12.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(39860400002)(396003)(199004)(189003)(229853002)(2616005)(66066001)(256004)(68736007)(6486002)(52116002)(93886005)(486006)(36756003)(478600001)(476003)(186003)(53936002)(7416002)(99286004)(2906002)(53546011)(31686004)(8936002)(105586002)(6506007)(386003)(6436002)(86362001)(25786009)(6512007)(11346002)(76176011)(8676002)(305945005)(6116002)(7736002)(31696002)(81156014)(81166006)(54906003)(5660300002)(97736004)(3846002)(6246003)(446003)(102836004)(4326008)(316002)(14454004)(71200400001)(106356001)(71190400001)(26005)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2731;H:DM6PR12MB2682.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iLu4TS5m15P/Mx0ZRBMwHsQ98Rp6xDTScsTpAoPCtNEaRnYohFXEyI7s+6DS7rohjA1HW+PPesmSyTO4mTgsmkG9oO0zWrN82NIRuA/NTv57ueu2oDouP8vF0R5PI+mSE+GXXXF5454ls9FHwJMk5FLckYS2PhzeE1IlojRMF4i2VQDnV+EYYkrk3iNpL3bsJLE2g61CHDGTL7DoDOfB6qQz3l0cTAXGFsUF2tSZkb2Xz9HTnRAjpaRcpnMjwhiKgm6UuWYJRKT+lai8JV9G7ZC03wbtY8JnOdUU+BfSK6BdxAg30vrNrPtsc/c3MzO8xkcUy72YZ2PUm0P/cUB0zqUvk+KaFFxI+tIoYxgdX+3bgcVHwOFJsLhk66hlEBLW5Jeyh1mbHDYcN00kXYGGF69v/JsUtwJEH5R2DwCnTxw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20558C964D194A419E3230BDC7DFEF99@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624751da-fd01-4c3f-01f0-08d6b145d1d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 17:17:55.3185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2731
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNCg0KT24gMy8yNS8xOSAxOjM3IEFNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgTWFyIDI1LCAyMDE5IGF0IDA5OjU4OjA3QU0gKzA4MDAsIGxpamlhbmcgd3Jv
dGU6DQo+PiBGb3IgdGhlIFNFViB2aXJ0dWFsIG1hY2hpbmUsIGl0IG1hcHMgdGhlIGtleGVjIG1l
bXJveSBhcmVhIGFzDQo+PiBlbmNyeXB0ZWQsIHNvLCBubyBuZWVkIHRvIGludm9rZSB0aGlzIGZ1
bmN0aW9uIHRvIGNoYW5nZSBhbnl0aGluZy4NCj4gDQo+IExvb2sgYXQgdGhlIGNvZGU6DQo+IA0K
PiBzZXRfbWVtb3J5X2RlY3J5cHRlZC0+X19zZXRfbWVtb3J5X2VuY19kZWMNCj4gDQo+IEl0IGFs
cmVhZHkgKmRvZXMqIGludm9rZSB0aGlzIGZ1bmN0aW9uLg0KPiANCg0KQnkgZGVmYXVsdCBhbGwg
dGhlIG1lbW9yeSByZWdpb25zIGFyZSBtYXBwZWQgZW5jcnlwdGVkLiBUaGUNCnNldF9tZW1vcnlf
e2VuY3J5cHQsZGVjcnlwdH0oKSBpcyBhIGdlbmVyaWMgZnVuY3Rpb24gd2hpY2ggY2FuIGJlDQpj
YWxsZWQgZXhwbGljaXRseSB0byBjbGVhci9zZXQgdGhlIGVuY3J5cHRpb24gbWFzayBmcm9tIHRo
ZSBleGlzdGluZw0KbWVtb3J5IG1hcHBpbmcuIFRoZSBtZW1fZW5jcnlwdF9hY3RpdmUoKSByZXR1
cm5zIHRydWUgaWYgZWl0aGVyIFNFViBvciANClNNRSBpcyBhY3RpdmUuIFNvIHRoZSBfX3NldF9t
ZW1vcnlfZW5jX2RlYygpIHVzZXMgdGhlDQptZW1vcnlfZW5jcnlwdF9hY3RpdmUoKSBjaGVjayB0
byBlbnN1cmUgdGhhdCB0aGUgZnVuY3Rpb24gaXMgbm8tb3Agd2hlbg0KU01FL1NFViBhcmUgbm90
IGFjdGl2ZS4NCg0KQ3VycmVudGx5LCB0aGUgYXJjaF9rZXhlY19wb3N0X2FsbG9jX3BhZ2VzKCkg
dW5jb25kaXRpb25hbGx5IGNsZWFyIHRoZQ0KZW5jcnlwdGlvbiBtYXNrIGZyb20gdGhlIGtleGVj
IGFyZWEuIEluIGNhc2Ugb2YgU0VWLCB3ZSBzaG91bGQgbm90IGNsZWFyDQp0aGUgZW5jcnlwdGlv
biBtYXNrLg0KDQoNCg0KPj4+IAlpZiAoIW1lbV9lbmNyeXB0X2FjdGl2ZSgpKQ0KPj4+DQo+Pj4g
YW5kIGhlYWRzIHdpbGwgc3BpbiBmcm9tIGFsbCB0aGUgY2hlY2tpbmcgb2YgbWVtb3J5IGVuY3J5
cHRpb24gYXNwZWN0cy4NCj4+Pg0KPj4+IFNvIHRoaXMgd291bGQgbmVlZCBhIHJld29yayBzbyB0
aGF0IHRoZXJlIGFyZSBubyBtdWx0aXBsZSBjb25mdXNpbmcNCj4+PiBjaGVja3MuDQo+Pg0KPj4g
QWJvdXQgdGhlIHRocmVlIGZ1bmN0aW9ucywgaGVyZSBpIGNvcGllZCB0aGVpciBjb21tZW50IGZy
b20gdGhlIGFyY2gveDg2L21tL21lbV9lbmNyeXB0LmMNCj4+IFBsZWFzZSByZWZlciB0byBpdC4N
Cj4gDQo+IEkga25vdyB0aGF0IGNvbW1lbnQgLSBJIGhhdmUgYXNrZWQgZm9yIGl0LiBOb3cgeW91
IGdvIGFuZCBsb29rIGF0IHRoZQ0KPiBjb2RlIGFnYWluIHdpdGggeW91ciBwYXRjaCBhcHBsaWVk
Lg0KPiANCg==
