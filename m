Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C65CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710F520679
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="mSh8j4Uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfKBKmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 06:42:39 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:41635 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfKBKmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 06:42:38 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: buoDDmDeXeA4p32yIZVcxN3GJrTYfbn6yiIiDtG282Vkqi9HmvjfUXoqTklEa73Gf9n2BLaar/
 /N847P4pOEASr6Y0B50SGGnceD2oJFac/b1/LpMzQzUFtLqy50WIsyQ9bcfgBjyxKQUgobptnU
 7g1mLcGkUzwgPeKTz/E4425cyBewGJJVH7rbW1BmqtSM6QZLFMHnJKcazEwudMqsH74eiRa7w2
 qwL+mXvoJ1QOR/2DDezVkeZM1cNw59vBwmm2NWekWYiZvCWxM0/o38Dhm8XymIAS2rEkB8bzY4
 0zw=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="55070846"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 03:42:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 03:42:33 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 2 Nov 2019 03:42:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ep0Ld66/j9zlSq2Dh69fAi1oBprfe4N9M//Xod6XCDKgNhqf0UThJZrKBQaeJGqJh7uYJNLjCrGGctoCqxV1F/++A740js9IipdqRHVkteQnAfKGVRTLXH5e8fK5o0ATcBk8TTEuRg5LODn4P7Suqg75tESXe2BlwsyKLDxvC5wkajytP8xrRgkBk/pCULaQ3qq7aIbpajlX873uSbdA39/dreQpp0FZfPcD/hvgQxsJP0s0bLIZtgjCppH6Q9Zmju5H4chR2TgHVt9Ra/j/RUPF6ImSIcbvxk02szutmAfFCDLBhYuOEYeMjuCQTowYcpW5AQIoTT43gRdagu3YZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hVyZtWmVpCoI2cDPnqHVcZBAKMDqDxdc8pA2Kg4vsw=;
 b=Fe5HV8V2FoJ8zhVDtG8vuwVIJMPDigMIr6D7jofrylvsQ9GAV4mHwGwr6jE2rJwP4LVc7gYaWSNZtVHoGX9E0le8s21TazKzaVljGXjE/2h9Zqm2P6H4JNwciexnM0inBFA9BxMZLAhofcP4Kcrf+6fHPRvcd6OOsDzjSdu0u+x2ka2dBuKls20ICyPHu+ATBlxWbZwMDuusRUDhSx84tENGaLcmRV50y6MI6HE9yAPrgmFhtEqkQOKthU9Qgvc1zwD8CLv0vw8XvGFzT/rUMO2Kz9z+XbGBB2SUkOAaFpoyRKMoVSWdBvFLYa0+ej57tz4U9hL8wTfTzXtL2/ryiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hVyZtWmVpCoI2cDPnqHVcZBAKMDqDxdc8pA2Kg4vsw=;
 b=mSh8j4UoZP+FKkXX2LMzgF2V0+dfuBb9tSYQ10yGqAZkg07ykHY+rY5GeiHQThobdXVm6jTucnRsJzkVc4TkvDEc3r4q6fGAs/PFP5pjrTsYfXmJBncv0DZNE25RIfojEdlA0vnV7doZV28I/wMmPck7fJf6yTK+7zy/jfdE290=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3629.namprd11.prod.outlook.com (20.178.252.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Sat, 2 Nov 2019 10:42:29 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 10:42:29 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 08/32] mtd: spi-nor: Pointer parameter for SR in
 spi_nor_read_sr()
Thread-Topic: [PATCH v3 08/32] mtd: spi-nor: Pointer parameter for SR in
 spi_nor_read_sr()
Thread-Index: AQHVjkpiOw/hcnX3gEiJ07FI3O5zB6d3t84A
Date:   Sat, 2 Nov 2019 10:42:29 +0000
Message-ID: <44a8a755-f3c6-f188-dc5b-dcebc1055f17@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
 <20191029111615.3706-9-tudor.ambarus@microchip.com>
