Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50285C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDDB2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="XzryjYEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfGSKFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 06:05:44 -0400
Received: from mail-eopbgr40092.outbound.protection.outlook.com ([40.107.4.92]:10046
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfGSKFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 06:05:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZZb5ntHBuxbcrDbFqQrWPXZ+2WcQPXQB7s3SlbvHzt8/Mug+f9wa98yYOoQY+gJjhAez0RUrG5p3WzP/Fu1o2QIxuJoIZnxNsSVhaRq7W/iVZU2ix6iO2viJs4ET11wyRi3p1I2YvQQBMM/2OOwJVcAo7CBPKnozJfWyNCUIoDGpR6bGHtYHI/AKx3GYiv8zAQyKjNGT+xRsq8Dc0ndqBmSI+h4KMri/GzWSBzNFFu9OyE7LrAgLNd5Vz1xqiuWu4ly+5MD7JCkHL/6fcYgXgXbWatDaDATXcdlXejVFx3QwSaIU7yDk61ttP5eeuPbV65iLuUBhgifpdwTjQW99A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTq697b8pNY7VmSbc1Y0KPdxRSinFvfyYF/Yw8olZyc=;
 b=AE3jrfMi/5TsVYQ/f/BZIcerjnw7ySlFZIPdb7PWLwW0PU1/Ayxzl3gY+2H71ceZfBO1MwAV6M1fV8zo31JdDDhAr60pSo5Rz2+pai2ZpaMsF64XYDnBrPyAPNRdOLJt8BJGnQe2PppE3Lup4tdNVBrYfhhTpOeYMfyN6qvd2LNDfOGrmaRpgdkPBlLJb4Jzjx71L36CU6ilnSTqc8M/huebs0C2gu/YilneeE/IfUlhmquULAnPJI9KYqMwuJNQh8VXRBFtzrdIWStVp65mGLIVp7mhJVvPX1oNenodNWgyQrmvcLxYf9zYlIVooiqdAS7yGJKRa6zmCbbDYZCNTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTq697b8pNY7VmSbc1Y0KPdxRSinFvfyYF/Yw8olZyc=;
 b=XzryjYEuK0NQf8ddJkax1js6gog/om9qn4lI1X6/ADDvQxMxiMuZUEMPu/ClzJ5QFTEaIRPXitT43hWx+2CbyS07YP689nR+e8JCo85n87YVAzieFXb6LaESHDz786+eh7wAFYGIkNdEzr42RJVUX/wpWsOGu0vfGnnF+CrWIS4=
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com (20.179.18.16) by
 AM6PR05MB5925.eurprd05.prod.outlook.com (20.179.0.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.14; Fri, 19 Jul 2019 10:05:36 +0000
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::c860:b386:22a:8ec9]) by AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::c860:b386:22a:8ec9%6]) with mapi id 15.20.2094.011; Fri, 19 Jul 2019
 10:05:36 +0000
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
Subject: [PATCH v6 5/6] ASoC: sgtl5000: Fix of unmute outputs on probe
Thread-Topic: [PATCH v6 5/6] ASoC: sgtl5000: Fix of unmute outputs on probe
Thread-Index: AQHVPhmCYUymm5JNk0a5eEu3cWiMyg==
Date:   Fri, 19 Jul 2019 10:05:35 +0000
Message-ID: <20190719100524.23300-6-oleksandr.suvorov@toradex.com>
References: <20190719100524.23300-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190719100524.23300-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR07CA0001.eurprd07.prod.outlook.com
 (2603:10a6:205:1::14) To AM6PR05MB6535.eurprd05.prod.outlook.com
 (2603:10a6:20b:71::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad4ff82d-0965-4e76-b23c-08d70c30a4c6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR05MB5925;
x-ms-traffictypediagnostic: AM6PR05MB5925:
x-microsoft-antispam-prvs: <AM6PR05MB592549FC3E072E4A26D9BE8DF9CB0@AM6PR05MB5925.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39840400004)(396003)(136003)(376002)(366004)(346002)(199004)(189003)(14454004)(68736007)(8676002)(50226002)(6486002)(8936002)(54906003)(305945005)(7736002)(71190400001)(71200400001)(6436002)(81156014)(186003)(99286004)(66476007)(66446008)(66556008)(64756008)(1411001)(81166006)(2906002)(476003)(36756003)(66946007)(446003)(14444005)(256004)(6512007)(86362001)(6916009)(26005)(478600001)(66066001)(11346002)(52116002)(53936002)(486006)(76176011)(2616005)(25786009)(1076003)(6506007)(4326008)(44832011)(3846002)(6116002)(316002)(5660300002)(102836004)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB5925;H:AM6PR05MB6535.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Dv0083ngfx9lnpMcs/jYYvqTtsTV+KhRWfrJfvkRcTUSw7UdXZFTO1Q6SKO3rCJkRb/c4JXMBvbRrYWGxA7wfjwafgTJiLL6bic5DzCsbEVMSgIEPCfCw7mr7ImP+tkM740Y9PD9rsoCYCBdK7YdD2WxHNhiF9Ynb4ka1R/5ghT13MX+CJMMYcynCLAOqhp0bBd1ofLWe6zfyuFf0SOU2cMgYOdTrBcdkuEj2CyODn18jXeQzoAYmZrLqW7YKa2EFz0n5u9SrOaU9LlxKzjQivv92rC8cgbv1hMooheDJdZNWy0d6azGSUqt60QIGXACowOelOed1IhbTRlpQVuF5FNu0mr0ifX0x4vNJW3BepFqgKqiLsrun6yuF3nLwgv76aE2JlfLIPqVpDUFf5EQGYoDnwRwGNwPmyD20z+F2NY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4ff82d-0965-4e76-b23c-08d70c30a4c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 10:05:35.9852
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

To enable "zero cross detect" for ADC/HP, change
HP_ZCD_EN/ADC_ZCD_EN bits only instead of writing the whole
CHIP_ANA_CTRL register.

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

 sound/soc/codecs/sgtl5000.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index b65232521ea8..23f4ae2f0723 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1453,6 +1453,7 @@ static int sgtl5000_probe(struct snd_soc_component *c=
omponent)
 	int ret;
 	u16 reg;
 	struct sgtl5000_priv *sgtl5000 =3D snd_soc_component_get_drvdata(componen=
t);
+	unsigned int zcd_mask =3D SGTL5000_HP_ZCD_EN | SGTL5000_ADC_ZCD_EN;
=20
 	/* power up sgtl5000 */
 	ret =3D sgtl5000_set_power_regs(component);
@@ -1480,9 +1481,8 @@ static int sgtl5000_probe(struct snd_soc_component *c=
omponent)
 	       0x1f);
 	snd_soc_component_write(component, SGTL5000_CHIP_PAD_STRENGTH, reg);
=20
-	snd_soc_component_write(component, SGTL5000_CHIP_ANA_CTRL,
-			SGTL5000_HP_ZCD_EN |
-			SGTL5000_ADC_ZCD_EN);
+	snd_soc_component_update_bits(component, SGTL5000_CHIP_ANA_CTRL,
+		zcd_mask, zcd_mask);
=20
 	snd_soc_component_update_bits(component, SGTL5000_CHIP_MIC_CTRL,
 			SGTL5000_BIAS_R_MASK,
--=20
2.20.1

