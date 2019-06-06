Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BBEC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 05:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1152A20673
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 05:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="GESAO4fu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfFFFpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 01:45:42 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:36414 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFFFpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 01:45:41 -0400
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
X-IronPort-AV: E=Sophos;i="5.63,558,1557212400"; 
   d="scan'208";a="37767415"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jun 2019 22:45:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex04.mchp-main.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Jun 2019 22:45:40 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 5 Jun 2019 22:45:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xf9y5dkSUEfmc3E2/91tJzjHbRTdSfh8ThS//SknM54=;
 b=GESAO4fuCcEhdIcuXp9BpfV/D6SlPUWLflUVzQLt7pUxa016KVZVzIFyBTR1s/KpxeU37h5Yhw8Uw8XtS1R5EevrNCsNNJWOll4QFcvvVbyohfGDmOhcpnPUQhjVYAM/ONVejgQmubgLDGQZ5NEYBgVQhyig5o8ARXTHenjvirw=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1332.namprd11.prod.outlook.com (10.173.32.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Thu, 6 Jun 2019 05:45:36 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e581:f807:acdc:cb36]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e581:f807:acdc:cb36%9]) with mapi id 15.20.1943.018; Thu, 6 Jun 2019
 05:45:35 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <han.xu@nxp.com>, <cyrille.pitchen@wedev4u.fr>,
        <marek.vasut@gmail.com>
CC:     <boris.brezillon@free-electrons.com>, <f.fainelli@gmail.com>,
        <kdasu.kdev@gmail.com>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-imx@nxp.com>, <computersforpeace@gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: Add prep/unprep for spi_nor_resume
Thread-Topic: [PATCH] mtd: spi-nor: Add prep/unprep for spi_nor_resume
Thread-Index: AQHU+uHfbtBiSaKzx0CN/OQDDONR1qaOYFKA
Date:   Thu, 6 Jun 2019 05:45:35 +0000
Message-ID: <ae82d8ea-dd85-0bc3-ff2d-0ba57f635030@microchip.com>
References: <20190424210818.25205-1-han.xu@nxp.com>
In-Reply-To: <20190424210818.25205-1-han.xu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0124.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::17) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c719bf65-65a0-4196-9cdb-08d6ea423263
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1332;
x-ms-traffictypediagnostic: BN6PR11MB1332:
x-microsoft-antispam-prvs: <BN6PR11MB133251318CDB0C8FE2D22E4FF0170@BN6PR11MB1332.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(376002)(346002)(189003)(199004)(25786009)(2906002)(66556008)(229853002)(66446008)(81156014)(7736002)(64756008)(66946007)(2501003)(66476007)(4744005)(68736007)(52116002)(186003)(54906003)(110136005)(6486002)(76176011)(99286004)(4326008)(102836004)(26005)(8676002)(53546011)(6506007)(386003)(6246003)(256004)(14444005)(53936002)(486006)(36756003)(446003)(73956011)(6116002)(72206003)(5660300002)(31686004)(14454004)(71190400001)(71200400001)(6512007)(8936002)(7416002)(305945005)(11346002)(86362001)(31696002)(66066001)(2616005)(3846002)(476003)(316002)(2201001)(81166006)(6436002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1332;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1qRKcybTsS2dPq8zBmb+Z1gwwRz3JCtm6mbIHoSr+czIcOO/ULf4qpTYZai/m6R5mtEAuGhqkVEzEZlovlNoGW/F+xkYiYMEN/Bj1MFrvppa8arHn3WGkP+W+ZJwUdentBc1E+V/ILLqCRiDOtbX1Uzfl2szyNL5yLIGJFhWwIucOrp0AVdV+uFIa/NBSLRfM/Aw33p/Uh8wlwu4OXFi0GMMttjEXeTYwbL0ZHgRBLOk8PpRw/mUqmvl6sM4+sy5kB6SLoNNdCay8vdYc+btuDE8nQxMjH9/Wnq45boI/CmxbFFskdhLAv3zLARqf2YoZ4m3hyPxwATVVTM6BPv5ykfvIBDoh0RCoeUTgR5QBZOXANyd06fC3D9NP3bT38lTC029r1a+3sD37AtjdeKjYqIrK3qUITRGt6FTDVgN6fc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E18BC54166FC4D47BE7036335E4D7EA6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c719bf65-65a0-4196-9cdb-08d6ea423263
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 05:45:35.8598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1332
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhhbiwNCg0KT24gMDQvMjUvMjAxOSAxMjowOCBBTSwgSGFuIFh1IHdyb3RlOg0KPiBFeHRl
cm5hbCBFLU1haWwNCj4gDQo+IA0KPiBJbiB0aGUgbmV3IGltcGxlbWVudGVkIHNwaV9ub3JfcmVz
dW1lIGZ1bmN0aW9uLCB0aGUgc3BpX25vcl9pbml0KCkNCj4gc2hvdWxkIGJlIGJyYWNlZCBieSBw
cmVwL3VucHJlcCBmdW5jdGlvbnMuXw0KPiANCg0KV291bGQgeW91IHBsZWFzZSBleHBsYWluIHdo
eSB0aGlzIGlzIG5lZWRlZD8gSGF2ZSB5b3UgdHJpZWQgYSBzdXNwZW5kL3Jlc3VtZQ0KY3ljbGUg
d2hpbGUgYSB3cml0ZSB3YXMgaW4gcHJvZ3Jlc3MgYW5kIGl0IGZhaWxlZD8NCg0KVGhhbmtzLA0K
dGENCg==
