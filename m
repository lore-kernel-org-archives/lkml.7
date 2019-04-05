Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7759DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CE821738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="26WIgbPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbfDEQPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:15:39 -0400
Received: from mail-eopbgr790071.outbound.protection.outlook.com ([40.107.79.71]:3244
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726643AbfDEQPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itACoOJjNcVgW8BV+1wcQnaqMm1Tfrlredk2icEmIjo=;
 b=26WIgbPoayFUzq08TJOICkePS5hb0m4C2r3FNdYHrhvFp8fxdtYjwewTNYn53dQSOYIaQNx9Y9HctGSZ4MflI4UCCEtULKaWdThbDAnBwJzzT8ieS5enTMHFFjwip+t6nLdmU7eN1V60rBI+l4apzZfIb/WY4Xts4VdLV9Hj3DA=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3627.namprd12.prod.outlook.com (20.178.199.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Fri, 5 Apr 2019 16:12:56 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0%5]) with mapi id 15.20.1750.021; Fri, 5 Apr 2019
 16:12:56 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
CC:     Ashok Raj <ashok.raj@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Grimm, Jon" <Jon.Grimm@amd.com>
Subject: Re: [RFC PATCH v2 11/14] x86/watchdog/hardlockup: Add an HPET-based
 hardlockup detector
Thread-Topic: [RFC PATCH v2 11/14] x86/watchdog/hardlockup: Add an HPET-based
 hardlockup detector
