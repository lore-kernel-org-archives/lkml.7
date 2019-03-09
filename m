Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8E8C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920A220851
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hTMqsjTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfCIOko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 09:40:44 -0500
Received: from mail-eopbgr690078.outbound.protection.outlook.com ([40.107.69.78]:61671
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725841AbfCIOkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 09:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lD5hr/8CNl/1Z355bRYZkrfCFC+f8z9c8Nx7P6r6sq0=;
 b=hTMqsjTHLprqS87crnweKHVpKPPt+VuAEbyu3y4muzkUczwKnf+2+fSVy9mbf4zKZL14rLf0yR9Q9qgKuRTXdmoAcZwa3ABTALTpFY7ykXRoBEihYlB53kFkahkfZryTmXiho07WUL8njTCrm27LPastSKwIlKHHI49f/Ka0DOk=
Received: from CY4PR02MB2183.namprd02.prod.outlook.com (10.169.180.137) by
 CY4PR02MB2501.namprd02.prod.outlook.com (10.173.41.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Sat, 9 Mar 2019 14:40:33 +0000
Received: from CY4PR02MB2183.namprd02.prod.outlook.com
 ([fe80::e9a7:9a39:a321:fcf8]) by CY4PR02MB2183.namprd02.prod.outlook.com
 ([fe80::e9a7:9a39:a321:fcf8%6]) with mapi id 15.20.1686.021; Sat, 9 Mar 2019
 14:40:33 +0000
From:   Appana Durga Kedareswara Rao <appanad@xilinx.com>
To:     Andre Naujoks <nautsch2@gmail.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: can: Increase tx queue length
Thread-Topic: [PATCH] net: can: Increase tx queue length
Thread-Index: AQHU1oF2NVazfm4kq02wvhmQ4wo64KYDWecAgAAA1yA=
Date:   Sat, 9 Mar 2019 14:40:32 +0000
Message-ID: <CY4PR02MB2183E0667CF67DEE6A297FF8DC4E0@CY4PR02MB2183.namprd02.prod.outlook.com>
References: <1552140446-31535-1-git-send-email-appana.durga.rao@xilinx.com>
 <cd71079c-664f-b1b6-bb21-ecda639ecbed@gmail.com>
In-Reply-To: <cd71079c-664f-b1b6-bb21-ecda639ecbed@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=appanad@xilinx.com; 
x-originating-ip: [183.82.220.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd7c72a4-2cdd-4dd6-a43b-08d6a49d2f68
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY4PR02MB2501;
x-ms-traffictypediagnostic: CY4PR02MB2501:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtDWTRQUjAyTUIyNTAxOzIzOjBHVHhzSVI5YzJvZXZTYlNSOGtzSllKcjUz?=
 =?utf-8?B?RHI1OUJuTzJ3R2NmUWJiN21vSWVBOVVub0hnb2xxTTg4TnQxdXphY0FsTHpp?=
 =?utf-8?B?SW1KenpKbitkYnBlQWpFSElyT1kxU3NlTkQ0NGZSME02Yy9sWTZza21BaU90?=
 =?utf-8?B?YkVxNmUxN0NKSFRLU0JHMmJGZFNuRnk3VEJOeHgxTUlpaUF5SEFhbTRHV21p?=
 =?utf-8?B?NW5nMW5VVzhrLzR0NUQyKzJRM2NNQm1GVkxxQ3dmYWowaE90ZWtLZnBPTzQx?=
 =?utf-8?B?Wk9FNjhmOEIvUU5uOVlMbGFpRTZoN1Vpa2RSOHd2MnRXOGJZOUY4Sk1Da1RX?=
 =?utf-8?B?UTY3VnVoVjJqQjhDZjZYbnNlNkhkOGE1TFozTUNQM2VwR282dXc5UHBnNVpw?=
 =?utf-8?B?UUtEOFpza1lWWHF4VEFxNDNlek1OL0dxSWdwcStHL2cwMW5vTVBDQmVkNWlp?=
 =?utf-8?B?bElNcExvNk9XcUg5L3psdnFvNU5ocjRjNFpaaWJoSUlnMTNYRWhOL1NjWkpz?=
 =?utf-8?B?N1hvZUN0cW0zZEtOcEJNeGZVZEZHbnJhODhjWTFER0J4ZTA4aTVLZFZkTTh6?=
 =?utf-8?B?UWppOWFTM1lWMDJvTUE5TThQTjBGUUFabFE3RDBoYklIMDNWS2ZIVUxxSjVp?=
 =?utf-8?B?U1dxNCtNM1E3aXlYaU9LdVl6M092eDFiT2ZlL2tLcE81VW9XUjMxSjhsZE0v?=
 =?utf-8?B?VmhZbW1zUkhiTzFiMGY5VDNIYlRydkI4V3o0dTF4cEEzRFpuaGRzMFFWZHRS?=
 =?utf-8?B?cTl3TTRXT0NLVUduZ0p6Q2FaVDNJTUFnckdNZkkzYVArc1ExWUwxRzE4RGZL?=
 =?utf-8?B?aW0xZjBIczRhNGVpM3d6dG50ZzNPMTMvaVBDTmRweEdrcWNOQklRdDdCbnRa?=
 =?utf-8?B?eEd6aVZvMUtDM2FsaWZTeURoTnNYNzNCVmdKeDdzU05RVkY2UitFazFkYTc4?=
 =?utf-8?B?Ylp6bGhYalpqUTMwV0NpMWJGWmJJZkM2KzN0Y050dU5pVmh4Z3RHWEEzMm1j?=
 =?utf-8?B?bGY0ZHlncE96K0dXbWV2RkgyREhIelJVTEFQN1VaTHByOUU1dEZWbGRlbS9V?=
 =?utf-8?B?K2UvU3FZRTcyWDkvU1FwNFNINEFjSEQyREZEc3ZXQzNhRkVGeXN4czZHbEhD?=
 =?utf-8?B?Zmw4c09FNml6ak8zUWtySWt0Y2pmb0p3eTd2MzIzak8yT2hRdkR3MU1nck5y?=
 =?utf-8?B?TVJqaXhVNDJVcG5ZbGkvTEcvcXV3VzdNd0RWQ3ZFb2pjcWdlUUhNejdScW94?=
 =?utf-8?B?VVkweXYxNm5NTE11MFVjZ3NXMVpNZXhpUlVHVVVtd21UcU53MXJGR1hQRjFr?=
 =?utf-8?B?RGVKU2pORzFIRGNPakdVNUdyck92ZTYxSjA2UzVJOFMvaEtONEJhYWtyVS9h?=
 =?utf-8?B?bkRzc2luZ3Z5R1c4OEJBTERDcm5Ia0NGbDNhTzhIVE5icllYU0NVZi9rZ3BL?=
 =?utf-8?B?djhGYzMvUGMzU1d0SExGdjdUQVg2RWI4WHJWcWV4a0ZCeWcyUldwUi80dC80?=
 =?utf-8?B?U01ETVVOamdMUG1mZDg5Y3g5YTJCRGFhSXM0YzJVSHAvZG5QRmtYWVFyZytG?=
 =?utf-8?B?RUxUNHR2UEFseE84T1E4eUZ6SDRjVTdYTzV3WHpJU1YweGRyUlJERkRzNXZl?=
 =?utf-8?B?QTBNZUcrYVM1TGRKcUwxRjVHcjU4c1NWbTJOWUVBemFMZGZ1SW9oRVJHTDVH?=
 =?utf-8?B?OGFtUjdvdzYyeGh0S3NLTFZIRHhJTGFWY2ZxYUNrTHkya29kOWFsWjJBeVJT?=
 =?utf-8?B?bjRxTWZ2Y0c4K2Q2cUlwNWlIMVlkZlVqVWh0cFBML0k0bkZ4UW93bDI1bjZF?=
 =?utf-8?Q?r9zpEEpbgzJXa?=
x-microsoft-antispam-prvs: <CY4PR02MB250121C07A3B08FA00D1A014DC4E0@CY4PR02MB2501.namprd02.prod.outlook.com>
x-forefront-prvs: 0971922F40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(51914003)(76176011)(2906002)(110136005)(6436002)(53936002)(81156014)(229853002)(81166006)(8676002)(486006)(26005)(478600001)(446003)(476003)(316002)(11346002)(2201001)(305945005)(52536013)(7736002)(74316002)(186003)(86362001)(5660300002)(66066001)(55016002)(9686003)(33656002)(97736004)(14454004)(106356001)(71200400001)(7696005)(4326008)(102836004)(78486014)(256004)(14444005)(71190400001)(25786009)(8936002)(54906003)(105586002)(6506007)(6116002)(3846002)(6246003)(53546011)(2501003)(99286004)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2501;H:CY4PR02MB2183.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hVFP8q0nAPhSqLiw2EXPrT/biUtaM+ydBZf6zjlyiZ3MuDERfuOFw/Lyrc+YYuTCTIt1/0Njm10Y3U5wtio/kKj7RsW2jTeuHDyabPISkI+nKCqSMB1wIyXaccXzKNzQe6O1yJknALz/3wIE70z6p2Rf43e92TzdfWIV+3PnyYNS6qOsCLqA3yOVTx782Ohm2usgazN6muEmqpEg/Bd5ceJib1UyD4iHQb/NtPTDH+D2kiiQXK1mBCZkkckbecD40ZTSX4TzB/a5x+29DpkpXqpEGX0JgJdL2/oqISrhwiMdNjxkTl+wZrgB1IWA8LPlXXIMJ+K15coJlRK4WaGQmaRDeN4q7nm29tO19zdEF4aVSw2rg9O3Pwrj6vE339xDpK7y7piC+gKCPPoIrf2Xwxk17hOBYcn00sd3qGkbLRM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7c72a4-2cdd-4dd6-a43b-08d6a49d2f68
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2019 14:40:33.0170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2501
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmUsDQoNCjxTbmlwPiANCj4gDQo+IE9uIDMvOS8xOSAzOjA3IFBNLCBBcHBhbmEgRHVy
Z2EgS2VkYXJlc3dhcmEgcmFvIHdyb3RlOg0KPiA+IFdoaWxlIHN0cmVzcyB0ZXN0aW5nIHRoZSBD
QU4gaW50ZXJmYWNlIG9uIHhpbGlueCBheGkgY2FuIGluIGxvb3BiYWNrDQo+ID4gbW9kZSBnZXR0
aW5nIG1lc3NhZ2UgIndyaXRlOiBubyBidWZmZXIgc3BhY2UgYXZhaWxhYmxlIg0KPiA+IEluY3Jl
YXNpbmcgZGV2aWNlIHR4IHF1ZXVlIGxlbmd0aCByZXNvbHZlZCB0aGUgYWJvdmUgbWVudGlvbmVk
IGlzc3VlLg0KPiANCj4gTm8gbmVlZCB0byBwYXRjaCB0aGUga2VybmVsOg0KPiANCj4gJCBpcCBs
aW5rIHNldCA8ZGV2LW5hbWU+IHR4cXVldWVsZW4gNTAwDQo+IA0KPiBkb2VzIHRoZSBzYW1lIHRo
aW5nLg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuLi4gDQpBZ3JlZSBidXQgaXQgaXMgbm90IGFu
IG91dCBvZiBib3ggc29sdXRpb24gcmlnaHQ/PyANCkRvIHlvdSBoYXZlIGFueSBpZGVhIGZvciBz
b2NrZXQgY2FuIGRldmljZXMgd2h5IHRoZSB0eCBxdWV1ZSBsZW5ndGggaXMgMTAgd2hlcmVhcw0K
Zm9yIG90aGVyIG5ldHdvcmsgZGV2aWNlcyAoZXg6IGV0aGVybmV0KSBpdCBpcyAxMDAwID8/IA0K
DQpSZWdhcmRzLA0KS2VkYXIuDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQXBwYW5hIER1
cmdhIEtlZGFyZXN3YXJhIHJhbw0KPiA+IDxhcHBhbmEuZHVyZ2EucmFvQHhpbGlueC5jb20+DQo+
ID4gLS0tDQo+ID4gLS0+IE5ldHdvcmsgZGV2aWNlcyBkZWZhdWx0IHR4X3F1ZXVlX2xlbiBpcyAx
MDAwIGJ1dCBmb3Igc29ja2V0DQo+ID4gY2FuIGRldmljZSBpdCBpcyAxMCBhbnkgcmVhc29uIGZv
ciBpdD8/DQo+ID4NCj4gPiAgZHJpdmVycy9uZXQvY2FuL2Rldi5jIHwgMiArLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9jYW4vZGV2LmMgYi9kcml2ZXJzL25ldC9jYW4vZGV2LmMgaW5k
ZXgNCj4gPiBjMDVlNGQ1Li4zMmJkNWJlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2Nh
bi9kZXYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9kZXYuYw0KPiA+IEBAIC02NDIsNyAr
NjQyLDcgQEAgc3RhdGljIHZvaWQgY2FuX3NldHVwKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpDQo+
ID4gIAlkZXYtPm10dSA9IENBTl9NVFU7DQo+ID4gIAlkZXYtPmhhcmRfaGVhZGVyX2xlbiA9IDA7
DQo+ID4gIAlkZXYtPmFkZHJfbGVuID0gMDsNCj4gPiAtCWRldi0+dHhfcXVldWVfbGVuID0gMTA7
DQo+ID4gKwlkZXYtPnR4X3F1ZXVlX2xlbiA9IDUwMDsNCj4gPg0KPiA+ICAJLyogTmV3LXN0eWxl
IGZsYWdzLiAqLw0KPiA+ICAJZGV2LT5mbGFncyA9IElGRl9OT0FSUDsNCj4gPg0KDQo=
