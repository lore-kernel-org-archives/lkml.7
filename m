Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B529C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451D92173B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QuyZlcZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfHLLYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:24:40 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:53917 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbfHLLYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:24:37 -0400
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
IronPort-SDR: FZoMxtYWkbyIXj1XJisPPUlokjCFK/vMgJS6Mm7LWzrG2d6YN/a9TQYQWmST06Rxjnxw8xvwn5
 Ujyi+nSxa6Fgaxx46jaJA5YH0t3uBL8i5iCFoTOvTOnxfXqiaw28lnh5GFXxSz0eeeFMTd+ZZK
 ZqUSwkDjlCHzwWRGOmH6aF6ePieJmd16a3UaCTwhw4nolYSZx7wAL+SCimRFna0LfPVv6hG5r+
 q1htUb8cWECRS01i7wa8HvDBLPnRiQaLNG5HWPhoVlo1mVPPkOANwrYmI5gCwsHX+9pMZnVZ39
 Kq8=
X-IronPort-AV: E=Sophos;i="5.64,377,1559545200"; 
   d="scan'208";a="43968405"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Aug 2019 04:24:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 12 Aug 2019 04:24:26 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 12 Aug 2019 04:24:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+DXWkJZEOLtpQ2jI+jVRZeQq/eUd5e/e0bBcReD6vYpHHFZzfUe56Wf/RkPSShIHfP2XzmIqUxYStJmsGJOtW7P4MAr5QKljw2MR4FbrfBgRqK1hsQ+UzonkVwObF7n4nlO0K3AncZgJd0LhW7UJZ4k38e4HVgi7z35LQbX+NOQGrL2AOQUIdD8c+uFFYUXX7okfl+ItwENfh7NnJgPj2QAy/VTCyRrJWUj29PpSyUEnQdM7G0m4JUm4Debd67aaKoU8nn7Yr6UkUEFjKZpKwV+oNskQTpdIWE7oMs6CwndQZ8q7Z9VxWxFIPtSRkpReWRxwUe3kKukmE74GhCH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFNPkCNcvIVyLXaDum920V2U9zMnSLTS1Idjwm6g1pI=;
 b=jvlSIFYpshl7Lt6SLdxcyCWMUbpKptVvp78lXleItwCGZAGyeKGbrF0rIPzanx6dpTPmAM+C1SQicTG7SczGeeIsFXv7YjJMMruSC3yYsj8PB2IBiNCIU1KkG4Hvc8fuubiZaS1Wb5mz98R+DrM0kgUdGe0LNDfGp0/avp4PfcroRCgUZwH2XvW1h1qvTux5UtQh+CQN9rhpuQx7KdNcdmmncu914tSBcv2o2e7yRMVz7TQrBIn7UgG5y/3vMVxYjP/n8bJwBdaD2Z6Ak6XdJp1NSTtAFLV+gNB+oIh5ghegOxnR5FsT4yrPmOROZfnSZ/NSi1pW9hYS+yxvkshEIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFNPkCNcvIVyLXaDum920V2U9zMnSLTS1Idjwm6g1pI=;
 b=QuyZlcZPPpLi9QeVOK8lp5yRwD5QFrNy7Go7jk7TemB+aZJlMDANLHpEJX1R3b6rgmdOaol35caQaUsNXzoPUAKC1ZDCIMWBj8c/QHHz7wOqvphET/UOE/W+T1wnUJsFUlO3RgrgEg5/jh1rg4oJLdKzZNTFhBC+0lxdkhxFvSw=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4062.namprd11.prod.outlook.com (20.179.149.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Mon, 12 Aug 2019 11:24:26 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 11:24:26 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <marek.vasut@gmail.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <boris.brezillon@collabora.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH 1/5] mtd: spi-nor: fix description for int
 (*flash_is_locked)()
Thread-Topic: [PATCH 1/5] mtd: spi-nor: fix description for int
 (*flash_is_locked)()
