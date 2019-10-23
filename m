Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDAFCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F722086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="lONGcFmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407497AbfJWVWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:22:31 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:8799 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406298AbfJWVWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:22:31 -0400
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
IronPort-SDR: yr4S4Kubyeukn7b3T6IkiBgBXYPqfP3ScIYbzI5hR2hTpyZqP66d9O04Ttu4iu6zMXc+uPos/H
 thbSIUihOmWxMOVv7pDPCATXy3teHxM9Yfa6Wm+jYBvYz7xS5e8SlX779ChN1VlUTMpbY0Sn7E
 b0YOIcEOOk7fAx8Kwqg/9PqzCUBcqdc+L5bkW8Qp8ErXnrwAzVY0kKGzJGkhWOKuutlDJCkXZd
 dccdW04bE+WTKMii0X5KEvUITqsIzn7BOut/1kiKYM/v4j+I21t2XeiH8hDqG2mzbCk9VQOFBQ
 YD8=
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="54151653"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Oct 2019 14:22:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Oct 2019 14:22:13 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 23 Oct 2019 14:22:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDejneL9Cy8dlrxFqNktoDjWCWk+gBX1fodRzB+CaaoFl3GiN68IBuCQcUncVjymOa/RT3h+daqVtxVIxBVQq4kneGT9dJJExDoDZAl8nQlYqM8Q5sGXVkOL1dj66WYrVxeK67vDRP3IttKmq679NFDfWZkFeqpz2tpRFBQmPXVQ1ipxzrBAI8Bk5btpDvZGxPFMSCbOEY1C8+rVpOlzYHJdIoPOMaJUd6ZNkLCVFy3vkFMx8j1VwzIPa3OVhFBD/2sxpEdAiAAQvjXuwMqUvbpvTZdBRZ0Q/B/yfnbCP7odt7OYGkIjjFCrGX9dcVkJcIW5+yD1Hyxd7U21Fh/Q2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmdVg9/mnWoa/rZ6wnposISNDudE4YQhcUhZ7gfCJoA=;
 b=PsV5RBv9AXk1DlYBi3ZgVcxl1s3XphU9l5jVwZxvYuNg3FtI/XSoCsfQ5nhzNW3s1sZLewlShXgMiI40EZUp3bz7CF/QjsheZrTjonnzUfK0cPjIwlPsr7A7fzXC1C36WbUi3Uc3+W9JW5E2i9Sq7KB3QIupSkYtQIviaG8uaZF/0daVXusaKe41ciuoyOlGw80eGFlMm0UtCxHY+f0iG/G1v24YVVrZv0/cMzqdQwDG5RzdfmYD9vSrX7NPXZqzZywN+lzZlXFTKFJ/L44k1inwIcxPQDRvHH+a4W0zM444bEgReSEMFx8Vhs5Sr2+cpvTdCTAikgzJCjethOo0Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmdVg9/mnWoa/rZ6wnposISNDudE4YQhcUhZ7gfCJoA=;
 b=lONGcFmNs27jD79TS4xjzF1pne1UP3hfxm063mDdS1YBYiCxI1nMdCl4RFYmPMJ27GbT4jJR3LkFx2JKP56jQwzBkqmRihkcPASSa6o5io4DqQncVMSilvKBlcrFw0Svye5XLDbRNUvLmgn2bKsQKIZvGR54b0axMB13+HA+O1M=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4416.namprd11.prod.outlook.com (52.135.36.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Wed, 23 Oct 2019 21:22:11 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2347.029; Wed, 23 Oct 2019
 21:22:11 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <jethro@fortanix.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <allison@lohutok.net>, <tglx@linutronix.de>, <info@metux.net>,
        <mika.westerberg@linux.intel.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] mtd: spi-nor: intel-spi: add support for Intel
 Cannon Lake SPI flash
Thread-Topic: [PATCH v2 2/2] mtd: spi-nor: intel-spi: add support for Intel
 Cannon Lake SPI flash
