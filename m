Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C434EC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6CF229F9
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="wCsufhh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391255AbfGYLoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 07:44:55 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:1744 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387927AbfGYLoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:44:55 -0400
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
IronPort-SDR: xYS69BO8PuG8b6Ytcp2MEbTafUubRJsBYFYT3IKUmxufk8itZdxZdgSla/k1TnNiLULXFPJ86k
 oAcI+N/To198Y9XmURQDTo9ISt3rIX4JAk+lV7MYWcVAKNdnFe6jFBVxp0KGjabxuF/MZ7I1Cb
 5dKqEElCvAUvIGZO7wK4Ic/STpZO2YDrZXM1SEGpY5mB6IEydhPQHW9fLzmiIjNNRZKwjFxhr4
 Ob2Klb/at+lNmjA8CY572RxwR+1NaZgXjNrL1S7QPp3QEjB6RMZXXRaPsV/A+fDmZSikcIslzP
 G4c=
X-IronPort-AV: E=Sophos;i="5.64,306,1559545200"; 
   d="scan'208";a="42717251"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2019 04:44:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 25 Jul 2019 04:44:53 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 25 Jul 2019 04:44:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWLN0Cubq2IJMd8fom8GkpijnHd8KIxeMORbxNoS+nAmF2WWqSRh801aTPyAVQH1DVo7+zNjrN/9FNWleFzZi9SVXedn3Y+0K19KlSDfj8bVteWUeksuluHvoy+8h5devCdqgd0RFaOpRr1Dw3owSpyueByBZECtpzfPBT+Kf50keqNmtb+WnJZkSNQ6vgZTZbYSZPg04HrEk+61E+ClIPgkYgZjRx3DUyJPq10XHcWf5nBWBldWK9xpV1uFCaWpoBQKoAOXoV8lEGtO57beO52D7GFHgfz2U/P9BVr5GTgcTfLtkp82kDsHdyhXPyWC8Loxq0bGEsFBA8Bs3O/CnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkIu4mvajccoXK948aemzhJN8murMFj1qsVf+J+2pOg=;
 b=aHERi80S/ptVebIX2X657rhN+xyQrjKGQwGvHZVMDFaz7KLWbvJUFWVAPVGHenSPHBV+/x2x9o0fnCQzObCglasS9iiE8M2ha2KICRYgrdg8BylSdC6+0LYrC2+RYqGYZkUodZUkpmPYHUm6rD4qEuhkZm0cbP9GZ3u32JrZth9xvdr2ZDTWx6iY8841Q2xd7qs5igDF9C2v2IMeg0lXXTakCNIxDTcGP/chISiux1/byEzatUSwijWEffVEtsbPZQ1crq2O30PZLNmj6I+FYt8xPl878R0U3M7wsL5VCwK8hlVCcmAlQNLE0JjEnx1zCtSzTWRlhisng8F7KneGYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkIu4mvajccoXK948aemzhJN8murMFj1qsVf+J+2pOg=;
 b=wCsufhh0bCNEsTMNloDloiP0MjqRI0OdiYvIxAi01ua0UK9Mxq0lk2Veo22OnMf08+5pTjJZ5Bbi3SsdE5XcaJ+m20IIn+fa3fGawx70VVKSFRO+Hbuuu3fGLi4EUthn6/Qcr8n+bXLb6YrJSpcBLqOucjbGGE8B6B4sgEg8zVo=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB4018.namprd11.prod.outlook.com (10.255.129.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Thu, 25 Jul 2019 11:44:52 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::3161:92ff:d26c:8b66]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::3161:92ff:d26c:8b66%7]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 11:44:52 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <marek.vasut@gmail.com>
