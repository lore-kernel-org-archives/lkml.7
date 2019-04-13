Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51435C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1361120850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfDMIlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:41:14 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:40744 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfDMIlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:41:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 27BD11802199E;
        Sat, 13 Apr 2019 10:41:11 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, bbrezillon@kernel.org,
        miquel.raynal@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/2] mtd: nandsim: switch to exec_op interface
Date:   Sat, 13 Apr 2019 10:40:52 +0200
Message-Id: <20190413084052.15416-2-richard@nod.at>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413084052.15416-1-richard@nod.at>
References: <20190413084052.15416-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop using the legacy interface.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/nand/raw/nandsim.c | 78 ++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 31 deletions(-)

diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsi=
m.c
index 3d80e2d23b6e..33c369f9a607 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -299,6 +299,7 @@ union ns_mem {
  */
 struct nandsim {
 	struct nand_chip chip;
+	struct nand_controller base;
 	struct mtd_partition partitions[CONFIG_NANDSIM_MAX_PARTS];
 	unsigned int nbparts;
=20
@@ -645,9 +646,6 @@ static int __init init_nandsim(struct mtd_info *mtd)
 		return -EIO;
 	}
=20
-	/* Force mtd to not do delays */
-	chip->legacy.chip_delay =3D 0;
-
 	/* Initialize the NAND flash parameters */
 	ns->busw =3D chip->options & NAND_BUSWIDTH_16 ? 16 : 8;
 	ns->geom.totsz    =3D mtd->size;
@@ -2077,24 +2075,6 @@ static void ns_nand_write_byte(struct nand_chip *c=
hip, u_char byte)
 	return;
 }
=20
-static void ns_hwcontrol(struct nand_chip *chip, int cmd, unsigned int b=
itmask)
-{
-	struct nandsim *ns =3D nand_get_controller_data(chip);
-
-	ns->lines.cle =3D bitmask & NAND_CLE ? 1 : 0;
-	ns->lines.ale =3D bitmask & NAND_ALE ? 1 : 0;
-	ns->lines.ce =3D bitmask & NAND_NCE ? 1 : 0;
-
-	if (cmd !=3D NAND_CMD_NONE)
-		ns_nand_write_byte(chip, cmd);
-}
-
-static int ns_device_ready(struct nand_chip *chip)
-{
-	NS_DBG("device_ready\n");
-	return 1;
-}
-
 static void ns_nand_write_buf(struct nand_chip *chip, const u_char *buf,
 			      int len)
 {
@@ -2146,7 +2126,7 @@ static void ns_nand_read_buf(struct nand_chip *chip=
, u_char *buf, int len)
 		int i;
=20
 		for (i =3D 0; i < len; i++)
-			buf[i] =3D chip->legacy.read_byte(chip);
+			buf[i] =3D ns_nand_read_byte(chip);
=20
 		return;
 	}
@@ -2169,6 +2149,46 @@ static void ns_nand_read_buf(struct nand_chip *chi=
p, u_char *buf, int len)
 	return;
 }
=20
+static int ns_exec_op(struct nand_chip *chip, const struct nand_operatio=
n *op,
+		      bool check_only)
+{
+	int i;
+	unsigned int op_id;
+	const struct nand_op_instr *instr =3D NULL;
+	struct nandsim *ns =3D nand_get_controller_data(chip);
+
+	ns->lines.ce =3D chip->cur_cs =3D=3D -1 ? 0 : 1;
+
+	for (op_id =3D 0; op_id < op->ninstrs; op_id++) {
+		instr =3D &op->instrs[op_id];
+		ns->lines.cle =3D 0;
+		ns->lines.ale =3D 0;
+
+		switch (instr->type) {
+		case NAND_OP_CMD_INSTR:
+			ns->lines.cle =3D 1;
+			ns_nand_write_byte(chip, instr->ctx.cmd.opcode);
+			break;
+		case NAND_OP_ADDR_INSTR:
+			ns->lines.ale =3D 1;
+			for (i =3D 0; i < instr->ctx.addr.naddrs; i++)
+				ns_nand_write_byte(chip, instr->ctx.addr.addrs[i]);
+			break;
+		case NAND_OP_DATA_IN_INSTR:
+			ns_nand_read_buf(chip, instr->ctx.data.buf.in, instr->ctx.data.len);
+			break;
+		case NAND_OP_DATA_OUT_INSTR:
+			ns_nand_write_buf(chip, instr->ctx.data.buf.out, instr->ctx.data.len)=
;
+			break;
+		case NAND_OP_WAITRDY_INSTR:
+			/* we are always ready */
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static int ns_attach_chip(struct nand_chip *chip)
 {
 	unsigned int eccsteps, eccbytes;
@@ -2209,6 +2229,7 @@ static int ns_attach_chip(struct nand_chip *chip)
=20
 static const struct nand_controller_ops ns_controller_ops =3D {
 	.attach_chip =3D ns_attach_chip,
+	.exec_op =3D ns_exec_op,
 };
=20
 /*
@@ -2234,14 +2255,6 @@ static int __init ns_init_module(void)
 	nsmtd       =3D nand_to_mtd(chip);
 	nand_set_controller_data(chip, (void *)ns);
=20
-	/*
-	 * Register simulator's callbacks.
-	 */
-	chip->legacy.cmd_ctrl	 =3D ns_hwcontrol;
-	chip->legacy.read_byte  =3D ns_nand_read_byte;
-	chip->legacy.dev_ready  =3D ns_device_ready;
-	chip->legacy.write_buf  =3D ns_nand_write_buf;
-	chip->legacy.read_buf   =3D ns_nand_read_buf;
 	chip->ecc.mode   =3D NAND_ECC_SOFT;
 	chip->ecc.algo   =3D NAND_ECC_HAMMING;
 	/* The NAND_SKIP_BBTSCAN option is necessary for 'overridesize' */
@@ -2292,7 +2305,10 @@ static int __init ns_init_module(void)
 	if ((retval =3D parse_gravepages()) !=3D 0)
 		goto error;
=20
-	chip->legacy.dummy_controller.ops =3D &ns_controller_ops;
+	nand_controller_init(&ns->base);
+	ns->base.ops =3D &ns_controller_ops;
+	chip->controller =3D &ns->base;
+
 	retval =3D nand_scan(chip, 1);
 	if (retval) {
 		NS_ERR("Could not scan NAND Simulator device\n");
--=20
2.21.0

