Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31FBC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FB820B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="A2EddGJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfFGE5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 00:57:04 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:24346 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfFGE5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 00:57:04 -0400
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
X-IronPort-AV: E=Sophos;i="5.63,562,1557212400"; 
   d="scan'208";a="35981880"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jun 2019 21:57:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 6 Jun 2019 21:56:51 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 6 Jun 2019 21:56:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGFLO5SXSgT+0MtHrUXgfO62nTwkGHzvMjYzzdtgFdY=;
 b=A2EddGJEX19lhlac0BtNcLY+W4NodBKIxt3aXSz9mDPYfLuqiSY5JXIYTvqFtFE9w6bUi9KI0uL44FvDLaqbPMYlujq+pUaB/zLFBi080k3hpDOxPC01Ln9luFJ/b+Ve4Fcb+L9bk1zHbiaEiv4S/2fa4CHDzmeC1P3CwDy6gpQ=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1905.namprd11.prod.outlook.com (10.175.97.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Fri, 7 Jun 2019 04:56:49 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e581:f807:acdc:cb36]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e581:f807:acdc:cb36%9]) with mapi id 15.20.1943.018; Fri, 7 Jun 2019
 04:56:48 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <f.suligoi@asem.it>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <bbrezillon@kernel.org>, <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: change "error reading JEDEC id" from dbg to
 err
Thread-Topic: [PATCH] mtd: spi-nor: change "error reading JEDEC id" from dbg
 to err
Thread-Index: AQHVEj+6kixcbpPmk0yDW0lHff3j+KaPtkkA
Date:   Fri, 7 Jun 2019 04:56:48 +0000
Message-ID: <22344be3-bed0-8788-9fc4-22db3580e0c6@microchip.com>
References: <1558709145-12088-1-git-send-email-f.suligoi@asem.it>
In-Reply-To: <1558709145-12088-1-git-send-email-f.suligoi@asem.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0077.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::18) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.241.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a95ce119-0678-4dbf-bebb-08d6eb048c36
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1905;
x-ms-traffictypediagnostic: BN6PR11MB1905:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN6PR11MB19058A6D622A643D9F2E1E2FF0100@BN6PR11MB1905.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(396003)(136003)(199004)(189003)(66946007)(71190400001)(66556008)(8676002)(6116002)(486006)(316002)(53546011)(446003)(6246003)(102836004)(99286004)(6436002)(52116002)(36756003)(6512007)(2906002)(54906003)(110136005)(3846002)(6306002)(6486002)(476003)(5660300002)(2616005)(11346002)(186003)(4326008)(81166006)(386003)(71200400001)(305945005)(73956011)(6506007)(4744005)(86362001)(66476007)(76176011)(229853002)(7736002)(31696002)(68736007)(53936002)(31686004)(8936002)(81156014)(66066001)(478600001)(256004)(64756008)(25786009)(14444005)(966005)(66446008)(72206003)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1905;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cqqxXhWshHxl8S5e5cK+PjYvEyZgAXmyWbLpMIIYKNazeaplpInKhI1dzH1TU+mE65tZfqDR6a3yfu4QKc39juRn5CJVa+NQKoljmcQdwC5WKj54d9UFM2B2zo/Owknb0AaefyQ1d4AYCpbQHWqyt12D8urQ3iCBiaFqI51YxFyDm8gbbcbNo8btGumRXpRo7ucPa6M7AaiibkTgaCx7/hHYwLUrO2hrrMH42JTbrlO7V1xzj4I5tmX5sN+Q6Q0ydimZHCXXfNoEqcYPiBiV11MOoyxyvLbkKo3cmSVc0oeYeKiJXDwpp6rw0xLBvHBlXdze+P+dMXApi1CPdKLWO43ndGXYS5Wc7zomsYjffFOS9zc1NTJxQi5hN2vUxELa5r/0woT3LYDEJeJf3umyvPq6Sl7NK6BD/oMkAEFKPRk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDB2E6DEFF1E084E96E95040583E1F41@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a95ce119-0678-4dbf-bebb-08d6eb048c36
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 04:56:48.8011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1905
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA1LzI0LzIwMTkgMDU6NDUgUE0sIEZsYXZpbyBTdWxpZ29pIHdyb3RlOg0KPiBFeHRl
cm5hbCBFLU1haWwNCj4gDQo+IA0KPiBJbiBjYXNlIG9mIFNQSSBlcnJvciBkdXJpbmcgdGhlIHJl
YWRpbmcgb2YgdGhlIG5vciBJZCwNCj4gdGhlIHByb2JlIGZhaWxzIHdpdGhvdXQgYW55IGVycm9y
IG1lc3NhZ2UgcmVsYXRlZCB0bw0KPiB0aGUgSkVERUMgSWQgcmVhZGluZyBwcm9jZWR1cmUuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBGbGF2aW8gU3VsaWdvaSA8Zi5zdWxpZ29pQGFzZW0uaXQ+DQo+
IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgfCAyICstDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQoNCkFwcGxpZWQgdG8g
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbXRkL2xpbnV4
LmdpdCwNCnNwaS1ub3IvbmV4dCBicmFuY2guDQoNClRoYW5rcywNCnRhDQo=
