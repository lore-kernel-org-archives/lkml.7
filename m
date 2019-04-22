Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA27C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 11:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FEE20881
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 11:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="hma3kdAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfDVLQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 07:16:32 -0400
Received: from mail-eopbgr740088.outbound.protection.outlook.com ([40.107.74.88]:29351
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727209AbfDVLQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 07:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lpVgj7ONHNsckSyALqROX2X3hK05oUADOnt+uYtEOs=;
 b=hma3kdAn+W+tVsoF2t3ozpabAQpUizkE7QolDow0GNmS9pojYOQu2WtLD3kyyPozm5pW6TcgkPFCMuXlWYCRhZ7Ek5iZf3TpZ17FcclH70zfpAdRDHLNoDyHe0AKT5PoEEtqED2ddWGXVQMQWzKnq2XNranijnCB/IoXnnHk+WU=
Received: from BN3PR03CA0051.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::11) by CO2PR03MB2263.namprd03.prod.outlook.com
 (2603:10b6:102:a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.17; Mon, 22 Apr
 2019 11:16:27 +0000
Received: from CY1NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by BN3PR03CA0051.outlook.office365.com
 (2a01:111:e400:7a4d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1813.12 via Frontend
 Transport; Mon, 22 Apr 2019 11:16:26 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT010.mail.protection.outlook.com (10.152.75.50) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Mon, 22 Apr 2019 11:16:25 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x3MBGOpA032714
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 22 Apr 2019 04:16:24 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Mon, 22 Apr 2019 07:16:23 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@jic23.retrosnub.co.uk" <jic23@jic23.retrosnub.co.uk>
CC:     "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>
Subject: Re: [PATCH 1/2] lib: add __sysfs_match_string_with_gaps() helper
Thread-Topic: [PATCH 1/2] lib: add __sysfs_match_string_with_gaps() helper
Thread-Index: AQHU+OX/0R8yezHYP0WMOZzYo8YTnKZIQBMAgAAKz4A=
Date:   Mon, 22 Apr 2019 11:16:23 +0000
Message-ID: <3a09d375506edd7aa405e9fa85e13028897d7bf4.camel@analog.com>
References: <20190422083257.21805-1-alexandru.ardelean@analog.com>
         <20190422113740.6ef66205@archlinux>
In-Reply-To: <20190422113740.6ef66205@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E98DADC8E6A0D4E9FAF16C063CE42C0@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39860400002)(376002)(2980300002)(199004)(189003)(2351001)(6916009)(70206006)(70586007)(478600001)(118296001)(8936002)(229853002)(2906002)(86362001)(106002)(76176011)(7696005)(356004)(54906003)(5660300002)(316002)(23676004)(2486003)(246002)(6246003)(336012)(186003)(8676002)(5640700003)(11346002)(6116002)(436003)(446003)(2501003)(426003)(3846002)(26005)(102836004)(126002)(476003)(2616005)(486006)(14454004)(305945005)(7636002)(7736002)(47776003)(50466002)(36756003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR03MB2263;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bff5dfe-20f8-41a3-e2c2-08d6c713f59a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:CO2PR03MB2263;
X-MS-TrafficTypeDiagnostic: CO2PR03MB2263:
X-Microsoft-Antispam-PRVS: <CO2PR03MB2263CADDE53A15F0A4351D3EF9220@CO2PR03MB2263.namprd03.prod.outlook.com>
X-Forefront-PRVS: 00159D1518
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ILpxt7Rn4feGG0nSZacAq5JuguHfaZnmn0l1Qz35hx18UAKNg/CSnSUwaR0U+ZLajTwrwsZV1EK1UZTErdyGPOdXcNgyR5pFK6KzoLEZFFzYxNeOiG3cazrTqowEM4VDmaZfQOWw1W0KSCOH1M1761LPQoY+U1roVXMKm4D4GX5XiP2XXLTUf+1vJxz70zmOgWB9x9hqIPxyCvUrQ9teD/uczM7Cc9rGtv8HOHkHqn3qDX+jPeo9yhPYiJkLsIwvzcqPlMo7FDbkpuSg6TIK4jUPs7eh9cLjvXFi2ZbJxJ1hI4hlqqjx6oKks8C6X9bcWthAqT43PYVcf8kHvm1C6bfGkxJM3vJVYkVD5C5SDMRY3hVUQsfAj4E64gHihofnK4Pvf6nnmpSKSxcxRzgFqRkJkgEkBY+HcBb/mUdny98=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2019 11:16:25.3768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bff5dfe-20f8-41a3-e2c2-08d6c713f59a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2263
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA0LTIyIGF0IDExOjM3ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiANCj4gT24gTW9uLCAyMiBBcHIgMjAxOSAxMTozMjo1NiAr
MDMwMA0KPiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29t
PiB3cm90ZToNCj4gDQo+ID4gVGhpcyBoZWxwZXIgaXMgc2ltaWxhciB0byBfX3N5c2ZzX21hdGNo
X3N0cmluZygpIHdpdGggdGhlIGV4Y2VwdGlvbg0KPiA+IHRoYXQgaXQNCj4gPiBpZ25vcmVzIE5V
TEwgZWxlbWVudHMgd2l0aGluIHRoZSBhcnJheS4NCj4gPiBJdCB0YWtlcyBhbiBleHRyYSBwYXJh
bWV0ZXIgKGNhbGxlZCBgZ2Fwc2ApIHdoaWNoIHdoZW4gdHJ1ZSB3aWxsIGlnbm9yZQ0KPiA+IHRo
ZSBOVUxMIGVsZW1lbnRzLiBXaGVuIGZhbHNlLCB0aGlzIGZ1bmN0aW9uIGJlaGF2ZXMgZXhhY3Rs
eSBsaWtlDQo+ID4gYF9fc3lzZnNfbWF0Y2hfc3RyaW5nKClgLg0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+
DQo+IA0KPiBIaSBBbGV4LA0KPiANCj4gVGhlIGV4aXN0ZW5jZSBvZiB0aGF0IGdhcHMgcGFyYW1l
dGVyIGRvZXMgc2VlbSBhIGxpdHRsZSBvZGQuDQo+IFdoeSBub3QganVzdCBoYXZlIHRoZSBleHBv
c2VkIF9nYXBzIGZvcm0gd3JhcCBhIHZlcnNpb24gdGhhdA0KPiB0YWtlcyB0aGF0IHBhcmFtZXRl
ciBhbmQgYWx3YXlzIHNldCBpdCB0byB0cnVlPw0KPiANCg0KVGhhdCB3YXMgb25lIHdheSBJIHRo
b3VnaHQgYWJvdXQgZG9pbmcgaXQuDQpJIHdhcyB0aGlua2luZyBhYm91dCBtYXliZSBub3QgZXhw
b3J0aW5nIHRvbyBtYW55IHN5bWJvbHMsIHNpbmNlIHRoYXQgY2FuDQphZGQgc29tZSBzaXplLW92
ZXJoZWFkIHRvIHRoZSBrZXJuZWwgZHVyaW5nIGxpbmtpbmcuDQoNCkknbGwgc2VuZCBhIFYyLg0K
DQpUaGFua3MNCkFsZXgNCg0KPiBPdGhlcndpc2UgbG9va3MgZ29vZCB0byBtZS4NCj4gDQo+IEpv
bmF0aGFuDQo+IA0KPiA+IC0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L3N0cmluZy5oIHwgIDkgKysr
KysrKystDQo+ID4gIGxpYi9zdHJpbmcuYyAgICAgICAgICAgfCAxNCArKysrKysrKysrLS0tLQ0K
PiA+ICAyIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc3RyaW5nLmggYi9pbmNsdWRlL2xp
bnV4L3N0cmluZy5oDQo+ID4gaW5kZXggNzkyN2I4NzVmODBjLi4zMDU5NWVkNDgzZGMgMTAwNjQ0
DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9zdHJpbmcuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGlu
dXgvc3RyaW5nLmgNCj4gPiBAQCAtMTg5LDcgKzE4OSwxNCBAQCBzdGF0aWMgaW5saW5lIGludCBz
dHJ0b2Jvb2woY29uc3QgY2hhciAqcywgYm9vbA0KPiA+ICpyZXMpDQo+ID4gIH0NCj4gPiANCj4g
PiAgaW50IG1hdGNoX3N0cmluZyhjb25zdCBjaGFyICogY29uc3QgKmFycmF5LCBzaXplX3Qgbiwg
Y29uc3QgY2hhcg0KPiA+ICpzdHJpbmcpOw0KPiA+IC1pbnQgX19zeXNmc19tYXRjaF9zdHJpbmco
Y29uc3QgY2hhciAqIGNvbnN0ICphcnJheSwgc2l6ZV90IG4sIGNvbnN0DQo+ID4gY2hhciAqcyk7
DQo+ID4gK2ludCBfX3N5c2ZzX21hdGNoX3N0cmluZ193aXRoX2dhcHMoY29uc3QgY2hhciAqIGNv
bnN0ICphcnJheSwgc2l6ZV90DQo+ID4gbiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBjb25zdCBjaGFyICpzdHIsIGJvb2wgZ2Fwcyk7DQo+ID4gKw0KPiA+ICtzdGF0aWMg
aW5saW5lIGludCBfX3N5c2ZzX21hdGNoX3N0cmluZyhjb25zdCBjaGFyICogY29uc3QgKmFycmF5
LA0KPiA+IHNpemVfdCBuLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjb25zdCBjaGFyICpzdHIpDQo+ID4gK3sNCj4gPiArICAgICByZXR1cm4gX19zeXNmc19tYXRj
aF9zdHJpbmdfd2l0aF9nYXBzKGFycmF5LCBuLCBzdHIsIGZhbHNlKTsNCj4gPiArfQ0KPiA+IA0K
PiA+ICAvKioNCj4gPiAgICogc3lzZnNfbWF0Y2hfc3RyaW5nIC0gbWF0Y2hlcyBnaXZlbiBzdHJp
bmcgaW4gYW4gYXJyYXkNCj4gPiBkaWZmIC0tZ2l0IGEvbGliL3N0cmluZy5jIGIvbGliL3N0cmlu
Zy5jDQo+ID4gaW5kZXggMzhlNGNhMDhlNzU3Li44ZGRhYzNjZDI5MmEgMTAwNjQ0DQo+ID4gLS0t
IGEvbGliL3N0cmluZy5jDQo+ID4gKysrIGIvbGliL3N0cmluZy5jDQo+ID4gQEAgLTY1OSwzMCAr
NjU5LDM2IEBAIGludCBtYXRjaF9zdHJpbmcoY29uc3QgY2hhciAqIGNvbnN0ICphcnJheSwNCj4g
PiBzaXplX3QgbiwgY29uc3QgY2hhciAqc3RyaW5nKQ0KPiA+ICBFWFBPUlRfU1lNQk9MKG1hdGNo
X3N0cmluZyk7DQo+ID4gDQo+ID4gIC8qKg0KPiA+IC0gKiBfX3N5c2ZzX21hdGNoX3N0cmluZyAt
IG1hdGNoZXMgZ2l2ZW4gc3RyaW5nIGluIGFuIGFycmF5DQo+ID4gKyAqIF9fc3lzZnNfbWF0Y2hf
c3RyaW5nX3dpdGhfZ2FwcyAtIG1hdGNoZXMgc3RyaW5nIGluIGFycmF5IGlnbm9yaW5nDQo+ID4g
TlVMTHMNCj4gPiAgICogQGFycmF5OiBhcnJheSBvZiBzdHJpbmdzDQo+ID4gICAqIEBuOiBudW1i
ZXIgb2Ygc3RyaW5ncyBpbiB0aGUgYXJyYXkgb3IgLTEgZm9yIE5VTEwgdGVybWluYXRlZCBhcnJh
eXMNCj4gPiAgICogQHN0cjogc3RyaW5nIHRvIG1hdGNoIHdpdGgNCj4gPiArICogQGdhcHM6IGJv
b2xlYW4gdG8gaWdub3JlIE5VTEwgZWxlbWVudHMgd2l0aGluIHRoZSBhcnJheQ0KPiA+ICAgKg0K
PiA+ICAgKiBSZXR1cm5zIGluZGV4IG9mIEBzdHIgaW4gdGhlIEBhcnJheSBvciAtRUlOVkFMLCBq
dXN0IGxpa2UNCj4gPiBtYXRjaF9zdHJpbmcoKS4NCj4gPiAgICogVXNlcyBzeXNmc19zdHJlcSBp
bnN0ZWFkIG9mIHN0cmNtcCBmb3IgbWF0Y2hpbmcuDQo+ID4gKyAqIElnbm9yZXMgTlVMTCBwb2lu
dGVycyB3aXRoaW4gdGhlIEBhcnJheSBpZiBAZ2FwcyBpcyB0cnVlLg0KPiA+ICAgKi8NCj4gPiAt
aW50IF9fc3lzZnNfbWF0Y2hfc3RyaW5nKGNvbnN0IGNoYXIgKiBjb25zdCAqYXJyYXksIHNpemVf
dCBuLCBjb25zdA0KPiA+IGNoYXIgKnN0cikNCj4gPiAraW50IF9fc3lzZnNfbWF0Y2hfc3RyaW5n
X3dpdGhfZ2Fwcyhjb25zdCBjaGFyICogY29uc3QgKmFycmF5LCBzaXplX3QNCj4gPiBuLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKnN0ciwgYm9vbCBn
YXBzKQ0KPiA+ICB7DQo+ID4gICAgICAgY29uc3QgY2hhciAqaXRlbTsNCj4gPiAgICAgICBpbnQg
aW5kZXg7DQo+ID4gDQo+ID4gICAgICAgZm9yIChpbmRleCA9IDA7IGluZGV4IDwgbjsgaW5kZXgr
Kykgew0KPiA+ICAgICAgICAgICAgICAgaXRlbSA9IGFycmF5W2luZGV4XTsNCj4gPiAtICAgICAg
ICAgICAgIGlmICghaXRlbSkNCj4gPiArICAgICAgICAgICAgIGlmICghaXRlbSkgew0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICBpZiAoZ2FwcykNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBjb250aW51ZTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4g
KyAgICAgICAgICAgICB9DQo+ID4gICAgICAgICAgICAgICBpZiAoc3lzZnNfc3RyZXEoaXRlbSwg
c3RyKSkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGluZGV4Ow0KPiA+ICAgICAg
IH0NCj4gPiANCj4gPiAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiAgfQ0KPiA+IC1FWFBPUlRf
U1lNQk9MKF9fc3lzZnNfbWF0Y2hfc3RyaW5nKTsNCj4gPiArRVhQT1JUX1NZTUJPTChfX3N5c2Zz
X21hdGNoX3N0cmluZ193aXRoX2dhcHMpOw0KPiA+IA0KPiA+ICAjaWZuZGVmIF9fSEFWRV9BUkNI
X01FTVNFVA0KPiA+ICAvKioNCj4gDQo+IA0K
