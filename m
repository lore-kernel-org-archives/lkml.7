Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49DFC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7A92173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="Ob9n9hNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfEIIxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 04:53:00 -0400
Received: from mail-eopbgr760072.outbound.protection.outlook.com ([40.107.76.72]:15874
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbfEIIw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 04:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvzbL8Ycy+8JsT2LEG7exf3YMzxxy/e1w/6ZkAj/vs0=;
 b=Ob9n9hNc/uA2LXfsrxC1M7MjT+xXz5xl4DGQ9OWQVd9aSaja0twX/T/tpY8YLGssRtjZ59egIZKxZPqQqky84QgnGupbaaLuGW4YwAunzf+RZ0cf+R6bz3z4EeB2iB9kisqkEwE8SW9RYxfgeFhGRJEEVMIwnS2fFq4s2cPFgeA=
Received: from BN3PR03CA0084.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::44) by SN2PR03MB2272.namprd03.prod.outlook.com
 (2603:10b6:804:d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1878.21; Thu, 9 May
 2019 08:52:55 +0000
Received: from SN1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by BN3PR03CA0084.outlook.office365.com
 (2a01:111:e400:7a4d::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1878.22 via Frontend
 Transport; Thu, 9 May 2019 08:52:55 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT040.mail.protection.outlook.com (10.152.72.195) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Thu, 9 May 2019 08:52:55 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x498qs4X014371
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 9 May 2019 01:52:54 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Thu, 9 May 2019 04:52:54 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "heiko@sntech.de" <heiko@sntech.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 02/16] treewide: rename match_string() ->
 __match_string()
Thread-Topic: [PATCH 02/16] treewide: rename match_string() ->
 __match_string()
Thread-Index: AQHVBZFNi8JDVYCrKU61ekRKdrjlIKZhtuQAgAEKMAA=
Date:   Thu, 9 May 2019 08:52:53 +0000
Message-ID: <857bce4e87bc473e533c53abc0b612ee918f2474.camel@analog.com>
References: <20190508112842.11654-1-alexandru.ardelean@analog.com>
         <20190508112842.11654-4-alexandru.ardelean@analog.com>
         <155733480678.14659.15999974975874060801@swboyd.mtv.corp.google.com>
In-Reply-To: <155733480678.14659.15999974975874060801@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F83AC590E2754C4D8DD9C7D6E5C56412@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(199004)(189003)(186003)(36756003)(2201001)(2906002)(478600001)(14444005)(3846002)(5660300002)(6116002)(26005)(2616005)(476003)(486006)(426003)(436003)(126002)(14454004)(305945005)(70586007)(446003)(6246003)(86362001)(336012)(4326008)(11346002)(70206006)(47776003)(118296001)(229853002)(356004)(106002)(8676002)(8936002)(7636002)(7696005)(2486003)(7736002)(23676004)(110136005)(246002)(54906003)(316002)(102836004)(2501003)(76176011)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2272;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 179b32cf-a800-48bc-cd78-08d6d45bba88
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:SN2PR03MB2272;
X-MS-TrafficTypeDiagnostic: SN2PR03MB2272:
X-Microsoft-Antispam-PRVS: <SN2PR03MB2272C71F4F3AC364C2C90022F9330@SN2PR03MB2272.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 003245E729
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 10yUH4ZljJuqFGPWwyBOYhFPNs3N9GiEnexfohM8SVV90+rF1zo7akr9g6XIPF1Y1HvMNr08Y0U5GvKROEVAA/flAcs/2fOWyMNql6TH4gEzumMsP1/GE6q2scdFmwnOR5tkB2f7VJm/ldT8kVQJ9PjyQ/nncyDgQspvgN9/EABITf4oOBJVOqAw68HrExeKzewFu6xgmyb2IJRfsoISRMu0SEH9SzjQi4pFNLBCyKmPmVbLtNGV9l/TXaUIE7RJSfkptVfHsj+vV+sG1cWrZq4wRypFdkBR6bih437b/oQsjoyLomvLJi6XlvS8vFuQ4wDMk8U43nf2/AVNWAQNjTcACm2zUKalSA4tfa47HDJo3oOZZs4OZA2ZhjlRYGSlpXaY5jQ9LLyR1d9c3RoCVu7V9z9OdNOJoOcNs+1+vT8=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2019 08:52:55.2851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 179b32cf-a800-48bc-cd78-08d6d45bba88
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2272
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA1LTA4IGF0IDEwOjAwIC0wNzAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IA0KPiAoVHJpbW1pbmcgdGhlIGxpc3RzIGJ1dCBrZWVwaW5nIGxr
bWwpDQo+IA0KPiBRdW90aW5nIEFsZXhhbmRydSBBcmRlbGVhbiAoMjAxOS0wNS0wOCAwNDoyODoy
OCkNCj4gPiBUaGlzIGNoYW5nZSBkb2VzIGEgcmVuYW1lIG9mIG1hdGNoX3N0cmluZygpIC0+IF9f
bWF0Y2hfc3RyaW5nKCkuDQo+ID4gDQo+ID4gVGhlcmUgYXJlIGEgZmV3IHBhcnRzIHRvIHRoZSBp
bnRlbnRpb24gaGVyZSAod2l0aCB0aGlzIGNoYW5nZSk6DQo+ID4gMS4gQWxpZ24gd2l0aCBzeXNm
c19tYXRjaF9zdHJpbmcoKS9fX3N5c2ZzX21hdGNoX3N0cmluZygpDQo+ID4gMi4gVGhpcyBoZWxw
cyB0byBncm91cCB1c2VycyBvZiBgbWF0Y2hfc3RyaW5nKClgIGludG8gc2ltcGxlIHVzZXJzOg0K
PiA+ICAgIGEuIHRob3NlIHRoYXQgdXNlIEFSUkFZX1NJWkUoX2EpIHRvIHNwZWNpZnkgdGhlIG51
bWJlciBvZiBlbGVtZW50cw0KPiA+ICAgIGIuIHRob3NlIHRoYXQgdXNlIC0xIHRvIHBhc3MgYSBO
VUxMIHRlcm1pbmF0ZWQgYXJyYXkgb2Ygc3RyaW5ncw0KPiA+ICAgIGMuIHNwZWNpYWwgdXNlcnMs
IHdoaWNoIChhZnRlciBlbGltaW5hdGluZyAxICYgMikgYXJlIG5vdCB0aGF0IG1hbnkNCj4gPiAz
LiBUaGUgZmluYWwgaW50ZW50IGlzIHRvIGZpeCBtYXRjaF9zdHJpbmcoKS9fX21hdGNoX3N0cmlu
ZygpIHdoaWNoIGlzDQo+ID4gICAgc2xpZ2h0bHkgYnJva2VuLCBpbiB0aGUgc2Vuc2UgdGhhdCBw
YXNzaW5nIC0xIG9yIGEgcG9zaXRpdmUgdmFsdWUNCj4gPiBkb2VzDQo+ID4gICAgbm90IG1ha2Ug
YW55IGRpZmZlcmVuY2U6IHRoZSBpdGVyYXRpb24gd2lsbCBzdG9wIGF0IHRoZSBmaXJzdCBOVUxM
DQo+ID4gICAgZWxlbWVudC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgQXJk
ZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiA+IC0tLQ0KPiANCj4gWy4u
Ll0NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvY2xrLmMgYi9kcml2ZXJzL2Nsay9jbGsu
Yw0KPiA+IGluZGV4IDk2MDUzYTk2ZmUyZi4uMGI2YzNkMzAwNDExIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvY2xrL2Nsay5jDQo+ID4gKysrIGIvZHJpdmVycy9jbGsvY2xrLmMNCj4gPiBAQCAt
MjMwNSw4ICsyMzA1LDggQEAgYm9vbCBjbGtfaGFzX3BhcmVudChzdHJ1Y3QgY2xrICpjbGssIHN0
cnVjdCBjbGsNCj4gPiAqcGFyZW50KQ0KPiA+ICAgICAgICAgaWYgKGNvcmUtPnBhcmVudCA9PSBw
YXJlbnRfY29yZSkNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+ID4gDQo+ID4g
LSAgICAgICByZXR1cm4gbWF0Y2hfc3RyaW5nKGNvcmUtPnBhcmVudF9uYW1lcywgY29yZS0+bnVt
X3BhcmVudHMsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhcmVudF9jb3JlLT5u
YW1lKSA+PSAwOw0KPiA+ICsgICAgICAgcmV0dXJuIF9fbWF0Y2hfc3RyaW5nKGNvcmUtPnBhcmVu
dF9uYW1lcywgY29yZS0+bnVtX3BhcmVudHMsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcGFyZW50X2NvcmUtPm5hbWUpID49IDA7DQo+IA0KPiBUaGlzIGlzIGVzc2VudGlhbGx5
IEFSUkFZX1NJWkUoY29yZS0+cGFyZW50X25hbWVzKSBzbyBpdCBzaG91bGQgYmUgZmluZQ0KPiB0
byBwdXQgdGhpcyBiYWNrIHRvIG1hdGNoX3N0cmluZygpIGxhdGVyIGluIHRoZSBzZXJpZXMuDQoN
CkkgZG9uJ3QgdGhpbmsgc28uDQpjb3JlLT5wYXJlbnRzICYgY29yZS0+cGFyZW50X25hbWVzIHNl
ZW0gdG8gYmUgZHluYW1pY2FsbHkgYWxsb2NhdGVkIGFycmF5Lg0KQVJSQVlfU0laRSgpIGlzIGEg
bWFjcm8gdGhhdCBleHBhbmRzIGF0IHByZS1jb21waWxlIHRpbWUgYW5kIGV2YWx1YXRlcw0KY29y
cmVjdGx5IGF0IGNvbXBpbGUgdGltZSBvbmx5IGZvciBzdGF0aWMgYXJyYXlzLg0KDQoNCj4gPiAg
fQ0KPiA+ICBFWFBPUlRfU1lNQk9MX0dQTChjbGtfaGFzX3BhcmVudCk7DQo+ID4gDQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvY2xrL3JvY2tjaGlwL2Nsay5jIGIvZHJpdmVycy9jbGsvcm9ja2No
aXAvY2xrLmMNCj4gPiBpbmRleCBjM2FkOTI5NjU4MjMuLjM3M2YxM2U5Y2Q4MyAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2Nsay9yb2NrY2hpcC9jbGsuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY2xr
L3JvY2tjaGlwL2Nsay5jDQo+ID4gQEAgLTI3Niw4ICsyNzYsOCBAQCBzdGF0aWMgc3RydWN0IGNs
aw0KPiA+ICpyb2NrY2hpcF9jbGtfcmVnaXN0ZXJfZnJhY19icmFuY2goDQo+ID4gICAgICAgICAg
ICAgICAgIHN0cnVjdCBjbGsgKm11eF9jbGs7DQo+ID4gICAgICAgICAgICAgICAgIGludCByZXQ7
DQo+ID4gDQo+ID4gLSAgICAgICAgICAgICAgIGZyYWMtPm11eF9mcmFjX2lkeCA9IG1hdGNoX3N0
cmluZyhjaGlsZC0+cGFyZW50X25hbWVzLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgY2hpbGQtPm51bV9wYXJlbnRzLA0KPiA+IG5hbWUpOw0K
PiA+ICsgICAgICAgICAgICAgICBmcmFjLT5tdXhfZnJhY19pZHggPSBfX21hdGNoX3N0cmluZyhj
aGlsZC0NCj4gPiA+cGFyZW50X25hbWVzLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjaGlsZC0+bnVtX3BhcmVudHMsIA0KPiA+IG5hbWUp
Ow0KPiANCj4gSSBzdXNwZWN0IHRoaXMgaXMgdGhlIHNhbWUgYXMgYWJvdmUsIGJ1dCBIZWlrbyBj
YW4gYWNrL2NvbmZpcm0uDQo+IA0KPiA+ICAgICAgICAgICAgICAgICBmcmFjLT5tdXhfb3BzID0g
JmNsa19tdXhfb3BzOw0KPiA+ICAgICAgICAgICAgICAgICBmcmFjLT5jbGtfbmIubm90aWZpZXJf
Y2FsbCA9DQo+ID4gcm9ja2NoaXBfY2xrX2ZyYWNfbm90aWZpZXJfY2I7DQo+ID4gDQo=
