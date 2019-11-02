Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B992CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F105217D9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Vk5aAA7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfKBKoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 06:44:16 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:27685 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfKBKoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 06:44:15 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: dqLOTch4Wp/HX+Dd+ZSfhTjEOn0gXjj87nsPxnjj2R60zVVCkki2hf+jka8Gns91k+MZptv9QN
 i9WJ9SHoWqIxXNSR41faVNyM7qUQIin3ZlymtMKgYqF8oTHbaEmTV0ypla8qh7CE8PmwvH679u
 GhRfTqSG56GHFqX0mH4pt5Qf++rcjLu3RRP8qUnQRDZhUbnua9Rz+bszUwm9RbgBhmGV/envJj
 gSZW+wbZG8tGsjo2TsXbG/sWXyJVvGFhNkd5XY3ooKqdvXXldvLEWJsKFJ1eAFYoGfnQzKU5Or
 Jo8=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="53868133"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 03:44:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 03:44:13 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 2 Nov 2019 03:44:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWeN3awINSlZaBQQu3IWzB7XYGBhosMUg0/iWkzbKmCs6nY3zbjFdLxNjbI/0DPS19s24OHaCPg7LpGBcfVyQ3YI6HrrzK7Fvb7dPo8p6aSOPdvYxWMUMfIvcr4oLpegiuJPS2ny26UhslRQfje5U2NXUlZf6n6aleFFq+uj1k2BwKeNl1mcmT9GxZYG4CSn58/BLd2F7LotGw3WwL1PU4R1pxNNfXmE2lb84d/hgolYHHlawZGUL5+S72FDc8OpIEy+VO0Man0I2GZZNQ9aDM0jfeUcd4BoxTFxtevkoj63OTJIxRD4uK9aOoK5+ugdz9sipi24f6qedJnHkdbCAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7E6k81Gv2WN/Ar8PoDUcCyOeJj9HJVjroCrcQEtHDEg=;
 b=P3qpax+AYe+ulnuSWC7sC+zG7FjSiCjhgOpIFFwIJa0HOlGzYY8tZ3aczLi5oTz1IO/aCpt7oPs9bQXT8tbrQRoIDpdRi/+uPIbMe+dlX4B2tnUW5cKFVQMMUJO9zl8Z6SCxbOTJhtOHb+my3uzelAfcdrEejcygz18pYjRn0qVIT9NuxVZx8TMGAeqP+3FTo7K/t/221JfyWXvi3nwzp1eihm3KO/MS2XvN7wx1AUEp3c775vaiOANQQr+MAeCLbnzODQfscvVz3OZWjRlIO5Qis4avS1WgckflFMKTPddl9tW4oEl34Nqi4EZZCOGz1l1E6/KFI7lvPnXv5ePzCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7E6k81Gv2WN/Ar8PoDUcCyOeJj9HJVjroCrcQEtHDEg=;
 b=Vk5aAA7mQOMccF5ENNNLBaQ/u6aW7xozqV5CubwbEQU/0Wjx+vWmi382halsCXvlZz084opuMZqBSmTYWmkFjAto1nsbkpWa64zl5bFzfyL/Mv3CSG1DpE0GvQzlnPZazQ3xksqEI6HCp/FFvgMWMeAcwd18EhmWEi6jLqE9lUU=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3629.namprd11.prod.outlook.com (20.178.252.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Sat, 2 Nov 2019 10:44:05 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 10:44:05 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 09/32] mtd: spi-nor: Pointer parameter for FSR in
 spi_nor_read_fsr()
Thread-Topic: [PATCH v3 09/32] mtd: spi-nor: Pointer parameter for FSR in
 spi_nor_read_fsr()
Thread-Index: AQHVjkpjFsCVETDwxUiEqOeciq1tr6d3uD+A
Date:   Sat, 2 Nov 2019 10:44:05 +0000
Message-ID: <478ae771-75fc-b721-3278-1f1a35735ec1@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
 <20191029111615.3706-10-tudor.ambarus@microchip.com>
