Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1317C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FDE21874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LBONo2Ls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfCUPYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:24:46 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:10481 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfCUPYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:24:46 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c93acb80001>; Thu, 21 Mar 2019 23:24:40 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 21 Mar 2019 08:24:40 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 21 Mar 2019 08:24:40 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Mar
 2019 15:24:40 +0000
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.55) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 21 Mar 2019 15:24:39 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3590.namprd12.prod.outlook.com (20.178.197.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Thu, 21 Mar 2019 15:24:37 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26%6]) with mapi id 15.20.1730.013; Thu, 21 Mar 2019
 15:24:37 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Subject: RE: [PATCH V3 01/10] mmc: tegra: fix ddr signaling for non-ddr modes
Thread-Topic: [PATCH V3 01/10] mmc: tegra: fix ddr signaling for non-ddr modes
Thread-Index: AQHU2eYqdgEs7XEeaUGSv6mRVWCzCqYV7v4AgABRJdA=
Date:   Thu, 21 Mar 2019 15:24:37 +0000
Message-ID: <BYAPR12MB339888D3A370E790A29E217EC2420@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
 <CAPDyKFp30v1H0KfPFeOc5Ut1dW5tec7cT7NFk6j0VT+DWkAODw@mail.gmail.com>
In-Reply-To: <CAPDyKFp30v1H0KfPFeOc5Ut1dW5tec7cT7NFk6j0VT+DWkAODw@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfbb8167-d9a3-45d4-dc9a-08d6ae115465
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3590;
x-ms-traffictypediagnostic: BYAPR12MB3590:
x-microsoft-antispam-prvs: <BYAPR12MB3590FC71DF7CADE148172374C2420@BYAPR12MB3590.namprd12.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39860400002)(376002)(136003)(189003)(199004)(316002)(6116002)(71200400001)(8936002)(71190400001)(4326008)(105586002)(97736004)(102836004)(99286004)(76176011)(7696005)(6916009)(106356001)(3846002)(6506007)(86362001)(26005)(305945005)(7736002)(54906003)(256004)(25786009)(7416002)(74316002)(9686003)(186003)(5660300002)(55016002)(14454004)(6246003)(446003)(53936002)(68736007)(66066001)(81156014)(11346002)(81166006)(229853002)(476003)(486006)(2906002)(6436002)(52536014)(8676002)(33656002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3590;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: evk8OPQNXeOOwU2qOqywgkS15K2R271JITUxhsY1T+AMPUD07ygewF8iAakZzoJWSqZlRplcKOLw9atm3duRMzTeQWYiZtlf4c2tnL2mbVxYm2RIXE7MQTnf1+gfbjsGtu0Db3H8f3dFlJX5MA9+qUW40k55Q9JkwekwqnkUg3jO2SIdvcgxzI+WbW/HNqvb73Opjpkxjg1X3AiL4m9JzEohDT16ZclgUFVH3v9oX0cIYS4youLP2bg3PptaXPP7G8exTFpvnYTz8i1/e3vrmPyF9c6ZXW0d2ONkOgsOCddUfrvcSX/j3JZNkwNApu7jOfNJBqCtQTSbiIu6msDCK1sXT2dSwd4CgB6L3Lf+SvvZnLNfqo/FxMob+DCgbBZKb+mB2/eweqlgZ1zoogJISuZI57PVaVKhgxvhgsfGHx0=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbb8167-d9a3-45d4-dc9a-08d6ae115465
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 15:24:37.1251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3590
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553181881; bh=/hfKprif990/k1xjE6NcZow1Oe7/t8hrGmKSLMIH7e4=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-microsoft-antispam:x-ms-traffictypediagnostic:
         x-microsoft-antispam-prvs:x-forefront-prvs:
         x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=LBONo2Ls1YMxkNRW5JQQzx/nMcIXoXwSSPJiMSXw2FwDIyWGKY5xKn6Jc+lrfud/T
         Lb7PZ++Ikad0iNYAG1sh/0fnTeHdbHnsH4t9uPXhQ52idQWs5QUU3FyQ+wdTP/Mu6X
         23DUWc1SUoU6U+X5OwbJhCtMVYQpOtYUbXgoBB/7O3oe2IWk16mhyZL6Ox5fC+gg3W
         xJ082LUuDBsPRWjjfcRAZbRf5kIKPedkdri0IpOuI9FR3FsZ5qstwafkqgBRq5kLoD
         s5ZNTmVymkpK5QqUYExvn/hU/+FIJuu/qToFqCv3g3RcAHpcQAo2tHE0R16TIgAPcT
         y2UmBvC9fXLEQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+DQo+ID4gZGRyX3NpZ25hbGluZyBpcyBzZXQgdG8gdHJ1ZSBmb3IgRERSNTAgYW5kIEREUjUy
IG1vZGVzIGJ1dCBpcyBub3Qgc2V0IA0KPiA+IGJhY2sgdG8gZmFsc2UgZm9yIG90aGVyIG1vZGVz
LiBUaGlzIHByb2dyYW1zIGluY29ycmVjdCBob3N0IGNsb2NrIHdoZW4gDQo+ID4gbW9kZSBjaGFu
Z2UgaGFwcGVucyBmcm9tIEREUjUyL0REUjUwIHRvIG90aGVyIFNEUiBvciBIUyBtb2RlcyBsaWtl
IA0KPiA+IGluY2FzZSBvZiBtbWNfcmV0dW5lIHdoZXJlIGl0IHN3aXRjaGVzIGZyb20gSFM0MDAg
dG8gSFMgRERSIGFuZCB0aGVuIA0KPiA+IGZyb20gSFMgRERSIHRvIEhTIG1vZGUgYW5kIHRoZW4g
dG8gSFMyMDAuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBkZHJfc2lnbmFsaW5nIHRv
IHNldCBwcm9wZXJseSBmb3Igbm9uIEREUiBtb2Rlcy4NCj4gPg0KPiA+IFRlc3RlZC1ieTogSm9u
IEh1bnRlciA8am9uYXRoYW5oQG52aWRpYS5jb20+DQo+ID4gQWNrZWQtYnk6IEFkcmlhbiBIdW50
ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNvd2phbnlh
IEtvbWF0aW5lbmkgPHNrb21hdGluZW5pQG52aWRpYS5jb20+DQo+DQo+IElzIHRoaXMgYSBmaXgg
YW5kL29yIHNoYWxsIEkgdGFnIGl0IGZvciBzdGFibGU/DQo+DQo+IFRoZSBzZXJpZXMgbG9va3Mg
Z29vZCB0byBtZSwgaG93ZXZlciBJIGFtIGF3YWl0aW5nIHR3byBtb3JlIGFja3MgZnJvbSBBZHJp
YW4gb24gcGF0Y2ggMiBhbmQgcGF0Y2gzLg0KPg0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0KPg0K
Pg0KVGhhbmtzIFVmZmUuIFllcyB0aGlzIGlzIGFwcGxpY2FibGUgZm9yIHN0YWJsZS4NCg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLXRlZ3JhLmMgfCAxICsNCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tbWMvaG9zdC9zZGhjaS10ZWdyYS5jIA0KPiA+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS10
ZWdyYS5jIGluZGV4IDMyZTYyOTA0YzBkMy4uNDYwODZkZDQzYmZiIA0KPiA+IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktdGVncmEuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
bW1jL2hvc3Qvc2RoY2ktdGVncmEuYw0KPiA+IEBAIC03NzksNiArNzc5LDcgQEAgc3RhdGljIHZv
aWQgdGVncmFfc2RoY2lfc2V0X3Voc19zaWduYWxpbmcoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3Qs
DQo+ID4gICAgICAgICBib29sIHNldF9kcXNfdHJpbSA9IGZhbHNlOw0KPiA+ICAgICAgICAgYm9v
bCBkb19oczQwMF9kbGxfY2FsID0gZmFsc2U7DQo+ID4NCj4gPiArICAgICAgIHRlZ3JhX2hvc3Qt
PmRkcl9zaWduYWxpbmcgPSBmYWxzZTsNCj4gPiAgICAgICAgIHN3aXRjaCAodGltaW5nKSB7DQo+
ID4gICAgICAgICBjYXNlIE1NQ19USU1JTkdfVUhTX1NEUjUwOg0KPiA+ICAgICAgICAgY2FzZSBN
TUNfVElNSU5HX1VIU19TRFIxMDQ6DQo+ID4gLS0NCj4gPiAyLjcuNA0KPiA+DQo=
