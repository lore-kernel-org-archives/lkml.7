Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB34CC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCB2207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ESER2DyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732954AbfFMPFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:05:48 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:36874 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732434AbfFMOM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:12:57 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,369,1557212400"; 
   d="scan'208";a="34287443"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2019 07:12:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex01.mchp-main.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 13 Jun 2019 07:12:54 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 13 Jun 2019 07:12:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OM81MMGtwoE3hz/Rvgiu1mIfPBrt8C6X7ndyCGZDaQ4=;
 b=ESER2DyPpS+U4OBMACepmKHo/pvacCDGzqyzrYQWeN085SyZR0tuUX4YCiefb5E2HbyzBnlUA3Th618ecRxMppswayhPSTd0hY2AfRPh39XtDevhx7Vp7bvBF8wG/Q1EsreNlMuHafz8hVSEKrIDKlAxDoKaTW7GfsM4i8fg0kk=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1358.namprd11.prod.outlook.com (10.169.233.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Thu, 13 Jun 2019 14:12:53 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::316b:7774:8db6:30ec]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::316b:7774:8db6:30ec%7]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 14:12:53 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <alexandre.belloni@bootlin.com>
CC:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Ludovic.Desroches@microchip.com>,
        <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>, <arnd.bergmann@linaro.org>
Subject: Re: Re: [PATCH 2/5] clocksource/drivers/timer-microchip-pit64b: add
 Microchip PIT64B support
Thread-Topic: Re: [PATCH 2/5] clocksource/drivers/timer-microchip-pit64b: add
 Microchip PIT64B support
Thread-Index: AQHU2oKzNY9L7o7MvUGRVNlgkbjplaYyGT4AgAA6L4CAUW8cAIABw0EAgBSpUwA=
Date:   Thu, 13 Jun 2019 14:12:53 +0000
Message-ID: <5e3d783e-7bcc-64c1-c814-eaf99a6aa205@microchip.com>
References: <1552580772-8499-1-git-send-email-claudiu.beznea@microchip.com>
 <1552580772-8499-3-git-send-email-claudiu.beznea@microchip.com>
 <a738fce5-1108-34d7-d255-dfcb86f51c56@linaro.org>
 <20190408121141.GK7480@piout.net>
 <88ab46de-c3b6-6dd2-3fa2-f2d0075e969f@microchip.com>
 <7267f37b-4f80-97e3-7a8e-bc1a9a28b995@linaro.org>
In-Reply-To: <7267f37b-4f80-97e3-7a8e-bc1a9a28b995@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VE1PR03CA0041.eurprd03.prod.outlook.com
 (2603:10a6:803:118::30) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8280020-e97c-4180-2450-08d6f009399b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR11MB1358;
