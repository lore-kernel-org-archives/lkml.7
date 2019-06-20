Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA33AC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796622082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Txo1THbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbfFTKat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 06:30:49 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:3500 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfFTKas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:30:48 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,396,1557212400"; 
   d="scan'208";a="38184400"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jun 2019 03:30:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 20 Jun 2019 03:30:46 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 20 Jun 2019 03:30:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qvRuc1G5hShiYb2Oqdiz9ZXVwODihz91oKkv2BfHxE=;
 b=Txo1THbTvYmlu388Wv21+6+KGuFADaZ8CF3XiMcWEnihcaV972GEUC/aA5K8pwouN8YqgWOlre8q+zGtXHj+3hTVttPOQSMBhCr0ILKpkUOtZtbgc/hjvhd918S4s3tCEd1n92hT2pjDAXMj0uNcSX8Vsuh3dX35Q/L2xvB6JlI=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1661.namprd11.prod.outlook.com (10.172.53.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 20 Jun 2019 10:30:43 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::316b:7774:8db6:30ec]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::316b:7774:8db6:30ec%7]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 10:30:43 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <claudiu.beznea@gmail.com>
Subject: Re: [PATCH 0/7] clk: at91: sckc: improve error path
Thread-Topic: [PATCH 0/7] clk: at91: sckc: improve error path
Thread-Index: AQHVIf3bUSmswP0Le0qxy3Tkv6UCZA==
Date:   Thu, 20 Jun 2019 10:30:42 +0000
Message-ID: <929ac20b-db1d-3f7a-b37c-0dfb253156d5@microchip.com>
References: <1560440205-4604-1-git-send-email-claudiu.beznea@microchip.com>
 <20190618095521.GE23549@piout.net>
