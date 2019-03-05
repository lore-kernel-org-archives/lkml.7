Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D78C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46512064A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="VWzY7fEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfCES5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:57:11 -0500
Received: from mail-eopbgr710066.outbound.protection.outlook.com ([40.107.71.66]:3776
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726921AbfCES5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Wu4dQoU2uTkxtdd+8pMneQ90aVgPRr5W/o3ug+wZ2M=;
 b=VWzY7fEWSIpCrTg+1SZ3bz4SAB3cY0IjigREPFqVpGZoLzhs4VcKtliOnfRWeQm3bzFagizxCh0k6zBeQJHp+odCDOTLxTWutrayJe4HddOnW/AXXaM5SyFH+6tiPlYpxDQVfREbiegp8q7l5QVRh6wZJ3RH/2iHi2oVm8OO7VI=
Received: from BYAPR02MB5992.namprd02.prod.outlook.com (20.179.89.80) by
 BYAPR02MB4744.namprd02.prod.outlook.com (52.135.232.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Tue, 5 Mar 2019 18:57:05 +0000
Received: from BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::911c:eb9a:23e7:1da8]) by BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::911c:eb9a:23e7:1da8%2]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 18:57:05 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Jann Horn <jannh@google.com>, Michal Simek <michals@xilinx.com>
CC:     Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] firmware: xilinx: fix debugfs write handler
Thread-Topic: [PATCH] firmware: xilinx: fix debugfs write handler
Thread-Index: AQHUx9L1I42szGwYakG9evuYpK7HMKX9eqlQ
Date:   Tue, 5 Mar 2019 18:57:05 +0000
Message-ID: <BYAPR02MB599297A2EB81002FA34AC401B8720@BYAPR02MB5992.namprd02.prod.outlook.com>
References: <20190218214309.29985-1-jannh@google.com>
In-Reply-To: <20190218214309.29985-1-jannh@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7223dda6-802e-45b5-e8d6-08d6a19c5c70
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB4744;
x-ms-traffictypediagnostic: BYAPR02MB4744:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtCWUFQUjAyTUI0NzQ0OzIzOjE5WE1vR010YyttMFNlNUM1VEs4UnY3RU1N?=
 =?utf-8?B?R0FONmRFNG9Fd1h3UnhaSXl4UkZlTmhPWkVoMUNMVlVobFZqVmh5YkpnOFRs?=
 =?utf-8?B?cDVxSGh3b0pkTDJZZUkxdUw2L0syb0NrSkFudy8zWFdZbzl4Ulp0QUY5MFNE?=
 =?utf-8?B?YWtraDczRDE4SGVoMkxKWTFMeGttQjdRUjJSbDBCZjJwOHM1d0VpOG5OL05N?=
 =?utf-8?B?bHBYMWlCMDV3eGpERFkrSnBwMUJmcWtSK0ZwSkhiVnFTZkdtaWhJdDNwWjd4?=
 =?utf-8?B?bE9tL0RLazFCREFnd3ZXTk9mVmljSHNoUHQvZ0d3UzdxaG9kajd6ODZGd0F4?=
 =?utf-8?B?OUVMakF4MmIwWTNHMTlKYUpHeUZrVzVidElWZ0ZEd2JjVE5qOXRRRm13YW5q?=
 =?utf-8?B?NjFYV2swajFuenVDSWlBdFY3S2dUU3VBaHpwOS9PR0Q4bXFzU0tjcDZuWCtG?=
 =?utf-8?B?NUtCYjZxeWxzN25FUEZYU1NKU1pjeFNVdFVWWE4zUTcvREk3RDRlc1F4d3U3?=
 =?utf-8?B?cUFPZG5HYTFrUlpkZFVWekx3bUI4M21ZQlN0WDZtVStVaHA3aUR0a1pJajI2?=
 =?utf-8?B?cWt4aVhHYjJyak0xbFYyeWR2eFo0L1NjUW4zZzcyTmR3aE1hNDhlajFRalBX?=
 =?utf-8?B?TUZrMDN5dlVselRESmRnNkxSL0ppeUFPTjFRSWZvUU8rK0ozZmNuZVdOR2VJ?=
 =?utf-8?B?azJHSGJKQkphWVpLWEV1SnA5cExOOXkyVmd2bmFZdURiSW5NdkFrOCtiQVg5?=
 =?utf-8?B?dFpDQnBCU0ZYOS9PWWkrT2hsRzlUMlg5V0M3VTdxQWd1ZkY1L1lvTHl5TTE1?=
 =?utf-8?B?ZWpaZG9JaWszbSt2MWkrc2xWYWpWZGRiT3lWZHczYXE4MkVYcm1rbDJpa2VF?=
 =?utf-8?B?d2RUaGZObG5xdGhvekFSMytjZjRranMrcFJiVjNVNkJIQzNabEpUOEtTQitZ?=
 =?utf-8?B?cmlWMWFIemY5Z1N6YTI4Nk9sMCtUaWZ3OVdtL2FJb1Q3dy84NnV3L0xuUzIw?=
 =?utf-8?B?S1djVXlKdWlNemZ2Z1ROYW9Gd1ozb0dROUFyVUNtYlJVbnFzdk5qY1YxS1R6?=
 =?utf-8?B?cXdVUkZHYUpDRHhQaWt3MjlOUDdEQzRMak0xaWtOL21DUEtZZjUvVWF3QTk2?=
 =?utf-8?B?N3ZkWTJ2UkRZYmFwT0psc1F5WlRpMmhDbXBqOEhoYUNUSjFmTHdzK3oxWi9z?=
 =?utf-8?B?cTFreGNoTXV3QlROaTJ6UjNiQzBqZHMrNzBEdTl0V0JlL2h6ZTQyWlAwOWdL?=
 =?utf-8?B?Z3Y1Ym82T0srWER0YVd0QWQ4ZjkwOHYwdEVhOGcvR2pqaVNSL1lmMXFpa2RV?=
 =?utf-8?B?OCtUYlN5QmxRSUxvaDJZUEw1UkYwWjZFS29XZkxHWHNmVk5HL0dkZG8xbWor?=
 =?utf-8?B?OEsyeUV6c1lrWmFRaTRiTnUrUDEyOXdTWTBocEgxL0xCWUt1d1FlTTBQUkdT?=
 =?utf-8?B?QzBrSWhacVBqcHVsWmpUeUFlQzc4VjNrUFFPNlNuK21KTDlhVkw2S0RmMDZH?=
 =?utf-8?B?TGtocVdFU3JtZGU4N3dCMkVtNEV5bzFBcVZvRkIvbURpYnYxNG5jTUVMM3o5?=
 =?utf-8?B?Sks4Rm16RjlwTlBTb0IrREtHTjk2MHFjeHFFb1dPeFF1TlpKRzViUjFPVTNu?=
 =?utf-8?B?TktSZ2VucWhWUWx0enBTQVhzc1krd1hCV3ZtSGE4Q1YyWGZGVzhjRzlNck9t?=
 =?utf-8?B?QXJMRjI4amQxcmtESlA5RTIwZDQxU3BEMnZVdXkwNHVFM0RGRHVMNkpuTnFl?=
 =?utf-8?Q?83y+LvYVMQccCO37Jhx6b1vmbKLjtVMk1uofo=3D?=
