Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0795C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E832086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="lp/MAVDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfHSGDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 02:03:42 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:24613 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHSGDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 02:03:41 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: mDEN09ridQc9oMEEBdpebg0P9LsQ0Oi6VNtIGccRCKAXiLgHhDu5ZhQSmvbSf/RLWCSNpwYACR
 wkPU09yBk2+65mtU9HwxBSl0gXQPcFbsNz4ZASpIfZGu7xrPOpVwg1jix3+EYhuKQRRuJd9o7T
 RqhUI6JeLNuhQ6PMgDrFAehEHei0nMMg1cDM0GJ5SKdB9Mm6aBsEgDSAfC81MlVxmnp9p42C68
 8wj6CCUAmbLj+HDb1n2CFKp1dcU6AvBHTZUAiEz0SpZYaNvUQI5gb6ajpovIKBiJgiqkRhS7uq
 7nk=
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="42726605"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Aug 2019 23:03:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 18 Aug 2019 23:03:30 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sun, 18 Aug 2019 23:03:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJ3ikrZhra7Oh9eJ0frKrIi7PaXlf9in1XBpEMqhI2tzQDpWqxm3QS2HjZIP+dIhonXfkI6vE6buN0j1d6z1zHvsRYSSxPHk0z3h9lTWWKex3pKmZ3rxvCCniysZWf/29uOWsCCFvutK/BhjQGsYv6cURONhlou6kt3MsK2+Rc/JmLwqv68cZjGs2Sxyv+Hq3igY6bCU24KDFb4zH2AcBqwFPM6zeo6l+lp0v+isyS8zy/R8Dl46y0vnssHGQ0DxFv8SfJmyGLtOi6B+ScR/Tux0ahPxVQ60GnepN/EqdtJYzUIBXnv5hHiBveJxkoemERPN11wAe2qE5/+P6KC8+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTl3yRqqsKP9WZERr8g5GYxuvfPjSbb+oUVuAxnPGLk=;
 b=ZsbhQCwFXV3IQN5YJ99j7ilsr9E6x5/idCwpOcW+XW6okHK3GMlQTfdWFr2cVCdhQISXvVuOv8gS8Z3ClxEvw7kc4UXTYFj5h4qzhtIoxJcQQfqjOOXC8PMBM9Ca9yFt2eMYXhqqsJsTrlmi0VJXRV+/5twsAm/aRZnZ2ryDv51z+kLLckOAy6uq7oiEn4y9KUWxh6WisIAvG4icY6tvg0My8jcCplFqS2hdzUQbm9G8Ec8aSiBtCVDWTf9ycMQBYprL1q4Jzc+hGRFCOwu0b3zpelvQk4y94ZD4qusnqQxQ2XdcR85FWWuJOwB72pYPy0ATDklc/RoXtNO3JE5BDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTl3yRqqsKP9WZERr8g5GYxuvfPjSbb+oUVuAxnPGLk=;
 b=lp/MAVDUgPNF3PdOcUcsi1BmJTH6lj9n/W0JGroSJJtu1HTw2zhYOjL9ef+jNspSYsSN3mxmEsGIfDpbWB0VVjw2eZRBxLakPvJ24rv304Y3aQIOHlIYyAFCbqnY6UDbjm1PgMqITQ6WBW7kV5XDlgX6Z+oQgjN74jLOKwtSqRE=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3709.namprd11.prod.outlook.com (20.178.252.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 06:03:26 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 06:03:26 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <wenwen@cs.uga.edu>
CC:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: fix a memory leak bug
Thread-Topic: [PATCH] mtd: spi-nor: fix a memory leak bug
Thread-Index: AQHVVev6fATxhl9u4US1h72AjbWeGacB+8IA
Date:   Mon, 19 Aug 2019 06:03:26 +0000
Message-ID: <e52a548a-0516-55ee-4005-5cc24c3a20b5@microchip.com>
References: <1566149993-2748-1-git-send-email-wenwen@cs.uga.edu>
In-Reply-To: <1566149993-2748-1-git-send-email-wenwen@cs.uga.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0902CA0034.eurprd09.prod.outlook.com
 (2603:10a6:802:1::23) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6282b93-2635-4e4e-d025-08d7246af320
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3709;
x-ms-traffictypediagnostic: MN2PR11MB3709:
x-microsoft-antispam-prvs: <MN2PR11MB37099C8399E88F65C6BDFD1AF0A80@MN2PR11MB3709.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(376002)(396003)(189003)(199004)(186003)(4744005)(31686004)(478600001)(25786009)(81166006)(6246003)(14444005)(76176011)(6916009)(14454004)(31696002)(81156014)(4326008)(8936002)(229853002)(7736002)(52116002)(99286004)(6116002)(3846002)(305945005)(316002)(2906002)(54906003)(71200400001)(71190400001)(26005)(66946007)(66476007)(66556008)(64756008)(66446008)(86362001)(486006)(66066001)(6436002)(5660300002)(2616005)(446003)(11346002)(476003)(53936002)(6512007)(2171002)(6486002)(8676002)(36756003)(53546011)(102836004)(6506007)(256004)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3709;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9kY7q9NyQhU0ZXD0Ap51mPQiJTBGSnFPGKC8akfkgg1VnKvGFhyA4BzkakpuZqrKqb73hb8Mw0oJQB8arvyhxni1SOE1Ehj2nLaNrKvdjVPqpfJprPdvr6D65wgIb+2cjiw8pp5P5c5MErcB+kYyRELb/EkQ56I9isUj5qZ20BhUqTslKQrGuuptj+01vs1etMO3UqCRzkNWbPc/2KyOxGRXFtN7BxA6kEgsO0qSIZA3K5oPOlA0O3yjr0RMKN3ii/Ku7RgceiFBM2oqxmXeibFMbJtIu23OCrZ+sePOEQR6gP0/4WJQM0Cp5njK2WsdeVaWZ8uqcXk9msow8nRJSwbEiXSEHClSytPlFXnu/wzLjb0hYy2lvtxoFJ+9wPrI+6oxESccdEUw4oFpQDpz6zicuuWvvGtXfLV6Tua3Kc8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AAB7BCEA377584D96671AB8EC6B2B43@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e6282b93-2635-4e4e-d025-08d7246af320
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 06:03:26.2510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ahgs/gGSgQ0tZM/H8KC6hONzXhvbHrnIyufbCHKqML6gXO1sD/0DTfKK0s3EUvrzg5EEceB71V4UampYLGDabolkVJX6LHCXmrL2R1wB/4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3709
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzE4LzIwMTkgMDg6MzkgUE0sIFdlbndlbiBXYW5nIHdyb3RlOg0KPiBJbiBzcGlf
bm9yX3BhcnNlXzRiYWl0KCksICdkd29yZHMnIGlzIGFsbG9jYXRlZCB0aHJvdWdoIGttYWxsb2Mo
KS4gSG93ZXZlciwNCj4gaXQgaXMgbm90IGRlYWxsb2NhdGVkIGluIHRoZSBmb2xsb3dpbmcgZXhl
Y3V0aW9uIGlmIHNwaV9ub3JfcmVhZF9zZmRwKCkNCj4gZmFpbHMsIGxlYWRpbmcgdG8gYSBtZW1v
cnkgbGVhay4gVG8gZml4IHRoaXMgaXNzdWUsIGZyZWUgJ2R3b3JkcycgYmVmb3JlDQo+IHJldHVy
bmluZyB0aGUgZXJyb3IuDQoNCkxvb2tzIGdvb2QuIFdvdWxkIHlvdSBhZGQgYSBGaXhlcyB0YWc/
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBXZW53ZW4gV2FuZyA8d2Vud2VuQGNzLnVnYS5lZHU+DQo+
IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgfCAyICstDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3Bp
LW5vci5jDQo+IGluZGV4IDAzY2M3ODguLmE0MWE0NjYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
bXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5v
ci5jDQo+IEBAIC0zNDUzLDcgKzM0NTMsNyBAQCBzdGF0aWMgaW50IHNwaV9ub3JfcGFyc2VfNGJh
aXQoc3RydWN0IHNwaV9ub3IgKm5vciwNCj4gIAlhZGRyID0gU0ZEUF9QQVJBTV9IRUFERVJfUFRQ
KHBhcmFtX2hlYWRlcik7DQo+ICAJcmV0ID0gc3BpX25vcl9yZWFkX3NmZHAobm9yLCBhZGRyLCBs
ZW4sIGR3b3Jkcyk7DQo+ICAJaWYgKHJldCkNCj4gLQkJcmV0dXJuIHJldDsNCj4gKwkJZ290byBv
dXQ7DQo+ICANCj4gIAkvKiBGaXggZW5kaWFubmVzcyBvZiB0aGUgNEJBSVQgRFdPUkRzLiAqLw0K
PiAgCWZvciAoaSA9IDA7IGkgPCBTRkRQXzRCQUlUX0RXT1JEX01BWDsgaSsrKQ0KPiANCg==
