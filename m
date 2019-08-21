Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B71C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D65B22DD6
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MttwzOO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfHUDVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 23:21:14 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:37700
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726898AbfHUDVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 23:21:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaEtFRSpYrJdGHlAehSWVhtvPtl0NkuS1t07Ol/+yM+xr+Nf+A21zYMN7l8YGEEbfmYkrv6dbtnM/y6slA7yPIhDjK04SfUXrxwBfCjBu7zQVuIlPHnL47UtJm3/0Mf/UmrsZMaUV2JU4HWTwlEDiT4kplc56z/suSKwCngrw3OhRvNxc1eFfbdChRVDkgxHIHyxtTJpiTwitleJRmmKqAjFeDnVmpx6yLEJ9Two4ZEfwQxZdCYu5NAgZf73bOb8dJpbum/iO+NYeUMx9CuTzF8oODBUXZIfk519Nxv9udnD8yCMWTC0Y+MFAmnZi1yE92kcd//uYMaFJembTN4dJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmn6MUHjKOeZEAvYJUjw326oX9mQ+bzeUcfEbsy/rdY=;
 b=gRIc3J75ZN3klAEGFi32YnGZtPfQvRR+iOExQkTtxwQ/dLBKPgCdO0o8vCeec0fJroxoJkhNTom4T7FIKxhvCXyBjsBCrg4BTSCYBxcRC94as0Pdgo/GQq6virN5/CiwdveDEJNdaIKo+SUSgJjnlPjiGqEHMXJgNE0Nad9kCdOBK3kxeVaDQC16d9PT5ZJUfTo0qWmyqcpDjtfYYBGmgSGNruHYhp1EvxRg+holPwxaP7rl8ko25s3iUiVq1Ze68NoWLKXONv4RcPht2l8w2P+clGKsQzL74A3Z2PXLyAwiU39lOFsGOUygc+vdAbqey9eU5cQ46hL2lXx6avr/xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmn6MUHjKOeZEAvYJUjw326oX9mQ+bzeUcfEbsy/rdY=;
 b=MttwzOO++MRgWrfxwQ7di+MGl9hrCiGKvxhBlz4jMFPMKv8FgLhYGp17hd5hLNd/j1l39qVnd+cwwVdzffQLbCCk1V1E7SBLzhJFY+oMA+GzHxBLL/j12oQz6BJcNMLcbTvx7s1X4JNEMXHTB48Ek/AwsKrMgJ6yS8oJpCVpEdI=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4465.eurprd04.prod.outlook.com (52.135.148.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 03:20:35 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.018; Wed, 21 Aug 2019
 03:20:35 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] nvmem: imx: scu: support write
Thread-Topic: [PATCH 2/2] nvmem: imx: scu: support write
Thread-Index: AQHVV89l2gZHrF0tR0yZfYtuVeLxmg==
Date:   Wed, 21 Aug 2019 03:20:35 +0000
Message-ID: <1566356496-30493-2-git-send-email-peng.fan@nxp.com>
References: <1566356496-30493-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1566356496-30493-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0054.apcprd04.prod.outlook.com
 (2603:1096:202:14::22) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec9c44d8-831c-457e-f495-08d725e6881d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4465;
