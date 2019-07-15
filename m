Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA82C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046D7206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="pAp6I4wu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbfGOLFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 07:05:08 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:14591 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbfGOLFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 07:05:08 -0400
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
IronPort-SDR: o7D0l77+7aaFuKdjr6e3XowsJj6pw0q8UnaaH2kT+5ggFhUUTTrmNzDMsSkpBCoVX7MMjSPsVd
 OgkvRZKBqZHpxifFuo/7La+WAOmD3iqm8SscFi6QujNPeaVXAf5bKgQ3F1QYLcOXyJoKFDFMLL
 UkUg4ExeWSKtY49hWsW1uHvsy2hy5wmwaQ5U6aZdWkKY9cSoQaq7b3conGnSOF2BbiwCo192MJ
 SMXG3tyaiNbHRiJDvzq8WHqhBxO5p3OpSHMXW8FqGCla4vX4YQIj0YPPSDFRz5Sw906oT6mcGs
 wWc=
X-IronPort-AV: E=Sophos;i="5.63,493,1557212400"; 
   d="scan'208";a="41296455"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2019 04:05:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 15 Jul 2019 04:05:06 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 15 Jul 2019 04:05:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrUxpokEcuqOV2QPQAmT/AA71PgGRYoEN7Q5YCC45E0UKG29D3Fk1CP/3+fXxNZQbiKnbWfUME7ZPbAUtN1iNbrpNQqzbu+DNC9eeZWXLZ0BtCAeoMUpkhsV42HTUsrK4TSd4kMXEQZa1fdTjkDsUuIwKtzbb2HyuQolUBP0qJ/Al4CX331yRCGRds3CtAz3u+NVKFfz6BB60/AHvsqRiXDPxEe+ursGer68qVlJVr58lDs/WIoR0fKoj7aZsfZ0trstnASn/kFO4YIDPgX4nhgboSyVO4yvauzPg1rjLsSipTA7WUn/tM4Gz3B77+3tVsGtiENYQtMiHPK44tBF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04ydRJRwVFHlaqEy3oz5Hj3yJqseCBem+3HIY9oHXs0=;
 b=lO7ckRJDLG9JCNa/92gqNhPbhEp15BCYSTgFj3YFp7iQpteSaDXgBZLF+rhDUd5SYInVrIHvvLZV7tjuiV+38WXEIB4tXk3KYNK/cA7B3rassoQH6GUsZuvyLuFOU9mff/X0Yy+jvybreinpk4ATfU64IyGsd6Iw1ImL7bqabUh40c9PkSD9J559YTeW1SB64p9jVA8hmG0rZwc8BfzoylfpgLSZElJuPr9Ca/EXuRZq7UVWqzS/+Zzb/lJsiYCOsWXq0wEKe5rJ6xuBWzi4IWtAytLLWlackQvO/mPPsZOxYMQ9JgAy3gjlr5oeSLfuZflupUeAAjtaw5Fa3d7OlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04ydRJRwVFHlaqEy3oz5Hj3yJqseCBem+3HIY9oHXs0=;
 b=pAp6I4wuvn7CTSkyI5QHCdhjRlFOVpxwr1rF7X3CQQ+kKDDKIYvcH3hTCGr5rZZnG9K//dS24w/cWA4wWcQfSwsgkg/9MhGkYkUxY19U0dWtQc/tAumhc5pRtsfrO1qt+xllwrA49LPMd2u952XuzO/C1/MjJD2S4kZ2c1aw5s4=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1379.namprd11.prod.outlook.com (10.173.32.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Mon, 15 Jul 2019 11:05:05 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::6515:912a:d113:5102]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::6515:912a:d113:5102%12]) with mapi id 15.20.2073.012; Mon, 15 Jul
 2019 11:05:05 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <sagar.kadam@sifive.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>,
        <paul.walmsley@sifive.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v7 0/4] mtd: spi-nor: add support for is25wp256 spi-nor
 flash
