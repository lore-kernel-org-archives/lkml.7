Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E628C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 23:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E57E2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 23:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="SpQUo2kH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfEVXTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 19:19:55 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:38979 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfEVXTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 19:19:54 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 24A96886BF;
        Thu, 23 May 2019 11:19:51 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1558567191;
        bh=dtuLuNHN5PQXizzBuOQOvLynHSt8GJ82TtRR1qtMiT4=;
        h=From:To:Cc:Subject:Date;
        b=SpQUo2kHmD9iW+Med7PaWO1niPYiux1juSNW5zZ+hmTaQegqk6dRKUW2/a2F6F/6R
         UCFcsFHG90w2vrERyM4A1Tl5dzIAjNyZmluapsp2A+ijCXkUd2orNVBWzBUxobvqOD
         PYqhcCWnJFmkbdcZ5X7Zd3Tl9e2A/RGvnw0XRl25gt/c7VB62DbiGklci2typO0AKJ
         ZEAP9j5n13dDd8ZbcqwRZt8S+rElczc89r7+wGeWhX7H5SMR7r6ZpRr6pZEQZonGMt
         CStO64/uSfoKsbcAJt5hutzpPxyFEAL0x50gFK2pNg3GmvoHcWixo+qXUPLjTnGi8t
         H2TGANI+Z2+0w==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ce5d9140001>; Thu, 23 May 2019 11:19:48 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 0EA9413EE11;
        Thu, 23 May 2019 11:19:51 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 601B51E1D5B; Thu, 23 May 2019 11:19:50 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 1/2] mtd: concat: refactor concat_lock/concat_unlock
Date:   Thu, 23 May 2019 11:19:47 +1200
Message-Id: <20190522231948.17559-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

concat_lock() and concat_unlock() only differed in terms of the mtd_xx
operation they called. Refactor them to use a common helper function and
pass a boolean flag to indicate whether lock or unlock is needed.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v2:
- Use a boolean flag instead of passing a function pointer.

 drivers/mtd/mtdconcat.c | 44 +++++++++++------------------------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index cbc5925e6440..6cb60dea509a 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -451,7 +451,8 @@ static int concat_erase(struct mtd_info *mtd, struct =
erase_info *instr)
 	return err;
 }
=20
-static int concat_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
+static int concat_xxlock(struct mtd_info *mtd, loff_t ofs, uint64_t len,
+			 bool is_lock)
 {
 	struct mtd_concat *concat =3D CONCAT(mtd);
 	int i, err =3D -EINVAL;
@@ -470,7 +471,10 @@ static int concat_lock(struct mtd_info *mtd, loff_t =
ofs, uint64_t len)
 		else
 			size =3D len;
=20
-		err =3D mtd_lock(subdev, ofs, size);
+		if (is_lock)
+			err =3D mtd_lock(subdev, ofs, size);
+		else
+			err =3D mtd_unlock(subdev, ofs, size);
 		if (err)
 			break;
=20
@@ -485,38 +489,14 @@ static int concat_lock(struct mtd_info *mtd, loff_t=
 ofs, uint64_t len)
 	return err;
 }
=20
-static int concat_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
+static int concat_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 {
-	struct mtd_concat *concat =3D CONCAT(mtd);
-	int i, err =3D 0;
-
-	for (i =3D 0; i < concat->num_subdev; i++) {
-		struct mtd_info *subdev =3D concat->subdev[i];
-		uint64_t size;
-
-		if (ofs >=3D subdev->size) {
-			size =3D 0;
-			ofs -=3D subdev->size;
-			continue;
-		}
-		if (ofs + len > subdev->size)
-			size =3D subdev->size - ofs;
-		else
-			size =3D len;
-
-		err =3D mtd_unlock(subdev, ofs, size);
-		if (err)
-			break;
-
-		len -=3D size;
-		if (len =3D=3D 0)
-			break;
-
-		err =3D -EINVAL;
-		ofs =3D 0;
-	}
+	return concat_xxlock(mtd, ofs, len, true);
+}
=20
-	return err;
+static int concat_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
+{
+	return concat_xxlock(mtd, ofs, len, false);
 }
=20
 static void concat_sync(struct mtd_info *mtd)
--=20
2.21.0

