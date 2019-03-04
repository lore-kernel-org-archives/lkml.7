Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305CEC10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E766F2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="smnW6LAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfCDHeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 02:34:00 -0500
Received: from mail-eopbgr770070.outbound.protection.outlook.com ([40.107.77.70]:48352
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbfCDHd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 02:33:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDar78uAuHEITJtK4oaBF8Q5AU4W6HesVO6i8n6zxxI=;
 b=smnW6LAQZc3qoIE0BCiqmT3RK+xWSa2QLW/wKkw3UxrHTZVzr2PeHwekc3UfRK2A1J5+Sxx7rawM1H8LDJbuT88Ewqn4h5QEycTnMzEBLRiQFE7RtI8TGcJn0A3kJ1vK8e5fkM/CK+Nnmftz8BNNqd+egtl8u4n0ktkYJ+FPsqg=
Received: from CY4PR03CA0087.namprd03.prod.outlook.com (2603:10b6:910:4d::28)
 by SN6PR03MB3517.namprd03.prod.outlook.com (2603:10b6:805:41::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1665.16; Mon, 4 Mar
 2019 07:33:54 +0000
Received: from CY1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by CY4PR03CA0087.outlook.office365.com
 (2603:10b6:910:4d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.16 via Frontend
 Transport; Mon, 4 Mar 2019 07:33:54 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT023.mail.protection.outlook.com (10.152.74.237) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Mon, 4 Mar 2019 07:33:53 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x247Xqhs000845
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 3 Mar 2019 23:33:52 -0800
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Mon, 4 Mar 2019 02:33:52 -0500
From:   "Ardelean, Alexandru" <Alex.Ardelean@analog.com>
To:     "renatogeh@gmail.com" <renatogeh@gmail.com>,
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
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "Ardelean, Alexandru" <Alex.Ardelean@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
Subject: Re: [PATCH v4 4/9] staging:iio:ad7780: add chip ID values and mask
Thread-Topic: [PATCH v4 4/9] staging:iio:ad7780: add chip ID values and mask
Thread-Index: AQHUz3FmSkCQgfvrAkKEY/tNv09ixKX2s0qAgAOUv4CAAA61gIABF2iA
Date:   Mon, 4 Mar 2019 07:33:51 +0000
Message-ID: <13ef212f8aeebd0c893be253cb4834a3e4d741b8.camel@analog.com>
References: <cover.1551358569.git.renatogeh@gmail.com>
         <90c573cd53bb54d49de6ac270bcff66880ccfeb5.1551358569.git.renatogeh@gmail.com>
         <190e26b19b8ed6559b92d3a000d852bbb0099a52.camel@analog.com>
         <20190303140107.ljjo3flatwmd44ya@renatolg>
         <20190303145347.41d49646@archlinux>
In-Reply-To: <20190303145347.41d49646@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <52538811362BBA4E81667CF748E8D63D@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(2980300002)(189003)(199004)(107886003)(11346002)(478600001)(106466001)(486006)(14454004)(86362001)(6246003)(72206003)(14444005)(47776003)(76176011)(336012)(246002)(476003)(446003)(2616005)(50466002)(126002)(426003)(436003)(186003)(106002)(8676002)(316002)(54906003)(102836004)(2501003)(110136005)(26005)(7696005)(2486003)(23676004)(229853002)(6116002)(118296001)(3846002)(4326008)(36756003)(2906002)(7636002)(7736002)(7416002)(93886005)(8936002)(305945005)(5660300002)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3517;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74ebf80f-8fd6-468a-a724-08d6a073c10e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060)(7193020);SRVR:SN6PR03MB3517;
X-MS-TrafficTypeDiagnostic: SN6PR03MB3517:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3517;20:9L0sZHKCJoSP2NDboAqDyUeY9+E2QeuH+dMbnqrbCDZuRfSVoDtU7XELgvQ/lQORK0FNCcr+LnXg+jUHybMApfD8Y+ldtWn4rn8Hn22d8rkcqm9H/UuaGArJ5aokRp+TongEjhJueWkQz46CQOwkl0Ev5M+fJElvEh9GkivDp9ASIYbtxsD/yYunQpgwTQH0FOrte4+n/Ky3SGmt9o6KPSusvMcrIqFMFTueAGau+zSZtJUUr+J/l4kAs3vgQHpuC63+IBZgq4OZ654tlCLuR3532MA72JnnbzoFKc8ESgKqP279gMtiy/B0WlSplOt96KjA7ienkL1kNriRbrZnvpEuUw7nWID+mHPX4qns13o1MJKb4HHef91RDyjBcPz/8kNcX2tbQTQpE6719OAY3WiRDWjf1KLywNYCWSeaB4oNNzsbTeIbMZeCBXSm/o6VM/03J/75/hSuCMbvVbbgaTZekRDfLt2uiS6Hc3pWrgPqAbleJbnbxcZQbGy8OhCE
X-Microsoft-Antispam-PRVS: <SN6PR03MB351721B768B47615B8D1EE3C95710@SN6PR03MB3517.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09669DB681
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjAzTUIzNTE3OzIzOkVxcnhjR3lrbm9ZS0R2bzJ1UXdLOUpZa2Ny?=
 =?utf-8?B?b0plYlpJOVBxY1h0cFV2alAwbmNORS9sZHVhWnowdHN5T3l2c2FRNm5jRHdQ?=
 =?utf-8?B?S3BsRzJXNWFlTzBncDNYazlmWTBSeFdSRnp6Z1RQM1VnRWJFaEtWTWpVdzNV?=
 =?utf-8?B?cy9lRWJJR3UvWVhxenpzZWxqVHY5NGtHRUREMGluQVh2aUhyWGl3SFhQR0ZR?=
 =?utf-8?B?OFcvdVFWcUJtaFI3eS96QzM2UFNSTTVjVXZRRXYvWGFpUGVKVEFPcG9Vdllt?=
 =?utf-8?B?VUNoWENTaElHTmZYMkY4Z0RENW5oREZ6M01rMXp6ZDVUcnV0L2RRRWRBQ250?=
 =?utf-8?B?dFRma3ZhWjlXbHhDVFhyd3JvQ0c3OWo2ODF2eWJDck9RajFOa0twQXlTanVv?=
 =?utf-8?B?NU9FYkZNR2xyUWo2SnBoM3BZT2JDMlh5UXIxNEx1OU5odTJrYVJRTjBieG5m?=
 =?utf-8?B?L1B0Z2c5a281UW1lZkhDa2ErM2IzN1FRQnY4SGhNbEt5MVN5SkorSVNZTXZ1?=
 =?utf-8?B?WnJBUFh6MlRwUzVqZHVSZUxmSVpZZTJHMTlKT2xMY0tpbkxuK3pXbG9qVU5J?=
 =?utf-8?B?ZjVWOVdvQ1lrV0xHSGIwR0VabEdDcEhITFpqRTM0SkFyeC8xNnNvMi9xVEUw?=
 =?utf-8?B?Z1dFSCs2OVpZMGVwYytyRDBZRDVEQXZVUjdiYldEVTg1V0F3YkZLWXZNa0RT?=
 =?utf-8?B?M0lUZGJadUNKajlBV01WMmJwSnNLNUpGNjVSL0pPZXRsdjduYjJMREdySk8v?=
 =?utf-8?B?QkFHOFNzMVRzZUdBT0hmbFFyN2ZTSTl2S3lFQjBoZDRPYU91b2ZrQURRajhy?=
 =?utf-8?B?Rnp5ekRlREpVaGlHSkdJbHhQQUVhYVJ6dVFLa3F5WXJnekpCdml6OXVycVNS?=
 =?utf-8?B?NXEvSVdYY3A2enRqWDNjTk05K3A2TWNtVGZCNXZaMEx2enR0VC9yRG5BSkV0?=
 =?utf-8?B?MEJDT0lLMERHZHgwODFFeTVUbFhmT2gvdHFUOHJRaDFNSWsyVmNTY1o2S1Jw?=
 =?utf-8?B?VnZjUkdVVHZNZjR4WGFucE4xSkdQVUc0TEZsaWlwN0xYMEx1MmNtYzUreGZt?=
 =?utf-8?B?ZWNnZzA3MCtyRElxMVF4MnhRSjFvRzhLWTI0T0Z6dzk4YUkxUzdITGR1eXA0?=
 =?utf-8?B?WnRnSVlXTGFvR1BLNWxBWTNjR1FXR3plMjlHYTQ5QTgvLzU2a2NRWVNsUnF1?=
 =?utf-8?B?RFRVc1BGKytDU2t0cHRwVmd3NjRncnZqR0ozTWo2Zmg3SVphbmpBUTRhcTlH?=
 =?utf-8?B?Qnp0UjZNaEJaNmNzalRVbWV0bm1DS1RxcUd3a21yb1R3UmtZcGk0NGkzZjZC?=
 =?utf-8?B?RHcyejdjNWNhTmwxb1BLenZ5U1J4WFlDYUlwWnBWenhiMEpsclVaYjBDc3RO?=
 =?utf-8?B?MzdiaDVSL1pIRjNmbTAxUk00d0trYkxVb2wwNVVtRVAwcmw3a0I0VXNFbkQ1?=
 =?utf-8?B?YWdnQ0JBNDJncy95UUFXd25BZStrMEtyWTgvdkNlOTVzUm5NalFYcmRoS3B3?=
 =?utf-8?B?MVpna2tPRVZ0c0VTOVlEMW9UaU05YitZQWRMUEhQL0JDSzNBS1VOTFZDdmc2?=
 =?utf-8?B?WExPRk9HY0prTDYreUJwU3VFNVMrR1Y5cHJ2aVEveWhXY0VDUEs3MGdld3dO?=
 =?utf-8?Q?b1ygYz1/kUhvL1m7EEF1?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: LExaLTT841XcNAjc5XazRecXukRGCfwZynWU81efgd8r3T3CIfMx3Z0ks2Rv8/5kslmWIpkaPAoPtQ8KHn/wgF7kjYSXJLyH4uo5Q2HbrN1KftjNzOsgb3lUeFr6/OnvgTIDOe5wi7ntAeAfqwPbkU6UQXLbrVTUvDrWrsFdD9iY+k9B8Nb4drk52WMj4sYyx/k/gjd5eZzUhdJbEiSaI7v01mKZXOZy79mxjM6sVgNL69xKn+f9RtXbhasZjs/z0W0hRsm0I25IV112yAz2cpzHptGyeXIc+H+WZRuXMjKVEXBRIBWTtcawSIY4gza/f77R4UamPjS2nujuZwteOaMGO3/BP+osP8vK3+vsyMHqJcwgIVITq9kgMCOXs03s+dEIG17OTXZj2tcJBEhvfI0MIWbdr647/IeNXHau89s=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2019 07:33:53.1953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ebf80f-8fd6-468a-a724-08d6a073c10e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3517
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDE5LTAzLTAzIGF0IDE0OjUzICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiANCj4gT24gU3VuLCAzIE1hciAyMDE5IDExOjAxOjA5IC0w
MzAwDQo+IFJlbmF0byBMdWkgR2VoIDxyZW5hdG9nZWhAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+
ID4gT24gMDMvMDEsIEFyZGVsZWFuLCBBbGV4YW5kcnUgd3JvdGU6DQo+ID4gPiBPbiBUaHUsIDIw
MTktMDItMjggYXQgMTE6MjQgLTAzMDAsIFJlbmF0byBMdWkgR2VoIHdyb3RlOg0KPiA+ID4gPiAN
Cj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBhZDc3ODAgc3VwcG9ydHMgYm90aCB0aGUgYWQ3Nzh4IGFu
ZCBhZDcxN3ggZmFtaWxpZXMuIEVhY2ggY2hpcA0KPiA+ID4gPiBoYXMNCj4gPiA+ID4gYSBjb3Jy
ZXNwb25kaW5nIElELiBUaGlzIHBhdGNoIHByb3ZpZGVzIGEgbWFzayBmb3IgZXh0cmFjdGluZyBJ
RA0KPiA+ID4gPiB2YWx1ZXMNCj4gPiA+ID4gZnJvbSB0aGUgc3RhdHVzIGJpdHMgYW5kIGFsc28g
bWFjcm9zIGZvciB0aGUgY29ycmVjdCB2YWx1ZXMgZm9yIHRoZQ0KPiA+ID4gPiBhZDcxNzAsIGFk
NzE3MSwgYWQ3NzgwIGFuZCBhZDc3ODEuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBSZW5hdG8gTHVpIEdlaCA8cmVuYXRvZ2VoQGdtYWlsLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4g
PiA+ICBkcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYyB8IDggKysrKysrLS0NCj4gPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4g
PiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3Nzgw
LmMNCj4gPiA+ID4gYi9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiA+ID4gPiBp
bmRleCA1NmM0OWUyOGY0MzIuLmFkNzYxN2EzYTE0MSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJp
dmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9zdGFn
aW5nL2lpby9hZGMvYWQ3NzgwLmMNCj4gPiA+ID4gQEAgLTI2LDEwICsyNiwxNCBAQA0KPiA+ID4g
PiAgI2RlZmluZSBBRDc3ODBfUkRZICAgICAgICAgICAgIEJJVCg3KQ0KPiA+ID4gPiAgI2RlZmlu
ZSBBRDc3ODBfRklMVEVSICAgICAgICAgIEJJVCg2KQ0KPiA+ID4gPiAgI2RlZmluZSBBRDc3ODBf
RVJSICAgICAgICAgICAgIEJJVCg1KQ0KPiA+ID4gPiAtI2RlZmluZSBBRDc3ODBfSUQxICAgICAg
ICAgICAgIEJJVCg0KQ0KPiA+ID4gPiAtI2RlZmluZSBBRDc3ODBfSUQwICAgICAgICAgICAgIEJJ
VCgzKQ0KPiA+ID4gPiAgI2RlZmluZSBBRDc3ODBfR0FJTiAgICAgICAgICAgIEJJVCgyKQ0KPiA+
ID4gPiANCj4gPiA+ID4gKyNkZWZpbmUgQUQ3MTcwX0lEICAgICAgICAgICAgICAwDQo+ID4gPiA+
ICsjZGVmaW5lIEFENzE3MV9JRCAgICAgICAgICAgICAgMQ0KPiA+ID4gPiArI2RlZmluZSBBRDc3
ODBfSUQgICAgICAgICAgICAgIDENCj4gPiA+ID4gKyNkZWZpbmUgQUQ3NzgxX0lEICAgICAgICAg
ICAgICAwDQo+ID4gPiA+ICsNCj4gPiA+ID4gKyNkZWZpbmUgQUQ3NzgwX0lEX01BU0sgICAgICAg
ICAoQklUKDMpIHwgQklUKDQpKQ0KPiA+ID4gDQo+ID4gPiBUaGlzIGFsc28gZG9lc24ndCBoYXZl
IGFueSBmdW5jdGlvbmFsaXR5IGNoYW5nZS4NCj4gPiA+IFRoZSBBRDcxNzBfSUQsIEFENzE3MV9J
RCwgQUQ3NzgwX0lEICYgQUQ3NzgxX0lEIElEcyBhcmUgYWxzbyB1bnVzZWQNCj4gPiA+IChtYXli
ZQ0KPiA+ID4gaW4gYSBsYXRlciBwYXRjaCB0aGV5IGFyZSA/KS4NCj4gPiANCj4gPiBUaGV5IGFy
ZW4ndC4gSSBhZGRlZCB0aGVtIGZvbGxvd2luZyBhIHByZXZpb3VzIHJldmlldyBzdWdnZXN0aW9u
Lg0KPiA+IFNob3VsZA0KPiA+IEkgcmVtb3ZlIHRoZW0/DQo+IA0KPiBDYW4gd2UgY2hlY2sgdGhl
bT8gIEl0J3MgYWx3YXlzIHVzZWZ1bCB0byBjb25maXJtIHRoYXQgdGhlIGRldmljZSBpcw0KPiB0
aGUgb25lIHlvdSB0aGluayBpdCBpcy4gIFRoZW4gd2UgY2FuIGVpdGhlciB1c2Ugd2hhdCBpcyB0
aGVyZQ0KPiB3aXRoIGEgc3VpdGFibGUgd2FybmluZywgb3IgaWYgdGhhdCBpcyB0cmlja3kganVz
dCBmYXVsdCBvdXQgYXMgdGhlDQo+IGR0IGlzIGdpdmluZyB1cyB0aGUgd3JvbmcgcGFydCBudW1i
ZXIuDQo+IA0KPiBKDQoNCkkgZ3Vlc3MgYGRldl93YXJuX3JhdGVsaW1pdGVkKClgIGNvdWxkIGJl
IHVzZWQgdG8gbWFrZSBzdXJlIHN5c2xvZyBpc24ndA0Kc3BhbW1lZC10by1kZWF0aCB3aGVuIGRv
aW5nIG11bHRpcGxlIGNvbnZlcnNpb25zLCBhbmQgdGhlIElEIGlzbid0IGNvcnJlY3QuDQpTaW5j
ZSB0aGVzZSBJRHMgYXJlIHJlYWQgYWZ0ZXIgeW91IGdldCBhIHNhbXBsZSwgSSdtIGEgYml0IGZl
YXJmdWwgb2YgbG9nLQ0Kc3BhbS4NCg0KSSB3b3VsZG4ndCB0aHJvdyBhbiBlcnJvciBpbiB0aGUg
YWQ3NzgwX3Bvc3Rwcm9jZXNzX3NhbXBsZSgpIGZvciB0aGlzLCBidXQNCndhcm5pbmcgW3dpdGgg
cmF0ZS1saW1pdF0gc291bmRzIHJlYXNvbmFibGUuDQoNCj4gDQo+ID4gPiANCj4gPiA+IEkgd291
bGQgYWxzbyBsZWF2ZSB0aGUgQUQ3NzgwX0lEMSAmIEFENzc4MF9JRDAgZGVmaW5pdGlvbnMgaW4g
cGxhY2UsDQo+ID4gPiBzaW5jZQ0KPiA+ID4gdGhleSdyZSBlYXNpZXIgbWF0Y2hlZCB3aXRoIHRo
ZSBkYXRhc2hlZXQuDQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+ICAjZGVmaW5lIEFENzc4MF9Q
QVRURVJOX0dPT0QgICAgMQ0KPiA+ID4gPiAgI2RlZmluZSBBRDc3ODBfUEFUVEVSTl9NQVNLICAg
IEdFTk1BU0soMSwgMCkNCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4yMS4wDQo+ID4gPiA+IA0KPiAN
Cj4gDQo=
