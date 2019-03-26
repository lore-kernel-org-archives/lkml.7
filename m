Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A8FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847612070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FTPon4WT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbfCZLlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:41:09 -0400
Received: from mail-eopbgr680076.outbound.protection.outlook.com ([40.107.68.76]:38798
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbfCZLlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68pznNmkV8KtdP0HgNFB7g2U2fOBOVPOZJ6V1UeBknw=;
 b=FTPon4WTysWZ8yzXh2SB+Oof9Z4p4TA4/AjjjuxdgEQ1LBpsMNhVTYsPLkEcVBjfyIAIw6dJDH0zTg6vJviWjQ+nuRnUr2+YQ8Lc5Kf57C6yBAMbUM+ljbEeK03cpvzLF7YVhWzeWkGcx4/3PtZpx5ryoEJ9tUBQo/eOEV5pznA=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2813.namprd12.prod.outlook.com (52.135.100.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Tue, 26 Mar 2019 11:41:05 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 11:41:05 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: RE: [PATCH v4 1/2] x86/MCE: Add function to allow filtering of MCA
 errors
Thread-Topic: [PATCH v4 1/2] x86/MCE: Add function to allow filtering of MCA
 errors
Thread-Index: AQHU4yiZZ+0d48CL0U+6DDOUp4sfcKYdjJ+AgAA9HXA=
Date:   Tue, 26 Mar 2019 11:41:05 +0000
Message-ID: <SN6PR12MB2639C80DA928C41AA678DFB6F85F0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190325163410.171021-1-Yazen.Ghannam@amd.com>
 <20190326075651.GB1867@zn.tnic>
In-Reply-To: <20190326075651.GB1867@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [75.66.99.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bb4fd41-36e1-4d68-5d33-08d6b1dfee45
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2813;
x-ms-traffictypediagnostic: SN6PR12MB2813:
x-microsoft-antispam-prvs: <SN6PR12MB28130BBF1645754A14E3A564F85F0@SN6PR12MB2813.namprd12.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(366004)(39860400002)(199004)(189003)(13464003)(3846002)(256004)(4326008)(14444005)(99286004)(33656002)(68736007)(74316002)(6116002)(102836004)(7736002)(52536014)(305945005)(53546011)(7696005)(5660300002)(26005)(6506007)(76176011)(229853002)(6916009)(53936002)(6436002)(106356001)(486006)(6246003)(25786009)(2906002)(186003)(476003)(66066001)(81166006)(11346002)(446003)(316002)(55016002)(81156014)(9686003)(478600001)(8676002)(71200400001)(54906003)(86362001)(72206003)(71190400001)(8936002)(14454004)(97736004)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2813;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: d9OdqRK+95RDnFHSzsni7K9Xdlguriky6X00h1i+NQwlMUSSU89IhSsG4YYvtTzJxReV9kRGph/ksYk7nhr2h2fXm1ny5wG6HMb8hHzaK+NFbxZCvLnD6VV6M0Nzak9fbH3tygwqmByvJVjplnO5JCs76XCgfIFZZhVIwvP/AnvP2vTY3+KgG8GYknRiXvK3WC+AdJdDpVcWckDUAZ7KVlSmHVjtLIoO3+3k8k4P4w24ror0y2za4b+jWKfgjJWW36mRaSW9PT2beXuyUnDHf3g44Aie2ZXV06NARGTar+IdohPPGJqgRY1BvhDtabccaXfE4P+AMkGBk5nKXdpSfgTxf5ycx6Caz0RRYvUHwaPWL3Ukj1wG1vXizvytLXHrcOo1dwF3IA87qG9Kw0ZoebtTBjRjKClzni6OsO5oPRI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb4fd41-36e1-4d68-5d33-08d6b1dfee45
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 11:41:05.1989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2813
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogVHVlc2RheSwgTWFyY2ggMjYsIDIwMTkgMjo1
NyBBTQ0KPiBUbzogR2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4NCj4gQ2M6
IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyB0b255Lmx1Y2tAaW50ZWwuY29tOyB4ODZAa2VybmVsLm9yZzsgcmFmYWxAbWlsZWNraS5wbDsN
Cj4gY2xlbWVqQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEvMl0geDg2L01D
RTogQWRkIGZ1bmN0aW9uIHRvIGFsbG93IGZpbHRlcmluZyBvZiBNQ0EgZXJyb3JzDQo+IA0KPiBP
biBNb24sIE1hciAyNSwgMjAxOSBhdCAwNDozNDoyMlBNICswMDAwLCBHaGFubmFtLCBZYXplbiB3
cm90ZToNCj4gPiBGcm9tOiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+
ID4NCj4gPiBTb21lIHN5c3RlbXMgbWF5IHJlcG9ydCBzcHVyaW91cyBNQ0EgZXJyb3JzLiBJbiBn
ZW5lcmFsLCBzcHVyaW91cyBNQ0ENCj4gPiBlcnJvcnMgbWF5IGJlIGRpc2FibGVkIGJ5IGNsZWFy
aW5nIGEgcGFydGljdWxhciBiaXQgaW4gTUNBX0NUTC4gSG93ZXZlciwNCj4gPiBjbGVhcmluZyBh
IGJpdCBpbiBNQ0FfQ1RMIG1heSBub3QgYmUgcmVjb21tZW5kZWQgZm9yIHNvbWUgZXJyb3JzLCBz
byB0aGUNCj4gPiBvbmx5IG9wdGlvbiBpcyB0byBpZ25vcmUgdGhlbS4NCj4gPg0KPiA+IEFuIE1D
QSBlcnJvciBpcyBwcmludGVkIGFuZCBoYW5kbGVkIGFmdGVyIGl0IGhhcyBiZWVuIGFkZGVkIHRv
IHRoZSBNQ0UNCj4gPiBldmVudCBwb29sLiBTbyBhbiBNQ0EgZXJyb3IgY2FuIGJlIGlnbm9yZWQg
Ynkgbm90IGFkZGluZyBpdCB0byB0aGUgcG9vbC4NCj4gPg0KPiA+IERlZmluZSBhIGRlZmF1bHQg
ZnVuY3Rpb24gdGhhdCBkb2VzIG5vdCBmaWx0ZXIgYW55IGVycm9ycy4NCj4gPg0KPiA+IENoZWNr
IGlmIGFuIE1DQSBlcnJvciBzaG91bGQgYmUgZmlsdGVyZWQgb3V0IHdoZW4gYWRkaW5nIGl0IHRv
IHRoZSBNQ0UNCj4gPiBldmVudCBwb29sLg0KPiA+DQo+ID4gQ2M6IDxzdGFibGVAdmdlci5rZXJu
ZWwub3JnPiAjIDUuMC54DQo+IA0KPiBUaGUgb2xkIHZlcnNpb24gb2YgdGhlIHBhdGNoZXMgaGFk
IDQuMTQueCBoZXJlIGFzIGEga2VybmVsIHZlcnNpb24uIFdoeQ0KPiBjaGFuZ2U/DQo+IA0KDQpU
aGV5IGRvbid0IGFwcGx5IGNsZWFubHkgdG8gdjQuMTQgYW55bW9yZSBiZWNhdXNlIG9mIHRoZSBy
ZWNlbnQgaGVhZGVyIGNoYW5nZS4NCg0KSSBmaWd1cmVkIHRoZXkgd291bGQgbmVlZCB0byBiZSBm
aXhlZCB1cCBhbmQgc3VibWl0dGVkIHNlcGFyYXRlbHkgdG8gb2xkZXIgc3RhYmxlDQp2ZXJzaW9u
cy4gSXMgdGhhdCBva2F5Pw0KDQpUaGFua3MsDQpZYXplbg0K