Thread-Index: AQHU68pp1tZnJZ2D6kWP10OmpUgNvA==
Date:   Fri, 5 Apr 2019 16:12:56 +0000
Message-ID: <b6d0dd2d-4b56-0055-a7e0-51af5c45f959@amd.com>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1551283518-18922-12-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1551283518-18922-12-git-send-email-ricardo.neri-calderon@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.0
x-originating-ip: [165.204.77.1]
x-clientproxiedby: SN6PR15CA0020.namprd15.prod.outlook.com
 (2603:10b6:805:16::33) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bf0f935-ff63-4abc-6b95-08d6b9e19020
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR12MB3627;
x-ms-traffictypediagnostic: DM6PR12MB3627:
x-microsoft-antispam-prvs: <DM6PR12MB362721EE001CAE362F9B1EDBF3510@DM6PR12MB3627.namprd12.prod.outlook.com>
x-forefront-prvs: 0998671D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(346002)(376002)(39860400002)(199004)(189003)(7416002)(8676002)(54906003)(256004)(7736002)(478600001)(5660300002)(97736004)(305945005)(6512007)(6486002)(14444005)(81166006)(6436002)(71200400001)(2906002)(58126008)(66066001)(2616005)(65826007)(11346002)(106356001)(8936002)(486006)(316002)(446003)(31686004)(229853002)(476003)(102836004)(386003)(86362001)(6246003)(186003)(105586002)(71190400001)(72206003)(65806001)(81156014)(110136005)(65956001)(6506007)(6116002)(68736007)(26005)(36756003)(64126003)(76176011)(4326008)(14454004)(25786009)(99286004)(52116002)(53936002)(53546011)(3846002)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3627;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xAeyYGXDDLddo3z+S74sHt6Rg0dZjc0oJ2KrtmL6W1PzMNjRkcuPfXG+TPvOrDXv8SwGWK0WTSGpDU1s800G3wppj6yoZHADSqDqSdEkhlYM9eiTXcJB+qumQmg9NLL24yiMmxvHDK42YMdy01sWHzwhM1td3ZiVIF291+ZuIcpP2/ymEFQMDzEsQn112SLjHe8Xu4qVD19a6nQkDv3reYwqtumHKvOKBGqtKbIm9LYbsdnCvsUeMKR5JdhbimYaaIc+kRyjsmgLPUyYhw3eJ0mzz19Ui+iF4koiAGrU0EmdZ7yLKiyfMX49rl5sKELfdGMMP+B+UryoAgtIhg5vE5HodzxdAPAv7jXZUwCY43/RXBskdoDAE6BZCJAluuQuBK+Ss3pFNCeZKA2W6d94472oQppT1v7/km8jjyVTRio=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D2569D468E36B4A811C4567760C9FC7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf0f935-ff63-4abc-6b95-08d6b9e19020
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2019 16:12:56.0900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3627
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmVyaSwNCg0KV2hpbGUgdHJ5aW5nIG91dCB0aGlzIHBhdGNoIHNlcmllcywgSSBmb3VuZCB0
aGF0IGl0IGRvZXMgbm90IHdvcmsgd2hlbiB0aGUgSFBFVCB0aW1lcg0KaXMgaW4gcGVyaW9kaWMg
bW9kZS4NCg0KT24gMi8yNy8xOSAxMTowNSBQTSwgUmljYXJkbyBOZXJpIHdyb3RlOg0KPiAuLi4u
Li4NCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC93YXRjaGRvZ19obGRfaHBldC5jIGIv
YXJjaC94ODYva2VybmVsL3dhdGNoZG9nX2hsZF9ocGV0LmMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi5jZmEyODRkYTRiZjYNCj4gLS0tIC9kZXYvbnVsbA0K
PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvd2F0Y2hkb2dfaGxkX2hwZXQuYw0KPiBAQCAtMCwwICsx
LDQwNSBAQA0KPiAuLi4uLg0KPiArDQo+ICsvKioNCj4gKyAqIHNldF9jb21wYXJhdG9yKCkgLSBV
cGRhdGUgdGhlIGNvbXBhcmF0b3IgaW4gYW4gSFBFVCB0aW1lciBpbnN0YW5jZQ0KPiArICogQGhk
YXRhOglBIGRhdGEgc3RydWN0dXJlIHdpdGggdGhlIHRpbWVyIGluc3RhbmNlIHRvIHVwZGF0ZQ0K
PiArICogQGNtcDoJVGhlIHZhbHVlIHRvIHdyaXRlIGluIHRoZSBpbiB0aGUgY29tcGFyYXRvciBy
ZWdpc3RlcmUNCj4gKyAqDQo+ICsgKiBSZXR1cm5zOg0KPiArICoNCj4gKyAqIE5vbmUNCj4gKyAq
Lw0KPiArc3RhdGljIGlubGluZSB2b2lkIHNldF9jb21wYXJhdG9yKHN0cnVjdCBocGV0X2hsZF9k
YXRhICpoZGF0YSwNCj4gKwkJCQkgIHVuc2lnbmVkIGxvbmcgY21wKQ0KPiArew0KPiArCWhwZXRf
d3JpdGVxKGNtcCwgSFBFVF9Ubl9DTVAoaGRhdGEtPm51bSkpOw0KPiArfQ0KPiArDQo+ICsvKioN
Cj4gKyAqIGtpY2tfdGltZXIoKSAtIFJlcHJvZ3JhbSB0aW1lciB0byBleHBpcmUgaW4gdGhlIGZ1
dHVyZQ0KPiArICogQGhkYXRhOglBIGRhdGEgc3RydWN0dXJlIHdpdGggdGhlIHRpbWVyIGluc3Rh
bmNlIHRvIHVwZGF0ZQ0KPiArICogQGZvcmNlOglGb3JjZSByZXByb2dyYW0uIFVzZWZ1bCBlbmFi
bGluZyBvciByZS1lbmFibGluZyBkZXRlY3Rvci4NCj4gKyAqDQo+ICsgKiBSZXByb2dyYW0gdGhl
IHRpbWVyIHRvIGV4cGlyZSB3aXRoaW4gd2F0Y2hkb2dfdGhyZXNoIHNlY29uZHMgaW4gdGhlIGZ1
dHVyZS4NCj4gKyAqDQo+ICsgKiBSZXR1cm5zOg0KPiArICoNCj4gKyAqIE5vbmUNCj4gKyAqLw0K
PiArc3RhdGljIHZvaWQga2lja190aW1lcihzdHJ1Y3QgaHBldF9obGRfZGF0YSAqaGRhdGEsIGJv
b2wgZm9yY2UpDQo+ICt7DQo+ICsJYm9vbCBraWNrX25lZWRlZCA9IGZvcmNlIHx8ICEoaGRhdGEt
PmZsYWdzICYgSFBFVF9ERVZfUEVSSV9DQVApOw0KPiArCXVuc2lnbmVkIGxvbmcgbmV3X2NvbXBh
cmUsIGNvdW50Ow0KPiArDQo+ICsJLyoNCj4gKwkgKiBVcGRhdGUgdGhlIGNvbXBhcmF0b3IgaW4g
aW5jcmVtZW50cyBvZiB3YXRjaF90aHJlc2ggc2Vjb25kcyByZWxhdGl2ZQ0KPiArCSAqIHRvIHRo
ZSBjdXJyZW50IGNvdW50LiBTaW5jZSB3YXRjaF90aHJlc2ggaXMgZ2l2ZW4gaW4gc2Vjb25kcywg
d2UNCj4gKwkgKiBhcmUgYWJsZSB0byB1cGRhdGUgdGhlIGNvbXBhcmF0b3IgYmVmb3JlIHRoZSBj
b3VudGVyIHJlYWNoZXMgc3VjaCBuZXcNCj4gKwkgKiB2YWx1ZS4NCj4gKwkgKg0KPiArCSAqIExl
dCBpdCB3cmFwIGFyb3VuZCBpZiBuZWVkZWQuDQo+ICsJICovDQo+ICsNCj4gKwlpZiAoa2lja19u
ZWVkZWQpIHsNCj4gKwkJY291bnQgPSBnZXRfY291bnQoKTsNCj4gKw0KPiArCQluZXdfY29tcGFy
ZSA9IGNvdW50ICsgd2F0Y2hkb2dfdGhyZXNoICogaGRhdGEtPnRpY2tzX3Blcl9zZWNvbmQ7DQo+
ICsNCj4gKwkJc2V0X2NvbXBhcmF0b3IoaGRhdGEsIG5ld19jb21wYXJlKTsNCj4gKwl9DQo+ICt9
DQoNCkl0IHR1cm5zIG91dCB0aGF0IHRoZSBzZXRfY29tcGFyYXRvcigpIGRvZXMgbm90IHNlZW0g
dG8gc3VwcG9ydCBwZXJpb2RpYyBtb2RlLA0KaW4gd2hpY2ggaXQgc2hvdWxkIGhhdmUgYmVlbiBz
ZXR0aW5nIHRoZSBhY2N1bXVsYXRvci9wZXJpb2QgdmlhIHRoZSBjb21wYXJhdG9yIHJlZ2lzdGVy
Lg0KDQpJbnN0ZWFkLCB3aGF0IGlmIHdlIHJlLWZhY3RvciB0aGUgY29kZSBpbiB0aGUgYXJjaC94
ODYva2VybmVsL2hwZXQuYzpocGV0X3NldF9wZXJpb2RpYygpDQp0byBocGV0X3NldF9jb21wYXJh
dG9yKCkuIFRoZW4gd2UgY2FuIGFsc28gcmV1c2UgaXQgaW4gdGhlIGFyY2gveDg2L2tlcm5lbC93
YXRjaGRvZ19obGRfcGV0LmM6DQpraWNrX3RpbWVyKCkgYXMgc2hvd24gYmVsb3cuDQoNCldpdGgg
dGhlc2UgY2hhbmdlcywgSSBjYW4gdGVzdCB0aGUgc2VyaWVzIG9uIEFNRCBzeXN0ZW1zLCBhbmQg
c2VlIGFsbCBjb3Jlcw0KaW4gL3Byb2MvaW50ZXJydXB0cyBhcmUgcmVjZWl2aW5nIE5NSSBpbnRl
cnJ1cHRzLg0KDQpSZWdhcmRzLA0KU3VyYXZlZQ0KDQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9ocGV0LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9ocGV0LmgNCmluZGV4IDA5
NzYzMzQuLmYzMDk1N2YgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9ocGV0LmgN
CisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2hwZXQuaA0KQEAgLTExNSw2ICsxMTUsNyBAQCBl
eHRlcm4gaW50IGhwZXRfcnRjX3RpbWVyX2luaXQodm9pZCk7DQogIGV4dGVybiBpcnFyZXR1cm5f
dCBocGV0X3J0Y19pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqZGV2X2lkKTsNCiAgZXh0ZXJuIGlu
dCBocGV0X3JlZ2lzdGVyX2lycV9oYW5kbGVyKHJ0Y19pcnFfaGFuZGxlciBoYW5kbGVyKTsNCiAg
ZXh0ZXJuIHZvaWQgaHBldF91bnJlZ2lzdGVyX2lycV9oYW5kbGVyKHJ0Y19pcnFfaGFuZGxlciBo
YW5kbGVyKTsNCitleHRlcm4gdm9pZCBocGV0X3NldF9jb21wYXJhdG9yKGludCBudW0sIHVuc2ln
bmVkIGludCBjbXAsIHVuc2lnbmVkIGludCBwZXJpb2QpOw0KDQogICNlbmRpZiAvKiBDT05GSUdf
SFBFVF9FTVVMQVRFX1JUQyAqLw0KDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2hwZXQu
YyBiL2FyY2gveDg2L2tlcm5lbC9ocGV0LmMNCmluZGV4IDAzYjA1ZGFlLi5mM2IyMzUxIDEwMDY0
NA0KLS0tIGEvYXJjaC94ODYva2VybmVsL2hwZXQuYw0KKysrIGIvYXJjaC94ODYva2VybmVsL2hw
ZXQuYw0KQEAgLTMyOCw2ICszMjgsNDEgQEAgc3RhdGljIHZvaWQgaHBldF9sZWdhY3lfY2xvY2tl
dmVudF9yZWdpc3Rlcih2b2lkKQ0KICAJcHJpbnRrKEtFUk5fREVCVUcgImhwZXQgY2xvY2tldmVu
dCByZWdpc3RlcmVkXG4iKTsNCiAgfQ0KDQorLyoNCisgKiBocGV0X3NldF9jb21wYXJhdG9yKCkg
LSBIZWxwZXIgZnVuY3Rpb24gZm9yIHNldHRpbmcgY29tcGFyYXRvciByZWdpc3Rlcg0KKyAqIEBu
dW06CVRoZSB0aW1lciBJRA0KKyAqIEBjbXA6CVRoZSB2YWx1ZSB0byBiZSB3cml0dGVuIHRvIHRo
ZSBjb21wYXJhdG9yL2FjY3VtdWxhdG9yDQorICogQHBlcmlvZDoJVGhlIHZhbHVlIHRvIGJlIHdy
aXR0ZW4gdG8gdGhlIHBlcmlvZCAoMCA9IG9uZXNob3QgbW9kZSkNCisgKg0KKyAqIEhlbHBlciBm
dW5jdGlvbiBmb3IgdXBkYXRpbmcgY29tcGFyYXRvciwgYWNjdW11bGF0b3IgYW5kIHBlcmlvZCB2
YWx1ZXMuDQorICoNCisgKiBJbiBwZXJpb2RpYyBtb2RlLCBIUEVUIG5lZWRzIEhQRVRfVE5fU0VU
VkFMIHRvIGJlIHNldCBiZWZvcmUgd3JpdGluZw0KKyAqIHRvIHRoZSBUbl9DTVAgdG8gdXBkYXRl
IHRoZSBhY2N1bXVsYXRvci4gVGhlbiwgSFBFVCBuZWVkcyBhIHNlY29uZA0KKyAqIHdyaXRlICh3
aXRoIEhQRVRfVE5fU0VUVkFMIGNsZWFyZWQpIHRvIFRuX0NNUCB0byBzZXQgdGhlIHBlcmlvZC4N
CisgKiBUaGUgSFBFVF9UTl9TRVRWQUwgYml0IGlzIGF1dG9tYXRpY2FsbHkgY2xlYXJlZCBhZnRl
ciB0aGUgZmlyc3Qgd3JpdGUuDQorICoNCisgKiBGb3Igb25lLXNob3QgbW9kZSwgSFBFVF9UTl9T
RVRWQUwgZG9lcyBub3QgbmVlZCB0byBiZSBzZXQuDQorICoNCisgKiBTZWUgdGhlIGZvbGxvd2lu
ZyBkb2N1bWVudHM6DQorICogICAtIEludGVsIElBLVBDIEhQRVQgKEhpZ2ggUHJlY2lzaW9uIEV2
ZW50IFRpbWVycykgU3BlY2lmaWNhdGlvbg0KKyAqICAgLSBBTUQtODExMSBIeXBlclRyYW5zcG9y
dCBJL08gSHViIERhdGEgU2hlZXQsIFB1YmxpY2F0aW9uICMgMjQ2NzQNCisgKi8NCit2b2lkIGhw
ZXRfc2V0X2NvbXBhcmF0b3IoaW50IG51bSwgdW5zaWduZWQgaW50IGNtcCwgdW5zaWduZWQgaW50
IHBlcmlvZCkNCit7DQorCWlmIChwZXJpb2QpIHsNCisJCXVuc2lnbmVkIGludCB2ID0gaHBldF9y
ZWFkbChIUEVUX1RuX0NGRyhudW0pKTsNCisJCWhwZXRfd3JpdGVsKHYgfCBIUEVUX1ROX1NFVFZB
TCwgSFBFVF9Ubl9DRkcobnVtKSk7DQorCX0NCisNCisJaHBldF93cml0ZWwoY21wLCBIUEVUX1Ru
X0NNUChudW0pKTsNCisJaWYgKCFwZXJpb2QpDQorCQlyZXR1cm47DQorDQorCXVkZWxheSgxKTsN
CisJaHBldF93cml0ZWwocGVyaW9kLCBIUEVUX1RuX0NNUChudW0pKTsNCit9DQorRVhQT1JUX1NZ
TUJPTF9HUEwoaHBldF9zZXRfY29tcGFyYXRvcik7DQorDQogIHN0YXRpYyBpbnQgaHBldF9zZXRf
cGVyaW9kaWMoc3RydWN0IGNsb2NrX2V2ZW50X2RldmljZSAqZXZ0LCBpbnQgdGltZXIpDQogIHsN
CiAgCXVuc2lnbmVkIGludCBjZmcsIGNtcCwgbm93Ow0KQEAgLTMzOSwxOSArMzc0LDExIEBAIHN0
YXRpYyBpbnQgaHBldF9zZXRfcGVyaW9kaWMoc3RydWN0IGNsb2NrX2V2ZW50X2RldmljZSAqZXZ0
LCBpbnQgdGltZXIpDQogIAlub3cgPSBocGV0X3JlYWRsKEhQRVRfQ09VTlRFUik7DQogIAljbXAg
PSBub3cgKyAodW5zaWduZWQgaW50KWRlbHRhOw0KICAJY2ZnID0gaHBldF9yZWFkbChIUEVUX1Ru
X0NGRyh0aW1lcikpOw0KLQljZmcgfD0gSFBFVF9UTl9FTkFCTEUgfCBIUEVUX1ROX1BFUklPRElD
IHwgSFBFVF9UTl9TRVRWQUwgfA0KLQkgICAgICAgSFBFVF9UTl8zMkJJVDsNCisJY2ZnIHw9IEhQ
RVRfVE5fRU5BQkxFIHwgSFBFVF9UTl9QRVJJT0RJQyB8IEhQRVRfVE5fMzJCSVQ7DQogIAlocGV0
X3dyaXRlbChjZmcsIEhQRVRfVG5fQ0ZHKHRpbWVyKSk7DQotCWhwZXRfd3JpdGVsKGNtcCwgSFBF
VF9Ubl9DTVAodGltZXIpKTsNCi0JdWRlbGF5KDEpOw0KLQkvKg0KLQkgKiBIUEVUIG9uIEFNRCA4
MXh4IG5lZWRzIGEgc2Vjb25kIHdyaXRlICh3aXRoIEhQRVRfVE5fU0VUVkFMDQotCSAqIGNsZWFy
ZWQpIHRvIFQwX0NNUCB0byBzZXQgdGhlIHBlcmlvZC4gVGhlIEhQRVRfVE5fU0VUVkFMDQotCSAq
IGJpdCBpcyBhdXRvbWF0aWNhbGx5IGNsZWFyZWQgYWZ0ZXIgdGhlIGZpcnN0IHdyaXRlLg0KLQkg
KiAoU2VlIEFNRC04MTExIEh5cGVyVHJhbnNwb3J0IEkvTyBIdWIgRGF0YSBTaGVldCwNCi0JICog
UHVibGljYXRpb24gIyAyNDY3NCkNCi0JICovDQotCWhwZXRfd3JpdGVsKCh1bnNpZ25lZCBpbnQp
ZGVsdGEsIEhQRVRfVG5fQ01QKHRpbWVyKSk7DQorDQorCWhwZXRfc2V0X2NvbXBhcmF0b3IodGlt
ZXIsIGNtcCwgKHVuc2lnbmVkIGludClkZWx0YSk7DQorDQogIAlocGV0X3N0YXJ0X2NvdW50ZXIo
KTsNCiAgCWhwZXRfcHJpbnRfY29uZmlnKCk7DQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJu
ZWwvd2F0Y2hkb2dfaGxkX2hwZXQuYyBiL2FyY2gveDg2L2tlcm5lbC93YXRjaGRvZ19obGRfaHBl
dC5jDQppbmRleCA0NDAyZGVmLi5kZTMzYzUwIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva2VybmVs
L3dhdGNoZG9nX2hsZF9ocGV0LmMNCisrKyBiL2FyY2gveDg2L2tlcm5lbC93YXRjaGRvZ19obGRf
aHBldC5jDQpAQCAtMzUsMjEgKzM1LDYgQEAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIGdl
dF9jb3VudCh2b2lkKQ0KICB9DQoNCiAgLyoqDQotICogc2V0X2NvbXBhcmF0b3IoKSAtIFVwZGF0
ZSB0aGUgY29tcGFyYXRvciBpbiBhbiBIUEVUIHRpbWVyIGluc3RhbmNlDQotICogQGhkYXRhOglB
IGRhdGEgc3RydWN0dXJlIHdpdGggdGhlIHRpbWVyIGluc3RhbmNlIHRvIHVwZGF0ZQ0KLSAqIEBj
bXA6CVRoZSB2YWx1ZSB0byB3cml0ZSBpbiB0aGUgaW4gdGhlIGNvbXBhcmF0b3IgcmVnaXN0ZXJl
DQotICoNCi0gKiBSZXR1cm5zOg0KLSAqDQotICogTm9uZQ0KLSAqLw0KLXN0YXRpYyBpbmxpbmUg
dm9pZCBzZXRfY29tcGFyYXRvcihzdHJ1Y3QgaHBldF9obGRfZGF0YSAqaGRhdGEsDQotCQkJCSAg
dW5zaWduZWQgbG9uZyBjbXApDQotew0KLQlocGV0X3dyaXRlcShjbXAsIEhQRVRfVG5fQ01QKGhk
YXRhLT5udW0pKTsNCi19DQotDQotLyoqDQogICAqIGtpY2tfdGltZXIoKSAtIFJlcHJvZ3JhbSB0
aW1lciB0byBleHBpcmUgaW4gdGhlIGZ1dHVyZQ0KICAgKiBAaGRhdGE6CUEgZGF0YSBzdHJ1Y3R1
cmUgd2l0aCB0aGUgdGltZXIgaW5zdGFuY2UgdG8gdXBkYXRlDQogICAqIEBmb3JjZToJRm9yY2Ug
cmVwcm9ncmFtLiBVc2VmdWwgZW5hYmxpbmcgb3IgcmUtZW5hYmxpbmcgZGV0ZWN0b3IuDQpAQCAt
NjgsNyArNTMsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgc2V0X2NvbXBhcmF0b3Ioc3RydWN0IGhw
ZXRfaGxkX2RhdGEgKmhkYXRhLA0KICBzdGF0aWMgdm9pZCBraWNrX3RpbWVyKHN0cnVjdCBocGV0
X2hsZF9kYXRhICpoZGF0YSwgYm9vbCBmb3JjZSkNCiAgew0KICAJYm9vbCBraWNrX25lZWRlZCA9
IGZvcmNlIHx8ICEoaGRhdGEtPmZsYWdzICYgSFBFVF9ERVZfUEVSSV9DQVApOw0KLQl1bnNpZ25l
ZCBsb25nIHRzY19jdXJyLCB0c2NfZGVsdGEsIG5ld19jb21wYXJlLCBjb3VudDsNCisJdW5zaWdu
ZWQgbG9uZyB0c2NfY3VyciwgdHNjX2RlbHRhLCBuZXdfY29tcGFyZSwgY291bnQsIHBlcmlvZCA9
IDA7DQoNCiAgCS8qIFN0YXJ0IG9idGFpbmluZyB0aGUgY3VycmVudCBUU0MgYW5kIEhQRVQgY291
bnRzLiAqLw0KICAJdHNjX2N1cnIgPSByZHRzYygpOw0KQEAgLTgxLDYgKzY2LDkgQEAgc3RhdGlj
IHZvaWQga2lja190aW1lcihzdHJ1Y3QgaHBldF9obGRfZGF0YSAqaGRhdGEsIGJvb2wgZm9yY2Up
DQogIAloZGF0YS0+dHNjX25leHQgPSB0c2NfY3VyciArIHRzY19kZWx0YTsNCiAgCWhkYXRhLT50
c2NfbmV4dF9lcnJvciA9IHRzY19kZWx0YSA+PiA2Ow0KDQorCWlmICgha2lja19uZWVkZWQpDQor
CQlyZXR1cm47DQorDQogIAkvKg0KICAJICogVXBkYXRlIHRoZSBjb21wYXJhdG9yIGluIGluY3Jl
bWVudHMgb2Ygd2F0Y2hfdGhyZXNoIHNlY29uZHMgcmVsYXRpdmUNCiAgCSAqIHRvIHRoZSBjdXJy
ZW50IGNvdW50LiBTaW5jZSB3YXRjaF90aHJlc2ggaXMgZ2l2ZW4gaW4gc2Vjb25kcywgd2UNCkBA
IC04OSwxMiArNzcsMTEgQEAgc3RhdGljIHZvaWQga2lja190aW1lcihzdHJ1Y3QgaHBldF9obGRf
ZGF0YSAqaGRhdGEsIGJvb2wgZm9yY2UpDQogIAkgKg0KICAJICogTGV0IGl0IHdyYXAgYXJvdW5k
IGlmIG5lZWRlZC4NCiAgCSAqLw0KKwlpZiAoaGRhdGEtPmZsYWdzICYgSFBFVF9ERVZfUEVSSV9D
QVApDQorCQlwZXJpb2QgPSB3YXRjaGRvZ190aHJlc2ggKiBoZGF0YS0+dGlja3NfcGVyX3NlY29u
ZDsNCg0KLQlpZiAoa2lja19uZWVkZWQpIHsNCi0JCW5ld19jb21wYXJlID0gY291bnQgKyB3YXRj
aGRvZ190aHJlc2ggKiBoZGF0YS0+dGlja3NfcGVyX3NlY29uZDsNCi0NCi0JCXNldF9jb21wYXJh
dG9yKGhkYXRhLCBuZXdfY29tcGFyZSk7DQotCX0NCisJbmV3X2NvbXBhcmUgPSBjb3VudCArIHBl
cmlvZDsNCisJaHBldF9zZXRfY29tcGFyYXRvcihoZGF0YS0+bnVtLCBuZXdfY29tcGFyZSwgcGVy
aW9kKTsNCiAgfQ0KDQogIC8qKg0KLS0gDQoyLjcuNA0K
