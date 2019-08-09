Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE529C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0202086A
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="L7TkHwiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407352AbfHIQuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:50:52 -0400
Received: from mail-eopbgr740070.outbound.protection.outlook.com ([40.107.74.70]:27616
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726157AbfHIQuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:50:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3p0XdxFd5PNk0B1Dx1necgwDcqjnWZb5RcXWqFvpNz915ZSLnRnW+u0hPtc4GtCPC9dbP6qmp2O45xG+Xi9kTrWTCWfr6ZkIKWS7zBU9dowBuVQh8EDTVv/URhhvqw8lW9IUGvz3LtuyjWGZUOeT1+XXsIe7ekuvCHDqD5dmGSrDA4yCgcfEJHXebXpUJNsXl0KracAqKgNp8d01FoxFtdm7rB5CfWzzwdEDei0tBj9Jx5o6n6XRuMp8jre+mIv8tYIYk5T46+GWEcQNGyF4FQjFO2OV9uYAIwDGmTzwNlRQBRIedLSHagH0OYxoj4sBBPSd4B8z98og2dJDnzWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHX32SBVQElESdgeTaGUtts5k30Jli91KfK+qmfEGKw=;
 b=CY5aTmGFqnbWmUB7RErtkLpdXY/UWEnjXG4W2U/VfQal1q2D66v4TK1zTaHjXDEHkDGrzM/4S2MXOUK3w+lRYxfe8GMmTLpI0Jxwa8AtYVPR6NVwGzM9/OYj+9lIB7s1EDzqvgx2KRkwAaPKlxHrkhiDVgNlbZ6xAtYLkw0+jSW7vDC8hodxRMnm8mOsRATbzM8UPzhpr0nhw/jsYFIsNvagZGJVhOjSxzr6UNJktgApu9tGWhWYA9VBYe0A/ER6JiMv+t1P/Jn4OLPFJBW4B6yRZpiZDnoSXn7CcyL0weIDk6f03PPnTsY81CJw//5ciLPjWLNWemf41cq+PyOCLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHX32SBVQElESdgeTaGUtts5k30Jli91KfK+qmfEGKw=;
 b=L7TkHwiTcbkBVA/+2lYWaF3v7btNClHoe7w0Dna6Fqb5LV9gEc74XEG5MGeD9sjOXj/i1jgmOWfOAUFeiBsevST4rIYBV7rdbgwJ3rc1W8okt0L980FcaqtM4RUUXer+4ray5jsIMfgasp99SDLYmfAABclOd4qfdPTJkjCybmM=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3113.namprd12.prod.outlook.com (20.178.31.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.12; Fri, 9 Aug 2019 16:50:49 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2157.015; Fri, 9 Aug 2019
 16:50:49 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "bp@alien8.de" <bp@alien8.de>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 3/3] iommu: Disable passthrough mode when SME is active
Thread-Topic: [PATCH 3/3] iommu: Disable passthrough mode when SME is active
Thread-Index: AQHVTsZIO8GEDV51QUKwXSImTUrW96bzB5aA
Date:   Fri, 9 Aug 2019 16:50:48 +0000
Message-ID: <7f383631-ce2c-e7c2-ceff-e7418bf8ff29@amd.com>
References: <20190809152233.2829-1-joro@8bytes.org>
 <20190809152233.2829-4-joro@8bytes.org>
In-Reply-To: <20190809152233.2829-4-joro@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR06CA0032.namprd06.prod.outlook.com
 (2603:10b6:805:8e::45) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5318726a-6675-4e3e-bad2-08d71ce9bb00
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3113;
x-ms-traffictypediagnostic: DM6PR12MB3113:
x-microsoft-antispam-prvs: <DM6PR12MB311343100FF35E3664177311ECD60@DM6PR12MB3113.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(396003)(136003)(366004)(376002)(346002)(199004)(189003)(478600001)(25786009)(2616005)(86362001)(76176011)(102836004)(486006)(6512007)(186003)(476003)(11346002)(229853002)(6486002)(6116002)(2906002)(3846002)(14454004)(256004)(14444005)(6246003)(53936002)(6916009)(52116002)(99286004)(4326008)(66066001)(26005)(8936002)(66446008)(54906003)(36756003)(64756008)(5660300002)(66476007)(66556008)(66946007)(316002)(305945005)(71200400001)(446003)(31686004)(81156014)(8676002)(81166006)(53546011)(31696002)(6436002)(386003)(6506007)(7736002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3113;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1VornK6UV0TVifiRmnW6xHqROpj2GYd41YgqW2JsoJa0ijYsZMp7e3/4a/CsnSu5CrGQoMxq9p6MRt3p7ldGEvyMkpCs7xVSTR2KZ47VVBBUM+cZvAVZ5xvNUM8dGAMwHgsquJ0/rcqHlmfdK9wAmJULzyrqLMz5fIkOfg849ZgGpFau8iE4P8WaTWb+HSmHkM0bAqW7RTsQ3Vh1i3lswd3pqdOTlHs7St5gazBfaKP69Zx1a9W3g0T0AmXGP0x6zTVdDFkJUfkolazfzWKlVZbuCUqgO1xpCEQCHNDhTwFSpkaH7F5PvO5lTsUlJuDbjIVPVbA/HSJw4eFvh+QlIL/cy0bJTQwkmDt+1Mk7hEkkLwroeRO5rDPQ3HcML7wQ1xCnsQpLAg0iwGKr3uVSi36QWVIr99OhA4uWqrR8fqE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEB52BBA38B43F4B863084D137BFABE7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5318726a-6675-4e3e-bad2-08d71ce9bb00
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 16:50:48.8528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YrmnfTeufK0bExbMiuvOoJ4u7QpHLVhfph9fuABfO0R9AloT8QtuZol0U9ypHNSkou9VRDPTsPJg4CjX6JDfcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC85LzE5IDEwOjIyIEFNLCBKb2VyZyBSb2VkZWwgd3JvdGU6DQo+IEZyb206IEpvZXJnIFJv
ZWRlbCA8anJvZWRlbEBzdXNlLmRlPg0KPiANCj4gVXNpbmcgUGFzc3Rocm91Z2ggbW9kZSB3aGVu
IFNNRSBpcyBhY3RpdmUgY2F1c2VzIGNlcnRhaW4NCj4gZGV2aWNlcyB0byB1c2UgdGhlIFNXSU9U
TEIgYm91bmNlIGJ1ZmZlci4gVGhlIGJvdW5jZSBidWZmZXINCj4gY29kZSBoYXMgYW4gdXBwZXIg
bGltaXQgb2YgMjU2a2IgZm9yIHRoZSBzaXplIG9mIERNQQ0KPiBhbGxvY2F0aW9ucywgd2hpY2gg
aXMgdG9vIHNtYWxsIGZvciBjZXJ0YWluIGRldmljZXMgYW5kDQo+IGNhdXNlcyB0aGVtIHRvIGZh
aWwuDQo+IA0KPiBXaXRoIHRoaXMgcGF0Y2ggd2UgZW5hYmxlIElPTU1VIGJ5IGRlZmF1bHQgd2hl
biBTTUUgaXMNCj4gYWN0aXZlIGluIHRoZSBzeXN0ZW0sIG1ha2luZyB0aGUgZGVmYXVsdCBjb25m
aWd1cmF0aW9uIHdvcmsNCj4gZm9yIG1vcmUgc3lzdGVtcyB0aGFuIGl0IGRvZXMgbm93Lg0KPiAN
Cj4gVXNlcnMgdGhhdCBkb24ndCB3YW50IElPTU1VcyB0byBiZSBlbmFibGVkIHN0aWxsIGNhbiBk
aXNhYmxlDQo+IHRoZW0gd2l0aCBrZXJuZWwgcGFyYW1ldGVycy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEpvZXJnIFJvZWRlbCA8anJvZWRlbEBzdXNlLmRlPg0KPiAtLS0NCj4gICBkcml2ZXJzL2lv
bW11L2lvbW11LmMgfCA2ICsrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvbW11LmMgYi9kcml2ZXJzL2lv
bW11L2lvbW11LmMNCj4gaW5kZXggNjJjYWU2ZGIwOTcwLi5mYmUxYWE1MWJjZTkgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYw0KPiArKysgYi9kcml2ZXJzL2lvbW11L2lvbW11
LmMNCj4gQEAgLTEwNCw2ICsxMDQsMTIgQEAgc3RhdGljIGludCBfX2luaXQgaW9tbXVfc3Vic3lz
X2luaXQodm9pZCkNCj4gICAJZWxzZQ0KPiAgIAkJaW9tbXVfZGVmX2RvbWFpbl90eXBlID0gSU9N
TVVfRE9NQUlOX0RNQTsNCj4gICANCj4gKwlpZiAoKGlvbW11X2RlZl9kb21haW5fdHlwZSA9PSBJ
T01NVV9ET01BSU5fSURFTlRJVFkpICYmDQo+ICsJICAgIHNtZV9hY3RpdmUoKSkgew0KPiArCQlw
cl9pbmZvKCJTTUUgZGV0ZWN0ZWQgLSBEaXNhYmxpbmcgZGVmYXVsdCBJT01NVSBwYXNzdGhyb3Vn
aFxuIik7DQo+ICsJCWlvbW11X2RlZl9kb21haW5fdHlwZSA9IElPTU1VX0RPTUFJTl9ETUE7DQoN
ClNob3VsZCB0aGlzIGFsc28gY2xlYXIgdGhlIGlvbW11X3Bhc3NfdGhyb3VnaCB2YXJpYWJsZSAo
dGhlIG9uZSBzZXQgYnkgdGhlDQppb21tdSBrZXJuZWwgcGFyYW1ldGVyIGluIGFyY2gveDg2L2tl
cm5lbC9wY2ktZG1hLmMpPw0KDQpJIGd1ZXNzIHRoaXMgaXMgbW9yZSBhcHBsaWNhYmxlIHRvIHRo
ZSBvcmlnaW5hbCBwYXRjaHNldCB0aGF0IGNyZWF0ZWQgdGhlDQpDT05GSUdfSU9NTVVfREVGQVVM
VF9QQVNTVEhST1VHSCBvcHRpb24sIGJ1dCBzaG91bGQgdGhlIGRlZmF1bHQNCnBhc3N0aHJvdWdo
IHN1cHBvcnQgYmUgbW9kaWZpZWQgc28gdGhhdCB5b3UgZG9uJ3QgaGF2ZSB0byBzcGVjaWZ5IG11
bHRpcGxlDQprZXJuZWwgcGFyYW1ldGVycyB0byBjaGFuZ2UgaXQ/DQoNClJpZ2h0IG5vdywgaWYg
Q09ORklHX0lPTU1VX0RFRkFVTFRfUEFTU1RIUk9VR0ggaXMgc2V0IHRvIHllcywgeW91IGNhbid0
DQpqdXN0IHNwZWNpZnkgaW9tbXU9bm9wdCB0byBlbmFibGUgdGhlIElPTU1VLiBZb3UgaGF2ZSB0
byBhbHNvIHNwZWNpZnkNCmlvbW11LnBhc3N0aHJvdWdoPTAuIERvIHdlIHdhbnQgdG8gZml4IHRo
YXQgc28gdGhhdCBqdXN0IHNwZWNpZnlpbmcNCmlvbW11PW5vcHQgb3IgaW9tbXUucGFzc3Rocm91
Z2g9MCBkb2VzIHdoYXQgaXMgbmVlZGVkPw0KDQpUaGFua3MsDQpUb20NCg0KPiArCX0NCj4gKw0K
PiAgIAlwcl9pbmZvKCJEZWZhdWx0IGRvbWFpbiB0eXBlOiAlc1xuIiwNCj4gICAJCWlvbW11X2Rv
bWFpbl90eXBlX3N0cihpb21tdV9kZWZfZG9tYWluX3R5cGUpKTsNCj4gICANCj4gDQo=
