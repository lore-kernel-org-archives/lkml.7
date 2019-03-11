Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F96C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7180F20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3tzTAurO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfCKSws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:52:48 -0400
Received: from mail-eopbgr760049.outbound.protection.outlook.com ([40.107.76.49]:59780
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726942AbfCKSws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KM1ZFjeVfdoPM6rgD1fT/Zxc4PIVHQYf3LdPJT7BNe4=;
 b=3tzTAurOn8q/KLInfYPYMvGAxgm+GvZfnAv1PJspMTExyKpPiAFu8G4LWkAiVte8Y1K9tQ9eqGoHtakgTZ8fWGTIUJFO1b4K9RsrynetBYu7s+rjCCJHDkNnVn2+VTw6JLoV2EGdfPxTz6wLOUOtZ825KjRX96xM6UOqcwVMEx0=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2704.namprd12.prod.outlook.com (52.135.103.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.19; Mon, 11 Mar 2019 18:52:05 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 18:52:05 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: RE: [PATCH 2/2] x86/MCE/AMD, EDAC/mce_amd: Don't report L1 BTB MCA
 errors on some Family 17h models
Thread-Topic: [PATCH 2/2] x86/MCE/AMD, EDAC/mce_amd: Don't report L1 BTB MCA
 errors on some Family 17h models
Thread-Index: AQHU1Sxe2SqGGPluPUqDcNOn3/d2LqYGxAcAgAAHaJA=
Date:   Mon, 11 Mar 2019 18:52:05 +0000
Message-ID: <SN6PR12MB263931263441531964542EB4F8480@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190307212552.8865-1-Yazen.Ghannam@amd.com>
 <20190307212552.8865-2-Yazen.Ghannam@amd.com> <20190311182104.GD7384@zn.tnic>
In-Reply-To: <20190311182104.GD7384@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 572e7574-6375-4848-4662-08d6a652a822
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2704;
x-ms-traffictypediagnostic: SN6PR12MB2704:
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2704;20:MYfUOzxJXPAy72/uk5bv0feG+J2SGMBS1Cv2Yvn7qlWjTF7C5YFXU+reOWFyCC+T2TxqyxdDmCt5VtUi13cejNTR7ghm+Lc2gGuuqKPIiu5IIeVp+qI+cbhMg69cAK3PJ1r+PYToqXCjHeqK+R0QQOCsI54QwqSOOXMmfnCZ8kE5S/WfCCXJwYwfuS8dmxFer5fsqF5AvcKDQwIME6m/KziXRTk00w83ZE36cXb18VPfnImyenkGRUqr+MQJWz5H
x-microsoft-antispam-prvs: <SN6PR12MB2704A2F6C30E5BF9638604E2F8480@SN6PR12MB2704.namprd12.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(346002)(366004)(13464003)(199004)(189003)(5660300002)(52536013)(6916009)(8676002)(4326008)(478600001)(81166006)(81156014)(14454004)(33656002)(86362001)(8936002)(256004)(66066001)(71200400001)(71190400001)(486006)(476003)(11346002)(446003)(186003)(72206003)(97736004)(305945005)(7736002)(68736007)(74316002)(105586002)(106356001)(55016002)(9686003)(6436002)(54906003)(76176011)(7696005)(99286004)(229853002)(6506007)(53546011)(26005)(6116002)(102836004)(316002)(3846002)(25786009)(53936002)(2906002)(6246003)(170073001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2704;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MO14vmqUk8umEHLYsqDFO7WCXv5firliSxxpyHmwgy0q6tlm3F0BHNW4XCnKRm7ioujHw2KFPD6C5mcRdyPv3Ur3X1rZ2tdWIjoPUe/kAlFtrI4u/zqwUDFKNJrC8VSGmGZD/ffbiON4dfOI6mLGxNO1viceWq9S7cZAvUtakDXYxCKX/jY4iKJxaW/bWBQIitB+u3/clQ4h456ipZO3hOF3O88C17Ub6A0ER4JV2WP5h8NfMUGrnJ6iovwVWTavblHwNjey1UKHsG1HPhM96KLY+RaKrLwmo0ZTPHQ7tbsLfQCVXEhLVTC54V2NYRs/nmWIOJQrwRKAd5CUibRshXTYAKVE5CegpUpW5NXuzR4csIuHusWP4QCAt7ddjHINrTdyqcfKPegJZ0GIeu9zrWMT8ZHGtr70zbqg+1YgMOU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 572e7574-6375-4848-4662-08d6a652a822
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 18:52:05.7231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2704
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogTW9uZGF5LCBNYXJjaCAxMSwgMjAxOSAxOjIx
IFBNDQo+IFRvOiBHaGFubmFtLCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0KPiBDYzog
bGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IEJvcmlzbGF2IFBldGtvdiA8YnBAc3VzZS5kZT47
IFRvbnkgTHVjayA8dG9ueS5sdWNrQGludGVsLmNvbT47IHg4NkBrZXJuZWwub3JnOyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgcmFmYWxAbWlsZWNraS5wbDsgY2xlbWVqQGdtYWls
LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0geDg2L01DRS9BTUQsIEVEQUMvbWNlX2Ft
ZDogRG9uJ3QgcmVwb3J0IEwxIEJUQiBNQ0EgZXJyb3JzIG9uIHNvbWUgRmFtaWx5IDE3aCBtb2Rl
bHMNCj4gDQo+IE9uIFRodSwgTWFyIDA3LCAyMDE5IGF0IDA5OjI2OjA0UE0gKzAwMDAsIEdoYW5u
YW0sIFlhemVuIHdyb3RlOg0KPiA+ICtzdGF0aWMgYm9vbCBzbWNhX2ZpbHRlcl9tY2Uoc3RydWN0
IG1jZSAqbSkNCj4gPiArew0KPiA+ICsJZW51bSBzbWNhX2JhbmtfdHlwZXMgYmFua190eXBlID0g
c21jYV9nZXRfYmFua190eXBlKG0tPmJhbmspOw0KPiA+ICsJc3RydWN0IGNwdWluZm9feDg2ICpj
ID0gJmJvb3RfY3B1X2RhdGE7DQo+ID4gKwl1OCB4ZWMgPSBYRUMobS0+c3RhdHVzLCB4ZWNfbWFz
ayk7DQo+ID4gKw0KPiA+ICsJLyoNCj4gPiArCSAqIFNwdXJpb3VzIGVycm9ycyBvZiB0aGlzIHR5
cGUgbWF5IGJlIHJlcG9ydGVkLg0KPiA+ICsJICogU2VlIEZhbWlseSAxN2ggTW9kZWxzIDEwaC0y
RmggRXJyYXR1bSAjMTExNC4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKGMtPng4NiA9PSAweDE3ICYm
DQo+ID4gKwkgICAgKGMtPng4Nl9tb2RlbCA+PSAweDEwICYmIGMtPng4Nl9tb2RlbCA8PSAweDJG
KSAmJg0KPiA+ICsJICAgIGJhbmtfdHlwZSA9PSBTTUNBX0lGICYmIHhlYyA9PSAxMCkNCj4gPiAr
CQlyZXR1cm4gdHJ1ZTsNCj4gDQo+IFRoaXMgaXMgaGFwcGVuaW5nIHRvbyBsYXRlIGFuZCB3ZSBu
ZWVkIGl0IG11Y2ggZWFybGllciwgZnJvbSBSYWZhbCdzIGRtZXNnOg0KPiANCj4gWyAgICAxLjA3
MDg1NV0gbWNlOiBbSGFyZHdhcmUgRXJyb3JdOiBNYWNoaW5lIGNoZWNrIGV2ZW50cyBsb2dnZWQN
Cj4gWyAgICAxLjA3MDg2MF0gbWNlOiBbSGFyZHdhcmUgRXJyb3JdOiBDUFUgMjogTWFjaGluZSBD
aGVjazogMCBCYW5rIDE6IGQ4MjAwMDAwMDAwYTAxNTENCj4gWyAgICAxLjA3MDg2M10gbWNlOiBb
SGFyZHdhcmUgRXJyb3JdOiBUU0MgNzNmYTA3NjVjIE1JU0MgZDAxYjBmZmYwMDAwMDAwMCBTWU5E
IDRhMDAwMDAwIElQSUQgMTAwYjAwMDAwMDAwMA0KPiBbICAgIDEuMDcxMDY1XSBtY2U6IFtIYXJk
d2FyZSBFcnJvcl06IFBST0NFU1NPUiAyOjgxMGYxMCBUSU1FIDE1NDM0ODE0MTEgU09DS0VUIDAg
QVBJQyAyIG1pY3JvY29kZSA4MTAxMDBiDQo+IA0KPiB0aGF0J3MgX19wcmludF9tY2UoKSBmcm9t
IHRoZSBub3RpZmllci4NCj4gDQo+IFNvIHdlJ2QgbmVlZCBhIGZpbHRlciBmdW5jdGlvbiB3aGlj
aCBpcyBjYWxsZWQgaW4gZG9fbWFjaGluZV9jaGVjaygpIGFuZA0KPiBtYWNoaW5lX2NoZWNrX3Bv
bGwoKSByaWdodCBhZnRlciB3ZSd2ZSBjb2xsZWN0ZWQgZW5vdWdoIGluZm8gdG8gYmUgYWJsZQ0K
PiB0byBmaWx0ZXIgb3V0IHRoZSBNQ0UgYmFzZWQgb24gdGhlIHNpZ25hdHVyZS4gSW4gdGhpcyBj
YXNlIHRoZSBleHRlbmRlZA0KPiBlcnJvciBjb3JlIGFuZCBTTUNBIGJhbmsgdHlwZSBzdWZmaWNl
cyBidXQgd2Ugc2hvdWxkIHB1dCB0aG9zZSBmdW5jdGlvbnMNCj4gbGF0ZSBlbm91Z2ggc28gdGhh
dCB0aGV5IGNhbiBiZSB1c2VkIGZvciBvdGhlciBmaWx0ZXJpbmcgbGF0ZXIuDQo+IA0KDQpPa2F5
LCB1bmRlcnN0b29kLg0KDQpTaG91bGQgSSBrZWVwIHRoZSBmaWx0ZXIgaW4gZWRhY19tY2VfYW1k
PyBJIGd1ZXNzIGl0J3Mgbm90IG5lY2Vzc2FyeSBpZiBmaWx0ZXJlZCBvdXQgZWFybGllci4NCg0K
PiBBbHRlcm5hdGl2ZWx5LCBpZiB0aGlzIGVycm9yIHR5cGUgaGFzIGEgc3BlY2lhbCBiaXQgaW4g
dGhlIG1hc2sgcmVnaXN0ZXJzIHNvDQo+IHRoYXQgeW91IGNhbiBkaXNhYmxlIGl0IHRoZXJlIGFs
YQ0KPiANCj4gICAgICAgICBpZiAoYy0+eDg2X3ZlbmRvciA9PSBYODZfVkVORE9SX0FNRCkgew0K
PiAgICAgICAgICAgICAgICAgaWYgKGMtPng4NiA9PSAxNSAmJiBjZmctPmJhbmtzID4gNCkgew0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAvKg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
KiBkaXNhYmxlIEdBUlQgVEJMIHdhbGsgZXJyb3IgcmVwb3J0aW5nLCB3aGljaA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgKiB0cmlwcyBvZmYgaW5jb3JyZWN0bHkgd2l0aCB0aGUgSU9NTVUg
JiAzd2FyZQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgKiAmIENlcmJlcnVzOg0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgKi8NCj4gICAgICAgICAgICAgICAgICAgICAgICAgY2xlYXJf
Yml0KDEwLCAodW5zaWduZWQgbG9uZyAqKSZtY2VfYmFua3NbNF0uY3RsKTsNCj4gDQo+IA0KPiB0
aGF0IHdvdWxkIGJlIGV2ZW4gYmV0dGVyIGJ1dCBJJ2QgZ3Vlc3MgaXQgZG9lc24ndCBoYXZlIGEg
c3BlY2lhbCBiaXQuLi4NCj4gDQoNClllcywgdGhhdCdzIHJpZ2h0LiBDbGVhcmluZyBhIGJpdCBp
biBNQ0FfQ1RMIGlzIG5vdCByZWNvbW1lbmQgaW4gdGhpcyBjYXNlLg0KDQpUaGFua3MsDQpZYXpl
bg0K
