Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A784EC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6326F206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="mdRrR3GK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388152AbfGaNGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:06:53 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:55752 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388110AbfGaNGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:06:52 -0400
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
IronPort-SDR: 3Bk5g0SioaS+ab2CxA2sF4JJ3qs/8dZOYCMIDjlZRab8yAkuofDivSarHDHVV4DxwU6DgPZqTd
 JTIY8ji/Mz15XAGERMSpDJ7US92BobFKnWTDuXZub8q8VXMCyGgf6n52A11tCpnZUUtIMFCA2K
 UgOe42hy/CvXfx8HhmrWpjMSYndrS7YMVv0LVOq4pVS6qngMsEPGVXKP7GtVlhHyLxjT5R5/dB
 JoRh/t/iUxeA0CJ3zZ7c8TxVL9DLZwOJAtWpwmc5kIqAKgFioQ+EDyny4yocO4WTpbJI7I5Fja
 6bI=
X-IronPort-AV: E=Sophos;i="5.64,330,1559545200"; 
   d="scan'208";a="42656730"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jul 2019 06:06:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 31 Jul 2019 06:06:46 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 31 Jul 2019 06:06:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObwHP3pb0T1HS5gypDUHsGDaEZomf9MBYabqxXslWXHwKR5qDA0Wwrw1s0QE14HHXkC/7Vwn0pVy7uEXf587QvdEyUkcoxFaZNN6p77zoYd3dK24NU//Lr607KKq+3xN2Y6VSNOjYG9vaWTa//l6GwuMC2AiFmygAI08PHBTK7r683QXGCsvkR1t+lDxFPvBoC02WvxHQN8gYO3k1O3kumPz6Q+ZiAu0ctZi+ObiPGYJc0sai0dOUlu8I6EgntcyWcPuz82P6wqLUhWWqy+ISqIq2t9dwTmyDkS2lQzBnbvVEyo1wPonf4y0FD4SDxSH3FMRvqdoJSnUsg0HpI01zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzrPid35fjCOw3EkXeoph/i9Wv+vr9lZc8pr58BleKo=;
 b=Cfu+XjK9iBtAc14UtX6oeKVKyirVmwDsmG4i5wqgApSzkSdfp2yTiLQ4EorXho/QPXePFrQ1dpREPuIZao/Pa+42ldhU86UWDHh2+GIJVUGClqUKqhO3DzdeR6DkPIiZe4d7NUYCqTM1Av7nukpC2f/QDd6pT4kir3R76SOlFxoRdGHIUDb9Sb5Bja3xnQiQT4UUh2DaHVYrxSJRv9KCbyyQSgPTsQXcswbuYe8jTyYUBB0oE86fLh8gHAMJcnvMPz7szqdn5afx6vfLf0dZBdfvtifNtJXzbR/diuFtyolZqMYR+wosaNnO8WtgbC+FXFEDuO4WrbtJThIHPZ7+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzrPid35fjCOw3EkXeoph/i9Wv+vr9lZc8pr58BleKo=;
 b=mdRrR3GKXlsujCpcAvycnVlQMUqgec8kZtPA4cqUXDmX6auuq0qzwjReCYtmVXEbL7jj0deWKSWnaCT6BR+3MOaD+Txj/yauWuqQPnUROm0/6swdNcIjIeEToW0hYTU3UMjKHhUazczX5BoYk6c+CWtztwndUWiQT5pc7k8bUh8=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Wed, 31 Jul 2019 13:06:46 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5%2]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 13:06:46 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <nagasure@xilinx.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <vigneshr@ti.com>
CC:     <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <computersforpeace@gmail.com>, <dwmw2@infradead.org>
Subject: Re: [PATCH 5/6] mtd: spi-nor: Add s3an_post_sfdp_fixups()
Thread-Topic: [PATCH 5/6] mtd: spi-nor: Add s3an_post_sfdp_fixups()
Thread-Index: AQHVR4AMaH6Ddp0nkEGsW9FcCZCHs6bkqLWAgAAJ2wA=
Date:   Wed, 31 Jul 2019 13:06:45 +0000
Message-ID: <cfe63aee-2c48-c321-53b7-3997c97dc215@microchip.com>
References: <20190731091145.27374-1-tudor.ambarus@microchip.com>
 <20190731091145.27374-6-tudor.ambarus@microchip.com>
 <MN2PR02MB5727FF8617B1A2FC89739601AFDF0@MN2PR02MB5727.namprd02.prod.outlook.com>