x-ms-traffictypediagnostic: MWHPR11MB1358:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <MWHPR11MB1358D7FCCFB0F02824EFA77B87EF0@MWHPR11MB1358.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(136003)(39860400002)(376002)(199004)(189003)(14444005)(256004)(66066001)(2501003)(71200400001)(31686004)(478600001)(72206003)(14454004)(966005)(86362001)(31696002)(486006)(476003)(2616005)(11346002)(446003)(36756003)(71190400001)(8676002)(99286004)(81156014)(81166006)(53546011)(6506007)(386003)(53936002)(54906003)(110136005)(186003)(76176011)(4326008)(26005)(102836004)(25786009)(6246003)(7736002)(6116002)(3846002)(305945005)(6436002)(6512007)(6306002)(8936002)(229853002)(2906002)(6486002)(52116002)(68736007)(316002)(66476007)(66556008)(5660300002)(64756008)(73956011)(66446008)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1358;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dOY6zvxmHd8Awa4i7AoTHRH0DR4NVPLCxRI8NlAeedrdpp3ao/PgZ62mEOMubcYTlnW+fAaVafvuqEqY4nWENqMM2pgHf+MuNPiD28qvLuZTFBgoEPwJywB3RTvzOMDvTUx9I6YBgYxBjQijvIqmKqpgV9WFRmapT6cnLjwNLAe8dNAAXkkkKDlxcBeKpDfGAC2jtTafZFMrdhaqpBFpt5cZTaX+CBm8D9VYla5SV7Qi7hbvroYvXMf9doitLk0/1Ubbl2TpjCz0+sVhpgPjq6Yyn1fHuj31jDRb2fr16w8j6/4LOVX8HJKYaYHWqMEKQEgi2cT4nObZ/mEu5MWcXfEl3ecgChM9UhTo7V7hE2Rm4qcQjzZDBgsgU8WjJwk8qMq0QOuUy8z49JfRehTI5onJ0/nnrWVreAFi56r2n9k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD599551A64A914392D310BA074C0663@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a8280020-e97c-4180-2450-08d6f009399b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 14:12:53.4066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: claudiu.beznea@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1358
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuaWVsLA0KDQpPbiAzMS4wNS4yMDE5IDEzOjQxLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gDQo+IEhpIENsYXVkaXUsDQo+IA0KPiANCj4gT24gMzAvMDUvMjAxOSAwOTo0NiwgQ2xhdWRp
dS5CZXpuZWFAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IEhpIERhbmllbCwNCj4+DQo+PiBUYWtp
bmcgaW50byBhY2NvdW50IHRoZSBkaXNjdXNzaW9uIG9uIHRoaXMgdHJlYWQgYW5kIHRoZSBmYWN0
IHRoYXQgd2UgaGF2ZQ0KPj4gbm8gYW5zd2VyIGZyb20gUm9iIG9uIHRoaXMgdG9waWMgKEknbSB0
YWxraW5nIGFib3V0IFsxXSksIHdoYXQgZG8geW91IHRoaW5rDQo+PiBpdCB3b3VsZCBiZSBiZXN0
IGZvciB0aGlzIGRyaXZlciB0byBiZSBhY2NlcHRlZCB0aGUgc29vbmVzdD8gV291bGQgaXQgYmUg
T0sNCj4+IGZvciB5b3UgdG8gbWltaWMgdGhlIGFwcHJvYWNoIGRvbmUgYnk6DQo+Pg0KPj4gZHJp
dmVycy9jbG9ja3NvdXJjZS90aW1lci1pbnRlZ3JhdG9yLWFwLmMNCj4+DQo+PiB3aXRoIHRoZSBm
b2xsb3dpbmcgYmluZGluZ3MgaW4gRFQ6DQo+Pg0KPj4gYWxpYXNlcyB7DQo+PiAJYXJtLHRpbWVy
LXByaW1hcnkgPSAmdGltZXIyOw0KPj4gCWFybSx0aW1lci1zZWNvbmRhcnkgPSAmdGltZXIxOw0K
Pj4gfTsNCj4+DQo+PiBhbHNvIGluIFBJVDY0QiBkcml2ZXI/DQo+Pg0KPj4gT3IgZG8geW91IHRo
aW5rIHJlLXNwaW5uaW5nIHRoZSBBbGV4YW5kcmUncyBwYXRjaGVzIGF0IFsyXSAod2hpY2ggc2Vl
bXMgdG8NCj4+IG1lIGxpa2UgdGhlIGdlbmVyaWMgd2F5IHRvIGRvIGl0KSB3b3VsZCBiZSBiZXR0
ZXI/DQo+IA0KPiBUaGlzIGhhcmR3YXJlIC8gT1MgY29ubmVjdGlvbiBwcm9ibGVtIGlzIGdldHRp
bmcgcmVhbGx5IGFubm95aW5nIGZvcg0KPiBldmVyeW9uZSBhbmQgdGhpcyBwYXR0ZXJuIGlzIHJl
cGVhdGluZyBpdHNlbGYgc2luY2Ugc2V2ZXJhbCB5ZWFycy4gSXQgaXMNCj4gdGltZSB3ZSBmaXgg
aXQgcHJvcGVybHkuDQo+IA0KPiBUaGUgZmlyc3Qgc29sdXRpb24gbG9va3MgaGFja2lzaCBmcm9t
IG15IFBPVi4gVGhlIHNlY29uZCBhcHByb2FjaCBsb29rcw0KPiBuaWNlciBhbmQgZ2VuZXJpYyBh
cyB5b3Ugc2F5LiBTbyBJIHdvdWxkIHZvdGUgZm9yIFsyXQ0KPiBmbGFnZ2luZyBhcHByb2FjaCBw
cm9wb3NlZCBieSBNYXJrIFszXS4NCg0KV2l0aCB0aGlzIGZsYWdnaW5nIGFwcHJvYWNoIHRoaXMg
d291bGQgbWVhbiBhIGtpbmQgdW5pZmljYXRpb24gb2YNCmNsb2Nrc291cmNlIGFuZCBjbG9ja2V2
ZW50IGZ1bmN0aW9uYWxpdGllcyB1bmRlciBhIHNpbmdsZSBvbmUsIHJpZ2h0PyBTbw0KdGhhdCB0
aGUgZHJpdmVyIHdvdWxkIHJlZ2lzdGVyIHRvIHRoZSBhYm92ZSBsYXllcnMgb25seSBvbmUgZGV2
aWNlIHcvIDINCmZ1bmN0aW9uYWxpdGllcyAoY2xvY2tzb3VyY2UgYW5kIGNsb2NrZXZlbnQpPyBQ
bGVhc2UgY29ycmVjdCBtZSBpZiBJJ20NCndyb25nPyBJZiBzbywgZnJvbSBteSBwb2ludCBvZiB2
aWV3IHRoaXMgd291bGQgcmVxdWlyZSBtYWpvciByZS13b3JraW5nIG9mDQpjbG9ja3NvdXJjZSBh
bmQgY2xvY2tldmVudCBzdWJzeXN0ZW1zLiBDb3JyZWN0bHkgaWYgSSB3cm9uZ2x5IHVuZGVyc3Rv
b2QsDQpwbGVhc2UuDQoNCkF0IHRoZSBtb21lbnQgd2UgcmVnaXN0ZXIgZGlmZmVyZW50IGZ1bmN0
aW9uYWxpdGllcyAoY2xvY2tzb3VyY2UgYW5kDQpjbG9ja2V2ZW50KSB0byB0aGUgYWJvdmUgbGF5
ZXJzIGZvciBoYXJkd2FyZSBibG9ja3MgKGUuZy4gd2l0aA0KY2xvY2tzb3VyY2VfcmVnaXN0ZXJf
aHooKSBvciBjbG9ja2V2ZW50c19jb25maWdfYW5kX3JlZ2lzdGVyKCkpLiBJZg0KaGFyZHdhcmUg
Y2FuIHN1cHBvcnQgY2xvY2tzb3VyY2UgYW5kIGNsb2NrZXZlbnQgd2UgcmVnaXN0ZXIgYm90aCB0
aGVzZQ0KZnVuY3Rpb25hbGl0aWVzLCBpZiBvbmx5IG9uZSBpcyBzdXBwb3J0ZWQgd2UgcmVnaXN0
ZXIgb25seSBvbmUgb2YgdGhlc2UuDQpUaGUgYWJvdmUgbGF5ZXJzIHdvdWxkIGNob29zZSB0aGUg
YmVzdCBjbG9ja3NvdXJjZS9jbG9ja2V2ZW50IGRldmljZSBmcm9tDQp0aGUgYXZhaWxhYmxlIG9u
ZXMgYmFzZWQgb24gcmF0aW5nIGZpZWxkIGZvciBlYWNoIGNsb2Nrc291cmNlL2Nsb2NrZXZlbnQg
d2UNCnJlZ2lzdGVyLiBJbiBhbGwgdGhpcyBjdXJyZW50IGJlaGF2aW9yIEkgZG9uJ3Qgc2VlIGhv
dyB0aGVzZSBmbGFncyB3b3VsZA0KaW50ZXJhY3Qgd2l0aCBjbG9ja3NvdXJjZS9jbG9ja2V2ZW50
IHN1YnN5c3RlbS4gQ291bGQgeW91IHBsZWFzZSBsZXQgbWUNCmtub3cgaG93IGRvIHlvdSBzZWUg
dGhlc2UgYW5kIHRoZSB3YXkgdGhlc2UgbmV3IGZsYWdzIHdvdWxkIGludGVyYWN0IHdpdGgNCnRo
ZSBsYXllcnMgYWJvdmUgdGhlIGRyaXZlcnM/DQoNClRoYW5rIHlvdSwNCkNsYXVkaXUgQmV6bmVh
DQoNCj4gDQo+IEkgYWRkZWQgQXJuZCBpbiBDYyBpbiBvcmRlciB0byBoYXZlIGl0cyBvcGluaW9u
Lg0KPiANCj4gWzNdDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAxNzEyMTUxMTMy
NDIuc2ttaDVuenI3d3FkbXZud0BsYWtyaWRzLmNhbWJyaWRnZS5hcm0uY29tLw0KPiANCj4+IFsx
XQ0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDE5MDQwODE1MTE1NS4yMDI3OS0x
LWFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tLyN0DQo+PiBbMl0NCj4+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xrbWwvMjAxNzEyMTMxODUzMTMuMjAwMTctMS1hbGV4YW5kcmUuYmVsbG9u
aUBmcmVlLWVsZWN0cm9ucy5jb20vDQo+Pg0KPiANCj4gDQo+IA0KPiANCj4gDQo+IA0K
