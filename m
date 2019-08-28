Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B981EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84025217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfH1KSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:18:39 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:15394 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfH1KSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:18:37 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Hne+sonuOIuUTYQYmdBaSu7N+tSKmViNqadsTj1QabcCfymnHNL7AYJ5uT4OCq5W+mIkF0Avnh
 PZ1jORtGtUvBUVem4eSVYjcr8BjXOzLJQ9mROiZMpaMx8Wu8nqv8zCD1EXGCTA8oXDaon897nD
 1avqA3adFQlfen1joycC8BIUdr+gVY2C+DtH9smuvtReCANYE4JiO2CwdvTHoALzgk5V1D/Cfo
 dllfOGlyYMjXz+jAratLEpbnknjlSMAl8L9Wc3kPByRECmGOjpcIVSbEwTbHbaogMVE/Y57+2K
 tR0=
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="48305702"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Aug 2019 03:18:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 28 Aug 2019 03:18:35 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 28 Aug 2019 03:18:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzbxZesxY2INSF1ZsC+nKBuAMrglH9wpgrSmZY6zu6FC4xeOhQ3BcKgBh1ct/08/2Y3bA8Rt/SlZ0MOEJ/CqmMjxd/2B6U2KXLu5xRpfxhOJPdHfcI5qzFsSwLi+PtTS4gHHfYRfod1KuXsWAO/P82k6nIC3cFOUuPXJA/FhmYbE2M/VNGfEw8om1/Hudk28cxKYastBqvkb88/qKWpWqkQ2mKLsSqMlU426ApZualSIqjOyuJDHjpx/XXPBIjxAY2uPUgN3i1L0mL8Dz4OcfGH4cpRQ8Hc4L9y3n60oS14iNpC1jvWrR/AgR+Ja+dS1WXnBWkIkjq3Y7QWzqwobGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AzZwaGPlieZfa9qWIFaQ6Bbb22POZhg1ABVFgDTEFA=;
 b=OyuSBkw5+ApnRZfj+/AG3/Wv5w1n+axfnM3BUrjXns1+NsHgF2rvsZlzk+grw78CBC9WrPENcL7a2sSxsXds/7l5VAFD2zuS7wJcMwKAOni/JszJaas5Ggc2QoT8y66blOFAUTb0Y+PsNQA+lFB/nw5zkHos7gKZiXN/Cj3v7VQLyVe5SFHW3A/qEuoPuL6xNxzXRK8TtfuahE9i3zHdCMEx79r16v1SpjsSQ0YfyoSk1JsPK4b+y+4ar55wlJrzy2hUkDpCsHni0YUEsdr0U+IDZst4XzL6G985G+MNMmIJmDWjGX+cXUxQA4X8R7b3Qtf2WuYEFoLs/BPiZS0AOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AzZwaGPlieZfa9qWIFaQ6Bbb22POZhg1ABVFgDTEFA=;
 b=KkUYv3qE2TwTCNaO1a8AnaPdYSUS2U1yyEukEYtCFkVZFjAA5ubmBSOxguWvPpmp0KcsGA0BgIKqrfHJ7pBbdFYD61CTBHJS0T/HriGxnDGWkgh/PQGUPEkPB4ra+OUsdBRJeF4KKcAtmaq48iPqlhIeey5i7tk4qFu1G6momqY=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3727.namprd11.prod.outlook.com (20.178.252.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 10:18:34 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 10:18:34 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v3 00/20] mtd: spi-nor: move manuf out of the core
