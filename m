Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F87EC10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E0520830
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="oWrH7gub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbfCAHRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 02:17:15 -0500
Received: from mail-eopbgr710078.outbound.protection.outlook.com ([40.107.71.78]:45792
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725982AbfCAHRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 02:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGH3IjZAAX0pWJLxnG6++B2A8z6u0eUD1t6AwcCqBO0=;
 b=oWrH7guby6hJRsGCV461XlZDWQ8KFd9Lp4lrxY5mLBj4bgHHjTNQgGoeYYhwvXZ51XQRHbu13otEMYpTh8OpyvCuT+Q4hF7wYKNxLYdo4drb63DvicW2eF50pzr6WGtU6byc8RT2xJpse5qCZ29PRCwZtAxmwhLf9dhraYKMiXI=
Received: from CY1PR03CA0026.namprd03.prod.outlook.com (2603:10b6:600::36) by
 BN6PR03MB3059.namprd03.prod.outlook.com (2603:10b6:405:45::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Fri, 1 Mar 2019 07:17:07 +0000
Received: from BL2NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by CY1PR03CA0026.outlook.office365.com
 (2603:10b6:600::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.15 via Frontend
 Transport; Fri, 1 Mar 2019 07:17:06 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT035.mail.protection.outlook.com (10.152.77.157) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Fri, 1 Mar 2019 07:17:06 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x217H5Qo009490
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 28 Feb 2019 23:17:05 -0800
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Fri, 1 Mar 2019 02:17:05 -0500
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
Subject: Re: [PATCH v4 3/9] staging: iio: ad7780: set pattern values and
 masks directly
Thread-Topic: [PATCH v4 3/9] staging: iio: ad7780: set pattern values and
 masks directly
Thread-Index: AQHUz3FaPQkUlqrErkyXchfV/yYKoqX2sncA
Date:   Fri, 1 Mar 2019 07:17:04 +0000
Message-ID: <efc42dc6be92871f03e5f8dc3d5aa9ebad5bedb8.camel@analog.com>
References: <cover.1551358569.git.renatogeh@gmail.com>
         <9c8331166124ec2bd52794a9c9f844bfb70d1cd9.1551358569.git.renatogeh@gmail.com>
In-Reply-To: <9c8331166124ec2bd52794a9c9f844bfb70d1cd9.1551358569.git.renatogeh@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C861BF982CFCA4CA1AB40FC3FBECA92@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(2980300002)(199004)(189003)(7416002)(72206003)(8936002)(106466001)(110136005)(54906003)(316002)(14454004)(7696005)(478600001)(5660300002)(2486003)(106002)(23676004)(76176011)(50466002)(47776003)(2906002)(356004)(4326008)(336012)(6246003)(446003)(246002)(11346002)(426003)(436003)(2616005)(8676002)(102836004)(305945005)(486006)(476003)(7636002)(7736002)(126002)(6116002)(3846002)(2501003)(36756003)(229853002)(26005)(86362001)(118296001)(2201001)(186003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3059;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c9b331f-b23d-4426-5b20-08d69e15e956
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB3059;
X-MS-TrafficTypeDiagnostic: BN6PR03MB3059:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3059;20:/rW+tdXQQfYIhNIQ0EpykvRYb9XVtO8elnN4FE4KhVT+8no+sNyzzdGExSYLqZ7A+HqORvwrtGuZdY56qkCz3DilpXy+3y8C1JazghZc4AyzzfTqHBJo6DbNDhkWXGW1hU3j8zsQxBjwrPWiacZ80xOlxsQ5p9nezU+ybkydGajIZqvJseniHtLMvb1y+rnNmk/YA3wu/y/HF3Fg9AyLXKHoao4ipDlYxXQ31Y7ENEkUJz0hh8ZNfHVIRUj3Y8P+0DC5tZ6nR2LWmwUvkwqSCMRzJ1BpCRthLaVftYrnsOrMA5jVoLwhQok155UctAOyS/Rqrlkv+mvEaz4Zp3A3mTD8KHnJ75Fu1gNbjgwIx1R9eZ2f82BEHLWGZVRNtNz6L+wSaepsJ092cm8mBj0RQSvwxW6ZGTxxCESeEQZUK0FpyczE7ZhJZOpjwvyvSp9FgubyjiR40hIGlVb5QkFtaIHPP347VOb8InoWRCS7mNUTnNZlSHloXHHyQcTZ9wN2
X-Microsoft-Antispam-PRVS: <BN6PR03MB3059081B5E1FD82E7FF8969595760@BN6PR03MB3059.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09634B1196
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjAzTUIzMDU5OzIzOm9zTlgwd24wSTRFZ2JjNm1XcmpMMWtub1I5?=
 =?utf-8?B?RGpDblM5VWNCS2xZc2pQYXBjV05iL0lNV2x3Y1lpRVVBMDNJWkpWdkFsb0xB?=
 =?utf-8?B?SjU3VEgwNE0wRUlYbkFXckhaVTdDWjFtQXJkdkpCYS9udGV4bmpNdkhHSFZv?=
 =?utf-8?B?ZkRRTm5uZDdocUVsOUpLR1dFSVg3SHBBbEF5d0Y4aDRIMGVoL3JQSkM0ck9X?=
 =?utf-8?B?SC84dWRFdG1Kb3pNVFh6Qk5ZQnl1TUtHdnBOVnk3MW9qSWhlZGYrOHZVejVL?=
 =?utf-8?B?WktaVUthUW1XaVJKeUVnOHMyNk9VS2x6VGFTUlRDbStyTDJna2FyTGxaVkIz?=
 =?utf-8?B?VkU2dXozNkticjhYZ3dSQm1ETkFMK0NvSFBSang0ZHgxWXFoQlZsdDNkc2s0?=
 =?utf-8?B?ZXQ2ZUJDSEVxV1pTL0ZUeFV2ZTFrbnc4UWdKNm9aR2lLcUtwRWU5SU51R0Vm?=
 =?utf-8?B?VExJZy9hQ01RbVU0eHN5YUh2M0lxRElSellmcmtqSzd1c0xtY002dzgwUUdH?=
 =?utf-8?B?U290MVY5ZGVLUmY5ZU5NNk15RmpsTTJXTE16MFhTWmdxdHRENTJhc1ZhQ2ZO?=
 =?utf-8?B?N0RybGdXL20yODllZlkyQ3FDT09GeVhvVGZ2WXlYSkNGQm5Ka1NURjNkUmND?=
 =?utf-8?B?SHh3Z3ZhYndBOFQvZUd1MkZ5YUNXYkxXbzZxUlZqS1FxUFhWaDZ2QmVpQ3N1?=
 =?utf-8?B?QXNDMVcwZStzZmxJWHRXSnQ1S0pJdjZoc1M2YkRNL2dLcDduREpuUHhva24v?=
 =?utf-8?B?UG9pcGJ6Um1BK2hob29CT2VzbStNdk9LcGYvM3lSa2Y2VzJIaHg4dmhwRkxZ?=
 =?utf-8?B?NUhiWndZTEN4QzRCcG1ORnNlQVp3eTBPcStLdUJ6OXJXR0ZiazNBM0dRSnZt?=
 =?utf-8?B?bzhicyt1dWFFVU9EcFM1MVpXT0wvRG43YlRhcDVtTU5tZVAxWXZWRjZUanhj?=
 =?utf-8?B?YVlFOFJ1dngwbWtKcjhhUU9ZWHB1LzNod0FvYUV6VXVqdUZ1SmpPMVZvU0xY?=
 =?utf-8?B?R3hVTlZaKzg0RWo3RWswNUdBdllrTFRPdmlZcG1ZYkdBSjRuVlBtcUpROHc1?=
 =?utf-8?B?M1ZBUjRsYXlWVDkxamFEOXRDRFd4UUdxWWNhKzNtaSt4WHEwa2Erd1d3K0hK?=
 =?utf-8?B?RjNiQzFpRzlxYVBlbCtYa3NrUndseWZCaHFhTFFRV2c2cGNkMWU5b1VhbkVu?=
 =?utf-8?B?QVczTHltOXhVNWxCb1Q5SkRvTXRmWHNqR095S2lkUCtNNnBTSXBrbHFJcHZJ?=
 =?utf-8?B?WExUeTlQRG5BRWpSNGhTbXdpdTVkZ0I3UjdNQXIzcEdKcHNzLzV0ZkZzRjAz?=
 =?utf-8?B?OWQ3Y3JpZEpwaE4xNUFiNWR4TkR6QVMvakprblRjQlJtS2xYMFZvNDVUQkVh?=
 =?utf-8?B?LzU3alJZK1N2MGl6bENhaUhNZ3pTMk10OGdJbUxsa0dNR0FlZDRkeHJwdldJ?=
 =?utf-8?B?dkRtT21WWG5LNDZGcUlzaTVXZHZ0UWlTdEI4YURpdjFQbUtBMHQyVHJkSldG?=
 =?utf-8?B?ZDVSQ1kzK2d5L3B2dUhsRWRwQ3RoYkg4MlNoTVk4aHIwL0t6WHRGYTllamt2?=
 =?utf-8?B?OGIzYWc3TVZ3TGVCN0FURjFyOU1PWGRQSUY0ZHFUL3AveU9sNkdoU0tFdTZR?=
 =?utf-8?Q?Z5+IMqCW76wKm15Xs1wV?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: jcQXxu6dGQbo4A58BjS/tgkxwQ19MG+grNGlqa2Tfawb4dQ32O08ELVkZhXZOKzIV1z16IpBXc30OgtcbpuqRm/4vhTxSn4X3QKeHpIbOYLkhduYmijeq3ztDMhaX+SbczTjhrgJAcZDCU1ESzHA5q9NsP9BFV4eDGGDbuZjNA5Kvh6hr7nWtHLucmdAPshp5rBjgacuTKVJpvG7HmNkImNS2oUf9k6ylUWnsFwUZIlKyaoMBqcWNSFIK9Fiq15v5gs48M3thVtW/Lht0R224uJmFjGRkAh+zuXTpg9J2zKxT/Z+edQ+yodio+EJ9qW0jcgXKNIwSbF/HtXJde/hTbksNX1oj4Ow2DMTGiliVFdY45E2Q3rNj5IkLkQtv3YUVbmdjUKZ585B4Cd07gXn1PQNwNV13rMv0pPS3al1iQM=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2019 07:17:06.4735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9b331f-b23d-4426-5b20-08d69e15e956
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTAyLTI4IGF0IDExOjI0IC0wMzAwLCBSZW5hdG8gTHVpIEdlaCB3cm90ZToN
Cj4gDQo+IA0KPiBUaGUgQUQ3NzgwIGRyaXZlciBjb250YWlucyBzdGF0dXMgcGF0dGVybiBiaXRz
IGRlc2lnbmVkIGZvciBjaGVja2luZw0KPiB3aGV0aGVyIHNlcmlhbCB0cmFuc2ZlcnMgaGF2ZSBi
ZWVuIGNvcnJlY3RseSBwZXJmb3JtZWQuIFBhdHRlcm4gbWFjcm9zDQo+IHdlcmUgcHJldmlvdXNs
eSBnZW5lcmF0ZWQgdGhyb3VnaCBiaXQgZmllbGRzLiBUaGlzIHBhdGNoIHNldHMgZ29vZA0KPiBw
YXR0ZXJuIHZhbHVlcyBkaXJlY3RseSBhbmQgbWFza3MgdGhyb3VnaCBHRU5NQVNLLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogUmVuYXRvIEx1aSBHZWggPHJlbmF0b2dlaEBnbWFpbC5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMgfCAyMCArKysrKysrKystLS0t
LS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMN
Cj4gYi9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiBpbmRleCA3YTY4ZTkwZGRm
MTQuLjU2YzQ5ZTI4ZjQzMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMv
YWQ3NzgwLmMNCj4gKysrIGIvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMNCj4gQEAg
LTE3LDYgKzE3LDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9zY2hlZC5oPg0KPiAgI2luY2x1ZGUg
PGxpbnV4L2dwaW8vY29uc3VtZXIuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4g
KyNpbmNsdWRlIDxsaW51eC9iaXRzLmg+DQo+IA0KPiAgI2luY2x1ZGUgPGxpbnV4L2lpby9paW8u
aD4NCj4gICNpbmNsdWRlIDxsaW51eC9paW8vc3lzZnMuaD4NCj4gQEAgLTI4LDE2ICsyOSwxMyBA
QA0KPiAgI2RlZmluZSBBRDc3ODBfSUQxICAgICAgICAgICAgIEJJVCg0KQ0KPiAgI2RlZmluZSBB
RDc3ODBfSUQwICAgICAgICAgICAgIEJJVCgzKQ0KPiAgI2RlZmluZSBBRDc3ODBfR0FJTiAgICAg
ICAgICAgIEJJVCgyKQ0KPiAtI2RlZmluZSBBRDc3ODBfUEFUMSAgICAgICAgICAgIEJJVCgxKQ0K
PiAtI2RlZmluZSBBRDc3ODBfUEFUMCAgICAgICAgICAgIEJJVCgwKQ0KDQpJIGRvbid0IHNlZSBh
IHByb2JsZW0gdG8gbGVhdmUgdGhlIGJpdGZpZWxkczsgIHRoZXkgY2FuIGJlIHJlYWQgJiBtYXRj
aGVkDQplYXNpZXIgd2l0aCB0aGUgZGF0YXNoZWV0Lg0KDQo+IA0KPiAtI2RlZmluZSBBRDc3ODBf
UEFUVEVSTiAgICAgICAgIChBRDc3ODBfUEFUMCkNCj4gLSNkZWZpbmUgQUQ3NzgwX1BBVFRFUk5f
TUFTSyAgICAoQUQ3NzgwX1BBVDAgfCBBRDc3ODBfUEFUMSkNCj4gDQo+IC0jZGVmaW5lIEFENzE3
MF9QQVQyICAgICAgICAgICAgQklUKDIpDQoNCj4gKyNkZWZpbmUgQUQ3NzgwX1BBVFRFUk5fR09P
RCAgICAxDQoNCkl0IHdhcyBhbHNvIG5pY2UgYmVmb3JlIHRoYXQgdGhlIFBBVDAuLlBBVDIgYml0
ZmllbGRzIHdlcmUgdXNlZCB0byBkZWZpbmUgYQ0KZ29vZCBwYXR0ZXJuLCBzaW5jZSBpdCdzIGVh
c2llciB0byBtYXRjaCB3aXRoIHRoZSBkYXRhc2hlZXQuDQoNCg0KPiArI2RlZmluZSBBRDc3ODBf
UEFUVEVSTl9NQVNLICAgIEdFTk1BU0soMSwgMCkNCg0KSSBsaWtlIHRoZSBnZW5lcmFsIHVzYWdl
IG9mIEdFTk1BU0ssIGJ1dCBJJ20gbm90IHN1cmUgaW4gdGhpcyBjYXNlIGl0J3MNCndvcnRoIGRv
aW5nLiBNYXliZSBJIG1pc3NlZCBhIGRpc2N1c3Npb24gc29tZXdoZXJlLCBhYm91dCBkb2luZyB0
aGlzDQpjaGFuZ2UsIGJ1dCBpdCBpcyBtb3N0bHkgYSBjb3NtZXRpYyB3aXRob3V0IGFueSBmdW5j
dGlvbmFsIGNoYW5nZS4NCg0KDQo+IA0KPiAtI2RlZmluZSBBRDcxNzBfUEFUVEVSTiAgICAgICAg
IChBRDc3ODBfUEFUMCB8IEFENzE3MF9QQVQyKQ0KPiAtI2RlZmluZSBBRDcxNzBfUEFUVEVSTl9N
QVNLICAgIChBRDc3ODBfUEFUMCB8IEFENzc4MF9QQVQxIHwgQUQ3MTcwX1BBVDIpDQo+ICsjZGVm
aW5lIEFENzE3MF9QQVRURVJOX0dPT0QgICAgNQ0KPiArI2RlZmluZSBBRDcxNzBfUEFUVEVSTl9N
QVNLICAgIEdFTk1BU0soMiwgMCkNCj4gDQo+ICAjZGVmaW5lIEFENzc4MF9HQUlOX01JRFBPSU5U
ICAgNjQNCj4gICNkZWZpbmUgQUQ3NzgwX0ZJTFRFUl9NSURQT0lOVCAxMzM1MA0KPiBAQCAtMjA5
LDI1ICsyMDcsMjUgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhZF9zaWdtYV9kZWx0YV9pbmZvDQo+
IGFkNzc4MF9zaWdtYV9kZWx0YV9pbmZvID0gew0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBhZDc3
ODBfY2hpcF9pbmZvIGFkNzc4MF9jaGlwX2luZm9fdGJsW10gPSB7DQo+ICAgICAgICAgW0lEX0FE
NzE3MF0gPSB7DQo+ICAgICAgICAgICAgICAgICAuY2hhbm5lbCA9IEFENzE3MF9DSEFOTkVMKDEy
LCAyNCksDQo+IC0gICAgICAgICAgICAgICAucGF0dGVybiA9IEFENzE3MF9QQVRURVJOLA0KPiAr
ICAgICAgICAgICAgICAgLnBhdHRlcm4gPSBBRDcxNzBfUEFUVEVSTl9HT09ELA0KPiAgICAgICAg
ICAgICAgICAgLnBhdHRlcm5fbWFzayA9IEFENzE3MF9QQVRURVJOX01BU0ssDQo+ICAgICAgICAg
ICAgICAgICAuaXNfYWQ3Nzh4ID0gZmFsc2UsDQo+ICAgICAgICAgfSwNCj4gICAgICAgICBbSURf
QUQ3MTcxXSA9IHsNCj4gICAgICAgICAgICAgICAgIC5jaGFubmVsID0gQUQ3MTcwX0NIQU5ORUwo
MTYsIDI0KSwNCj4gLSAgICAgICAgICAgICAgIC5wYXR0ZXJuID0gQUQ3MTcwX1BBVFRFUk4sDQo+
ICsgICAgICAgICAgICAgICAucGF0dGVybiA9IEFENzE3MF9QQVRURVJOX0dPT0QsDQo+ICAgICAg
ICAgICAgICAgICAucGF0dGVybl9tYXNrID0gQUQ3MTcwX1BBVFRFUk5fTUFTSywNCj4gICAgICAg
ICAgICAgICAgIC5pc19hZDc3OHggPSBmYWxzZSwNCj4gICAgICAgICB9LA0KPiAgICAgICAgIFtJ
RF9BRDc3ODBdID0gew0KPiAgICAgICAgICAgICAgICAgLmNoYW5uZWwgPSBBRDc3ODBfQ0hBTk5F
TCgyNCwgMzIpLA0KPiAtICAgICAgICAgICAgICAgLnBhdHRlcm4gPSBBRDc3ODBfUEFUVEVSTiwN
Cj4gKyAgICAgICAgICAgICAgIC5wYXR0ZXJuID0gQUQ3NzgwX1BBVFRFUk5fR09PRCwNCj4gICAg
ICAgICAgICAgICAgIC5wYXR0ZXJuX21hc2sgPSBBRDc3ODBfUEFUVEVSTl9NQVNLLA0KPiAgICAg
ICAgICAgICAgICAgLmlzX2FkNzc4eCA9IHRydWUsDQo+ICAgICAgICAgfSwNCj4gICAgICAgICBb
SURfQUQ3NzgxXSA9IHsNCj4gICAgICAgICAgICAgICAgIC5jaGFubmVsID0gQUQ3NzgwX0NIQU5O
RUwoMjAsIDMyKSwNCj4gLSAgICAgICAgICAgICAgIC5wYXR0ZXJuID0gQUQ3NzgwX1BBVFRFUk4s
DQo+ICsgICAgICAgICAgICAgICAucGF0dGVybiA9IEFENzc4MF9QQVRURVJOX0dPT0QsDQo+ICAg
ICAgICAgICAgICAgICAucGF0dGVybl9tYXNrID0gQUQ3NzgwX1BBVFRFUk5fTUFTSywNCj4gICAg
ICAgICAgICAgICAgIC5pc19hZDc3OHggPSB0cnVlLA0KPiAgICAgICAgIH0sDQo+IC0tDQo+IDIu
MjEuMA0KPiANCg==
