Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AB9C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5C02083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="InZahNqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbfFFPye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:54:34 -0400
Received: from mail-eopbgr690066.outbound.protection.outlook.com ([40.107.69.66]:45125
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729191AbfFFPyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiCd8iPy1QyMge8qYep9/jgfNiQXBaiRyLmfn0MRF7c=;
 b=InZahNqsxQwSdXK0T658g3nUwf7ZOVUoE0xVP+beWcY/5kztFRWQR8QzgzyV6m3tjN4QAEA042+X0knBBARPiPdMHry0kYjvb1rk1Q9XcBebS/aPwTPfhKVXllVSwG6poLQ6hGVmdfnMoQ+LgDYlUblL81PXru4cLerLXFdWxaM=
Received: from CY4PR05MB3365.namprd05.prod.outlook.com (10.171.248.19) by
 CY4PR05MB3640.namprd05.prod.outlook.com (10.171.247.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.5; Thu, 6 Jun 2019 15:54:24 +0000
Received: from CY4PR05MB3365.namprd05.prod.outlook.com
 ([fe80::442:4df6:5b71:e9d2]) by CY4PR05MB3365.namprd05.prod.outlook.com
 ([fe80::442:4df6:5b71:e9d2%3]) with mapi id 15.20.1965.011; Thu, 6 Jun 2019
 15:54:24 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Vishnu DASA <vdasa@vmware.com>,
        Adit Ranadive <aditr@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] VMCI: Fixup atomic64_t abuse
Thread-Topic: [PATCH] VMCI: Fixup atomic64_t abuse
Thread-Index: AQHVHEsQlQCviH/BJEiUtO16c/n4+6aOx6KA
Date:   Thu, 6 Jun 2019 15:54:24 +0000
Message-ID: <BC2D213B-89E4-4C14-A093-AC61EAB56830@vmware.com>
References: <20190606093428.GF3402@hirez.programming.kicks-ass.net>
In-Reply-To: <20190606093428.GF3402@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.9.1)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jhansen@vmware.com; 
x-originating-ip: [83.92.5.149]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 821af4ba-bba7-4688-c35f-08d6ea973f9d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR05MB3640;
x-ms-traffictypediagnostic: CY4PR05MB3640:
x-microsoft-antispam-prvs: <CY4PR05MB3640EB70033500C6BCA5BDAADA170@CY4PR05MB3640.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(346002)(39860400002)(199004)(189003)(51914003)(66066001)(68736007)(7736002)(478600001)(305945005)(36756003)(14454004)(8676002)(256004)(82746002)(476003)(83716004)(2616005)(53936002)(81166006)(81156014)(6506007)(5660300002)(86362001)(14444005)(486006)(446003)(11346002)(54906003)(33656002)(8936002)(316002)(99286004)(53546011)(102836004)(6116002)(25786009)(50226002)(2906002)(6246003)(229853002)(26005)(57306001)(3846002)(6916009)(186003)(66446008)(64756008)(71200400001)(66476007)(73956011)(66946007)(66556008)(76116006)(91956017)(6512007)(6486002)(4326008)(76176011)(71190400001)(6436002)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR05MB3640;H:CY4PR05MB3365.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I5RO7eVs+xeqmXlcgEKzqLxo6J/MrMbAw0GtDa0xo+TkEBGPaNfNjwYO619NoL/ExKcKSerTPBr0ocpm7eCr2eD4QC/7iWyX/wnW2oMu3ksdaeFHcTXy1ZAiSYeCSYAkjo3QNwBpT7YQJmFrJX/61CH72RgyRHycN/s3ZTYmdW462bqSBa+ZguiEgbOvavm2/1DSm89OcVQOWiWeuaJeMyf6RK3UiTRNOiblt21SWhmlj8LF6KMMm9MRldGvT9bRh4qiFhFQKgC316flQNYeZTIpl1PCEX96n7xxnMneyDUh8fb52/Oj2fJwwOpITJYJpgfRthSrX4kYpe+Ww9kTPSY1ShE9TaCMNs+GWuwfDnXrei7iBwFxBmUC/dk3Ipk8CEBqHkRfcuU5OxyvOYCCX5ey0l8iCNFI6/jzIN/enDg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A8C900F274E854B8C4B72FC39AA9719@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821af4ba-bba7-4688-c35f-08d6ea973f9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 15:54:24.5740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jhansen@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR05MB3640
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gNiBKdW4gMjAxOSwgYXQgMTE6MzQsIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiANCj4gVGhlIFZNQ0kgZHJpdmVyIGlzIGFidXNpbmcg
YXRvbWljNjRfdCBhbmQgYXRvbWljX3QsIHRoZXJlIGlzIG5vIGFjdHVhbA0KPiBhdG9taWMgUm1X
IG9wZXJhdGlvbnMgYXJvdW5kLg0KPiANCj4gUmV3cml0ZSB0aGUgY29kZSB0byB1c2UgYSByZWd1
bGFyIHU2NCB3aXRoIFJFQURfT05DRSgpIGFuZA0KPiBXUklURV9PTkNFKCkgYW5kIGEgY2FzdCB0
byAndW5zaWduZWQgbG9uZycuIFRoaXMgZnVsbHkgcHJlc2VydmVzDQo+IHdoYXRldmVyIGJyb2tl
biB0aGVyZSB3YXMgKGl0J3Mgbm90IGVuZGlhbi1zYWZlIGZvciBzdGFydGVycywgYW5kIGFsc28N
Cj4gbG9va3MgdG8gYmUgbWlzc2luZyBvcmRlcmluZykuDQoNClRoYW5rcyBmb3IgdGhlIGNsZWFu
dXAuDQoNClRoaXMgY29kZSBpcyBvbmx5IGludGVuZGVkIGZvciB1c2Ugd2l0aCB0aGUgdm1jaSBk
ZXZpY2UgZHJpdmVyLCBhbmQgdGhhdCBpcyBYODYgb25seSwgc28gZHVyaW5nIHRoZSBvcmlnaW5h
bCB1cHN0cmVhbWluZyBubyBlZmZvcnQgd2FzIG1hZGUgdG8gbWFrZSB0aGlzIHdvcmsgY29ycmVj
dGx5IG9uIGFueXRoaW5nIGVsc2UuDQoNCldpdGggdGhhdCBpbiBtaW5kLCBpdCBzaG91bGQgYmUg
ZmluZSB0byBkcm9wIHRoZSB1bnNpZ25lZCBsb25nICogdHlwZSBjYXN0cywgc2luY2UgdGhlIGlu
dHJvZHVjdGlvbiBvZiB0aGUgMzIgYml0IG9wZXJhdGlvbnMgd2VyZSBvbmx5IGRvbmUgdG8gYXZv
aWQgYW4gaXNzdWUgd2l0aCBjbXB4Y2hnOGIgb24gMzItYml0LCBhbmQganVzdCBkb2luZyBzdHJh
aWdodCB3cml0ZXMgYXZvaWRzIHRoYXQgdG9vLg0KDQpXZeKAmWxsIGJlIHVwZGF0aW5nIHRoZSB2
bWNpIGRldmljZSBkcml2ZXIgdG8gd29yayBvbiBvdGhlciBhcmNoaXRlY3R1cmVzIHNvb25pc2gs
IHNvIHdpbGwgYmUgYWRkaW5nIGJhcnJpZXJzIHRvIGVuZm9yY2Ugb3JkZXJpbmcgYXMgd2VsbCBh
dCB0aGF0IHBvaW50LiBJZiB5b3Ugd2FudCB0byBsZWF2ZSB5b3VyIHBhdGNoIGFzIGlzLCB3ZSBj
YW4gYWRkcmVzcyB0aGUgdHlwZSBjYXN0aW5nIHRoZW4uDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFBldGVyIFppamxzdHJhIChJbnRlbCkgPHBldGVyekBpbmZyYWRlYWQub3JnPg0KPiAtLS0NCj4g
aW5jbHVkZS9saW51eC92bXdfdm1jaV9kZWZzLmggfCAgIDMwICsrKysrKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRp
b25zKC0pDQo+IA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3Ztd192bWNpX2RlZnMuaA0KPiArKysg
Yi9pbmNsdWRlL2xpbnV4L3Ztd192bWNpX2RlZnMuaA0KPiBAQCAtNDM4LDggKzQzOCw4IEBAIGVu
dW0gew0KPiBzdHJ1Y3Qgdm1jaV9xdWV1ZV9oZWFkZXIgew0KPiAJLyogQWxsIGZpZWxkcyBhcmUg
NjRiaXQgYW5kIGFsaWduZWQuICovDQo+IAlzdHJ1Y3Qgdm1jaV9oYW5kbGUgaGFuZGxlOwkvKiBJ
ZGVudGlmaWVyLiAqLw0KPiAtCWF0b21pYzY0X3QgcHJvZHVjZXJfdGFpbDsJLyogT2Zmc2V0IGlu
IHRoaXMgcXVldWUuICovDQo+IC0JYXRvbWljNjRfdCBjb25zdW1lcl9oZWFkOwkvKiBPZmZzZXQg
aW4gcGVlciBxdWV1ZS4gKi8NCj4gKwl1NjQgcHJvZHVjZXJfdGFpbDsJLyogT2Zmc2V0IGluIHRo
aXMgcXVldWUuICovDQo+ICsJdTY0IGNvbnN1bWVyX2hlYWQ7CS8qIE9mZnNldCBpbiBwZWVyIHF1
ZXVlLiAqLw0KPiB9Ow0KPiANCj4gLyoNCj4gQEAgLTc0MCwxMyArNzQwLDkgQEAgc3RhdGljIGlu
bGluZSB2b2lkICp2bWNpX2V2ZW50X2RhdGFfcGF5bA0KPiAgKiBwcmVmaXggd2lsbCBiZSB1c2Vk
LCBzbyBjb3JyZWN0bmVzcyBpc24ndCBhbiBpc3N1ZSwgYnV0IHVzaW5nIGENCj4gICogNjRiaXQg
b3BlcmF0aW9uIHN0aWxsIGFkZHMgdW5uZWNlc3Nhcnkgb3ZlcmhlYWQuDQo+ICAqLw0KPiAtc3Rh
dGljIGlubGluZSB1NjQgdm1jaV9xX3JlYWRfcG9pbnRlcihhdG9taWM2NF90ICp2YXIpDQo+ICtz
dGF0aWMgaW5saW5lIHU2NCB2bWNpX3FfcmVhZF9wb2ludGVyKHU2NCAqdmFyKQ0KPiB7DQo+IC0j
aWYgZGVmaW5lZChDT05GSUdfWDg2XzMyKQ0KPiAtCXJldHVybiBhdG9taWNfcmVhZCgoYXRvbWlj
X3QgKil2YXIpOw0KPiAtI2Vsc2UNCj4gLQlyZXR1cm4gYXRvbWljNjRfcmVhZCh2YXIpOw0KPiAt
I2VuZGlmDQo+ICsJcmV0dXJuIFJFQURfT05DRSgqKHVuc2lnbmVkIGxvbmcgKil2YXIpOw0KPiB9
DQo+IA0KPiAvKg0KPiBAQCAtNzU1LDIzICs3NTEsMTcgQEAgc3RhdGljIGlubGluZSB1NjQgdm1j
aV9xX3JlYWRfcG9pbnRlcihhdA0KPiAgKiBuZXZlciBleGNlZWRzIGEgMzJiaXQgdmFsdWUgaW4g
dGhpcyBjYXNlLiBPbiAzMmJpdCBTTVAsIHVzaW5nIGENCj4gICogbG9ja2VkIGNtcHhjaGc4YiBh
ZGRzIHVubmVjZXNzYXJ5IG92ZXJoZWFkLg0KPiAgKi8NCj4gLXN0YXRpYyBpbmxpbmUgdm9pZCB2
bWNpX3Ffc2V0X3BvaW50ZXIoYXRvbWljNjRfdCAqdmFyLA0KPiAtCQkJCSAgICAgIHU2NCBuZXdf
dmFsKQ0KPiArc3RhdGljIGlubGluZSB2b2lkIHZtY2lfcV9zZXRfcG9pbnRlcih1NjQgKnZhciwg
dTY0IG5ld192YWwpDQo+IHsNCj4gLSNpZiBkZWZpbmVkKENPTkZJR19YODZfMzIpDQo+IC0JcmV0
dXJuIGF0b21pY19zZXQoKGF0b21pY190ICopdmFyLCAodTMyKW5ld192YWwpOw0KPiAtI2Vsc2UN
Cj4gLQlyZXR1cm4gYXRvbWljNjRfc2V0KHZhciwgbmV3X3ZhbCk7DQo+IC0jZW5kaWYNCj4gKwkv
KiBYWFggYnVnZ2VyZWQgb24gYmlnLWVuZGlhbiAqLw0KPiArCVdSSVRFX09OQ0UoKih1bnNpZ25l
ZCBsb25nICopdmFyLCAodW5zaWduZWQgbG9uZyluZXdfdmFsKTsNCj4gfQ0KPiANCj4gLyoNCj4g
ICogSGVscGVyIHRvIGFkZCBhIGdpdmVuIG9mZnNldCB0byBhIGhlYWQgb3IgdGFpbCBwb2ludGVy
LiBXcmFwcyB0aGUNCj4gICogdmFsdWUgb2YgdGhlIHBvaW50ZXIgYXJvdW5kIHRoZSBtYXggc2l6
ZSBvZiB0aGUgcXVldWUuDQo+ICAqLw0KPiAtc3RhdGljIGlubGluZSB2b2lkIHZtY2lfcXBfYWRk
X3BvaW50ZXIoYXRvbWljNjRfdCAqdmFyLA0KPiAtCQkJCSAgICAgICBzaXplX3QgYWRkLA0KPiAt
CQkJCSAgICAgICB1NjQgc2l6ZSkNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCB2bWNpX3FwX2FkZF9w
b2ludGVyKHU2NCAqdmFyLCBzaXplX3QgYWRkLCB1NjQgc2l6ZSkNCj4gew0KPiAJdTY0IG5ld192
YWwgPSB2bWNpX3FfcmVhZF9wb2ludGVyKHZhcik7DQo+IA0KPiBAQCAtODQ4LDggKzgzOCw4IEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCB2bWNpX3FfaGVhZGVyX2luaXQoc3QNCj4gCQkJCSAgICAgIGNv
bnN0IHN0cnVjdCB2bWNpX2hhbmRsZSBoYW5kbGUpDQo+IHsNCj4gCXFfaGVhZGVyLT5oYW5kbGUg
PSBoYW5kbGU7DQo+IC0JYXRvbWljNjRfc2V0KCZxX2hlYWRlci0+cHJvZHVjZXJfdGFpbCwgMCk7
DQo+IC0JYXRvbWljNjRfc2V0KCZxX2hlYWRlci0+Y29uc3VtZXJfaGVhZCwgMCk7DQo+ICsJcV9o
ZWFkZXItPnByb2R1Y2VyX3RhaWwgPSAwOw0KPiArCXFfaGVhZGVyLT5jb25zdW1lcl9oZWFkID0g
MDsNCj4gfQ0KPiANCj4gLyoNCg0K
