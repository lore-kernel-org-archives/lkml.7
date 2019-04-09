Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A097C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18B42084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PqtHFtaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfDINsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:48:25 -0400
Received: from mail-eopbgr690079.outbound.protection.outlook.com ([40.107.69.79]:51174
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbfDINsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTiulF2Gf26GVnRRNqb8PyB55EluwHDMt2h6B7ky+GI=;
 b=PqtHFtaINM5t21z4PTt90raHhDoMLfI8/t2qCiEWgEIima/dwX9R45SR6btfgEDCIbPfjMUFV6YtHP0W+ek369iJA9S+t/29H/ZM2Px0p2MgIjTtsuBQhsQCS9xSO6zzyVHLc75b+z3COsIUXZ0d/y6q1BrWL88YCL6IBl0wTH8=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3036.namprd12.prod.outlook.com (20.178.30.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Tue, 9 Apr 2019 13:47:41 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::c96d:c1dd:fd7a:ffd6]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::c96d:c1dd:fd7a:ffd6%4]) with mapi id 15.20.1792.009; Tue, 9 Apr 2019
 13:47:41 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Borislav Petkov <bp@alien8.de>, "Hook, Gary" <Gary.Hook@amd.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "Hook, Gary" <Gary.Hook@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] x86/mm/mem_encrypt: Disable all instrumentation for SME
 early boot code
Thread-Topic: [PATCH] x86/mm/mem_encrypt: Disable all instrumentation for SME
 early boot code
Thread-Index: AQHU6yS/AQVIYa78D0OsnFnDJRviWKYsd26AgAYHgoCAAANhgIAAHMIAgAAHZwCAATjSAA==
Date:   Tue, 9 Apr 2019 13:47:41 +0000
Message-ID: <e1252d23-2eaa-6661-160e-cb21a3329d32@amd.com>
References: <155440965936.6194.3202659723198724589.stgit@sosrh7.amd.com>
 <alpine.DEB.2.21.1904042237020.1802@nanos.tec.linutronix.de>
 <5dfcb133-0a0e-9e07-3774-313e30814e79@amd.com>
 <20190408165835.GJ15689@zn.tnic>
 <8a14050e-2516-5c0f-195d-611c6959b94b@amd.com>
 <20190408190800.GL15689@zn.tnic>
