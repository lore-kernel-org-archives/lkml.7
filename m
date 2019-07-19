Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8FDC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3EB21850
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="e8WP6alf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfGSKFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 06:05:53 -0400
Received: from mail-eopbgr40092.outbound.protection.outlook.com ([40.107.4.92]:10046
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726076AbfGSKFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 06:05:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZTkTnj5nNx1EsfZ/uQOq3+oBaCulmKXNxpHqg+WeWtDWKO6NOa3p3PIFtEs3J+ScUvAqfMMQAf6h3UK4F4z4z22z7sobBQoNy3ejv3kAFm6hr7xC3pUOako2VYzLMbrR2hy4fbbKanJyuXfkGst/VqHt856+0cHXV9Qtq696OFZ96QgMD/LViT6xPK0+uCQoiTLJ5YXdGJJXQl5KM/NEAWZVH5+4fyYrfoqeUcpPtEM3gR0hgYvvDXH4WIvUjnpxBsaJGP47yqZbk8HS9+XB4A+kR/wOMVUukGUBozDqW7ztMfJiFn3+KWKH4M91A5bA8MSNKBb8X5FX7ZmNHRGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJr6doRZWrVJKhh0YOf32RxCPdpRYy1yhrs/Mfctc1E=;
 b=Xns1zNmtgGivqkJEHrt3caD0T1kx81ZFxTHzIFH1t0kdcmK6O4Cbdoij86vgio7P2yG6W4xTLC1x/iH0oRlovgkO0mKe5ZTBTutNf3Mz3Kzdf/FV0P4BT1g6KF69RMCUCHL5aw1+0vt6hhCeDEi5Y2UXRYl48AwWVkV/O4/37KWY7uDMIrbGEO/W4pgyVI4r9h3CuX80SF//HO2ZJaa7Jq4kJtLBv9NzWCt560nc+CR5Zc+/o81QzIS+c6zAl7FNhsHsvsHIRZxHP4Bw2PYd/RdyyCpB989/7NcZLDQhO2/UQdO8OuyW7dds+QuSa5Ngzcovnb/2Y/aAmW4pjOBtfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJr6doRZWrVJKhh0YOf32RxCPdpRYy1yhrs/Mfctc1E=;
 b=e8WP6alfiA3KRR0b+eFuHHJ+ND5VrFpN8EdE3JWMl5kikUc3FLVnrrna2HdXCpFTD8iHgEOWJzQnR6Lh40h+rUEm4Sf/Nwnl98xdCdO41YG/gqcEfjLpdO2h6iYEShpCbg277QeWismqy7Arc2aExTVOUiIECeUdfmu/4aKmoKM=
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com (20.179.18.16) by
 AM6PR05MB5925.eurprd05.prod.outlook.com (20.179.0.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.14; Fri, 19 Jul 2019 10:05:33 +0000
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::c860:b386:22a:8ec9]) by AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::c860:b386:22a:8ec9%6]) with mapi id 15.20.2094.011; Fri, 19 Jul 2019
 10:05:33 +0000
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
Subject: [PATCH v6 3/6] ASoC: sgtl5000: Fix definition of VAG Ramp Control
Thread-Topic: [PATCH v6 3/6] ASoC: sgtl5000: Fix definition of VAG Ramp
 Control
Thread-Index: AQHVPhmAZZGJS53Ju0OkpFrsxpcqKQ==
Date:   Fri, 19 Jul 2019 10:05:33 +0000
Message-ID: <20190719100524.23300-4-oleksandr.suvorov@toradex.com>
References: <20190719100524.23300-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190719100524.23300-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR07CA0013.eurprd07.prod.outlook.com
 (2603:10a6:205:1::26) To AM6PR05MB6535.eurprd05.prod.outlook.com
 (2603:10a6:20b:71::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c4f3208-1d31-4a98-0c45-08d70c30a331
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR05MB5925;
x-ms-traffictypediagnostic: AM6PR05MB5925:
x-microsoft-antispam-prvs: <AM6PR05MB592533B97FED01D587F52027F9CB0@AM6PR05MB5925.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39840400004)(396003)(136003)(376002)(366004)(346002)(199004)(189003)(14454004)(68736007)(8676002)(50226002)(6486002)(8936002)(54906003)(305945005)(7736002)(71190400001)(71200400001)(6436002)(81156014)(186003)(99286004)(66476007)(66446008)(66556008)(64756008)(1411001)(81166006)(2906002)(476003)(36756003)(66946007)(446003)(14444005)(256004)(6512007)(86362001)(6916009)(26005)(478600001)(66066001)(11346002)(52116002)(53936002)(486006)(76176011)(2616005)(25786009)(1076003)(6506007)(4326008)(44832011)(3846002)(6116002)(316002)(5660300002)(102836004)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB5925;H:AM6PR05MB6535.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tvOaZXROgaj7xu10qufxXL7rmh4O/jmmMAa06oVHw6mLMjUiKdsM4LEQCSRrHw261JMTnBjrtZRCiKVoE9w5hnv1pMG57I4DDuFEfDCQFs2zfdgDbIZz3xNhdSf/IGS2xl464s8slGJDozxZFanr0kh5Cx9d5W+z50SEvJ1VYmgl+sMiduu+hgG7xziJH+M0Kng0AavVo8h4Do9vQLMhGAIG4PFiZldUX9TSZKf4YeWtrXAKrix+ZcMhURhIslibgZRGBATPJcqOgkkbb0BcJrmImJl/ZkVzR2WwllXjZmu4LkbZIyBHX4ZzHUXD77vuOEJgRuV20NSq5HqUYNl0Q1O4A1oSqT7wz4q+/LPmqlQxRVASJJHTfki7dDLYaI0wVAAC0gTOL4mCoQH8hq7UiWfCoa4myqHPcGk+KNVOzcM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4f3208-1d31-4a98-0c45-08d70c30a331
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 10:05:33.3557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oleksandr.suvorov@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5925
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

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
- Fix patch formatting

 sound/soc/codecs/sgtl5000.c | 2 +-
 sound/soc/codecs/sgtl5000.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 34cc85e49003..3f28e7862b5b 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1460,7 +1460,7 @@ static int sgtl5000_probe(struct snd_soc_component *c=
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
index 18cae08bbd3a..a4bf4bca95bf 100644
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