Thread-Index: AQHVPHxaKG+eJEFhOUur/Urn3TTMiqbsJe6AgAth+IA=
Date:   Mon, 12 Aug 2019 11:24:26 +0000
Message-ID: <2ac48ee5-f918-2313-c30c-8d1e2d3008b5@microchip.com>
References: <20190717084745.19322-1-tudor.ambarus@microchip.com>
 <20190717084745.19322-2-tudor.ambarus@microchip.com>
 <a4f14ae4-e42c-73f5-2121-5e506dd868cf@ti.com>
In-Reply-To: <a4f14ae4-e42c-73f5-2121-5e506dd868cf@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0189.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::13) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 968ff21a-5c00-43bd-9328-08d71f17a211
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB4062;
x-ms-traffictypediagnostic: MN2PR11MB4062:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB406201C97BF7A56BEB41CEEFF0D30@MN2PR11MB4062.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:352;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(136003)(366004)(199004)(189003)(26005)(316002)(66946007)(6306002)(6512007)(64756008)(66556008)(66476007)(66446008)(14454004)(110136005)(3846002)(99286004)(8936002)(966005)(6486002)(6436002)(36756003)(5660300002)(305945005)(54906003)(81166006)(6116002)(81156014)(4744005)(7736002)(8676002)(66066001)(4326008)(31686004)(25786009)(2906002)(107886003)(6246003)(229853002)(478600001)(53936002)(53546011)(76176011)(386003)(476003)(2616005)(2501003)(52116002)(186003)(71200400001)(71190400001)(102836004)(86362001)(14444005)(256004)(486006)(446003)(11346002)(6506007)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4062;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kEAsSN5UxtKWVqEPMhkEmUF2VGmm4y2pRx0d1mXE6pM5KSBf0OOxr6CHKKRn8lz8E4zorNsfGT9UW7UY4omUzTAXUBbLmc3DjJPI4iXwGXLVyR3IAnY3qUp1iwX+D3GjN8TiqQTASstJ/ReI0iCyvInQInk5QrkqV/oMdRExh5O4aCAxgcNx1Yi1NFlJDZEJnIH6ByyMyf5Jwfiy6wWNvtYMVgVEKfUhlFkv9VF676sU6IUSGlEw7bFn2/1dXtEpHnXAx0P0WL7BfK1IL7Ew7J9q86Im92G2MjH9+AM62LjPMi9AbkkPCwZJEsTWjHXk7gFChgqeHkn7cEznP/DzQvIN+wSv/rH4SJ1RgjLBFt4S9I00LCpgl+imRh2dnm4FXtdPOdv+vJ2Dt7FTNRf0Ho7Qc1/jq/HfyKMOutrpYXs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70FB3AC78402B24182E5E8F90A4C3A9A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 968ff21a-5c00-43bd-9328-08d71f17a211
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 11:24:26.2862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HBSqVv0KauPw33NqU/UWup1qtL9b4nbPWC/TpuYMHVtAGqsc/mnug/qf90V13fCLmFiYIKzSH+VDpvrnH3gWwaRV5Nf71dBdN2NWBuYP7oI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzA1LzIwMTkgMDg6MzQgQU0sIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+
IEV4dGVybmFsIEUtTWFpbA0KPiANCj4gDQo+IA0KPiBPbiAxNy8wNy8xOSAyOjE4IFBNLCBUdWRv
ci5BbWJhcnVzQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBGcm9tOiBUdWRvciBBbWJhcnVzIDx0
dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gVGhlIGRlc2NyaXB0aW9uIHdhcyBp
bnRlcmxlYXZlZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5h
bWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogVmlnbmVzaCBSYWdoYXZl
bmRyYSA8dmlnbmVzaHJAdGkuY29tPg0KPiANCg0KQXBwbGllZCB0byBodHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9tdGQvbGludXguZ2l0LA0Kc3BpLW5vci9u
ZXh0IGJyYW5jaC4NCg0KVGhhbmtzLA0KdGENCg==
