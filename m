Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C289AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEE9218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="GXWZwXAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733080AbfCAIfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 03:35:32 -0500
Received: from mail-eopbgr720052.outbound.protection.outlook.com ([40.107.72.52]:12416
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732888AbfCAIfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 03:35:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYaJmvbcnFWM/inDeSSCTGaAF/o2EboTiAnFlZ/l4es=;
 b=GXWZwXAVWGuNKQDIPX5FnFUdOVEYp5m7h6X7CSmHP1F9lmq208oY0vJ83HKvseaJ7hIetzWaMg9tKwJTUaDzhBj4Q18aheGH+hgeYCKEHtMeuT/ji4hTTAsWM8U/307V1TLFVzs5B8DYQ4tKVnl/nggpfxxW7TLd4Es1P2ktWFo=
Received: from DM6PR03CA0050.namprd03.prod.outlook.com (2603:10b6:5:100::27)
 by BYAPR03MB3750.namprd03.prod.outlook.com (2603:10b6:a03:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.20; Fri, 1 Mar
 2019 08:35:20 +0000
Received: from SN1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by DM6PR03CA0050.outlook.office365.com
 (2603:10b6:5:100::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.18 via Frontend
 Transport; Fri, 1 Mar 2019 08:35:19 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT014.mail.protection.outlook.com (10.152.72.106) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Fri, 1 Mar 2019 08:35:18 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x218ZHTB011097
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 1 Mar 2019 00:35:17 -0800
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Fri, 1 Mar 2019 03:35:17 -0500
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
Subject: Re: [PATCH v4 0/9] staging: iio: ad7780: move out of staging
Thread-Topic: [PATCH v4 0/9] staging: iio: ad7780: move out of staging
Thread-Index: AQHUz3EmxReka3xzxUG261UTvKFWTKX2yFKA
Date:   Fri, 1 Mar 2019 08:35:17 +0000
Message-ID: <72a54cd5f58aeb9507b95b7e33ca3d9a38c853e9.camel@analog.com>
References: <cover.1551358569.git.renatogeh@gmail.com>
In-Reply-To: <cover.1551358569.git.renatogeh@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5442297840C98448AB8000052EEEA3FE@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(2980300002)(199004)(189003)(54534003)(4326008)(6116002)(3846002)(54906003)(14454004)(2501003)(6246003)(76176011)(7696005)(2486003)(23676004)(106466001)(110136005)(50466002)(2906002)(5660300002)(316002)(36756003)(118296001)(86362001)(446003)(72206003)(7416002)(106002)(14444005)(426003)(476003)(2201001)(229853002)(8676002)(486006)(336012)(436003)(8936002)(126002)(2616005)(47776003)(7636002)(246002)(102836004)(11346002)(305945005)(7736002)(186003)(26005)(356004)(478600001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3750;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16ee60a8-536b-41c6-3d5c-08d69e20d670
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB3750;
X-MS-TrafficTypeDiagnostic: BYAPR03MB3750:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3750;20:W3zla6I0Ph3PfyaK0/vu34XEZhFMz/WQB3IGde5fHZ2Wj2RiFbvfQDJ+RKtzQK8EfTc3QlM4NiYy+PWGnLywM0Z6EFN9xTqX5eXCJpwjqdbDFNaD0zD9Xye5GQPYxHmrp+gQ2brEP82f2nX18XJp+dPFv6TkdhYxJdP+hVG6WymcWhecZJaa1b1fop3LJoR/TQG2x7OGsHuMiNcGk0u8erp8pC3kR8AEuqSQzeUUVmIedTueLiG3tdP3KwHluIU7dedijxB59kr9OzJB64XcVh2UbxEzaJ1yc09tTgGEuilEBOgkW5tL3UUVnYdpzuz++xgBR6Ij7zhDK3Qlai9bcTCK1pVISw0LndGkzESApU8Dh9JxXjQAaYxB5gLclkK6cnuGo9MBXwz36VN4NV7bqicyxuT5hVk3d9KGHsTE2CPY6eJ+j+2uZhAvdM8K9MMp4pUWmP22bfE8KFWmY9RlWokPokJtuQ4FKT2WJ5z8MZJrnSq5HrDY+JVIToI0pxwP
X-Microsoft-Antispam-PRVS: <BYAPR03MB37503A791B4DF4D34A82883795760@BYAPR03MB3750.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09634B1196
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjAzTUIzNzUwOzIzOmRzbGhwZW94ZVIvWUI1SlR2bGp3RXpFdG9S?=
 =?utf-8?B?Qk1qN1BEQUpkNWllZzVEdEdKazRDL00yMnFpMnMzcnVQeGwxUHhkeWlpM0FU?=
 =?utf-8?B?K2FLVjZuU1YvNWt1MWlqdno3cHBpV0ZhaU1pM1JSSkRaSnR0aVpMVXZLTkcr?=
 =?utf-8?B?UEFWYjRkKzJZZHNVeXBhbzZpK3JTd2dqU3hWdFZqVDh5TkhzZG1ZMkJ5TzJx?=
 =?utf-8?B?djdVR3pLeEVzNUUxdnhBZ3NnTTNwWEIxeHBoZ1hzN2czVmtoS3Q5Q3BnVWtH?=
 =?utf-8?B?YmhmOXptMk4zbkhaZWNKdktzaXVZZEhUNm5HQ3pmMDVyLy9BRWtaVHJBR3d1?=
 =?utf-8?B?UTJvN1ppNXluNjFzNGdkZmMwOVNYVXlYWE93SkVRSHl5YjlpbHhpbUFlYkhB?=
 =?utf-8?B?bmtjaFB3cFVWRHpZeGpwUE5hN001OHFEdDlFZmtudzdzdUM5ekRoN3c4dFoy?=
 =?utf-8?B?V1h6YUU5RU1mWTN5QnhJcnZJWVBxaStCMk1MYmRxY3U3aGxhdnIxbHpnbElX?=
 =?utf-8?B?TTlDcG9PY0xqTk44dkNQN25SakVqeUQ5TnNDa2JWUC82MjZodVZPK2xNQUFv?=
 =?utf-8?B?MGtoMkkrNkxMaExHaENpZVNwT2l5QU9Jc3NNbFZ3QjFZUlJMaDFWK1NJQmR1?=
 =?utf-8?B?Q0RQMVpCWHpyWktmaFNGbUd4SWpjbmsrLzhCVzA0dkl3K0tMa1d5aGU4ME1t?=
 =?utf-8?B?R1V4aitqcXVGMWpuM3I0VER2VDhvelMzYUhpTVlkMHZacDdDanZ1TGpEZ0VQ?=
 =?utf-8?B?ck5NRHVoVkRPdUk2Z3pmOGZlaVp3cjNaUUwzb1VyWFpFQzRobmhzREZCaXh4?=
 =?utf-8?B?UmNha3lKeEQ5UGlSTXB6c09PbnBnZ2x2VTVXb25LZ2taeWJidlV1djdOSmxG?=
 =?utf-8?B?MUdUMEs0ZExKdjVucGlNcUMybGJkWURYS3p1ZUVhdUhKandYMW1GSlhPR25v?=
 =?utf-8?B?SWZFbmRPRmN0SXlCRnliTW90MGNnM2pQUG9KeXpNbVRQbWlpYm1LN1VwYlRL?=
 =?utf-8?B?TVNJSjV2S3h4VS9IQktWbkFKcDV1L09EMmJmQWl2UnpHSDJoWU1veGVwZkhO?=
 =?utf-8?B?RjA2MnNOakNNMllyS0RPeFk1YTByR0lyZEQwMlhDYVZSbkVrTEJSTDZ1ZVpw?=
 =?utf-8?B?eHVjbkJJbDdCbzhTWEo3UHZpOE9RNVRPMjd4NzNGVERnZDJaTVlLemhaeWVp?=
 =?utf-8?B?Vk1tSU14Nms1cWdwQ1dwNVBuYkxuT2hHNmJUdmg0cWpnakJSeWFkTEtsUk5j?=
 =?utf-8?B?MjZZMFFURFRlaEhqbDllNS9kejNIR0tHWDZncU5wYjZqTmM0ZEFubUdCdFN2?=
 =?utf-8?B?QlBRVUx4d0hIU05qL1FQVWhoMGZQamZZQlFmSXVVL0tmVEY0RFBoWFgrUTdS?=
 =?utf-8?B?eVhrRlpEL3JqNnhPeDZzZDg2VWJSeGVRc01zU2lBWXBBU1VndUlTR3FqR3R0?=
 =?utf-8?B?cGY5OUFXNy9tVW9MN2FUVDJQeW1yVWRMcUlNU3hyRUVDVHJsNDFHUDRCeXYv?=
 =?utf-8?B?L3RnVklQMWdnbGdCb1NnRTZwOFBlc29ncDhQTFUwRU96bjg2eHk0WmRCaVBj?=
 =?utf-8?B?c09CWmgwMlV2c1N2Q3FweUdNU2IxZUZ0ektMQlpTRDVFRkgrQVVEWkxEZFY4?=
 =?utf-8?B?blpNMjVzNytDbm1VVGhLa3A3MnZyT1p4K1QwdVVQYXd6Y3gxaFpxWVFjTFI1?=
 =?utf-8?Q?1qR4wnav8eq5/LDFwU=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: kv2MGnWIJrjp6hfEKrw+7nFKZhzHiEiZuZnbzO4dN+SAeBUSWwMZ6yuTEHZL/521g/KvudjzBlBJSf/nGp2jxdqaSz2Z79LJxWzRpJ7qYglAVnG3UOyIrkGTHPlIPvr4Md1uUSR7tUbl4mEeCts/yckV6/KoPtL2d4Xw4DhEfv7gT1qoJuDvS28erOax6/MRDALviMvouZ7hUXQ/BbutoJg5a7o11tHcn/awKJthwJF2KRTaWCFu52i/xy2Gy7/JzNzBnw+thb+VyFWyuXJ1dHhOGbVVCI37BslAQgGYX1hi95mpe9RfDcgPWMEIbyRW8W2SMNYC2pfruWE1nWYTn2xQsoCPPGMECGM/z+TvJ+/Znor1tnbV4WvHVS++gwJUDJwMlgKm6rMeoVCQz/+vTMUXdFiaARv69AEMlFTO0jQ=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2019 08:35:18.7171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ee60a8-536b-41c6-3d5c-08d69e20d670
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3750
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTAyLTI4IGF0IDExOjIzIC0wMzAwLCBSZW5hdG8gTHVpIEdlaCB3cm90ZToN
Cj4gDQoNClRoZSBwYXRjaC1zZXJpZXMgaXMgYSBiaXQgYmlnLg0KSSBndWVzcyB0aGF0IHRoZSBp
bnRlbnQgaXMgdG8gbW92ZSB0aGlzIG91dC1vZi1zdGFnaW5nLCBidXQgdmFyaW91cyBwYXRjaGVz
DQphcmUgaG9sZGluZyB0aGlzIGluIGl0J3MgcGxhY2UuDQpGb3IgcGF0Y2ggc2VyaWVzIGFib3Zl
IGEgY2VydGFpbiBzaXplLCB5b3UgY291bGQgZ2V0IG1hbnkgcmUtc3BpbnMNCltWMiwzLDQuLi4g
c28gb25dLg0KDQpZb3UgY291bGQgc2VuZCBzb21lIG9mIHRoZSBjaGFuZ2VzIGFzIGluZGl2aWR1
YWwgcGF0Y2hlcywgb3IgZ3JvdXAgdGhlbSBpbg0Kc2VyaWVzIG9mIDEsMiBvciAzIHBhdGNoZXMu
IFRoYXQgd2F5LCB5b3UgInBhcmFsbGVsaXplIiBwYXRjaCBzZW5kaW5nLCBhbmQNCndoZW4geW91
IGdldCByZXZpZXdzIG9uIGVhY2ggcGF0Y2gsIHlvdSBjYW4gcmUtc3BpbiB0aGVtIGluZGl2aWR1
YWxseS4NCllvdSdsbCBmaW5kIG92ZXIgdGltZSB0aGF0IGNlcnRhaW4gcGF0Y2hlcyBnZXQgYWNj
ZXB0ZWQgb24gVjEsIG90aGVycyBvbiBWMg0KYW5kIHNvbWUgb24gVjcgWyBob3BlZnVsbHksIHRo
ZXJlIGlzbid0IGFueSBmcnVzdHJhdGlvbiBhdCB0aGF0IHBvaW50IF0uDQoNCldlbGwsIHRoaXMg
aXMgYSB0ZWNobmlxdWUgSSB1c2UgdG8gZGlzdHJpYnV0ZSBzb21lIG9mIG15IHVwc3RyZWFtLXBh
dGNoLQ0Kd29yaywgc28gdGhhdCBJIGNhbiBzd2l0Y2ggZWFzaWVyIGJldHdlZW4gaW50ZXJuYWwt
d29yayAmIHVwc3RyZWFtaW5nLXdvcmsuDQoNCkNvbWluZyBiYWNrIHRvIHRoaXMgcGF0Y2gtc2Vy
aWVzLg0KTXkgZ2VuZXJhbCBpbnB1dCwgaXMgdGhhdCB0aGUgcGF0Y2hlcyBhcmUgZmluZSBvdmVy
LWFsbDsgc29tZSBhcmUganVzdA0KY29zbWV0aWNzL25vaXNlL2EtZGlmZmVyZW50LXdheS1vZi1k
b2luZy10aGluZ3MtZm9yLXRoaXMtZHJpdmVyLCBhbmQgdGhvc2UNCnVzdWFsbHkgY2FuIGJlIGxl
ZnQgdG8gcHJlZmVyZW5jZSBbb2YgdGhlIG1haW50YWluZXIgdXN1YWxseV0uDQoNCkkgZG8gc3Vn
Z2VzdCB0byBub3QgaHVycnkgd2hlbiByZS1zcGlubmluZyBwYXRjaGVzLCBhbmQgbm90IGNoYW5n
ZSB0b28gbXVjaA0KdGhlIG51bWJlciBvZiBwYXRjaGVzIGluIGEgbmV3IHNlcmllcy4gVGhhdCBj
YW4gY29tcGxpY2F0ZSB0aGluZ3MNCnNvbWV0aW1lcy4gQnV0LCBpZiBkb2luZyBzbWFsbCBwYXRj
aC1zZXJpZXMgb3IgaW5kaXZpZHVhbCBwYXRjaGVzLCB5b3UNCndvbid0IGhhdmUgdGhpcyBwcm9i
bGVtIHRvbyBtdWNoLg0KDQpUaGFua3MNCkFsZXgNCg0KPiANCj4gVGhpcyBzZXJpZXMgb2YgcGF0
Y2hlcyBjb250YWlucyB0aGUgZm9sbG93aW5nOg0KPiAgLSBBZGRzIHVzZXIgaW5wdXQgZm9yIHRo
ZSAnZ2FpbicgYW5kICdmaWx0ZXInIEdQSU8gcGlucyBmb3IgdGhlIGFkNzc4eA0KPiAgICBmYW1p
bHkgY2hpcHM7DQo+ICAtIEZpbHRlciByZWFkaW5nIGZvciB0aGUgYWQ3Nzh4Ow0KPiAgLSBTZXRz
IHBhdHRlcm4gbWFjcm8gdmFsdWVzIGFuZCBtYXNrIGZvciBQQVRURVJOIHN0YXR1cyBiaXRzOw0K
PiAgLSBBZGRzIElEIHZhbHVlcyBmb3IgdGhlIGFkNzE3MCwgYWQ3MTcxLCBhZDc3ODAgYW5kIGFk
Nzc4MSBmb3IgSUQNCj4gICAgc3RhdHVzIGJpdHMgY2hlY2tpbmc7DQo+ICAtIE1vdmVzIHJlZ3Vs
YXRvciBpbml0aWFsaXphdGlvbiB0byBhZnRlciBHUElPIGluaXQgdG8gbWFpbnRhaW4NCj4gICAg
Y29uc2lzdGVuY3kgYmV0d2VlbiBwcm9iZSBhbmQgcmVtb3ZlOw0KPiAgLSBDb3B5cmlnaHQgZWRp
dHMsIGFkZGluZyBTUERYIGlkZW50aWZpZXIgYW5kIG5ldyBjb3B5cmlnaHQgaG9sZGVyOw0KPiAg
LSBNb3ZlcyB0aGUgYWQ3NzgwIGRyaXZlciBvdXQgb2Ygc3RhZ2luZyB0byB0aGUgbWFpbmxpbmU7
DQo+ICAtIEFkZHMgZGV2aWNlIHRyZWUgYmluZGluZyBmb3IgdGhlIGFkNzc4MCBkcml2ZXIuDQo+
IA0KPiBSZW5hdG8gTHVpIEdlaCAoOSk6DQo+ICAgc3RhZ2luZzogaWlvOiBhZDc3ODA6IGFkZCBn
YWluICYgZmlsdGVyIGdwaW8gc3VwcG9ydA0KPiAgIHN0YWdpbmc6IGlpbzogYWQ3NzgwOiBhZGQg
ZmlsdGVyIHJlYWRpbmcgdG8gYWQ3Nzh4DQo+ICAgc3RhZ2luZzogaWlvOiBhZDc3ODA6IHNldCBw
YXR0ZXJuIHZhbHVlcyBhbmQgbWFza3MgZGlyZWN0bHkNCj4gICBzdGFnaW5nOmlpbzphZDc3ODA6
IGFkZCBjaGlwIElEIHZhbHVlcyBhbmQgbWFzaw0KPiAgIHN0YWdpbmc6IGlpbzogYWQ3NzgwOiBt
b3ZlIHJlZ3VsYXRvciB0byBhZnRlciBHUElPIGluaXQNCj4gICBzdGFnaW5nOiBpaW86IGFkNzc4
MDogYWRkIFNQRFggaWRlbnRpZmllcg0KPiAgIHN0YWdpbmc6IGlpbzogYWQ3NzgwOiBhZGQgbmV3
IGNvcHlyaWdodCBob2xkZXINCj4gICBzdGFnaW5nOiBpaW86IGFkNzc4MDogbW92aW5nIGFkNzc4
MCBvdXQgb2Ygc3RhZ2luZw0KPiAgIHN0YWdpbmc6IGlpbzogYWQ3NzgwOiBhZGQgZGV2aWNlIHRy
ZWUgYmluZGluZw0KPiANCj4gQ2hhbmdlbG9nOg0KPiAqdjMNCj4gIC0gU1BEWCBhbmQgcmVndWxh
dG9yIGluaXQgYXMgcGF0Y2hlcw0KPiAgLSBSZW5hbWVkIGZpbHRlciB0byBvZHIgYW5kIGFkNzc4
eF9maWx0ZXIgdG8gYWQ3Nzh4X29kcl9hdmFpbA0KPiAgLSBSZW1vdmVkIHVubmVjZXNzYXJ5IHJl
Z3VsYXRvciBkaXNhYmxpbmcNCj4gIC0gUmVtb3ZlZCB1bm5lY2Vzc2FyeSBBRF9TRF9DSEFOTkVM
IG1hY3JvDQo+ICAtIENoYW5nZWQgdW5zaWduZWQgaW50IHRvIHVuc2lnbmVkIGxvbmcgbG9uZyB0
byBhdm9pZCBvdmVyZmxvdw0KPiAqdjQNCj4gIC0gU3BsaXQgZ2FpbiAmIGZpbHRlciBwYXRjaCBp
bnRvIHR3bywgd2l0aCB0aGUgbmV3IGNvbW1pdCBhZGRpbmcgb25seQ0KPiAgICBmaWx0ZXIgcmVh
ZGluZw0KPiAgLSBDaGFuZ2VkIHBhdHRlcm4gdmFsdWVzIHRvIGRpcmVjdCB2YWx1ZXMsIGFuZCBh
ZGRlZCBwYXR0ZXJuIG1hc2sNCj4gIC0gQWRkZWQgSUQgdmFsdWVzIGFuZCBtYXNrDQo+ICAtIEFk
ZGVkIG5ldyBjb3B5cmlnaHQgaG9sZGVyDQo+ICAtIEFkZGVkIGRldmljZSB0cmVlIGJpbmRpbmcg
dG8gdGhlIGFkNzc4MCBkcml2ZXINCj4gDQo+ICAuLi4vYmluZGluZ3MvaWlvL2FkYy9hZGksYWQ3
NzgwLnR4dCAgICAgICAgICAgfCAgNDggKysrDQo+ICBkcml2ZXJzL2lpby9hZGMvS2NvbmZpZyAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMTIgKw0KPiAgZHJpdmVycy9paW8vYWRjL01ha2VmaWxl
ICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gIGRyaXZlcnMvaWlvL2FkYy9hZDc3ODAu
YyAgICAgICAgICAgICAgICAgICAgICB8IDM2NSArKysrKysrKysrKysrKysrKysNCj4gIGRyaXZl
cnMvc3RhZ2luZy9paW8vYWRjL0tjb25maWcgICAgICAgICAgICAgICB8ICAxMyAtDQo+ICBkcml2
ZXJzL3N0YWdpbmcvaWlvL2FkYy9NYWtlZmlsZSAgICAgICAgICAgICAgfCAgIDEgLQ0KPiAgZHJp
dmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMgICAgICAgICAgICAgIHwgMjc3IC0tLS0tLS0t
LS0tLS0NCj4gIDcgZmlsZXMgY2hhbmdlZCwgNDI2IGluc2VydGlvbnMoKyksIDI5MSBkZWxldGlv
bnMoLSkNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvaWlvL2FkYy9hZGksYWQ3NzgwLnR4dA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvaWlvL2FkYy9hZDc3ODAuYw0KPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc3Rh
Z2luZy9paW8vYWRjL2FkNzc4MC5jDQo+IA0KPiAtLQ0KPiAyLjIxLjANCj4gDQo=
