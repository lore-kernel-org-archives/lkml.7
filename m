Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61DEC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A59B2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="c1ZXA6Vn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfHEGkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 02:40:45 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:39367 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfHEGkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 02:40:45 -0400
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
IronPort-SDR: jPg06cHkJlLrHMGUEJGo+PzOg+Q/38T36E6AOfFnxRFohifijOet3BsP85fINi9Vlv69tvCp2d
 BsoHIMZDUKZJ8m7GfjvHa78ndy2qoofTFFu53iAKMV/mD+46GMWTuGbUvKDhfwTdIHxwWE1Yzq
 1LxDEv6uUSAf4tqGl94AKqJBVCfd2HwiLLr85fhD98wziswOdIAc64TbLYMVNxJ1q+iWPiJ1T6
 8Hs7pumsQLXSvFIfcvL/ebfCFwH3qgUkP0q134cvSVWmI3QaKgpNG62ZwpPbg1x8fJ/3bpLSCu
 L2w=
X-IronPort-AV: E=Sophos;i="5.64,348,1559545200"; 
   d="scan'208";a="45318154"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2019 23:40:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 4 Aug 2019 23:40:27 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sun, 4 Aug 2019 23:40:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/LYWyjKDTwFqm2HoFyA2JHzhnuLPo9b3AfxF4YjQJ69xxN2g4jOk5nE2d4NJHx80gpzP3Yv/h5aFHBwaHXZ2b+l7G0RdD+KK5zQa6dJfEmlfmOGCineru5yuXOm8lg8gv9p22/qa91lx1qKje2lTVIXXtxecM6qSR3/zGfhC+pOKB95Pe0B0TmqQapJcv3doqxEUi49LzX4xREQB3N8pzK8O4yg6nhBN6QtQ48RTJNrXQdkDi24u/Veangy8+CQuVCwYlI78hlaylbXcJtiEQLW0q3a/lPbrltklDWxrr2OdyHtXwJLEmRgrOKhrV8vDRt9ANUxHzEkTxlLXh/gIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkavV3oS1aEBVL3Dvrg7UlKu0AN4u9D43ChYs/wIju8=;
 b=JjQzZOgAeR4zjVr48FZP2TmhTeYFEJ5Ar+BU1djI0BFtm5RAkqHXr+JzhJUjzTj2WM0tQxsCIwBArCZAwYmRyX5BmFZy+JehS1YOTL+J6Yc0GEDOTeR88d1mo2BAHzoRubQU2h+znVjg3ISk4W6AivmGXVa207LKlORGABm7RLjTxu8W2Am274hEqkX99Z+j/0TtY5qy4eyEI9hPf9tp+4UwO3R3xp6lQpzSc+VO8jEB17muWwb++LU4Pzp9wpd5+28dTatg4CqJ3wGnYz6R6C0O8AkyFPbf1QEOlrMREdtahs0H8u2xSU7ThTWTMuMn9HNd44rgaw5d7Kz5cVJ20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkavV3oS1aEBVL3Dvrg7UlKu0AN4u9D43ChYs/wIju8=;
 b=c1ZXA6VnZmbokn3wTH22ktD927hCtnlfbfxl/+gg4XKca7NkIhorM1VpP1GN5t6v7lEg2u1br6FfHZsGv733+GQy4BrlQXvurEp9065kLJf9W1smnjaHggiT17082muEEva6HY6ccUS8PeyNjRxaKz7NH/eka7YdCbnW0/0DR80=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4207.namprd11.prod.outlook.com (52.135.37.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Mon, 5 Aug 2019 06:40:25 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 06:40:25 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>
CC:     <vigneshr@ti.com>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <marek.vasut@gmail.com>,
        <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <computersforpeace@gmail.com>, <dwmw2@infradead.org>
Subject: Re: [PATCH 5/6] mtd: spi-nor: Add s3an_post_sfdp_fixups()
Thread-Topic: [PATCH 5/6] mtd: spi-nor: Add s3an_post_sfdp_fixups()
Thread-Index: AQHVR4AMaH6Ddp0nkEGsW9FcCZCHs6bl2Y8AgAZIuwA=
Date:   Mon, 5 Aug 2019 06:40:24 +0000
Message-ID: <6241efd1-e016-e8ed-ebc5-5931e23ea970@microchip.com>
References: <20190731091145.27374-1-tudor.ambarus@microchip.com>
 <20190731091145.27374-6-tudor.ambarus@microchip.com>
 <20190801084226.27572bb6@collabora.com>
In-Reply-To: <20190801084226.27572bb6@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR02CA0063.eurprd02.prod.outlook.com
 (2603:10a6:802:14::34) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8ce8c1f-c88b-43bc-06d4-08d7196fcbda
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4207;
x-ms-traffictypediagnostic: MN2PR11MB4207:
x-microsoft-antispam-prvs: <MN2PR11MB4207724FBF95788A8D475932F0DA0@MN2PR11MB4207.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(366004)(396003)(199004)(189003)(54906003)(476003)(6506007)(386003)(14454004)(53546011)(2616005)(102836004)(11346002)(229853002)(446003)(76176011)(558084003)(4326008)(71200400001)(305945005)(6436002)(31686004)(25786009)(486006)(186003)(66066001)(478600001)(52116002)(256004)(99286004)(36756003)(7736002)(71190400001)(31696002)(66446008)(81166006)(86362001)(8936002)(64756008)(66556008)(66476007)(26005)(81156014)(8676002)(53936002)(5660300002)(6486002)(66946007)(6512007)(6916009)(2906002)(6246003)(3846002)(6116002)(316002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4207;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bnJig3wOdaKpyPlIH1kYz5jYE1BAcKz7fYJ2RWwcdLmOAPP3Ya68wlxgVFxFBVcz6IZSIFczb4VNNJE8Ufj1FastZmbB+xA+QebnDRAOb+PLEuREk5dOwjnzrS8NoLX0lIMGZZLoD1pZ+jSqn4he8a4mf1PCVskS/U8lm4DpcrZYi48p15o9+K+2xohJpwE4mWWk08TV2OYRP+VbYmmtIHS2WSwWryhOGIMCk8pjjy9FagMBiZa3jgd+4D4WN4Nd0XEhO6HBi3hVm9Jh88A8KldcNFSOFwzQT2Esz6bSklc6jD5vGqf6oRz5dQsVFOFo0kOgM9sC764Ocx6CqivwXECXuQYOlIuwnSqKqtLPyVCDMEcbElwV10Jg7qck9xk/n9NHkFVtGA2341NFhDVlW5PRP5hA/GGAT8hCWHm87bI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <731435373D1DD14BB97B7BBFB1A98792@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ce8c1f-c88b-43bc-06d4-08d7196fcbda
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 06:40:24.9831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzAxLzIwMTkgMDk6NDIgQU0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gQWxt
b3N0IGFsbCBvZiB0aGlzIChleGNlcHQgdGhlIHMzYW4gc3BlY2lmaWMgYml0cykgc2hvdWxkIGJl
IGRvbmUgaW4NCj4gdGhlIHByZXZpb3VzIHBhdGNoLiBTbyBJJ2xsIHB1dCBhIGNvbmRpdGlvbiBv
biB0aGUgUi1iIEkgcGxhY2VkIG9uIHBhdGNoDQo+IDQ6IHNvbWUgb2YgdGhpcyBjb2RlIHNob3Vs
ZCBiZSBtb3ZlZCB0aGVyZS4NCg0KWW91J3JlIHJpZ2h0LCB3aWxsIGRvLg0KDQpDaGVlcnMsDQp0
YQ0K