Thread-Topic: [RESEND PATCH v3 00/20] mtd: spi-nor: move manuf out of the core
Thread-Index: AQHVXAb5BskU+i2FLEuxBjAKiOchAqcQW80A
Date:   Wed, 28 Aug 2019 10:18:33 +0000
Message-ID: <8fced5c4-4a22-8445-8838-ea61c416698c@microchip.com>
References: <20190826120821.16351-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190826120821.16351-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0044.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::21) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79be0cd8-d143-41a6-4181-08d72ba114d2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3727;
x-ms-traffictypediagnostic: MN2PR11MB3727:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR11MB372788364116A63E26D6E8DBF0A30@MN2PR11MB3727.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(376002)(136003)(189003)(199004)(446003)(6246003)(11346002)(76176011)(2616005)(6436002)(2201001)(6306002)(25786009)(5660300002)(36756003)(99286004)(6506007)(6486002)(316002)(6512007)(14444005)(256004)(2501003)(486006)(53936002)(2906002)(476003)(52116002)(66066001)(71190400001)(229853002)(102836004)(186003)(478600001)(81156014)(81166006)(110136005)(8676002)(966005)(86362001)(26005)(66446008)(64756008)(66556008)(66476007)(305945005)(6116002)(14454004)(3846002)(31696002)(7736002)(8936002)(66946007)(71200400001)(31686004)(53546011)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3727;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CJwVI2e92fWcobikBCdukMU8WybP2kIaB7JFsIm78NvHNssmChGQDnRbPFrEStmEGf/LvrPoiNHeazCWmGNVI70E1W2YBuUMB3acLwRmF0VfaYLLLX/vxaWzOyOvMVNUJxPVcIEAO5mZbAZti3n0JIXdqP57QLUuVujSLLMCieZucqnS2+ak25/fPk/e53IXJa3M1Bpqe6Z3nqUbJacCM64QuxrNnvRYUkDFzzjUKASypzadHfUX7OnCxPM2kY3pIp1P8YEKmmBMzc5/eFzmaJzcwmIAj3hIC+BCqQhZzswrH7exxbfoGcFYja4AKLAPGTTV1YwHyZGzcNQ++EyWUOW7hSgRlSd9H4MaJ5B51n+hKlSdX8C4itSOzu+PiKRgF2XJaZQmMEuy8rtCXUvInK65f7M3r7Xt0wvMezEKmcQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EFD104D4F35294C82AE6C2A3383335A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 79be0cd8-d143-41a6-4181-08d72ba114d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 10:18:33.8975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 203ycDiBm9s6prCPTR3XiNtQv+U3wj2KcFc1VjpQlaBFEiPbu6r22EjR6CHXFJrKDjaIcrevFlepCoaPmPtjaeOk6dAEEtg7AI2aGYTog40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3727
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzI2LzIwMTkgMDM6MDggUE0sIFR1ZG9yIEFtYmFydXMgLSBNMTgwNjQgd3JvdGU6
DQo+IEZyb206IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4g
DQo+IHYzOg0KPiAtIERyb3AgcGF0Y2hlczoNCj4gICAibXRkOiBzcGktbm9yOiBNb3ZlIGNsZWFy
X3NyX2JwKCkgdG8gJ3N0cnVjdCBzcGlfbm9yX2ZsYXNoX3BhcmFtZXRlciciDQo+ICAgIm10ZDog
c3BpLW5vcjogUmV3b3JrIHRoZSBkaXNhYmxpbmcgb2YgYmxvY2sgd3JpdGUgcHJvdGVjdGlvbiIN
Cj4gYW5kIHJlcGxhY2UgdGhlbSB3aXRoIHRoZSBSRkMgcGF0Y2g6DQo+ICAgIm10ZDogc3BpLW5v
cjogUmV3b3JrIHRoZSBkaXNhYmxpbmcgb2YgYmxvY2sgd3JpdGUgcHJvdGVjdGlvbiINCj4gLSBy
ZW5hbWUgc3BpX25vcl9sZWdhY3lfaW5pdF9wYXJhbXMoKSB0byBzcGlfbm9yX2luZm9faW5pdF9w
YXJhbXMoKQ0KPiAtIHJlYmFzZSBwYXRjaGVzIGFuZCBzZW5kIHRoZW0gYWxsIGluIGEgc2luZ2xl
IHBhdGNoIHNldC4NCj4gDQo+IHYyOg0KPiAtIGFkZHJlc3NlZCBhbGwgdGhlIGNvbW1lbnRzDQo+
IC0gYWxsIGZsYXNoIHBhcmFtZXRlcnMgYW5kIHNldHRpbmdzIGFyZSBub3cgc2V0IGluICdzdHJ1
Y3QNCj4gICBzcGlfbm9yX2ZsYXNoX3BhcmFtZXRlcicsIGZvciBhIGNsZWFyZXIgc2VwYXJhdGlv
biBiZXR3ZWVuIHRoZSBTUEkgTk9SDQo+ICAgbGF5ZXIgYW5kIHRoZSBmbGFzaCBwYXJhbXMuDQo+
IA0KPiBJbiBvcmRlciB0byB0ZXN0IHRoaXMsIHlvdSdsbCBoYXZlIHRvIG1lcmdlIHY1LjMtcmM1
IGluIHNwaS1ub3IvbmV4dC4NCj4gVGhpcyBwYXRjaCBzZXQgZGVwZW5kcyBvbg0KPiAnY29tbWl0
IDgzNGRlNWMxYWE3NiAoIm10ZDogc3BpLW5vcjogRml4IHRoZSBkaXNhYmxpbmcgb2Ygd3JpdGUg
cHJvdGVjdGlvbiBhdCBpbml0IikNCj4gDQo+IFRoZSBzY29wZSBvZiB0aGUgIm10ZDogc3BpLW5v
cjogbW92ZSBtYW51ZiBvdXQgb2YgdGhlIGNvcmUiIGJhdGNoZXMsDQo+IGlzIHRvIG1vdmUgYWxs
IG1hbnVmYWN0dXJlciBzcGVjaWZpYyBjb2RlIG91dCBvZiB0aGUgc3BpLW5vciBjb3JlLg0KPiAN
Cj4gSW4gdGhlIHF1ZXN0IG9mIHJlbW92aW5nIHRoZSBtYW51ZmFjdHVyZXIgc3BlY2lmaWMgY29k
ZSBmcm9tIHRoZSBzcGktbm9yDQo+IGNvcmUsIHdlIHdhbnQgdG8gaW1wb3NlIGEgdGltZWxpbmUv
cHJpb3JpdHkgb24gaG93IHRoZSBmbGFzaCBwYXJhbWV0ZXJzDQo+IGFyZSB1cGRhdGVkLiBBcyBv
ZiBub3cuIHRoZSBmbGFzaCBwYXJhbWV0ZXJzIGluaXRpYWxpemF0aW9uIGxvZ2ljIGlzIGFzDQo+
IGZvbGxvd2luZzoNCj4gDQo+ICAgICBhLyBkZWZhdWx0IGZsYXNoIHBhcmFtZXRlcnMgaW5pdCBp
biBzcGlfbm9yX2luaXRfcGFyYW1zKCkNCj4gICAgIGIvIG1hbnVmYWN0dXJlciBzcGVjaWZpYyBm
bGFzaCBwYXJhbWV0ZXJzIHVwZGF0ZXMsIHNwbGl0IGFjcm9zcyBlbnRpcmUNCj4gICAgICAgIHNw
aS1ub3IgY29yZSBjb2RlDQo+ICAgICBjLyBmbGFzaCBwYXJhbWV0ZXJzIHVwZGF0ZXMgYmFzZWQg
b24gU0ZEUCB0YWJsZXMNCj4gICAgIGQvIHBvc3QgQkZQVCBmbGFzaCBwYXJhbWV0ZXIgdXBkYXRl
cw0KPiANCj4gV2l0aCB0aGUgIm10ZDogc3BpLW5vcjogbW92ZSBtYW51ZiBvdXQgb2YgdGhlIGNv
cmUiIGJhdGNoZXMsIHdlIHdhbnQgdG8NCj4gaW1wb3NlIHRoZSBmb2xsb3dpbmcgc2VxdWVuY2Ug
b2YgY2FsbHM6DQo+IA0KPiAgICAgMS8gc3BpLW5vciBjb3JlIGxlZ2FjeSBmbGFzaCBwYXJhbWV0
ZXJzIGluaXQ6DQo+ICAgICAgICAgICAgIHNwaV9ub3JfZGVmYXVsdF9pbml0X3BhcmFtcygpDQo+
IA0KPiAgICAgMi8gTUZSLWJhc2VkIG1hbnVmYWN0dXJlciBmbGFzaCBwYXJhbWV0ZXJzIGluaXQ6
DQo+ICAgICAgICAgICAgIG5vci0+bWFudWZhY3R1cmVyLT5maXh1cHMtPmRlZmF1bHRfaW5pdCgp
DQo+IA0KPiAgICAgMy8gc3BlY2lmaWMgZmxhc2hfaW5mbyB0d2Vla3MgZG9uZSB3aGVuIGRlY2lz
aW9ucyBjYW4gbm90IGJlIGRvbmUganVzdA0KPiAgICAgICAgb24gTUZSOg0KPiAgICAgICAgICAg
ICBub3ItPmluZm8tPmZpeHVwcy0+ZGVmYXVsdF9pbml0KCkNCj4gDQo+ICAgICA0LyBTRkRQIHRh
YmxlcyBmbGFzaCBwYXJhbWV0ZXJzIGluaXQgLSBTRkRQIGtub3dzIGJldHRlcjoNCj4gICAgICAg
ICAgICAgc3BpX25vcl9zZmRwX2luaXRfcGFyYW1zKCkNCj4gDQo+ICAgICA1LyBwb3N0IFNGRFAg
dGFibGVzIGZsYXNoIHBhcmFtZXRlcnMgdXBkYXRlcyAtIGluIGNhc2UgbWFudWZhY3R1cmVycw0K
PiAgICAgICAgZ2V0IHRoZSBzZXJpYWwgZmxhc2ggdGFibGVzIHdyb25nIG9yIGluY29tcGxldGUu
DQo+ICAgICAgICAgICAgIG5vci0+aW5mby0+Zml4dXBzLT5wb3N0X3NmZHAoKQ0KPiAgICAgICAg
VGhlIGxhdGVyIGNhbiBiZSBleHRlbmRlZCB0byBub3ItPm1hbnVmYWN0dXJlci0+Zml4dXBzLT5w
b3N0X3NmZHAoKQ0KPiAgICAgICAgaWYgbmVlZGVkLg0KPiANCj4gU2V0dGluZyBvZiBmbGFzaCBw
YXJhbWV0ZXJzIHdpbGwgbm8gbG9uZ2VyIGJlIHNwcmVhZCBpbnRlcmxlYXZlZCBhY3Jvc3MNCj4g
dGhlIHNwaS1ub3IgY29yZSwgdGhlcmUgd2lsbCBiZSBhIGNsZWFyIHNlcGFyYXRpb24gb24gd2hv
IGFuZCB3aGVuIHdpbGwNCj4gdXBkYXRlIHRoZSBmbGFzaCBwYXJhbWV0ZXJzLg0KPiANCj4gVGVz
dGVkIG9uIHNzdDI2dmYwNjRiIHdpdGggYXRtZWwtcXVhZHNwaSBTUElNRU0gZHJpdmVyLg0KPiAN
Cj4gQm9yaXMgQnJlemlsbG9uICg3KToNCj4gICBtdGQ6IHNwaS1ub3I6IEFkZCBhIGRlZmF1bHRf
aW5pdCgpIGZpeHVwIGhvb2sgZm9yIGdkMjVxMjU2DQo+ICAgbXRkOiBzcGktbm9yOiBDcmVhdGUg
YSAtPnNldF80Ynl0ZSgpIG1ldGhvZA0KPiAgIG10ZDogc3BpLW5vcjogUmV3b3JrIHRoZSBTUEkg
Tk9SIGxvY2svdW5sb2NrIGxvZ2ljDQo+ICAgbXRkOiBzcGktbm9yOiBBZGQgcG9zdF9zZmRwKCkg
aG9vayB0byB0d2VhayBmbGFzaCBjb25maWcNCj4gICBtdGQ6IHNwaS1ub3I6IEFkZCBzcGFuc2lv
bl9wb3N0X3NmZHBfZml4dXBzKCkNCj4gICBtdGQ6IHNwaS1ub3I6IEFkZCBhIC0+Y29udmVydF9h
ZGRyKCkgbWV0aG9kDQo+ICAgbXRkOiBzcGktbm9yOiBBZGQgdGhlIFNQSV9OT1JfWFNSX1JEWSBm
bGFnDQo+IA0KPiBUdWRvciBBbWJhcnVzICgxMyk6DQo+ICAgbXRkOiBzcGktbm9yOiBSZWdyb3Vw
IGZsYXNoIHBhcmFtZXRlciBhbmQgc2V0dGluZ3MNCj4gICBtdGQ6IHNwaS1ub3I6IFVzZSBub3It
PnBhcmFtcw0KPiAgIG10ZDogc3BpLW5vcjogRHJvcCBxdWFkX2VuYWJsZSgpIGZyb20gJ3N0cnVj
dCBzcGktbm9yJw0KPiAgIG10ZDogc3BpLW5vcjogTW92ZSBlcmFzZV9tYXAgdG8gJ3N0cnVjdCBz
cGlfbm9yX2ZsYXNoX3BhcmFtZXRlcicNCj4gICBtdGQ6IHNwaS1ub3I6IEFkZCBkZWZhdWx0X2lu
aXQoKSBob29rIHRvIHR3ZWFrIGZsYXNoIHBhcmFtZXRlcnMNCj4gICBtdGQ6IHNwaV9ub3I6IE1v
dmUgbWFudWZhY3R1cmVyIHF1YWRfZW5hYmxlKCkgaW4gLT5kZWZhdWx0X2luaXQoKQ0KPiAgIG10
ZDogc3BpLW5vcjogU3BsaXQgc3BpX25vcl9pbml0X3BhcmFtcygpDQo+ICAgbXRkOiBzcGlfbm9y
OiBBZGQgYSAtPnNldHVwKCkgbWV0aG9kDQo+ICAgbXRkOiBzcGktbm9yOiBBZGQgczNhbl9wb3N0
X3NmZHBfZml4dXBzKCkNCj4gICBtdGQ6IHNwaS1ub3I6IEJyaW5nIGZsYXNoIHBhcmFtcyBpbml0
IHRvZ2V0aGVyDQo+ICAgbXRkOiBzcGlfbm9yOiBJbnRyb2R1Y2Ugc3BpX25vcl9zZXRfYWRkcl93
aWR0aCgpDQo+ICAgbXRkOiBzcGktbm9yOiBJbnRyb2R1Y2Ugc3BpX25vcl9nZXRfZmxhc2hfaW5m
bygpDQo+ICAgbXRkOiBzcGktbm9yOiBSZXdvcmsgdGhlIGRpc2FibGluZyBvZiBibG9jayB3cml0
ZSBwcm90ZWN0aW9uDQo+IA0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgfCAxMzA0
ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICBpbmNsdWRlL2xp
bnV4L210ZC9zcGktbm9yLmggICB8ICAyOTggKysrKysrKy0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2Vk
LCA5MjcgaW5zZXJ0aW9ucygrKSwgNjc1IGRlbGV0aW9ucygtKQ0KPiANCg0KQWRkcmVzc2VkIEJv
cmlzJ3MgYW5kIFZpbmduZXNoJ3MgbGF0ZXN0IHNtYWxsIHVwZGF0ZXMuDQoNCkFsbCBidXQgbGFz
dCBhcHBsaWVkIHRvIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L210ZC9saW51eC5naXQsDQpzcGktbm9yL25leHQgYnJhbmNoLg0KDQpUaGFua3MsDQp0YQ0K
