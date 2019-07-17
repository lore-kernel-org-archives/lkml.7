Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86296C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FED2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="nTSftXk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfGQQbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 12:31:00 -0400
Received: from mail-eopbgr60133.outbound.protection.outlook.com ([40.107.6.133]:12419
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727368AbfGQQaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 12:30:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfUWOxiMah6hHVBClnLs8r/xvLJ0KKfts/nncIgxpRnDOIbtMezL8fZBTcnTwdgumoaJnBGE/pU0+PQ763NgG8/w7MNQCfs7i4yXLWNprPqZtjfz49x1zjRazQhdjcDfzOM6QHGJUykAzj25vNcDAJk0ony0j1Us2dgRkHrFtpszGcpQY1d3KDkHzXkd24nSg6ED8Eme8CtiVzjpdCte54A4c0sPg7MO/cqeeLQU7FeDZRlStvawPYGgvXNb8nR53ww1smheDsg+8K+RMlLlQ6vrD5MZHwcp/0OlfMl+trURNOcGYc9R2Stx6WNob6/3aJ2pObKqCvylq260Bo83lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIrw0DsoEBE/Kyv7xQZQW02YH1iJP6RtEkaPNFXINpY=;
 b=H5rq02AkQVSaPKDZvcSlpKUxdotRyWfkalfDJ1NKz42/FbHBA1UE8O2AVpzzUC8WbaMRVIHJhIHNCZYenXGln5nTFE5s564vxdyrVHq3pb08UdLZgttxuJq13AyXGoNMReKmzMeAegLSFUWR1ttITVluJscnuH1F/Mzdwb4V18uqRhPbVIe5aY9aqV+D5OF0VV8F7Jj4at+SPsmyOw//n74NScGKfiUD3lwBjvNxyr1zrL1CXWOGzAVAD8HbH1K5xQp+WwIqndYdu9krL2lD56yNHp7utxQ3Puxy1wu3hSUDwrhjAin7c/h5y8IZtLn6fVIBnUJY9AoYjJY+wpwZgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIrw0DsoEBE/Kyv7xQZQW02YH1iJP6RtEkaPNFXINpY=;
 b=nTSftXk0G2vplLUCa+WUvw2bilnfqburZw3fhr3Jv36vMZI0Lea3g6f/HST2HYVJKwUpxlevWVD8wn083ZT9Jb8/uAez7BxUSpBUXQATvO91Haludo4zuVUApzmh6FaaWjVRGyH572xGIjO0c4Pcrrstrb9Q38PCgCpwo1TN9D4=
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com (20.179.18.16) by
 AM6PR05MB4455.eurprd05.prod.outlook.com (52.135.162.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.11; Wed, 17 Jul 2019 16:30:53 +0000
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::c860:b386:22a:8ec9]) by AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::c860:b386:22a:8ec9%6]) with mapi id 15.20.2094.011; Wed, 17 Jul 2019
 16:30:53 +0000
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
Subject: [PATCH v4 5/6] ASoC: sgtl5000: Fix of unmute outputs on probe
Thread-Topic: [PATCH v4 5/6] ASoC: sgtl5000: Fix of unmute outputs on probe
Thread-Index: AQHVPL0APvMXuyYKqEmMI8DZ4RRwwA==
Date:   Wed, 17 Jul 2019 16:30:53 +0000
Message-ID: <20190717163014.429-6-oleksandr.suvorov@toradex.com>
References: <20190717163014.429-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190717163014.429-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0202CA0006.eurprd02.prod.outlook.com
 (2603:10a6:200:89::16) To AM6PR05MB6535.eurprd05.prod.outlook.com
 (2603:10a6:20b:71::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d173b83-7225-47c7-15bd-08d70ad422d3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR05MB4455;
x-ms-traffictypediagnostic: AM6PR05MB4455:
x-microsoft-antispam-prvs: <AM6PR05MB4455514BE87F70FEF72630C2F9C90@AM6PR05MB4455.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(396003)(39850400004)(376002)(366004)(189003)(199004)(7736002)(4326008)(6916009)(478600001)(66556008)(66476007)(66446008)(81166006)(5660300002)(50226002)(305945005)(66946007)(71190400001)(64756008)(66066001)(71200400001)(1076003)(8936002)(2616005)(6436002)(81156014)(256004)(476003)(2906002)(8676002)(446003)(11346002)(14444005)(3846002)(52116002)(53936002)(44832011)(186003)(486006)(99286004)(102836004)(6506007)(386003)(76176011)(1411001)(26005)(68736007)(36756003)(86362001)(14454004)(25786009)(316002)(6512007)(54906003)(6486002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB4455;H:AM6PR05MB6535.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7XK7MH4SDC+j5Kn9t5ZIPzC0te5xwJZ+t6EprXqbDcL8FwKbWt9bSXbwraCHS7ghY9wqOkalyIkHY0/+3OMgYjdcVkmZPIHy3HBdqXAXeJVrlrWe2UWfZqg2CGNb4Bpu0PA3R2F8QnLfJJbK63C1wE5NmmgZM5n3PAqPe3EYKw80fclL8krpIXACnHMGrWSi3pb/gzate0kF20I2bDx8IV0L7VlyAmvZ0X3a4LapWLXhyfXdPYaXe6lU13Ii02XBbr0BfttrVNuvb65Ye23Dve5IrzsesG48PjG/wKci3AOCbY9Si1tg4H1e2N4ppLpUgsP04nsWZ1iq38VEHAAvXduMEgScw7bw1sBx/gQc1n9429vIwsRNwMhF+5PXbgFH1VHbytokdfDLF0mzePS/tKwFSEUsMXGiDTq+k60XDLk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d173b83-7225-47c7-15bd-08d70ad422d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 16:30:53.0747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oleksandr.suvorov@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4455
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

---

Changes in v4: None
Changes in v3: None
Changes in v2:
- Fix patch formatting

 sound/soc/codecs/sgtl5000.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 0123d9cfcb473..31d546abde717 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1443,6 +1443,7 @@ static int sgtl5000_probe(struct snd_soc_component *c=
omponent)
 	int ret;
 	u16 reg;
 	struct sgtl5000_priv *sgtl5000 =3D snd_soc_component_get_drvdata(componen=
t);
+	unsigned int zcd_mask =3D SGTL5000_HP_ZCD_EN | SGTL5000_ADC_ZCD_EN;
=20
 	/* power up sgtl5000 */
 	ret =3D sgtl5000_set_power_regs(component);
@@ -1470,9 +1471,8 @@ static int sgtl5000_probe(struct snd_soc_component *c=
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

