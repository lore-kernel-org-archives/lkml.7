Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9310DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 04:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D77721741
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 04:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ap9nKHKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfCXEt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 00:49:28 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:50137 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfCXEt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 00:49:27 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c970c550000>; Sun, 24 Mar 2019 12:49:25 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Sat, 23 Mar 2019 21:49:22 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Sat, 23 Mar 2019 21:49:22 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 24 Mar
 2019 04:49:21 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.58) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sun, 24 Mar 2019 04:49:21 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3464.namprd12.prod.outlook.com (20.178.196.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Sun, 24 Mar 2019 04:49:17 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26%6]) with mapi id 15.20.1730.019; Sun, 24 Mar 2019
 04:49:17 +0000
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
Thread-Index: AQHU2eYqdgEs7XEeaUGSv6mRVWCzCqYV7v4AgABRJdCABAVJwA==
Date:   Sun, 24 Mar 2019 04:49:17 +0000
Message-ID: <BYAPR12MB3398DDACBBD120C77CABD14FC25D0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
 <CAPDyKFp30v1H0KfPFeOc5Ut1dW5tec7cT7NFk6j0VT+DWkAODw@mail.gmail.com>
 <BYAPR12MB339888D3A370E790A29E217EC2420@BYAPR12MB3398.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB339888D3A370E790A29E217EC2420@BYAPR12MB3398.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5140dd0-fe3a-422b-a77d-08d6b0141255
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3464;
x-ms-traffictypediagnostic: BYAPR12MB3464:
x-microsoft-antispam-prvs: <BYAPR12MB34649ADBEFF77C0E8F777013C25D0@BYAPR12MB3464.namprd12.prod.outlook.com>
x-forefront-prvs: 09860C2161
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39850400004)(136003)(396003)(366004)(199004)(189003)(106356001)(7736002)(74316002)(305945005)(6916009)(52536014)(446003)(486006)(11346002)(476003)(26005)(102836004)(6506007)(76176011)(7696005)(8676002)(81156014)(81166006)(97736004)(99286004)(2906002)(5660300002)(105586002)(229853002)(86362001)(4326008)(14454004)(55016002)(316002)(54906003)(3846002)(8936002)(33656002)(6436002)(6246003)(14444005)(256004)(7416002)(71200400001)(71190400001)(66066001)(186003)(478600001)(9686003)(6116002)(25786009)(68736007)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3464;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rxcWFHo0Jgrs5hcOU9pfmSiwfF3oQIbPSljw7jJCPa+GA7FZCMlL04xhBvEyMi6OK5Yl4v6CYTmGrc8PSbZKeRjNUvXAIt7THbqI7SApf1Zx9aZAp/jR0/vJY5zt48o8wwOQzJtoS79I7gdmby3CqoZQ4JWaoKVayprA+AboSA817UsTgSdkG88dn3HZDR6wU/ZyEohWtuBRMD8XWEngJG+ZmgTmXIdO1pFPOW844XsYuiqnQymXL3R5VqaxW9USufHiKsxKR+6Au00u1ad5wSCVLxJ6TguimfpLRawJZ+u/5g6jpHberTX+yFx5FK50kH0LD7dlqPplDhrH/4TsKrLAXrP3uci8yS6LEKHB9M2csF5xQWPt3eksQgFYkDDZVK7qQpNYeVE+VY+GzXXRLq0CL0eCnN8LpXgN2n3D7T8=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f5140dd0-fe3a-422b-a77d-08d6b0141255
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2019 04:49:17.1300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3464
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553402966; bh=FgAWg9nYoDoyfts6DLRINmFFXVBUZTqdaKANqdNfqZ8=;
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
        b=ap9nKHKTJDAUny2Y80C1h6ISxSVOzI+WRvviBsdBoHyIHS/cenljMGS8D7oPz9P3Y
         i783quWdTfBK+CvcPXIZpn401hlVIgon9r1+iFFq3LKes4mpmp8iz8jhwpbkAM3dda
         XK9T8RA9MWwK/AymAfXzfvNSCjVXFTHt0OwRShfIGaq4WBWOS9mykw+e023HPM2X1N
         JI/OtGCUQFK/KNU736JkG1Tj3cZ3QGc8Fc0jEhbT5gESZSh6RHaZK85HpkkcSldSVQ
         fRx9Y5DdTyAjtUB/Rjx9ja3TXG6vZUMQxp5waOLVPr/1b9Z3j00Wm2JUFdHz9NOSV2
         1iZGWHZnExd+g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+DQo+ID4gZGRyX3NpZ25hbGluZyBpcyBzZXQgdG8gdHJ1ZSBmb3IgRERSNTAgYW5kIEREUjUy