In-Reply-To: <MN2PR02MB5727FF8617B1A2FC89739601AFDF0@MN2PR02MB5727.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MR2P264CA0052.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:31::16) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0549b613-59c2-4423-606b-08d715b7f096
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3711;
x-ms-traffictypediagnostic: MN2PR11MB3711:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MN2PR11MB3711470F15F9F0CDE6F9684FF0DF0@MN2PR11MB3711.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(52116002)(4326008)(7736002)(316002)(6116002)(8936002)(6486002)(86362001)(25786009)(53546011)(3846002)(71200400001)(31696002)(54906003)(6246003)(8676002)(966005)(305945005)(71190400001)(478600001)(5660300002)(6436002)(66066001)(6306002)(14454004)(2501003)(68736007)(6506007)(386003)(2201001)(110136005)(64756008)(486006)(66476007)(66446008)(66556008)(186003)(6512007)(31686004)(446003)(81166006)(99286004)(2616005)(4744005)(476003)(11346002)(256004)(81156014)(102836004)(7416002)(76176011)(2906002)(26005)(66946007)(229853002)(53936002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3711;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MO02jVNxFq7CS8RRBHFe2roKMMXMyivH+6TTQEDgTNhdicxtbJe5mT0RBREnQRpqLulhAsvyBTJdg/yIMp89m01evyJ4Tb3sPCaD2g4aHNlzPUU7+ReKAdrgTSA+Aux1dEpq6ZdZhKWzGsX+X/FTVrRsl/s9saGP59sYg6h0xWZURycjDOICHn8DDFMcImjDQcVGKdHuLfrbRkBnWn8c6+qYMWoQ4W0hQAJPXRt/eWB2E5E9oETvduZjAMGkQtZ4/hw6GfW25hUz7j4O/y2YrLuJLiw7eyYvKhekeCwM7e0Ze3v5/2iYa1z/FF9rqBKHoCj9Q7ODHGdkUOcNVnOfWqD9mWc27cytaQ17yDoP4wUFJXeFbFIuvFJeOLn/WrIC/iAALCFDSowTg6+gq+bEperdwoPbmMwB6q4+oGz8MFE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C5BA27FD850E84E9261E407CB6C7352@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0549b613-59c2-4423-606b-08d715b7f096
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 13:06:45.6790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE5hZ2EsDQoNCk9uIDA3LzMxLzIwMTkgMDM6MzEgUE0sIE5hZ2EgU3VyZXNoa3VtYXIgUmVs
bGkgd3JvdGU6DQo+PiArCWlmIChub3ItPmluZm8tPmZsYWdzICYgU1BJX1MzQU4pDQo+PiArCQlz
M2FuX3Bvc3Rfc2ZkcF9maXh1cHMobm9yKTsNCj4+ICB9DQo+Pg0KPiBJbnN0ZWFkIG9mIGNoZWNr
aW5nIHRoZSBmbGFncywgd2h5IGNhbid0IHdlIGNhbGwgZGlyZWN0bHkgdGhlIG5vcl9maXh1cHM/
DQo+IGxpa2UgQm9yaXMgaW1wbGVtZW50YXRpb24gbm9yLT5pbmZvLT5maXh1cHMtPnBvc3Rfc2Zk
cCgpDQo+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcGF0Y2gvMTAwOTI5MS8NCg0KVGhp
cyBjaGVjayB3aWxsIHZhbmlzaCBhbmQgbm9yLT5pbmZvLT5maXh1cHMtPnBvc3Rfc2ZkcCgpIHdp
bGwgYmUgY2FsbGVkDQpkaXJlY3RseSBvbmNlIEknbGwgcmVzcGluIHRoZSBtYW51ZmFjdHVyZXIg
ZHJpdmVyIHBhcnQuIHBvc3Rfc2ZkcCgpIHdpbGwgc2V0DQpqdXN0IGZsYXNoIHBhcmFtZXRlcnMu
IENoZWNrIEJvcmlzJyBwYXRjaCBhdA0KaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wYXRj
aC8xMDA5Mjk1Lw0KDQpJJ2xsIHRyeSB0byByZXNwaW4gdGhlIHJlc3Qgb2YgQm9yaXMnIHBhdGNo
ZXMgc29tZXRpbWUgYXQgdGhlIGJlZ2lubmluZyBvZiB0aGUNCm5leHQgd2Vlay4NCg0KQ2hlZXJz
LA0KdGENCg==
