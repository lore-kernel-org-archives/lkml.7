Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AABC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE94421734
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="R4BmQ0IS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfHERp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:45:58 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:10286 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfHERp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:45:58 -0400
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
IronPort-SDR: pxXpMitIqQvyZRCSqKXNJbLbyDsrDI1rPnGeb0+mXNT+b0KepVncMDfsIsFpQ27hr2yu92/CON
 DDUuV6h4Ce+TU1xyihlGRNhAfIKjV4v33jelMB+rvo4hxPBlkM3iXVAZHA3hhFI6uki1itSHfF
 oySjhZBqv6WZTDgXfY3V4c2njelzP/lWMJq6Yi1cQ/s8xKejlehu0UGpPk9c6O9CzdituwF9gM
 N8ri4M0c2HCRPDsjRo6zBAU73Du+NFXkHDuS+Ywgmg5UPZ2XKLPf5XdZ4rQe6RuMmyvq5qg24n
 +Ec=
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="41049603"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2019 10:45:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 5 Aug 2019 10:45:55 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 5 Aug 2019 10:45:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ynayqu6pdcbNVzlAx0NSnNzRh4Fh3THn+vH9fzpLli3kJNnrxX7OhhrUL0Ee1sCZQ3HZmgbOJeRyitpDnq0KQo3+DnYM8rxFR7GiV9zdQqHfxErXICOaUVezB1zo5lDEkikUM2GKrnQVrTbxbyX9kzGhwd++OZqk8Tjj6hGRLKCFi3A2JnfGU/GK600Vvl4WiPMxMeo+EMacdqa2qVV50bUXJS0dAbQHmLx47/89jIP9WaghyHPVkUGwlfI1kgGFHpf40wbnoIQr/rClwPdk1iFHijmyDNbg0f9khKnvujpOBV5fd3/6s1aTuz170Jn7RQaqHdmLcKyAw8aJJuafYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tSn9ArI6Oj9LWP0VR4kuqpS8nsN/9ABFgShx4107Pc=;
 b=bQFgNxsv7VDu+cUE038Ob5tFgxzZBkLs14M0JNapI40YU4119KQd9onAqw6/0/HN0G2SvUzvr/4qmM7Mz5LiTEpAoVUDtGufiBb1OeUvc4Kqm7XAmmDvM2rkOLh6Oh386lPsm86uYVr/QVDM2hUK2UviPHydH9v3jqP3YbQE30e32Q+/CqdOADJaMPJN/QigcFviv9n4/2/aUo8KGQMhr0SugbX+lRwl1XWok2Zmf54EZ6SVQr+B68+gkqKacLJkF5Nb/8OdZKMn638RfwGVsEoGsLRCSsBXju0seEFA/uSVjq2jfXejmQ1BCO7h3QOUjewxTICjGSBiris4mwW5+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tSn9ArI6Oj9LWP0VR4kuqpS8nsN/9ABFgShx4107Pc=;
 b=R4BmQ0ISIj1jQWO6Bs4O6YI7n340cY2Yj5+zfPOGEcExMXOppWuWnKcGX2BImsnyDFKyqCGxDEAVtRb5uzZxFABPOrHO09aCrxtJTn6FzJmz+qr9mNJYZx7zmJsBS35nyqnHPa50KfsPzJatnsOIUoGpHdniivocQI+EW+PfvEw=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4287.namprd11.prod.outlook.com (52.135.37.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 17:45:53 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 17:45:53 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>
CC:     <marek.vasut@gmail.com>, <bbrezillon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <tmaimon77@gmail.com>
Subject: Re: [PATCH v4 3/3] mtd: spi-nor: Rework hwcaps selection for the
 spi-mem case
Thread-Topic: [PATCH v4 3/3] mtd: spi-nor: Rework hwcaps selection for the
 spi-mem case
Thread-Index: AQHVSIVT0p7xGp6VbkaLHo0K31VAGqbs2i0A
Date:   Mon, 5 Aug 2019 17:45:53 +0000
Message-ID: <ca327faa-d716-9ef3-f368-e496a40c6e2e@microchip.com>
References: <20190801162229.28897-1-vigneshr@ti.com>
 <20190801162229.28897-4-vigneshr@ti.com>
In-Reply-To: <20190801162229.28897-4-vigneshr@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0134.eurprd07.prod.outlook.com
 (2603:10a6:802:16::21) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f81827d-e20d-472c-cf9a-08d719ccc2c1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4287;
x-ms-traffictypediagnostic: MN2PR11MB4287:
x-microsoft-antispam-prvs: <MN2PR11MB4287802585D28472057477D4F0DA0@MN2PR11MB4287.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(366004)(39860400002)(199004)(189003)(25786009)(5660300002)(446003)(66476007)(186003)(76176011)(53546011)(6506007)(386003)(102836004)(256004)(66066001)(52116002)(81156014)(81166006)(7736002)(64756008)(66446008)(305945005)(26005)(4744005)(11346002)(6246003)(476003)(14454004)(8936002)(99286004)(4326008)(68736007)(53936002)(486006)(8676002)(478600001)(3846002)(6512007)(2906002)(316002)(110136005)(229853002)(31696002)(6486002)(66556008)(6116002)(54906003)(6436002)(86362001)(71190400001)(71200400001)(36756003)(2616005)(31686004)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4287;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uEBNluvNSbJTsv+ZeK4ciKY+7ZrhgEvJ+4Qs37FtlNBu6OSA+8h/h5U48Qx4RjIfhOGYmlhnCopNivIdaOp/HeOPzaL22W9vkTmW6CppCm8MhZj8kx4iS5RsHFp/0wxm6k/JO03UDmtFww6hKjTzTT9QPmvf6cHzThobV78FKixhwipfvlsSGl9avF0PCr3y7NeR5BTtHmzDZqq6smW4eHHDbgDCLG8wp2mTv/WPIY9xAntMbCXU+Z3CyJra9so94ujp/2Ot0kArmegQ5eAngWNoAaNQxm0x/FH/c41jZbRtqeVsBprwpQEH7WMoLGGli8Rv5c+xfyYjb27DYX5Pp3DWYkWVxYDm+epGzG161U3gPsSJfGFVZbB+sfyf3+dvABga4V1c0evPw5RqF5Cwcc232ghUNj61VKOCckD/G+E=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F416EB51D6EB14591E18B60F949FBE2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f81827d-e20d-472c-cf9a-08d719ccc2c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 17:45:53.0796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4287
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzAxLzIwMTkgMDc6MjIgUE0sIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+
ICtzdGF0aWMgaW50IHNwaV9ub3Jfc3BpbWVtX2NoZWNrX29wKHN0cnVjdCBzcGlfbm9yICpub3Is
DQo+ICsJCQkJICAgc3RydWN0IHNwaV9tZW1fb3AgKm9wKQ0KPiArew0KPiArCS8qDQo+ICsJICog
Rmlyc3QgdGVzdCB3aXRoIDQgYWRkcmVzcyBieXRlcy4gVGhlIG9wY29kZSBpdHNlbGYgbWlnaHQN
Cj4gKwkgKiBiZSBhIDNCIGFkZHJlc3Npbmcgb3Bjb2RlIGJ1dCB3ZSBkb24ndCBjYXJlLCBiZWNh
dXNlDQo+ICsJICogU1BJIGNvbnRyb2xsZXIgaW1wbGVtZW50YXRpb24gc2hvdWxkIG5vdCBjaGVj
ayB0aGUgb3Bjb2RlLA0KPiArCSAqIGJ1dCBqdXN0IHRoZSBzZXF1ZW5jZS4NCj4gKwkgKi8NCj4g
KwlvcC0+YWRkci5uYnl0ZXMgPSA0Ow0KPiArCWlmICghc3BpX21lbV9zdXBwb3J0c19vcChub3It
PnNwaW1lbSwgb3ApKSB7DQo+ICsJCS8qIElmIGZsYXNoIHNpemUgPDE2TUIsIDMgYWRkcmVzcyBi
eXRlcyBhcmUgc3VmZmljaWVudCAqLw0KPiArCQlpZiAobm9yLT5tdGQuc2l6ZSA8PSBTWl8xNk0p
IHsNCj4gKwkJCW9wLT5hZGRyLm5ieXRlcyA9IDM7DQo+ICsJCQlpZiAoIXNwaV9tZW1fc3VwcG9y
dHNfb3Aobm9yLT5zcGltZW0sIG9wKSkNCj4gKwkJCQlyZXR1cm4gLUVOT1RTVVBQOw0KPiArCQl9
DQoNCnRoaXMgcmV0dXJucyBzdWNjZXNzIHdoZW46DQoJb3AtPmFkZHIubmJ5dGVzID09IDQgJiYg
IXNwaV9tZW1fc3VwcG9ydHNfb3Aobm9yLT5zcGltZW0sIG9wKSAmJg0KCSEobm9yLT5tdGQuc2l6
ZSA8PSBTWl8xNk0pKQ0KDQp3aGljaCBpcyB3cm9uZy4NCg0KVGhlIHBhdGNoIGxvb2tzIGdvb2Qg
b3RoZXJ3aXNlIQ0KDQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo=