x-microsoft-antispam-prvs: <BYAPR02MB4744DEE10C22C5270C996192B8720@BYAPR02MB4744.namprd02.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(136003)(366004)(13464003)(199004)(189003)(76176011)(71200400001)(66066001)(53936002)(305945005)(229853002)(7736002)(6636002)(25786009)(53546011)(6506007)(81166006)(2906002)(74316002)(6116002)(256004)(6436002)(14444005)(3846002)(8676002)(6246003)(97736004)(71190400001)(55016002)(110136005)(9686003)(316002)(54906003)(7696005)(26005)(476003)(11346002)(14454004)(33656002)(81156014)(446003)(52536013)(99286004)(4326008)(486006)(105586002)(106356001)(102836004)(68736007)(72206003)(478600001)(5660300002)(86362001)(8936002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4744;H:BYAPR02MB5992.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UIh4ETM0AiNctkB+a+NGgqwzSodMKE1Xm6s6F14FLHK92BV/K+xVBPlmGS+f+ccL8FP8FknKFEeHzMLIQvBWvFRHQ+nYPvh5qxSxMNN/HxSlu0hPXin3rFoa4FqBdLx1VrcXvwba8FMdoDeLjTjUYvKPnil2t1yyfv+zZvJ12JfoqH5ScpCge/Ucmg71NhHZVfWTcc4aC1XGiJpnwTnqiRPpXVwyq2w2Qs1+z4HBFerkTlpjZKIxfeYCF09sKP7FdYMS4uG1ropqAbvtLkaTfGBy54yiGYy0ST+qyvFim9oTvT6hCnxEr4nRCGGn6q3Flt4wIHx0NDrJlFsdsmrDPDYuXQVsLo/5ufwkuMRk3EEY0D07GMpROBAhMtYoKSh9aVscM/AbwCsbe8I92GBgMwE7yNI3cEdqFh0zMHmYwU4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7223dda6-802e-45b5-e8d6-08d6a19c5c70
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 18:57:05.6136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWNrZWQtYnk6IEpvbGx5IFNoYWggPGpvbGx5c0B4aWxpbnguY29tPg0KDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFubiBIb3JuIDxqYW5uaEBnb29nbGUuY29tPg0K
PiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDE4LCAyMDE5IDE6NDMgUE0NCj4gVG86IE1pY2hhbCBT
aW1layA8bWljaGFsc0B4aWxpbnguY29tPjsgamFubmhAZ29vZ2xlLmNvbQ0KPiBDYzogUmFqYW4g
VmFqYSA8UkFKQU5WQHhpbGlueC5jb20+OyBKb2xseSBTaGFoIDxKT0xMWVNAeGlsaW54LmNvbT47
IGxpbnV4LQ0KPiBhcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIXSBmaXJtd2FyZTogeGlsaW54OiBmaXgg
ZGVidWdmcyB3cml0ZSBoYW5kbGVyDQo+IA0KPiAgLSBVc2Vyc3BhY2Ugd2FudHMgdG8gd3JpdGUg
YSBzdHJpbmcgd2l0aCBgbGVuYCBieXRlcywgbm90IGNvdW50aW5nIHRoZQ0KPiAgICB0ZXJtaW5h
dGluZyBOVUxMLCBzbyB3ZSBzaG91bGQgYWxsb2NhdGUgYGxlbisxYCBieXRlcy4gSXQgbG9va3Mg
bGlrZSB0aGUNCj4gICAgY3VycmVudCBjb2RlIHJlbGllZCBvbiBoYXZpbmcgYSBudWxsYnl0ZSBk
aXJlY3RseSBiZWhpbmQgYGtlcm5fYnVmZmAsDQo+ICAgIHdoaWNoIGhhcHBlbnMgdG8gd29yayBy
ZWxpYWJseSBhcyBsb25nIGFzIGBsZW5gIGlzbid0IG9uZSBvZiB0aGUga21hbGxvYw0KPiAgICBz
aXplIGNsYXNzZXMuDQo+ICAtIHN0cm5jcHlfZnJvbV91c2VyKCkgaXMgY29tcGxldGVseSB3cm9u
ZyBoZXJlOyB1c2Vyc3BhY2UgaXMgZ2l2aW5nIHVzIGENCj4gICAgKG5vdCBuZWNlc3NhcmlseSBu
dWxsLXRlcm1pbmF0ZWQpIGJ1ZmZlciBhbmQgaXRzIGxlbmd0aC4NCj4gICAgc3RybmNweV9mcm9t
X3VzZXIoKSBpcyBmb3IgY2FzZXMgaW4gd2hpY2ggd2UgZG9uJ3Qga25vdyB0aGUgbGVuZ3RoLg0K
PiAgLSBEb24ndCBsZXQgYnJva2VuIHVzZXJzcGFjZSBhbGxvY2F0ZSBhcmJpdHJhcmlseSBiaWcg
a21hbGxvYyBhbGxvY2F0aW9ucy4NCj4gDQo+IEp1c3QgdXNlIG1lbWR1cF91c2VyX251bCgpLCB3
aGljaCBpcyBkZXNpZ25lZCBwcmVjaXNlbHkgZm9yIHRoaW5ncyBsaWtlDQo+IHRoaXMuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBKYW5uIEhvcm4gPGphbm5oQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiBX
QVJOSU5HOiBjb21wbGV0ZWx5IHVudGVzdGVkIHBhdGNoDQo+IA0KPiBkcml2ZXJzL2Zpcm13YXJl
L3hpbGlueC96eW5xbXAtZGVidWcuYyB8IDE1ICsrKystLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9maXJtd2FyZS94aWxpbngvenlucW1wLWRlYnVnLmMNCj4gYi9kcml2ZXJzL2Zp
cm13YXJlL3hpbGlueC96eW5xbXAtZGVidWcuYw0KPiBpbmRleCAyNzcxZGY2ZGYzNzkuLjkwYjY2
Y2RiZmQ1OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9maXJtd2FyZS94aWxpbngvenlucW1wLWRl
YnVnLmMNCj4gKysrIGIvZHJpdmVycy9maXJtd2FyZS94aWxpbngvenlucW1wLWRlYnVnLmMNCj4g
QEAgLTE2MywyMSArMTYzLDE0IEBAIHN0YXRpYyBzc2l6ZV90IHp5bnFtcF9wbV9kZWJ1Z2ZzX2Fw
aV93cml0ZShzdHJ1Y3QNCj4gZmlsZSAqZmlsZSwNCj4gDQo+ICAJc3RyY3B5KGRlYnVnZnNfYnVm
LCAiIik7DQo+IA0KPiAtCWlmICgqb2ZmICE9IDAgfHwgbGVuID09IDApDQo+ICsJaWYgKCpvZmYg
IT0gMCB8fCBsZW4gPD0gMSB8fCBsZW4gPiBQQUdFX1NJWkUgLSAxKQ0KPiAgCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gDQo+IC0Ja2Vybl9idWZmID0ga3phbGxvYyhsZW4sIEdGUF9LRVJORUwpOw0KPiAt
CWlmICgha2Vybl9idWZmKQ0KPiAtCQlyZXR1cm4gLUVOT01FTTsNCj4gLQ0KPiArCWtlcm5fYnVm
ZiA9IG1lbWR1cF91c2VyX251bChwdHIsIGxlbik7DQo+ICsJaWYgKElTX0VSUihrZXJuX2J1ZmYp
KQ0KPiArCQlyZXR1cm4gUFRSX0VSUihrZXJuX2J1ZmYpOw0KPiAgCXRtcF9idWZmID0ga2Vybl9i
dWZmOw0KPiANCj4gLQlyZXQgPSBzdHJuY3B5X2Zyb21fdXNlcihrZXJuX2J1ZmYsIHB0ciwgbGVu
KTsNCj4gLQlpZiAocmV0IDwgMCkgew0KPiAtCQlyZXQgPSAtRUZBVUxUOw0KPiAtCQlnb3RvIGVy
cjsNCj4gLQl9DQo+IC0NCj4gIAkvKiBSZWFkIHRoZSBBUEkgbmFtZSBmcm9tIGEgdXNlciByZXF1
ZXN0ICovDQo+ICAJcG1fYXBpX3JlcSA9IHN0cnNlcCgma2Vybl9idWZmLCAiICIpOw0KPiANCj4g
LS0NCj4gMi4yMS4wLnJjMC4yNTguZzg3OGUyY2QzMGUtZ29vZw0KDQo=
