Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE48C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0062082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="5ZeeILbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfDJQ6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:58:18 -0400
Received: from mail-eopbgr750058.outbound.protection.outlook.com ([40.107.75.58]:51114
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726556AbfDJQ6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSWwLAOnwmoBM5S9mG2i0+g+gOVd0prN2ZEB9hD9n/o=;
 b=5ZeeILbxo9pPXg5XblTBJEe4LVjC8agum+O3rm/Zd2qFH+FtJvAhjmDjiDyarAgtGjOQW4QJvWCs6dCUTMPzxCezXT9SqdyIdKnH6LwUOX6zt5QagLrH0h8aSR8numUGK2OtfS7hbrIglO115+lSz5S+NhGMZ3/q7Blb4jty52M=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2766.namprd12.prod.outlook.com (52.135.107.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Wed, 10 Apr 2019 16:58:13 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8%2]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 16:58:12 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH RESEND 2/5] x86/MCE: Handle MCA controls in a per_cpu way
Thread-Topic: [PATCH RESEND 2/5] x86/MCE: Handle MCA controls in a per_cpu way
Thread-Index: AQHU7hUSVDLUqZVqKEupBAtcrt9jWqYyi0gAgAAIfUCAAbc/AIABTYIggAADjgCAAAApUA==
Date:   Wed, 10 Apr 2019 16:58:12 +0000
Message-ID: <SN6PR12MB2639F37C634BC7F6D4B86194F82E0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190408141205.12376-1-Yazen.Ghannam@amd.com>
 <20190408141205.12376-3-Yazen.Ghannam@amd.com>
 <20190408175142.GK15689@zn.tnic>
 <SN6PR12MB26397E000684890C92075985F82C0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190409203412.GE6150@zn.tnic>
 <SN6PR12MB2639C9B48E46DA6A8BA9DB3DF82E0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190410164036.GC26580@zn.tnic>
