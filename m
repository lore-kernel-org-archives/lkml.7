Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20C4C072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 00:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8418321773
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 00:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="svj6280m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfEVAH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 20:07:59 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:37148 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfEVAH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 20:07:58 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 38C8C891A9;
        Wed, 22 May 2019 12:07:56 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1558483676;
        bh=4vBMADYmnJSt2XlDMdbmk4Hf0OrCwBXEHiQQvrZH6HM=;
        h=From:To:Cc:Subject:Date;
        b=svj6280mLrmcPUSBHSGiN8f6seclFeA+xN6F74OrwbVPfOoDTnbMznq3Z6R8wYOtX
         45zn1y5GHvXrdOcS1tLPOTVNC/j4Lke3YMR6rI3RFomy6LjSssuKZJ1yDb4jLqZUYD
         1JsugsEVlPk2APR5lcJx10ms/5lz0ftAnqHFAx6+nSmTnaEpZQAHdoYiPEWykdrZJ+
         JyZjdIQXdqF5N0V0Q6dRNwrsct2GpcjBr1jh6TGChD6lCmSxOatcWrFEzIg7wojShh
         rBUj/DVhlVv9sG7s/jYI3+VgwRFgpJ1StJ0TWWDPg1fZJHpfiVO2+LYwBF4Ekgt7as
         CU6SEUWq+JvQA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ce492db0000>; Wed, 22 May 2019 12:07:55 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 11E2013ED45;
        Wed, 22 May 2019 12:07:56 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 6B6781E1DDA; Wed, 22 May 2019 12:07:55 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 1/2] mtd: concat: refactor concat_lock/concat_unlock
Date:   Wed, 22 May 2019 12:07:52 +1200
Message-Id: <20190522000753.13300-1-chris.packham@alliedtelesis.co.nz>
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
pass mtd_lock or mtd_unlock as an argument.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/mtd/mtdconcat.c | 41 +++++++++--------------------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index cbc5925e6440..9514cd2db63c 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -451,7 +451,8 @@ static int concat_erase(struct mtd_info *mtd, struct =
erase_info *instr)
 	return err;
 }
=20
-static int concat_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
+static int __concat_xxlock(struct mtd_info *mtd, loff_t ofs, uint64_t le=
n,
+			   int (*mtd_op)(struct mtd_info *mtd, loff_t ofs, uint64_t len))
 {
 	struct mtd_concat *concat =3D CONCAT(mtd);
 	int i, err =3D -EINVAL;
@@ -470,7 +471,7 @@ static int concat_lock(struct mtd_info *mtd, loff_t o=
fs, uint64_t len)
 		else
 			size =3D len;
=20
-		err =3D mtd_lock(subdev, ofs, size);
+		err =3D mtd_op(subdev, ofs, size);
 		if (err)
 			break;
=20
@@ -485,38 +486,14 @@ static int concat_lock(struct mtd_info *mtd, loff_t=
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
+	return __concat_xxlock(mtd, ofs, len, mtd_lock);
+}
=20
-	return err;
+static int concat_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
+{
+	return __concat_xxlock(mtd, ofs, len, mtd_unlock);
 }
=20
 static void concat_sync(struct mtd_info *mtd)
--=20
2.21.0

