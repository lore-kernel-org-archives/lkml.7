Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC4EC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C6820675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="WmxPBiHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbfCFK5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:57:51 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:49935 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729515AbfCFK5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:57:50 -0500
X-IronPort-AV: E=Sophos;i="5.58,447,1544511600"; 
   d="scan'208";a="28797204"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 06 Mar 2019 03:57:48 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 6 Mar 2019 03:57:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3kliFqTEAfT+oqQpbdrKF7FmTuvuSA5e28tySC2HPE=;
 b=WmxPBiHjxrb5qikdZTtwGxrGrHjgbt+35eFKrBpyIEDOw3Rxjli5p2CBnSxY9SjVxDjTYNOHU6X3unOzcimm9oaM/5G10d0ZVxbmh+JswpVD/mFs559CAfdwLjxKz6uL6x09cFT8Bj6caEP/G/aUC7WxtI1hk/cuzbF1PkAjjvI=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1279.namprd11.prod.outlook.com (10.169.237.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Wed, 6 Mar 2019 10:57:46 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::5413:49b5:8548:fe44]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::5413:49b5:8548:fe44%8]) with mapi id 15.20.1665.019; Wed, 6 Mar 2019
 10:57:45 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <axel.lin@ingics.com>, <linux-kernel@vger.kernel.org>
CC:     <broonie@kernel.org>, <radu_nicolae.pirea@upb.ro>,
        <lee.jones@linaro.org>, <linux-spi@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>, <Cristian.Birsan@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] spi: at91-usart: Remove duplicated checking for
 spi->bits_per_word
Thread-Topic: [PATCH] spi: at91-usart: Remove duplicated checking for
 spi->bits_per_word
