Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F303C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224AB2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SNAB1LuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbfD2WXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 18:23:42 -0400
Received: from mail-eopbgr800040.outbound.protection.outlook.com ([40.107.80.40]:37017
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728105AbfD2WXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY9/DZnek49ctf+uWfdC6GktaEMWvybqnR8p3oUK2AY=;
 b=SNAB1LuZygnDHekmlkXFDUEyT7mPvXAeusWllD8eJqzmTHkf1jA65nfSRfggEOK4fCgeRIo+bu2A3vqy18bjca1jccwPBIn2TtldPtCTUe6AjKXWWWbfEBx7h4syZ4cysSa9nfGwH2fjNCDLyf2qGKrR7uMWH9w9XrwHt1cXlZk=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.40.14) by
 DM5PR12MB1932.namprd12.prod.outlook.com (10.175.89.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Mon, 29 Apr 2019 22:22:58 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::11db:1b41:d1e6:c6dc]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::11db:1b41:d1e6:c6dc%11]) with mapi id 15.20.1835.016; Mon, 29 Apr
 2019 22:22:58 +0000
From:   "Hook, Gary" <Gary.Hook@amd.com>
To:     "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: [PATCH 2] x86/mm/mem_encrypt: Disable all instrumentation for SME
 early files
Thread-Topic: [PATCH 2] x86/mm/mem_encrypt: Disable all instrumentation for
 SME early files
Thread-Index: AQHU/toZC/wbh5hvA0WBi9nHaOY1qQ==
Date:   Mon, 29 Apr 2019 22:22:58 +0000
Message-ID: <155657657552.7116.18363762932464011367.stgit@sosrh3.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR16CA0062.namprd16.prod.outlook.com
 (2603:10b6:805:ca::39) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:10::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ba4a355-10d7-4e5a-c5d3-08d6ccf13b8b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1932;
