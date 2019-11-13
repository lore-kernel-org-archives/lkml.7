Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167B2C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D67222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="s6yDoIKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfKMLPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 06:15:10 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:47628 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfKMLPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 06:15:10 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Cwk9j49k05muuy61Ma9931YppjH7Ayw5PoG3tpIgKHi0Lf8FsrVMw95eKPZIHCQWlMqw5obidp
 MU/bx3YsW5FFtRbHDQF9GVahe76gE+lX3y6lnhOe+7x/k1zk9YCZq599DI9v124NCp48ejOj1G
 gWIHU6YPULHXGeySLcDY1eHFdmJLQOj+FUsqnwu8Im3JvvKTBC5J3tuwKCLtqRLyMkEDC5UZ9+
 fs3sUvQAw76aTL+vwaoW+5BkDyRtixrrwIxID/VeZwKhGCiG7MGYgrI3afcnf9QKG80DNmvpVm
 vMY=
X-IronPort-AV: E=Sophos;i="5.68,300,1569308400"; 
   d="scan'208";a="56886588"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Nov 2019 04:15:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Nov 2019 04:15:09 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 13 Nov 2019 04:15:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZ/JPXfeRUrnwXVqEXsvVtd+LWm1j5b0gOj4mhTrpEkICNe03WTPeiWAsBOINpySKnrRHhGKOXEhhs4sVX2c94wGr+ySlvrVzemPXXzrAFVMqY6yUGuz60pPW0TvEqhDgMM81E7HF2doGW4pfXyFHbWTwBg2Cs499DiRSqtTINlWUNAFjGi7bMfPaSRMSVGvThHS7V4gssYkLFWHf5BmPyp3QIdpoGujC8LZgFg9GsqzRUKBq2roU0gAbffPgetCF5EeUUF+ZplHBaBMBQJrz1pMzrHiIH/HM0JioAiYtHg+WSm2xQZ7PqoBnO9yiko+e9Ih/Hc058Mk45F7qeuTOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/AHet2aaRlIDLXgDuPutYNnU8mwg7TxExXu5iCyG8w=;
 b=cCkaG2IzCFSax7b7mv8fY9I8MLvbXDNXfXi9XUvzRC4K6/gi9GjdKF9lJH03+VeYKno8YsOpvse49tE3DeFc3SVerolbAcw080RKGk9H5gjyS+UIgSJ/wZ+d0j1YZgTAsAnsWEKACBXypmCwIQ+xFnOpL/+n4nhL8o28syT7VNY78Ejb6j4+ydeaV8ZgGfxv1SfGzgcSLdoljKrb0pOsZPBbbFYMG2Rz6bpOYEOWi3MqAo2upGu8GIdsmOPNv8DHQSCsWHyIvdvoX8jE8ji+Kvjkvhw1EHsNZyLhkaR6gBGbmY/qTEMrKb8WSWXhuRxxgjt3eMI8xMcMhkcw901MVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/AHet2aaRlIDLXgDuPutYNnU8mwg7TxExXu5iCyG8w=;
 b=s6yDoIKFA8Ssj47FfVHp9D4lP1BDdz9kF5XylYuGDd4NJWXEj37wvnlXMMlG+b06km/4ge+Vx4GCNJn+ERaue/3FgmTLTxmp1gFf4/b0j4L0UdlK8K+rRxETph2n3mfPbeLubmdoQjCRnRgWZczlsnY8R97DNrt7jFRax7oWW0M=
Received: from BYAPR11MB3224.namprd11.prod.outlook.com (20.177.127.88) by
 BYAPR11MB3207.namprd11.prod.outlook.com (20.177.184.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 11:15:07 +0000
Received: from BYAPR11MB3224.namprd11.prod.outlook.com
 ([fe80::f4eb:2c83:7aec:ee98]) by BYAPR11MB3224.namprd11.prod.outlook.com
 ([fe80::f4eb:2c83:7aec:ee98%3]) with mapi id 15.20.2430.023; Wed, 13 Nov 2019
 11:15:07 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linux@armlinux.org.uk>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] add defconfig support for SAM9X60
