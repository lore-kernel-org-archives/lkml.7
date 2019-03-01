Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6ABC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE723218EA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="JJN2qei4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbfCAHUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 02:20:08 -0500
Received: from mail-eopbgr720059.outbound.protection.outlook.com ([40.107.72.59]:16135
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbfCAHUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 02:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSSxW+RoMTvJ0E1/DS7w5iDwFO8oiTfN+PADIWkYluc=;
 b=JJN2qei461cxlaeT+XJyit8tZjbYBp7oCB8RFJU/QRktlhem+dm8A7PqZ7Yg/Gakdr1gZNKNETv41R5uslOyoHtSWT+lI9+q67ucGsMYvc6ZWPfNWeScxFKUqcbHQ2lylww4epwyMmqWy+qF+DmNPwUrm6Qc1Gbbhk1ytMCCUcU=
Received: from MWHPR03CA0032.namprd03.prod.outlook.com (2603:10b6:301:3b::21)
 by BYAPR03MB3510.namprd03.prod.outlook.com (2603:10b6:a02:aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1665.16; Fri, 1 Mar
 2019 07:20:03 +0000
Received: from SN1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by MWHPR03CA0032.outlook.office365.com
 (2603:10b6:301:3b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.15 via Frontend
 Transport; Fri, 1 Mar 2019 07:20:03 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT050.mail.protection.outlook.com (10.152.72.128) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Fri, 1 Mar 2019 07:20:02 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x217K2tA010244
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 28 Feb 2019 23:20:02 -0800
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Fri, 1 Mar 2019 02:20:02 -0500
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
Subject: Re: [PATCH v4 4/9] staging:iio:ad7780: add chip ID values and mask
Thread-Topic: [PATCH v4 4/9] staging:iio:ad7780: add chip ID values and mask
Thread-Index: AQHUz3FmSkCQgfvrAkKEY/tNv09ixKX2s0qA
Date:   Fri, 1 Mar 2019 07:20:01 +0000
Message-ID: <190e26b19b8ed6559b92d3a000d852bbb0099a52.camel@analog.com>
References: <cover.1551358569.git.renatogeh@gmail.com>
         <90c573cd53bb54d49de6ac270bcff66880ccfeb5.1551358569.git.renatogeh@gmail.com>
In-Reply-To: <90c573cd53bb54d49de6ac270bcff66880ccfeb5.1551358569.git.renatogeh@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9487AF172CBDEB46A60968BB37F41499@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(136003)(39860400002)(376002)(346002)(396003)(2980300002)(189003)(199004)(476003)(446003)(11346002)(2616005)(126002)(2501003)(110136005)(316002)(486006)(106466001)(186003)(8936002)(106002)(436003)(426003)(336012)(54906003)(5660300002)(246002)(72206003)(2486003)(2906002)(23676004)(356004)(47776003)(7696005)(478600001)(36756003)(2201001)(305945005)(102836004)(229853002)(118296001)(50466002)(4326008)(7416002)(26005)(8676002)(76176011)(7736002)(7636002)(6116002)(6246003)(86362001)(3846002)(14454004)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3510;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d71c836-317d-449c-427d-08d69e1652bc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB3510;
X-MS-TrafficTypeDiagnostic: BYAPR03MB3510:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3510;20:v2PVOehAXKrgzQPh0uyZdefa8M6HgGBI0oiXNR9qjiCh/ajNON1SQs+SyKe3kStJa7bzR5miT0X+NYmcC4MD5rglfArQO0oC53JwXuuKIMS3fHNMA1HmZlPsPEUhp3f7Op4V6To+5NPnm6EJYUlI1wnYcZ+/n2yvHBzMMWxSAWkK2iVFyvolr52RDZIuEF0N839pm9Moic5Wgvq8Kccxja2lMe+d4lDWwmsPx2IBe906Qn9KKjyQbiHFGAHCbw4nihcAd68AZ5DzTRcHCvq2B87wCu0t5DcrBOrT0tXrrVa12L0E3t4IeJqbzJ5+CRTJ2yai8O0y2QENWTt88eW1gn6Qhh3mIDankdK++BneuqV4n7T1FnPzZI3XmhdEy/o/bDb3AGVz5D18FBLeF7zuGZQRRYRnNwi4BVI6iVd6RewRb46ZmWpM9eMedkvRBmXNhf1AqvVwjCI3WTxUXQlcLpp3aGGnhIsLq2GWqZCVk96YUT9Q9MIgG8nvDqq5ah9v
X-Microsoft-Antispam-PRVS: <BYAPR03MB3510984FACE7D1CD15CF5ACE95760@BYAPR03MB3510.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09634B1196
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjAzTUIzNTEwOzIzOitXSVYvODljNVIzOWVJZzE2QVJNeUNKV3dS?=
 =?utf-8?B?V2RMc0o1YUdNMStGbGlhc3IyVjlpenNvTGlIaFR5OHVQczg3cWtDQXVzL1dy?=
 =?utf-8?B?c0RTaG5oOE56bElldnd6QW1kejlOUGp4WlJ4Vy93WWw5WW10bTZ6eXVOTDFR?=
 =?utf-8?B?WGZvU2lkem9sM2d3ZGdyNnRNRHNhc0pzdnU3cElKZ2pDQlRhQlZOMVlMVHoy?=
 =?utf-8?B?SGxtaVdCVlh6RFBkNXl1dVpLVndrajZQanM3R1EzK0VvUm1vcEVpdEt1YWor?=
 =?utf-8?B?Y0d2VXZ4NVlSVnhxOGFZNnB2eGlPaCs3eFM0bkJ4OWw5RzJQekU4NEJiSDAz?=
 =?utf-8?B?U2dkR25EbHM4TVUvcmhiNkdSQlBRMGNTS3FPYmZJZ0VITkxuQWtHeVBIWjVx?=
 =?utf-8?B?S21GNEluM2haWjVBZEhHVDZZdzJzdmRsUnZjV3RLbUJUM2g4S2lPdkRwWngx?=
 =?utf-8?B?RWlvV1N4UUE5Y2lLU0FkaTFtR2R4dWdLVndVS2VRYS84b1FFRXhRdzhuS2Fj?=
 =?utf-8?B?MDhTNXFxVmtvMjRxbU16SmhSTlJFZ2o2MndGME9EQkdUZ1dudUp4Rk1LTzZv?=
 =?utf-8?B?emFXczUwKzd1T0JZNzRrSmFlV1BVOGVGQzBKRGJEbnh2amxEbmlSTGlPSVph?=
 =?utf-8?B?UDdQYUJOT0JqSTlqZWlseE5wVW5BNXZoYjJ6NE1WcW5xT0NpamZ2SzFYTGtu?=
 =?utf-8?B?eUk1NDBDUTdmcmtYT25GWElqcVFUc21PTGczRWl5RkxIUE5LM2tDN2pVcTFW?=
 =?utf-8?B?UEc5alY5MHpBdjYzNHVldTV0OGFrSS91TzB5MjlRd0pmb2s2K3ZEOWNUNEVp?=
 =?utf-8?B?NUVNNmNCVmQ2Z2NnTjRPNFBrcmp6ZlJxeVVUQk5JcllubjF4STlwMHdqVnMw?=
 =?utf-8?B?My8vSnQrZmFuNHZtRkRPS1lMYXFCUXliditBSlNVOWFMczNmWlN6eStrZzB5?=
 =?utf-8?B?UnRFQWxzVmJhR0p3TFFsRXl1Z1BsczBFeHpkeEFSMCt3U0ljUVFjaHY5dGto?=
 =?utf-8?B?dVJGSmd6L1pEV251UkwzWHh5VXF0YlJDT0Q5bkdwMzdyUGlHbFNVYmtNOGw1?=
 =?utf-8?B?a0t3Q2JDVGx2VjBSNDc0cGZHRk1vVFZ2RjN3T0hZdVl0Q1hGMDA1bm5pNFNF?=
 =?utf-8?B?anI4eWJqNkY1ckhzaHdLbXhGMGlLbXFBYzR2NHhGekp4dXVoYmN5S0pTbmN3?=
 =?utf-8?B?VEZyWG11dUs2dTYzZjMvbnRVTzFqaXZZK3U1WlNGYmpTZ1hIcEZGY2hRdHFa?=
 =?utf-8?B?Z0pWeHN1a1R0WTUvVHVoVzNYdU5nRzdWY29qWk5CWVpxVGd5d1JBU1FyRy9h?=
 =?utf-8?B?NjZNdFhKbVpiVDY1UkZUZmgwN3pxZFRQMXdVMkNhTEk4NHlINUhydWkwT2Js?=
 =?utf-8?B?azFlbDRkZDYxZmRGZWtyTGZnaDRWUHdEZ2UzY1p1UndSeUVqbURlOFdldDZl?=
 =?utf-8?B?Vk1mcjF1cmYvMEFpWlhuMHAxSjY3TmRFUEdlb1dPVGV3bWJGSjZyY2NkeFVE?=
 =?utf-8?B?eVo1ZHdvZEtSWFRIRGpHdW1sb0x4bGtEdjJsQ0RzK3Z2Wmszamc3eWlxRS8y?=
 =?utf-8?B?Qlc2REFWRWl1YmZYRjlQN2NWK2R1RUdmWGtydHpyV25XNUl1SkxqckJld1gw?=
 =?utf-8?B?ZVNCSmRGSUlZYTg4YkRlVEFOc0M4LzJkV2s3c2ZlN1RMcG16RkNtczYvUXRG?=
 =?utf-8?B?VTU3cDhjTXRERjJ3ZFAzSmRyVG9CRkNOWnRQQ0VvdzEvaCtKa3phU0VTM3Av?=
 =?utf-8?B?dldCZVhCdmdkcFphRnRlUT09?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: g/7BmrwFqQUXOWUeX+KlvjU2+qdygWw84iCQfSDuLcC6MninU+DfANRicMmziA9malDKWhzrqsrMG0lD/TAZUbN81P4i7yiqsKg1YUEOgXSSlXcQ+TnLCQf5GPr7KRvW5NLbuINgeZ60AP4k/51ffwmh5AsFDc2xa4V3b+bfEg2tL0R2LD3ZxWrSq7c7/m41JwuIpfcKsd5mEGI2O6jKqs438AEfP3cA2pI/RAa7i4PLIIIWqkBM9/V5nvv24k2cNqGSaMUvZ62dt2KpuMUfeslTjPNEvX69FzekKr01fudQ7cpkvs+znLmBmXQpV7975CvkNjjBMQZYoyiZCYOSjYDCXotv4PgumNwA1FY/9g0FmXtJlLXYAqy/1q50R8el7A0IN7Ehr9Ft7rJhnpFC+kELI/EKedVGtApRQrHXaOs=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2019 07:20:02.7887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d71c836-317d-449c-427d-08d69e1652bc
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTAyLTI4IGF0IDExOjI0IC0wMzAwLCBSZW5hdG8gTHVpIEdlaCB3cm90ZToN
Cj4gDQo+IA0KPiBUaGUgYWQ3NzgwIHN1cHBvcnRzIGJvdGggdGhlIGFkNzc4eCBhbmQgYWQ3MTd4
IGZhbWlsaWVzLiBFYWNoIGNoaXAgaGFzDQo+IGEgY29ycmVzcG9uZGluZyBJRC4gVGhpcyBwYXRj
aCBwcm92aWRlcyBhIG1hc2sgZm9yIGV4dHJhY3RpbmcgSUQgdmFsdWVzDQo+IGZyb20gdGhlIHN0
YXR1cyBiaXRzIGFuZCBhbHNvIG1hY3JvcyBmb3IgdGhlIGNvcnJlY3QgdmFsdWVzIGZvciB0aGUN
Cj4gYWQ3MTcwLCBhZDcxNzEsIGFkNzc4MCBhbmQgYWQ3NzgxLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogUmVuYXRvIEx1aSBHZWggPHJlbmF0b2dlaEBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVy
cy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMgfCA4ICsrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzc4MC5jDQo+IGIvZHJpdmVycy9zdGFnaW5nL2lpby9h
ZGMvYWQ3NzgwLmMNCj4gaW5kZXggNTZjNDllMjhmNDMyLi5hZDc2MTdhM2ExNDEgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzc4MC5jDQo+ICsrKyBiL2RyaXZlcnMv
c3RhZ2luZy9paW8vYWRjL2FkNzc4MC5jDQo+IEBAIC0yNiwxMCArMjYsMTQgQEANCj4gICNkZWZp
bmUgQUQ3NzgwX1JEWSAgICAgICAgICAgICBCSVQoNykNCj4gICNkZWZpbmUgQUQ3NzgwX0ZJTFRF
UiAgICAgICAgICBCSVQoNikNCj4gICNkZWZpbmUgQUQ3NzgwX0VSUiAgICAgICAgICAgICBCSVQo
NSkNCj4gLSNkZWZpbmUgQUQ3NzgwX0lEMSAgICAgICAgICAgICBCSVQoNCkNCj4gLSNkZWZpbmUg
QUQ3NzgwX0lEMCAgICAgICAgICAgICBCSVQoMykNCj4gICNkZWZpbmUgQUQ3NzgwX0dBSU4gICAg
ICAgICAgICBCSVQoMikNCj4gDQo+ICsjZGVmaW5lIEFENzE3MF9JRCAgICAgICAgICAgICAgMA0K
PiArI2RlZmluZSBBRDcxNzFfSUQgICAgICAgICAgICAgIDENCj4gKyNkZWZpbmUgQUQ3NzgwX0lE
ICAgICAgICAgICAgICAxDQo+ICsjZGVmaW5lIEFENzc4MV9JRCAgICAgICAgICAgICAgMA0KPiAr
DQo+ICsjZGVmaW5lIEFENzc4MF9JRF9NQVNLICAgICAgICAgKEJJVCgzKSB8IEJJVCg0KSkNCg0K
VGhpcyBhbHNvIGRvZXNuJ3QgaGF2ZSBhbnkgZnVuY3Rpb25hbGl0eSBjaGFuZ2UuDQpUaGUgQUQ3
MTcwX0lELCBBRDcxNzFfSUQsIEFENzc4MF9JRCAmIEFENzc4MV9JRCBJRHMgYXJlIGFsc28gdW51
c2VkIChtYXliZQ0KaW4gYSBsYXRlciBwYXRjaCB0aGV5IGFyZSA/KS4NCg0KSSB3b3VsZCBhbHNv
IGxlYXZlIHRoZSBBRDc3ODBfSUQxICYgQUQ3NzgwX0lEMCBkZWZpbml0aW9ucyBpbiBwbGFjZSwg
c2luY2UNCnRoZXkncmUgZWFzaWVyIG1hdGNoZWQgd2l0aCB0aGUgZGF0YXNoZWV0Lg0KDQo+IA0K
PiAgI2RlZmluZSBBRDc3ODBfUEFUVEVSTl9HT09EICAgIDENCj4gICNkZWZpbmUgQUQ3NzgwX1BB
VFRFUk5fTUFTSyAgICBHRU5NQVNLKDEsIDApDQo+IC0tDQo+IDIuMjEuMA0KPiANCg==