In-Reply-To: <20190618095521.GE23549@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0501CA0005.eurprd05.prod.outlook.com
 (2603:10a6:800:92::15) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190620133036236
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d59898d6-adc2-4646-bd4a-08d6f56a58af
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR11MB1661;
x-ms-traffictypediagnostic: MWHPR11MB1661:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR11MB166148147E11E57E279C155687E40@MWHPR11MB1661.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(39860400002)(366004)(346002)(189003)(199004)(52314003)(14454004)(6436002)(76176011)(6916009)(25786009)(53546011)(99286004)(31696002)(66066001)(52116002)(2616005)(6506007)(68736007)(229853002)(476003)(5660300002)(11346002)(8676002)(316002)(446003)(71190400001)(8936002)(26005)(386003)(6246003)(53936002)(66476007)(54906003)(66556008)(81166006)(2906002)(486006)(72206003)(81156014)(71200400001)(7736002)(186003)(86362001)(305945005)(4326008)(73956011)(66446008)(6486002)(102836004)(6116002)(256004)(36756003)(6306002)(6512007)(3846002)(966005)(478600001)(64756008)(31686004)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1661;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XN6NHzB3DN/76KMen2BxeJqTLMvuS9tyz9BkHL2Om70dKZkqDC5/XUexq1K4G0A9POIVg5n5Ajr7eBzFCU5haeooGkggApEtdUQBNgSdrqcWxgYQoSMihXmzII4LBQGpERHn9y96o2FrOgrJJBj/EkL4Z0AKOYa1QHGYgmjZSG8A9hlvLXXijHGtrX3u/c1UNgtcx9g1iL+FEElZua0phf4qEvSOOBur/LqVtpgGi6mNQDm3cBGohaDdaYEP0EWVV9Ys9HAAJqD5jBOhu3z8CH8Q0juBCf7wouikNda+h/yYxHsC2OKni4cWPAwwqQI7aDVOWPAILtzGYx+Sm/dYrKYzZWiR7GOzz+oEbP4nHo+cyaNdnZshW1s8clw1upJX9aag4PRkzFTMrUKHvsvvkdwcgwxBd+lALOErtA5QU9Q=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B69A89804D6A0240AB1264BA6322EE17@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d59898d6-adc2-4646-bd4a-08d6f56a58af
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 10:30:42.5186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: claudiu.beznea@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1661
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDE4LjA2LjIwMTkgMTI6NTUsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBP
biAxMy8wNi8yMDE5IDE1OjM3OjA2KzAwMDAsIENsYXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb20g
d3JvdGU6DQo+PiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlw
LmNvbT4NCj4+DQo+PiBIaSwNCj4+DQo+PiBUaGlzIHNlcmllcyB0cmllcyB0byBpbXByb3ZlIGVy
cm9yIHBhdGggZm9yIHNsb3cgY2xvY2sgcmVnaXN0cmF0aW9ucw0KPj4gYnkgYWRkaW5nIGZ1bmN0
aW9ucyB0byBmcmVlIHJlc291cmNlcyBhbmQgdXNpbmcgdGhlbSBvbiBmYWlsdXJlcy4NCj4+DQo+
IA0KPiBEb2VzIHRoZSBwbGF0Zm9ybSBldmVuIGJvb3Qgd2hlbiB0aGUgc2xvdyBjbG9jayBpcyBu
b3QgYXZhaWxhYmxlPyANCj4gDQo+IFRoZSBUQ0IgY2xvY2tzb3VyY2Ugd291bGQgZmFpbCBhdDoN
Cj4gDQo+ICAgICAgICAgdGMuc2xvd19jbGsgPSBvZl9jbGtfZ2V0X2J5X25hbWUobm9kZS0+cGFy
ZW50LCAic2xvd19jbGsiKTsNCj4gICAgICAgICBpZiAoSVNfRVJSKHRjLnNsb3dfY2xrKSkNCj4g
ICAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKHRjLnNsb3dfY2xrKTsNCj4gDQoNCkluIGNh
c2Ugb2YgdXNpbmcgVEMgYXMgY2xvY2tzb3VyY2UsIHllcywgdGhlIHBsYXRmb3JtIHdvdWxkbid0
IGJvb3QgaWYgc2xvdw0KY2xvY2sgaXMgbm90IGF2YWlsYWJsZSwgYmVjYXVzZSwgYW55d2F5IHRo
ZSBUQyBuZWVkcyBpdC4gUElUIG1heSB3b3JrDQp3aXRob3V0IGl0IChpZiBzbG93IGNsb2NrIGlz
IG5vdCB1c2VkIHRvIGRyaXZlIHRoZSBQSVQpLg0KDQpGb3Igc3VyZSB0aGVyZSBhcmUgb3RoZXIg
SVBzICh3aGljaCBtYXkgYmUgb3IgYXJlIGRyaXZlbiBieSBzbG93IGNsb2NrKQ0Kd2hpY2ggbWF5
IG5vdCB3b3JrIGlmIHNsb3cgY2xvY2sgaXMgZHJpdmVuIHRoZW0uDQoNCkFueXdheSwgcGxlYXNl
IGxldCBtZSBrbm93IGlmIHlvdSBmZWVsIHRoaXMgc2VyaWVzIGhhcyBubyBtZWFuaW5nLg0KDQpU
aGFuayB5b3UsDQpDbGF1ZGl1IEJlem5lYQ0KDQo+IA0KPj4gSXQgaXMgY3JlYXRlZCBvbiB0b3Ag
b2YgcGF0Y2ggc2VyaWVzIGF0IFsxXS4NCj4+DQo+PiBUaGFuayB5b3UsDQo+PiBDbGF1ZGl1IEJl
em5lYQ0KPj4NCj4+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzE1NTg0MzM0NTQt
Mjc5NzEtMS1naXQtc2VuZC1lbWFpbC1jbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tLw0KPj4N
Cj4+IENsYXVkaXUgQmV6bmVhICg3KToNCj4+ICAgY2xrOiBhdDkxOiBzY2tjOiBhZGQgc3VwcG9y
dCB0byBmcmVlIHNsb3cgb3NjaWxsYXRvcg0KPj4gICBjbGs6IGF0OTE6IHNja2M6IGFkZCBzdXBw
b3J0IHRvIGZyZWUgc2xvdyByYyBvc2NpbGxhdG9yDQo+PiAgIGNsazogYXQ5MTogc2NrYzogYWRk
IHN1cHBvcnQgdG8gZnJlZSBzbG93IGNsb2NrIG9zY2xpbGxhdG9yDQo+PiAgIGNsazogYXQ5MTog
c2NrYzogaW1wcm92ZSBlcnJvciBwYXRoIGZvciBzYW05eDUgc2NrIHJlZ2lzdGVyDQo+PiAgIGNs
azogYXQ5MTogc2NrYzogcmVtb3ZlIHVubmVjZXNzYXJ5IGxpbmUNCj4+ICAgY2xrOiBhdDkxOiBz
Y2tjOiBpbXByb3ZlIGVycm9yIHBhdGggZm9yIHNhbWE1ZDQgc2NrIHJlZ2lzdHJhdGlvbg0KPj4g
ICBjbGs6IGF0OTE6IHNja2M6IHVzZSBkZWRpY2F0ZWQgZnVuY3Rpb25zIHRvIHVucmVnaXN0ZXIg
Y2xvY2sNCj4+DQo+PiAgZHJpdmVycy9jbGsvYXQ5MS9zY2tjLmMgfCAxMjIgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQs
IDg2IGluc2VydGlvbnMoKyksIDM2IGRlbGV0aW9ucygtKQ0KPj4NCj4+IC0tIA0KPj4gMi43LjQN
Cj4+DQo+IA0K
