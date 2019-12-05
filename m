Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544B8C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 07:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C391205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 07:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Trzbnsgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfLEHpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 02:45:20 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:16919 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfLEHpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 02:45:19 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: blMtPCkpoLZhBVQvN2vxT8EawB2qs0VXYwEp5OJdKCM2yBppFRuQpBviAhDeCZpNrTcDqam2AR
 3LeGiQjgHsdfQebCh2rSfcOfhZe7mv5g5235s0TxF7e2N99oVy7oPiRqiMLA8xPnG4Q1jLhAdW
 q4b5XqmSUvFWbY+TJI3F9ZzH+I0nLh/i0QLIpNd45NHtselp3w96At+s3DWsWMGN4OMAd3uwfj
 BOXvOu/daNhHEriyLCuyVBJVU/tQk+Q1maJpAT5tGiHAc+51Ym4M5l2d3yhoIClGH8j3hLJ5Ok
 js0=
X-IronPort-AV: E=Sophos;i="5.69,280,1571727600"; 
   d="scan'208";a="59341252"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Dec 2019 00:45:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 5 Dec 2019 00:45:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 5 Dec 2019 00:45:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E08b5vZCZ7R+/vkuos+uWyylR+SBXiqDXlYlmGVi1+JywBk/iycvHkQAz874NDi/s10dcPYGY7xnEXZH1/2r0V7ya0us9aFuCEbzhJ0eNk3RQ7haOivAETIGmu9vVZfa9yfOx0NuG1vN6RUPMS1ZJlpvuTkLPws0dcLGK5IIevNsIFL5cF2LpY+ipwhHEz0qVQLYd4yjasUe2Jl3PTTmrEZX34MUkxKI2EREF8SYQQs9nsLty2Kjwv5b8EUL22OqlXKe38czYrFXrQOhdCEm/pvL9UD5XJ6llf6gzV8FuvSPAIwxLqn46uZ/5cx3dWcf5MWKouJ2Wsq4x/vGu84BAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xC3jReT8OL+ItYm7fWigXNH5IVM9Lukn9Rbw3i7d+w=;
 b=OrLDA3VBXsBAX6minNzvUEtlsXq91jG13T1+sNR5PhjziZiSZ62YVZIRHFDj7BI8f9oLoHSBEtdUD2otCIXl13PnP2puwYPhVrxCcuXnMjTAUYQ+LyAU5fxDcAV+Xcr2T7qPvjC02fpa+YgQBALEkrGiweeActJhoJ8Jd5w51+yGUJedTxa5bULtOdQn+Eo1isumzf9uRk93RoeICLOD/r/lEUIj8B2BFLH110FmgZdzUMC3dxgRAH6moMI3NQrnDOnUt+iZQy4CAYSbzEx1XjEvVfkeyYNbIGiQQqaLfe5ZDeUcLmF3rxT/Kt2bpw9j4JPRk3TiMSAx0dh+48kGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xC3jReT8OL+ItYm7fWigXNH5IVM9Lukn9Rbw3i7d+w=;
 b=TrzbnsgfDj67xybiJmCMAHeV5YIODYUvuU5l0XOyxSMdm63Mn6x0zVjY5mxywzUHbHIqwTp5y+LjAovlLQjb0vK1IBGl7QFC7Mn63rU3gUbABbT1d6mQH5JngAPnBFMXNLUA8/UzEUGdKeTzuIJQP2aJ2Rn3/4HlXX8nFN0jBlU=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1979.namprd11.prod.outlook.com (10.175.87.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 5 Dec 2019 07:45:00 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1%12]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 07:45:00 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Ludovic.Desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: at91: sama5d27_som1_ek: add i2c filters
 properties
Thread-Topic: [PATCH] ARM: dts: at91: sama5d27_som1_ek: add i2c filters
 properties
Thread-Index: AQHVo3KV0xMhN6t/20m55125H3GPJKenJySAgAQRrgA=
Date:   Thu, 5 Dec 2019 07:45:00 +0000
Message-ID: <35ba1327-ff76-0eed-d481-f07196b20fb1@microchip.com>
References: <1574674036-5589-1-git-send-email-eugen.hristev@microchip.com>
 <20191202173625.GG909634@piout.net>