x-ms-traffictypediagnostic: DM5PR12MB1932:
x-microsoft-antispam-prvs: <DM5PR12MB19326BA73D55EC23E890F23DFD390@DM5PR12MB1932.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(396003)(366004)(199004)(189003)(103116003)(6116002)(53936002)(486006)(14444005)(256004)(8676002)(316002)(2906002)(7736002)(81166006)(305945005)(81156014)(110136005)(2501003)(72206003)(6436002)(6486002)(14454004)(476003)(5660300002)(68736007)(478600001)(25786009)(99286004)(386003)(6506007)(3846002)(66556008)(6512007)(52116002)(66446008)(71200400001)(66476007)(64756008)(26005)(73956011)(71190400001)(66946007)(8936002)(66066001)(2201001)(86362001)(186003)(97736004)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1932;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NcjNrK/EQWwmHuu/kfVPmIwBTbsK6ZAclYSqpEkjNePFNvf8pELwTwKZUP496flvXvcrS4iY7tSIZ4HfUDaIcLra7NC2CB7ogQ18CdF5Tfr7zA5IjDyVzw8szkyQ6ZGt5SLW+KMk66GTaKPYzenWtUvrcZtj25SCBG8wNo1YMql/fx3R3RvWzHO74MYi9jz+8X2CPsBEETBv9MCHQkqtD6Fhh/xKqJxfgnaBy5GAaDiwTDu2pfTAkumHWLYIj0GwNlGrzW1N1sC0KNZEEymkHSMh7I/g+BX648Te6j+gjUQBKdC5o7A19WN3a20e/VzuTJe2nlsioQCBX1KHNN7e4HwK35ZkDWc1/wiedT0MJi0DUxN1CSdG+YOFsZEW0VKDhk4nTCYGmoETJAtm2ojU07QOvOo7enEPhLhp1YSbfxs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69B1D0A9410F7042AF758D42183F5483@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba4a355-10d7-4e5a-c5d3-08d6ccf13b8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 22:22:58.4880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RW5hYmxlbWVudCBvZiBBTUQncyBTZWN1cmUgTWVtb3J5IEVuY3J5cHRpb24gZmVhdHVyZSBpcyBk
ZXRlcm1pbmVkDQp2ZXJ5IGVhcmx5IGFmdGVyIHN0YXJ0X2tlcm5lbCgpIGlzIGVudGVyZWQuIFBh
cnQgb2YgdGhpcyBwcm9jZWR1cmUNCmludm9sdmVzIHNjYW5uaW5nIHRoZSBjb21tYW5kIGxpbmUg
Zm9yIHRoZSBwYXJhbWV0ZXIgJ21lbV9lbmNyeXB0Jy4NCg0KVG8gZGV0ZXJtaW5lIGludGVuZGVk
IHN0YXRlLCB0aGUgZnVuY3Rpb24gc21lX2VuYWJsZSgpIHVzZXMgbGlicmFyeQ0KZnVuY3Rpb25z
IGNtZGxpbmVfZmluZF9vcHRpb24oKSBhbmQgc3RybmNtcCgpLiAgVGhlaXIgdXNlIG9jY3VycyBl
YXJseQ0KZW5vdWdoIHN1Y2ggdGhhdCB3ZSBjYW4ndCBhc3N1bWUgdGhhdCBhbnkgaW5zdHJ1bWVu
dGF0aW9uIHN1YnN5c3RlbSBpcw0KaW5pdGlhbGl6ZWQuIEZvciBleGFtcGxlLCBtYWtpbmcgY2Fs
bHMgdG8gYSBLQVNBTi1pbnN0cnVtZW50ZWQNCmZ1bmN0aW9uIGJlZm9yZSBLQVNBTiBpcyBzZXQg
dXAgd2lsbCByZXN1bHQgaW4gdGhlIHVzZSBvZiB1bmluaXRpYWxpemVkDQptZW1vcnkgYW5kIGEg
Ym9vdCBmYWlsdXJlLg0KDQpXaGVuIEFNRCdzIFNNRSBzdXBwb3J0IGlzIGVuYWJsZWQsIGNvbmRp
dGlvbmFsbHkgZGlzYWJsZSBpbnN0cnVtZW50YXRpb24NCm9mIHRoZXNlIGRlcGVuZGVudCBmdW5j
dGlvbnMgaW4gbGliL3N0cmluZy5jIGFuZCBhcmNoL3g4Ni9saWIvY21kbGluZS5jLg0KDQpGaXhl
czogYWNhMjBkNTQ2MjE0ICAoIng4Ni9tbTogQWRkIHN1cHBvcnQgdG8gbWFrZSB1c2Ugb2YgU2Vj
dXJlIE1lbW9yeSBFbmNyeXB0aW9uIikNClJlcG9ydGVkLWJ5OiBMaSBSb25nUWluZyA8bGlyb25n
cWluZ0BiYWlkdS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBHYXJ5IFIgSG9vayA8Z2FyeS5ob29rQGFt
ZC5jb20+DQotLS0NCiBhcmNoL3g4Ni9saWIvTWFrZWZpbGUgfCAgIDE2ICsrKysrKysrKysrKysr
KysNCiBsaWIvTWFrZWZpbGUgICAgICAgICAgfCAgIDE0ICsrKysrKysrKysrKysrDQogMiBmaWxl
cyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9saWIv
TWFrZWZpbGUgYi9hcmNoL3g4Ni9saWIvTWFrZWZpbGUNCmluZGV4IDE0MGU2MTg0M2EwNy4uYjVi
OTMyMTI0MjgwIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYvbGliL01ha2VmaWxlDQorKysgYi9hcmNo
L3g4Ni9saWIvTWFrZWZpbGUNCkBAIC02LDYgKzYsMjIgQEANCiAjIFByb2R1Y2VzIHVuaW50ZXJl
c3RpbmcgZmxha3kgY292ZXJhZ2UuDQogS0NPVl9JTlNUUlVNRU5UX2RlbGF5Lm8JOj0gbg0KIA0K
K2lmZGVmIENPTkZJR19BTURfTUVNX0VOQ1JZUFQNCisjDQorIyBFYXJseSBib290IHVzZSBvZiBj
bWRsaW5lOyBkb24ndCBpbnN0cnVtZW50IGl0DQorIw0KK0tDT1ZfSU5TVFJVTUVOVF9jbWRsaW5l
Lm8gICAgICAgICAgICAgIDo9IG4NCisNCitLQVNBTl9TQU5JVElaRV9jbWRsaW5lLm8gICAgICAg
ICAgICAgICA6PSBuDQorDQoraWZkZWYgQ09ORklHX0ZVTkNUSU9OX1RSQUNFUg0KK0NGTEFHU19S
RU1PVkVfY21kbGluZS5vICAgICAgICAgICAgICAgICAgICAgICAgPSAtcGcNCitlbmRpZg0KKw0K
K25vc3RhY2twIDo9ICQoY2FsbCBjYy1vcHRpb24sIC1mbm8tc3RhY2stcHJvdGVjdG9yKQ0KK0NG
TEFHU19jbWRsaW5lLm8gICAgICAgICAgICAgICA6PSAkKG5vc3RhY2twKQ0KK2VuZGlmDQorDQog
aW5hdF90YWJsZXNfc2NyaXB0ID0gJChzcmN0cmVlKS9hcmNoL3g4Ni90b29scy9nZW4taW5zbi1h
dHRyLXg4Ni5hd2sNCiBpbmF0X3RhYmxlc19tYXBzID0gJChzcmN0cmVlKS9hcmNoL3g4Ni9saWIv
eDg2LW9wY29kZS1tYXAudHh0DQogcXVpZXRfY21kX2luYXRfdGFibGVzID0gR0VOICAgICAkQA0K
ZGlmZiAtLWdpdCBhL2xpYi9NYWtlZmlsZSBiL2xpYi9NYWtlZmlsZQ0KaW5kZXggM2IwODY3M2U4
ODgxLi4wN2Q3MTY2MmY2YjIgMTAwNjQ0DQotLS0gYS9saWIvTWFrZWZpbGUNCisrKyBiL2xpYi9N
YWtlZmlsZQ0KQEAgLTE3LDYgKzE3LDIwIEBAIEtDT1ZfSU5TVFJVTUVOVF9saXN0X2RlYnVnLm8g
Oj0gbg0KIEtDT1ZfSU5TVFJVTUVOVF9kZWJ1Z29iamVjdHMubyA6PSBuDQogS0NPVl9JTlNUUlVN
RU5UX2R5bmFtaWNfZGVidWcubyA6PSBuDQogDQoraWZkZWYgQ09ORklHX0FNRF9NRU1fRU5DUllQ
VA0KKyMNCisjIEVhcmx5IGJvb3QgdXNlIG9mIGNtZGxpbmUsIGRvbid0IGluc3RydW1lbnQgaXQN
CisjDQorS0FTQU5fU0FOSVRJWkVfc3RyaW5nLm8gICAgICAgICAgICAgICAgOj0gbg0KKw0KK2lm
ZGVmIENPTkZJR19GVU5DVElPTl9UUkFDRVINCitDRkxBR1NfUkVNT1ZFX3N0cmluZy5vICAgICAg
ICAgPSAtcGcNCitlbmRpZg0KKw0KK25vc3RhY2twIDo9ICQoY2FsbCBjYy1vcHRpb24sIC1mbm8t
c3RhY2stcHJvdGVjdG9yKQ0KK0NGTEFHU19zdHJpbmcubyAgICAgICAgICAgICAgICAgICAgICAg
IDo9ICQobm9zdGFja3ApDQorZW5kaWYNCisNCiBsaWIteSA6PSBjdHlwZS5vIHN0cmluZy5vIHZz
cHJpbnRmLm8gY21kbGluZS5vIFwNCiAJIHJidHJlZS5vIHJhZGl4LXRyZWUubyB0aW1lcnF1ZXVl
Lm8geGFycmF5Lm8gXA0KIAkgaWRyLm8gaW50X3NxcnQubyBleHRhYmxlLm8gXA0KDQo=
