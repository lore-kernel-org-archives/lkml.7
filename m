Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C9CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA64218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="NnhJVAsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbfCAG7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:59:54 -0500
Received: from mail-eopbgr700061.outbound.protection.outlook.com ([40.107.70.61]:40876
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725982AbfCAG7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 01:59:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlS65dSdBzBcTKJnofxF/0bj7EDwBBrO7kv8GbhFRgY=;
 b=NnhJVAsNFJC1Xp3In1wCNtn1ClD5woogZw3ueTz6azhe6vMZnEpF7KKzjtzn2p3O5X/qM2pkLLhqXhca79AqJqWZc6LC5JaPb3pZFu6LN7N/YfgWl85pLsjMNlVGGsWkCzBfL/junFFA0TbUJHh9E09iInQjdkaK0vh/hLaS8J4=
Received: from CY4PR03CA0022.namprd03.prod.outlook.com (2603:10b6:903:33::32)
 by BN6PR03MB3058.namprd03.prod.outlook.com (2603:10b6:405:44::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1665.16; Fri, 1 Mar
 2019 06:59:49 +0000
Received: from SN1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by CY4PR03CA0022.outlook.office365.com
 (2603:10b6:903:33::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.16 via Frontend
 Transport; Fri, 1 Mar 2019 06:59:49 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT063.mail.protection.outlook.com (10.152.72.213) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Fri, 1 Mar 2019 06:59:48 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x216xlFn004848
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 28 Feb 2019 22:59:47 -0800
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Fri, 1 Mar 2019 01:59:47 -0500
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
Subject: Re: [PATCH v4 2/9] staging: iio: ad7780: add filter reading to
 ad778x
Thread-Topic: [PATCH v4 2/9] staging: iio: ad7780: add filter reading to
 ad778x
Thread-Index: AQHUz3FMBrjpRb6JxEKCsh3hg21SVaX2raOA
Date:   Fri, 1 Mar 2019 06:59:46 +0000
Message-ID: <ec194bd243af4f6201e857fd333c36a881ac2c4a.camel@analog.com>
References: <cover.1551358569.git.renatogeh@gmail.com>
         <a44c3316553c3cab4378d7e31c2d1914bf558c62.1551358569.git.renatogeh@gmail.com>
In-Reply-To: <a44c3316553c3cab4378d7e31c2d1914bf558c62.1551358569.git.renatogeh@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1095002B7C7D14CA9274FABBC1DCD61@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(2980300002)(189003)(199004)(2201001)(86362001)(4326008)(36756003)(23676004)(7416002)(6246003)(2486003)(436003)(8676002)(426003)(486006)(446003)(118296001)(126002)(356004)(2616005)(11346002)(476003)(229853002)(6116002)(3846002)(26005)(186003)(102836004)(50466002)(2501003)(336012)(106466001)(47776003)(8936002)(316002)(14454004)(7636002)(5660300002)(305945005)(478600001)(2906002)(7696005)(246002)(72206003)(106002)(110136005)(54906003)(7736002)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3058;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef834ab2-ef66-491b-0e3a-08d69e137ef8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB3058;
X-MS-TrafficTypeDiagnostic: BN6PR03MB3058:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3058;20:Kux/oDN9gFycEPBHGgY7yEI129dKW3BQGw7O/aAvh8tl17A8/KDI/vwxaOMtI6UKo7WQRBn4Hr1EaLqmOwyuN2umTmEwKz+vsVyma7P4Bd4fyKO49IDZDZRapmrOOjx2mvLVN1dDY7QBal7S2n4UX6vXlXHQ6AaFUnPZMGr7HlBMWxNkJF42RzheMCpB0DFkLLoDeitORnjDFl9MIFdzd0StFBiRkxjP5R4DCC20Ap5QcdYK6Phb0Feq7/RjwLHv2KTxvG1OtxhdxLkAWXiIYhHoRLWT53M60FXt6iiFwG/2br4htw8fHlKWNwJ/3pPxHxiAlY5Cdaaz3/bE5si6GuYb+XoDBizz1tcTFzRGVmhbXVtjt/ED+TzlzKlRVoUdHXTgBmTgwMvV518c+Sv8lZkJp1MaiiYqEEJn2urxXj59ia1rQ4b8oFymZTJA1VfZAkX5uWTgn4j6o0kA2nRbVsH1FFW1+G9aNTRaNQgQF+BudT/4cKClhOnRULyX6mWi
X-Microsoft-Antispam-PRVS: <BN6PR03MB305806D941CE2C80E792253295760@BN6PR03MB3058.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09634B1196
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjAzTUIzMDU4OzIzOkZBQVkyZmhwbHl6NFNxLy9MclJMb1NOekJC?=
 =?utf-8?B?Y3loSzFSeHFVcmt1UGhuQk1XQy9JZkN2UjNQaEpYZXk2TjVhWHAwbXdYeTZD?=
 =?utf-8?B?bzlWQ0xQYk0wUmdtL1VHNlNJaVJseFR1ZmZJL3lPRzNwQzFNcW5pUE0rT003?=
 =?utf-8?B?S1hOVGhyeUV4QWMyNG5zRm5vUWhESlVkNi9DT3VHSW42bm5ySm14T0FLZUVm?=
 =?utf-8?B?L0N6Z2pzUElsYVk0Y0pOL05HTUtqU29MUmhoYVVGaTkvMmJWampJaHdpOGFQ?=
 =?utf-8?B?S0VTQmpYbUprcFUxNzh5bmUrY2l2Z0hRNnE1Mm1kcEVxdkpRT3BubjVRbUFn?=
 =?utf-8?B?T0R6WG9FMkNFMkM5MzR0SndmbEtvc0dFN3FtT29FSlByVU54cnJjeXVhVGlk?=
 =?utf-8?B?ektpUUowK0hRdSsveTQyU2FpVUNQSDB5Si9JNlB1KzhTMzY5QjN2RzhmbTJE?=
 =?utf-8?B?Wld6YnRYOXpHd25qYU0rTnhpYUJ4OVRoRWsrYkkzL3Y4TzNHV1J3eHNmeTBK?=
 =?utf-8?B?NE1nanZGcmdvSUNiWUJLbmxVWkFrQ2M5UjR1TlRtOEdVZ0ZhVEdSclBiZ0c4?=
 =?utf-8?B?OUVLOHQxZlBySE4zWGRlQUxJVGZnaFhGdGFSeU8rbFJRenZ2Ym9rWnVpcFdP?=
 =?utf-8?B?eThVYU8zWEIrYVI5RlQ0b3RvQTYzNFVrOVJLaktoSDdGVFdmWndyKzhyWFFk?=
 =?utf-8?B?Y2wxZk9CZ3ZuUW9ScW5IaGJhZzF6UEROSC9KQnlTSGRGQndKS2Z0K01Rdktk?=
 =?utf-8?B?MjEyRE82WHQ1K2RhZWkrT3gzdC9LVENMYjZjcTR0Zm5xMUhUNE1BMTB0NWNN?=
 =?utf-8?B?bEo4dUFjcU9UNzZndkV0bE1aMUFrdy9nbVVSS0RPSisyUnNWUzZGZFo5eXE3?=
 =?utf-8?B?TDg0cStVTDFJM1ByeGJVMWxXc0hPTGwzTG9PTHI3N0tENEtQTUlTRnFzMnhB?=
 =?utf-8?B?Z3BvVHJCWmNFeDAvOE9NMEpFbkdWeFp4b0dldGNwdE01NmxtWUc5NDFya0xz?=
 =?utf-8?B?VWJXOGVMWUJSbjBpQmRpMmxZd1JTakYrc3h6Mk83ZzBzVEhnSXBuSUhXU2pC?=
 =?utf-8?B?VmNpTHlDTWFxVjlEMkw3amZhSWxteTloeVp3cnFPNHFMaUwwZlJUNGdDdE0x?=
 =?utf-8?B?NlhyMEE1TldTd1NUOW1kd0I4YmRRSlZPMWZCcVk2LzZZVVdkMmNRbGJQODQr?=
 =?utf-8?B?L0JmbTJISUdNV3orYzhWY21sNlZIaXRZZ0VWTEpyRDhQRy9uNHI0N05jVzdH?=
 =?utf-8?B?ZkVNN0hzZ1NGRFNlTWp3UU5sV0FYT1YxVUFwVkc3TW43NXBsazA1bFg2MXJX?=
 =?utf-8?B?c1FCaGhmMkVUVGxGUzFmbEJGZDgyOGlocFJRaFcyQ1JiTzNJRkJUTFhUUkdh?=
 =?utf-8?B?cEFFbUxTcm5BVy9ub0M4emJ1Y1RlN1JnY0RWaVNsYzhBa3BlaE4xWnFDb1Fk?=
 =?utf-8?B?a1loVDNNUWtFYkltV0lndFdtYzRjVDFjUE5QNFBuWFdiQW5RaVhla1N6cVVT?=
 =?utf-8?B?bE9UckVKMFFzUjFwcEtiSm5TdlZOV3J0eXlyV3h5eHpvdzZsS25NcWJQRlpr?=
 =?utf-8?B?dndnYVdiZG9LVVl0dmdvL3RYOW5ManhmOWV4SUFhelFhQm5qQ2pjL29PT0xJ?=
 =?utf-8?Q?DG7o4TEpGNogdkt07ATX?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: uEqmxGsLIZBRb8VeC31Z4X2cC4I2qDPl6MFG6RJTIN5hRBYJyojPw639+LGeZIpH0+5wfvQ9KCWUlocPMZe5kuJNLuYYDdBFqHuf7d8RStVOaye8AQUdz6l9nk7ULhRu/PhcyeyIs0tSF4KTWVlfnioZ7ZFVW9mmptNAYg++hdbZxCAxYRIDWQ5ew5pASeoO4MVSFPU6lE2qCax3AZnlR56MbXluH7EdwkRp0Gm4wsOdAwT5Y+zE01S0AfmGKI7jYFam9DWUhodpe78yB7Zz23lQ4G+V/1WAMebOzTRAgvSEIcr4Q7ULfg5KZDCpgMFLPyEXeuVlFpzzKzRSghyO+Z23h6uTHA1PDTRJklWcSCDQaLMpQGsvZq2QdxSgaGvd9Pvq/WQqUK/rG6Vnib2zgvtX/ffAnlQEW2/kJqpaay8=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2019 06:59:48.5208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef834ab2-ef66-491b-0e3a-08d69e137ef8
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTAyLTI4IGF0IDExOjI0IC0wMzAwLCBSZW5hdG8gTHVpIEdlaCB3cm90ZToN
Cj4gDQo+IA0KPiBUaGlzIHBhdGNoIGFkZHMgdGhlIG5ldyBmZWF0dXJlIG9mIHJlYWRpbmcgdGhl
IGZpbHRlciBvZHIgdmFsdWUgZm9yDQo+IGFkNzc4eCBjaGlwcy4gVGhpcyB2YWx1ZSBpcyBzdG9y
ZWQgaW4gdGhlIGNoaXAncyBzdGF0ZSBzdHJ1Y3Qgd2hlbmV2ZXIgYQ0KPiByZWFkIG9yIHdyaXRl
IGNhbGwgaXMgcGVyZm9ybWVkIG9uIHRoZSBjaGlwJ3MgZHJpdmVyLg0KPiANCj4gVGhpcyBmZWF0
dXJlIHJlcXVpcmVzIHNoYXJpbmcgU0FNUF9GUkVRLiBTaW5jZSB0aGUgYWQ3MTd4IGRvZXMgbm90
IGhhdmUNCj4gYSBmaWx0ZXIgb3B0aW9uLCB0aGUgZHJpdmVyIG9ubHkgc2hhcmVzIHRoZSByZWxl
dmFudCBpbmZvIG1hc2sgZm9yIHRoZQ0KPiBhZDc3OHggZmFtaWx5Lg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogUmVuYXRvIEx1aSBHZWggPHJlbmF0b2dlaEBnbWFpbC5jb20+DQo+IC0tLQ0KPiBDaGFu
Z2VzIGluIHY0Og0KPiAgLSBBcyBtZW50aW9uZWQgaW4gdGhlIHByZXZpb3VzIHBhdGNoLCB0aGlz
IHdhcyBvcmlnaW5hbGx5IGFzIHBhcnQgb2YNCj4gICAgdGhlICdhZGQgZ2FpbiAmIGZpbHRlciBn
cGlvIHN1cHBvcnQnIHBhdGNoDQo+IA0KDQpUaGlzIG5lZWRzIHRoZSAgYWQ3Nzh4X29kcl9hdmFp
bFsyXSBhcnJheSB0byBiZSBtb3ZlZCB0byB0aGlzIHBhdGNoLg0KT3RoZXJ3aXNlIGZyb20gd2hh
dCBJIGNhbiB0ZWxsLCB0aGlzIGxvb2tzIGdvb2QuDQoNCj4gIGRyaXZlcnMvc3RhZ2luZy9paW8v
YWRjL2FkNzc4MC5jIHwgMTIgKysrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3N0
YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiBiL2RyaXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzc4
MC5jDQo+IGluZGV4IDg3ZmJjZjUxMGQ0NS4uN2E2OGU5MGRkZjE0IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiArKysgYi9kcml2ZXJzL3N0YWdpbmcv
aWlvL2FkYy9hZDc3ODAuYw0KPiBAQCAtNTksNiArNTksNyBAQCBzdHJ1Y3QgYWQ3NzgwX3N0YXRl
IHsNCj4gICAgICAgICBzdHJ1Y3QgZ3Bpb19kZXNjICAgICAgICAgICAgICAgICpnYWluX2dwaW87
DQo+ICAgICAgICAgc3RydWN0IGdwaW9fZGVzYyAgICAgICAgICAgICAgICAqZmlsdGVyX2dwaW87
DQo+ICAgICAgICAgdW5zaWduZWQgaW50ICAgICAgICAgICAgICAgICAgICBnYWluOw0KPiArICAg
ICAgIHVuc2lnbmVkIGludCAgICAgICAgICAgICAgICAgICAgb2RyOw0KPiAgICAgICAgIHVuc2ln
bmVkIGludCAgICAgICAgICAgICAgICAgICAgaW50X3ZyZWZfbXY7DQo+IA0KPiAgICAgICAgIHN0
cnVjdCBhZF9zaWdtYV9kZWx0YSBzZDsNCj4gQEAgLTEyMSw2ICsxMjIsOSBAQCBzdGF0aWMgaW50
IGFkNzc4MF9yZWFkX3JhdyhzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0KPiAgICAgICAgIGNh
c2UgSUlPX0NIQU5fSU5GT19PRkZTRVQ6DQo+ICAgICAgICAgICAgICAgICAqdmFsID0gLSgxIDw8
IChjaGFuLT5zY2FuX3R5cGUucmVhbGJpdHMgLSAxKSk7DQo+ICAgICAgICAgICAgICAgICByZXR1
cm4gSUlPX1ZBTF9JTlQ7DQo+ICsgICAgICAgY2FzZSBJSU9fQ0hBTl9JTkZPX1NBTVBfRlJFUToN
Cj4gKyAgICAgICAgICAgICAgICp2YWwgPSBzdC0+b2RyOw0KPiArICAgICAgICAgICAgICAgcmV0
dXJuIElJT19WQUxfSU5UOw0KPiAgICAgICAgIGRlZmF1bHQ6DQo+ICAgICAgICAgYnJlYWs7DQo+
ICAgICAgICAgfQ0KPiBAQCAtMTYzLDYgKzE2Nyw3IEBAIHN0YXRpYyBpbnQgYWQ3NzgwX3dyaXRl
X3JhdyhzdHJ1Y3QgaWlvX2Rldg0KPiAqaW5kaW9fZGV2LA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICB2YWwgPSAwOw0KPiAgICAgICAgICAgICAgICAgZWxzZQ0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICB2YWwgPSAxOw0KPiArICAgICAgICAgICAgICAgc3QtPm9kciA9IGFkNzc4eF9vZHJf
YXZhaWxbdmFsXTsNCj4gICAgICAgICAgICAgICAgIGdwaW9kX3NldF92YWx1ZShzdC0+ZmlsdGVy
X2dwaW8sIHZhbCk7DQo+ICAgICAgICAgICAgICAgICBicmVhazsNCj4gICAgICAgICBkZWZhdWx0
Og0KPiBAQCAtMTg0LDYgKzE4OSw3IEBAIHN0YXRpYyBpbnQgYWQ3NzgwX3Bvc3Rwcm9jZXNzX3Nh
bXBsZShzdHJ1Y3QNCj4gYWRfc2lnbWFfZGVsdGEgKnNpZ21hX2RlbHRhLA0KPiANCj4gICAgICAg
ICBpZiAoY2hpcF9pbmZvLT5pc19hZDc3OHgpIHsNCj4gICAgICAgICAgICAgICAgIHN0LT5nYWlu
ID0gYWQ3Nzh4X2dhaW5bcmF3X3NhbXBsZSAmIEFENzc4MF9HQUlOXTsNCj4gKyAgICAgICAgICAg
ICAgIHN0LT5vZHIgPSBhZDc3OHhfb2RyX2F2YWlsW3Jhd19zYW1wbGUgJiBBRDc3ODBfRklMVEVS
XTsNCj4gICAgICAgICB9DQo+IA0KPiAgICAgICAgIHJldHVybiAwOw0KPiBAQCAtMTk2LDE3ICsy
MDIsMTkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhZF9zaWdtYV9kZWx0YV9pbmZvDQo+IGFkNzc4
MF9zaWdtYV9kZWx0YV9pbmZvID0gew0KPiAgfTsNCj4gDQo+ICAjZGVmaW5lIEFENzc4MF9DSEFO
TkVMKGJpdHMsIHdvcmRzaXplKSBcDQo+ICsgICAgICAgQURfU0RfQ0hBTk5FTCgxLCAwLCAwLCBi
aXRzLCAzMiwgd29yZHNpemUgLSBiaXRzKQ0KPiArI2RlZmluZSBBRDcxNzBfQ0hBTk5FTChiaXRz
LCB3b3Jkc2l6ZSkgXA0KPiAgICAgICAgIEFEX1NEX0NIQU5ORUxfTk9fU0FNUF9GUkVRKDEsIDAs
IDAsIGJpdHMsIDMyLCB3b3Jkc2l6ZSAtIGJpdHMpDQo+IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVj
dCBhZDc3ODBfY2hpcF9pbmZvIGFkNzc4MF9jaGlwX2luZm9fdGJsW10gPSB7DQo+ICAgICAgICAg
W0lEX0FENzE3MF0gPSB7DQo+IC0gICAgICAgICAgICAgICAuY2hhbm5lbCA9IEFENzc4MF9DSEFO
TkVMKDEyLCAyNCksDQo+ICsgICAgICAgICAgICAgICAuY2hhbm5lbCA9IEFENzE3MF9DSEFOTkVM
KDEyLCAyNCksDQo+ICAgICAgICAgICAgICAgICAucGF0dGVybiA9IEFENzE3MF9QQVRURVJOLA0K
PiAgICAgICAgICAgICAgICAgLnBhdHRlcm5fbWFzayA9IEFENzE3MF9QQVRURVJOX01BU0ssDQo+
ICAgICAgICAgICAgICAgICAuaXNfYWQ3Nzh4ID0gZmFsc2UsDQo+ICAgICAgICAgfSwNCj4gICAg
ICAgICBbSURfQUQ3MTcxXSA9IHsNCj4gLSAgICAgICAgICAgICAgIC5jaGFubmVsID0gQUQ3Nzgw
X0NIQU5ORUwoMTYsIDI0KSwNCj4gKyAgICAgICAgICAgICAgIC5jaGFubmVsID0gQUQ3MTcwX0NI
QU5ORUwoMTYsIDI0KSwNCj4gICAgICAgICAgICAgICAgIC5wYXR0ZXJuID0gQUQ3MTcwX1BBVFRF
Uk4sDQo+ICAgICAgICAgICAgICAgICAucGF0dGVybl9tYXNrID0gQUQ3MTcwX1BBVFRFUk5fTUFT
SywNCj4gICAgICAgICAgICAgICAgIC5pc19hZDc3OHggPSBmYWxzZSwNCj4gLS0NCj4gMi4yMS4w
DQo+IA0K
