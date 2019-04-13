Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6409C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A894A20850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfDMIlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:41:14 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:40724 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfDMIlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:41:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 87AAB1802DF5F;
        Sat, 13 Apr 2019 10:41:10 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, bbrezillon@kernel.org,
        miquel.raynal@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/2] mtd: nandsim: Embed struct nand_chip in struct nandsim
Date:   Sat, 13 Apr 2019 10:40:51 +0200
Message-Id: <20190413084052.15416-1-richard@nod.at>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We well need struct nand_controller soon, so more stuff need to
be parts of struct nandsim.
While we are here, rename "nand" to "ns" to use the same naming scheme
everywhere in nandsim.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/nand/raw/nandsim.c | 49 +++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsi=
m.c
index 933d1a629c51..3d80e2d23b6e 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -298,6 +298,7 @@ union ns_mem {
  * The structure which describes all the internal simulator data.
  */
 struct nandsim {
+	struct nand_chip chip;
 	struct mtd_partition partitions[CONFIG_NANDSIM_MAX_PARTS];
 	unsigned int nbparts;
=20
@@ -2216,7 +2217,7 @@ static const struct nand_controller_ops ns_controll=
er_ops =3D {
 static int __init ns_init_module(void)
 {
 	struct nand_chip *chip;
-	struct nandsim *nand;
+	struct nandsim *ns;
 	int retval =3D -ENOMEM, i;
=20
 	if (bus_width !=3D 8 && bus_width !=3D 16) {
@@ -2224,16 +2225,14 @@ static int __init ns_init_module(void)
 		return -EINVAL;
 	}
=20
-	/* Allocate and initialize mtd_info, nand_chip and nandsim structures *=
/
-	chip =3D kzalloc(sizeof(struct nand_chip) + sizeof(struct nandsim),
-		       GFP_KERNEL);
-	if (!chip) {
+	ns =3D kzalloc(sizeof(struct nandsim), GFP_KERNEL);
+	if (!ns) {
 		NS_ERR("unable to allocate core structures.\n");
 		return -ENOMEM;
 	}
+	chip	    =3D &ns->chip;
 	nsmtd       =3D nand_to_mtd(chip);
-	nand        =3D (struct nandsim *)(chip + 1);
-	nand_set_controller_data(chip, (void *)nand);
+	nand_set_controller_data(chip, (void *)ns);
=20
 	/*
 	 * Register simulator's callbacks.
@@ -2266,19 +2265,19 @@ static int __init ns_init_module(void)
 	 * the initial ID read command correctly
 	 */
 	if (id_bytes[6] !=3D 0xFF || id_bytes[7] !=3D 0xFF)
-		nand->geom.idbytes =3D 8;
+		ns->geom.idbytes =3D 8;
 	else if (id_bytes[4] !=3D 0xFF || id_bytes[5] !=3D 0xFF)
-		nand->geom.idbytes =3D 6;
+		ns->geom.idbytes =3D 6;
 	else if (id_bytes[2] !=3D 0xFF || id_bytes[3] !=3D 0xFF)
-		nand->geom.idbytes =3D 4;
+		ns->geom.idbytes =3D 4;
 	else
-		nand->geom.idbytes =3D 2;
-	nand->regs.status =3D NS_STATUS_OK(nand);
-	nand->nxstate =3D STATE_UNKNOWN;
-	nand->options |=3D OPT_PAGE512; /* temporary value */
-	memcpy(nand->ids, id_bytes, sizeof(nand->ids));
+		ns->geom.idbytes =3D 2;
+	ns->regs.status =3D NS_STATUS_OK(ns);
+	ns->nxstate =3D STATE_UNKNOWN;
+	ns->options |=3D OPT_PAGE512; /* temporary value */
+	memcpy(ns->ids, id_bytes, sizeof(ns->ids));
 	if (bus_width =3D=3D 16) {
-		nand->busw =3D 16;
+		ns->busw =3D 16;
 		chip->options |=3D NAND_BUSWIDTH_16;
 	}
=20
@@ -2323,27 +2322,27 @@ static int __init ns_init_module(void)
 	if ((retval =3D nand_create_bbt(chip)) !=3D 0)
 		goto err_exit;
=20
-	if ((retval =3D parse_badblocks(nand, nsmtd)) !=3D 0)
+	if ((retval =3D parse_badblocks(ns, nsmtd)) !=3D 0)
 		goto err_exit;
=20
 	/* Register NAND partitions */
-	retval =3D mtd_device_register(nsmtd, &nand->partitions[0],
-				     nand->nbparts);
+	retval =3D mtd_device_register(nsmtd, &ns->partitions[0],
+				     ns->nbparts);
 	if (retval !=3D 0)
 		goto err_exit;
=20
-	if ((retval =3D nandsim_debugfs_create(nand)) !=3D 0)
+	if ((retval =3D nandsim_debugfs_create(ns)) !=3D 0)
 		goto err_exit;
=20
         return 0;
=20
 err_exit:
-	free_nandsim(nand);
+	free_nandsim(ns);
 	nand_release(chip);
-	for (i =3D 0;i < ARRAY_SIZE(nand->partitions); ++i)
-		kfree(nand->partitions[i].name);
+	for (i =3D 0;i < ARRAY_SIZE(ns->partitions); ++i)
+		kfree(ns->partitions[i].name);
 error:
-	kfree(chip);
+	kfree(ns);
 	free_lists();
=20
 	return retval;
@@ -2364,7 +2363,7 @@ static void __exit ns_cleanup_module(void)
 	nand_release(chip); /* Unregister driver */
 	for (i =3D 0;i < ARRAY_SIZE(ns->partitions); ++i)
 		kfree(ns->partitions[i].name);
-	kfree(mtd_to_nand(nsmtd));        /* Free other structures */
+	kfree(ns);        /* Free other structures */
 	free_lists();
 }
=20
--=20
2.21.0

