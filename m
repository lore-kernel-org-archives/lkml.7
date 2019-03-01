Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA2BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30852186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="n+081RgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732828AbfCAHkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 02:40:31 -0500
Received: from mail-eopbgr790078.outbound.protection.outlook.com ([40.107.79.78]:45376
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732081AbfCAHka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 02:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rXM7Y34v/l39MBl9UIsOJoM2tfhaenA8M8uYG1PgQM=;
 b=n+081RgHp747Pl18B87U3J9nq+k4xGiHiuXJbHbzRRtV8KekMD9ELwvpXbD2iTtq07IgTwAPNICSkD6naQDP5pCNRrOIZhdLorXHgdcIhaW/UwTdZIejSkGUUNxTuL63AMgyGo4wPBl9YZ0fxHXqQXl+9KrBCINRhh1c0nXanNg=
Received: from CY4PR03CA0007.namprd03.prod.outlook.com (2603:10b6:903:33::17)
 by DM5PR03MB3068.namprd03.prod.outlook.com (2603:10b6:4:3c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.15; Fri, 1 Mar
 2019 07:38:47 +0000
Received: from BL2NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by CY4PR03CA0007.outlook.office365.com
 (2603:10b6:903:33::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.18 via Frontend
 Transport; Fri, 1 Mar 2019 07:38:46 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT020.mail.protection.outlook.com (10.152.77.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Fri, 1 Mar 2019 07:38:46 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x217cjQG014138
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 28 Feb 2019 23:38:45 -0800
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Fri, 1 Mar 2019 02:38:45 -0500
From:   "Ardelean, Alexandru" <Alex.Ardelean@analog.com>
To:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 5/9] staging: iio: ad7780: move regulator to after
 GPIO init
Thread-Topic: [PATCH v4 5/9] staging: iio: ad7780: move regulator to after
 GPIO init
Thread-Index: AQHUz3FvfboR2oAIAEa+TaF0Vv+tjqX2uIaA
Date:   Fri, 1 Mar 2019 07:38:45 +0000
Message-ID: <28d78cfc00bc5414c7539879df46200d61e52ee1.camel@analog.com>
References: <cover.1551358569.git.renatogeh@gmail.com>
         <93cabb081605ac356f2f0d9a9a41d5bc5e63820d.1551358569.git.renatogeh@gmail.com>
In-Reply-To: <93cabb081605ac356f2f0d9a9a41d5bc5e63820d.1551358569.git.renatogeh@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C1D24390C95A74DA6E0B9CA09D7E998@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(346002)(2980300002)(199004)(189003)(76176011)(486006)(246002)(436003)(8676002)(8936002)(426003)(54906003)(14444005)(2501003)(36756003)(47776003)(476003)(2616005)(11346002)(6246003)(4326008)(110136005)(305945005)(7636002)(7736002)(446003)(186003)(126002)(336012)(50466002)(6346003)(106466001)(2486003)(23676004)(72206003)(7696005)(229853002)(5660300002)(86362001)(14454004)(118296001)(26005)(106002)(2906002)(102836004)(316002)(356004)(478600001)(7416002)(3846002)(6116002)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3068;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa264264-83f5-4588-9141-08d69e18f047
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB3068;
X-MS-TrafficTypeDiagnostic: DM5PR03MB3068:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3068;20:KOH2OAlobX33K9+oDuAL3+MJyqdSGkwu13c1mnJAFqdBjdsl8UwJyZK7G1ZIExsnuXQ1iT3YsjK1UqcM+KvXEn7Bv8+scLCVxU7OAW6KrZ/ZMLSoUJTs7e34JEhxrCQUqJcYqRxHq+bl/iproCIK2JqbHURkn+OZmEx0vlpyTHMe7e3rUmPBmXHnWnHVQPizmj0Jx90lpU369MCOTF3IvrgM1X71NcA2gF0a9HNAcx6VZHLsZvW+UR8ClhgNh5M4RNW+i3wI2vjVZ8w2vV3A578m9wBtK6UXJxW550SlarucK/u0M37RADM17Z4Yhq/J1hv/7SMsFos/LQDMxSPrNO1DXCejDwpWlQUgHgLajLofvsdwwMTZ2cjzH/fSUjE5MZrs00Gt2cnG+fg7B2WGf4+Z8IJFmSaub4e+DjlloauYAh21rbpWkcujSn1X/OSgXgGu6deeK0LC+LKsLNfZfjMViGy1QH0G47dkb1dhheqyHdi3yLcXE/Hz69ZELTHO
X-Microsoft-Antispam-PRVS: <DM5PR03MB3068719F9139576E2241D4AC95760@DM5PR03MB3068.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09634B1196
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjAzTUIzMDY4OzIzOmQ2bHBzSjF3cVNLZlhVb3RuRWJCdEx1N0s0?=
 =?utf-8?B?R21VbVh2b2pDb3EyTEVuTWFzaTNPUzF4L01vdzlGeTJReCtVOEVuNlRtanh5?=
 =?utf-8?B?dkxGSGJmdGRXZHJnTU5CbEpJOGNZZFRuRlc0NnRjaTJqY2dRaGpTVHM2N0p2?=
 =?utf-8?B?VTFkQnJYOWppb1VVRkx2Ykt2MlU5YUp1OHJlcnZsalROc0Y5Q0hPamx1R2NE?=
 =?utf-8?B?bTNPRllRaklUS0I5VEFHU0ZUODhqcFJRRi9oRGx6U3d4aXlrZmYxdGZBcmhH?=
 =?utf-8?B?VDZsbGx4cFVRblR4ZlBOTHpvekljVlFLNDN5ZzVaOW8xQ1dlZC9vbjV2V0w3?=
 =?utf-8?B?S0tITGZUMEJuRU9PTVlZOGlUaEtuMnFib0lJS3FPdkNEcG1pUVhRVnVMOFRV?=
 =?utf-8?B?SmdrREtoSUROZWpBSjNGcXRwUmY4TWxpdUg2dXpxOWtpSGlZd0RpcElBckli?=
 =?utf-8?B?d2xSSGtkZnUwS1BiWVFMZ1FQejB4YnVvam9qSzhRa1FqbC9aMDcyckJkNlp5?=
 =?utf-8?B?Rll5Vzlxd0JFTUZ4clJFWkd6SDVBaHRyT3UzZkZXWjlwc1ovVTJTWjF6UjNn?=
 =?utf-8?B?Tkw0YUNhU0RmVmxyRnpzT2QxcDhDSzgydEd2RXNRdjNkZGRyY0p0RmJ5U05h?=
 =?utf-8?B?TUozdW1yQ0JoZzk1WDZwcld4Nk5rcGk1VEFaekpJWHdyNTgvMlhERDlwa25R?=
 =?utf-8?B?b1VucG5COGdrTDlhZlppSytGbWVQUUFLRkJNaWdLdUxzNkFsaUE0Mm16dG80?=
 =?utf-8?B?alhza2VJVlRnN2kvVzZKWkU2VU4zVTRvRXFUN0VtdXVhcjNNZmhYZTJkalRy?=
 =?utf-8?B?WndYU3U4amxDMWNTa0xacGZuY282Mkl0Z3VySkVONlNJaDFzSFpIcGd6SitX?=
 =?utf-8?B?K0FmSTVvTGpOYUFDTzNDdVFzcHBYczNWR0dvOGZoTUVQcGgzalFFWjFiRVIx?=
 =?utf-8?B?VkJWbjc5QU1QT0daV21pYUcraElpeFdKaVdSdG5KSEpvZ3NzWmZWaVQ5SnhR?=
 =?utf-8?B?Rys4Sm83ZXZVMWZNa2VCR29hUWV0cWx3VnpXVUdDdXVMVklXYnk0WkN6cFpk?=
 =?utf-8?B?dmFLdjJnNUplSkFsa09yVjBKYXNrTER1THVsSTRsTmIvTFRCR29VakZoVmpN?=
 =?utf-8?B?Y1FndUFwbW1ZaTNtMXI3UzRGNkU5c0JxUDk5OEZSWC9MSURJTEdSd0MrSnNo?=
 =?utf-8?B?QjJNSWlvTTdRMXRTcDFXbHVZbnIwVTBnd20zQUJ2dUJTZ01OSFgvR0tlRmRo?=
 =?utf-8?B?eUg0aE90Vk9tN2IzTmtXUmFqZlcxQmkrRE9UWEY5RDQzc3pOUFdCakIwUGI2?=
 =?utf-8?B?c01xREVpV0VYODRTOWNYTmJ2OWxoZDRMZVlkNW91U3lCZVlqY1lKOE50SldI?=
 =?utf-8?B?ajJ1L1hra0IzWmxmbTZhMVRBT1FXbjFESzlSeXlPV0k1WXlRLy9tb2RUQkJx?=
 =?utf-8?B?OE5tUE5vczZDQ3g2Q2lKZThuS1gxMmk4UFl1ZXg1QWlFVE04SENsT25TdVVF?=
 =?utf-8?B?WUM1cE5zUWJTZTFLMWxGQ1NZUEV2UGVxQ0tSTG4wSmw4SFVwZDZ5NUl5QlFl?=
 =?utf-8?B?eGRDTm1ua2JhSXBDNnBZUHlJdTEvNXkybTJXTXllQzVjRDhkVnZPZWhNaFJr?=
 =?utf-8?B?ZWxEb2tVeTQvcVdBbW5TK0U2T2lyczFBdFVTWkFpRHBEUXZMcnpScG9tS1Zx?=
 =?utf-8?Q?fjW7q8zlKh6sSlfhn0=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: s6WRvYoei42nS3FxbWcxABoZpYq8HF49p7UCAhIiaSOllWvgv8OeJb08t6pDfiK7wyvWKnjv62EHI+vySAutwsZTJo76556LKKZL4AvrP+EAZn8uOz+20GewmBqa6bx/9FUW7ZW/P74btkCxn3CcqiCFq2uxZm5kwxWBql3U+DgV/Qn7rjaO1N9ct4wZ6PH6iWnesC6ZOwjnbQJgPPyf7OI7Q5Tvf4C1Prntf7ExdGu55qso1Zv9nZ+sxL4ATmXZCwysxQIDT2W/42SNZM/7UkbVwZwPoTd8Is1OIq9EXjSO9qUVIcycrBHPrkjJRxNm6aNQ3PH9hbg2sEOGlfUuzbo0hTQB1OiNkQhG8mwaOdEEWS9XEb/v6mhkWnzzTds+UMGZbHEHzNGgHt+0FcOyIZzZPqMOMvW96Ask9VPvrtQ=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2019 07:38:46.6068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa264264-83f5-4588-9141-08d69e18f047
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTAyLTI4IGF0IDExOjI1IC0wMzAwLCBSZW5hdG8gTHVpIEdlaCB3cm90ZToN
Cj4gDQo+IA0KPiBUbyBtYWludGFpbiBjb25zaXN0ZW5jeSBiZXR3ZWVuIGFkNzc4MF9wcm9iZSBh
bmQgYWQ3NzgwX3JlbW92ZSBvcmRlcnMsDQo+IHJlZ3VsYXRvciBpbml0aWFsaXphdGlvbiBoYXMg
YmVlbiBtb3ZlZCB0byBhZnRlciBHUElPIGluaXRpYWxpemF0aW9ucy4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFJlbmF0byBMdWkgR2VoIDxyZW5hdG9nZWhAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzc4MC5jIHwgMjYgKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0K
PiBiL2RyaXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzc4MC5jDQo+IGluZGV4IGFkNzYxN2EzYTE0
MS4uMTJhZWYwZjEwMWJjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9h
ZDc3ODAuYw0KPiArKysgYi9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiBAQCAt
MjU1LDE2ICsyNTUsNiBAQCBzdGF0aWMgaW50IGFkNzc4MF9wcm9iZShzdHJ1Y3Qgc3BpX2Rldmlj
ZSAqc3BpKQ0KPiANCj4gICAgICAgICBhZF9zZF9pbml0KCZzdC0+c2QsIGluZGlvX2Rldiwgc3Bp
LCAmYWQ3NzgwX3NpZ21hX2RlbHRhX2luZm8pOw0KPiANCj4gLSAgICAgICBzdC0+cmVnID0gZGV2
bV9yZWd1bGF0b3JfZ2V0KCZzcGktPmRldiwgImF2ZGQiKTsNCj4gLSAgICAgICBpZiAoSVNfRVJS
KHN0LT5yZWcpKQ0KPiAtICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoc3QtPnJlZyk7DQo+
IC0NCj4gLSAgICAgICByZXQgPSByZWd1bGF0b3JfZW5hYmxlKHN0LT5yZWcpOw0KPiAtICAgICAg
IGlmIChyZXQpIHsNCj4gLSAgICAgICAgICAgICAgIGRldl9lcnIoJnNwaS0+ZGV2LCAiRmFpbGVk
IHRvIGVuYWJsZSBzcGVjaWZpZWQgQVZkZA0KPiBzdXBwbHlcbiIpOw0KPiAtICAgICAgICAgICAg
ICAgcmV0dXJuIHJldDsNCj4gLSAgICAgICB9DQo+IC0NCj4gICAgICAgICBzdC0+Y2hpcF9pbmZv
ID0NCj4gICAgICAgICAgICAgICAgICZhZDc3ODBfY2hpcF9pbmZvX3RibFtzcGlfZ2V0X2Rldmlj
ZV9pZChzcGkpLQ0KPiA+ZHJpdmVyX2RhdGFdOw0KPiANCj4gQEAgLTI4NCw3ICsyNzQsNyBAQCBz
dGF0aWMgaW50IGFkNzc4MF9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiAgICAgICAg
ICAgICAgICAgcmV0ID0gUFRSX0VSUihzdC0+cG93ZXJkb3duX2dwaW8pOw0KPiAgICAgICAgICAg
ICAgICAgZGV2X2Vycigmc3BpLT5kZXYsICJGYWlsZWQgdG8gcmVxdWVzdCBwb3dlcmRvd24gR1BJ
TzoNCj4gJWRcbiIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldCk7DQo+IC0gICAgICAg
ICAgICAgICBnb3RvIGVycm9yX2Rpc2FibGVfcmVnOw0KPiArICAgICAgICAgICAgICAgcmV0dXJu
IHJldDsNCj4gICAgICAgICB9DQo+IA0KPiAgICAgICAgIGlmIChzdC0+Y2hpcF9pbmZvLT5pc19h
ZDc3OHgpIHsNCj4gQEAgLTI5NSw3ICsyODUsNyBAQCBzdGF0aWMgaW50IGFkNzc4MF9wcm9iZShz
dHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBQ
VFJfRVJSKHN0LT5nYWluX2dwaW8pOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJy
KCZzcGktPmRldiwgIkZhaWxlZCB0byByZXF1ZXN0IGdhaW4gR1BJTzoNCj4gJWRcbiIsDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0KTsNCj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgZ290byBlcnJvcl9kaXNhYmxlX3JlZzsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIHJldDsNCj4gICAgICAgICAgICAgICAgIH0NCj4gDQo+ICAgICAgICAgICAgICAgICBz
dC0+ZmlsdGVyX2dwaW8gPSBkZXZtX2dwaW9kX2dldF9vcHRpb25hbCgmc3BpLT5kZXYsDQo+IEBA
IC0zMDYsMTAgKzI5NiwyMCBAQCBzdGF0aWMgaW50IGFkNzc4MF9wcm9iZShzdHJ1Y3Qgc3BpX2Rl
dmljZSAqc3BpKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKCZzcGktPmRldiwN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiRmFpbGVkIHRvIHJlcXVlc3QgZmls
dGVyIEdQSU86ICVkXG4iLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldCk7
DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyb3JfZGlzYWJsZV9yZWc7DQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICAgICAgICAgICAgICAgICB9DQo+
ICAgICAgICAgfQ0KPiANCj4gKyAgICAgICBzdC0+cmVnID0gZGV2bV9yZWd1bGF0b3JfZ2V0KCZz
cGktPmRldiwgImF2ZGQiKTsNCj4gKyAgICAgICBpZiAoSVNfRVJSKHN0LT5yZWcpKQ0KPiArICAg
ICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoc3QtPnJlZyk7DQo+ICsNCj4gKyAgICAgICByZXQg
PSByZWd1bGF0b3JfZW5hYmxlKHN0LT5yZWcpOw0KPiArICAgICAgIGlmIChyZXQpIHsNCj4gKyAg
ICAgICAgICAgICAgIGRldl9lcnIoJnNwaS0+ZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSBzcGVjaWZp
ZWQgQVZkZA0KPiBzdXBwbHlcbiIpOw0KPiArICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4g
KyAgICAgICB9DQo+ICsNCg0KSSdtIHByb2JhYmx5IG1pc3Npbmcgc29tZXRoaW5nLCBidXQgb3Ro
ZXIgdGhhbiB0aGUgZmFjdCB0aGF0IHRoaXMgbW92ZXMgdGhlDQpyZWd1bGF0b3IgaW5pdCBhZnRl
ciB0aGUgR1BJT3MgaW5pdCwgaXQgZG9lc24ndCBjaGFuZ2UgbXVjaC4NClRoZSBvcmRlciBvZiB0
aGUgcHJvYmUgJiByZW1vdmUgaXMgbW9yZS1vci1sZXNzIHRoZSBzYW1lLg0KVGhlIEdQSU9zIHdp
bGwgYmUgZnJlZSdkIHZpYSBkZXZtXyBBUEkvc3R1ZmYuDQoNCg0KPiAgICAgICAgIHJldCA9IGFk
X3NkX3NldHVwX2J1ZmZlcl9hbmRfdHJpZ2dlcihpbmRpb19kZXYpOw0KPiAgICAgICAgIGlmIChy
ZXQpDQo+ICAgICAgICAgICAgICAgICBnb3RvIGVycm9yX2Rpc2FibGVfcmVnOw0KPiAtLQ0KPiAy
LjIxLjANCj4gDQo=
