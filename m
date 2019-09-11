Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3918ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B662168B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CLAKpr7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfIKJIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:08:06 -0400
Received: from mail-eopbgr750074.outbound.protection.outlook.com ([40.107.75.74]:25408
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726857AbfIKJIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:08:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfzaMNbxQf4xTTXmRt32U+qEklJSIStiWSBabXQ4Urulm66fju7iXUKFS3Gm+YLtIDDdGE3eb1SQ2yhsaVl3jxVypORSaaUtjggAHUNh5DW66lA6KyyFgNw89VC8nz4WPDVkfc4+YdUlNzy/+1UfQ/pkuLXqX8FEpmCpFtlBe8kVFtxIUlTv0fJjgsV3QrGqtAowq6Ui7GphacmoBww8x/56khTiwZMZOnEXLYTeF9+LnnyJzYxfpwIq2UQuIWRE+EQlQ6XZw4m6aqEGGbsWEbl2m44l+n2msNs3N4Ivj0CYDh1sXtoUeO2IosRIAHNLZIrdis1r79Pl/T7rVWp/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xa2FUoqIBi1NCgup3X6L7JeMDdyt4qsQYEdh5JtcS4=;
 b=OzdJDwTWJOrsMPBNq8dDRXiZLF5WkHail4Sfniuby9RmrLjVl9TPMpqti83V9Ze5pjlXao/8EmZe0s6U/9TB5UEAiztiO2KQxJkrRVhNWfdRSVnj/HtGmzTL4jgxHZPA+oBfiXBQHHhcYajnOtbIMz+a+F1Q0qxnfmq18qNKkuJhjewhSlwgEAVOXprllZ/Av+dH9lZJEQC/fyielC472jyYwTwaguC6ppLSdxg4VeYUrPvNhxrIWFGfsroT/x342jYNCVt1mip+E5Nf9vG234Ofv9RbsJDxgTO56mX6proOlJgAvnf6a9fZkMIIIN8J+HXciK6xfsTCPuUx3thqUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xa2FUoqIBi1NCgup3X6L7JeMDdyt4qsQYEdh5JtcS4=;
 b=CLAKpr7MqFu8AcDOAIn2bu+jETbEpDQxmHjZlRZ+8BWxeRusnkuWGLxtGKQCHuhQc4PEMwR6UXxRyEGuaftDIFHdKHbYTK9DsBkqbDcYwwfaeMu+9UpQd2soamZUnG+rn/5YyFgriG9JHNaUyGMQItwZ3P1Y0Lazy07UNhPVm9M=
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1481.namprd12.prod.outlook.com (10.172.39.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.20; Wed, 11 Sep 2019 09:08:02 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::9d43:b3d4:9ef:29fc]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::9d43:b3d4:9ef:29fc%8]) with mapi id 15.20.2241.018; Wed, 11 Sep 2019
 09:08:01 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     =?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0gKFZNd2FyZSk=?= 
        <thomas_os@shipmail.org>, Andy Lutomirski <luto@amacapital.net>,
        Christoph Hellwig <hch@infradead.org>
CC:     Dave Hansen <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "pv-drivers@vmware.com" <pv-drivers@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [RFC PATCH 1/2] x86: Don't let pgprot_modify() change the page
 encryption bit
Thread-Topic: [RFC PATCH 1/2] x86: Don't let pgprot_modify() change the page
 encryption bit
Thread-Index: AQHVY9W/NbX8l5jE2EqdnkeqDdb24qcdIPeAgAAShQCAAADnAIAH6LoAgAA2koCAAOVxgA==
Date:   Wed, 11 Sep 2019 09:08:01 +0000
Message-ID: <d6da6e46-d283-9efc-52cb-9f2a6b0b7188@amd.com>
References: <20190905103541.4161-1-thomas_os@shipmail.org>
 <20190905103541.4161-2-thomas_os@shipmail.org>
 <608bbec6-448e-f9d5-b29a-1984225eb078@intel.com>
 <b84d1dca-4542-a491-e585-a96c9d178466@shipmail.org>
 <20190905152438.GA18286@infradead.org>
 <10185AAF-BFB8-4193-A20B-B97794FB7E2F@amacapital.net>
 <92171412-eed7-40e9-2554-adb358e65767@shipmail.org>
