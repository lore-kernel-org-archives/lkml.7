Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD58DC072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 00:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980DA217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 00:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="E8zIP9sC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfEVAGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 20:06:48 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:37114 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfEVAGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 20:06:48 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3A41A8365B;
        Wed, 22 May 2019 12:06:46 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1558483606;
        bh=MlTgnlsatXuH34Bkw+JA8k8YCTZyVZxlECoV11VrIxs=;
        h=From:To:Cc:Subject:Date;
        b=E8zIP9sC59ehXJK6VZy6paV6rHo+NiA0P6WHFN7rqz0VDtXvd4v8BCB2WbiZ5jTSQ
         z+Y3tmvIDGXTczXZEhdXs5WFpCYgJpP/IA4VU5/aueTMbDpo20pfWzHFwI3qSwBI6w
         NPEooA4J8+7l2ca+CiONV2z6ZPgsYM2zE/c2TwDu6AhAFzAf0ex0r2oIXHbA9ldLxt
         OBKOnR7iopWpnK0Pln9+S/xYa+dGsWeI0RPgRs8PnzmV1Tq+EOKO7vc7UAAFCTGXOQ
         89fccHlyzPNrAwPAktwLOMzbPsvZDjqWSeg2Q2zp4RoACPb/Lh7tOVBJPf2+cKurL4
         a2+ggnp9eqNcg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ce492920000>; Wed, 22 May 2019 12:06:45 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 1BE1213ED45;
        Wed, 22 May 2019 12:06:43 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 726621E1DDA; Wed, 22 May 2019 12:06:42 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Cc:     sr@denx.de, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] mtd: cfi_cmdset_0002: dynamically determine the max sectors
Date:   Wed, 22 May 2019 12:06:28 +1200
Message-Id: <20190522000628.13073-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because PPB unlocking unlocks the whole chip cfi_ppb_unlock() needs to
remember the locked status for each sector so it can re-lock the
unaddressed sectors. Dynamically calculate the maximum number of sectors
rather than using a hardcoded value that is too small for larger chips.

Tested with Spansion S29GL01GS11TFI flash device.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/mtd/chips/cfi_cmdset_0002.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_=
cmdset_0002.c
index c8fa5906bdf9..a1a7d334aa82 100644
--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -2533,8 +2533,6 @@ struct ppb_lock {
 	int locked;
 };
=20
-#define MAX_SECTORS			512
-
 #define DO_XXLOCK_ONEBLOCK_LOCK		((void *)1)
 #define DO_XXLOCK_ONEBLOCK_UNLOCK	((void *)2)
 #define DO_XXLOCK_ONEBLOCK_GETLOCK	((void *)3)
@@ -2633,6 +2631,7 @@ static int __maybe_unused cfi_ppb_unlock(struct mtd=
_info *mtd, loff_t ofs,
 	int i;
 	int sectors;
 	int ret;
+	int max_sectors;
=20
 	/*
 	 * PPB unlocking always unlocks all sectors of the flash chip.
@@ -2640,7 +2639,11 @@ static int __maybe_unused cfi_ppb_unlock(struct mt=
d_info *mtd, loff_t ofs,
 	 * first check the locking status of all sectors and save
 	 * it for future use.
 	 */
-	sect =3D kcalloc(MAX_SECTORS, sizeof(struct ppb_lock), GFP_KERNEL);
+	max_sectors =3D 0;
+	for (i =3D 0; i < mtd->numeraseregions; i++)
+		max_sectors +=3D regions[i].numblocks;
+
+	sect =3D kcalloc(max_sectors, sizeof(struct ppb_lock), GFP_KERNEL);
 	if (!sect)
 		return -ENOMEM;
=20
@@ -2689,9 +2692,9 @@ static int __maybe_unused cfi_ppb_unlock(struct mtd=
_info *mtd, loff_t ofs,
 		}
=20
 		sectors++;
-		if (sectors >=3D MAX_SECTORS) {
+		if (sectors >=3D max_sectors) {
 			printk(KERN_ERR "Only %d sectors for PPB locking supported!\n",
-			       MAX_SECTORS);
+			       max_sectors);
 			kfree(sect);
 			return -EINVAL;
 		}
--=20
2.21.0