In-Reply-To: <20190410164036.GC26580@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4f18b10-3dd6-4cec-22d3-08d6bdd5b7dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2766;
x-ms-traffictypediagnostic: SN6PR12MB2766:
x-microsoft-antispam-prvs: <SN6PR12MB2766BE00A28214A9AFC375ACF82E0@SN6PR12MB2766.namprd12.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(136003)(396003)(189003)(199004)(13464003)(72206003)(26005)(6506007)(476003)(14454004)(97736004)(102836004)(446003)(4326008)(186003)(76176011)(53546011)(66066001)(86362001)(93886005)(11346002)(33656002)(71200400001)(53936002)(6246003)(71190400001)(478600001)(6116002)(316002)(54906003)(3846002)(25786009)(486006)(8676002)(9686003)(7696005)(7736002)(8936002)(6916009)(229853002)(5660300002)(256004)(81156014)(105586002)(55016002)(99286004)(68736007)(2906002)(81166006)(106356001)(74316002)(14444005)(305945005)(52536014)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2766;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TYT+UVp33YOZs+SMS0ISytGG5YTECVDoaHi1ns0YVNENMMhjB6AdxUFHw60Ia6sQ8L9A9BC+FXMMgtZih2qKNqrzoqRoii21228eTyLyE8aRqtTY3P4zHxLJjkMEZRAQssZ39XezzpvA/nKOdm3OtihQphj6jVk0TjnA3k7LcicNPFPtPKPB/ibrAkBzOLTnWGQ2RiBzWzSQ0eooPDdQJgAmcWnEWlN8jncbsHPfUuTwamur+R+VG2XaRtl2q0pWhMEVL96NU/akJ8zyZl1gYUntfDBFJo+oFrnosLoSCZeO+Fk5sdh0EWSO4ifw/TzWXWCk6AhvVMA9XdaR54t5hhlT+QkUt8tJKjfsQXJTHVU1kp6ElAC01KQH8hGOqz2DYZdX/4izu8Avzm2dBlg2rPBO/25yzCJg4ycBuvy+fP8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f18b10-3dd6-4cec-22d3-08d6bdd5b7dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 16:58:12.8749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2766
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCAxMCwgMjAxOSAxMTo0MSBBTQ0K
PiBUbzogR2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4NCj4gQ2M6IGxpbnV4
LWVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyB0b255
Lmx1Y2tAaW50ZWwuY29tOyB4ODZAa2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFJF
U0VORCAyLzVdIHg4Ni9NQ0U6IEhhbmRsZSBNQ0EgY29udHJvbHMgaW4gYSBwZXJfY3B1IHdheQ0K
PiANCj4gT24gV2VkLCBBcHIgMTAsIDIwMTkgYXQgMDQ6MzY6MzBQTSArMDAwMCwgR2hhbm5hbSwg
WWF6ZW4gd3JvdGU6DQo+ID4gV2UgaGF2ZSB0aGlzIGNhc2Ugb24gQU1EIEZhbWlseSAxN2ggd2l0
aCBCYW5rIDQuIFRoZSBoYXJkd2FyZSBlbmZvcmNlcw0KPiA+IHRoaXMgYmFuayB0byBiZSBSZWFk
LWFzLVplcm8vV3JpdGVzLUlnbm9yZWQuDQo+ID4NCj4gPiBUaGlzIGJlaGF2aW9yIGlzIGVuZm9y
Y2VkIHdoZXRoZXIgdGhlIGJhbmsgaXMgaW4gdGhlIG1pZGRsZSBvciBhdCB0aGUNCj4gPiBlbmQu
DQo+IA0KPiBEb2VzIG51bV9iYW5rcyBjb250YWluIHRoZSBkaXNhYmxlZCBiYW5rPyBJZiBzbywg
dGhlbiBpdCB3aWxsIHdvcmsuDQo+IA0KDQpZZXMsIHVudXNlZCBiYW5rcyBpbiB0aGUgbWlkZGxl
IGFyZSBjb3VudGVkIGluIHRoZSBNQ0dfQ0FQW0NvdW50XSB2YWx1ZS4NCg0KPiA+IEknbSB0aGlu
a2luZyB0byByZWRvIHRoZSBzeXNmcyBpbnRlcmZhY2UgZm9yIGJhbmtzIGluIGFub3RoZXIgcGF0
Y2gNCj4gPiBzZXQuIEkgY291bGQgaW5jbHVkZSBhIG5ldyBmaWxlIHRvIGluZGljYXRlIGVuYWJs
ZWQvZGlzYWJsZWQsIG9yIG1heWJlDQo+ID4ganVzdCB1cGRhdGUgdGhlIGRvY3VtZW50YXRpb24g
dG8gZGVzY3JpYmUgdGhpcyBjYXNlLg0KPiANCj4gTm8sIHRoZSB3cml0ZSB0byB0aGUgYmFuayBj
b250cm9scyBzaG91bGQgZmFpbCBvbiBhIGRpc2FibGVkIGJhbmsuDQo+IA0KDQpPa2F5LCBzbyB5
b3UncmUgc2F5aW5nIHRoZSBzeXNmcyBhY2Nlc3Mgc2hvdWxkIGZhaWwgaWYgYSBiYW5rIGlzIGRp
c2FibGVkLiBJcyB0aGF0IGNvcnJlY3Q/DQoNCkRvZXMgImRpc2FibGVkIiBtZWFuIG9uZSBvciBi
b3RoIG9mIHRoZXNlPw0KVW51c2VkID0gUkFaL1dJIGluIGhhcmR3YXJlDQpVbmluaXRpYWxpemVk
ID0gTm90IGluaXRpYWxpemVkIGJ5IGtlcm5lbCBkdWUgdG8gcXVpcmtzLCBldGMuDQoNCkZvciBh
biB1bnVzZWQgYmFuaywgaXQgZG9lc24ndCBodXJ0IHRvIHdyaXRlIE1DQV9DVEwsIGJ1dCByZWFs
bHkgdGhlcmUncyBubyByZWFzb24gdG8gZG8gc28gYW5kIGdvIHRocm91Z2ggbWNlX3Jlc3RhcnQo
KS4NCg0KRm9yIGFuIHVuaW5pdGlhbGl6ZWQgYmFuaywgc2hvdWxkIHdlIHByZXZlbnQgdXNlcnMg
ZnJvbSBvdmVycmlkaW5nIHRoZSBrZXJuZWwncyBzZXR0aW5ncz8NCg0KVGhhbmtzLA0KWWF6ZW4N
Cg0KDQogDQo=