In-Reply-To: <20191202173625.GG909634@piout.net>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ZRAP278CA0009.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::19) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191205094444311
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3decf607-bf6d-408e-98e7-08d779570827
x-ms-traffictypediagnostic: DM5PR11MB1979:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1979FB8A3CC3419B6739915BE85C0@DM5PR11MB1979.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(136003)(366004)(199004)(189003)(99286004)(478600001)(25786009)(66946007)(52116002)(4326008)(14454004)(102836004)(31686004)(26005)(8676002)(6506007)(966005)(186003)(6436002)(316002)(4744005)(53546011)(66446008)(76176011)(5660300002)(66556008)(64756008)(54906003)(66476007)(71200400001)(2616005)(86362001)(81156014)(81166006)(36756003)(8936002)(305945005)(7736002)(11346002)(6512007)(2906002)(6246003)(3846002)(6486002)(6916009)(71190400001)(31696002)(229853002)(6306002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1979;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aQU66Pd/MEdt7J4BrDnR+D+ia/uLDPzuvzmfBw1r8J0iow04vUi7xlcHqNvklbUD9E/oLuR111Nt9nrrlleIdjqM45Wjh/1uJOO7F4ZOd60ZrUXYECaBjOhjOjBz/42XJo7QM0HVI1t+nesiUxGviywqi7nmNGc0CBP8ipY21LQ51jQeXrEIF48v2KZht0cao0gS43CIHwTFD8ZHsbEJe981+vgceE56lO9Eo1+Ie4BnlII+J4ypoNETQRMZ0zn25u2XTMSu0BpsKfmqof6OP9o1sXV+EoY61/u9ZEVxyAMgluXdS8A1Vg7sOpZOsebdJev6PuSdh71vBZ3407BMX/ycFsDsywZ7VrmaMlGkeWlZB/QVFY37h58Jb1EOZBSWjFmudoVV2cQDACcYnOxQtSrZQB/PbS9OwqXeazDcQ4OOSiSrwVxqKe/E0b7+6vBer3sD5iocHjK82lgj27GVmQDdCyLLC2R5qHAPj9MrdSk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <041C6DC314442247B623CE879BA2A932@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3decf607-bf6d-408e-98e7-08d779570827
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 07:45:00.5401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXpIwh9/+MSR4eFHXwjiJbDjU1xYn63SSfHXQ6oUm4awSy1gb5i7XxCDrgY4YOn3mnIT4MAyjS8crroJIorRo35RevZf6HQPbJAUJHJN9xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1979
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAyLjEyLjIwMTkgMTk6MzYsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KDQo+IE9u
IDI1LzExLzIwMTkgMDk6Mjc6NDErMDAwMCwgRXVnZW4uSHJpc3RldkBtaWNyb2NoaXAuY29tIHdy
b3RlOg0KPj4gRnJvbTogRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29t
Pg0KPj4NCj4+IEFkZCBwcm9wZXJ0aWVzIGZvciBpMmMgZmlsdGVycyBmb3IgaTJjMCBhbmQgaTJj
MSBvbiBzYW1hNWQyN19zb20xX2VrLg0KPj4gTm9pc2UgaXMgYWZmZWN0aW5nIGNvbW11bmljYXRp
b24gb24gaTJjIGZvciBleGFtcGxlIHdoZW4gY29ubmVjdGluZyBpMmMNCj4+IGNhbWVyYSBzZW5z
b3JzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuIEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZA
bWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICBhcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE1
ZDI3X3NvbTFfZWsuZHRzIHwgNiArKysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKQ0KPj4NCj4gQXBwbGllZCwgdGhhbmtzLg0KDQpIaSBBbGV4YW5kcmUsDQoNClRoZSBw
cm9wZXJ0aWVzIGZvciBpMmMwIGFyZSBhdCB0aGUgd3Jvbmcgbm9kZS4gU2hvdWxkIGJlIGF0IHRo
ZSBjaGlsZCANCm5vZGUuIEkgc2VudCBhIHYyIHRvIGNvcnJlY3QgaXQuIElmIGl0J3MgdG9vIGxh
dGUgbGV0IG1lIGtub3cgYW5kIEkgY2FuIA0KbWFrZSBhIGZpeCBwYXRjaCBpbnN0ZWFkLg0KDQpU
aGFua3MgYW5kIHNvcnJ5LA0KRXVnZW4NCg0KPiANCj4gLS0NCj4gQWxleGFuZHJlIEJlbGxvbmks
IEJvb3RsaW4NCj4gRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZw0KPiBodHRw
czovL2Jvb3RsaW4uY29tDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXw0KPiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdA0KPiBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsDQo+IA0K
