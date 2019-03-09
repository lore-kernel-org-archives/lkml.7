Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355D0C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 05:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1C4207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 05:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nqWe9qnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfCIFOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 00:14:44 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:53200 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfCIFOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 00:14:44 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c834bbc0000>; Sat, 09 Mar 2019 13:14:36 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 08 Mar 2019 21:14:36 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 08 Mar 2019 21:14:36 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 9 Mar
 2019 05:14:34 +0000
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.50) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 9 Mar 2019 05:14:34 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3365.namprd12.prod.outlook.com (20.178.55.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.17; Sat, 9 Mar 2019 05:14:31 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26%5]) with mapi id 15.20.1686.020; Sat, 9 Mar 2019
 05:14:30 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Asutosh Das <asutoshd@codeaurora.org>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V1 07/11] mmc: cqhci: add quirk for setting DCMD
 CMD_TIMING
Thread-Topic: [PATCH V1 07/11] mmc: cqhci: add quirk for setting DCMD
 CMD_TIMING
Thread-Index: AQHU0Le8XNfDXr1Gi0eUvv60djK956X+l9EAgADl9YCAAP/PoIABNiUAgAEXe2A=
Date:   Sat, 9 Mar 2019 05:14:30 +0000
Message-ID: <BYAPR12MB3398438AEB0E9D2625758406C24E0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
 <1551504025-3541-7-git-send-email-skomatineni@nvidia.com>
 <a320c841-7e58-4d3e-5df6-61e10520d9d8@intel.com>
 <a544bc6d-7b23-53e8-16d0-ee0eaf576eb2@codeaurora.org>
 <BYAPR12MB33984D80A404EF919F3A86A0C24C0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <1fa6f529-2cb8-0108-2041-99ad9b39498f@intel.com>
