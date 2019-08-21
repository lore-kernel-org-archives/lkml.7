Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B63C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A3B2339F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfHUH30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 03:29:26 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:27227 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbfHUH30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:29:26 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: cwuR3BrswxSbXt+XiiUxWMcvGuhNJiHKXuw9oiNhJJj9C28Cz3JfyQtLvYvadqcssv04mdype/
 k1kOd/kHpgpfmP/UGD/mhizFHVWT7pElApmNY1nozow14HS6uqK7rst79n5wX649U2qMRJArPx
 FKWPC4GYX09GSGdyH8Hx7iEe0VeJN7iRie5NWiYF3uvTsBBebdk7Kj8Sozw2DLq0wQnJYCZGJt
 JfH6itSRoxz49C4rFiRGZcoKmIko721c/hWxv1HW3SPTKA0vHZLyAysyeml/JDl7tK/vU/bMBV
 6SM=
X-IronPort-AV: E=Sophos;i="5.64,411,1559545200"; 
   d="scan'208";a="46027795"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Aug 2019 00:29:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 21 Aug 2019 00:29:23 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 21 Aug 2019 00:29:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbKtuuGXkrMyTYcwQR2VCGHH7x/f+AKu2+Cz5pOl6j1zcIAgzHRxtP18/zyLkbG8jbijDkoZEBC1uh346bFcoBTOjou6gjvSPe9fgAPDR7tuR+ua/5O8LdUIWkS+LBENDzUSL5Y0+OKUzOU3vVMvp15IVKRhCAo93hpTeVDYyhaGXB2Vf5bR85RQo0PJiWEzRaYyovHkGPXkpiXDHydFeVIjnuXoJpZt/olkVPTE/YqpcI7k0Wrvw2JoapJDfnMnbCdotYdFhFPuEmTrUshUi6H7XnrVVu6cxuqLkJ0eKO7MfUnkEa9KhvI8O6I5HBq6YjSAMEvUAIMSQCqEYEkILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lz8AZ6TmjX0s/Uxxt+xp0ZEOwqshmxwlIQzCw1csZyU=;
 b=DfAhXRQE34mt0OkHtF+DLRQspiw8UKxC4KLTNg8ySLN1qKXwt6dgNzIvHWSPs/ArESDxY7mOGe8XG+g/upvIzTRzs4Vujbv5BYX3GgBm3Ifnn35P75nN9VnV8+xRncN0Rcwk4qGc+6hnQ04K1eix8RV9ByY1vfsEvxz5qr/s8Ia7cgdHERRRU+vR3z4H2TXePkNWqdbhCgsXEl3hwN20/rHhIUTNdEtcyC6ZWfSImkmKUcCCuHWLkzTiZU8dsQdIagBZVqF98lDvxaFBnghQplJ1DTsKef7yqzdoSMVeaRwOstRLqir69/cafaWYv/J2ovOnTgo2dMdeYJXGeM9ACQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lz8AZ6TmjX0s/Uxxt+xp0ZEOwqshmxwlIQzCw1csZyU=;
 b=RxyLPYgQWTHnsiQz3D3CWt984kC2/smszwDLX4RxRvRG0tdJ+mx7/Uk87G8acciyMcnPRd4Jq+pU6P65tF/LJH9HOSPWae5GwrInUN5YvgeAv4bHHVYZ42I7PKqOBMzkLAnAFu52NJ8codIhnH8rVzZR04uw3wdZYLO1gYzbAvc=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3934.namprd11.prod.outlook.com (10.255.180.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 07:29:21 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 07:29:21 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <thor.thayer@linux.intel.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] mtd: spi-nor: Fix Cadence QSPI RCU Schedule Stall