x-ms-traffictypediagnostic: AM0PR04MB4465:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB44650224D412C3F66F5DA16B88AA0@AM0PR04MB4465.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(189003)(199004)(52116002)(66446008)(26005)(71200400001)(5660300002)(71190400001)(110136005)(2616005)(446003)(66946007)(66476007)(54906003)(8936002)(64756008)(14454004)(256004)(14444005)(11346002)(386003)(102836004)(66556008)(7736002)(486006)(305945005)(2906002)(6506007)(25786009)(44832011)(316002)(186003)(86362001)(4326008)(476003)(66066001)(6436002)(6512007)(50226002)(36756003)(478600001)(3846002)(6116002)(99286004)(8676002)(2501003)(81156014)(81166006)(53936002)(2201001)(6486002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4465;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OeY5I3ydmUWL3pT93clK7wBJXO62x5aEKYLxHWx8fXYVdxOwDApIfd5wjP192FZYDGAHTjqfWk7BIxJukyFYfBAGIMe91WrjxUyeTC1HAoK9hMDiV8Wn4Mrlx/GYC6QnD87a0Eg7PJHB9gBjodwbjysIvUoQbwlWOAFD3pUs+cSZuKGrAI/j60GwoTOqFy9rfHeqeQB9nuDmuzYmvGBr49YgRsPZaQEoiNPR6Fy7Rswces1wqGqrWE2jHvEQm/SM/rjB5u53TKhKgo82ax4KnPbGh3xpDWcFLVMlKyolDjBVwJGb/c5kLgVL/BKpidp0ooeNY98GBfkePnWrU7p21aEdKtKTH0AmNLdjxS7VfSKszTEcsRN9SRlEAkUFMWSTiA/bTquyB6IzFYMqNb4/AiT2aj0fkNC4bTbDRF4r9gk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9c44d8-831c-457e-f495-08d725e6881d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 03:20:35.4503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fOc7+ODw/hV5bmUXjU2H+N+q+PH9xQ09asuHcmZPZNK5Xah6zGAsF+2N67hef9Zasu73TkamSB32LzLIY3SEMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4465
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The fuse programming from non-secure world is blocked, so we could
only use Arm Trusted Firmware SIP call to let ATF program fuse.

Because there is ECC region that could only be programmed once,
so add a heler in_ecc to check the ecc region.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

The ATF patch will soon be posted to ATF community.

 drivers/nvmem/imx-ocotp-scu.c | 73 +++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
index 2f339d7432e6..0f064f2e74a8 100644
--- a/drivers/nvmem/imx-ocotp-scu.c
+++ b/drivers/nvmem/imx-ocotp-scu.c
@@ -7,6 +7,7 @@
  * Peng Fan <peng.fan@nxp.com>
  */
=20
+#include <linux/arm-smccc.h>
 #include <linux/firmware/imx/sci.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
@@ -14,6 +15,9 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
=20
+#define IMX_SIP_OTP			0xC200000A
+#define IMX_SIP_OTP_WRITE		0x2
+
 enum ocotp_devtype {
 	IMX8QXP,
 };
@@ -45,6 +49,8 @@ struct imx_sc_msg_misc_fuse_read {
 	u32 word;
 } __packed;
=20
+static DEFINE_MUTEX(scu_ocotp_mutex);
+
 static struct ocotp_devtype_data imx8qxp_data =3D {
 	.devtype =3D IMX8QXP,
 	.nregs =3D 800,
@@ -73,6 +79,23 @@ static bool in_hole(void *context, u32 index)
 	return false;
 }
=20
+static bool in_ecc(void *context, u32 index)
+{
+	struct ocotp_priv *priv =3D context;
+	const struct ocotp_devtype_data *data =3D priv->data;
+	int i;
+
+	for (i =3D 0; i < data->num_region; i++) {
+		if (data->region[i].flag & ECC_REGION) {
+			if ((index >=3D data->region[i].start) &&
+			    (index <=3D data->region[i].end))
+				return true;
+		}
+	}
+
+	return false;
+}
+
 static int imx_sc_misc_otp_fuse_read(struct imx_sc_ipc *ipc, u32 word,
 				     u32 *val)
 {
@@ -116,6 +139,8 @@ static int imx_scu_ocotp_read(void *context, unsigned i=
nt offset,
 	if (!p)
 		return -ENOMEM;
=20
+	mutex_lock(&scu_ocotp_mutex);
+
 	buf =3D p;
=20
 	for (i =3D index; i < (index + count); i++) {
@@ -126,6 +151,7 @@ static int imx_scu_ocotp_read(void *context, unsigned i=
nt offset,
=20
 		ret =3D imx_sc_misc_otp_fuse_read(priv->nvmem_ipc, i, buf);
 		if (ret) {
+			mutex_unlock(&scu_ocotp_mutex);
 			kfree(p);
 			return ret;
 		}
@@ -134,18 +160,63 @@ static int imx_scu_ocotp_read(void *context, unsigned=
 int offset,
=20
 	memcpy(val, (u8 *)p + offset % 4, bytes);
=20
+	mutex_unlock(&scu_ocotp_mutex);
+
 	kfree(p);
=20
 	return 0;
 }
=20
+static int imx_scu_ocotp_write(void *context, unsigned int offset,
+			       void *val, size_t bytes)
+{
+	struct ocotp_priv *priv =3D context;
+	struct arm_smccc_res res;
+	u32 *buf =3D val;
+	u32 tmp;
+	u32 index;
+	int ret;
+
+	/* allow only writing one complete OTP word at a time */
+	if ((bytes !=3D 4) || (offset % 4))
+		return -EINVAL;
+
+	index =3D offset >> 2;
+
+	if (in_hole(context, index))
+		return -EINVAL;
+
+	if (in_ecc(context, index)) {
+		pr_warn("ECC region, only program once\n");
+		mutex_lock(&scu_ocotp_mutex);
+		ret =3D imx_sc_misc_otp_fuse_read(priv->nvmem_ipc, index, &tmp);
+		mutex_unlock(&scu_ocotp_mutex);
+		if (ret)
+			return ret;
+		if (tmp) {
+			pr_warn("ECC region, already has value: %x\n", tmp);
+			return -EIO;
+		}
+	}
+
+	mutex_lock(&scu_ocotp_mutex);
+
+	arm_smccc_smc(IMX_SIP_OTP, IMX_SIP_OTP_WRITE, index, *buf,
+		      0, 0, 0, 0, &res);
+
+	mutex_unlock(&scu_ocotp_mutex);
+
+	return res.a0;
+}
+
 static struct nvmem_config imx_scu_ocotp_nvmem_config =3D {
 	.name =3D "imx-scu-ocotp",
-	.read_only =3D true,
+	.read_only =3D false,
 	.word_size =3D 4,
 	.stride =3D 1,
 	.owner =3D THIS_MODULE,
 	.reg_read =3D imx_scu_ocotp_read,
+	.reg_write =3D imx_scu_ocotp_write,
 };
=20
 static const struct of_device_id imx_scu_ocotp_dt_ids[] =3D {
--=20
2.16.4