In-Reply-To: <1fa6f529-2cb8-0108-2041-99ad9b39498f@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d97956d-0af3-4b5f-b8f3-08d6a44e1c5c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3365;
x-ms-traffictypediagnostic: BYAPR12MB3365:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIzMzY1OzIzOjd1REMwUklHYU9TQU1iOG5Wd2VaOG1yTWNB?=
 =?utf-8?B?cUUwMG82eHpodTdrZUJhbE8wazAyRnV2cXNXMkhPZm01NVByOTkxWC8ydDJN?=
 =?utf-8?B?a20xODNjNThYWTA1d0pubDd5WUdSVUs5akh6eENURkhLcUdIckRuRURkL25l?=
 =?utf-8?B?Tm92UXFuQ3Z4ZThqNFJhdVI0REdwL1ZSb1lxaVRoQnFWNHRabU5MT3dZZUZR?=
 =?utf-8?B?RVJGNXo3UzdFcjFVZUlXYzk5QVRTc0pCTGV1clVOV0tCVHZqemRlNVdWSkI1?=
 =?utf-8?B?aUtyUTM2ZEdUT21jK3MzNm5DalhSN3IvR3pqZmx0Q2g1VWh1bk1yWERFN0xB?=
 =?utf-8?B?dU85ZWUyY24wMUVBUGRiV1FneWRNZ21WNVBoOVdFUnExS1NGbldtdFRkd2RW?=
 =?utf-8?B?UHRYcC8wWS9lQWhCOW81ZnNublQ3dVJ1RDZQaEhNazc3clhNSWQvZDVKU0ZM?=
 =?utf-8?B?TDI3SjZwbTMrc3Bid1R4SlU2RVFxZ090eHhpWGxHNnRYcmEzRm11NWxZYzRN?=
 =?utf-8?B?WTlNakg1Q2ZZQk5mRWJnY3BleHVTWmtPbUVjK3NybHNRZ0lVaEExZXBvWU1s?=
 =?utf-8?B?UGp4MVZhMlhoK1lXeW8zS0d3Ry9kL283S21MZW93aDlSbWxYWVFSR2o3TCt3?=
 =?utf-8?B?b3dxbVpmQjZzb0RUa0dGZnZuclkvSHkweXMzRXhtTnJkR2FxMDJLZDFqRy9M?=
 =?utf-8?B?cnFsOEViWVlVRXdHWWZRaGt1ZHRieUQ2NHI5OFByTzUxUmR5Qml4MlczdjVj?=
 =?utf-8?B?Tk1lZDYrdHpkUFpxNjgyY1VMdWg4QjR0UVc4QkMza3NnR0c2OHU0MXAyM3ZU?=
 =?utf-8?B?SDFrWmtWalNvMTg4SXhweExxelEwMDVDd0FvT0JVMmNGaGZwQ0R0QThzejNV?=
 =?utf-8?B?WG9jcTNUaHN0ditoOWZkS0I0ZFlmbXh4T0l1NC9GaVNmTSs4YmJ3Q2IvVFFt?=
 =?utf-8?B?ZXpnZ3YvR3YzdVN1cm9NbjZwcDl1NlRNTitDVjkwckQvOWdjTWtKYTVrYlZH?=
 =?utf-8?B?WEozcVcwdThpNWdSMXRVb1U2KzkwWk9KTDBhY0RNd0o5dFZXRlRkNHVtTmNR?=
 =?utf-8?B?UDdyK2crTzhZUkJFVExNZjhjWDR1eVVoMWEyNXJmRm5PdmxFME1xdHdTc2pi?=
 =?utf-8?B?MXdRQnlOOWtvUys2Mm9ZZDhKcFhIcVFzRytVVmxWNnJMTEpOdFRmeENMWDBQ?=
 =?utf-8?B?TkVmY3luY2MyRktkeXdST2c3a3JTS0d3Z1l4L1FPV01MbXF5RWtKaENabjZ1?=
 =?utf-8?B?eFJ6RFVzWnZudTZtOW1XRkNhSU1qcUhsVWtQNDBib2orT2VZVHRaL09kTHhX?=
 =?utf-8?B?bllRclgyQ2xXcXBjeVdaSlVWNHc2Q1FkRXp6d0gzTUVQLzZ1QVpnNzZQM1R6?=
 =?utf-8?B?UG53YUl1NTcvRmJNQXdIV0M1QklTaG5OeE83N2JZOUcvZUdLOHVUalJTeXZk?=
 =?utf-8?B?VGJMRUlXYzhEMEhlZ2U1b0xpejFVakZRUTc0aVFMeWwrdWg5QUZFTmZEb2s5?=
 =?utf-8?B?eStYQzdTZG05NXUvbE5IcStIQkVYaVdZZlpMTE5KR2JyV0F6a1hBSmowQmVx?=
 =?utf-8?B?SmhrTWxTUVhvOGlFa3J6blJ1RzhzWlFjaFc3c0tGRFpVQjU0QUlraHVSUy9Z?=
 =?utf-8?B?RXNjcVMwcUhabW4wbWNOREM4d2w0M2ZodEJyeFV0YjNEbVNjcG5WZnluK0o0?=
 =?utf-8?B?cUpONSs1ZFNWNy9HaVh0ajBzVml3L0pPS1MwczFYdi9ObHZteUV2cnphMTNK?=
 =?utf-8?Q?gE3o1d2y4upavej7DMPWbx9/dlbuuLIM68t4E=3D?=
