Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A03C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC8F21670
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CZltAcKa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="s6vuf5ds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfGEQD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:03:59 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:48148 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725884AbfGEQD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:03:59 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EB7AEC1226;
        Fri,  5 Jul 2019 16:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1562342639; bh=2Fvf8cBAp60F0f5iVvH18pN0k76ZfD6wNx0DKswToEc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=CZltAcKaYA6IqDQiezkTEUGvUj5HGqoBsyaQJZZ5AdPbLzQGv7lNiFYk7bBnjn7Dd
         l6AYQS0tXNJxZRayzvN+KXOMalOSD98qHee00pfc+yCiwD1tZ4sbeE8hH/QDEvuW9F
         p/2zD8qo7qkbao+qclgphXuDa7XIuxQdKLHRkq475HRza1EX1O9XiOTAzzUU76PSkz
         IC+6ZGgrc27+w3WV15UQAsGaIdidE4QFyn3rWo09T8vNeCsxOxuBrmu9sS1HMEhAJk
         LXKOtRfUO0Lw8O3D0FI2I6TBQbL1hL9jjrSVcqyR7Vb0QJLXJ/jX4F4tcs2BusX2gM
         Dbj4cc4/IvA8g==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7C9C6A023B;
        Fri,  5 Jul 2019 16:03:53 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 5 Jul 2019 09:03:53 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 5 Jul 2019 09:03:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Fvf8cBAp60F0f5iVvH18pN0k76ZfD6wNx0DKswToEc=;
 b=s6vuf5dsTiYOlclrIY0tBM4/1fZGbGjIK42SA9vCR74mwXL6rBM7vs9EtCwhNcw/jBDAJFBvlBhuPOQo6h0mIJf/sII/q8V/wdyExrBTK09p30+T/b+1cygwhMFwilPBajAxAb7LakH5T122zAV3Blc2+FmZD90V7pbDy/2pzRg=
