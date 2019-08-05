Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C093CC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A21A20856
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Sfjx4mJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfHEKZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 06:25:44 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:48891 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfHEKZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:25:44 -0400
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
IronPort-SDR: DxKR9W15XD3mz7Raxy5ycVPUB+Qjk6Sw5owHijlt5WWt4jnIHYFZgSA4XjJPcEeNmnMu6dwbmi
 95DlJ8eqxnIEN4aNc1+MQ5foGb5Vc21ZBZ7OzyGGiaNSUykqPfk4jaBTQMcWspUz6AiJNEOkzd
 IMWHON7+k42PhFgjJCU+nCQHvlxANvBed5u4LXukqo/vzpI5uKGGeOkUS8YRrIS4P+Msk4JxTv
 lT5DHKwcYfAeM3L3PdlfDK5Gjsm7gxQIoZwC2DMtBrf1eZC9IF0QTO1jC90+GH3bHSm3Wr5Yco
 xnY=
X-IronPort-AV: E=Sophos;i="5.64,349,1559545200"; 
   d="scan'208";a="45345562"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2019 03:25:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 5 Aug 2019 03:25:43 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 5 Aug 2019 03:25:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xjh9qRH3IY10PhWTh/rWf4x8+PqZgIzAziSgHbGmrN8n27stUyDy9osZpcvGQxBvAiEG+rILaI+K3ww5aIBrCdUmvn5yzQ72z1nfVAi50KTUWl6hzG2Aq03VjiPRb/d5h0aGpoKeBGTHCeGSeoJI0Y9DTfvuyYZwwdfDctYuZSOhQpkjLKf/mVpUIOoenFZIQ8l3p69apTkIlJgN0Y3a1iv2mE873UrXm/m9QNwatI1uaOmvx+QZ0ekH+935j921opdzbV4y65k7BVi6ArWIMg6qJ84zgIOmg8gjBzY0CArteDkbnbZHyegEDjvq8ZkmZGgmYnnw98UQ3G+HUid+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+v+1mb8LNZU/oPMYE3RGfiExIiz1KJMGAfvLZW/fdLI=;
 b=nI5D14e8vzkHu1cslREYOerz4eCt8TDvfO1hkVH8ZCV8QfNIDj0W/XcXjAnm6l5YBMIQ/nL1f+nBbcRr0AgsTvx5rUpSq2r1sNYOkqKVgeRnTXGDYL0wkn9dFafBoEVKilbeMeSeCrdjbRg0+UomKfdBshzwU6cQ+J4N5RY17M7LJ2hTpNRsPYhlm2fo9TsU/iiOhlpa0KAKn6b7tuepMaqo35HY3fqiTNVmjofPwjCXTrBhIdlU+vXkY0balQDIiwAlADjk6YczsnHqOS6cayMePP9WRoL94zoLJJlwhkBHhiHYvGxoMmV1/98IsuUHIu2gfq7zwBf1ETffh2FuDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+v+1mb8LNZU/oPMYE3RGfiExIiz1KJMGAfvLZW/fdLI=;
 b=Sfjx4mJ8ejZ7MhMBwzsO0t1Q1k4MERaCYiKNqH6/gUf3iC8EtLYDkVLEyNA4tk4Bp1w4U7eJlz+/oe3dtay0KIczUmAeVe5QWYNU/5ZI4Q7BDyQEKjNlFWHU4OIP50uic5UMzajzh+vVs7O6l81Y7C1VdwVYU7orIaPKghaCE94=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4477.namprd11.prod.outlook.com (52.135.36.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Mon, 5 Aug 2019 10:25:41 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 10:25:41 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>
CC:     <marek.vasut@gmail.com>, <bbrezillon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <tmaimon77@gmail.com>
Subject: Re: [PATCH v4 2/3] mtd: spi-nor: Move m25p80 code in spi-nor.c
Thread-Topic: [PATCH v4 2/3] mtd: spi-nor: Move m25p80 code in spi-nor.c
Thread-Index: AQHVSIVNR1h9SqkuukqZlfb/4kclfKbsXzAA
Date:   Mon, 5 Aug 2019 10:25:41 +0000
Message-ID: <852ffdd1-a546-03db-3b60-47d60bd8d7cf@microchip.com>
References: <20190801162229.28897-1-vigneshr@ti.com>
 <20190801162229.28897-3-vigneshr@ti.com>
In-Reply-To: <20190801162229.28897-3-vigneshr@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0057.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::25) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4e4ed8b-9ded-403d-4d80-08d7198f4452
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB4477;
x-ms-traffictypediagnostic: MN2PR11MB4477:
x-microsoft-antispam-prvs: <MN2PR11MB4477052247EB576403FA09EEF0DA0@MN2PR11MB4477.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(366004)(376002)(199004)(189003)(66946007)(66556008)(66446008)(7736002)(6512007)(99286004)(8936002)(26005)(186003)(14454004)(446003)(4326008)(6246003)(31686004)(6486002)(8676002)(478600001)(476003)(2616005)(81156014)(11346002)(486006)(53936002)(305945005)(71200400001)(81166006)(25786009)(6116002)(3846002)(68736007)(31696002)(6506007)(386003)(53546011)(66066001)(6436002)(36756003)(2906002)(316002)(52116002)(54906003)(110136005)(71190400001)(76176011)(229853002)(64756008)(66476007)(86362001)(256004)(5660300002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4477;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dfnoTbD+7yjLlXiXd9H2dgxMb2NyebARTMPv6ZBx8Ra2CJ90AfTTMYDfPyJoa4ZP/bfY79JZF9uGw5ScvVG57T5ASSbjhioOmqPOu2kEQWut4dGzFtvO0iYWtz+H8Lu6i6tcPR66MvcCnQEg/L2N399zWtDU70mwPIGjR9M1/95uwy2kjc+Gevy0k4M0hoXKxE63OL42CKeyqbW1bgjm5oH4mH8qfPSppOfhd9UZiaIxxdQf1kpHG/8LNEPF+4Dlj1fx5zgQWV+cu0GXBp5c/rSTepKeUFFWitV2X5dRK7dHTUWMu6zgodvyKZ0SnaVy9FiPpoTQlHQdtM9X+rvf7Ch0g8kTDz2nYSSSOmJh0h7Pgdqu1G3BtprU5b/ggQVC2RFEg4B4Nf7WUk2y56Im8S/YiGA3wX4vIwF3cyQwcGg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A04998477AA694C9F22C195129CC8BE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e4ed8b-9ded-403d-4d80-08d7198f4452
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 10:25:41.5175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4477
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzAxLzIwMTkgMDc6MjIgUE0sIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQoN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jIGIvZHJpdmVycy9t
dGQvc3BpLW5vci9zcGktbm9yLmMNCj4gaW5kZXggZTAyMzc2ZTExMjdiLi44NjY5NjJjNzE1YjQg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+ICsrKyBiL2Ry
aXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+IEBAIC0xOSw2ICsxOSw3IEBADQoNCmN1dA0K
DQo+ICtzdGF0aWMgc3NpemVfdCBzcGlfbm9yX3NwaW1lbV9yZWFkX2RhdGEoc3RydWN0IHNwaV9u
b3IgKm5vciwgbG9mZl90IGZyb20sDQo+ICsJCQkJCXNpemVfdCBsZW4sIHU4ICpidWYpDQo+ICt7
DQo+ICsJc3RydWN0IHNwaV9tZW1fb3Agb3AgPQ0KPiArCQlTUElfTUVNX09QKFNQSV9NRU1fT1Bf
Q01EKG5vci0+cmVhZF9vcGNvZGUsIDEpLA0KPiArCQkJICAgU1BJX01FTV9PUF9BRERSKG5vci0+
YWRkcl93aWR0aCwgZnJvbSwgMSksDQo+ICsJCQkgICBTUElfTUVNX09QX0RVTU1ZKG5vci0+cmVh
ZF9kdW1teSwgMSksDQo+ICsJCQkgICBTUElfTUVNX09QX0RBVEFfSU4obGVuLCBidWYsIDEpKTsN
Cj4gKw0KPiArCS8qIGdldCB0cmFuc2ZlciBwcm90b2NvbHMuICovDQo+ICsJb3AuY21kLmJ1c3dp
ZHRoID0gc3BpX25vcl9nZXRfcHJvdG9jb2xfaW5zdF9uYml0cyhub3ItPnJlYWRfcHJvdG8pOw0K
PiArCW9wLmFkZHIuYnVzd2lkdGggPSBzcGlfbm9yX2dldF9wcm90b2NvbF9hZGRyX25iaXRzKG5v
ci0+cmVhZF9wcm90byk7DQoNCm5pdDogb3AuZHVtbXkuYnVzd2lkdGggPSBvcC5hZGRyLmJ1c3dp
ZHRoOw0KDQpjdXQNCg0KPiAgDQo+IEBAIC02ODgsNiArMTAwMywxNiBAQCBzdGF0aWMgaW50IHNw
aV9ub3JfZXJhc2Vfc2VjdG9yKHN0cnVjdCBzcGlfbm9yICpub3IsIHUzMiBhZGRyKQ0KPiAgCWlm
IChub3ItPmVyYXNlKQ0KPiAgCQlyZXR1cm4gbm9yLT5lcmFzZShub3IsIGFkZHIpOw0KPiAgDQo+
ICsJaWYgKG5vci0+c3BpbWVtKSB7DQo+ICsJCXN0cnVjdCBzcGlfbWVtX29wIG9wID0NCj4gKwkJ
CVNQSV9NRU1fT1AoU1BJX01FTV9PUF9DTUQobm9yLT5lcmFzZV9vcGNvZGUsIDEpLA0KPiArCQkJ
CSAgIFNQSV9NRU1fT1BfQUREUihub3ItPmFkZHJfd2lkdGgsIGFkZHIsIDEpLA0KPiArCQkJCSAg
IFNQSV9NRU1fT1BfTk9fRFVNTVksDQo+ICsJCQkJICAgU1BJX01FTV9PUF9OT19EQVRBKTsNCj4g
Kw0KPiArCQlyZXR1cm4gc3BpX21lbV9leGVjX29wKG5vci0+c3BpbWVtLCAmb3ApOw0KPiArCX0N
Cj4gKw0KDQp0aGlzIHNob3VsZCBiZSBkb25lIGJlbG93IGluIHRoZSBmdW5jdGlvbiwgYWZ0ZXIg
bWFza2luZyB0aGUgYWRkcmVzcy4NCg0KWW91IGFkZCBhIGRvdWJsZSBzcGFjZSBhZnRlciByZXR1
cm4gaW46DQo+ICsJcmV0dXJuICBub3ItPnJlYWRfcmVnKG5vciwgU1BJTk9SX09QX1JEU1IyLCBz
cjIsIDEpOw0KDQpUaGVyZSBhcmUgc29tZSBjaGVja3BhdGNoIHdhcm5pbmdzIHRoYXQgd2UgY2Fu
IGZpeCBub3cuDQoNCkxvb2tzIGdvb2QhDQp0YQ0K
