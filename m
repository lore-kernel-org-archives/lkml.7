Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B87C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1B32085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="j7gbK3RW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387756AbfCAKHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:07:24 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:60903 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733008AbfCAKHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:07:24 -0500
X-IronPort-AV: E=Sophos;i="5.58,427,1544511600"; 
   d="scan'208";a="24655399"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Mar 2019 03:07:22 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 1 Mar 2019 03:07:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzyWAt8hJFDVsF1G8kLlGD+P9LGD7axwSuXbJRlZTGQ=;
 b=j7gbK3RW+K6T+rvjuQHWY/bzC/0Pu2jXES4EzElDDEsxbMOKXnm54979cic39yzIeUfs0UAL66j2eGPhw76F5w3HL2QvLPo4wM+5MlbxNQNVTExQXAUJB8RoXfl/WnY1nZjsNjKmLh7OkY0YsMddoCG2VB63/nWEm6ikwvpUvU4=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1309.namprd11.prod.outlook.com (10.169.237.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Fri, 1 Mar 2019 10:07:20 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%8]) with mapi id 15.20.1643.022; Fri, 1 Mar 2019
 10:07:20 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sam@ravnborg.org>
CC:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <bbrezillon@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <thierry.reding@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <Sandeep.Sheriker@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 6/7] drm: atmel-hlcdc: enable sys_clk during
 initalization.
Thread-Topic: [PATCH 6/7] drm: atmel-hlcdc: enable sys_clk during
 initalization.
Thread-Index: AQHUzrjwAYRRhdyfPkqrFMqRJO5EaKX1wyWAgADMeYA=
Date:   Fri, 1 Mar 2019 10:07:20 +0000
Message-ID: <6271a811-9e45-f55c-d53b-b9efe4f13ba4@microchip.com>
References: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
 <1551284609-14594-7-git-send-email-claudiu.beznea@microchip.com>
 <20190228215519.GE30188@ravnborg.org>