In-Reply-To: <20190408190800.GL15689@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR16CA0067.namprd16.prod.outlook.com
 (2603:10b6:805:ca::44) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1df7d06-47f3-45bc-8738-08d6bcf1ef61
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3036;
x-ms-traffictypediagnostic: DM6PR12MB3036:
x-microsoft-antispam-prvs: <DM6PR12MB30364CA9E90777DE2386A49AEC2D0@DM6PR12MB3036.namprd12.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(396003)(136003)(199004)(189003)(81166006)(8676002)(11346002)(81156014)(36756003)(53936002)(106356001)(229853002)(256004)(105586002)(25786009)(6436002)(6636002)(2906002)(110136005)(6486002)(54906003)(3846002)(6246003)(6116002)(14454004)(31686004)(66066001)(93886005)(71190400001)(5660300002)(6512007)(71200400001)(7736002)(8936002)(316002)(305945005)(76176011)(53546011)(52116002)(4326008)(99286004)(102836004)(6506007)(68736007)(386003)(72206003)(478600001)(26005)(31696002)(86362001)(186003)(486006)(446003)(97736004)(476003)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3036;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HzSIoHxLkDqZy5GxZIZe0/YzYfMic8+xCAVc/3t80bM3EfmarJT27aDKN0NR0v673WO9GG1AkwqOOvczTaHEmqOyzFDoNqsAx9dvExCyas4J9OgO142a+iDJAkyQebPmmDNPigUW6tmIaOcTEEkioErc52vuQJESizi5YubEq7VnU3d6sB2T7UGJtWmXTSS5KajOS8g7zecv/C8+frnS2Zc1oZFbrRVo1lt2FRdmnUnE1dK07TFwMnQks2KwUAZrGu3XvLeHvgDda11Q5+cOrUbdyyEtxKpi/Et4Wxi2mWJcknxFe6BueRKF+BbXN3SVLv90O5RRPOWVVTaoC/MELVK54VqvlqEG48BoLzpOmdifFd36BquR1xEnQJtr0htSwxpFzH+hilDWJ+jbIGFKH0Q6kZ0NnnDYrOM+5NtkwKM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A91C0DBF72CBC499ED5C016C6C7C556@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1df7d06-47f3-45bc-8738-08d6bcf1ef61
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 13:47:41.1592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC84LzE5IDI6MDggUE0sIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gTW9uLCBBcHIg
MDgsIDIwMTkgYXQgMDY6NDE6MzBQTSArMDAwMCwgR2FyeSBSIEhvb2sgd3JvdGU6DQo+PiBBZ2Fp
biwgbm90IGFyZ3VpbmcuIEkgY29tcGxldGVseSB1bmRlcnN0YW5kLiBIb3dldmVyLCB0byBiZSBm
YWlyLCB0aGlzIA0KPj4gaXNuJ3QgYWJvdXQgU01FIGhhdmluZyB0cm91YmxlIHdpdGggdGhvc2Ug
ZmFjaWxpdGllcywgdGhpcyBpcyBhYm91dCANCj4+IHVzaW5nIGNlcnRhaW4gZmVhdHVyZXMgKGUu
Zy4gY29tbWFuZCBsaW5lIG9wdGlvbiBwcm9jZXNzaW5nKSBlYXJseSBpbiANCj4+IHRoZSBib290
LiBBbnkgY29tcGxleCBmZWF0dXJlIGNvdWxkIGhhdmUgaGFkIHRoYXQgcmVxdWlyZW1lbnQsIGRv
bid0IHlvdSANCj4+IHRoaW5rPw0KPiANCj4gU3VyZSwgYnV0IHRoZW4gd2h5IGRvIHdlIG5lZWQg
dGhhdCBwYXRjaCBhdCBhbGwgdGhlbj8gV2h5IGRvIHdlIG5lZWQgdG8NCj4gZGlzYWJsZSBpbnN0
cnVtZW50YXRpb24gZm9yIFNNRSBlYXJseSBjb2RlIGFuZCBub3QgZm9yIG90aGVyIGVhcmx5IGNv
ZGU/DQo+IA0KPiBJIG1lYW4sIGlmIHlvdSBncmVwIGFyb3VuZCB0aGUgdHJlZSB5b3UgY2FuIHNl
ZSBhIGJ1bmNoIG9mDQo+IEtBU0FOX1NBTklUSVpFIGJ1dCBpbiBsaWIvIHdlIG9ubHkgaGF2ZQ0K
PiANCj4gbGliL01ha2VmaWxlOjIxMDpLQVNBTl9TQU5JVElaRV9zdGFja2RlcG90Lm8gOj0gbg0K
PiANCj4gd2hpY2ggaXMgc3BlY2lhbC4gQnV0IHRoZSByZXN0IG9mIHRoZSBnZW5lcmljIGNvZGUg
aW4gbGliLyBvcg0KPiBhcmNoL3g4Ni9saWIvIGlzbid0Lg0KPiANCj4gTm93LCB0aGVyZSdzIHRo
aXM6DQo+IA0KPiBhcmNoL3g4Ni9ib290L01ha2VmaWxlOjEyOktBU0FOX1NBTklUSVpFICAgICAg
ICAgICAgICAgICAgICAgICAgOj0gbg0KPiBhcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvTWFrZWZp
bGU6MjA6S0FTQU5fU0FOSVRJWkUgICAgICAgICAgICAgICAgICAgICA6PSBuDQo+IA0KPiB3aGlj
aCBkaXNhYmxlcyBLQVNBTiBmb3IgYWxsIGJvb3QgY29kZS4NCj4gDQo+IEFuZCB0aGlzIGlzIHdo
YXQgeW91IG1lYW4gLSBhbGwgZWFybHkgYm9vdCBjb2RlIHNob3VsZCBub3QgYmUgc2FuaXRpemVk
Lg0KPiANCj4gV2hpY2ggYWxzbyBnaXZlcyB0aGUgcmlnaHQgc29sdXRpb24sIElNTzoNCj4gDQo+
IGNtZGxpbmUubyBzaG91bGQgbm90IGJlIHNhbml0aXplZCBvbmx5IHdoZW4gdXNlZCBpbiB0aGUg
Ym9vdCBjb2RlLiBCdXQNCj4gdGhhdCBpcyBhbHJlYWR5IHRoZSBjYXNlLg0KPiANCj4gU28gd2h5
IGRvIHlvdSBuZWVkIHRvIGRpc2FibGUgS0FTQU4gZm9yIGFyY2gveDg2L2xpYi9jbWRsaW5lLmM/
DQo+IA0KPiBCZWNhdXNlIGZvciB0aG9zZSB0d286DQo+IA0KPiBhcmNoL3g4Ni9ib290L2NtZGxp
bmUuYw0KPiBhcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvY21kbGluZS5jDQo+IA0KPiB0aGF0IHNo
b3VsZCBhbHJlYWR5IGJlIHRoZSBjYXNlIGR1ZSB0byB0aGUgTWFrZWZpbGUgZGVmaW5lcyBhYm92
ZS4NCg0KVGhpcyBpc24ndCB0aGUgY29kZSBpbiBhcmNoL3g4Ni9ib290LiBUaGlzIGlzIHBvc3Qg
ZGVjb21wcmVzc2lvbiBwaGFzZSBhbmQNCnBhcnQgb2YgdGhlIGFjdHVhbCBrZXJuZWwgZWFybHkg
Ym9vdCBjb2RlIHdoZXJlIHRoZSBwYWdlIHRhYmxlcyBhcmUgYmVpbmcNCm1vZGlmaWVkIHdpdGgg
dGhlIGVuY3J5cHRpb24gbWFzayBhbmQgdGhlIGFjdHVhbCBrZXJuZWwgbG9hZCBhZGRyZXNzIChz
ZWUNCnRoZSBzbWVfZW5hYmxlKCkgY2FsbCBmcm9tIF9fc3RhcnR1cF82NCgpIGluIGFyY2gveDg2
L2tlcm5lbC9oZWFkNjQuYykuDQoNCj4gDQo+PiBSaWdodC4gTXkgZ29hbCB3YXMgdG8gZ2V0IGEg
Y29udmVyc2F0aW9uIHN0YXJ0ZWQsIGJlY2F1c2UgZm9sa3MgYXJlDQo+PiBydW5uaW5nIGludG8g
dGhpcyBwcm9ibGVtIHdoZW4gS0FTQU4gaXMgZW5hYmxlZC4NCj4gDQo+IFlvdSBzYXkgS0FTQU4u
IFdoeSBpcyB0aGVyZSBLQ09WX0lOU1RSVU1FTlRfY21kbGluZS5vIHRvbz8NCj4gDQo+PiBOLkIu
IEhlcmUncyBhbm90aGVyIGZhY2V0IG9mIHRoaXMgcHJvYmxlbTogY21kbGluZS5jIGRvZXNuJ3Qg
KHRvZGF5KSANCj4+IGNvbnRhaW4gYW55dGhpbmcgdGhhdCB3b3VsZCB0cmlnZ2VyIHRoZSBzdGFj
ayBwcm90ZWN0b3IuIEhvd2V2ZXIsIGl0J3MgDQo+PiBwb3NzaWJsZSB0byBlbmFibGUgdGhlIHN0
YWNrIHByb3RlY3RvciBnbG9iYWxseSB3aGVuIGJ1aWxkaW5nLCByaWdodD8gSW4gDQo+PiB3aGlj
aCBjYXNlLCBhIGJvb3Qgd291bGQgZmFpbCwgc28gd2UgaGF2ZSB0aGUgc2FtZSBpc3N1ZTogZWFy
bHkgYm9vdCANCj4+IGNvZGUgaGFzIHNwZWNpYWwgcmVxdWlyZW1lbnRzIC8gcmVzdHJpY3Rpb25z
Lg0KPiANCj4gSG93IHNvPw0KPiANCj4gVGhpcyAuY29uZmlnIGJvb3RzIGhlcmUgaW4gYSB2bSBq
dXN0IGZpbmUuDQoNClRoZSBTTUUgcGF0aCB0aGF0IHRoaXMgYWRkcmVzc2VzIGlzIGJ5cGFzc2Vk
IHdoZW4geW91IGJvb3QgaW4gYSBWTS4gVGhlDQpzbWVfZW5hYmxlKCkgY29kZSBkZXRlY3RzIHRo
YXQgaXQgaXMgZXhlY3V0aW5nIHVuZGVyIGEgaHlwZXJ2aXNvciBhbmQgZG9lcw0Kbm90IGNoZWNr
IHRoZSBjb21tYW5kIGxpbmUgb3IgZG8gYSBzdHJpbmcgY29tcGFyZS4NCg0KVGhhbmtzLA0KVG9t
DQoNCj4gDQo+ICQgZ3JlcCBTVEFDS1BST1QgLmNvbmZpZw0KPiBDT05GSUdfQ0NfSEFTX1NBTkVf
U1RBQ0tQUk9URUNUT1I9eQ0KPiBDT05GSUdfSEFWRV9TVEFDS1BST1RFQ1RPUj15DQo+IENPTkZJ
R19DQ19IQVNfU1RBQ0tQUk9URUNUT1JfTk9ORT15DQo+IENPTkZJR19TVEFDS1BST1RFQ1RPUj15
DQo+IENPTkZJR19TVEFDS1BST1RFQ1RPUl9TVFJPTkc9eQ0KPiANCg==