In-Reply-To: <92171412-eed7-40e9-2554-adb358e65767@shipmail.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM0PR06CA0045.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::22) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc557c48-69bb-4b1a-ca20-08d736978c25
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1481;
x-ms-traffictypediagnostic: DM5PR12MB1481:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1481739D15DC70D07926460F83B10@DM5PR12MB1481.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(51914003)(189003)(199004)(54094003)(36756003)(66946007)(256004)(14444005)(99286004)(386003)(6506007)(76176011)(52116002)(7736002)(6436002)(81156014)(446003)(7416002)(305945005)(8676002)(81166006)(8936002)(966005)(54906003)(58126008)(110136005)(102836004)(478600001)(316002)(66574012)(14454004)(71190400001)(71200400001)(86362001)(31686004)(66556008)(66476007)(64756008)(66446008)(31696002)(53546011)(6486002)(2906002)(5660300002)(6116002)(229853002)(2616005)(65806001)(476003)(65956001)(53936002)(6306002)(6246003)(6512007)(4326008)(486006)(186003)(46003)(25786009)(11346002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1481;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +UQCaMF7NKotieN+3cEyaF+OMNNAHJ5cAv5zBMwldzuFZxI+MubLRo2OjtGfEHUm/1tBhI694jtm4LcnVYtn7KtjR/fkL3CemDgb9+/FJgkdCBvCONcmVaXw05ZxpQ1p8myIkr9umymmbZaiM+WgscaDJ3zBWFsguGU6lJ9jlMhYtBjZYDhh87MqM9X3ZhhAaJbPWEgIoWIUL0KHyfh6hRCwEDU2OVKDTuCndPD03Y9/peqCbP5NzVaowyvirf/Pmtk3v81fJsUsxA92R15QyQFA3rMOMsm0uZg7rA/4rppDuTKARMqa59KgsWHGrvwJB75OjbxtfJRjTPru43ulQ6Mqu1JiETFtWXY93LWYRcKehDSrBUXXEQCYrihFXzqU2SdRxhEHdOPHLddSzFnUm/YAWQLvZ6RpSyrQ81bzrnU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1275175B87B4354D8D837AFF7369DECF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc557c48-69bb-4b1a-ca20-08d736978c25
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 09:08:01.8311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uePYWzH2ATNpEiR7RpxuPmYgw09Ssk0yijMGpA1om5RXC1+vqliTfuA+yv0rXyGt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1481
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMTAuMDkuMTkgdW0gMjE6MjYgc2NocmllYiBUaG9tYXMgSGVsbHN0csO2bSAoVk13YXJlKToN
Cj4gT24gOS8xMC8xOSA2OjExIFBNLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6DQo+Pg0KPj4+IE9u
IFNlcCA1LCAyMDE5LCBhdCA4OjI0IEFNLCBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGluZnJhZGVh
ZC5vcmc+IA0KPj4+IHdyb3RlOg0KPj4+DQo+Pj4+IE9uIFRodSwgU2VwIDA1LCAyMDE5IGF0IDA1
OjIxOjI0UE0gKzAyMDAsIFRob21hcyBIZWxsc3Ryw7ZtIChWTXdhcmUpIA0KPj4+PiB3cm90ZToN
Cj4+Pj4+IE9uIDkvNS8xOSA0OjE1IFBNLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4+Pj4+IEhpIFRo
b21hcywNCj4+Pj4+DQo+Pj4+PiBUaGFua3MgZm9yIHRoZSBzZWNvbmQgYmF0Y2ggb2YgcGF0Y2hl
cyHCoCBUaGVzZSBsb29rIG11Y2ggaW1wcm92ZWQgDQo+Pj4+PiBvbiBhbGwNCj4+Pj4+IGZyb250
cy4NCj4+Pj4gWWVzLCBhbHRob3VnaCB0aGUgVFRNIGZ1bmN0aW9uYWxpdHkgaXNuJ3QgaW4geWV0
LiBIb3BlZnVsbHkgd2UgDQo+Pj4+IHdvbid0IGhhdmUgdG8NCj4+Pj4gYm90aGVyIHlvdSB3aXRo
IHRob3NlIHRob3VnaCwgc2luY2UgdGhpcyBhc3N1bWVzIFRUTSB3aWxsIGJlIHVzaW5nIA0KPj4+
PiB0aGUgZG1hDQo+Pj4+IEFQSS4NCj4+PiBQbGVhc2UgdGFrZSBhIGxvb2sgYXQgZG1hX21tYXBf
cHJlcGFyZSBhbmQgZG1hX21tYXBfZmF1bHQgaW4gdGhpcw0KPj4+IGJyYW5jaDoNCj4+Pg0KPj4+
IGh0dHA6Ly9naXQuaW5mcmFkZWFkLm9yZy91c2Vycy9oY2gvbWlzYy5naXQvc2hvcnRsb2cvcmVm
cy9oZWFkcy9kbWEtbW1hcC1pbXByb3ZlbWVudHMNCj4+Pg0KPj4+IHRoZXkgc2hvdWxkIGFsbG93
IHRvIGZhdWx0IGRtYSBhcGkgcGFnZXMgaW4gdGhlIHBhZ2UgZmF1bHQgaGFuZGxlci7CoCANCj4+
PiBCdXQNCj4+PiB0aGlzIGlzIHRvdGFsbHkgaG90IG9mZiB0aGUgcHJlc3MgYW5kIG5vdCBhY3R1
YWxseSB0ZXN0ZWQgZm9yIHRoZSBsYXN0DQo+Pj4gZmV3IHBhdGNoZXMuwqAgTm90ZSB0aGF0IEkn
dmUgYWxzbyBpbmNsdWRlZCB5b3VyIHR3byBwYXRjaGVzIGZyb20gdGhpcw0KPj4+IHNlcmllcyB0
byBoYW5kbGUgU0VWLg0KPj4gSSByZWFkIHRoYXQgcGF0Y2gsIGFuZCBpdCBzZWVtcyBsaWtlIHlv
deKAmXZlIGJ1aWx0IGluIHRoZSBhc3N1bXB0aW9uIA0KPj4gdGhhdCBhbGwgcGFnZXMgaW4gdGhl
IG1hcHBpbmcgdXNlIGlkZW50aWNhbCBwcm90ZWN0aW9uIG9yLCBpZiBub3QsIA0KPj4gdGhhdCB0
aGUgc2FtZSBmYWtlIHZtYSBoYWNrIHRoYXQgVFRNIGFscmVhZHkgaGFzIGlzIHVzZWQgdG8gZnVk
Z2UgDQo+PiBhcm91bmQgaXQuwqAgQ291bGQgaXQgYmUgcmV3b3JrZWQgc2xpZ2h0bHkgdG8gYXZv
aWQgdGhpcz8NCj4+DQo+PiBJIHdvbmRlciBpZiBpdOKAmXMgYSBtaXN0YWtlIHRvIHB1dCB0aGUg
ZW5jcnlwdGlvbiBiaXRzIGluIHZtX3BhZ2VfcHJvdCANCj4+IGF0IGFsbC4NCj4NCj4gRnJvbSBt
eSBQT1csIHRoZSBlbmNyeXB0aW9uIGJpdHMgYmVoYXZlIHF1aXRlIHNpbWlsYXIgaW4gYmVoYXZp
b3VyIHRvIA0KPiB0aGUgY2FjaGluZyBtb2RlIGJpdHMsIGFuZCB0aGV5J3JlIGFsc28gaW4gdm1f
cGFnZV9wcm90LiBUaGV5J3JlIHRoZSANCj4gcmVhc29uIFRUTSBuZWVkcyB0byBtb2RpZnkgdGhl
IHBhZ2UgcHJvdGVjdGlvbiBpbiB0aGUgZmF1bHQgaGFuZGxlciBpbiANCj4gdGhlIGZpcnN0IHBs
YWNlLg0KPg0KPiBUaGUgcHJvYmxlbSBzZWVuIGluIFRUTSBpcyB0aGF0IHdlIHdhbnQgdG8gYmUg
YWJsZSB0byBjaGFuZ2UgdGhlIA0KPiB2bV9wYWdlX3Byb3QgZnJvbSB0aGUgZmF1bHQgaGFuZGxl
ciwgYnV0IGl0J3MgcHJvYmxlbWF0aWMgc2luY2Ugd2UgDQo+IGhhdmUgdGhlIG1tYXBfc2VtIHR5
cGljYWxseSBvbmx5IGluIHJlYWQgbW9kZS4gSGVuY2UgdGhlIGZha2Ugdm1hIA0KPiBoYWNrLiBG
cm9tIHdoYXQgSSBjYW4gdGVsbCBpdCdzIHJlYXNvbmFibHkgd2VsbC1iZWhhdmVkLCBzaW5jZSAN
Cj4gcHRlX21vZGlmeSgpIHNraXBzIHRoZSBiaXRzIFRUTSB1cGRhdGVzLCBzbyBtcHJvdGVjdCgp
IGFuZCBtcmVtYXAoKSANCj4gd29ya3MgT0suIEkgdGhpbmsgc3BsaXRfaHVnZV9wbWQgbWF5IHJ1
biBpbnRvIHRyb3VibGUsIGJ1dCB3ZSBkb24ndCANCj4gc3VwcG9ydCBpdCAoeWV0KSB3aXRoIFRU
TS4NCg0KQWghIEkgYWN0dWFsbHkgcmFuIGludG8gdGhpcyB3aGlsZSBpbXBsZW1lbnRpbmcgaHVn
ZSBwYWdlIHN1cHBvcnQgZm9yIA0KVFRNIGFuZCBuZXZlciBmaWd1cmVkIG91dCB3aHkgdGhhdCBk
b2Vzbid0IHdvcmsuIERyb3BwZWQgQ1BVIGh1Z2UgcGFnZSANCnN1cHBvcnQgYmVjYXVzZSBvZiB0
aGlzLg0KDQo+DQo+IFdlIGNvdWxkIHByb2JhYmx5IGdldCBhd2F5IHdpdGggYSBXUklURV9PTkNF
KCkgdXBkYXRlIG9mIHRoZSANCj4gdm1fcGFnZV9wcm90IGJlZm9yZSB0YWtpbmcgdGhlIHBhZ2Ug
dGFibGUgbG9jayBzaW5jZQ0KPg0KPiBhKSBXZSdyZSBsb2NraW5nIG91dCBhbGwgb3RoZXIgd3Jp
dGVycy4NCj4gYikgV2UgY2FuJ3QgcmFjZSB3aXRoIGFub3RoZXIgZmF1bHQgdG8gdGhlIHNhbWUg
dm1hIHNpbmNlIHdlIGhvbGQgYW4gDQo+IGFkZHJlc3Mgc3BhY2UgbG9jayAoImJ1ZmZlciBvYmpl
Y3QgcmVzZXJ2YXRpb24iKQ0KPiBjKSBXaGVuIHdlIG5lZWQgdG8gdXBkYXRlIHRoZXJlIGFyZSBu
byB2YWxpZCBwYWdlIHRhYmxlIGVudHJpZXMgaW4gdGhlIA0KPiB2bWEsIHNpbmNlIGl0IG9ubHkg
aGFwcGVucyBkaXJlY3RseSBhZnRlciBtbWFwKCksIG9yIGFmdGVyIGFuIA0KPiB1bm1hcF9tYXBw
aW5nX3JhbmdlKCkgd2l0aCB0aGUgc2FtZSBhZGRyZXNzIHNwYWNlIGxvY2suIFdoZW4gYW5vdGhl
ciANCj4gcmVhZGVyIChmb3IgZXhhbXBsZSBzcGxpdF9odWdlX3BtZCgpKSBzZWVzIGEgdmFsaWQg
cGFnZSB0YWJsZSBlbnRyeSwgDQo+IGl0IGFsc28gc2VlcyB0aGUgbmV3IHBhZ2UgcHJvdGVjdGlv
biBhbmQgdGhpbmdzIGFyZSBmaW5lLg0KDQpZZWFoLCB0aGF0J3MgZXhhY3RseSB3aHkgSSBhbHdh
eXMgd29uZGVyZWQgd2h5IHdlIG5lZWQgdGhpcyBoYWNrIHdpdGggDQp0aGUgdm1hIGNvcHkgb24g
dGhlIHN0YWNrLg0KDQo+DQo+IEJ1dCB0aGF0IHdvdWxkIHJlYWxseSBiZSBhIHNwZWNpYWwgY2Fz
ZS4gVG8gc29sdmUgdGhpcyBwcm9wZXJseSB3ZSdkIA0KPiBwcm9iYWJseSBuZWVkIGFuIGFkZGl0
aW9uYWwgbG9jayB0byBwcm90ZWN0IHRoZSB2bV9mbGFncyBhbmQgDQo+IHZtX3BhZ2VfcHJvdCwg
dGFrZW4gYWZ0ZXIgbW1hcF9zZW0gYW5kIGlfbW1hcF9sb2NrLg0KDQpXZWxsIHdlIGFscmVhZHkg
aGF2ZSBhIHNwZWNpYWwgbG9jayBmb3IgdGhpczogVGhlIHJlc2VydmF0aW9uIG9iamVjdC4gU28g
DQptZW1vcnkgYmFycmllcnMgZXRjIHNob3VsZCBiZSBpbiBwbGFjZSBhbmQgSSBhbHNvIHRoaW5r
IHdlIGNhbiBqdXN0IA0KdXBkYXRlIHRoZSB2bV9wYWdlX3Byb3Qgb24gdGhlIGZseS4NCg0KQ2hy
aXN0aWFuLg0KDQo+DQo+IC9UaG9tYXMNCj4NCj4NCj4NCj4NCg0K
