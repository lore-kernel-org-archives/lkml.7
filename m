Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28CEC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9606214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="CiZQEuab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfLKMH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 07:07:26 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:54067 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfLKMH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 07:07:26 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: tDegTIlqnBaqIrKux3j6hOyK/molOMSxyaI9XcPNoRh4YJN3HkvFDp1Q6QpDchojkDkwAS2juE
 jJmtW16Idvgc21qjnfE09qMJLQ2o6zlHDfdTp1QHc/tfZfbDQOq8rv6yNcSGWFcWw9cskFOM8y
 7CIy9fzLdk/zBDXgOryLvN4iUiFSVMLh3CTsYhirJT7g0gTJE6I6pUpepoBF3t2Y25Y7Bt+O8c
 98NhnOG2kKHoRFn9dn648SYzDJpZJ/Q7ztldWidvF/Rkh00djMwVVG6w2Kc0hdZ3h+UXMlgy+T
 X5Y=
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="57351278"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Dec 2019 05:07:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 11 Dec 2019 05:07:30 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 11 Dec 2019 05:07:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYeR3YjmNjwtrOwW2vJSCt7EobsISI2cZnmws28UMoBx/rAGzpnDTHR9rOPE7aDkfFPyc2a+id/afd/orxMlmehL3tbKV51M4s0ByEEj3Wuy/QA6DHUG3QpM/QJZ+Ido0yy7GkbonN3TbR6MR8YoHyfszg2VAyb/WbwwBim+EgyX03P6mnyjCyyCYU1st4WfKmmvSGwT6s8iy+PYg8TXRdqGsAqsToUB7csLH/3PlnWeTutHLX/q1RkgoMj1HvC6GW9BoEsoDWk7rUtzgqGk7/cxKEclofjFdbnVR9X+bBRoagotS6BSsctoNsWxKvD4qBDPZFz5DAt2xPO9oeHXcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Z2NdoZaZ9/uYx9re3ADms1h0r7WpMlgy2iv26bUc/Y=;
 b=XZyccruARxxd/+m6MzKjS8CvELkb0wzT6P/9Kefy6Yek9S9lJf/qB9uFB6wekrjiC9ihOcX5xe/WDPsgYyQ65itTNK4b8LcDZvTGTbhv0lxtlDLDnMyQeWDpeZjRV7cvTlcKJKcTWlQFWVxp3crGB20mncWLyCMsZ4V9mWxCWeGRtSEBXBtxw7f8k/nVliq4o4q1fMmlEj8d12cIV1YVBKc7Oc1oCNZLdUmaUDeex+tgKW4WKqZ8iQAvtCKLskCj28DWiafkAALqaWDolXl9h7x6H0PCwhGsfednbR+CRT0ha5A6BI+NH26+QmANQjTAhm0V5EGUaHq3tVVj/ifLiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Z2NdoZaZ9/uYx9re3ADms1h0r7WpMlgy2iv26bUc/Y=;
 b=CiZQEuabrxVd4tOGsijWBvjgTXpeJdaTbq7AzoauHxFU754DKAsR7ywimgReXA5MRApxxW3qtgRddwZ0OFqyD4MiKZZbuvQnC90qMgCxftvaNL9+Zyz/RIaZaXLlEzOSaecBMwPhzmpOAI7+pOVyJRvkjXG17zScmtsjMkZ70sM=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB2538.namprd11.prod.outlook.com (20.176.95.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.18; Wed, 11 Dec 2019 12:07:18 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::ed7d:d06f:7d55:cbe2]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::ed7d:d06f:7d55:cbe2%6]) with mapi id 15.20.2538.012; Wed, 11 Dec 2019
 12:07:18 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sam@ravnborg.org>
CC:     <alexandre.belloni@bootlin.com>, <bbrezillon@kernel.org>,
        <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <Ludovic.Desroches@microchip.com>,
        <daniel@ffwll.ch>, <lee.jones@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/5] mfd: atmel-hlcdc: return in case of error