Thread-Index: AQHU1AtuMmC+asDYR0KwOSW1eOUxHQ==
Date:   Wed, 6 Mar 2019 10:57:45 +0000
Message-ID: <5978e11c-9858-15c7-2821-73d09f5ffa38@microchip.com>
References: <20181002101010.29723-1-axel.lin@ingics.com>
In-Reply-To: <20181002101010.29723-1-axel.lin@ingics.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0080.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::20) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0331da8-943a-4ea5-4e25-08d6a222906c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1279;
x-ms-traffictypediagnostic: MWHPR11MB1279:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxMjc5OzIzOnBtNVEwSkZBbDJLZSs4c2JSdmRkL051Z2pI?=
 =?utf-8?B?VjY2VFpLRzJ1ZHcyTk5rRktRT0NTTDRQaWJGWFFGazd0SGt4ZGtrRXU1SDYx?=
 =?utf-8?B?c281WEJtMWowSlF6eUFGeTk1VThTTy9OODE2NFJ3Z2tMbldhNEZHbVJNM1dU?=
 =?utf-8?B?Rk9ZcFJEbFBZR3NNVzk0Q2ZVWjRyZXVjWEJ3Sk5CUjI0Wkx5T2N5VWFUc0tJ?=
 =?utf-8?B?RVNZOTRJRXgxUGxPUXMxMUUzNnYwK012VHo5eTIzWk9YbE5STTlxVzQ3NGNT?=
 =?utf-8?B?cjIyNU81azByeitiOVBXWjR5Q0dlOTg0bVNlMTdaK1diOEpKTW1LMmltU2NG?=
 =?utf-8?B?N05vOUpzQzloOFlvV1p5QnJTTWFFdDFhdHZJTm4zZ1d4T29mTm1FOExzRy92?=
 =?utf-8?B?ckVJSkpxSkYwYmdtTkduMlFKOHE3QTNtRFJNYTV5Wld4VGlYaTh3TGRKMlhj?=
 =?utf-8?B?MmNqQlJlL3FFdVRsTDczd2grU0pSQzlJVVFsZFJzV1ZWa1djR3VsRktGL25E?=
 =?utf-8?B?eDdrbkxxSjYwUlBOT0c4RGJQVDcxS2dGVUtpSDRBVGhaRVlDQ1FBZk1zalFD?=
 =?utf-8?B?N2c5SWZzd1pYaXNaVFp4bEdpODFXbFFiRDVpdEovZUZ4aU00ZE14SHhXT3lS?=
 =?utf-8?B?NW5JcER1ZXpJVmJSRUdhYkRGVzl5RE9ybTVjTzREZzIwSXhtcWtRaEhJMHk2?=
 =?utf-8?B?NlhNSUdJNng0Umt1ZTN4NEtKTTdIWTNrdFF5bXFhQ3IyQmRsZ0Q5TlkzbUtu?=
 =?utf-8?B?ZllNT2FwT2FKSDF5KzNUcGp6aTIzblhsV3dIcEVVZ0RuNU9wcTVYaU1oczZI?=
 =?utf-8?B?V1N6TG4reEMreHJlQTIzNFRhS08zSWNVbTZtNFBCeUxFUVFyNnFnT0FHUUkx?=
 =?utf-8?B?SXNVWXpTQ0dnY2RIRVBmdytnb0ltMGNUVmRxWGs1cHNqN3hiRW82aVlSM3kr?=
 =?utf-8?B?d3ljU1o3ams1bDBRK0N3MjM1eThYSUFPUFdoWUY2OFExaTBvMUpFOTEzZzUx?=
 =?utf-8?B?Q0REbGloT1pJNnJRS1MyQXpmcmpoK1ZFL3ZIZ0tWdWRBMjNUby92TUlONy8r?=
 =?utf-8?B?RlcwQjlOV1dHOXJWVEY1ZnFXaWJxY2MxejBrNHRBeEFHSUJjQU5VL3RTT3hz?=
 =?utf-8?B?UE0rWE9oWmhIT1VycXk5QkVYNTJweDlPUUkxakl6cjZxaXVYcFdiQ1F3OE5E?=
 =?utf-8?B?cGhlU3ZrK3JuNnB2VVVVdkt1ZHJISzRDNHdOOGlCemgyU1Vxb0IrU25RYmh3?=
 =?utf-8?B?MVJrdHFmSVROK3FzR1BHbTRmUnFGMFFPY0JNTzcwYkRselFDKzM0S2J5Nndi?=
 =?utf-8?B?V3Zmc2FHUmdlS0QxbVpvQnNCcGdZVUZNaklsT1J5cU8yNGMweUlacDJrK2Mw?=
 =?utf-8?B?b1ROWEZsR1l2UDBPVW1rZVliL0plTUNZVnVnbjdaVm5WS20ydjNtZmJRZjkv?=
 =?utf-8?B?MkgwVWxJMTdLV0hZTVVmVTBzUmxrd29Lc3psYmw2dzNNekxQNHdZVE9xMm9M?=
 =?utf-8?B?dXorQzVQNnZVTndGL21DaW1EVnB5aUhNbVd2emxzem5JTmlEblRURFpFd2sy?=
 =?utf-8?B?UFowWGZ3dVl3aGdpS2JCaWpyWU9yZGViUFhiSUpKY1R2QjlLZXpaVllvTGVh?=
 =?utf-8?B?UmQvMGhWQnl5VGFVci95enk0ZE9nbzhCQ1dUbDREY0VJV0JhSGpjaVNtS2oy?=
 =?utf-8?B?Y2pRb09vMkcvb0x3YWhYMytrMTJQdk0rbEdPUmM2QnU2by9iazgxQ1d3RVM4?=
 =?utf-8?B?WVorTE0zWlIxUHJiK1VKQThGbTU5T1cwRHB6b0I5d3lWc2htTWFKSE5hT2Ro?=
 =?utf-8?Q?Cn8aHXEs6GtRr?=