x-microsoft-antispam-prvs: <BYAPR12MB33650F563B46AC3C5A3244CFC24E0@BYAPR12MB3365.namprd12.prod.outlook.com>
x-forefront-prvs: 0971922F40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(136003)(39850400004)(189003)(199004)(8936002)(256004)(7736002)(68736007)(2501003)(305945005)(476003)(53936002)(446003)(74316002)(6246003)(81166006)(11346002)(76176011)(81156014)(93886005)(54906003)(66066001)(8676002)(316002)(478600001)(486006)(110136005)(33656002)(99286004)(9686003)(2906002)(7696005)(25786009)(7416002)(5660300002)(105586002)(6116002)(55016002)(229853002)(6506007)(6436002)(14454004)(97736004)(86362001)(4326008)(53546011)(71200400001)(102836004)(186003)(71190400001)(26005)(3846002)(52536013)(106356001)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3365;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L0Dhpz0kKaTca9Oy8LRV7yJZeBJ/GnTcb3k7XyWPeMWuRT0qOlFA8Sx+l3un84cWoAkISdE555/jWym9ECXTTmKI02pAKYYh2atjLErjMv2XT53FW4o9CZhItBxwemLYjfcLgvm1E43fU4iI/RD061KxXtY4ied2MGLRgvKaJlfw3M1nQ+N/LTGkPzKRMRep7O04TmrPLPCyApcVEQGfmc9iggjkkf1Ccy9fQ15tzfJZYJVlGl8LI+38qtPN7yJ5xHZVAUlD6NZFwYAPwXL/vpjRa9ICppZ3RwZMsa3/WsAMkeyxiIWC7OiQta4qUg86VdBRKCQ/lF3h36ugoexsGh2hlE+9zDwQrn83eSI36sOhM6pk5exNpf593ixegk2lyK/qRLwFi4RTGHblusy6uhJQPRIzBCzs4moVbTGXKzs=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d97956d-0af3-4b5f-b8f3-08d6a44e1c5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2019 05:14:30.7915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3365
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552108476; bh=RtGasEHj1tQXRzY7rJbI3jhabWDUZ2+YATTx1ZRk7nM=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-microsoft-antispam:x-ms-traffictypediagnostic:
         x-microsoft-exchange-diagnostics:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=nqWe9qnVzUru1BORP2THDerv5iy4S9FlGfr9sGQ9Nlg2VnsrhnskUroXmm0ULhZyP
         mzbHsgbeqelcyA35dizYxLWVnuO/QBb8FeNLZOXbD4XhnZG3XhhEgOXrzZ75Ijyn/1
         w0CgZIhAZSB0IhkPedFgSi/XRR36QAHABzoRdV+1fAQznrfyfMqUXeaTSc+RKQDZHY
         fyLRx7hiFYeokhB4XxTLn6lniBTmGr0SyEjqyJBipt7gfKZnAkpcs+VJZsgguMdXyk
         TYSNZojqgwHKNllr8MKysF7fgaYQQSboW16BubDgL2krsBG3VYmN0LIzXdg9LMoub7
         UqgcwckRepJUg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiA3LzAzLzE5IDg6MTYgUE0sIFNvd2phbnlhIEtvbWF0aW5lbmkgd3JvdGU6DQo+PiANCj4+