Thread-Topic: [PATCH 3/5] mfd: atmel-hlcdc: return in case of error
Thread-Index: AQHVsBuEbmezCvtdS02ZCsl69qCn1w==
Date:   Wed, 11 Dec 2019 12:07:18 +0000
Message-ID: <99b559e2-4621-dec3-8c6c-b7a36f9ef07e@microchip.com>
References: <1575984287-26787-1-git-send-email-claudiu.beznea@microchip.com>
 <1575984287-26787-4-git-send-email-claudiu.beznea@microchip.com>
 <20191210203716.GC24756@ravnborg.org>
In-Reply-To: <20191210203716.GC24756@ravnborg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::28) To DM6PR11MB3225.namprd11.prod.outlook.com
 (2603:10b6:5:5b::32)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191211140711496
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adfa8810-18cf-4764-361e-08d77e32ab78
x-ms-traffictypediagnostic: DM6PR11MB2538:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2538CA980E9F767FECED8DF4875A0@DM6PR11MB2538.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(396003)(136003)(189003)(199004)(86362001)(52116002)(66946007)(2616005)(478600001)(8676002)(36756003)(26005)(66556008)(81156014)(8936002)(81166006)(66476007)(186003)(6916009)(6486002)(64756008)(6512007)(5660300002)(71200400001)(54906003)(31696002)(31686004)(66446008)(4326008)(316002)(966005)(6506007)(2906002)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB2538;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b6mt6xgDkthwJBuL/3o2pii5letnQTr6Yfngqs8A43CWL7sR33+fvxgoJr7SINITyuamrbrJ2uKL0DKkPwQP+8LuJJAY78S1tjRXxQXuauO40O3sPGX7wEau+9Ts/QRpFCq8MT9GQmrF6pJRTBZhSIQiW++OMsRfkvxdc6VEosgrDNfiw17JtGKAkX1t1ksmlJEJZNJ68GKpoFBg7ADzKyNJ+PnF7k0zjZaLHxZxQGqaNiX9DO4tTFPovE6S68W0IYNvcb6LWWHiayl/opFUw1eoFZ3ni3bjfKDqSrRYz7P+NlLky5epY+xtBz5JVk7Pj35u/2W1nmm6Y2HmfepLn6q2tSKREj/tLmwhxuvHnisF8TBga8+n9Up/E+YgyVxwOvug5xxZGn4gR/OWqu3E15WSh0u4Wl6Amj8dNaGOI3ZvppkZMdMSgZ/eRdB2yuVDvTPKvcs7+HcvXR0N/uwI8SvW3DEaiV1cQaj0SdFFm4M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F858CEA95E15745A056EA7BAC76D287@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: adfa8810-18cf-4764-361e-08d77e32ab78
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 12:07:18.7680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OajKFdksAQEww7OoP9rRYHZ5IpWqM7SrUUEuCN2L2Gpm6XPkHFe0X2LuDwBIfbGPk8bMNMARHIj9LUKSrJXUxh6TU17hWRfwm+x/rc+tQFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2538
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2FtLA0KDQpPbiAxMC4xMi4yMDE5IDIyOjM3LCBTYW0gUmF2bmJvcmcgd3JvdGU6DQo+IEhp
IENsYXVkaXUuDQo+IA0KPiBPbiBUdWUsIERlYyAxMCwgMjAxOSBhdCAwMzoyNDo0NVBNICswMjAw
LCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+IEZvciBITENEQyB0aW1pbmcgZW5naW5lIGNvbmZp
Z3VyYXRpb25zIGJpdCBBVE1FTF9ITENEQ19TSVAgb2YNCj4+IEFUTUVMX0hMQ0RDX1NSIG5lZWRz
IHRvIGNoZWNrZWQgaWYgaXQgaXMgZXF1YWwgd2l0aCB6ZXJvIGJlZm9yZSBhcHBseWluZw0KPj4g
bmV3IGNvbmZpZ3VyYXRpb24gdG8gdGltaW5nIGVuZ2luZS4gSW4gY2FzZSBvZiB0aW1lb3V0IHRo
ZXJlIGlzIG5vDQo+PiBpbmRpY2F0b3IgYWJvdXQgdGhpcywgc28sIHJldHVybiB3aXRoIGVycm9y
IGluIGNhc2Ugb2YgdGltZW91dCBpbg0KPj4gcmVnbWFwX2F0bWVsX2hsY2RjX3JlZ193cml0ZSgp
IGFuZCBhbHNvIHByaW50IGEgbWVzc2FnZSBhYm91dCB0aGlzLg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4gLS0t
DQo+PiAgZHJpdmVycy9tZmQvYXRtZWwtaGxjZGMuYyB8IDE0ICsrKysrKysrKystLS0tDQo+PiAg
MSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL2F0bWVsLWhsY2RjLmMgYi9kcml2ZXJzL21mZC9hdG1l
bC1obGNkYy5jDQo+PiBpbmRleCA2NDAxM2M1N2E5MjAuLjE5ZjFkYmViOGJjZCAxMDA2NDQNCj4+
IC0tLSBhL2RyaXZlcnMvbWZkL2F0bWVsLWhsY2RjLmMNCj4+ICsrKyBiL2RyaXZlcnMvbWZkL2F0
bWVsLWhsY2RjLmMNCj4+IEBAIC0zOSwxMCArMzksMTYgQEAgc3RhdGljIGludCByZWdtYXBfYXRt
ZWxfaGxjZGNfcmVnX3dyaXRlKHZvaWQgKmNvbnRleHQsIHVuc2lnbmVkIGludCByZWcsDQo+Pg0K
Pj4gICAgICAgaWYgKHJlZyA8PSBBVE1FTF9ITENEQ19ESVMpIHsNCj4+ICAgICAgICAgICAgICAg
dTMyIHN0YXR1czsNCj4+IC0NCj4+IC0gICAgICAgICAgICAgcmVhZGxfcG9sbF90aW1lb3V0X2F0
b21pYyhocmVnbWFwLT5yZWdzICsgQVRNRUxfSExDRENfU1IsDQo+PiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RhdHVzLCAhKHN0YXR1cyAmIEFUTUVMX0hMQ0RDX1NJ
UCksDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMSwgMTAwKTsN
Cj4+ICsgICAgICAgICAgICAgaW50IHJldDsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgcmV0ID0g
cmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYyhocmVnbWFwLT5yZWdzICsgQVRNRUxfSExDRENfU1Is
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RhdHVz
LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICEoc3Rh
dHVzICYgQVRNRUxfSExDRENfU0lQKSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAxLCAxMDApOw0KPj4gKyAgICAgICAgICAgICBpZiAocmV0KSB7DQo+
PiArICAgICAgICAgICAgICAgICAgICAgcHJfZXJyKCJUaW1lb3V0IHdhaXRpbmcgZm9yIEFUTUVM
X0hMQ0RDX1NJUFxuIik7DQo+PiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4g
Q29uc2lkZXIgYWRkaW5nIGRldmljZSAqIHRvIGF0bWVsX2hsY2RjX3JlZ21hcCAtIHNvIHlvdSBj
YW4gdXNlDQo+IGRldl9lcnIoKSBoZXJlLiBUaGlzIG1ha2VzIGl0IG9idmlvdXMgd2hhdCBkZXZp
Y2UgdGhpcyBjb21lcyBmcm9tLg0KDQpPSyEgSSdsbCBkbyBpdCBpbiB2Mi4NCg0KPiANCj4gICAg
ICAgICBTYW0NCj4gDQo+PiArICAgICAgICAgICAgIH0NCj4+ICAgICAgIH0NCj4+DQo+PiAgICAg
ICB3cml0ZWwodmFsLCBocmVnbWFwLT5yZWdzICsgcmVnKTsNCj4+IC0tDQo+PiAyLjcuNA0KPiAN
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbA0KPiANCg==