In-Reply-To: <20191029111615.3706-10-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0006.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:d0::16) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 383a9e07-f980-4470-6395-08d75f819541
x-ms-traffictypediagnostic: MN2PR11MB3629:
x-microsoft-antispam-prvs: <MN2PR11MB362924102DEF64D76031FFCAF07D0@MN2PR11MB3629.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(39850400004)(136003)(189003)(199004)(66946007)(66556008)(316002)(66446008)(52116002)(2201001)(86362001)(76176011)(6512007)(53546011)(386003)(14454004)(305945005)(6116002)(229853002)(31696002)(6486002)(446003)(71190400001)(25786009)(36756003)(4326008)(66066001)(6246003)(6506007)(102836004)(2616005)(99286004)(8936002)(478600001)(71200400001)(11346002)(8676002)(81166006)(66476007)(81156014)(2501003)(256004)(3846002)(5660300002)(64756008)(7736002)(31686004)(6436002)(186003)(4744005)(2906002)(26005)(110136005)(54906003)(486006)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3629;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YMjOoJW/2M81dIPIMTV63eSYz6R0tR1k4geLRJEY8ICKCmUhnmIPDlwOTxo3+Zi6QOOgto65BqXcbNZYpdGp+Rdu+Gpn1+XFCaLwWAShFRW1sVrOykcLHoIOWd+p+6Tn0ccWsMwG6q7C3OS1khgUz+7EqBu76mKs+5X7erPSizt5DVtjsWs0dkDhHWk4UydbKhSHeF/2+zlKS50JdyK/Uk/AWAz0RDX1Byz2GcqFa6VcSNGL1yJb1RqJbM7guyu1CMYwf7+j6u6kTPyp5FztRvXEtGPwouStTMUHwdRSBY3dnKNb+glCBK+cvgoU/v7cHmNO5r1EpE8omhOjpTUU7Ag2hIBcYnUJ0FefI+kLf3xmGUzpj9BKYaEa/xrYvOcwB+NYD/49hovsgJjxeTCSYmTmzeiGtQgQVTw35p/HD1q4h6eITtzUpU3SUmsc4M0Y
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CDD3EBF2E81EF4A928871E79571C774@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 383a9e07-f980-4470-6395-08d75f819541
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 10:44:05.7803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MOCPn6PB9qmcW3XjSiZ1T6lbpnkcG7PE+VXrjNWLpEGTU9Al09C2gpLoPUJNz6Mf48rg/STsYRzKBulw0aHTCQ89CIGifgcENrvzzwiey9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzI5LzIwMTkgMDE6MTcgUE0sIFR1ZG9yIEFtYmFydXMgLSBNMTgwNjQgd3JvdGU6
DQo+IEZyb206IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4g
DQo+IExldCB0aGUgY2FsbGVycyBwYXNzIHRoZSBwb2ludGVyIHRvIHRoZSBETUEtYWJsZSBidWZm
ZXIgd2hlcmUNCj4gdGhlIHZhbHVlIG9mIHRoZSBGbGFnIFN0YXR1cyBSZWdpc3RlciB3aWxsIGJl
IHdyaXR0ZW4uIFRoaXMgd2F5IHdlDQo+IGF2b2lkIHRoZSBjYXN0cyBiZXR3ZWVuIGludCBhbmQg
dTgsIHdoaWNoIGNhbiBiZSBjb25mdXNpbmcuDQo+IA0KPiBDYWxsZXIgc3RvcHMgY29tcGFyZSB0
aGUgcmV0dXJuIHZhbHVlIG9mIHNwaV9ub3JfcmVhZF9mc3IoKSB3aXRoIG5lZ2F0aXZlLA0KPiBz
cGlfbm9yX3JlYWRfZnNyKCkgcmV0dXJucyAwIG9uIHN1Y2Nlc3MgYW5kIC1lcnJubyBvdGhlcndp
c2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1p
Y3JvY2hpcC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgfCAz
OCArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDIwIGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KDQpSZXBsYWNlZCAmbm9yLT5i
b3VuY2VidWZbMF0gd2l0aCBub3ItPmJvdW5jZWJ1ZiBhbmQgYXBwbGllZCB0byBzcGktbm9yL25l
eHQuIFRoYW5rcy4NCg==
