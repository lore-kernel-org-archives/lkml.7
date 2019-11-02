Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17DCCA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60FFE2053B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="RCwqQYKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfKBKqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 06:46:44 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:27850 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfKBKqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 06:46:43 -0400
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
IronPort-SDR: 2xM7p/FkHlgkbC+sagWyB9avhMAKAnJCJ1t0YokE36RuG16cVC7TzzQaJyqgo6dzTE5U6YWhI1
 j4qo3CmHyeM+T2Kki2/Q4fgdIsX0ZQC/7FbxLBIwEAMsoJwIWCPa6dwScSMnbCjobh7G5XNHxC
 egw+XgHdmEphCqn3rxYWbGELHOvIatz/Z0xBw12jf2ZhohuHFuCM6PuXjS2QbOLIvqQnhrXl1Z
 14B75tja3Yek/77LLoU4+0WzzqrZC6Y9jtli2qqKM68dXwk+BmUb6n3RLvrV7LYxSaqelbOuMp
 Clw=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="53868282"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 03:46:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 03:46:43 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 2 Nov 2019 03:46:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRRuUbgRjhHeU500+iI96GE+OiDnmiYeEeXYocsT54/D3nbmnhbzj/83cjqiDVyyR6n1oWZbKfPu5rOaN2PrRED5pDE+Ss8r2MB0uhTqonC6F1hgZyD83SLa006eEOT+i+mxUB3Y9/rHhpULa6zJjBERqBbjK7U3faixiBB3SGRUKCyUSEA3WdcC2Oc5qCtMFqhYYKK5aBUx/9d6eXGkIcZx3+2P5ssCChNBi6ZnG5l6H+aPbGSiQP3eJ9UcWkE/2ptDycRyBIuGOZ3jjFk9bZuyqoE7K0k/nGv6vfR5MdJhI8dXqNuNNXlRyd3oEcY/tpmkO++EB84pEvn+hIt2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f10L2dtv2k9f/b7xK8ZXkzGSRJq+OEVwm7Ae7ZwysSM=;
 b=naiSOtnp/LJ4OOktiOzsle5mCC3zdCKIJIAIBZOguvHyjipx3JxV2GHnfhwbatfJxG5igeT6mRsqkL5661AOga6B+8/8Vfw5bTY5+yCEeQgnXQqMwTM3VPY28Yemom/RUcwR/KrpA2cPsBHH4mo7y3xxEE6tjcCflK2DBNzByK90GUgZBdEXrco2qpBezpAzpLcrj/+BRGNpWwgpLZQikbxdnUuPxwmLuzG8YnHtx+ht7qTfb0QU8OgJmR/JtXTgdfaQiEw9UQUUvHvieipBiDdcPt2pMc7ra/W1i8JtLtChNuBRXEQjkXnErVwL+HZkLYFK9kmWqhu9kwtRh6WDgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f10L2dtv2k9f/b7xK8ZXkzGSRJq+OEVwm7Ae7ZwysSM=;
 b=RCwqQYKzKuyujM3t0hH0w4TeCobx+bJfL96vsgNSy25nP/+bUZAGqISw9iO9kf+nAty2VzJ3RfY4d+8BRqHFMSe9PTlBHNFtvaudFw6ggW/bXBv1lk+lxdOl+6okokrFhICqa380fsM/URBASS1TA1iVj5XVsHyiQMXdiXYQvBA=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3629.namprd11.prod.outlook.com (20.178.252.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Sat, 2 Nov 2019 10:46:40 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 10:46:40 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 11/32] mtd: spi-nor: Drop redundant error reports in
 Reg Ops callers
Thread-Topic: [PATCH v3 11/32] mtd: spi-nor: Drop redundant error reports in
 Reg Ops callers
Thread-Index: AQHVjkplMcJSJ7ucD0m8Dk/rmpqoY6d3uPmA
Date:   Sat, 2 Nov 2019 10:46:40 +0000
Message-ID: <1cfe6a86-65b1-4a0c-ac5d-4c449822c0af@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
 <20191029111615.3706-12-tudor.ambarus@microchip.com>
In-Reply-To: <20191029111615.3706-12-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P193CA0010.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:bd::20) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ede7f69-1ff5-4519-5461-08d75f81f120
x-ms-traffictypediagnostic: MN2PR11MB3629:
x-microsoft-antispam-prvs: <MN2PR11MB36292F1C5EAC0742A7419E7CF07D0@MN2PR11MB3629.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(39850400004)(136003)(189003)(199004)(66946007)(66556008)(316002)(66446008)(52116002)(2201001)(86362001)(76176011)(6512007)(53546011)(386003)(14444005)(14454004)(305945005)(6116002)(229853002)(31696002)(6486002)(446003)(71190400001)(25786009)(36756003)(4326008)(66066001)(6246003)(6506007)(102836004)(2616005)(99286004)(8936002)(478600001)(71200400001)(11346002)(8676002)(81166006)(66476007)(81156014)(2501003)(256004)(3846002)(5660300002)(64756008)(7736002)(31686004)(6436002)(186003)(4744005)(2906002)(26005)(110136005)(54906003)(486006)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3629;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: suPPKRW3reGG4RBqNFoErLgPyxCE6Q1rzWuKdpUgP5dbbIzRax4fSr8mut6SHGNT8nqSTVnfYNG1XG4if456yU6fXonMivfVI3GeW2VL8Gy2FrrslRbB5RoXtNyUa0KZwLJyq5FsPRSpYXEF7q7b4E40kTAVa/6XG3Rf3FfXT9NxxWRjjtqNJ74EDq1sIO+ilQYV+Fcww4aOk8XKS8O5TI2xMzwyKeRjQ/Yh33pGCA9FIReuHpT5j/2dM3TOsdE6/sw0qU2xoXZPzHALJW2dRfAX9Cb0gZ6lerjDOylNOLY+dyQT79vGOvrxhYVlD1tG+OU9dAqg7lv5MV8fPsjYbF4pjjuDvnRdfW1m28tG9lIIpmpENMOSgBrtXYAIZK9Ngtn41YMmwUdjVLWICr3U5iTDO0uWhO8RT82L6bI8vFVRkSBYeAydzfQU0qoXNM/L
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4A7B7A79E8D3D46AF748DC26DC72E43@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ede7f69-1ff5-4519-5461-08d75f81f120
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 10:46:40.1699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MbgT82BjD+X3Dj0LhNn81n+mi17LxqoJ8bxMPPd7l45N2Ob0dl0EinoR2dPBSThaQXPjDSp7ghDMxqhGtU+JdnyI/hYsxYYc1tyNSYkkBqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzI5LzIwMTkgMDE6MTcgUE0sIFR1ZG9yIEFtYmFydXMgLSBNMTgwNjQgd3JvdGU6
DQo+IEZyb206IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4g
DQo+IERyb3AgdGhlIGVycm9yIG1lc3NhZ2VzIGZyb20gdGhlIGNhbGxlcnMsIHNpbmNlIHRoZSBj
YWxsZWVzDQo+IGFscmVhZHkgcHJpbnQgYW4gZXJyb3IgbWVzc2FnZSBpbiBjYXNlIG9mIGZhaWx1
cmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1p
Y3JvY2hpcC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgfCA1
MCArKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNDAgZGVsZXRpb25zKC0pDQoNCkFwcGxpZWQgdG8g
c3BpLW5vci9uZXh0LiBUaGFua3MuDQo=