Thread-Topic: [PATCH v7 0/4] mtd: spi-nor: add support for is25wp256 spi-nor
 flash
Thread-Index: AQHVMQWfiPsPkD0Jj0iOEEvNMlu2s6bLksqAgAAFdAA=
Date:   Mon, 15 Jul 2019 11:05:05 +0000
Message-ID: <14025233-db7d-2307-5367-d41ed24f371d@microchip.com>
References: <1562092745-11541-1-git-send-email-sagar.kadam@sifive.com>
 <CAARK3HkMz3AdcVyrteGmqczCaMDTYS1h9uALspm75RFE9c6jFQ@mail.gmail.com>
In-Reply-To: <CAARK3HkMz3AdcVyrteGmqczCaMDTYS1h9uALspm75RFE9c6jFQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::49) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b75437e3-e864-4deb-8222-08d709144a75
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1379;
x-ms-traffictypediagnostic: BN6PR11MB1379:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN6PR11MB137961C63DAF10BB55153D8AF0CF0@BN6PR11MB1379.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(366004)(39860400002)(346002)(189003)(199004)(53754006)(2501003)(476003)(256004)(31686004)(5660300002)(4326008)(53936002)(6306002)(6246003)(66476007)(6512007)(486006)(64756008)(26005)(66556008)(14454004)(2616005)(71190400001)(446003)(11346002)(186003)(66946007)(4744005)(71200400001)(76176011)(53546011)(102836004)(386003)(66446008)(6506007)(6486002)(81166006)(52116002)(316002)(54906003)(8936002)(110136005)(6116002)(3846002)(36756003)(99286004)(7736002)(8676002)(6436002)(305945005)(68736007)(7416002)(2906002)(25786009)(2201001)(478600001)(966005)(229853002)(66066001)(86362001)(31696002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1379;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KImi6EakB8GcXmW+YWy8cMioHwnlyaK4i9/4TLZGTpq0dZf5b+dOAmjqzGu82XpmzghVnTdpsAZa6StY87SwfuuDDw+zVrvupO2IOgT+yk0EbFvdI4TNGaqKPXXlZ1QJmWzFf4hBfjHmZwreBWYdWQ/Z/iCYcMn2pmCVfZfvo4aWXmEZ3VzOMa6WfLby3rwc9QW5GuHWAqc5rUEILmD9IZY4ygPcoFKhleUAGFXnL0tJnr0xrxX0ujSg3vglu5o9BEVO9asATg7BhFeQjLmvptQzirwY8TavtsMtdhASoSOPLkLPrXt+6xGVyyY52iBEP5BGsfVG3fK0PZRuyB5rjshdmWAGwVV/9T4bl0FJP9nc+zejK2JY+Yii7DbinpR9MYM/vuHfDiMdBVaVZ517kLQkD13p+o61ZA/EZv+N5tY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85B1051788F50241A7CCAE010E941EA4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b75437e3-e864-4deb-8222-08d709144a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 11:05:05.1814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1379
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA3LzE1LzIwMTkgMDE6NDUgUE0sIFNhZ2FyIEthZGFtIHdyb3RlOg0KPiBIaSBBbGws
DQo+IA0KPiBBbnkgY29tbWVudHMgb24gdGhpcyBzZXJpZXM/DQo+IA0KDQpIaSwgU2FnYXIsDQoN
Ckkgd2FzIE9PTyB0aGUgbGFzdCAyIHdlZWtzIGFuZCBwcmV2aW91c2x5IEkgd2FzIGJ1c3kgd2l0
aCBvdGhlciBzcGktbm9yIHBhdGNoZXMuDQpUaGUgc2VyaWVzIGlzIGluIG15IHF1ZXVlLCBJJ2xs
IHJldmlldyBpdC4gWW91IGNhbiBjaGVjayB0aGUgc3RhdHVzIG9mIGEgbXRkDQpwYXRjaCBieSBs
b29raW5nIGluIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9saW51eC1tdGQv
bGlzdC8NCg0KQ2hlZXJzLA0KdGENCg==