Thread-Index: AQHVYr46w+9V00BKOEGkHvwLMfTVVadpClUA
Date:   Wed, 23 Oct 2019 21:22:11 +0000
Message-ID: <6d11cb32-65e8-30c6-48a0-fffeac94090c@microchip.com>
References: <d62dec18-fed4-7ac5-35c8-25f1be2201a9@fortanix.com>
In-Reply-To: <d62dec18-fed4-7ac5-35c8-25f1be2201a9@fortanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0087.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::16) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db37abfa-cb46-4740-d3ff-08d757ff110f
x-ms-traffictypediagnostic: MN2PR11MB4416:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR11MB4416733CAE87743B1F0976FCF06B0@MN2PR11MB4416.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(366004)(199004)(189003)(8936002)(8676002)(110136005)(71200400001)(966005)(478600001)(31686004)(66556008)(81156014)(2501003)(64756008)(66476007)(66446008)(66946007)(31696002)(2201001)(66066001)(81166006)(71190400001)(14454004)(86362001)(7736002)(6306002)(476003)(6512007)(7416002)(3846002)(5660300002)(52116002)(386003)(256004)(2906002)(99286004)(316002)(25786009)(11346002)(2616005)(486006)(1250700005)(446003)(6486002)(6436002)(4744005)(229853002)(76176011)(6246003)(26005)(14444005)(186003)(305945005)(6116002)(53546011)(6506007)(36756003)(102836004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4416;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2SCB8Obr0S4zNU4bA7TD4c7XsI/N5m5YOi1jVZEGf67uT8PI4hmrnelHTFfZJdBxYi6G/g8VzyiVgv6PBCk8NOV5nBmDPgfGunqsc331Kjz5/TlKEXmrfA0stn9DOPZZ/w2JmUT4Tf5NGOH6sMSK8s+Ns1JovDJm4icy2IyzGMhawzbz2NqvzoxbKLHfkRLKKf4SPdVsI6VOLFPiKtbDqAVNGJSfFYTBGT3nYLKLz7tq/zbGygi1laTqxjAbmx9kzgJo1terONKIYhZMoEOhte7uwuMGu59MXgK+tg8xWwxcoO7DPq1G7uubWT3SGAi/80JzCcFLw5opQssYjZcbSsvwjTJDCxw9/uD5FC/rjAj9gnWbS765w5nVPXLJW1RfkWzZzvStg0xaq3opLPzKDNDi/9VRcGo86w8bvNN7zdAD41JE+Ec2DmMmyfBUE5TESX/Q3XnNDbVoVkD3bU+nWd7FLh2LYCExrOGY6pCX0VA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <54E1ED6979BAAE4193F54CDA9E6D53A6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: db37abfa-cb46-4740-d3ff-08d757ff110f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 21:22:11.2600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KBBlPgshv+IBL8txlQnuz23zOMTsfQ8CMRdTsYD5oSOOJW7c3OG370ONlZePip5j67wADXROlDy3dJ+zGLdongRkNb4HM8G/ppQTjGKaEn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4416
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA5LzA0LzIwMTkgMDQ6MTUgQU0sIEpldGhybyBCZWVrbWFuIHdyb3RlOg0KPiBFeHRl
cm5hbCBFLU1haWwNCj4gDQo+IA0KPiBOb3cgdGhhdCBTUEkgZmxhc2ggY29udHJvbGxlcnMgd2l0
aG91dCBhIHNvZnR3YXJlIHNlcXVlbmNlciBhcmUNCj4gc3VwcG9ydGVkLCBpdCdzIHRyaXZpYWwg
dG8gYWRkIHN1cHBvcnQgZm9yIENOTCBhbmQgaXRzIFBDSSBJRC4NCj4gDQo+IFZhbHVlcyBmcm9t
IGh0dHBzOi8vd3d3LmludGVsLmNvbS9jb250ZW50L2RhbS93d3cvcHVibGljL3VzL2VuL2RvY3Vt
ZW50cy9kYXRhc2hlZXRzLzMwMC1zZXJpZXMtY2hpcHNldC1wY2gtZGF0YXNoZWV0LXZvbC0yLnBk
Zg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmV0aHJvIEJlZWttYW4gPGpldGhyb0Bmb3J0YW5peC5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9pbnRlbC1zcGktcGNpLmMgICAgIHwg
IDUgKysrKysNCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvaW50ZWwtc3BpLmMgICAgICAgICB8IDEx
ICsrKysrKysrKysrDQo+ICBpbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvaW50ZWwtc3BpLmgg
fCAgMSArDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykNCj4gDQoNCkFwcGxp
ZWQgdG8gc3BpLW5vci9uZXh0LiBUaGFua3MuDQo=