Thread-Topic: [PATCH 00/13] add defconfig support for SAM9X60
Thread-Index: AQHVmhOaxsb1PFuwzEKI4243iHeyKA==
Date:   Wed, 13 Nov 2019 11:15:07 +0000
Message-ID: <fe877350-d50c-c2d8-a07f-0c577de08358@microchip.com>
References: <1573635069-30883-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1573635069-30883-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR08CA0058.eurprd08.prod.outlook.com
 (2603:10a6:205:2::29) To BYAPR11MB3224.namprd11.prod.outlook.com
 (2603:10b6:a03:77::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191113131500526
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9809fe8-3fc8-4495-194c-08d7682abd45
x-ms-traffictypediagnostic: BYAPR11MB3207:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB32074EE40873D3E4EA14813487760@BYAPR11MB3207.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(396003)(136003)(199004)(189003)(71200400001)(64756008)(186003)(86362001)(53546011)(66446008)(6116002)(6436002)(6486002)(54906003)(305945005)(66066001)(66946007)(66476007)(66556008)(102836004)(256004)(316002)(6246003)(31686004)(71190400001)(229853002)(110136005)(478600001)(6512007)(7736002)(52116002)(25786009)(6506007)(2616005)(76176011)(8936002)(486006)(31696002)(6636002)(81166006)(2501003)(14454004)(26005)(446003)(99286004)(11346002)(386003)(2906002)(4326008)(5660300002)(476003)(8676002)(36756003)(3846002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3207;H:BYAPR11MB3224.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7s50Zw0DHh5CGZaskgH9gsB+G+ny29tjwFHAK1sXYsk2LZ1A96i6PwKi+wEia7vyC6GmEYAQFOseVM9YTq1YjQePgRbkKxPVeDyGSJeXi/N/iiXzpxCi18WYJ0fVryASFrUnTYRvcSs2gDig2iFoIHOiHxdy2G5gXYcF1cOjBPFdpzIgCOc0hj0jXYc7wS0/lAjfs0nQO7+9UgXu01rzkj9EdE3yfj+QqjZsc8nXUcvw/iXQG5hb6A9bMM0T74t4QG3St7KLCrRzgCK6cQFGpBR26IdYR6ysUI4VIcK2AyGn5Ugwf0tEK+atbc9twHpxO/Ezn0Bwk9RVPd/5KgXLmzSYRmHIhIMXtIYAn/JEcEi/PymGri4AE8ljzM09CPGCuaoQ28S7KJe+Vgr/+3PhlJuw2133Q8sAQuC+KlXli1HFFt7uz7qe6DA+ovQj7Ick
Content-Type: text/plain; charset="utf-8"
Content-ID: <B43A231ABEF0FC4BA13AEAB52BFFEE83@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b9809fe8-3fc8-4495-194c-08d7682abd45
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 11:15:07.1700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ub90rkXBAmeHpJ0nPPVZD76N1QAoYIkfMAlWDKbGxh+o8uj7mnONNfRIVdO6oGf2r8hO0Uqr+8wxSRdQR90X0NnpwDsY2GyamVLqA3JY7TE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClBsZWFzZSBpZ25vcmUgdGhpcyBzZXJpZXMgZm9yIHRoZSBtb21lbnQuDQoNClRoYW5r
IHlvdSwNCkNsYXVkaXUgQmV6bmVhDQoNCk9uIDEzLjExLjIwMTkgMTA6NTAsIENsYXVkaXUgQmV6
bmVhIHdyb3RlOg0KPiBIaSwNCj4gDQo+IFRoaXMgc2VyaWVzIGVuYWJsZXMgcHJvcGVyIHN1cHBv
cnQgZm9yIFNBTTlYNjAgaW4gS2NvbmZpZyBhbmQNCj4gZGVmY29uZmlnLg0KPiANCj4gVGhhbmsg
eW91LA0KPiBDbGF1ZGl1IEJlem5lYQ0KPiANCj4gQ2xhdWRpdSBCZXpuZWEgKDgpOg0KPiAgIEFS
TTogYXQ5MTogS2NvbmZpZzogYWRkIHNhbTl4NjAgcGxsIGNvbmZpZyBmbGFnDQo+ICAgQVJNOiBh
dDkxOiBLY29uZmlnOiBhZGQgY29uZmlnIGZsYWcgZm9yIFNBTTlYNjAgU29DDQo+ICAgQVJNOiBh
dDkxL2RlZmNvbmZpZzogdXNlIHNhdmVkZWZjb25maWcNCj4gICBBUk06IGF0OTEvZGVmY29uZmln
OiBhZGQgY29uZmlnIG9wdGlvbiBmb3IgU0FNOVg2MCBTb0MNCj4gICBBUk06IGF0OTEvZGVmY29u
ZmlnOiBlbmFibGUgYXRtZWwgbWF4dG91Y2gNCj4gICBBUk06IGF0OTEvZGVmY29uZmlnOiBlbmFi
bGUgU0FNQTVEMidzIFNIRFdDDQo+ICAgQVJNOiBhdDkxL2RlZmNvbmZpZzogZW5hYmxlIGZsZXhj
b20NCj4gICBBUk06IGF0OTEvZGVmY29uZmlnOiBlbmFibGUgWERNQUMNCj4gDQo+IENvZHJpbiBD
aXVib3Rhcml1ICgzKToNCj4gICBBUk06IGF0OTEvZGVmY29uZmlnOiBBZGQgSTJTIE11bHRpLWNo
YW5uZWwgZHJpdmVyDQo+ICAgQVJNOiBhdDkxL2RlZmNvbmZpZzogQWRkIGRyaXZlciBmb3IgQXVk
aW8gUFJPVE8gYm9hcmQNCj4gICBBUk06IGF0OTEvZGVmY29uZmlnOiBlbmFibGUgQ0xBU1NEDQo+
IA0KPiBUdWRvciBBbWJhcnVzICgyKToNCj4gICBBUk06IGF0OTEvZGVmY29uZmlnOiBlbmFibGUg
QVQ5MV9TQU1BNUQyX0FEQw0KPiAgIEFSTTogYXQ5MS9kZWZjb25maWc6IGVuYWJsZSBBVE1FTF9R
VUFEU1BJDQo+IA0KPiAgYXJjaC9hcm0vY29uZmlncy9hdDkxX2R0X2RlZmNvbmZpZyB8IDU2ICsr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICBhcmNoL2FybS9tYWNoLWF0
OTEvS2NvbmZpZyAgICAgICAgIHwgMTMgKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDM5
IGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKQ0KPiANCg==
