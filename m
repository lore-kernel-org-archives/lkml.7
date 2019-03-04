Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52ADBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7FF20863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="GfPWDX9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfCDHTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 02:19:22 -0500
Received: from mail-eopbgr780078.outbound.protection.outlook.com ([40.107.78.78]:48896
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbfCDHTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 02:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPxbSrkzqCgeTzivBXSkMT7XnbnMP4O5dJYXGF8JQTY=;
 b=GfPWDX9fSz4NHlAfqRp+pzfSq5xdsVAmeth5eOeyAD0bJL4HIS7cj+ELBknErYF2D5u69LZsOfDKfaZaCZcfmWDGVgPeWYT4utCzlBcpJRWj795Kj1lexn3VXZVAQVIV4RHMs9a7hLfUma+Oya0/FzV3pNUAH5dq3BcaenXFYFE=
Received: from CY4PR03CA0106.namprd03.prod.outlook.com (2603:10b6:910:4d::47)
 by BN7PR03MB3747.namprd03.prod.outlook.com (2603:10b6:408:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1665.16; Mon, 4 Mar
 2019 07:19:12 +0000
Received: from SN1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by CY4PR03CA0106.outlook.office365.com
 (2603:10b6:910:4d::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.15 via Frontend
 Transport; Mon, 4 Mar 2019 07:19:12 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT017.mail.protection.outlook.com (10.152.72.115) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Mon, 4 Mar 2019 07:19:11 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x247J9WG030352
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 3 Mar 2019 23:19:10 -0800
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Mon, 4 Mar 2019 02:19:09 -0500
From:   "Ardelean, Alexandru" <Alex.Ardelean@analog.com>
To:     "Ardelean, Alexandru" <Alex.Ardelean@analog.com>,
        "jic23@jic23.retrosnub.co.uk" <jic23@jic23.retrosnub.co.uk>
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
Subject: Re: [PATCH v4 3/9] staging: iio: ad7780: set pattern values and
 masks directly
Thread-Topic: [PATCH v4 3/9] staging: iio: ad7780: set pattern values and
 masks directly
Thread-Index: AQHUz3FaPQkUlqrErkyXchfV/yYKoqX2sncAgAJYxACAAABJgIACXoUA
Date:   Mon, 4 Mar 2019 07:19:08 +0000
Message-ID: <b3abf479a0c6bfab4f47becb847647745d7931b3.camel@analog.com>
References: <cover.1551358569.git.renatogeh@gmail.com>
         <9c8331166124ec2bd52794a9c9f844bfb70d1cd9.1551358569.git.renatogeh@gmail.com>
         <efc42dc6be92871f03e5f8dc3d5aa9ebad5bedb8.camel@analog.com>
         <20190302190716.26838b52@archlinux> <20190302190817.61dc4e72@archlinux>
In-Reply-To: <20190302190817.61dc4e72@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C51931CFEAEE24F84BF893C63753F14@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(2980300002)(199004)(189003)(426003)(110136005)(436003)(2616005)(54906003)(11346002)(446003)(186003)(102836004)(7416002)(8936002)(26005)(8676002)(336012)(106466001)(2906002)(50466002)(6116002)(316002)(106002)(47776003)(14444005)(93886005)(3846002)(246002)(2501003)(7736002)(7636002)(72206003)(356004)(14454004)(305945005)(118296001)(86362001)(107886003)(23676004)(476003)(5660300002)(2486003)(6246003)(4326008)(229853002)(76176011)(478600001)(126002)(7696005)(486006)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3747;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aba494b9-8d5b-4482-b116-08d6a071b330
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060)(7193020);SRVR:BN7PR03MB3747;
X-MS-TrafficTypeDiagnostic: BN7PR03MB3747:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3747;20:FiGGEFJPdtJWXRagg2hPLNa1xMpId4hFQTUX6ewVWXw8vwgDN29clDbDdlkGmfBBzbPTvPUrW1hqpB3uwzpIXo2sJB7YiH6wF9N7NTpT58XhTZDcDefoCTF9MfXF3qNl8IVBZqeUZnrItntobEN1nT0he09d2AVp3pSw0hHJa+l+JwOgueHIgK57eHk/f5hHSmOPLxmqHf2b2s62OLIDlVXMZbpPdXcl8hc63ghK4gqYQT7A4wI1mfj5b+W9MWefn635w/Bg+rPNGW4P5+WgpqPJHyMzQfDcJ33rrMLc9ASAqQ0KVzrt7qBpDHXm1LV5DM77t/fXOP9jGfTok4cu4zi+DXN/gYertXbmKU3sCaILsUcCEXr2SEuhjUoYTVehmxSaiLTQjfMY/ZPEXjJUOK9f+UJflsxyKrk79NU5L02KcB2YtZFtT73XXxlAdfHqxGi4LeQRikbIe+GXBMIrZsvI1Ne+IKUXKVJejp29nnyGDOWJaTMl+Zn52cUcQvh8
X-Microsoft-Antispam-PRVS: <BN7PR03MB3747448947DBF4008A05786795710@BN7PR03MB3747.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09669DB681
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjAzTUIzNzQ3OzIzOnEydmZmazFTc29BWUREQ1BsSnY2UFlaakt3?=
 =?utf-8?B?YW9RRTgvSG1ISk1jalBTbUVGMFprcyt0NEVyNHNxWEU2NGhOOWcwdGpQc0tx?=
 =?utf-8?B?T3ZvWDNkVXk5aXo4YkJxVlZYRnA4VDcxdExLbDVRUjdRQ2hmTTdSUFQxcFFY?=
 =?utf-8?B?bU5UZ3JER1RWWXhPdVI1MTFGbEgxcmV0cmhRTm41U1dvMThBUXlzOEhEdmhQ?=
 =?utf-8?B?dUcvZyt4eEU4eElFcUE0YUo4eUd4ckc0dWxRV3BoQzY3ODJYWnRRMzd3OTB3?=
 =?utf-8?B?L1VIQjVXVlFYUFVkNWFDMHV0Rk9FU1oyYk8ya0xrbnNsdzE3WnhmaldxQ0tK?=
 =?utf-8?B?bzUvdzJWU2J6eVluSzdrenlLVStUTVR1T0tmMElIYzFOVFduUWZxRnl5c05z?=
 =?utf-8?B?WVdiT1lNU00wYmFLWVZ1QkxOamlpNlZJTmRFWFl4SS8xZDhYK0FWcU5CbG14?=
 =?utf-8?B?U1huRjAwOG8wNDRRakppbjViVXgwYVorYkpXVE92ck9HSEZ5QVFhL2xKa1hF?=
 =?utf-8?B?aEFUYkR5b1ZkSVlOQy9nVExEOERweHZlSVh4RWxpbmthVERLZlc0YWtQdnk3?=
 =?utf-8?B?Q2ZxSWtqRGNBTEVpT2JSZWFTaEhuQ2RkUUxUNU5FNUJBVXZLQjR2d3dKRHZs?=
 =?utf-8?B?UE1IV0ZZUHJ4N1BDWGZ4dm9PZzRVSkErTzdXb3VPSUx4SUVNRnB3QVFzM0x4?=
 =?utf-8?B?SnE1eFBNUGhsOW9YMHY1VExJSjk1SFlhMlVaQnAzOEVjY1B2K3pYbnRuSDkz?=
 =?utf-8?B?WW01MW44WkgvTktya3diVSt6clhhRTBSTWNodGZnd3d5Zi9CV1dkZXNYNzRT?=
 =?utf-8?B?QW9wcEZaQTZvemEzTXRDN0xLWUdYYVlJTjFOc1dCTy9yaHpDRXNibnMvNVhZ?=
 =?utf-8?B?dkpQc1pKNEl1QktBTENOQjZGVTlJUkc0VE9hYTJjL1JoZTYzblZFeHNVTWla?=
 =?utf-8?B?bDdaWTBBOTc0aUVyQWJwNTFMM3VmRXBRN0R4bVJuSWlucUZ4WElGUnRVWEtX?=
 =?utf-8?B?V3BQMkZZRGxBOEVIaVNOMDVhalNMdXhEd3d5eUxxdWlCbktUQkVBZVBwcCty?=
 =?utf-8?B?dTZRbFhBYVY5RmFVOXYzeGhJRHoxK0lPalRkOWpBclpFbWxibHIzcTBVSEgw?=
 =?utf-8?B?dW9WMTJxQmFFL0tVKzNqcVRIUng2N2JmckRSNWFSUGdJZTh6emdsdXN5Y0N2?=
 =?utf-8?B?UWhRNGtScHRsMzlRVC9qQzlaOFZnNGV3UVBFclkvRU55dTl1ZE5IWTAxaVM2?=
 =?utf-8?B?NnZXcWZsaWNxRzdVMkRHbW5XTjRKSHVrdnNGYzZwWmw0Sm9Sek5qOENSaXNV?=
 =?utf-8?B?Z0VZUDd3YTUrRis3Nk5jUnFscDJFT2FUbEYzUXY5eU0wODBOK29rSTlDWkhM?=
 =?utf-8?B?R09mcnZnTEJwZGFwNVlBaGs1VmhRcVY0WXlrUndZME9wallkWXg5M00xVjZN?=
 =?utf-8?B?NlZzRzk4VDRUOFBHZU9yaDQ5RzU4cTduQ1FNMmJjdjEwcVNPLzhFU1BtZlBr?=
 =?utf-8?B?dXpTeWNHTFQ2REVrKy92RjlJdHZKM3YxQ0lGbEVDbjVVWGZuUndmR1lUOEJX?=
 =?utf-8?B?UUJuR1pCOUFYTWpmZEVzanFDZ0tWYTVrdCs2QlFSQk5jQnpMYkxRcjFKYjJS?=
 =?utf-8?Q?35CdGc1wcboHwrUDHw3g?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: W6/W2fAN0HbPd365eCDqhQc6KReBJ5oSiHnV+AtaR2j6RdiVExAYJp4PKBU2Si6xpYICa0jn6xrazmGTEzlP1zMMlwg/AhJCUZcemvPnLEENJVxlwyJbOH6OSpAZ1QFrc+G6DPm35R7mxuaCjlovTghmHraklVCA0wObVi+puKkMJ+hkYkInB+7ZlRkByS7iQkS4WTTUQ7hdVgI5gYVxX74wBe8lspNSWQ+Oe6LdQ1xt0qi2gmNCcd/snYG0JF5rDgCjr/oTzAKeOu8bW5mbDxGeCUEppHUp+MnFSDc817I0n+Xlp7o71+i/68rE7kfy/x3mb0h+ixdXGwgA4DT9+S9uZ8/LqLN0u3n9SYY20VZhW83F3jcqENqNZedWF64V2YwhkehZtq4dF5jcXGp5Au6jz2Dxlqa3VHrP8BeIDuo=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2019 07:19:11.1190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aba494b9-8d5b-4482-b116-08d6a071b330
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3747
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDE5LTAzLTAyIGF0IDE5OjA4ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiANCj4gT24gU2F0LCAyIE1hciAyMDE5IDE5OjA3OjE2ICsw
MDAwDQo+IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4g
PiBPbiBGcmksIDEgTWFyIDIwMTkgMDc6MTc6MDQgKzAwMDANCj4gPiAiQXJkZWxlYW4sIEFsZXhh
bmRydSIgPEFsZXguQXJkZWxlYW5AYW5hbG9nLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gPiBPbiBU
aHUsIDIwMTktMDItMjggYXQgMTE6MjQgLTAzMDAsIFJlbmF0byBMdWkgR2VoIHdyb3RlOg0KPiA+
ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBBRDc3ODAgZHJpdmVyIGNvbnRhaW5zIHN0YXR1
cyBwYXR0ZXJuIGJpdHMgZGVzaWduZWQgZm9yDQo+ID4gPiA+IGNoZWNraW5nDQo+ID4gPiA+IHdo
ZXRoZXIgc2VyaWFsIHRyYW5zZmVycyBoYXZlIGJlZW4gY29ycmVjdGx5IHBlcmZvcm1lZC4gUGF0
dGVybg0KPiA+ID4gPiBtYWNyb3MNCj4gPiA+ID4gd2VyZSBwcmV2aW91c2x5IGdlbmVyYXRlZCB0
aHJvdWdoIGJpdCBmaWVsZHMuIFRoaXMgcGF0Y2ggc2V0cyBnb29kDQo+ID4gPiA+IHBhdHRlcm4g
dmFsdWVzIGRpcmVjdGx5IGFuZCBtYXNrcyB0aHJvdWdoIEdFTk1BU0suDQo+ID4gPiA+IA0KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBSZW5hdG8gTHVpIEdlaCA8cmVuYXRvZ2VoQGdtYWlsLmNvbT4N
Cj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYyB8
IDIwICsrKysrKysrKy0tLS0tLS0tLS0tDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNl
cnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiA+ID4gPiBiL2RyaXZlcnMvc3Rh
Z2luZy9paW8vYWRjL2FkNzc4MC5jDQo+ID4gPiA+IGluZGV4IDdhNjhlOTBkZGYxNC4uNTZjNDll
MjhmNDMyIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3
ODAuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiA+
ID4gPiBAQCAtMTcsNiArMTcsNyBAQA0KPiA+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L3NjaGVkLmg+
DQo+ID4gPiA+ICAjaW5jbHVkZSA8bGludXgvZ3Bpby9jb25zdW1lci5oPg0KPiA+ID4gPiAgI2lu
Y2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L2JpdHMuaD4N
Cj4gPiA+ID4gDQo+ID4gPiA+ICAjaW5jbHVkZSA8bGludXgvaWlvL2lpby5oPg0KPiA+ID4gPiAg
I2luY2x1ZGUgPGxpbnV4L2lpby9zeXNmcy5oPg0KPiA+ID4gPiBAQCAtMjgsMTYgKzI5LDEzIEBA
DQo+ID4gPiA+ICAjZGVmaW5lIEFENzc4MF9JRDEgICAgICAgICAgICAgQklUKDQpDQo+ID4gPiA+
ICAjZGVmaW5lIEFENzc4MF9JRDAgICAgICAgICAgICAgQklUKDMpDQo+ID4gPiA+ICAjZGVmaW5l
IEFENzc4MF9HQUlOICAgICAgICAgICAgQklUKDIpDQo+ID4gPiA+IC0jZGVmaW5lIEFENzc4MF9Q
QVQxICAgICAgICAgICAgQklUKDEpDQo+ID4gPiA+IC0jZGVmaW5lIEFENzc4MF9QQVQwICAgICAg
ICAgICAgQklUKDApDQo+ID4gPiANCj4gPiA+IEkgZG9uJ3Qgc2VlIGEgcHJvYmxlbSB0byBsZWF2
ZSB0aGUgYml0ZmllbGRzOyAgdGhleSBjYW4gYmUgcmVhZCAmDQo+ID4gPiBtYXRjaGVkDQo+ID4g
PiBlYXNpZXIgd2l0aCB0aGUgZGF0YXNoZWV0Lg0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiAt
I2RlZmluZSBBRDc3ODBfUEFUVEVSTiAgICAgICAgIChBRDc3ODBfUEFUMCkNCj4gPiA+ID4gLSNk
ZWZpbmUgQUQ3NzgwX1BBVFRFUk5fTUFTSyAgICAoQUQ3NzgwX1BBVDAgfCBBRDc3ODBfUEFUMSkN
Cj4gPiA+ID4gDQo+ID4gPiA+IC0jZGVmaW5lIEFENzE3MF9QQVQyICAgICAgICAgICAgQklUKDIp
DQo+ID4gPiA+ICsjZGVmaW5lIEFENzc4MF9QQVRURVJOX0dPT0QgICAgMQ0KPiA+ID4gDQo+ID4g
PiBJdCB3YXMgYWxzbyBuaWNlIGJlZm9yZSB0aGF0IHRoZSBQQVQwLi5QQVQyIGJpdGZpZWxkcyB3
ZXJlIHVzZWQgdG8NCj4gPiA+IGRlZmluZSBhDQo+ID4gPiBnb29kIHBhdHRlcm4sIHNpbmNlIGl0
J3MgZWFzaWVyIHRvIG1hdGNoIHdpdGggdGhlIGRhdGFzaGVldC4NCj4gPiANCj4gPiBUaGlzIG9u
ZSB3YXMgbXVjaCBzdWdnZXN0aW9uLiAgTm90IHBhcnRpY3VsYXJseSBpbXBvcnRhbnQgb25lLg0K
PiANCj4gTm90IGVub3VnaCBzbGVlcCB0aGlzIHdlZWsgY2xlYXJseSA6KQ0KPiBUaGlzIG9uZSB3
YXMgX215XyBzdWdnZXN0aW9uLg0KDQpPay4NCkkgYXNzdW1lZCBhIGJpdCBJIG1pc3NlZCBhIGRp
c2N1c3Npb24gc29tZXdoZXJlLg0KDQpMZXQncyBoYXZlIHRoaXMgYXMtaXMgaGVyZS4NCkkgZG9u
J3QgbWluZCBpdCBtdWNoIGVpdGhlci4NCk15IFtwZXJzb25hbF0gZmVlbGluZyBpcyB0aGF0IFtp
biB0aGUgY29udGV4dCBvZiBhIG1vdmUtb3V0LW9mLXN0YWdpbmctb2YtDQp0aGlzLWRyaXZlcl0g
dGhpcyBwYXRjaCBpcyBhIGJpdCBvZiBub2lzZS4NCg0KSWYgdGhlIHNlcmllcyB3ZXJlIG1vcmUg
dGlkeS11cCwgdGhlbiBJIHByb2JhYmx5IHdvdWxkIG5vdCBoYXZlIHJlcGxpZWQuDQoNCj4gDQo+
ID4gDQo+ID4gUGVyc29uYWxseSBpZiBhIGRhdGFzaGVldCBpcyBwb2ludGxlc3NseSBjb25mdXNp
bmcgSSB0ZW5kIHRvIGlnbm9yZSBpdC4NCj4gPiBUaGlzIGlzIGEgdHdvIGJpdCBmaWVsZCBhcyB0
aGUgYml0cyBkb24ndCBoYXZlIGluZGVwZW5kZW50IG1lYW5pbmchDQo+ID4gDQo+ID4gSSdtIG5v
dCBzdHJvbmdseSB0aWVkIHRvIGl0IHRob3VnaCBhbmQgYXMgaXQncyBhbiBBbmFsb2cgZHJpdmVy
IGFuZA0KPiA+IHlvdSBhbGwgZG8gYSBnb29kIGpvYiBtYWludGFpbmluZyB0aGUgc2V0IEknbGwg
Z28gd2l0aCB5b3VyIHByZWZlcmVuY2UhDQo+ID4gSSBkbyBwcmVmZXIgdGhlIG5hbWluZyBvZiBQ
QVRURVJOX0dPT0QgdGhvdWdoIGlmIG5vdGhpbmcgZWxzZSENCj4gPiA+IA0KPiA+ID4gDQo+ID4g
PiA+ICsjZGVmaW5lIEFENzc4MF9QQVRURVJOX01BU0sgICAgR0VOTUFTSygxLCAwKQ0KPiA+ID4g
DQo+ID4gPiBJIGxpa2UgdGhlIGdlbmVyYWwgdXNhZ2Ugb2YgR0VOTUFTSywgYnV0IEknbSBub3Qg
c3VyZSBpbiB0aGlzIGNhc2UNCj4gPiA+IGl0J3MNCj4gPiA+IHdvcnRoIGRvaW5nLiBNYXliZSBJ
IG1pc3NlZCBhIGRpc2N1c3Npb24gc29tZXdoZXJlLCBhYm91dCBkb2luZyB0aGlzDQo+ID4gPiBj
aGFuZ2UsIGJ1dCBpdCBpcyBtb3N0bHkgYSBjb3NtZXRpYyB3aXRob3V0IGFueSBmdW5jdGlvbmFs
IGNoYW5nZS4NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiAtI2RlZmluZSBBRDcx
NzBfUEFUVEVSTiAgICAgICAgIChBRDc3ODBfUEFUMCB8IEFENzE3MF9QQVQyKQ0KPiA+ID4gPiAt
I2RlZmluZSBBRDcxNzBfUEFUVEVSTl9NQVNLICAgIChBRDc3ODBfUEFUMCB8IEFENzc4MF9QQVQx
IHwNCj4gPiA+ID4gQUQ3MTcwX1BBVDIpDQo+ID4gPiA+ICsjZGVmaW5lIEFENzE3MF9QQVRURVJO
X0dPT0QgICAgNQ0KPiA+ID4gPiArI2RlZmluZSBBRDcxNzBfUEFUVEVSTl9NQVNLICAgIEdFTk1B
U0soMiwgMCkNCj4gPiA+ID4gDQo+ID4gPiA+ICAjZGVmaW5lIEFENzc4MF9HQUlOX01JRFBPSU5U
ICAgNjQNCj4gPiA+ID4gICNkZWZpbmUgQUQ3NzgwX0ZJTFRFUl9NSURQT0lOVCAxMzM1MA0KPiA+
ID4gPiBAQCAtMjA5LDI1ICsyMDcsMjUgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhZF9zaWdtYV9k
ZWx0YV9pbmZvDQo+ID4gPiA+IGFkNzc4MF9zaWdtYV9kZWx0YV9pbmZvID0gew0KPiA+ID4gPiAg
c3RhdGljIGNvbnN0IHN0cnVjdCBhZDc3ODBfY2hpcF9pbmZvIGFkNzc4MF9jaGlwX2luZm9fdGJs
W10gPSB7DQo+ID4gPiA+ICAgICAgICAgW0lEX0FENzE3MF0gPSB7DQo+ID4gPiA+ICAgICAgICAg
ICAgICAgICAuY2hhbm5lbCA9IEFENzE3MF9DSEFOTkVMKDEyLCAyNCksDQo+ID4gPiA+IC0gICAg
ICAgICAgICAgICAucGF0dGVybiA9IEFENzE3MF9QQVRURVJOLA0KPiA+ID4gPiArICAgICAgICAg
ICAgICAgLnBhdHRlcm4gPSBBRDcxNzBfUEFUVEVSTl9HT09ELA0KPiA+ID4gPiAgICAgICAgICAg
ICAgICAgLnBhdHRlcm5fbWFzayA9IEFENzE3MF9QQVRURVJOX01BU0ssDQo+ID4gPiA+ICAgICAg
ICAgICAgICAgICAuaXNfYWQ3Nzh4ID0gZmFsc2UsDQo+ID4gPiA+ICAgICAgICAgfSwNCj4gPiA+
ID4gICAgICAgICBbSURfQUQ3MTcxXSA9IHsNCj4gPiA+ID4gICAgICAgICAgICAgICAgIC5jaGFu
bmVsID0gQUQ3MTcwX0NIQU5ORUwoMTYsIDI0KSwNCj4gPiA+ID4gLSAgICAgICAgICAgICAgIC5w
YXR0ZXJuID0gQUQ3MTcwX1BBVFRFUk4sDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAucGF0dGVy
biA9IEFENzE3MF9QQVRURVJOX0dPT0QsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAucGF0dGVy
bl9tYXNrID0gQUQ3MTcwX1BBVFRFUk5fTUFTSywNCj4gPiA+ID4gICAgICAgICAgICAgICAgIC5p
c19hZDc3OHggPSBmYWxzZSwNCj4gPiA+ID4gICAgICAgICB9LA0KPiA+ID4gPiAgICAgICAgIFtJ
RF9BRDc3ODBdID0gew0KPiA+ID4gPiAgICAgICAgICAgICAgICAgLmNoYW5uZWwgPSBBRDc3ODBf
Q0hBTk5FTCgyNCwgMzIpLA0KPiA+ID4gPiAtICAgICAgICAgICAgICAgLnBhdHRlcm4gPSBBRDc3
ODBfUEFUVEVSTiwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIC5wYXR0ZXJuID0gQUQ3NzgwX1BB
VFRFUk5fR09PRCwNCj4gPiA+ID4gICAgICAgICAgICAgICAgIC5wYXR0ZXJuX21hc2sgPSBBRDc3
ODBfUEFUVEVSTl9NQVNLLA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgLmlzX2FkNzc4eCA9IHRy
dWUsDQo+ID4gPiA+ICAgICAgICAgfSwNCj4gPiA+ID4gICAgICAgICBbSURfQUQ3NzgxXSA9IHsN
Cj4gPiA+ID4gICAgICAgICAgICAgICAgIC5jaGFubmVsID0gQUQ3NzgwX0NIQU5ORUwoMjAsIDMy
KSwNCj4gPiA+ID4gLSAgICAgICAgICAgICAgIC5wYXR0ZXJuID0gQUQ3NzgwX1BBVFRFUk4sDQo+
ID4gPiA+ICsgICAgICAgICAgICAgICAucGF0dGVybiA9IEFENzc4MF9QQVRURVJOX0dPT0QsDQo+
ID4gPiA+ICAgICAgICAgICAgICAgICAucGF0dGVybl9tYXNrID0gQUQ3NzgwX1BBVFRFUk5fTUFT
SywNCj4gPiA+ID4gICAgICAgICAgICAgICAgIC5pc19hZDc3OHggPSB0cnVlLA0KPiA+ID4gPiAg
ICAgICAgIH0sDQo+ID4gPiA+IC0tDQo+ID4gPiA+IDIuMjEuMA0KPiA+ID4gPiANCj4gDQo+IA0K
