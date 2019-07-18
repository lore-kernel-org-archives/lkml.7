Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25C6C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7DA21783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="f3W/puXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389686AbfGRJC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 05:02:57 -0400
Received: from mail-eopbgr150109.outbound.protection.outlook.com ([40.107.15.109]:61477
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727633AbfGRJC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:02:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lw5Ydb9hTIusn9jzjav3CYJXkGQfte92NHVhVoSuLFmJ4O3OVC6Lkk60pG8JQGSbiS3z7NkteClfHDEJHRIpP7Q74VmfXa1TiAaSmQ5V8nvuiNGCTyRW0xR63CHbJUcDgNLUzTmLAf7hT2A9s74Otx9HnwEp4w6kX8I5AVPtmT6LcrDPJQqlQQU10qYTshkcMQ0t2ej18U2Gf5wPLk7Yv6TTnXZm8EE6HiMb1RQIvD19YqSpzZ3DuXJY0vd8Hku/lQcdsXwLg/eSDDDAW4uCW256v/gcUgqIE44FsT/OZFAeJQpL5zOw5LQYmo2bSh8xmGMPhzfvdkYmHFawNGIdLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KENG8EsMsbygLILn6kmKiGP20I0vqpVPRW9K7S5YINc=;
 b=Lb+aBs7pZo3gDvr3NXVnnahm3BDxDAC/gLwrkSjsvOFUd5HdnkCtySb6D5QHXr/X1XlPmY04/XmKRPplM/yzRsmCnNPbjwkHCUtdbPmdBpqSHQk8Cq40tQX/EM+9YW/zoxZIrglZA9mBX4sYsQ0o/srvTaQvYFK7rufEbEJTv+Yi3udns6whpBQVZESNn0RZq+rdIhuxt24N5YBZNMo8xQgm5hikfehgJiTsuXvJKk6/DsRSeuk4zzUqgsfY1pINiJ+a3umkCQueo4r/j05H5TWn+LgvQOLCqD5jjgpWc4DRj6nsoHO5EV7qd4BfPYbFsjO9RghGrEASUj8tZ9zEOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KENG8EsMsbygLILn6kmKiGP20I0vqpVPRW9K7S5YINc=;
 b=f3W/puXc6OUJpl84Lz98+KP9rmDAXJ6QzfLE1rAiPWx4HppQBQTUprCujpmg/i7kb94komGELDQoKyKQXDuoP8/aURxgixRCSkgDGoz72LXnpMMcnZQVwG9CIEvMDY/dZuob2s/Fdyd4vKglN4bk86+j43oZ/kPSl4qYCkFPY+0=
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com (20.179.18.16) by
 AM6PR05MB5013.eurprd05.prod.outlook.com (20.177.35.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.12; Thu, 18 Jul 2019 09:02:49 +0000
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::c860:b386:22a:8ec9]) by AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::c860:b386:22a:8ec9%6]) with mapi id 15.20.2094.011; Thu, 18 Jul 2019
 09:02:49 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v5 3/6] ASoC: sgtl5000: Fix definition of VAG Ramp Control
Thread-Topic: [PATCH v5 3/6] ASoC: sgtl5000: Fix definition of VAG Ramp
 Control
Thread-Index: AQHVPUeSMC+aACEaGUiWMvIQp2qocw==
Date:   Thu, 18 Jul 2019 09:02:49 +0000
Message-ID: <20190718090240.18432-4-oleksandr.suvorov@toradex.com>
References: <20190718090240.18432-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190718090240.18432-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR04CA0139.eurprd04.prod.outlook.com (2603:10a6:207::23)
 To AM6PR05MB6535.eurprd05.prod.outlook.com (2603:10a6:20b:71::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b6bc69d-304c-4eb0-948b-08d70b5eb520
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR05MB5013;
x-ms-traffictypediagnostic: AM6PR05MB5013:
x-microsoft-antispam-prvs: <AM6PR05MB5013048507F9FAFEACB372A9F9C80@AM6PR05MB5013.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(346002)(366004)(376002)(396003)(136003)(199004)(189003)(2616005)(99286004)(68736007)(476003)(446003)(50226002)(11346002)(486006)(86362001)(8936002)(81166006)(76176011)(81156014)(26005)(14454004)(4326008)(186003)(386003)(6506007)(316002)(102836004)(6916009)(54906003)(52116002)(36756003)(6486002)(6436002)(71190400001)(71200400001)(6512007)(25786009)(14444005)(66066001)(256004)(66946007)(64756008)(66476007)(66556008)(66446008)(1076003)(1411001)(5660300002)(8676002)(478600001)(7736002)(44832011)(6116002)(3846002)(305945005)(53936002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB5013;H:AM6PR05MB6535.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IC+hQCehtd+T9XcUNZfEE+IHJ5zkurSvijpuwOe7YL+d4F1k+SxGGa7JCBVGelBaasX3GuJFc2MCJ4M+VrmT74mNLtpPYvCW2wqsQh/ubgKp9bRYjQTfMJiZTc/ki9OUbSkM3wxzFpkLNTsbD8YJmkDu3S9eQ2jsRsXrdRy6unXz35Bfz+kaQ76IbZ7TZxp492UsUd2v9sKsIYDkU7rAxBt+9xFBpv8oUjRo/t60FPObi8nHyh9NCGucN+ZGuBOo6ecEmtE2qKFIjvyrXlBxggXqUaOsratqpYpC/aKkQX25uWy6OUL5bocW3ybK/vC5inVdz1qMENCqs69untCnNmAEXWBcxw3XvbI2pQwFXvd8jWOZWtP1o0zvxCFZx13XsWqC9Po+hvPMpa1P6XaZaHyrtT+JqBiZaJ7uHcli5qU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6bc69d-304c-4eb0-948b-08d70b5eb520
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 09:02:49.0946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oleksandr.suvorov@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGTL5000_SMALL_POP is a bit mask, not a value. Usage of
correct definition makes device probing code more clear.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@toradex.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>

---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
- Fix patch formatting

 sound/soc/codecs/sgtl5000.c | 2 +-
 sound/soc/codecs/sgtl5000.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index a2aeb5fb9b537..a8d55c21a5f2d 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1450,7 +1450,7 @@ static int sgtl5000_probe(struct snd_soc_component *c=
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