IG1vZGVzIGJ1dCBpcyBub3QgDQo+ID4gc2V0IGJhY2sgdG8gZmFsc2UgZm9yIG90aGVyIG1vZGVz
LiBUaGlzIHByb2dyYW1zIGluY29ycmVjdCBob3N0IA0KPiA+IGNsb2NrIHdoZW4gbW9kZSBjaGFu
Z2UgaGFwcGVucyBmcm9tIEREUjUyL0REUjUwIHRvIG90aGVyIFNEUiBvciBIUyANCj4gPiBtb2Rl
cyBsaWtlIGluY2FzZSBvZiBtbWNfcmV0dW5lIHdoZXJlIGl0IHN3aXRjaGVzIGZyb20gSFM0MDAg
dG8gSFMgDQo+ID4gRERSIGFuZCB0aGVuIGZyb20gSFMgRERSIHRvIEhTIG1vZGUgYW5kIHRoZW4g
dG8gSFMyMDAuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBkZHJfc2lnbmFsaW5nIHRv
IHNldCBwcm9wZXJseSBmb3Igbm9uIEREUiBtb2Rlcy4NCj4gPg0KPiA+IFRlc3RlZC1ieTogSm9u
IEh1bnRlciA8am9uYXRoYW5oQG52aWRpYS5jb20+DQo+ID4gQWNrZWQtYnk6IEFkcmlhbiBIdW50
ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNvd2phbnlh
IEtvbWF0aW5lbmkgPHNrb21hdGluZW5pQG52aWRpYS5jb20+DQo+DQo+IElzIHRoaXMgYSBmaXgg
YW5kL29yIHNoYWxsIEkgdGFnIGl0IGZvciBzdGFibGU/DQo+DQo+IFRoZSBzZXJpZXMgbG9va3Mg
Z29vZCB0byBtZSwgaG93ZXZlciBJIGFtIGF3YWl0aW5nIHR3byBtb3JlIGFja3MgZnJvbSBBZHJp
YW4gb24gcGF0Y2ggMiBhbmQgcGF0Y2gzLg0KPg0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0KPg0K
Pg0KVGhhbmtzIFVmZmUuIFllcyB0aGlzIGlzIGFwcGxpY2FibGUgZm9yIHN0YWJsZS4NCg0KSnVz
dCBzZW50IHVwZGF0ZWQgcGF0Y2ggc2VyaWVzIFY0IHdpdGggbWlub3IgZml4IGZvciBhdm9pZGlu
ZyBidWlsZCBlcnJvciB3YXJuaW5nLg0KRGlkbuKAmXQgc2VlIGVhcmxpZXIgYW5kIGZvdW5kIG1p
c3NpbmcgLVdlcnJvciBmbGFnIGR1cmluZyBidWlsZC4gU28gZml4ZWQgaW4gVjQuDQoNCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS10ZWdyYS5jIHwgMSArDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bW1jL2hvc3Qvc2RoY2ktdGVncmEuYyANCj4gPiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktdGVn
cmEuYyBpbmRleCAzMmU2MjkwNGMwZDMuLjQ2MDg2ZGQ0M2JmYg0KPiA+IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktdGVncmEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1j
L2hvc3Qvc2RoY2ktdGVncmEuYw0KPiA+IEBAIC03NzksNiArNzc5LDcgQEAgc3RhdGljIHZvaWQg
dGVncmFfc2RoY2lfc2V0X3Voc19zaWduYWxpbmcoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsDQo+
ID4gICAgICAgICBib29sIHNldF9kcXNfdHJpbSA9IGZhbHNlOw0KPiA+ICAgICAgICAgYm9vbCBk
b19oczQwMF9kbGxfY2FsID0gZmFsc2U7DQo+ID4NCj4gPiArICAgICAgIHRlZ3JhX2hvc3QtPmRk
cl9zaWduYWxpbmcgPSBmYWxzZTsNCj4gPiAgICAgICAgIHN3aXRjaCAodGltaW5nKSB7DQo+ID4g
ICAgICAgICBjYXNlIE1NQ19USU1JTkdfVUhTX1NEUjUwOg0KPiA+ICAgICAgICAgY2FzZSBNTUNf
VElNSU5HX1VIU19TRFIxMDQ6DQo+ID4gLS0NCj4gPiAyLjcuNA0KPiA+DQo=
