Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196FEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4E2218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="noDQT5MH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfCVTYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:24:07 -0400
Received: from mail-eopbgr760047.outbound.protection.outlook.com ([40.107.76.47]:29558
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726215AbfCVTYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTkVSD0dDVRfwGkFHzYF76+ikj2Tx3bb0/2dWaHSENA=;
 b=noDQT5MHIXmmf6sKjjGivcuVDKjmR1TEAmnMz6VLITMXKS4accjUG7xkgC7awMvOsq77LMfUHteJCiZKHPt9EERJAYj8A8FTZYWmbbxeRc3HJyovuHyx1HaNy6iWfqS6A6NNKn2X6QHhAw/MxvUVWuV394iPRz7UAjN2NxjxljQ=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2813.namprd12.prod.outlook.com (52.135.100.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Fri, 22 Mar 2019 19:24:01 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1730.013; Fri, 22 Mar 2019
 19:24:01 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: Re: [PATCH v2 2/2] x86/MCE/AMD: Don't report L1 BTB MCA errors on
 some Family 17h models
Thread-Topic: [PATCH v2 2/2] x86/MCE/AMD: Don't report L1 BTB MCA errors on
 some Family 17h models
Thread-Index: AQHU4CQzOwE6EEZAWEC91l7umX/fDqYX6sEAgAAejgA=
Date:   Fri, 22 Mar 2019 19:24:01 +0000
Message-ID: <feea1978-04ef-82f9-933e-4ae280391aea@amd.com>
References: <20190321202505.5553-1-Yazen.Ghannam@amd.com>
 <20190321202505.5553-2-Yazen.Ghannam@amd.com>
 <20190322173436.GK12472@zn.tnic>
In-Reply-To: <20190322173436.GK12472@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR12CA0018.namprd12.prod.outlook.com
 (2603:10b6:208:a8::31) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d3ee6db-8a36-457d-a46b-08d6aefbf074
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2813;
x-ms-traffictypediagnostic: SN6PR12MB2813:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB28133BC02E161AE60701FC7AF8430@SN6PR12MB2813.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(346002)(39860400002)(366004)(136003)(396003)(189003)(199004)(5660300002)(486006)(53936002)(52116002)(102836004)(76176011)(3846002)(6116002)(4326008)(478600001)(71200400001)(72206003)(99286004)(25786009)(71190400001)(14444005)(256004)(14454004)(6246003)(54906003)(966005)(31696002)(8936002)(81156014)(81166006)(8676002)(86362001)(316002)(106356001)(105586002)(305945005)(446003)(11346002)(36756003)(186003)(386003)(53546011)(6916009)(6506007)(229853002)(6306002)(476003)(26005)(6512007)(2616005)(31686004)(6486002)(68736007)(2906002)(97736004)(66066001)(6436002)(7736002)(170073001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2813;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TdRGXgHojKIXg7tDDY8Gqg2UgQW14FGPAH9OxcpNlp5XIIWvjCwTYuZm+1km15jlqG/SPnsnxrKBjErAeoPPcTac69/bIjDCvTQHkNfoDrAOnVETiK46nPM7/Rj6po91+yr9vi+kSszm2mgEaQDHX6BIteED9YSRWdtN5qbu1BLsDn/oN9qctZhOonvldh6atwEjcA8mI/F/4eKB5dy0c054iQNumP29bFU8/rjLTGrKDEnNSQIJx9oZNevwtNZ7lk067WpzUdV/AWyhawZzl2Ej5k/mOSJqubzsvl+qjVs/vsbeWLrMMzC7ikdCJrhh4AtMt3ciQOfQx81+qVznlcDjtRrqEa1e4qc7oaVyWYxiaDiTEIjSN8AFgfgv3gtsvdvqUQFDcHlzR47xWdDwpReHu/g2Ql0O7ojXNEr/GgQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD866DA1EC834948A7AE79114E38E23D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3ee6db-8a36-457d-a46b-08d6aefbf074
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 19:24:01.6306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2813
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yMi8yMDE5IDEyOjM0IFBNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+IE9uIFRodSwg
TWFyIDIxLCAyMDE5IGF0IDA4OjI1OjE4UE0gKzAwMDAsIEdoYW5uYW0sIFlhemVuIHdyb3RlOg0K
Pj4gRnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KPj4NCj4+IEFN
RCBGYW1pbHkgMTdoIE1vZGVscyAxMGgtMkZoIG1heSByZXBvcnQgYSBoaWdoIG51bWJlciBvZiBM
MSBCVEIgTUNBDQo+PiBlcnJvcnMgdW5kZXIgY2VydGFpbiBjb25kaXRpb25zLiBUaGUgZXJyb3Jz
IGFyZSBiZW5pZ24gYW5kIGNhbiBzYWZlbHkgYmUNCj4+IGlnbm9yZWQuIEhvd2V2ZXIsIHRoZSBo
aWdoIGVycm9yIHJhdGUgbWF5IGNhdXNlIHRoZSBNQ0EgdGhyZXNob2xkDQo+PiBjb3VudGVyIHRv
IG92ZXJmbG93IGNhdXNpbmcgYSBoaWdoIHJhdGUgb2YgdGhyZXNob2xkaW5nIGludGVycnVwdHMu
IEluDQo+PiBhZGRpdGlvbiwgdXNlcnMgbWF5IHNlZSB0aGUgZXJyb3JzIHJlcG9ydGVkIHRocm91
Z2ggdGhlIEFNRCBNQ0UgZGVjb2Rlcg0KPj4gbW9kdWxlLCBldmVuIHdpdGggdGhlIGludGVycnVw
dCBkaXNhYmxlZCwgZHVlIHRvIE1DQSBwb2xsaW5nLg0KPj4NCj4+IFRoaXMgZXJyb3IgaXMgcmVw
b3J0ZWQgdGhyb3VnaCB0aGUgSW5zdHJ1Y3Rpb24gRmV0Y2ggYmFuay4NCj4+DQo+PiBDbGVhciB0
aGUgIkNvdW50ZXIgUHJlc2VudCIgYml0IGluIHRoZSBJbnN0cnVjdGlvbiBGZXRjaCBiYW5rJ3MN
Cj4+IE1DQV9NSVNDMCByZWdpc3Rlci4gVGhpcyB3aWxsIHByZXZlbnQgZW5hYmxpbmcgTUNBIHRo
cmVzaG9sZGluZyBvbiB0aGlzDQo+PiBiYW5rIHdoaWNoIHdpbGwgcHJldmVudCB0aGUgaGlnaCBp
bnRlcnJ1cHQgcmF0ZSBkdWUgdG8gdGhpcyBlcnJvci4NCj4+DQo+PiBEZWZpbmUgYSBmdW5jdGlv
biB0byBmaWx0ZXIgdGhlc2UgZXJyb3JzIGZyb20gdGhlIE1DRSBldmVudCBwb29sLg0KPj4gSW5z
dGFsbCB0aGlzIGZ1bmN0aW9uIGR1cmluZyBBTUQgdmVuZG9yIGluaXQuIFRoZSBNQ0EgYmFua3Mg
YXJlIGVuYWJsZWQNCj4+IGFmdGVyIHZlbmRvciBpbml0LCBzbyB0aGUgZmlsdGVyIGZ1bmN0aW9u
IHdpbGwgYmUgaW5zdGFsbGVkIGJlZm9yZSB0aGUNCj4+IHNwdXJpb3VzIGVycm9ycyB3aWxsIGJl
IHJlcG9ydGVkLg0KPj4NCj4+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyA0LjE0Lng6
IGM5NWIzMjNkY2QzNTogeDg2L01DRS9BTUQ6IFR1cm4gb2ZmIE1DNF9NSVNDIHRocmVzaG9sZGlu
ZyBvbiBhbGwgZmFtaWx5IDB4MTUgbW9kZWxzDQo+PiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmc+ICMgNC4xNC54OiAzMGFhM2QyNmVkYjA6IHg4Ni9NQ0UvQU1EOiBDYXJ2ZSBvdXQgdGhlIE1D
NF9NSVNDIHRocmVzaG9sZGluZyBxdWlyaw0KPj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3Jn
PiAjIDQuMTQueA0KPj4gU2lnbmVkLW9mZi1ieTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5h
bUBhbWQuY29tPg0KPj4gLS0tDQo+PiBMaW5rOg0KPj4gaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcv
ci8yMDE5MDMwNzIxMjU1Mi44ODY1LTItWWF6ZW4uR2hhbm5hbUBhbWQuY29tDQo+Pg0KPj4gdjEt
PnYyOg0KPj4gKiBGaWx0ZXIgb3V0IHRoZSBlcnJvciBlYXJsaWVyIGluIE1DRSBjb2RlIHJhdGhl
ciB0aGFuIGxhdGVyIGluIEVEQUMuDQo+Pg0KPj4gIGFyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2Ft
ZC5jIHwgNTcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4+ICAxIGZpbGUg
Y2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FtZC5jIGIvYXJjaC94ODYva2VybmVsL2Nw
dS9tY2UvYW1kLmMNCj4+IGluZGV4IGU2NGRlNTE0OWU1MC4uMmRiODVmNjViNDFlIDEwMDY0NA0K
Pj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvYW1kLmMNCj4+ICsrKyBiL2FyY2gveDg2
L2tlcm5lbC9jcHUvbWNlL2FtZC5jDQo+PiBAQCAtNTYzLDIyICs1NjMsNTUgQEAgcHJlcGFyZV90
aHJlc2hvbGRfYmxvY2sodW5zaWduZWQgaW50IGJhbmssIHVuc2lnbmVkIGludCBibG9jaywgdTMy
IGFkZHIsDQo+PiAgCXJldHVybiBvZmZzZXQ7DQo+PiAgfQ0KPj4gIA0KPj4gK2Jvb2wgZmlsdGVy
X21jZV9ydihzdHJ1Y3QgbWNlICptKQ0KPj4gK3sNCj4+ICsJZW51bSBzbWNhX2JhbmtfdHlwZXMg
YmFua190eXBlID0gc21jYV9nZXRfYmFua190eXBlKG0tPmJhbmspOw0KPj4gKwl1OCB4ZWMgPSAo
bS0+c3RhdHVzID4+IDE2KSAmIDB4M0Y7DQo+PiArDQo+PiArCS8qDQo+PiArCSAqIFNwdXJpb3Vz
IGVycm9ycyBvZiB0aGlzIHR5cGUgbWF5IGJlIHJlcG9ydGVkLg0KPj4gKwkgKiBTZWUgRmFtaWx5
IDE3aCBNb2RlbHMgMTBoLTJGaCBFcnJhdHVtICMxMTE0Lg0KPj4gKwkgKi8NCj4+ICsJaWYgKGJh
bmtfdHlwZSA9PSBTTUNBX0lGICYmIHhlYyA9PSAxMCkNCj4+ICsJCXJldHVybiB0cnVlOw0KPj4g
Kw0KPj4gKwlyZXR1cm4gZmFsc2U7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyB2b2lkIGZpbHRl
cl9tY2VfY2hlY2soc3RydWN0IGNwdWluZm9feDg2ICpjKQ0KPj4gK3sNCj4+ICsJaWYgKGMtPng4
NiA9PSAweDE3ICYmIChjLT54ODZfbW9kZWwgPj0gMHgxMCAmJiBjLT54ODZfbW9kZWwgPD0gMHgy
RikpDQo+PiArCQlmaWx0ZXJfbWNlID0gZmlsdGVyX21jZV9ydjsNCj4+ICt9DQo+IA0KPiBXaHkg
YWxsIHRoZSBub29kbGluZyBoZXJlIHdpdGggYSBjaGVjayBmdW5jdGlvbiB3aGljaCBhc3NpZ25z
IGENCj4gZmlsdGVyX21jZV9ydiAoYnR3LCB0aGF0ICJydiIgbWVhbnMgbm90aGluZyBvdXRzaWRl
IG9mIEFNRCkgYW5kIGENCj4gZ2VuZXJpYyBkZWZhdWx0X2ZpbHRlcl9tY2U/DQo+IA0KDQpPa2F5
LiBJdCBjb3VsZCBiZSBuYW1lZCBzb21ldGhpbmcgZWxzZS4gVGhpcyBtb2RlbCBncm91cCBpcyBS
YXZlbiBSaWRnZSwgc28gSSB0aG91Z2h0ICJydiIgd291bGQgYmUgYSBnb29kLiBNYXliZSBzcGVs
bGluZyBpdCBvdXQgd291bGQgYmUgYmV0dGVyPyBPciBzaG91bGQgaXQganVzdCBiZSBzb21ldGhp
bmcgZmFtaWx5L21vZGVsPw0KDQo+IFdoeSBub3QgYSBzaW1wbGUgZmlsdGVyX21jZSgpIGluIG1j
ZS9jb3JlLmMgd2hpY2ggY2FsbHMgYW1kX2ZpbHRlcl9tY2UoKQ0KPiBiYXNlZCBvbiB4ODZfdmVu
ZG9yIGFuZCBhbWRfZmlsdGVyX21jZSgpIGlzIGRlZmluZWQgaW4gbWNlL2FtZC5jPw0KPiANCg0K
R2VuZXJhbGx5LCB0aGUgbW9kZWwgZ3JvdXBzIHNoYXJlIHRoZSBzYW1lIGhhcmR3YXJlIGRlc2ln
biBhbmQgc28gdGhlIHNhbWUgcXVpcmtzLiBTbyBJJ20gdGhpbmtpbmcgdGhhdCBpdCdkIGJlIG1v
cmUgZWZmaWNpZW50IHRvIGhhdmUgYSBmaWx0ZXIgZnVuY3Rpb24gdGhhdCB0YXJnZXRzIGEgc3Bl
Y2lmaWMgZ3JvdXAgb2YgbW9kZWxzIHJhdGhlciB0aGFuIG9uZSB0aGF0IGNoZWNrcyBhbGwga25v
d24gcXVpcmtzIG9uIGFsbCBtb2RlbHMuDQoNCk1vc3Qgb2YgdGhlIHF1aXJrcyBhcmUgZGVhbHQg
d2l0aCBhdCBpbml0IHRpbWUsIGJ1dCB0aGlzIG5lZWRzIGJlIHRvIGRvbmUgZHVyaW5nIHJ1biB0
aW1lIGZvciBlYWNoIE1DRSB0aGF0IGlzIGxvZ2dlZC4gU28gSSBkaWRuJ3Qgd2FudCB0byBhZGQg
dW5uZWNlc3NhcnkgY2hlY2tzIHRvIHRoZSBNQ0UgaGFuZGxlcnMuIFdlIGhhdmUgcXVpcmtfbm9f
d2F5X291dCgpIHRoYXQgZG9lcyBzb21ldGhpbmcgc2ltaWxhci4NCg0KVGhhbmtzLA0KWWF6ZW4N
Cg==