Received: from SN6PR12MB2670.namprd12.prod.outlook.com (52.135.103.23) by
 SN6PR12MB2829.namprd12.prod.outlook.com (20.177.250.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Fri, 5 Jul 2019 16:03:52 +0000
Received: from SN6PR12MB2670.namprd12.prod.outlook.com
 ([fe80::ecdd:a159:c3f7:67a]) by SN6PR12MB2670.namprd12.prod.outlook.com
 ([fe80::ecdd:a159:c3f7:67a%6]) with mapi id 15.20.2032.022; Fri, 5 Jul 2019
 16:03:52 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "Vineet Gupta" <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARC: [plat-hsdk]: enable DW SPI controller
Thread-Topic: [PATCH] ARC: [plat-hsdk]: enable DW SPI controller
Thread-Index: AQHVHUAiWFZlgltnUkiza42/ua9nLqaQUSqAgCwKzoA=
Date:   Fri, 5 Jul 2019 16:03:51 +0000
Message-ID: <8e8d7e3fb497a3760bc0979457ae1bae77ecc561.camel@synopsys.com>
References: <20190607144800.19234-1-Eugeniy.Paltsev@synopsys.com>
         <CY4PR1201MB0120F4FE7C0E000AAAC5762DA1100@CY4PR1201MB0120.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR1201MB0120F4FE7C0E000AAAC5762DA1100@CY4PR1201MB0120.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [84.204.78.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30cc707a-7982-41aa-9b6d-08d701625fc0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2829;
x-ms-traffictypediagnostic: SN6PR12MB2829:
x-microsoft-antispam-prvs: <SN6PR12MB2829B8A6331CC231F8DA6D37DEF50@SN6PR12MB2829.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(136003)(39860400002)(376002)(13464003)(189003)(199004)(71190400001)(71200400001)(486006)(25786009)(4326008)(229853002)(66946007)(76116006)(64756008)(66556008)(66476007)(76176011)(186003)(73956011)(91956017)(66446008)(102836004)(53546011)(11346002)(316002)(6916009)(446003)(26005)(81166006)(2616005)(6506007)(478600001)(256004)(476003)(5660300002)(81156014)(99286004)(6246003)(2351001)(14454004)(3846002)(6116002)(53936002)(305945005)(68736007)(54906003)(118296001)(7736002)(36756003)(2501003)(8676002)(2906002)(5640700003)(8936002)(6512007)(6436002)(6486002)(66066001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR12MB2829;H:SN6PR12MB2670.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3oVOAsNiAVysc5UW9b81v4Zi7pmA+dju4cp9fekHlBjltu+ZQTs8icNbxic4odd54TiU9tLuZEi3LGGynG4zMGLry3jw/hvTnrrDYrkxvSeeWY1ndvbTuWmYfEkAnWymEw22eQ5iB+tNupKrRULWrBo0VAZbPyotEmxcogojY5CindngUxRq6ltfNk2TrJ1niyzsT9mri+F7tyCQKXpSr3rHYoMudAmQAQbAkaF5h3vTXcM0p8AC/0+WMbaaqQDpYR+l/+P+59JE5hprX40KQW+j3J6+/GOef/0ABtrRlh5kN34ZJ1wyppfQamrGGI1EToRvN6hIwF5CkPuKSb9hmRR2uc8JQZKvQlM/5K1taCE7BBCLBsKjT3P1nKPCIxstfKTsCOkcUMdlipTtSStkaL0ua/5qp/SqHL3xGrAOWzY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B42A07E3A101B40B708DC98221ABE7D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 30cc707a-7982-41aa-9b6d-08d701625fc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 16:03:51.9796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: paltsev@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2829
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmluZWV0LA0KDQpJIGd1ZXNzIHlvdSdsbCBhZGQgdGhpcyB0byA1LjMsIHJpZ2h0Pw0KDQpP
biBGcmksIDIwMTktMDYtMDcgYXQgMTU6MjkgKzAwMDAsIEFsZXhleSBCcm9ka2luIHdyb3RlOg0K
PiBIaSBFdWdlbml5LA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZy
b206IEV1Z2VuaXkgUGFsdHNldiA8RXVnZW5peS5QYWx0c2V2QHN5bm9wc3lzLmNvbT4NCj4gPiBT
ZW50OiBGcmlkYXksIEp1bmUgNywgMjAxOSA1OjQ4IFBNDQo+ID4gVG86IGxpbnV4LXNucHMtYXJj
QGxpc3RzLmluZnJhZGVhZC5vcmc7IFZpbmVldCBHdXB0YSA8dmd1cHRhQHN5bm9wc3lzLmNvbT4N
Cj4gPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQWxleGV5IEJyb2RraW4gPGFi
cm9ka2luQHN5bm9wc3lzLmNvbT47IEV1Z2VuaXkgUGFsdHNldg0KPiA+IDxFdWdlbml5LlBhbHRz
ZXZAc3lub3BzeXMuY29tPg0KPiA+IFN1YmplY3Q6IFtQQVRDSF0gQVJDOiBbcGxhdC1oc2RrXTog
ZW5hYmxlIERXIFNQSSBjb250cm9sbGVyDQo+ID4gDQo+ID4gSFNESyBTb0MgaGFzIERXIFNQSSBj
b250cm9sbGVyLiBFbmFibGUgaXQgaW4gcHJlcGFyYXRpb24gb2YNCj4gPiBlbmFibGluZyBvbi1i
b2FyZCBTUEkgcGVyaXBoZXJhbHMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRXVnZW5peSBQ
YWx0c2V2IDxFdWdlbml5LlBhbHRzZXZAc3lub3BzeXMuY29tPg0KPiANCj4gQWRkaW5nIFJvYiBh
bmQuLi4NCj4gDQo+IEFja2VkLWJ5OiBBbGV4ZXkgQnJvZGtpbiA8YWJyb2RraW5Ac3lub3BzeXMu
Y29tPg0KPiANCj4gPiAgYXJjaC9hcmMvYm9vdC9kdHMvaHNkay5kdHMgICAgICB8IDE0ICsrKysr
KysrKysrKysrDQo+ID4gIGFyY2gvYXJjL2NvbmZpZ3MvaHNka19kZWZjb25maWcgfCAgMyArKysN
Cj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJjL2Jvb3QvZHRzL2hzZGsuZHRzIGIvYXJjaC9hcmMvYm9vdC9kdHMvaHNk
ay5kdHMNCj4gPiBpbmRleCBlNTdiMjRkZDAyZTcuLjQyZTFjOTYxYmE0OCAxMDA2NDQNCj4gPiAt
LS0gYS9hcmNoL2FyYy9ib290L2R0cy9oc2RrLmR0cw0KPiA+ICsrKyBiL2FyY2gvYXJjL2Jvb3Qv
ZHRzL2hzZGsuZHRzDQo+ID4gQEAgLTExLDYgKzExLDcgQEANCj4gPiAgICovDQo+ID4gIC9kdHMt
djEvOw0KPiA+IA0KPiA+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZ3Bpby9ncGlvLmg+DQo+ID4g
ICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9yZXNldC9zbnBzLGhzZGstcmVzZXQuaD4NCj4gPiANCj4g
PiAgLyB7DQo+ID4gQEAgLTIzMyw2ICsyMzQsMTkgQEANCj4gPiAgCQkJZG1hLWNvaGVyZW50Ow0K
PiA+ICAJCX07DQo+ID4gDQo+ID4gKwkJc3BpMDogc3BpQDIwMDAwIHsNCj4gPiArCQkJY29tcGF0
aWJsZSA9ICJzbnBzLGR3LWFwYi1zc2kiOw0KPiA+ICsJCQlyZWcgPSA8MHgyMDAwMCAweDEwMD47
DQo+ID4gKwkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsJCQkjc2l6ZS1jZWxscyA9IDww
PjsNCj4gPiArCQkJaW50ZXJydXB0cyA9IDwxNj47DQo+ID4gKwkJCW51bS1jcyA9IDwyPjsNCj4g
PiArCQkJcmVnLWlvLXdpZHRoID0gPDQ+Ow0KPiA+ICsJCQljbG9ja3MgPSA8JmlucHV0X2Nsaz47
DQo+ID4gKwkJCWNzLWdwaW9zID0gPCZjcmVnX2dwaW8gMCBHUElPX0FDVElWRV9MT1c+LA0KPiA+
ICsJCQkJICAgPCZjcmVnX2dwaW8gMSBHUElPX0FDVElWRV9MT1c+Ow0KPiA+ICsJCX07DQo+ID4g
Kw0KPiA+ICAJCWNyZWdfZ3BpbzogZ3Bpb0AxNGIwIHsNCj4gPiAgCQkJY29tcGF0aWJsZSA9ICJz
bnBzLGNyZWctZ3Bpby1oc2RrIjsNCj4gPiAgCQkJcmVnID0gPDB4MTRiMCAweDQ+Ow0KPiA+IGRp
ZmYgLS1naXQgYS9hcmNoL2FyYy9jb25maWdzL2hzZGtfZGVmY29uZmlnIGIvYXJjaC9hcmMvY29u
Zmlncy9oc2RrX2RlZmNvbmZpZw0KPiA+IGluZGV4IDBjNDQxMWY1MDk0OC4uY2NmYTc0NGZlNzU1
IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJjL2NvbmZpZ3MvaHNka19kZWZjb25maWcNCj4gPiAr
KysgYi9hcmNoL2FyYy9jb25maWdzL2hzZGtfZGVmY29uZmlnDQo+ID4gQEAgLTQ2LDYgKzQ2LDkg
QEAgQ09ORklHX1NFUklBTF84MjUwX0NPTlNPTEU9eQ0KPiA+ICBDT05GSUdfU0VSSUFMXzgyNTBf
RFc9eQ0KPiA+ICBDT05GSUdfU0VSSUFMX09GX1BMQVRGT1JNPXkNCj4gPiAgIyBDT05GSUdfSFdf
UkFORE9NIGlzIG5vdCBzZXQNCj4gPiArQ09ORklHX1NQST15DQo+ID4gK0NPTkZJR19TUElfREVT
SUdOV0FSRT15DQo+ID4gK0NPTkZJR19TUElfRFdfTU1JTz15DQo+ID4gIENPTkZJR19HUElPTElC
PXkNCj4gPiAgQ09ORklHX0dQSU9fU1lTRlM9eQ0KPiA+ICBDT05GSUdfR1BJT19EV0FQQj15DQo+
ID4gLS0NCj4gPiAyLjIxLjANCi0tIA0KIEV1Z2VuaXkgUGFsdHNldg0K
