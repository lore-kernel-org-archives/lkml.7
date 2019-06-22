Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1277C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 12:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8091720679
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 12:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="oJV1Hvf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfFVMFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 08:05:11 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:56861 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfFVMFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 08:05:10 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,404,1557212400"; 
   d="scan'208";a="36923223"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jun 2019 05:05:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 22 Jun 2019 05:05:06 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 22 Jun 2019 05:05:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwpEukNpBUgwuk6b4/8t4J7Z9vidNXP0mKcLjWt0p3s=;
 b=oJV1Hvf+ft0TFK8JYhPO7PkEFhSL4RIKAUZkhFQR56FQXw5RKnILbwaPDFF+KHVqz9kq0O+Qm0WYsTTmEhCySvy2vFmXFnflFNpF+tKcaRnWZ5OrIy1UWlLMOOiFQGyAXOS+F9mRKwXtqRsP0Kf/behgDV2BrAuRpKUKlH7iCzk=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1683.namprd11.prod.outlook.com (10.173.27.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Sat, 22 Jun 2019 12:05:02 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e581:f807:acdc:cb36]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e581:f807:acdc:cb36%9]) with mapi id 15.20.1987.017; Sat, 22 Jun 2019
 12:05:02 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <geert+renesas@glider.be>, <marek.vasut@gmail.com>,
        <trivial@kernel.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH trivial] mtd: spi-nor: Spelling s/Writ/Write/
Thread-Topic: [PATCH trivial] mtd: spi-nor: Spelling s/Writ/Write/
Thread-Index: AQHVHSQzA/2vTv3S6Ui6+xkhVmuhlaanqyCA
Date:   Sat, 22 Jun 2019 12:05:01 +0000
Message-ID: <893ae99a-954c-cf80-3ec9-0d7360261ec7@microchip.com>
References: <20190607112848.14313-1-geert+renesas@glider.be>
In-Reply-To: <20190607112848.14313-1-geert+renesas@glider.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VE1PR03CA0009.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::21) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.127.138.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92960cf7-401a-4fb5-1d51-08d6f709da7a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1683;
x-ms-traffictypediagnostic: BN6PR11MB1683:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN6PR11MB16831737EAB02F565BC19F4AF0E60@BN6PR11MB1683.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-forefront-prvs: 0076F48C8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(136003)(39860400002)(366004)(346002)(376002)(199004)(189003)(76176011)(316002)(66446008)(81156014)(99286004)(81166006)(31686004)(256004)(14444005)(229853002)(5660300002)(4326008)(25786009)(52116002)(8676002)(110136005)(36756003)(54906003)(14454004)(6512007)(446003)(72206003)(102836004)(476003)(11346002)(2616005)(966005)(6246003)(6306002)(7736002)(68736007)(186003)(86362001)(71190400001)(71200400001)(53936002)(558084003)(6486002)(66946007)(26005)(66066001)(6436002)(31696002)(386003)(6506007)(53546011)(6116002)(73956011)(66476007)(8936002)(305945005)(64756008)(66556008)(3846002)(486006)(2906002)(478600001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1683;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5kNa5XOj47oSbKJAKnrGSVXOwiFSSxUkY4Gg721HwN5zmq0CUEiZWw5M6l6MT9UAMhBZZbDmU9xnhzbnybYfJqDninx8dBNWRTWQvXx4hoUybFsP4py2CLJ3GbLenKtZCMxt5K55zL1eaLPIOrLwctmby58d2FRCk5flM3XPAV6N0YXjbCn91m7ViYVID7QYhZHl69ayb35C7G3lA9W7iswfGf203uQIY0tblf42E5DRMN3vgXxTw8fN7TnW7Mkz16klJgtanC0G+ddof6ktbmXeuNztERcG0aoGN4zd8sDSrbi2tmOkVsMUtoztx5E4VwtOsHkBy/ncTGjBaFm0OyZywj/WXAiN7ICc6xdzdkQocHAKmwUbAjsmnxy9diCFFb7MdcVjdIwf0v9vc1G1ieoqX099egLTXdPIMaGycdk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7B105BC8B825B48BF5C763B5810DB60@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 92960cf7-401a-4fb5-1d51-08d6f709da7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2019 12:05:02.0223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1683
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA2LzA3LzIwMTkgMDI6MjggUE0sIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToNCj4g
U2lnbmVkLW9mZi1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5i
ZT4NCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDIgKy0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCg0KQXBwbGll
ZCB0byBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9tdGQv
bGludXguZ2l0LA0Kc3BpLW5vci9uZXh0IGJyYW5jaC4NCg0KVGhhbmtzLA0KdGENCg==
