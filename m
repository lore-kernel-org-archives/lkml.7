Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98113C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E6620657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="CTyXTlS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfCRSkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:40:07 -0400
Received: from mail-eopbgr130081.outbound.protection.outlook.com ([40.107.13.81]:58276
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726771AbfCRSkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sMNU60CPGtRLBWy1yS+xFNJAQ90VGrXbhxPb38ZLkk=;
 b=CTyXTlS3xlD5uzxuCwoRsoFmuwHMTXFr5yA7N9SpA2lr2ZeuwxU5DCDvWevnv3x5BmzyVNW/s0FmjtRTpF3QRZ2rIvNrLHcjjnn101DwyGkvrSFySbeFuAbDdS+yG6pdNh8zoFFdgx3iSC8FxMtB4vnAWyePRDmGqeRPzeL8qYY=
Received: from DB6PR0501MB2709.eurprd05.prod.outlook.com (10.172.226.16) by
 DB6PR0501MB2647.eurprd05.prod.outlook.com (10.172.225.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 18:39:22 +0000
Received: from DB6PR0501MB2709.eurprd05.prod.outlook.com
 ([fe80::e595:dbdf:132d:3ef7]) by DB6PR0501MB2709.eurprd05.prod.outlook.com
 ([fe80::e595:dbdf:132d:3ef7%7]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 18:39:22 +0000
From:   Junhan Zhou <Junhan@mellanox.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liming Sun <lsun@mellanox.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] EDAC, mellanox: Add ECC support for BlueField DDR4
Thread-Topic: [PATCH v1 1/1] EDAC, mellanox: Add ECC support for BlueField
 DDR4
Thread-Index: AQHUzhufLnpn0YmSqUG23Fj2fS8i96X0F/MAgBjO+YCABOkrIA==
Date:   Mon, 18 Mar 2019 18:39:22 +0000
Message-ID: <DB6PR0501MB2709E23A6880AE98FD094DF9B3470@DB6PR0501MB2709.eurprd05.prod.outlook.com>
References: <e59276b6f3dc165703ddcb47a8a006d8a62d9c95.1551216637.git.Junhan@mellanox.com>
 <1551298916-4981-1-git-send-email-Junhan@mellanox.com>
 <20190315151257.GB12523@zn.tnic>
In-Reply-To: <20190315151257.GB12523@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Junhan@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d72b52c-9408-4f83-260b-08d6abd109fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0501MB2647;
x-ms-traffictypediagnostic: DB6PR0501MB2647:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB6PR0501MB26479A4790E4430149FC2F0EB3470@DB6PR0501MB2647.eurprd05.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(346002)(376002)(189003)(199004)(54906003)(80792005)(33656002)(316002)(14454004)(6116002)(53936002)(3846002)(6246003)(52536014)(256004)(7736002)(99286004)(76176011)(9686003)(2906002)(6306002)(66066001)(6436002)(966005)(478600001)(74316002)(7696005)(8936002)(305945005)(72206003)(55016002)(71190400001)(71200400001)(26005)(6916009)(97736004)(106356001)(6506007)(25786009)(105586002)(186003)(229853002)(86362001)(5660300002)(446003)(4326008)(476003)(486006)(81166006)(11346002)(81156014)(102836004)(8676002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2647;H:DB6PR0501MB2709.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E8+y8/pitwah9PSHKEdUXjx8Vm+quFjCpk8oYR0gWHYpLdzUJRcbdGJg2BFyRidh7zqKr6erUGcmTZolcBuZLTKs1RW4lyzqFoy5jg7FeHCApKsy5wQm2U84Pi7vammI//Gh+FHzfms4YNhn81JKNTbwyhzfpS8BKrHSEA/PEhofV5XQUAh6DXO2xFyAsTrvpI19JujyZJWYjVBbTqbWL7fG9rCoh34eC+uuplzpz7jIoSt2UDDzwTZFZerKgcCfQmWq5Aer445rH08ltPZOZgePkGcfb79xoYYkmph8TyLNhqpJeGdfaO1AQlrH0L0AhMpLpJGw95NST92TcMG5uD06nfl2RooD1Bv6kAdYGH2Si+d4+SaOpaEnZN5DlzEfR1SyYrCrqHRraS2LAGOqEOt2LrELVjNPAGxgg9Qa5T4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d72b52c-9408-4f83-260b-08d6abd109fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 18:39:22.2756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2647
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICtjb25maWcgRURBQ19CTFVFRklFTEQNCj4gPiArCXRyaXN0YXRlICJNZWxsYW5veCBCbHVl
RmllbGQgTWVtb3J5IEVDQyINCj4gPiArCWRlcGVuZHMgb24gKE1FTExBTk9YX1BMQVRGT1JNICYm
IEFSTTY0ICYmIEFDUEkpIHx8DQo+IENPTVBJTEVfVEVTVA0KPiANCj4gTUVMTEFOT1hfUExBVEZP
Uk0gZGVwZW5kcyBvbiBYODYgfHwgQVJNIGJ1dCB0aGlzIGRlcGVuZHMgb24gQVJNNjQuDQo+IEhv
dyBpcyB0aGF0IGV2ZW4gc3VwcG9zZWQgdG8gd29yaz8NCg0KV2UgYXJlIHB1c2hpbmcgdG8gYWRk
IGRyaXZlciBzdXBwb3J0IGluIHRoZSBtYWlubGluZSBrZXJuZWwgZm9yIG91ciBBNzIgKEFSTTY0
KSBiYXNlZCBCbHVlRmllbGQgU29DLCBhbmQgYWZ0ZXIgZGViYXRlcyBkZWNpZGVkIHRvIHVzZSB0
aGUgTUVMTEFOT1hfUExBVEZPUk0gb3B0aW9uIGZvciB0aGlzLg0KTXkgY29sbGVhZ3VlIGlzIGFs
c28gaW4gdGhlIHByb2Nlc3Mgb2YgdXBzdHJlYW1pbmcgYSBkcml2ZXIgd2hpY2ggbWFrZXMgTUVM
TEFOT1hfUExBVEZPUk0gZGVwZW5kcyBvbiBBUk02NCwgeW91IGNhbiBzZWUgdGhlIHBhdGNoIGF0
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMTU1MjA1NjA4NC0xMjEzNy0xLWdpdC1zZW5k
LWVtYWlsLWxzdW5AbWVsbGFub3guY29tLw0KSWYgeW91IHdhbnQsIEkgY2FuIGFsc28gYWRkIHRo
ZSBjaGFuZ2UgdG8gdGhpcyBwYXRjaCwgYnV0IEkgd291bGQgcHJlZmVyIHRvIG9ubHkgaGF2ZSB0
aGUgY2hhbmdlIGluIG9uZSBwYXRjaC4NCg0KPiANCj4gPiArCWhlbHANCj4gPiArCSAgU3VwcG9y
dCBmb3IgZXJyb3IgZGV0ZWN0aW9uIGFuZCBjb3JyZWN0aW9uIG9uIHRoZQ0KPiA+ICsJICBNZWxs
YW5veCBCbHVlRmllbGQgU29Dcy4NCj4gPiArDQo+ID4gIGVuZGlmICMgRURBQw0KPiANCj4gVGhp
cyBwYXRjaCBuZWVkcyBNQUlOVEFJTkVSUyBlbnRyeSBzbyB0aGF0IHlvdSBjYW4gZ2V0IENDZWQg
b24gYnVnDQo+IHJlcG9ydHMuDQoNCkRvbmUuIEFkZGVkIG15c2VsZi4NCg0KPiA+ICt1bmlvbiBN
TFhCRl9FTUlfRFJBTV9FQ0NfQ09VTlRfdSB7DQo+IA0KPiBObyBhbGwgY2FwcyBuYW1lcyBwbHMu
IEFuZCBubyAiX3UiIHN1ZmZpeGluZyAtIHRoaXMgaXMgbm90IEMrKy4NCg0KRG9uZS4gUmVtb3Zl
ZCB0aGUgX3Ugc3VmZml4IGFuZCBjaGFuZ2VkIGFsbCB1bmlvbiBkZWNsYXJhdGlvbnMgdG8gbG93
ZXIgY2FzZS4NCg0KPiA+ICsJc3RydWN0IHsNCj4gPiArCQkvKiBFQ0Mgc2luZ2xlIGVycm9ycyBj
b3VudGVyICovDQo+ID4gKwkJdTMyIHNpbmdsZV9lcnJvcl9jb3VudCA6IDE2Ow0KPiANCj4gWW91
IGhhdmUgZXhjZXNzaXZlIGNvbW1lbnRzIGZvciBtZW1iZXJzIHdob3NlIG5hbWVzIGFscmVhZHkg
ZGVzY3JpYmUNCj4gd2hhdCB0aGV5IGFyZS4gUmVtb3ZlIHRoZSBjb21tZW50cyBhbmQgZGVzY3Jl
YXNlIHRoZSBjbHV0dGVyIHRoaXMgd2F5Lg0KDQpTb3JyeSwgdGhpcyB3YXMgYXV0b2dlbmVyYXRl
ZCBmcm9tIHRoZSByZWdpc3RlciBoYXJkd2FyZSBkZWZpbml0aW9ucy4gUmVtb3ZlZCBhbGwgZXhj
ZXB0IGZvciB0aGUgRUNDIHN5bmRyb21lIG9uZSBhcyBpdCBkb2VzIGhhdmUgYWRkZWQgaW5mb3Jt
YXRpb24gb2Ygc2F5aW5nIGl0J3MgZXJyb3IgYml0IGFjY29yZGluZyB0byB0aGUgSGFtbWluZyBj
b2RlLg0KDQo+IA0KPiA+ICt1bmlvbiBNTFhCRl9FTUlfRFJBTV9FQ0NfRVJST1JfdSB7DQo+ID4g
KwlzdHJ1Y3Qgew0KPiA+ICsJCS8qIDEgLSBFQ0Mgc2luZ2xlIGVycm9yIGZyb20gRFJBTSB3cmFw
cGVyIHguICovDQo+IA0KPiBXaGF0J3MgYSAiRFJBTSB3cmFwcGVyIHgiIHdoaWNoIGlzIGJlaW5n
IG1lbnRpb25lZCBoZXJlIGFuZCB0aGVyZT8NCg0KU29ycnkgYWJvdXQgdGhpcywgcmVtb3ZlZC4g
SXQgd291bGQgYmUgbW9yZSBjb25mdXNpbmcgaWYganVzdCBsZWZ0IGhlcmUuDQpUaGUgc3Rvcnkg
aXMgdGhpcyBoYXJkd2FyZSBJUCB3YXMgb3JpZ2luYWxseSB1c2VkIGZvciB0aGUgRXpjaGlwIE5Q
UyBtZW1vcnkgY29udHJvbGxlciB3aGVyZSB0aGVyZSB3ZXJlIGEgbG90IG9mIHNlcGFyYXRlIERS
QU0gZ3JvdXBzIG9yICJ3cmFwcGVycyIsIGFuZCBlYWNoIGJpdCBoZXJlIHdvdWxkIGNvcnJlc3Bv
bmRpbmcgdG8gb25lIG9mIGl0LiBCdXQgd2hlbiBtb3ZpbmcgdG8gQmx1ZUZpZWxkIGl0IHdhcyBk
ZWNpZGVkIHRvIGdldCByaWQgb2YgYWxsIHRoZXNlIHdyYXBwZXJzLiBCdXQgYXBwYXJlbnRseSB0
aGUgZGVzY3JpcHRpb24gd2Fzbid0IHVwZGF0ZWQuDQoNCj4gPiArCQl1MzIgZHJhbV9lY2Nfc2lu
Z2xlIDogMTsNCj4gPiArCQkvKiBSZXNlcnZlZC4gKi8NCj4gQWxsIHRob3NlICJSZXNlcnZlZCIg
Y29tbWVudHMgYXJlIGNvbXBsZXRlbHkgdXNlbGVzcy4NCkFsbCByZW1vdmVkLg0KPiA+ICsgKiBS
ZXRyaWV2ZSBpbmZvcm1hdGlvbiBhYm91dCBESU1NIG9uIGEgY2VydGFpb24gc2xvdC4NCj4gCQkJ
CQkgICBeXl5eXl5eXg0KPiBSdW4geW91ciB3aG9sZSBwYXRjaCB0aHJvdWdoIGEgc3BlbGxjaGVj
a2VyLg0KR29vZCB0aXAuIFJ1biBpdCB0aHJvdWdoIGFzcGVsbC4gVGhvdWdoIHRoZXJlIGFyZSBh
IGxvdCBvZiBmYWxzZSBwb3NpdGl2ZXMsIGVzcGVjaWFsbHkgZm9yIHRoZSBnaXQgaGFzaGVzLiBB
bnkgdGlwcyBvbiB0aGlzPw0KQlRXLCBpdCBkaWQgcGljayB1cCAic3luZHJvbSIgYXMgYW4gZXJy
b3Igd2hlcmUgdGhlIGNvcnJlY3Qgc3BlbGxpbmcgaXMgInN5bmRyb21lIi4gQnV0IHRoZSBoYXJk
d2FyZSByZWdpc3RlciBpcyBuYW1lZCB0aGF0IHdheSBzbyBJIGtlcHQgdGhhdCBhbG9uZS4NCj4g
PiArCWlmIChlZGVjLnNpbmdsZV9lcnJvcl9jb3VudCAhPSAwKSB7DQo+IAlpZiAoZWRlYy5zaW5n
bGVfZXJyb3JfY291bnQpIHsNCj4gaXMgZW5vdWdoLiBCZWxvdyB0b28uDQpEb25lLg0KPiA+ICsJ
CWlmIChzbWNfaW5mby5zaXplX0dCID09IDApIHsNCj4NCj4gCQlpZiAoIS4uLg0KPiANCkRvbmUN
Cg0KPiA+ICsJLyogT25seSBQT0xMIG1vZGUgc3VwcG9ydGVkIHNvIGZhci4gKi8NCj4gPiArCWVk
YWNfb3Bfc3RhdGUgPSBFREFDX09QU1RBVEVfUE9MTDsNCj4gDQo+IFRoaXMgbmVlZHMgdG8gaGFw
cGVuICpsYXN0KiBpbiB0aGlzIGZ1bmN0aW9uLCB3aGVuIGV2ZXJ5dGhpbmcgZWxzZSBzdWNjZWVk
cy4NCj4gDQpEb25lDQo+ID4gKwlpZiAobWNpID09IE5VTEwpDQo+IA0KPiAJaWYgKCFtY2kpDQo+
IA0KRG9uZQ0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMhIEp1c3QgcG9zdGVkIGEgVjIgcGF0
Y2ggYWRkcmVzc2luZyB0aGVtLg0K
