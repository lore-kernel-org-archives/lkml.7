Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E227DC10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D4420863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="D1cD40Qb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfCDHUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 02:20:31 -0500
Received: from mail-eopbgr800040.outbound.protection.outlook.com ([40.107.80.40]:57634
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbfCDHUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 02:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVZ3LkI7zftvFL+xzyd1N9vu7K2vcccmTxijuQSZKW8=;
 b=D1cD40QbDyQD6ILmh+PCX1lzgD9fHcI5G8kEjquKXAJyQtMGaM9naKpVDoS3jJg2Q/G8PeGEARoJWDOKANyiDQdpBLVICASfizBBCSZagFjwzqhlNXIiHAW7QCaKVeRd3SgriHUrNuqMliH2/DTVVXNyG7BQ9EquDQhWPfpHyyo=
Received: from BN6PR03CA0053.namprd03.prod.outlook.com (2603:10b6:404:4c::15)
 by MWHPR03MB3071.namprd03.prod.outlook.com (2603:10b6:301:3c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1665.19; Mon, 4 Mar
 2019 07:20:25 +0000
Received: from SN1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by BN6PR03CA0053.outlook.office365.com
 (2603:10b6:404:4c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.16 via Frontend
 Transport; Mon, 4 Mar 2019 07:20:24 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT018.mail.protection.outlook.com (10.152.72.122) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Mon, 4 Mar 2019 07:20:23 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x247KMiK007303
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 3 Mar 2019 23:20:22 -0800
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Mon, 4 Mar 2019 02:20:22 -0500
From:   "Ardelean, Alexandru" <Alex.Ardelean@analog.com>
To:     "Ardelean, Alexandru" <Alex.Ardelean@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
Subject: Re: [PATCH v4 5/9] staging: iio: ad7780: move regulator to after
 GPIO init
Thread-Topic: [PATCH v4 5/9] staging: iio: ad7780: move regulator to after
 GPIO init
Thread-Index: AQHUz3FvfboR2oAIAEa+TaF0Vv+tjqX2uIaAgAJT/4CAAl3cAA==
Date:   Mon, 4 Mar 2019 07:20:21 +0000
Message-ID: <693a710f3fb4a209bc701e7cd796b0de13d2d5a5.camel@analog.com>
References: <cover.1551358569.git.renatogeh@gmail.com>
         <93cabb081605ac356f2f0d9a9a41d5bc5e63820d.1551358569.git.renatogeh@gmail.com>
         <28d78cfc00bc5414c7539879df46200d61e52ee1.camel@analog.com>
         <20190302191153.5d57a86b@archlinux>
In-Reply-To: <20190302191153.5d57a86b@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE9A9CF7DFD3204CB0806BC957C394B6@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(376002)(2980300002)(199004)(189003)(54906003)(110136005)(8936002)(2486003)(106466001)(23676004)(72206003)(14444005)(486006)(6246003)(478600001)(36756003)(126002)(107886003)(7696005)(336012)(47776003)(316002)(86362001)(4326008)(305945005)(106002)(7736002)(26005)(50466002)(2906002)(356004)(8676002)(93886005)(7636002)(3846002)(6116002)(246002)(229853002)(426003)(436003)(2616005)(446003)(11346002)(14454004)(76176011)(118296001)(186003)(102836004)(5660300002)(2501003)(7416002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3071;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b926f9a2-f7fa-46fa-808b-08d6a071de5f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060)(7193020);SRVR:MWHPR03MB3071;
X-MS-TrafficTypeDiagnostic: MWHPR03MB3071:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3071;20:L09RNLT3BARuR8Nca6tTY/i6pUFNIGWJN1Ji9HE3m0MEA2VVTguMDP9fNigTizRiaoaA6DfhvJSanApqIYnuBO6tlqUqVd0f9tQB7sSI4Qr30RbXGYvp3EIhv5TlwdHhlAoX6B6TzzF8NwKdha5vwmpajZz39euT78WWjbQqyiqqkIT9aJ7bh4bhiIH7orzzyAT9JaQKg4wiyktl7LvqoAMe5Oryjg5RIPi6UKLtzqV7SB+uC5KzC+77dY30WxdlQR4StAKQEG13H2DE7nujPOXuBzX0RqDvHZqEiguy9cr9WdJIRc5LxlcZPcuC257iBnhFumfsse8J7JZB4Fc0pD+yfJp7ez/9GcwMRbA4M+6Y94gM2wN0igtbVb9jA6lJYdEoUZCPXNwLDwR9Dx31o6NTbq840pPVBtXUykOvlXJ8acSbRQOyTXNCm6tMMf2/mzM24vDTH+2qxNZS44z31ij3blADuuBSGGZW+mV7Bd4wyR8Uuhz0bcoRmxzQCMm2
X-Microsoft-Antispam-PRVS: <MWHPR03MB3071AF19F32AD51897E8038795710@MWHPR03MB3071.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09669DB681
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjAzTUIzMDcxOzIzOmNRU3d2OHhIZUVkVGR2dWNBdGVUV3F4SDNJ?=
 =?utf-8?B?dW1na0pSOFNMRmUrazNUbTF2Slo2di9PZ2Q2MlY3c05sRm9hbEkrdC94bUx2?=
 =?utf-8?B?WWNsWldBQXhTYWtJWVlzRXI2V1dJdGE5U1BFR1RkeHlaUTBrcXlSbGNuY3Mv?=
 =?utf-8?B?T2hUN2c0alBHelBTVnJDakgzbkQ1VXZjbzlJUHVvZ0JHNzgyL1NHSUd3UzBz?=
 =?utf-8?B?RW51OG1DbVZPdzllZU1jMVJjaWZQaGMvZEFNNDM2Sk9FWjlFTEwvMVc4aEFR?=
 =?utf-8?B?Y3N5ZXRhMmh5MmFFbXJIQTBXaitsRlNuSWpZcktZc0ZlZW5uN1c4Y0s5WjJJ?=
 =?utf-8?B?QXdvbkhjZzVBR3hZaUNHc3JaL1F4MEk3ck5HQjJjWHBaZEpkZkdWVVBZNEVv?=
 =?utf-8?B?akxVaGlvS20zcnVBZ3A2bTlMbUp6eEpMZ21VVHlkOUMrUmphbGU2ZWtwZ0xk?=
 =?utf-8?B?QVMwa0N3S1VQdjErT01vQS9KNHlUbEpYNU9hd1gvbFFzY3h2NWdMMDV0SGY0?=
 =?utf-8?B?SWd2aHZ5SnROekR4ZGdWS3pSYmovK3dnd05sQmI3aUZOakFLeUFwL2pSSFAx?=
 =?utf-8?B?Z2FOVEFud3AyQ3FGZDNhMVZoZEppdHlRU1oxa1BoSDNoM2psT2pzTUY1WGY3?=
 =?utf-8?B?UzN2eVRKaVVBS0IzMTFTTmlyWHNhWHpQM3ZhNW5wMis5NHducUplaW5QSnN3?=
 =?utf-8?B?Mm9BRmNKQXArUnU2TWJoSGJSbFl3STQyVGJwa21FZXdpaVlYNTdDeThNa3Zt?=
 =?utf-8?B?bDluTkg5ZmZJUklsVGdUNGRGTEw5OFA3d1lLdDFoTEhwUnhSOEVvblpoZC9t?=
 =?utf-8?B?RFg3NzVYRTRpNEZPK05YN29rMjA0NEVKRjhVZmNjMzlkWXJnTGJWSnBkZGRa?=
 =?utf-8?B?OXFTby93anV2UnRWcVlCK1dGdmg4MzF2aUxsK1R5Vyt4bW85ZWhqNVpQcHNq?=
 =?utf-8?B?STc2ZDJNOXZ3WkJ5Z3FodEFrcmlRUFcwL0Nvajk4eHFYWTMxYXJvOGk1aWxs?=
 =?utf-8?B?bUN0KzF0TjVDSXlJbXZUOFY3MXNBT3J0RXVwZ3g3S1pBRUdxdGF2VjZGNUZC?=
 =?utf-8?B?dzdXVG05VXNSNnlsVVRBa0lLcWVpNmZrWEVhYW5nVEVERFVsT2pydER4T0oy?=
 =?utf-8?B?cE9Pbzd1cS9Zd2JsNFowNklkM0hKVEVWUmxEaTcveXZXQUlreVNpWUxIVkM3?=
 =?utf-8?B?VFp1NVBYY1VEbG5sRS84ZE56Q3VBS1JNNjNmVmxyaUxPY1N3QjFiUjNZUWRr?=
 =?utf-8?B?cEFGWk5BNDF2WHo1VkVWL1lvYmVXRW1adWFlRkxqNXlDSjE4OTdXTEVnMThL?=
 =?utf-8?B?Mk5KK3NOY0Q0ZFBTSEdubmxMYndpd3cyeTdYVVhkMWV4YjV6L2owZytYcGpj?=
 =?utf-8?B?SXBwQ2JERTBKcXI2SXVZU0U5azlIdi9kZFJtSTFzSVRGK2ZzWC9zS3JBdGtu?=
 =?utf-8?B?Vk5pTG9vMmNZejRNYktVU0ZTaG15QjhDK3YzOFJQWkJBRGFLY05sL0N2OUtQ?=
 =?utf-8?B?c2tIV2Q3aC9GdnhxM1J3YnYyYi90TVBIM1FLVnFzeVlEWFR3djhiRS9FcXBp?=
 =?utf-8?B?U2RFZTZVRDFWSzF3UVdBcDBSOTluVjV1c2VIMjBNanczZUVoN0JzMzlkNytS?=
 =?utf-8?Q?UgT3iP3PsQ/0bqx+nsqI?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Z4JK6ruSpgipVO6Q6oqPFUFfy3cxl1lOtFvtURVZ99Ig+oW7vLqm87Ay97KwoBlPutWu6FAERc1oVjLIY5MoW6QQIWOzPP8jYkwpB1iEhyy/SR4YWjhDIZENjM9F6HJsh7GcU3oS9MnWr5kNF5IO5Aixdo+Lpp5wEjUqfjsK/0x+LoXlPZge20j4gjHRc3SaGdrY3u92w2GVgkNvJXZOJ81sJuOV4mLLiJRG7z9v/SWYQ97Gqc9H1BFk1/goHcHc7EnbZANZ9LONmi0m61zneNjt7g980nydNrhO408OnXzmeTIIIhJ9fjCRdEiCisXtgXKD1GgWhJWK+Nn/v0AuEClpQas2ETqsdgmu2+BNt42dA/kJlKnP2ZwZS2Bv8ubmTwP/mPUU3VSvYSFxG8+Bw046bDTAhXKVBjzhNEnHcoo=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2019 07:20:23.5548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b926f9a2-f7fa-46fa-808b-08d6a071de5f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDE5LTAzLTAyIGF0IDE5OjExICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiANCj4gT24gRnJpLCAxIE1hciAyMDE5IDA3OjM4OjQ1ICsw
MDAwDQo+ICJBcmRlbGVhbiwgQWxleGFuZHJ1IiA8QWxleC5BcmRlbGVhbkBhbmFsb2cuY29tPiB3
cm90ZToNCj4gDQo+ID4gT24gVGh1LCAyMDE5LTAyLTI4IGF0IDExOjI1IC0wMzAwLCBSZW5hdG8g
THVpIEdlaCB3cm90ZToNCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBUbyBtYWludGFpbiBjb25zaXN0
ZW5jeSBiZXR3ZWVuIGFkNzc4MF9wcm9iZSBhbmQgYWQ3NzgwX3JlbW92ZQ0KPiA+ID4gb3JkZXJz
LA0KPiA+ID4gcmVndWxhdG9yIGluaXRpYWxpemF0aW9uIGhhcyBiZWVuIG1vdmVkIHRvIGFmdGVy
IEdQSU8NCj4gPiA+IGluaXRpYWxpemF0aW9ucy4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1i
eTogUmVuYXRvIEx1aSBHZWggPHJlbmF0b2dlaEBnbWFpbC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+
ICBkcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYyB8IDI2ICsrKysrKysrKysrKystLS0t
LS0tLS0tLS0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEzIGRl
bGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2lp
by9hZGMvYWQ3NzgwLmMNCj4gPiA+IGIvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMN
Cj4gPiA+IGluZGV4IGFkNzYxN2EzYTE0MS4uMTJhZWYwZjEwMWJjIDEwMDY0NA0KPiA+ID4gLS0t
IGEvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMv
c3RhZ2luZy9paW8vYWRjL2FkNzc4MC5jDQo+ID4gPiBAQCAtMjU1LDE2ICsyNTUsNiBAQCBzdGF0
aWMgaW50IGFkNzc4MF9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiA+ID4gDQo+ID4g
PiAgICAgICAgIGFkX3NkX2luaXQoJnN0LT5zZCwgaW5kaW9fZGV2LCBzcGksDQo+ID4gPiAmYWQ3
NzgwX3NpZ21hX2RlbHRhX2luZm8pOw0KPiA+ID4gDQo+ID4gPiAtICAgICAgIHN0LT5yZWcgPSBk
ZXZtX3JlZ3VsYXRvcl9nZXQoJnNwaS0+ZGV2LCAiYXZkZCIpOw0KPiA+ID4gLSAgICAgICBpZiAo
SVNfRVJSKHN0LT5yZWcpKQ0KPiA+ID4gLSAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKHN0
LT5yZWcpOw0KPiA+ID4gLQ0KPiA+ID4gLSAgICAgICByZXQgPSByZWd1bGF0b3JfZW5hYmxlKHN0
LT5yZWcpOw0KPiA+ID4gLSAgICAgICBpZiAocmV0KSB7DQo+ID4gPiAtICAgICAgICAgICAgICAg
ZGV2X2Vycigmc3BpLT5kZXYsICJGYWlsZWQgdG8gZW5hYmxlIHNwZWNpZmllZCBBVmRkDQo+ID4g
PiBzdXBwbHlcbiIpOw0KPiA+ID4gLSAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gPiAt
ICAgICAgIH0NCj4gPiA+IC0NCj4gPiA+ICAgICAgICAgc3QtPmNoaXBfaW5mbyA9DQo+ID4gPiAg
ICAgICAgICAgICAgICAgJmFkNzc4MF9jaGlwX2luZm9fdGJsW3NwaV9nZXRfZGV2aWNlX2lkKHNw
aSktDQo+ID4gPiA+IGRyaXZlcl9kYXRhXTsNCj4gPiA+IA0KPiA+ID4gQEAgLTI4NCw3ICsyNzQs
NyBAQCBzdGF0aWMgaW50IGFkNzc4MF9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiA+
ID4gICAgICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIoc3QtPnBvd2VyZG93bl9ncGlvKTsNCj4g
PiA+ICAgICAgICAgICAgICAgICBkZXZfZXJyKCZzcGktPmRldiwgIkZhaWxlZCB0byByZXF1ZXN0
IHBvd2VyZG93biBHUElPOg0KPiA+ID4gJWRcbiIsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICByZXQpOw0KPiA+ID4gLSAgICAgICAgICAgICAgIGdvdG8gZXJyb3JfZGlzYWJsZV9yZWc7
DQo+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiA+ICAgICAgICAgfQ0KPiA+
ID4gDQo+ID4gPiAgICAgICAgIGlmIChzdC0+Y2hpcF9pbmZvLT5pc19hZDc3OHgpIHsNCj4gPiA+
IEBAIC0yOTUsNyArMjg1LDcgQEAgc3RhdGljIGludCBhZDc3ODBfcHJvYmUoc3RydWN0IHNwaV9k
ZXZpY2UgKnNwaSkNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIo
c3QtPmdhaW5fZ3Bpbyk7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKCZz
cGktPmRldiwgIkZhaWxlZCB0byByZXF1ZXN0IGdhaW4NCj4gPiA+IEdQSU86DQo+ID4gPiAlZFxu
IiwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0KTsNCj4gPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyb3JfZGlzYWJsZV9yZWc7DQo+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ID4gICAgICAgICAgICAgICAgIH0N
Cj4gPiA+IA0KPiA+ID4gICAgICAgICAgICAgICAgIHN0LT5maWx0ZXJfZ3BpbyA9IGRldm1fZ3Bp
b2RfZ2V0X29wdGlvbmFsKCZzcGktPmRldiwNCj4gPiA+IEBAIC0zMDYsMTAgKzI5NiwyMCBAQCBz
dGF0aWMgaW50IGFkNzc4MF9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgZGV2X2Vycigmc3BpLT5kZXYsDQo+ID4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICJGYWlsZWQgdG8gcmVxdWVzdCBmaWx0ZXIgR1BJTzoNCj4g
PiA+ICVkXG4iLA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXQpOw0K
PiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJvcl9kaXNhYmxlX3JlZzsNCj4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gPiAgICAgICAgICAg
ICAgICAgfQ0KPiA+ID4gICAgICAgICB9DQo+ID4gPiANCj4gPiA+ICsgICAgICAgc3QtPnJlZyA9
IGRldm1fcmVndWxhdG9yX2dldCgmc3BpLT5kZXYsICJhdmRkIik7DQo+ID4gPiArICAgICAgIGlm
IChJU19FUlIoc3QtPnJlZykpDQo+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIo
c3QtPnJlZyk7DQo+ID4gPiArDQo+ID4gPiArICAgICAgIHJldCA9IHJlZ3VsYXRvcl9lbmFibGUo
c3QtPnJlZyk7DQo+ID4gPiArICAgICAgIGlmIChyZXQpIHsNCj4gPiA+ICsgICAgICAgICAgICAg
ICBkZXZfZXJyKCZzcGktPmRldiwgIkZhaWxlZCB0byBlbmFibGUgc3BlY2lmaWVkIEFWZGQNCj4g
PiA+IHN1cHBseVxuIik7DQo+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiA+
ICsgICAgICAgfQ0KPiA+ID4gKw0KPiA+IA0KPiA+IEknbSBwcm9iYWJseSBtaXNzaW5nIHNvbWV0
aGluZywgYnV0IG90aGVyIHRoYW4gdGhlIGZhY3QgdGhhdCB0aGlzIG1vdmVzDQo+ID4gdGhlDQo+
ID4gcmVndWxhdG9yIGluaXQgYWZ0ZXIgdGhlIEdQSU9zIGluaXQsIGl0IGRvZXNuJ3QgY2hhbmdl
IG11Y2guDQo+ID4gVGhlIG9yZGVyIG9mIHRoZSBwcm9iZSAmIHJlbW92ZSBpcyBtb3JlLW9yLWxl
c3MgdGhlIHNhbWUuDQo+ID4gVGhlIEdQSU9zIHdpbGwgYmUgZnJlZSdkIHZpYSBkZXZtXyBBUEkv
c3R1ZmYuDQo+IA0KPiBUaGlzIGlzIGFub3RoZXIgb25lIGZyb20gbWUuICBJJ20gYSBmYW5hdGlj
IGF0IHRpbWVzIHdoZW4gaXQgY29tZXMNCj4gdG8gcHJvYmUgYW5kIHJlbW92ZSBvcmRlcnMgYmVp
bmcgcHJlY2lzZSByZXZlcnNlcy4gIEl0IGp1c3QgbWFrZXMNCj4gcmV2aWV3IGVhc2llci4gIE5p
Y2UgdG8gbm90IGFjdHVhbGx5IGhhdmUgdG8gdGhpbmsuDQo+IA0KPiBTbyBJIGFncmVlIHRoZXJl
IGlzIG5vICdhY3R1YWwnIGVmZmVjdCBidXQgaXQgaXMgaW4gbXkgdmlldw0KPiBzdGlsbCB3b3J0
aCBkb2luZy4NCg0KQWNrLg0KTGV0J3MgbGVhdmUgaXQNCg0KPiANCj4gSm9uYXRoYW4NCj4gDQo+
ID4gDQo+ID4gDQo+ID4gPiAgICAgICAgIHJldCA9IGFkX3NkX3NldHVwX2J1ZmZlcl9hbmRfdHJp
Z2dlcihpbmRpb19kZXYpOw0KPiA+ID4gICAgICAgICBpZiAocmV0KQ0KPiA+ID4gICAgICAgICAg
ICAgICAgIGdvdG8gZXJyb3JfZGlzYWJsZV9yZWc7DQo+ID4gPiAtLQ0KPiA+ID4gMi4yMS4wDQo+
ID4gPiANCj4gDQo+IA0K