In-Reply-To: <20190228215519.GE30188@ravnborg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0181.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::11) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190301120709022
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6d01d58-0742-44d3-92ef-08d69e2db0f5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1309;
x-ms-traffictypediagnostic: MWHPR11MB1309:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxMzA5OzIzOjFWODFiOVo5LzdIcm8xVWhKMHlsSFNhVFN6?=
 =?utf-8?B?ejNLcENFaHlKSWRWaUdudFJCM0o3cFdhc0luODVIekpVK0RCdnU1Mjl6cnl4?=
 =?utf-8?B?VnBOTVhOU0ZtYnAxNkNnWGdiY1o5RmVCT1hWMHRETjNUMDFRUjJQdGhVQmsr?=
 =?utf-8?B?Q2ZBTmRDYVBTckRHVDF4YXYxdDB4SzFROVVrWWY4aEZudS9qVEdmNXQ3RWp4?=
 =?utf-8?B?di9BajB0V3ZEcm9QNkJrNDRNMTRrYjY0Zk5YT0tlZmp0STJ3UjQrQUxWaFdz?=
 =?utf-8?B?ZmdCLzNTR3htNU9HdmQ1K3d2V0JxVW9Td3JlYk5hRFNCVStJYXVsQU04Q3pq?=
 =?utf-8?B?TmVObEtUK2JheGZwR29ZS0tUM3lqT3NzT211VmFMQlNXUWJOTXFDSkV6RnNp?=
 =?utf-8?B?dEtsa0dkVGlLdXM0YXJVbFgwTS9mbXNsWW9WczA2WTJEa3FIbzk5bDdBM3N4?=
 =?utf-8?B?VnN1SG10b0s5OVBCSUNwYjl5WG9XMzFHdlMwYU00K2R3ODI1MnRRaDVTMi96?=
 =?utf-8?B?VnU0ZjhnQnIvQUQ5V1pHaVVsUk1LbXFsTWlEU241bS8wMnVqUE96emR6bzdr?=
 =?utf-8?B?TUI3V3lhU0Q1cHU4SUQrOEowU0FRSWRiNFlZc2czb1gxK1FMUjJITm9xVjZV?=
 =?utf-8?B?SnpUdDBtSXptdk56T05oZDRReHpxRWxJMXQyMVBsbm5LQWkvS0FKdE43eVlv?=
 =?utf-8?B?VWRrMDAwbWs5UG53VHl5K3ErMGs5ajY2SzMyVkc2ZjdnUGNmNEFRNWZHNkVn?=
 =?utf-8?B?Vm0zakNDZXJJcVpZSmRRdFlMRlpvQlFZK0FTbEVJbDR5aXVNQVF3d01DM1pa?=
 =?utf-8?B?S2RZK2xTZXRWd0ZZOHViNTZnbmUrYlFWVDljRllLYjE3eHpIVmw0N09NQUwx?=
 =?utf-8?B?aHB0N0szQ2g4MXNCanpRbHJEZmVtclFNYmtVdnVvNnZ6R0hWbEgreVNOdjJ5?=
 =?utf-8?B?a0I1bVNISmZWWTYzUmxpOTM1MDBCTzNnUXNrWWJ4SGhNOVRaT3JUYWhhMUEx?=
 =?utf-8?B?OWp3RDREWEpsMVBXbCtPQWFHRVdtTEdFTlhTUDZCQndTaVk1ZWVraWo2b0wy?=
 =?utf-8?B?VDlVaVJHZENPS0hzWlR6eHduWEd4WUNtbWpkcC96LzQ4OU9uMmtKM0phNTUy?=
 =?utf-8?B?SnRzVndZN3FORUtDMG9CdXI5VDlJQXA3MlExVTNoaytIZ1kxNzZEN1I4YkUv?=
 =?utf-8?B?YnJBYW9CVEJUSE5sY1JKOFo2MWJHZzh0enBFWjdvWnY3YzNrVFlJMWFscHlO?=
 =?utf-8?B?UVROY2xqamMrWlI5amN5UVE0TDI2SXpzMnM5eng2Z0cwTjdzc0o3Si96Mlgz?=
 =?utf-8?B?UFpCSmlDWTBTNUROTlZ2T1N0d1F2cjE3WnhWWDlwUHNLeHNmTHE4UjVMSjho?=
 =?utf-8?B?SFdYcFpEdWpZWjB1aGRhT0pBWmxxUnRtZ3ZpTzZoeW9DdGxHeDhsb2Q5MUR5?=
 =?utf-8?B?ZGJralFrOVl0bUh4eW1oREdqRlRmU0dNRnc0b3lnb1NoM0JhSEFsa3RXUnBZ?=
 =?utf-8?B?MzlHbEF3S2VIOVdITGZxWmZqL29oYlJNS2JzZStGOFZhTWhpK3BrbmFQcHAx?=
 =?utf-8?B?c3pkTGlXWXlUNkxNWS9QQWRQaklnTGhETUU4d0F0bEd2bjhVVWk5VnV4UmR1?=
 =?utf-8?B?UElESGtDTFVoeHQxcldMMUQwQmZIWUNCTUE2dGRaRkY1WEZZWFlkdFlISndq?=
 =?utf-8?B?MWE4MlhkS3czSUh5anpqekpsUlhkcml4VjYzTXcrdCt2QStLVThjNHVpUlp6?=
 =?utf-8?B?cmJyRUFwcVkvcFdBeVJmUXdmQmtqc1JnQmRtRHRFdlp1SE0zVGlkcEUyWW42?=
 =?utf-8?B?bGJaOVZwUzk2eTl3YXBYc0VFQjVNWE83VkQyT2FqT2p5OVE9PQ==?=
