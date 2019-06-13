Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8F0C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F5F206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="bVLGy5i+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387738AbfFMPhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:37:39 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:42046 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbfFMPhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:37:31 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,369,1557212400"; 
   d="scan'208";a="34303746"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2019 08:37:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex01.mchp-main.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 13 Jun 2019 08:37:09 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 13 Jun 2019 08:37:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jTwSK+Ec5teQ0EnGS5ktoWxmIj9nN0/cSWrt/acqvk=;
 b=bVLGy5i+yV3U8mkko5/MisEQsdj0jWtWtspz/ana5OllV1l/NTGFgRTJquX6JIEP76bVbFoB4xyNUzLoyp+0Ay7I11LAvdNY5Bwp9RUkHITbd5qS1Y3KdwTqZM9Xz7RL5mizY5XwGXq9hHLghd3Wr20WwtDDXn+RzJkgqoTQwNI=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1822.namprd11.prod.outlook.com (10.175.54.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 13 Jun 2019 15:37:06 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::316b:7774:8db6:30ec]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::316b:7774:8db6:30ec%7]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 15:37:06 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <claudiu.beznea@gmail.com>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH 0/7] clk: at91: sckc: improve error path
Thread-Topic: [PATCH 0/7] clk: at91: sckc: improve error path
Thread-Index: AQHVIf3bUSmswP0Le0qxy3Tkv6UCZA==
Date:   Thu, 13 Jun 2019 15:37:06 +0000
Message-ID: <1560440205-4604-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0174.eurprd09.prod.outlook.com
 (2603:10a6:800:120::28) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e7e0e79-43b3-438a-64c5-08d6f014fd68
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR11MB1822;
x-ms-traffictypediagnostic: MWHPR11MB1822:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR11MB1822EBEB043474AA667130F487EF0@MWHPR11MB1822.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(39860400002)(396003)(189003)(199004)(14454004)(478600001)(110136005)(54906003)(256004)(68736007)(966005)(2906002)(72206003)(316002)(71200400001)(71190400001)(2501003)(36756003)(50226002)(4326008)(107886003)(25786009)(6306002)(6512007)(8676002)(8936002)(81156014)(2616005)(476003)(6436002)(6486002)(81166006)(5660300002)(66066001)(99286004)(305945005)(4744005)(53936002)(7736002)(52116002)(66946007)(3846002)(6116002)(86362001)(486006)(66446008)(66556008)(186003)(26005)(6506007)(73956011)(386003)(102836004)(64756008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1822;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FIHGhxA0oYEEU6JGJOaexUk+OwwXBexZyKjZV41/JuVfmYkTO5PZUPkgGfm9NiD9t3aAGCF1ju4Z7Fd2IXmGsuCod7gLVia/Wg9526KOb77S2TujEGYq+Zz7PIxjGTQaf5iWGFx4zvjN9Dz6kQ+bTqrtMFBWPWXrnXWf4Ik4kXGBGgUCvu1AU16YDpr954p+ie+VMmaC8XfdSd/sahHMRdJACnslxdML0HZbRzqcuJV8xllU5gitwOYuwQm2gO/8CeIk90B4MR9SCqDGEh+ARm7iTUCqmxOPWtwnXwM4Xudly9pMZsibn8CF181pSbHB5YcmYGoQ4CzPeJfkocaXZqXvartMfsD5ps46m+tms3iTXtNshOOP/chSz+2YqsQIBoUewOlFmU9dnEfDunGvp4KcRr8o0GrVsbtMxBOiSW8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7e0e79-43b3-438a-64c5-08d6f014fd68
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 15:37:06.5246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: claudiu.beznea@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCkhp
LA0KDQpUaGlzIHNlcmllcyB0cmllcyB0byBpbXByb3ZlIGVycm9yIHBhdGggZm9yIHNsb3cgY2xv
Y2sgcmVnaXN0cmF0aW9ucw0KYnkgYWRkaW5nIGZ1bmN0aW9ucyB0byBmcmVlIHJlc291cmNlcyBh
bmQgdXNpbmcgdGhlbSBvbiBmYWlsdXJlcy4NCg0KSXQgaXMgY3JlYXRlZCBvbiB0b3Agb2YgcGF0
Y2ggc2VyaWVzIGF0IFsxXS4NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0KWzFdIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMTU1ODQzMzQ1NC0yNzk3MS0xLWdpdC1zZW5kLWVt
YWlsLWNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20vDQoNCkNsYXVkaXUgQmV6bmVhICg3KToN
CiAgY2xrOiBhdDkxOiBzY2tjOiBhZGQgc3VwcG9ydCB0byBmcmVlIHNsb3cgb3NjaWxsYXRvcg0K
ICBjbGs6IGF0OTE6IHNja2M6IGFkZCBzdXBwb3J0IHRvIGZyZWUgc2xvdyByYyBvc2NpbGxhdG9y
DQogIGNsazogYXQ5MTogc2NrYzogYWRkIHN1cHBvcnQgdG8gZnJlZSBzbG93IGNsb2NrIG9zY2xp
bGxhdG9yDQogIGNsazogYXQ5MTogc2NrYzogaW1wcm92ZSBlcnJvciBwYXRoIGZvciBzYW05eDUg
c2NrIHJlZ2lzdGVyDQogIGNsazogYXQ5MTogc2NrYzogcmVtb3ZlIHVubmVjZXNzYXJ5IGxpbmUN
CiAgY2xrOiBhdDkxOiBzY2tjOiBpbXByb3ZlIGVycm9yIHBhdGggZm9yIHNhbWE1ZDQgc2NrIHJl
Z2lzdHJhdGlvbg0KICBjbGs6IGF0OTE6IHNja2M6IHVzZSBkZWRpY2F0ZWQgZnVuY3Rpb25zIHRv
IHVucmVnaXN0ZXIgY2xvY2sNCg0KIGRyaXZlcnMvY2xrL2F0OTEvc2NrYy5jIHwgMTIyICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFu
Z2VkLCA4NiBpbnNlcnRpb25zKCspLCAzNiBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjcuNA0KDQo=