x-microsoft-antispam-prvs: <MWHPR11MB127924BBA31076C3742A7FBAE0730@MWHPR11MB1279.namprd11.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(366004)(199004)(189003)(81156014)(106356001)(105586002)(8676002)(81166006)(36756003)(2906002)(25786009)(6436002)(4326008)(7736002)(71200400001)(305945005)(71190400001)(6486002)(229853002)(14444005)(256004)(31686004)(6246003)(53936002)(66066001)(68736007)(8936002)(6512007)(72206003)(14454004)(2501003)(86362001)(31696002)(478600001)(54906003)(110136005)(2616005)(476003)(186003)(446003)(486006)(5660300002)(11346002)(76176011)(99286004)(26005)(6506007)(386003)(53546011)(316002)(52116002)(3846002)(102836004)(6116002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1279;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iEk2fwcB8R/tFjucjpuC/s/PVBbOpGZHKnnttVyNuL7ZLRUnN+h2AHknzleVqA0/4Yhcv2sDCc2p6s8QOdD6mlzjkUGNPx12Lwlvbn5FQ2ShrWufw2eteEI17CzOVEU09pFxh5HdA80ym9Jz86DuKfyidY3HNgDIIrHu4wjBQbYfycWHCtr5USmUZPMjgssk1aMbZwYmmV7w4GUn+8zsb11qMFEUFBb7zxlS9sKLGnZf+pGU6sOaTigBDbUTizRnt5EE0uOXK9YkKUwMd3ndtD+4vbNB1NaqrweH7H3isUNH8jzZFdYW5QnEgEwhRKUlV2fgkGcmv5XVMFQkKy2otHMlTW0qK0vHqP3otGX1LTMpDucBHp96sHjdY74Q/rg3+XKvq8oF7QftTzp/PqkZCzFgobfRa9DunpKYf7lbGUU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6392F73CAF6A874FB93E52FAF501C2AB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f0331da8-943a-4ea5-4e25-08d6a222906c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 10:57:45.8141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1279
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIvMTAvMjAxOCBhdCAxMjoxMCwgQXhlbCBMaW4gd3JvdGU6DQo+IFRoaXMgY2hlY2tpbmcg
aXMgYWxyZWFkeSBkb25lIGluIF9fc3BpX3ZhbGlkYXRlX2JpdHNfcGVyX3dvcmQoKS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEF4ZWwgTGluIDxheGVsLmxpbkBpbmdpY3MuY29tPg0KDQpBZ3JlZWQ6
DQpBY2tlZC1ieTogTmljb2xhcyBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPg0K
DQooQXhlbCwgc29ycnkgZm9yIHRoZSBkZWxheSkNCg0KQmVzdCByZWdhcmRzLA0KICAgTmljb2xh
cw0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvc3BpL3NwaS1hdDkxLXVzYXJ0LmMgfCA4ICstLS0tLS0t
DQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA3IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaS1hdDkxLXVzYXJ0LmMgYi9kcml2ZXJzL3Nw
aS9zcGktYXQ5MS11c2FydC5jDQo+IGluZGV4IGE5MjQ2NTc2NDJmYS4uNTE5ODUzZjE0OTM0IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktYXQ5MS11c2FydC5jDQo+ICsrKyBiL2RyaXZl
cnMvc3BpL3NwaS1hdDkxLXVzYXJ0LmMNCj4gQEAgLTE3NiwxMiArMTc2LDYgQEAgc3RhdGljIGlu
dCBhdDkxX3VzYXJ0X3NwaV9zZXR1cChzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiAgIAlzdHJ1
Y3QgYXQ5MV91c2FydF9zcGkgKmF1cyA9IHNwaV9tYXN0ZXJfZ2V0X2RldmRhdGEoc3BpLT5jb250
cm9sbGVyKTsNCj4gICAJdTMyICphdXNkID0gc3BpLT5jb250cm9sbGVyX3N0YXRlOw0KPiAgIAl1
bnNpZ25lZCBpbnQgbXIgPSBhdDkxX3VzYXJ0X3NwaV9yZWFkbChhdXMsIE1SKTsNCj4gLQl1OCBi
aXRzID0gc3BpLT5iaXRzX3Blcl93b3JkOw0KPiAtDQo+IC0JaWYgKGJpdHMgIT0gOCkgew0KPiAt
CQlkZXZfZGJnKCZzcGktPmRldiwgIk9ubHkgOCBiaXRzIHBlciB3b3JkIGFyZSBzdXBwb3J0ZWRc
biIpOw0KPiAtCQlyZXR1cm4gLUVJTlZBTDsNCj4gLQl9DQo+ICAgDQo+ICAgCWlmIChzcGktPm1v
ZGUgJiBTUElfQ1BPTCkNCj4gICAJCW1yIHw9IFVTX01SX0NQT0w7DQo+IEBAIC0yMTAsNyArMjA0
LDcgQEAgc3RhdGljIGludCBhdDkxX3VzYXJ0X3NwaV9zZXR1cChzdHJ1Y3Qgc3BpX2RldmljZSAq
c3BpKQ0KPiAgIA0KPiAgIAlkZXZfZGJnKCZzcGktPmRldiwNCj4gICAJCSJzZXR1cDogYnB3ICV1
IG1vZGUgMHgleCAtPiBtciAlZCAlMDh4XG4iLA0KPiAtCQliaXRzLCBzcGktPm1vZGUsIHNwaS0+
Y2hpcF9zZWxlY3QsIG1yKTsNCj4gKwkJc3BpLT5iaXRzX3Blcl93b3JkLCBzcGktPm1vZGUsIHNw
aS0+Y2hpcF9zZWxlY3QsIG1yKTsNCj4gICANCj4gICAJcmV0dXJuIDA7DQo+ICAgfQ0KPiANCg0K
DQotLSANCk5pY29sYXMgRmVycmUNCg==
