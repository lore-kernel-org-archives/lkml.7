Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328C9C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED78E214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="WWqaBdE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfHTOyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:54:38 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:50532 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfHTOyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:54:38 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Eet0xybUhXNh5Gn0mcUuMkj74ktNUhIRlgiQDLiQm08jZ4IVgZd8NysmcwvzTZRq3GP+fqA/33
 2Lp4YD901zhpVlAkPM8NmzI0ra/98OhGqF5dvprVIDScGWvlpTLRo5ws0Rvczn0Jsvjxgktlvc
 amcLL459UjtJWrBpr9yiuah23CHbox5iTSMXjzoTyxC5G0Z56NXi1EU/WpUjccFF6sJ6WOimTM
 WZlPvZW0tZDeVuJ5qxa5VMvCniIgTTAf8rDfRTLvQ7YywKq+68oDyO8tTjKb36pPNQdm5RaVJQ
 +UQ=
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="44944829"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2019 07:54:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 20 Aug 2019 07:54:36 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 20 Aug 2019 07:54:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJO7RefyGCXuDdND90UmzXBzVi/Accfgue0QXmk6ZWAYwwcac9nfGbuEuNbfur6TZXbCV7Ney0N9frSoYf56+baZmIQix9sDK6eEKxXv9EfVEptVMnJEtS+Gt6bXbFFwqRoq4XYIjIxhaXKbCsboPLttlZ6HZiT3NHa30E9oJDw7UQVYheKey+CqtPhA0zAoz9fRSm7O5w1oJNDnIfzlxEp7NZ9pQXqsPsGcm4ib3DwO7VugFI2T8xHiH4HesYZLcfTv5ijf9cRPXkAWjerhKBW7s2iKCr5Q18OI6cn9S6sVRuhVuE629LIhRRfA6D0T9WyOvqwA6xg0ozM6sXCX7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kVKS2nT0qa4S2HUsTm0bhm6EJoZpqdOg0wz/j5p/4o=;
 b=R9HJGAGoLHtEWbTA0/s2rYmA3CoszIzjT1cuvhEft658mTHeaEUrwoTRjFb9zTRPNjE2mtTR4H2PIZhp/T7iiQDXoz+7WYRYbC3abzSDWNR1XmtjVRiYRb60nsdgLuuEFFCjPuMrWU03YKGI9dM5JoR4EquN+HmCDQpkgMZm2cJg5Grdgv7s3LOsksTovzl8TUoA/wNkzwucz/JH/XVpzjq/pJHlJoxPvU0C4KTa0cJriBMZsRNjVBvNfme9i7ksFnoJ7moWUrZP7jv9A7KXc0phCqxrkGW59FKSb/zGZRuEcq5cetPJIWyA9eT07pUlXDMSGcDCX15OMNv7rowP6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kVKS2nT0qa4S2HUsTm0bhm6EJoZpqdOg0wz/j5p/4o=;
 b=WWqaBdE9uAx9LR7RN6YiYHkV7fnMUBf7pGq6xTqnc8WZ/880kIZFzmZot61Sp0ZJwoiQpqnaUUTsNIsEJU/XxFaxpP2i1cnwzIF+kgHIIfNiQm7MmXX0vK1IFC3xrwze5KbhctXzepXZflXKLhvcyWIYG883i7HNFE5obT/86MM=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4350.namprd11.prod.outlook.com (52.135.39.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 20 Aug 2019 14:54:34 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 14:54:34 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <wenwen@cs.uga.edu>
CC:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: spi-nor: fix a memory leak bug
Thread-Topic: [PATCH v2] mtd: spi-nor: fix a memory leak bug
Thread-Index: AQHVVrHa0wRKD5wwWEKewRQkNp25zacEIO+A
Date:   Tue, 20 Aug 2019 14:54:34 +0000
Message-ID: <a2eced51-aa2a-0609-530a-16e03e78ae19@microchip.com>
References: <1566234960-3226-1-git-send-email-wenwen@cs.uga.edu>
In-Reply-To: <1566234960-3226-1-git-send-email-wenwen@cs.uga.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0066.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::19) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4298d09c-b6ac-436c-161c-08d7257e507c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4350;
x-ms-traffictypediagnostic: MN2PR11MB4350:
x-microsoft-antispam-prvs: <MN2PR11MB4350061E04DAE0524ADA3221F0AB0@MN2PR11MB4350.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(14454004)(229853002)(7736002)(305945005)(6116002)(6486002)(6916009)(36756003)(86362001)(2171002)(31696002)(6246003)(6512007)(2616005)(11346002)(486006)(5660300002)(102836004)(53546011)(6506007)(386003)(71200400001)(71190400001)(4744005)(6436002)(256004)(14444005)(476003)(26005)(81166006)(81156014)(8936002)(186003)(446003)(4326008)(478600001)(31686004)(54906003)(99286004)(52116002)(76176011)(2906002)(66066001)(8676002)(66946007)(66446008)(64756008)(66556008)(66476007)(316002)(25786009)(53936002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4350;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: edA20vOPIUDllgr4U7LKCsgFcqP4rWlGckIgq+aqW/DewqS3APAHwqN89Pgx1LHKpeAnfIyu92jLlhHRPkTmzjGVUPzav/MttOdFYNAXYn/d4zI1ZtEGPjnpLfDCMVWnhIlWUl+bWJGyo4JKRyrGhR/UqxznDKckUBesJZYGkdcXlpJm90Ri1mqAe3bZyALJ+bn3tR9ylaXd06g7tcrdS7U4FvJ134nuKm8TireYn+x9n2kOxV12ZAwOT9ds4zZ3uXwvdiBT7oYs3PtvrOztvfyji/TV6pCsFZhW3meVtL9JB6JltrlsxghUKMMH1s+wTHw2SjyWvTpE79OQ78aZylGYqjafG+dzMC1ONHy7xOKr74Y+J+43ygBxVOJDcvVCGB0qEcXWlNdem/ChB1ydsr/zYtRYBAl/Q2EXkXhXi/c=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8C01FABEEFAB4498F14639787292A0B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4298d09c-b6ac-436c-161c-08d7257e507c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 14:54:34.4439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PDSxOotgeXeGFklk+2CyfBpEDbdLCtpeA44djNbIfbJUDvNx4AlS/H0UD5k8xECQg5OvPD4il4/Gotts76TwbDIe3lEmArewRYw5ceRxWho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4350
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzE5LzIwMTkgMDg6MTYgUE0sIFdlbndlbiBXYW5nIHdyb3RlOg0KPiBFeHRlcm5h
bCBFLU1haWwNCj4gDQo+IA0KPiBJbiBzcGlfbm9yX3BhcnNlXzRiYWl0KCksICdkd29yZHMnIGlz
IGFsbG9jYXRlZCB0aHJvdWdoIGttYWxsb2MoKS4gSG93ZXZlciwNCj4gaXQgaXMgbm90IGRlYWxs
b2NhdGVkIGluIHRoZSBmb2xsb3dpbmcgZXhlY3V0aW9uIGlmIHNwaV9ub3JfcmVhZF9zZmRwKCkN
Cj4gZmFpbHMsIGxlYWRpbmcgdG8gYSBtZW1vcnkgbGVhay4gVG8gZml4IHRoaXMgaXNzdWUsIGZy
ZWUgJ2R3b3JkcycgYmVmb3JlDQo+IHJldHVybmluZyB0aGUgZXJyb3IuDQo+IA0KPiBGaXhlczog
ODE2ODczZWFlZWM2ICgibXRkOiBzcGktbm9yOiBwYXJzZSBTRkRQIDQtYnl0ZSBBZGRyZXNzIElu
c3RydWN0aW9uDQo+IFRhYmxlIikNCj4gDQoNCl4gTWlxdWVsLCBtYXliZSB5b3UgY2FuIGRyb3Ag
dGhpcyBuZXcgbGluZSB3aGVuIGFwcGx5aW5nLg0KDQo+IFNpZ25lZC1vZmYtYnk6IFdlbndlbiBX
YW5nIDx3ZW53ZW5AY3MudWdhLmVkdT4NCg0KVGhpcyBpcyBhIGdvb2QgY2FuZGlkYXRlIGZvciBt
dGQvZml4ZXMsIHNvOg0KDQpSZXZpZXdlZC1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1
c0BtaWNyb2NoaXAuY29tPg0K