PiBPbiAzLzYvMjAxOSA2OjMwIFBNLCBBZHJpYW4gSHVudGVyIHdyb3RlOg0KPj4+PiBPbiAyLzAz
LzE5IDc6MjAgQU0sIFNvd2phbnlhIEtvbWF0aW5lbmkgd3JvdGU6DQo+Pj4+PiBUaGlzIHBhdGNo
IGFkZHMgYSBxdWlyayBmb3Igc2V0dGluZyBDTURfVElNSU5HIHRvIDEgaW4gZGVzY3JpcHRvciAN
Cj4+Pj4+IGZvciBEQ01EIHdpdGggUjFCIHJlc3BvbnNlIHR5cGUgdG8gYWxsb3cgdGhlIGNvbW1h
bmQgdG8gYmUgc2VudCB0byANCj4+Pj4+IGRldmljZSBkdXJpbmcgZGF0YSBhY3Rpdml0eSBvciBi
dXN5IHRpbWUuDQo+Pj4+Pg0KPj4+Pj4gVGVncmExODYgQ1FIQ0kgaG9zdCBoYXMgYnVnIHdoZXJl
IGl0IHNlbGVjdHMgREFUQV9QUkVTRU5UX1NFTEVDVCB0byANCj4+Pj4+IDEgYnkgQ1FIQ0kgY29u
dHJvbGxlciBmb3IgRENNRHMgd2l0aCBSMUIgcmVzcG9uc2UgdHlwZSBhbmQgc2luY2UgDQo+Pj4+
PiBEQ01EIGRvZXMgbm90IHRyaWdnZXIgYW55IGRhdGEgdHJhbnNmZXIsIERDTUQgdGFzayBjb21w
bGV0ZSBoYXBwZW5zIA0KPj4+Pj4gbGVhdmluZyB0aGUgREFUQSBGU00gb2YgaG9zdCBjb250cm9s
bGVyIGluIHdhaXQgc3RhdGUgZm9yIGRhdGEuDQo+Pj4+Pg0KPj4+Pj4gVGhpcyBlZmZlY3RzIHRo
ZSBkYXRhIHRyYW5zZmVyIHRhc2sgaXNzdWVkIGFmdGVyIFIxQiBEQ01EIHRhc2sgYW5kIA0KPj4+
Pj4gbm8gaW50ZXJydXB0IGlzIGdlbmVyYXRlZCBmb3IgdGhlIGRhdGEgdHJhbnNmZXIgdGFzay4N
Cj4+Pj4+DQo+Pj4+PiBTVyBXQVIgZm9yIHRoaXMgaXNzdWUgaXMgdG8gc2V0IENNRF9USU1JTkcg
Yml0IHRvIDEgaW4gRENNRCB0YXNrIA0KPj4+Pj4gZGVzY3JpcHRvciBhbmQgYXMgRENNRCB0YXNr
IGRlc2NyaXB0b3IgcHJlcGFyYXRpb24gaXMgZG9uZSBieSBjcWhjaSANCj4+Pj4+IGRyaXZlciwg
dGhpcyBwYXRjaCBhZGRzIGNxZXF1aXJrIHRvIGhhbmRsZSB0aGlzLg0KPj4+Pj4NCj4+Pj4+IFNp
Z25lZC1vZmYtYnk6IFNvd2phbnlhIEtvbWF0aW5lbmkgPHNrb21hdGluZW5pQG52aWRpYS5jb20+
DQo+Pj4+PiAtLS0NCj4+Pj4+ICAgZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5jIHwgNSArKysrLQ0K
Pj4+Pj4gICBkcml2ZXJzL21tYy9ob3N0L2NxaGNpLmggfCAxICsNCj4+Pj4+ICAgMiBmaWxlcyBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pj4+DQo+Pj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5jIGIvZHJpdmVycy9tbWMvaG9zdC9jcWhj
aS5jIA0KPj4+Pj4gaW5kZXggYThhZjY4MmE5MTgyLi5iMzRjMDcxMjVmMzIgMTAwNjQ0DQo+Pj4+
PiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L2NxaGNpLmMNCj4+Pj4+ICsrKyBiL2RyaXZlcnMvbW1j
L2hvc3QvY3FoY2kuYw0KPj4+Pj4gQEAgLTUyMSw3ICs1MjEsMTAgQEAgc3RhdGljIHZvaWQgY3Fo
Y2lfcHJlcF9kY21kX2Rlc2Moc3RydWN0IG1tY19ob3N0ICptbWMsDQo+Pj4+PiAgIAl9IGVsc2Ug
ew0KPj4+Pj4gICAJCWlmIChtcnEtPmNtZC0+ZmxhZ3MgJiBNTUNfUlNQX1IxQikgew0KPj4+Pj4g
ICAJCQlyZXNwX3R5cGUgPSAweDM7DQo+Pj4+PiAtCQkJdGltaW5nID0gMHgwOw0KPj4+Pj4gKwkJ
CWlmIChjcV9ob3N0LT5xdWlya3MgJiBDUUhDSV9RVUlSS19DTURfVElNSU5HX1IxQl9EQ01EKQ0K
Pj4+Pj4gKwkJCQl0aW1pbmcgPSAweDE7DQo+Pj4+PiArCQkJZWxzZQ0KPj4+Pj4gKwkJCQl0aW1p
bmcgPSAweDA7DQo+Pj4+IEkgd2FzIHRoaW5raW5nIGl0IHdvdWxkIGJlIG5pY2UgaWYgdGhlcmUg
d2FzIGEgZ2VuZXJpYyB3YXkgZm9yIA0KPj4+PiBkcml2ZXJzIHRvIG1ha2UgY2hhbmdlcyB0byBk
ZXNjcmlwdG9ycyBiZWZvcmUgYSB0YXNrIGlzIHN0YXJ0ZWQuICANCj4+Pj4gQ3VycmVudGx5IHRo
ZXJlIGlzDQo+Pj4+IGhvc3QtPm9wcy0+d3JpdGVfbCgpIHdoaWNoIHdvdWxkIG1ha2UgaXQgcG9z
c2libGUgYnkgY2hlY2tpbmcgZm9yIA0KPj4+PiBob3N0LT5vcHMtPkNRSENJX1REQlINCj4+Pj4g
cmVnaXN0ZXIgYW5kLCBpbiB0aGlzIGNhc2UsIHRoZSBEQ01EIHRhZy4gIFdlIHdvdWxkIG5lZWQg
dG8gZXhwb3J0IA0KPj4+PiBnZXRfZGVzYygpLCBwZXJoYXBzIHJlbmFtZSBpdCBjcWhjaV9nZXRf
ZGVzYygpIGFuZCBwdXQgaXQgaW4gY3FoY2kuaCANCj4+Pj4gc2luY2UgaXQgaXMgYW4gaW5saW5l
IGZ1bmN0aW9uLg0KPj4+DQo+Pj4gV2UgdGFrZSBzcGluX2xvY2tfaXJxc2F2ZSBhZnRlciB0aGUg
ZGVzY3JpcHRvciBpcyBwcmVwYXJlZCBhbmQgYmVmb3JlIHdyaXRpbmcgdG8gVERCUi4NCj4+PiBO
b3Qgc3VyZSBidXQgdG9tb3Jyb3cgdGhpcyBtYXkgYmVjb21lIGEgbGltaXRhdGlvbiBmb3IgZHJp
dmVycyB0byBtYWtlIGNoYW5nZXMgdG8gZGVzY3JpcHRvcnMgaWYgdGhleSBlZGl0IGRlc2NyaXB0
b3JzIGluIGhvc3QtPm9wcy0+d3JpdGVfbCgpIGNhbGwuDQo+Pj4gVGhvdWdoIGluIHRoaXMgY2Fz
ZSBpdCBpcyBub3QgcmVxdWlyZWQgaGVyZS4NCj4+Pg0KPj4+Pg0KPj4+PiBBbHRlcm5hdGl2ZWx5
IHdlIGNvdWxkIGFkZCBob3N0LT5vcHMgZm9yIGRlc2NyaXB0b3IgcHJlcGFyYXRpb24uDQo+Pj4N
Cj4+PiBCb3RoIHdheXMgc291bmRzIGdvb2QgdG8gbWUuDQo+Pj4gQnV0IG1heWJlIGFkZGluZyBh
IGhvc3QtPm9wcyBmb3IgZGVzY3JpcHRvciBwcmVwYXJhdGlvbiBpcyBiZXR0ZXIgd2F5IA0KPj4+
IHRvIGdvLCBzaW5jZSB0aGF0IHdpbGwgYmUgdGhlIHJpZ2h0IGludGVyZmFjZSBleHBvc2VkIHRv
IG1ha2UgY2hhbmdlcyANCj4+PiB0byBkZXNjcmlwdG9ycy4NCj4+Pg0KPj4gDQo+PiBEQ01EIGRl
c2NyaXB0b3IgYXR0cmlidXRlcyByZW1haW4gc2FtZSBmb3IgYW55IGhvc3QgYW5kIGFsc28gdGFz
ayBwYXJhbWV0ZXJzIGFzIFFCUiBuZWVkIHRvIGJlIGVuYWJsZWQgd2l0aCBEQ01ELg0KPj4gU28g
SSBiZWxpZXZlIGl0IHNob3VsZCBiZSBvayBpZiB3ZSBqdXN0IGFkZCBjYWxsYmFjayB0byBhbGxv
dyBob3N0cyB0byB1cGRhdGUgY29tbWFuZCBwYXJhbWV0ZXJzIG9mIERDTUQgZGVzY3JpcHRvciBv
bmx5IHRocnUgY3FoY2lfaG9zdF9vcHMuDQo+DQo+VGhhdCBzb3VuZHMgZmluZSB0byBtZS4gIE1h
eWJlIGRvIHRoYXQgZm9yIHRoZSBuZXh0IHZlcnNpb24gb2YgdGhpcyBwYXRjaHNldC4NCg0KVGhh
bmtzIEFkcmlhbi4gQWN0dWFsbHksIERDTUQgY29tbWFuZCBwYXJhbWV0ZXJzIGluY2x1ZGUgb3Bj
b2RlLCB0aW1pbmcsIGFuZCByZXNwb25zZSB0eXBlIHdoZXJlIG9wY29kZSBhbmQgcmVzcG9uc2Ug
dHlwZSBzdGF5cyBzYW1lLg0KU28gSSBvbmx5IHNlZSBuZWVkIGZvciBob3N0cyB0byBjaG9vc2Ug
Y21kIHRpbWluZyB0byBjb250cm9sIGlmIGhhcmR3YXJlIHNob3VsZCB3YWl0IGZvciBidXN5IHRp
bWUgb3Igbm90IGJhc2ljYWxseSB0byBzZW5kIGNvbW1hbmQgZHVyaW5nIGJ1c3kgb3IgaWRsZSB0
aW1lLg0KDQpXaWxsIGFkZCBjcWhjaV9ob3N0X29wcyBpbnRlcmZhY2UgdG8gYWxsb3cgaG9zdCBk
cml2ZXIgdG8gY2hvb3NlIGNtZCB0aW1pbmcgYW5kIHdpbGwgc2VuZCBhbG9uZyB3aXRoIHRoZSBv
dGhlciB0dW5pbmcgcmVsYXRlZCBmZWVkYmFjayBmaXhlcyBvZiB0aGlzIHNlcmllcy4NCg0KPj4g
DQo+PiBBbHNvLCBkb27igJl0IHNlZSBhbnkgcmVxdWlyZW1lbnQgZm9yIGhvc3Qgc3BlY2lmaWMg
VGFzayBwYXJhbWV0ZXIgdXBkYXRlcyBpbiBUYXNrIGRlc2NyaXB0b3Igc28gbm90IHN1cmUgaWYg
dGhlcmUgaXMgYW55IG5lZWQgdG8gcHJvdmlkZSBjYWxsYmFjayBmb3IgdGFzayBkZXNjcmlwdG9y
IGRhdGEgcHJlcGFyYXRpb24gdG8gaG9zdHMuDQo+PiBQbGVhc2UgY29uZmlybS4NCj4+IA0KPj4+
Pg0KPj4+PiBXaGF0IGRvIHBlb3BsZSB0aGluaz8NCj4+Pj4NCj4+Pj4+ICAgCQl9IGVsc2Ugew0K
Pj4+Pj4gICAJCQlyZXNwX3R5cGUgPSAweDI7DQo+Pj4+PiAgIAkJCXRpbWluZyA9IDB4MTsNCj4+
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L2NxaGNpLmggYi9kcml2ZXJzL21tYy9o
b3N0L2NxaGNpLmggDQo+Pj4+PiBpbmRleCA5ZTY4Mjg2YTA3YjQuLmY5NmQ4NTY1Y2MwNyAxMDA2
NDQNCj4+Pj4+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvY3FoY2kuaA0KPj4+Pj4gKysrIGIvZHJp
dmVycy9tbWMvaG9zdC9jcWhjaS5oDQo+Pj4+PiBAQCAtMTcwLDYgKzE3MCw3IEBAIHN0cnVjdCBj
cWhjaV9ob3N0IHsNCj4+Pj4+ICAgDQo+Pj4+PiAgIAl1MzIgcXVpcmtzOw0KPj4+Pj4gICAjZGVm
aW5lIENRSENJX1FVSVJLX1NIT1JUX1RYRlJfREVTQ19TWgkweDENCj4+Pj4+ICsjZGVmaW5lIENR
SENJX1FVSVJLX0NNRF9USU1JTkdfUjFCX0RDTUQJMHgyDQo+Pj4+PiAgIA0KPj4+Pj4gICAJYm9v
bCBlbmFibGVkOw0KPj4+Pj4gICAJYm9vbCBoYWx0ZWQ7DQo+Pj4+Pg0KDQo=
