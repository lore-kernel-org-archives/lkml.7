Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3644C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 02:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D71F207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 02:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HpFZ6ppO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfI0CYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 22:24:24 -0400
Received: from mail-eopbgr130077.outbound.protection.outlook.com ([40.107.13.77]:64587
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727631AbfI0CYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 22:24:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMqRyMlvVwRmhMJCnv/hohaPFBqQMoeKMpudn4RpfxJ5Qz1VAVMPKsw0oOFqMFSbHMC+86ni6TV+1qk4BXHFapKliVZx8iTXcSR9SwFi23zzhI+Vb8CUXHIDYqxpzOtjWyRUfI3IAnkNfcY1Q07xlZ6Je7FPUpTPpDSggYAqs5Gw/4YtCRj2Pi+UQ4/oRJ/G6huN0xh0G+/3EsQBl/dbwwTos0WZlZuALfMVqr1bLmn/38mx/bfcEFL+/qlULQXrC49JCL8vJUhaGcDWDGgVKgoK72fnFhA+NCDLmXEBLh/r9I0JXYYZcAKLHsFbQaKRSQR9h7/8038bisTJ64Yeng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xccQNTD57IXyhSef/plRJ/zrUfYyV5oWPiMYwMx27dg=;
 b=TBLDN6tsANlE8BM5AFx3HaUXtDK0TUFwDXPSf88jumPz/RjmDDDToZZ39HzLmebLLWQP1sLV0lqCBV1ISuZ2WA1PQQXVykJr+DF0HgxY7wDklrfKm/u3z6Grtc3csyaYlVQ+Ht9iGYVq0NLfFMfvXjz0msS+RUg0amM+jLWpv5e++eApXltKk1v5xfMpXpUbGzp5+lLaMQ0IBUjlw2mttT9CPps/DIuwc/EbEY4gtFyTaskk/aOIfO7l0DKzCm5rCB0/r7LfKG+40m7GspWq5bvwPsDlAC2b5eU8Ly4tAHiLfGqcit6cjMynnko8ojYZm3Z9NLLg6cppXlq10z/S2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xccQNTD57IXyhSef/plRJ/zrUfYyV5oWPiMYwMx27dg=;
 b=HpFZ6ppOZ7hsG4DCOuoJN4eMByJrDlgiW74J9hDyN8Y5yvqnGwtdrBtDBZbk1i68WecPhWGrtrLgH9U13TibANubGcgODQvq5OIOsXvw+dT1aAsx3iZg/nOeDDl99zc5vURQSkSEukkNtiAQssnRF8K8iJe4lF0fUBYBIWp3TL4=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.150) by
 DB7PR04MB5338.eurprd04.prod.outlook.com (52.135.128.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 27 Sep 2019 02:23:44 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::4427:96f2:f651:6dfa]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::4427:96f2:f651:6dfa%5]) with mapi id 15.20.2284.023; Fri, 27 Sep 2019
 02:23:44 +0000
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
Subject: [PATCH V2 2/2] nvmem: imx: scu: support write
Thread-Topic: [PATCH V2 2/2] nvmem: imx: scu: support write
Thread-Index: AQHVdNqWV3bDbWXLM0C9Hq/ux+/f2Q==
Date:   Fri, 27 Sep 2019 02:23:44 +0000
Message-ID: <1569550913-10176-2-git-send-email-peng.fan@nxp.com>
References: <1569550913-10176-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1569550913-10176-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0021.apcprd04.prod.outlook.com
 (2603:1096:202:2::31) To DB7PR04MB4490.eurprd04.prod.outlook.com
 (2603:10a6:5:36::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed95b29c-9f14-4c8d-49dc-08d742f1b888
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB5338;
x-ms-traffictypediagnostic: DB7PR04MB5338:|DB7PR04MB5338:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB533899A5D77BC63B5D4B85A788810@DB7PR04MB5338.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(199004)(189003)(54906003)(6436002)(110136005)(6486002)(81166006)(81156014)(50226002)(8676002)(2501003)(64756008)(8936002)(2201001)(66446008)(186003)(66556008)(66476007)(6512007)(6506007)(52116002)(478600001)(386003)(99286004)(4326008)(6116002)(86362001)(26005)(102836004)(256004)(14444005)(446003)(44832011)(7736002)(5660300002)(305945005)(36756003)(66946007)(3846002)(316002)(2616005)(76176011)(14454004)(486006)(2906002)(11346002)(66066001)(476003)(71190400001)(71200400001)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5338;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gCujlQzd4+7VoFPuc2ZiuLhrZJW+46k1YscePlrm0WAQmA2jzX/3GPdyq1Ek9LkXnqz6hmynUT5XQvicNl1dOV2YHJrjKJ3D35hNh/CH20AqEM/aduVSbVKkRKFGKM071FBS24le1PaUG2Lr0LWxdUdlWpyjWue011AVzzhjFuzjAGap3/OIvwxgNs0U9V9CKKFhlZx+64wKgbvVNXI/JMF+qDOGqvda1CZ8xYRzCtdDPpAvRDHTwWRFvm9YzRqwN/HtDXz9Djw1Usnm9QW/dzpyr8wB4vZAi/SIID//+8EHbEtuXgx/Fo6RWkQOIuk9FMTErp7etVVOHvuP/atX6Y5bwnu+ERAYbDuGuMmH4uW0tvJt0fG+Q0l0i/zxQUnSnWVVa5lT96gHmSS2yXNauHQa7kxLUC+MYMTjCsb+EWE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed95b29c-9f14-4c8d-49dc-08d742f1b888
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 02:23:44.8254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ozf6TbbjPxs41FdgzUPe9CteAxzfDPpEHZC5TpBOrZYsR57nUw1c/2npXz6Pxo4W71emE10/0OOZMnQisf1Row==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5338
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

V2:
 Rebased on Latest linux-next

 drivers/nvmem/imx-ocotp-scu.c | 73 +++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
index 030e27ba4dfb..03f1ab23ad51 100644
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
 	IMX8QM,
@@ -46,6 +50,8 @@ struct imx_sc_msg_misc_fuse_read {
 	u32 word;
 } __packed;
=20
+static DEFINE_MUTEX(scu_ocotp_mutex);
+
 static struct ocotp_devtype_data imx8qxp_data =3D {
 	.devtype =3D IMX8QXP,
 	.nregs =3D 800,
@@ -84,6 +90,23 @@ static bool in_hole(void *context, u32 index)
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
@@ -127,6 +150,8 @@ static int imx_scu_ocotp_read(void *context, unsigned i=
nt offset,
 	if (!p)
 		return -ENOMEM;
=20
+	mutex_lock(&scu_ocotp_mutex);
+
 	buf =3D p;
=20
 	for (i =3D index; i < (index + count); i++) {
@@ -137,6 +162,7 @@ static int imx_scu_ocotp_read(void *context, unsigned i=
nt offset,
=20
 		ret =3D imx_sc_misc_otp_fuse_read(priv->nvmem_ipc, i, buf);
 		if (ret) {
+			mutex_unlock(&scu_ocotp_mutex);
 			kfree(p);
 			return ret;
 		}
@@ -145,18 +171,63 @@ static int imx_scu_ocotp_read(void *context, unsigned=
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