CC:     <bbrezillon@kernel.org>, <yogeshnarayan.gaur@nxp.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: Move m25p80 code in spi-nor.c
Thread-Topic: [PATCH v2 1/2] mtd: spi-nor: Move m25p80 code in spi-nor.c
Thread-Index: AQHVPtFNjfEG9DN44ESnRp+H/g0b8qbbN92AgAAHOoA=
Date:   Thu, 25 Jul 2019 11:44:52 +0000
Message-ID: <b60adcf5-e85b-875a-c041-6bff1cade296@microchip.com>
References: <20190720080023.5279-1-vigneshr@ti.com>
 <20190720080023.5279-2-vigneshr@ti.com>
 <f6410e21-18c3-9733-4ea5-13eb26ad6169@microchip.com>
In-Reply-To: <f6410e21-18c3-9733-4ea5-13eb26ad6169@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0106.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::32) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 108fc523-07df-4f23-bc95-08d710f5814d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB4018;
x-ms-traffictypediagnostic: BN6PR11MB4018:
x-microsoft-antispam-prvs: <BN6PR11MB4018DC513D8D27676999393DF0C10@BN6PR11MB4018.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39860400002)(199004)(189003)(3846002)(2616005)(110136005)(54906003)(6116002)(316002)(446003)(31686004)(36756003)(4744005)(99286004)(52116002)(76176011)(256004)(71200400001)(71190400001)(486006)(64756008)(186003)(2201001)(476003)(81156014)(81166006)(68736007)(8936002)(8676002)(66066001)(386003)(6506007)(86362001)(53936002)(6436002)(478600001)(66476007)(66446008)(14454004)(66556008)(6486002)(229853002)(7736002)(66946007)(26005)(6246003)(305945005)(2501003)(5660300002)(4326008)(6512007)(31696002)(102836004)(25786009)(2906002)(53546011)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB4018;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yJigpJlTGRRurJgF4uWQUNjdXHNFx1B2w5woumwTtI1fI/1mqF86/LObWfxIRk5TzEuIqTXk3tJzEmmNX566QaTgCDk4llaBJaotSL04z9vZulJFiTSbLh/vyMsAg1BA08C831xhqWEwvBnDCttos9LPSrVUEIPLmveCN77yfWZ2LTb58HJSmWbDyHKAyFAF6Wh8A9cd3HstLiu+haLjDkUWSu7qKN3zHaiLb/RnxDx8Og9d/NbFkr1+ttXJXhvq8w64ZC3AxH22dci3KNDA7HECEaqhKN+9uC9HIGe0ZC+qWGqG5uNCxlmLH6f6y+y8XN9l8Re13mVRElb5MmWaDWrd64z++0wYr5u7HY0DW5W2pTdvee9XSJVFcovXGA8imMXZxctejl7v46lIFugEud+xejfUx8rnh42wjI3wed8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AF77D3742602449AFF30BC901B41BC2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 108fc523-07df-4f23-bc95-08d710f5814d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 11:44:52.2740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA3LzI1LzIwMTkgMDI6MTkgUE0sIFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbSB3
cm90ZToNCj4gc3RhdGljIGludCBzcGlfbm9yX3NwaW1lbV94ZmVyX3JlZyhzdHJ1Y3Qgc3BpX25v
ciAqbm9yLCBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3ApDQo+IHsNCj4gCWlmICghb3AgfHwgKG9wLT5k
YXRhLm5ieXRlcyAmJiAhbm9yLT5jbWRfYnVmKSkNCg0KIW5vci0+Y21kX2J1ZiBjYW4ndCBiZSBO
VUxMLCB3ZSBjYW4gZ2V0IHJpZCBvZiB0aGlzIGNoZWNrIHRvbywgYW5kIHVzZQ0Kc3BpX21lbV9l
eGVjX29wKCkgZGlyZWN0bHkgd2hlbiBpbnRlcmFjdGluZyB3aXRoIHJlZ2lzdGVycy4NCg0KPiAJ
CXJldHVybiAtRUlOVkFMOw0KPiANCj4gCXJldHVybiBzcGlfbWVtX2V4ZWNfb3Aobm9yLT5zcGlt
ZW0sIG9wKTsNCj4gfQ0K
