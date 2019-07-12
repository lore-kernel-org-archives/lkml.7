Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2303C742BD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F222084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="tZhiYHr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfGLO4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 10:56:07 -0400
Received: from mail-eopbgr00131.outbound.protection.outlook.com ([40.107.0.131]:39750
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726976AbfGLO4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 10:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VHr78KOKN/d4cfMQWesczqQ/LUFN692kmJ0UbAL+Sc=;
 b=tZhiYHr6xz0SGXhDlYHq8njURzBtFgmxSrGhssAWDd8NA+uAKYxdsmGvewzMWhjuF3XZtRB8+3DfpGYvEsRIvNsdd2h3IYu94lzG9xvo0CUh3Yq5NcTSYqRbSTKoyi57nBfIpEBmpkUrQhMCRkAXmZiBLiUS56knbEynxSGjujo=
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com (20.179.18.16) by
 AM6PR05MB5508.eurprd05.prod.outlook.com (20.177.119.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.20; Fri, 12 Jul 2019 14:56:00 +0000
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::c860:b386:22a:8ec9]) by AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::c860:b386:22a:8ec9%6]) with mapi id 15.20.2073.008; Fri, 12 Jul 2019
 14:56:00 +0000
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
Subject: [PATCH v3 1/6] ASoC: sgtl5000: Fix definition of VAG Ramp Control
Thread-Topic: [PATCH v3 1/6] ASoC: sgtl5000: Fix definition of VAG Ramp
 Control
Thread-Index: AQHVOMHrINaeLGEi802AIHxHUxVJuw==
Date:   Fri, 12 Jul 2019 14:56:00 +0000
Message-ID: <20190712145550.27500-2-oleksandr.suvorov@toradex.com>
References: <20190712145550.27500-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190712145550.27500-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::25) To AM6PR05MB6535.eurprd05.prod.outlook.com
 (2603:10a6:20b:71::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 252d44f8-a933-48b1-ca67-08d706d90dab
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR05MB5508;
x-ms-traffictypediagnostic: AM6PR05MB5508:
x-microsoft-antispam-prvs: <AM6PR05MB55087E587898E5FB316AC4BFF9F20@AM6PR05MB5508.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39850400004)(376002)(346002)(396003)(136003)(199004)(189003)(102836004)(186003)(66476007)(52116002)(305945005)(26005)(66946007)(64756008)(66446008)(6506007)(5660300002)(6436002)(86362001)(478600001)(1411001)(66556008)(53936002)(8676002)(386003)(7736002)(316002)(76176011)(66066001)(1076003)(6916009)(54906003)(99286004)(50226002)(14454004)(36756003)(71200400001)(71190400001)(68736007)(6116002)(3846002)(486006)(6512007)(2616005)(6486002)(2906002)(44832011)(11346002)(446003)(8936002)(81166006)(81156014)(4326008)(476003)(256004)(14444005)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB5508;H:AM6PR05MB6535.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6rpgwWETLl7tfUU4AU6dzYSJs/rjxNtmlNpEi10/wPhzI+8cX4VakXTA5jw6avrX1s6BrnGc3OPSuGpELIWZ71Nfi075ZaaCT2NV2iGsBXoIIhLCbVd9LcKTQ4Gd1kBzPVXGAJ3oGj2wlYLwVP0BehcrK+OK5ivkQJFcOK9SLJLILR2q5sxpIjIrOXRMgmrlFpx7CdwG9jj+KCAhH5k82EqUAGs2B6CHWRQ8JDO61fxhRSeST35tI3qrlt3a4rDjqvt6MZn6Y+kdJdO6BTKKaLB3pNEvWpm9BBpfJunTvCThYWOOFUG4I8DAtBRnghGHq/QpPd+vhHMjCG/Y6GZbwVYJ7xJ7gHJB24wTN62wpTDMSK/JDwDlpKypCREs1aSU/hxx6qbUsPk5j12NSZkjoHK97MjRBEp/0D2PRUgikjY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252d44f8-a933-48b1-ca67-08d706d90dab
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 14:56:00.4456
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

SGTL5000_SMALL_POP is a bit mask, not a value. Usage of
correct definition makes device probing code more clear.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@toradex.com>

---

Changes in v3: None
Changes in v2:
- Fix patch formatting

 sound/soc/codecs/sgtl5000.c | 2 +-
 sound/soc/codecs/sgtl5000.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index a6a4748c97f9d..5e49523ee0b67 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1296,7 +1296,7 @@ static int sgtl5000_probe(struct snd_soc_component *c=
omponent)
=20
 	/* enable small pop, introduce 400ms delay in turning off */
 	snd_soc_component_update_bits(component, SGTL5000_CHIP_REF_CTRL,
-				SGTL5000_SMALL_POP, 1);
+				SGTL5000_SMALL_POP, SGTL5000_SMALL_POP);
=20
 	/* disable short cut detector */
 	snd_soc_component_write(component, SGTL5000_CHIP_SHORT_CTRL, 0);
diff --git a/sound/soc/codecs/sgtl5000.h b/sound/soc/codecs/sgtl5000.h
index 18cae08bbd3a6..a4bf4bca95bf7 100644
--- a/sound/soc/codecs/sgtl5000.h
+++ b/sound/soc/codecs/sgtl5000.h
@@ -273,7 +273,7 @@
 #define SGTL5000_BIAS_CTRL_MASK			0x000e
 #define SGTL5000_BIAS_CTRL_SHIFT		1
 #define SGTL5000_BIAS_CTRL_WIDTH		3
-#define SGTL5000_SMALL_POP			1
+#define SGTL5000_SMALL_POP			0x0001
=20
 /*
  * SGTL5000_CHIP_MIC_CTRL
--=20
2.20.1