x-microsoft-antispam-prvs: <MWHPR11MB13092B5DCF3F98AD8E0AB4D287760@MWHPR11MB1309.namprd11.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(189003)(11346002)(6116002)(2616005)(14454004)(6916009)(229853002)(54906003)(8936002)(305945005)(478600001)(66066001)(316002)(446003)(7736002)(68736007)(6486002)(105586002)(106356001)(81166006)(81156014)(6436002)(8676002)(99286004)(72206003)(76176011)(52116002)(3846002)(476003)(966005)(2906002)(31686004)(36756003)(486006)(53546011)(6506007)(25786009)(386003)(26005)(31696002)(86362001)(6512007)(186003)(71190400001)(71200400001)(6306002)(53936002)(14444005)(256004)(7416002)(102836004)(5660300002)(6246003)(97736004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1309;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qom8r/QU4dhOw0ffc5cH/1bT8M7SUngaQlMEql3eT7JlfN6yaHJYIKgBzdh67lbss6Bf/Fejt381pUPl3oSATlw58TXcWDt2zpogclu6A5T2VDQWzJaJ1fuDV8E7Q6lVN2ikIA1PLwFA6fhY2cfIX5znfjM/sYaS7hQmwc7anG00Pnlv6arwg5ilujDy4zbrRcxF3+fiwmBFYc83tZBQdsJ/K83w2/Ls+64QGJe2veH9ZBYkkIRNmYI4mwxCBsQfYri3r1MsIujL4kVqgkIBkLAXJ4ye7DZDAmDb4Dt0BG1zvvnIFfccmAf4ZCmTZRB35lEGdFqeyQXcCmd/nUwPOpMVzv5kTRd7a5VKzjPqqDpinZ5gUm23kAFoYpjz6nTu2cripHW/ZFr6bmILKIKtBiq2JAHoA0lWlDPFia2XwTw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F83F0B621C1DBE479232DD4D7F7EE3E7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d01d58-0742-44d3-92ef-08d69e2db0f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 10:07:15.4356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1309
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI4LjAyLjIwMTkgMjM6NTUsIFNhbSBSYXZuYm9yZyB3cm90ZToNCj4gSGkgQ2xhdWRp
dQ0KPiANCj4gT24gV2VkLCBGZWIgMjcsIDIwMTkgYXQgMDQ6MjQ6NDBQTSArMDAwMCwgQ2xhdWRp
dS5CZXpuZWFAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IEZyb206IFNhbmRlZXAgU2hlcmlrZXIg
TWFsbGlrYXJqdW4gPHNhbmRlZXBzaGVyaWtlci5tYWxsaWthcmp1bkBtaWNyb2NoaXAuY29tPg0K
Pj4NCj4+IEZvciBTQU05WDYwIFNvQywgc3lzX2NsayBpcyB0aHJvdWdoIGxjZF9nY2xrIGNsb2Nr
IHNvdXJjZSBhbmQgdGhpcw0KPj4gbmVlZHMgdG8gYmUgZW5hYmxlZCBiZWZvcmUgZW5hYmxpbmcg
bGNkX2Nsay4NCj4gDQo+IFdlIGhhdmUgIm93bmVyc2hpcCIgb2YgdGhlIGNsb2NrcyBpbiB0aGUg
bWZkIGRldmljZS4NCj4gU28gaXQgd291bGQgbWFrZSBtb3JlIHNlbnNlIHRvIGxldCB0aGUgbWZk
IGRldmljZSBoYW5kbGUNCj4gdGhlIGJhc2UgY2xvY2tzLg0KPiBJbiBvdGhlciB3b3JkcyAtIHdo
YXQgYWJvdXQgcHVzaGluZyBlbmFibGUgb2YgcGVyaWdoX2NsayBhbmQgc3lzX2NsayB0bw0KPiB0
aGUgbWZkIGRyaXZlci4NCg0KSSB0aGluayB0aGlzIGNvdWxkIGJlIGFjaGlldmVkLCBidXQgaG93
IGlzIGJldHRlcj8gVG8gaGF2ZSBpbmRpdmlkdWFsDQpkcml2ZXJzIChpbiB0aGlzIGNhcmUgSSB3
b3VsZCBzYXksIGNoaWxkIGRyaXZlcnMsIGxpa2UgZS5nLiB0aGlzIGxjZA0KZHJpdmVyKSB0YWtp
bmcgZGVjaXNpb25zIG9uIHRoZWlyIG93biBmb3IgdGhlaXIgcmVzb3VyY2VzIChldmVuIGlmIHNo
YXJlZCkNCm9yIHRvIGhhdmUgcGFyZW50cyB0YWtpbmcgZGVjaXNpb25zIGZvciB0aGVtPyBKdXN0
IGFza2luZy4NCg0KPiANCj4gVGhpcyBtYXkgaGF2ZSB0aGUgbmljZSBzaWRlLWVmZmVjdCB0aGF0
IHdlIGF2b2lkDQo+IHRoYXQgYm90aCB0aGUgZHJtIGRyaXZlciBhbmQgdGhlIHB3bSBkcml2ZXIg
ZW5hYmxlL2Rpc2FibGUgdGhlIHBlcmlwaF9jbGsNCj4gYXMgaXQgaXMgdG9kYXkuDQo+IA0KPiBB
bm90aGVyIGNvbW1lbnQgLSBmaXhlZF9jbGtzcmMgaXMgdXNlZCB0byBkZXRlcm1pbmUgaWYgc3lz
X2NsayBpcyBlbmFibGVkLg0KPiBCdXQgdGhhdCBmbGFnIGlzIGFib3V0IHRoZSBjbGtzb3VyY2Ug
c2VsZWN0aW9uLCBhbmQgaXQgaXMganVzdCBhIGNvaW5jaWRlbmNlDQo+IHRoYXQgdGhlIHNhbWUg
ZmxhZyBjYW4gYmUgdXNlZCBoZXJlLg0KDQpZZXMsIGFncmVlIG9uIHRoaXMsIEkgdG9vayBhZHZh
bnRhZ2Ugb2YgZml4ZWRfY2xrc3JjIHRvIGFsc28gZW5hYmxlIHRoZQ0Kc3lzX2NsayBiYXNlZCBv
biBmaXhlZF9jbGtzcmMgdG8gYXZvaWQgaW50cm9kdWNpbmcgYW5vdGhlciBtZW1iZXIgaW4gc3Ry
dWN0DQphdG1lbF9obGNkY19kY19kZXNjLiBBdCB0aGlzIG1vbWVudCB0aGlzIGlzIHZhbGlkIG9u
bHkgZm9yIFNBTTlYNjAgYW5kIEkNCndhcyB0aGlua2luZyB0aGF0IGluIGNhc2Ugc29tZSBvdGhl
ciBzY2VuYXJpbyB3aWxsIGFwcGVhciBJIHdpbGwgZG8gdGhlDQphcHByb3ByaWF0ZSBjaGFuZ2Vz
Lg0KDQo+IFdoeSB3ZSBjYW5ub3QgYWx3YXlzIGVuYWJsZSBzeXNfY2xrPyBEbyB3ZSBuZWVkIHRv
IGRvIHRoaXMgb25seQ0KPiBmb3Igc2FtOXg2MD8NCg0KT25seSBTQU05WDYwIHJlcXVpcmVzIHRo
aXMgZXhwbGljaXRseSBhdCBwcm9iZS4NCg0KPiBJRiB5ZXMsIHRoZW4gYWRkIGEgbmV3IGZhbGcu
IElmIG5vLCB0aGVuIHNraXAgdGhlIGZsYWcuDQo+IA0KPiAJU2FtDQo+IA0KPiANCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBTYW5kZWVwIFNoZXJpa2VyIE1hbGxpa2FyanVuIDxzYW5kZWVwc2hlcmlr
ZXIubWFsbGlrYXJqdW5AbWljcm9jaGlwLmNvbT4NCj4+IFtjbGF1ZGl1LmJlem5lYUBtaWNyb2No
aXAuY29tOiBhZGQgZml4ZWRfY2xrc3JjIGNoZWNrc10NCj4+IFNpZ25lZC1vZmYtYnk6IENsYXVk
aXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgZHJp
dmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2RjLmMgfCAxOSArKysrKysrKysr
KysrKysrKystDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0
bWVsX2hsY2RjX2RjLmMgYi9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNf
ZGMuYw0KPj4gaW5kZXggMGJlMTNlY2VlZGJhLi44YmY1MWY4NTM3MjEgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfZGMuYw0KPj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2RjLmMNCj4+IEBAIC02MjUs
MTAgKzYyNSwxOCBAQCBzdGF0aWMgaW50IGF0bWVsX2hsY2RjX2RjX2xvYWQoc3RydWN0IGRybV9k
ZXZpY2UgKmRldikNCj4+ICAJZGMtPmhsY2RjID0gZGV2X2dldF9kcnZkYXRhKGRldi0+ZGV2LT5w
YXJlbnQpOw0KPj4gIAlkZXYtPmRldl9wcml2YXRlID0gZGM7DQo+PiAgDQo+PiArCWlmIChkYy0+
ZGVzYy0+Zml4ZWRfY2xrc3JjKSB7DQo+PiArCQlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoZGMt
PmhsY2RjLT5zeXNfY2xrKTsNCj4+ICsJCWlmIChyZXQpIHsNCj4+ICsJCQlkZXZfZXJyKGRldi0+
ZGV2LCAiZmFpbGVkIHRvIGVuYWJsZSBzeXNfY2xrXG4iKTsNCj4+ICsJCQlnb3RvIGVycl9kZXN0
cm95X3dxOw0KPj4gKwkJfQ0KPj4gKwl9DQo+PiArDQo+PiAgCXJldCA9IGNsa19wcmVwYXJlX2Vu
YWJsZShkYy0+aGxjZGMtPnBlcmlwaF9jbGspOw0KPj4gIAlpZiAocmV0KSB7DQo+PiAgCQlkZXZf
ZXJyKGRldi0+ZGV2LCAiZmFpbGVkIHRvIGVuYWJsZSBwZXJpcGhfY2xrXG4iKTsNCj4+IC0JCWdv
dG8gZXJyX2Rlc3Ryb3lfd3E7DQo+PiArCQlnb3RvIGVycl9zeXNfY2xrX2Rpc2FibGU7DQo+PiAg
CX0NCj4+ICANCj4+ICAJcG1fcnVudGltZV9lbmFibGUoZGV2LT5kZXYpOw0KPj4gQEAgLTY2NCw2
ICs2NzIsOSBAQCBzdGF0aWMgaW50IGF0bWVsX2hsY2RjX2RjX2xvYWQoc3RydWN0IGRybV9kZXZp
Y2UgKmRldikNCj4+ICBlcnJfcGVyaXBoX2Nsa19kaXNhYmxlOg0KPj4gIAlwbV9ydW50aW1lX2Rp
c2FibGUoZGV2LT5kZXYpOw0KPj4gIAljbGtfZGlzYWJsZV91bnByZXBhcmUoZGMtPmhsY2RjLT5w
ZXJpcGhfY2xrKTsNCj4+ICtlcnJfc3lzX2Nsa19kaXNhYmxlOg0KPj4gKwlpZiAoZGMtPmRlc2Mt
PmZpeGVkX2Nsa3NyYykNCj4+ICsJCWNsa19kaXNhYmxlX3VucHJlcGFyZShkYy0+aGxjZGMtPnN5
c19jbGspOw0KPj4gIA0KPj4gIGVycl9kZXN0cm95X3dxOg0KPj4gIAlkZXN0cm95X3dvcmtxdWV1
ZShkYy0+d3EpOw0KPj4gQEAgLTY4OCw2ICs2OTksOCBAQCBzdGF0aWMgdm9pZCBhdG1lbF9obGNk
Y19kY191bmxvYWQoc3RydWN0IGRybV9kZXZpY2UgKmRldikNCj4+ICANCj4+ICAJcG1fcnVudGlt
ZV9kaXNhYmxlKGRldi0+ZGV2KTsNCj4+ICAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRjLT5obGNk
Yy0+cGVyaXBoX2Nsayk7DQo+PiArCWlmIChkYy0+ZGVzYy0+Zml4ZWRfY2xrc3JjKQ0KPj4gKwkJ
Y2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRjLT5obGNkYy0+c3lzX2Nsayk7DQo+PiAgCWRlc3Ryb3lf
d29ya3F1ZXVlKGRjLT53cSk7DQo+PiAgfQ0KPj4gIA0KPj4gQEAgLTgwNSw2ICs4MTgsOCBAQCBz
dGF0aWMgaW50IGF0bWVsX2hsY2RjX2RjX2RybV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikN
Cj4+ICAJcmVnbWFwX3JlYWQocmVnbWFwLCBBVE1FTF9ITENEQ19JTVIsICZkYy0+c3VzcGVuZC5p
bXIpOw0KPj4gIAlyZWdtYXBfd3JpdGUocmVnbWFwLCBBVE1FTF9ITENEQ19JRFIsIGRjLT5zdXNw
ZW5kLmltcik7DQo+PiAgCWNsa19kaXNhYmxlX3VucHJlcGFyZShkYy0+aGxjZGMtPnBlcmlwaF9j
bGspOw0KPj4gKwlpZiAoZGMtPmRlc2MtPmZpeGVkX2Nsa3NyYykNCj4+ICsJCWNsa19kaXNhYmxl
X3VucHJlcGFyZShkYy0+aGxjZGMtPnN5c19jbGspOw0KPj4gIA0KPj4gIAlyZXR1cm4gMDsNCj4+
ICB9DQo+PiBAQCAtODE0LDYgKzgyOSw4IEBAIHN0YXRpYyBpbnQgYXRtZWxfaGxjZGNfZGNfZHJt
X3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+PiAgCXN0cnVjdCBkcm1fZGV2aWNlICpkcm1f
ZGV2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+PiAgCXN0cnVjdCBhdG1lbF9obGNkY19kYyAq
ZGMgPSBkcm1fZGV2LT5kZXZfcHJpdmF0ZTsNCj4+ICANCj4+ICsJaWYgKGRjLT5kZXNjLT5maXhl
ZF9jbGtzcmMpDQo+PiArCQljbGtfcHJlcGFyZV9lbmFibGUoZGMtPmhsY2RjLT5zeXNfY2xrKTsN
Cj4+ICAJY2xrX3ByZXBhcmVfZW5hYmxlKGRjLT5obGNkYy0+cGVyaXBoX2Nsayk7DQo+PiAgCXJl
Z21hcF93cml0ZShkYy0+aGxjZGMtPnJlZ21hcCwgQVRNRUxfSExDRENfSUVSLCBkYy0+c3VzcGVu
ZC5pbXIpOw0KPj4gIA0KPj4gLS0gDQo+PiAyLjcuNA0KPj4NCj4+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+PiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0
DQo+PiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+PiBodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA0KPiANCg==