In-Reply-To: <20191029111615.3706-9-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P18901CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::16) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be2d39c1-0174-4c6b-6d48-08d75f815bc1
x-ms-traffictypediagnostic: MN2PR11MB3629:
x-microsoft-antispam-prvs: <MN2PR11MB36293B96001954B8965D1EB1F07D0@MN2PR11MB3629.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(39850400004)(136003)(189003)(199004)(66946007)(66556008)(316002)(66446008)(52116002)(2201001)(86362001)(76176011)(6512007)(53546011)(386003)(14454004)(305945005)(6116002)(229853002)(31696002)(6486002)(446003)(71190400001)(25786009)(36756003)(4326008)(66066001)(6246003)(6506007)(102836004)(2616005)(99286004)(8936002)(478600001)(71200400001)(11346002)(8676002)(81166006)(66476007)(81156014)(2501003)(256004)(3846002)(5660300002)(64756008)(7736002)(31686004)(6436002)(186003)(4744005)(2906002)(26005)(110136005)(54906003)(486006)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3629;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H55lBQlT+Y8Rbvr/1jjD+n6YD7VyZoGouy781NJQCKJgB9mIIK1UYKWuGu53m/lZnyYQYPlQTC0F0Qfs/34QJErHpfohnnKqmaTTDUOVtwyW3U4qavsy/Ic9JE02H1+S11nV2MICnF4r8Fs2tM+OTMa9jbZGfMqQv305K2reFFByFCn9hl4usejlaxBwjeT5cc+EOtjR3LHoUlzg8aftif7wY4fIecIZncxhxW7vnUUjok9nZhj4bV0NQ33aQbiR3CNu6+d+SFCnixW+CeJhBszE2rr7+XdP+fQWztphvAh5bReCyQvM1qg2nFdX1CXfvky1exOAY/G+kgoLX/LHrfNCD3OuUf9YaapRXkw7MBanGRzpl3jroK+iIEqRtE+2xK1CSvB/at9ua4wZHNYWe99SAnnb8JAY0pwh4Q9CjQ/1JpXrZUzu1JI3Q6NaxEn9
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE23FBE63892C643A8D361B15A2484E5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: be2d39c1-0174-4c6b-6d48-08d75f815bc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 10:42:29.3685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nF4MbRQv2icQWOurENBkySeP/L2YtUI4jBAqzQuPd9lZ7onM0aJ9xTDnRWmAmNQ0NkHxikyIixIbwLqdZuHgCzzlLrlhc5cWX1kxy9GOp+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzI5LzIwMTkgMDE6MTcgUE0sIFR1ZG9yIEFtYmFydXMgLSBNMTgwNjQgd3JvdGU6
DQo+IEZyb206IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4g
DQo+IExldCB0aGUgY2FsbGVycyBwYXNzIHRoZSBwb2ludGVyIHRvIHRoZSBETUEtYWJsZSBidWZm
ZXIgd2hlcmUNCj4gdGhlIHZhbHVlIG9mIHRoZSBTdGF0dXMgUmVnaXN0ZXIgd2lsbCBiZSB3cml0
dGVuLiBUaGlzIHdheSB3ZQ0KPiBhdm9pZCB0aGUgY2FzdHMgYmV0d2VlbiBpbnQgYW5kIHU4LCB3
aGljaCBjYW4gYmUgY29uZnVzaW5nLg0KPiANCj4gQ2FsbGVycyBzdG9wIGNvbXBhcmUgdGhlIHJl
dHVybiB2YWx1ZSBvZiBzcGlfbm9yX3JlYWRfc3IoKSB3aXRoIG5lZ2F0aXZlLA0KPiBzcGlfbm9y
X3JlYWRfc3IoKSByZXR1cm5zIDAgb24gc3VjY2VzcyBhbmQgLWVycm5vIG90aGVyd2lzZS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlw
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDExNyArKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA2NCBpbnNlcnRpb25zKCspLCA1MyBkZWxldGlvbnMoLSkNCg0KUmVwbGFjZWQgJm5vci0+Ym91
bmNlYnVmWzBdIHdpdGggbm9yLT5ib3VuY2VidWYgYW5kICZzcl9jclswXSB3aXRoIHNyX2NyIGFu
ZA0KYXBwbGllZCB0byBzcGktbm9yL25leHQuIFRoYW5rcy4NCg==
