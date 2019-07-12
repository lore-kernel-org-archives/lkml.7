Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF23CC742BD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A95C2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="DnMIeFKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfGLO4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 10:56:03 -0400
Received: from mail-eopbgr00131.outbound.protection.outlook.com ([40.107.0.131]:39750
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726724AbfGLO4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 10:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTJ4tx4re0CD+61B+eAB9qljlN6sxw1DTjp4EyOJfXE=;
 b=DnMIeFKacNMegcAGTZizagANDKGx/5WlTe/VMtGSBx1F3aQMbk02GstSkYhA0DER3CwIeyOm6sxSVHW1o4bmV31Qh02XJ5xFol+nwj9ye3OX8mnuubpa0ScIdzWGR8pShs3QBFLrKQ1FrLVs5376disH00DId4o5qKsRvsKeuJA=
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com (20.179.18.16) by
 AM6PR05MB5508.eurprd05.prod.outlook.com (20.177.119.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.20; Fri, 12 Jul 2019 14:55:59 +0000
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::c860:b386:22a:8ec9]) by AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::c860:b386:22a:8ec9%6]) with mapi id 15.20.2073.008; Fri, 12 Jul 2019
 14:55:59 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v3 0/6] VAG power control improvement for sgtl5000 codec
Thread-Topic: [PATCH v3 0/6] VAG power control improvement for sgtl5000 codec
Thread-Index: AQHVOMHqURHnTs/AN0OjdnZhj0q7OQ==
Date:   Fri, 12 Jul 2019 14:55:58 +0000
Message-ID: <20190712145550.27500-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR08CA0072.eurprd08.prod.outlook.com
 (2603:10a6:205:2::43) To AM6PR05MB6535.eurprd05.prod.outlook.com
 (2603:10a6:20b:71::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc635a77-aa64-4002-958a-08d706d90cbd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR05MB5508;
x-ms-traffictypediagnostic: AM6PR05MB5508:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR05MB550851E1DD04BE4BD50783ECF9F20@AM6PR05MB5508.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:236;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39850400004)(376002)(346002)(396003)(136003)(199004)(189003)(102836004)(186003)(66476007)(52116002)(305945005)(26005)(66946007)(64756008)(66446008)(6506007)(5660300002)(6436002)(86362001)(478600001)(1411001)(66556008)(53936002)(8676002)(386003)(7736002)(316002)(66066001)(1076003)(6916009)(54906003)(99286004)(50226002)(14454004)(36756003)(71200400001)(71190400001)(68736007)(6116002)(3846002)(486006)(6512007)(2616005)(6486002)(6306002)(2906002)(966005)(44832011)(8936002)(81166006)(81156014)(4326008)(476003)(256004)(14444005)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB5508;H:AM6PR05MB6535.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GFRzV/FWBAUwDvHIWPT8YIqfvVDhqj1jKs68oJR0Yi0wJ04LfYg7p1P/Vw3Il/C69rBW7luNQSnhuicJJdARcJWmb7NMeR4MsOe8XY+09lOzxv0IuOifeI2u+npxvo0I6749z16dg9oEkm7KjAKu3q9AFfeyohTm1BSz1LHXuK08sar7NIcI7FjzmpU2PxIohsOalGzEBOm8UnugQy8ZTeiwvV4dbz+pR0Ye0jYdGH0NnkDf+OgRhxNSixwFJxD5n8GCU/wVoRg9xZZJXe8X6bEIhQAmdCv26sj04OxdCJcLMVw5GAqa5Pn9CeWylmjp3YoLWrHPutB5QSmyuCme0f4a5iYQJW3L55mvRUK3aGH6e0htAQE7wafytVmpTQzVBmA8wG3EBg5xje/s0k4XOiwqSxjhjCsRGQgk/1B5n4o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc635a77-aa64-4002-958a-08d706d90cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 14:55:58.9344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oleksandr.suvorov@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5508
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


VAG power control is improved to fit the manual [1]. This patchset fixes as
minimum one bug: if customer muxes Headphone to Line-In right after boot,
the VAG power remains off that leads to poor sound quality from line-in.

I.e. after boot:
- Connect sound source to Line-In jack;
- Connect headphone to HP jack;
- Run following commands:
$ amixer set 'Headphone' 80%
$ amixer set 'Headphone Mux' LINE_IN

Also this series includes fixes of non-important bugs in sgtl5000 codec
driver.

[1] https://www.nxp.com/docs/en/data-sheet/SGTL5000.pdf

Changes in v3:
- Add the reference to NXP SGTL5000 data sheet to commit message
- Fix multi-line comment format
- Add the reference to NXP SGTL5000 data sheet to commit message

Changes in v2:
- Fix patch formatting
- Fix patch formatting
- Fix patch formatting
- Fix patch formatting
- Fix patch formatting
- Fix patch formatting

Oleksandr Suvorov (6):
  ASoC: sgtl5000: Fix definition of VAG Ramp Control
  ASoC: sgtl5000: add ADC mute control
  ASoC: sgtl5000: Fix of unmute outputs on probe
  ASoC: sgtl5000: Fix charge pump source assignment
  ASoC: Define a set of DAPM pre/post-up events
  ASoC: sgtl5000: Improve VAG power and mute control

 include/sound/soc-dapm.h    |   2 +
 sound/soc/codecs/sgtl5000.c | 251 ++++++++++++++++++++++++++++++------
 sound/soc/codecs/sgtl5000.h |   2 +-
 3 files changed, 213 insertions(+), 42 deletions(-)

--=20
2.20.1