Thread-Topic: [RESEND] mtd: spi-nor: Fix Cadence QSPI RCU Schedule Stall
Thread-Index: AQHVU7xeH2z0neoGB0mjYqq1QJRJg6cFPMmA
Date:   Wed, 21 Aug 2019 07:29:21 +0000
Message-ID: <91a99466-62b5-a928-3019-8a198d28fcd7@microchip.com>
References: <1565909736-11379-1-git-send-email-thor.thayer@linux.intel.com>
In-Reply-To: <1565909736-11379-1-git-send-email-thor.thayer@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P194CA0008.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::18) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8343eb56-e483-4f62-62a5-08d7260948d3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3934;
x-ms-traffictypediagnostic: MN2PR11MB3934:
x-microsoft-antispam-prvs: <MN2PR11MB393456E1F496727EC8DD2A34F0AA0@MN2PR11MB3934.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(366004)(376002)(45904002)(189003)(199004)(6486002)(386003)(76176011)(4326008)(53936002)(7736002)(5660300002)(14454004)(99286004)(6246003)(6512007)(2906002)(52116002)(54906003)(31686004)(2501003)(316002)(6116002)(110136005)(305945005)(25786009)(66066001)(31696002)(3846002)(26005)(478600001)(486006)(2201001)(8936002)(71200400001)(36756003)(71190400001)(186003)(256004)(14444005)(2616005)(66476007)(81156014)(81166006)(229853002)(66556008)(446003)(11346002)(8676002)(476003)(66446008)(6436002)(102836004)(86362001)(66946007)(53546011)(6506007)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3934;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g/hAezB3+kWAdEHEAHuTJe6ePAu4/cKWqFSdl13VvwmKuYG5zxFIw+L4FSbjH9ogNeawnKpZV8uuVMS0+lHYxea6rXs7d6qEhRi3XMXIpASyur487HQlyLNIKbUaa6qc7L5UZsrSVXvOT/V7P9bqz7ORQXVN9opVuxEQiTDPYhhx0ePHPVZzOGWQf5wbzCDTkJ+GSocbC00WcL1sAfQYzcCRO3esDbjIuf6OwoT6zTmnVmMzFqm+FF3u/l2+idBLP612ym+BhVouLQw4JCD4qWqUJg8iILbD2sBmaRDbQr6NowqTTCyPkrad/zsgCuB+FalJYPaES1GkQhP/kBzLgPcaG20NcyqRdc2MjmlHGhi1BzeFGe1LQI29GwJfLR6LNI0yz0KtupUwerZ5HmbiqYy+SY8IvpO2JIWpvbmOaI0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABC08B6E90FDF6449B6100419F89BF8B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8343eb56-e483-4f62-62a5-08d7260948d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 07:29:21.6127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4OnUfI6IPEjw16I/0rwhp5vAXwCTaCJiSEDYiZBVi5aQKFxqjKLDufZFAl8n5PyQFDEcKUhVAxKlIlJrn/w4eum6fDRTl+yLYFFg3BaPEq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWlxdWVsLA0KDQpPbiAwOC8xNi8yMDE5IDAxOjU1IEFNLCB0aG9yLnRoYXllckBsaW51eC5pbnRl
bC5jb20gd3JvdGU6DQo+IEV4dGVybmFsIEUtTWFpbA0KPiANCj4gDQo+IEZyb206IFRob3IgVGhh
eWVyIDx0aG9yLnRoYXllckBsaW51eC5pbnRlbC5jb20+DQo+IA0KPiBUaGUgY3VycmVudCBDYWRl
bmNlIFFTUEkgZHJpdmVyIHNvbWV0aW1lcyBjYXVzZWQgYQ0KPiAicmN1X3NjaGVkIHNlbGYtZGV0
ZWN0ZWQgc3RhbGwiIHdoaWxlIHdyaXRpbmcgbGFyZ2UgZmlsZXMuDQo+IA0KPiBTdGFsbCBSZXBv
cnQ6DQo+ICcjIG10ZF9kZWJ1ZyB3cml0ZSAvZGV2L210ZDEgMCA0ODgxNjQ2NCBibG9iLmltZw0K
PiBbIDE4MTUuNDU0MjI3XSByY3U6IElORk86IHJjdV9zY2hlZCBzZWxmLWRldGVjdGVkIHN0YWxs
IG9uIENQVQ0KPiBbIDE4MTUuNDU5Nzg5XSByY3U6ICAgICAwLS4uLi46ICgyMDk5IHRpY2tzIHRo
aXMgR1ApIGlkbGU9OGM2LzEvMHg0MDAwMDAwMg0KPiAgc29mdGlycT02NDkyLzY0OTIgZnFzPTkz
NQ0KPiBbIDE4MTUuNDY4NDQyXSByY3U6ICAgICAgKHQ9MjEwMCBqaWZmaWVzIGc9ODc0OSBxPTI0
NykNCj4gCTxzbmlwPiAoYWJicmV2aWF0ZWQgYmFja3RyYWNlKQ0KPiBbIDE4MTUuNzcyMDg2XSBb
PGMwNWEzZWEwPl0gKGNxc3BpX2V4ZWNfZmxhc2hfY21kKSAoY3FzcGlfcmVhZF9yZWcpDQo+IFsg
MTgxNS43ODYyMDNdIFs8YzA1YTU0ODg+XSAoY3FzcGlfcmVhZF9yZWcpIGZyb20gKHJlYWRfc3Ip
DQo+IFsgMTgxNS44MDM3OTBdIFs8YzA1YTAzMzA+XSAocmVhZF9zcikgZnJvbQ0KPiAJKHNwaV9u
b3Jfd2FpdF90aWxsX3JlYWR5X3dpdGhfdGltZW91dCkNCj4gWyAxODE1LjgxNjYxMF0gWzxjMDVh
MTgyYz5dIChzcGlfbm9yX3dhaXRfdGlsbF9yZWFkeV93aXRoX3RpbWVvdXQpIGZyb20NCj4gCShz
cGlfbm9yX3dyaXRlKzB4MTA0LzB4MWQwKQ0KPiBbIDE4MTUuODM2NzkxXSBbPGMwNWExYTQ0Pl0g
KHNwaV9ub3Jfd3JpdGUpIGZyb20gKHBhcnRfd3JpdGUrMHg1MC8weDU4KQ0KPiAJPHNuaXA+DQo+
IFsgMTgxNS45OTc5NjFdIGNhZGVuY2UtcXNwaSBmZjgwOTAwMC5zcGk6IEZsYXNoIGNvbW1hbmQg
ZXhlY3V0aW9uIHRpbWVkIG91dC4NCj4gWyAxODE2LjAwNDczM10gZXJyb3IgLTExMCByZWFkaW5n
IFNSDQo+IGZpbGVfdG9fZmxhc2g6IHdyaXRlLCBzaXplIDB4MmU4ZTE1MCwgbiAweDJlOGUxNTAN
Cj4gd3JpdGUoKTogQ29ubmVjdGlvbiB0aW1lZCBvdXQNCj4gDQo+IFRoaXMgd2FzIGNhdXNlZCBi
eSBhIHRpZ2h0IGxvb3AgaW4gY3FzcGlfd2FpdF9mb3JfYml0KCkuIEZpeCBieSB1c2luZw0KPiBy
ZWFkbF9yZWxheGVkX3BvbGxfdGltZW91dCgpIHdoaWNoIHNsZWVwcyAxMHVzIHdoaWxlIHBvbGxp
bmcgYSByZWdpc3Rlci4NCj4gDQo+IEZpdCBvbnRvIDgwIGNoYXJhY3RlciBsaW5lIGJ5IHRydW5j
YXRpbmcgdGhlIGJvb2wgY2xlYXIgcGFyYW1ldGVyDQo+IA0KPiBGaXhlczogMTQwNjIzNDEwNTM2
ICgibXRkOiBzcGktbm9yOiBBZGQgZHJpdmVyIGZvciBDYWRlbmNlIFF1YWQgU1BJIEZsYXNoIENv
bnRyb2xsZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBUaG9yIFRoYXllciA8dGhvci50aGF5ZXJAbGlu
dXguaW50ZWwuY29tPg0KDQpQcm9iYWJseSB0aGlzIGlzIGEgZ29vZCBjYW5kaWRhdGUgZm9yIG10
ZC9maXhlcy4NCg0KUmV2aWV3ZWQtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWlj
cm9jaGlwLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY2FkZW5jZS1xdWFk
c3BpLmMgfCAxOSArKysrKy0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210
ZC9zcGktbm9yL2NhZGVuY2UtcXVhZHNwaS5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jYWRlbmNl
LXF1YWRzcGkuYw0KPiBpbmRleCA2N2YxNWExZjE2ZmQuLjdiZWY2Mzk0N2IyOSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9jYWRlbmNlLXF1YWRzcGkuYw0KPiArKysgYi9kcml2
ZXJzL210ZC9zcGktbm9yL2NhZGVuY2UtcXVhZHNwaS5jDQo+IEBAIC0xMyw2ICsxMyw3IEBADQo+
ICAjaW5jbHVkZSA8bGludXgvZXJybm8uaD4NCj4gICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQu
aD4NCj4gICNpbmNsdWRlIDxsaW51eC9pby5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5o
Pg0KPiAgI2luY2x1ZGUgPGxpbnV4L2ppZmZpZXMuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9rZXJu
ZWwuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gQEAgLTI0MSwyMyArMjQyLDEz
IEBAIHN0cnVjdCBjcXNwaV9kcml2ZXJfcGxhdGRhdGEgew0KPiAgDQo+ICAjZGVmaW5lIENRU1BJ
X0lSUV9TVEFUVVNfTUFTSwkJMHgxRkZGRg0KPiAgDQo+IC1zdGF0aWMgaW50IGNxc3BpX3dhaXRf
Zm9yX2JpdCh2b2lkIF9faW9tZW0gKnJlZywgY29uc3QgdTMyIG1hc2ssIGJvb2wgY2xlYXIpDQo+
ICtzdGF0aWMgaW50IGNxc3BpX3dhaXRfZm9yX2JpdCh2b2lkIF9faW9tZW0gKnJlZywgY29uc3Qg
dTMyIG1hc2ssIGJvb2wgY2xyKQ0KPiAgew0KPiAtCXVuc2lnbmVkIGxvbmcgZW5kID0gamlmZmll
cyArIG1zZWNzX3RvX2ppZmZpZXMoQ1FTUElfVElNRU9VVF9NUyk7DQo+ICAJdTMyIHZhbDsNCj4g
IA0KPiAtCXdoaWxlICgxKSB7DQo+IC0JCXZhbCA9IHJlYWRsKHJlZyk7DQo+IC0JCWlmIChjbGVh
cikNCj4gLQkJCXZhbCA9IH52YWw7DQo+IC0JCXZhbCAmPSBtYXNrOw0KPiAtDQo+IC0JCWlmICh2
YWwgPT0gbWFzaykNCj4gLQkJCXJldHVybiAwOw0KPiAtDQo+IC0JCWlmICh0aW1lX2FmdGVyKGpp
ZmZpZXMsIGVuZCkpDQo+IC0JCQlyZXR1cm4gLUVUSU1FRE9VVDsNCj4gLQl9DQo+ICsJcmV0dXJu
IHJlYWRsX3JlbGF4ZWRfcG9sbF90aW1lb3V0KHJlZywgdmFsLA0KPiArCQkJCQkgICgoKGNsciA/
IH52YWwgOiB2YWwpICYgbWFzaykgPT0gbWFzayksDQo+ICsJCQkJCSAgMTAsIENRU1BJX1RJTUVP
VVRfTVMgKiAxMDAwKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGJvb2wgY3FzcGlfaXNfaWRsZShz
dHJ1Y3QgY3FzcGlfc3QgKmNxc3BpKQ0KPiANCg==
