Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DFEC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 23:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E792075E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 23:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="D8CL520u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfEVXTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 19:19:53 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:38978 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfEVXTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 19:19:53 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2F5A5891A9;
        Thu, 23 May 2019 11:19:51 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1558567191;
        bh=imFlaRrpR3dMR0zUD0PJ2j4weZ85YEMqw1I1qdD35d4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=D8CL520uGaBH6rVHmSQCVRm0yT+9oya/gIxGmR8R2ZhwIOcKa/LgjGRLwAAIhnAT/
         XXx826QdgJpjx6/fjExYyqyIe3ZQJA090OvKZcGfT2Yr3WPByWlZ7n0XYM9i3ebl50
         pVXDrTugcGrg5epMUgrm6AtBuPk+Vvys6SAz8FT2H8lzMrvwf+mlX6bgdF7aNmdzvB
         s6BscHuzZV/PqGGcr9P2QTQRJlSplwdaBWLQGhE/jIr7ojnlbsdxmIZ0cycWt4ipJu
         XIKmDL6xztLen1WKzpUZNXikCmJGTYjrCqR1XncmsqcBtSc2783eFPX1RTRvc/1Iz7
         6hqjavFXeo2Vw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ce5d9140002>; Thu, 23 May 2019 11:19:48 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 245BD13EEB6;
        Thu, 23 May 2019 11:19:51 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 792F51E1D5B; Thu, 23 May 2019 11:19:50 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 2/2] mtd: concat: implement _is_locked mtd operation
Date:   Thu, 23 May 2019 11:19:48 +1200
Message-Id: <20190522231948.17559-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190522231948.17559-1-chris.packham@alliedtelesis.co.nz>
References: <20190522231948.17559-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an implementation of the _is_locked operation for concatenated mtd
devices. This doesn't handle getting the lock status of a range that
spans chips, which is consistent with cfi_ppb_is_locked and
cfi_intelext_is_locked which only look at the first block in the range.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v2:
- Don't re-use the xxlock helper.
- Explicitly disallow ranges that span chips.

 drivers/mtd/mtdconcat.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index 6cb60dea509a..eef0612c2e94 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -499,6 +499,28 @@ static int concat_unlock(struct mtd_info *mtd, loff_=
t ofs, uint64_t len)
 	return concat_xxlock(mtd, ofs, len, false);
 }
=20
+static int concat_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t l=
en)
+{
+	struct mtd_concat *concat =3D CONCAT(mtd);
+	int i, err =3D -EINVAL;
+
+	for (i =3D 0; i < concat->num_subdev; i++) {
+		struct mtd_info *subdev =3D concat->subdev[i];
+
+		if (ofs >=3D subdev->size) {
+			ofs -=3D subdev->size;
+			continue;
+		}
+
+		if (ofs + len > subdev->size)
+			break;
+
+		return mtd_is_locked(subdev, ofs, len);
+	}
+
+	return err;
+}
+
 static void concat_sync(struct mtd_info *mtd)
 {
 	struct mtd_concat *concat =3D CONCAT(mtd);
@@ -698,6 +720,7 @@ struct mtd_info *mtd_concat_create(struct mtd_info *s=
ubdev[],	/* subdevices to c
 	concat->mtd._sync =3D concat_sync;
 	concat->mtd._lock =3D concat_lock;
 	concat->mtd._unlock =3D concat_unlock;
+	concat->mtd._is_locked =3D concat_is_locked;
 	concat->mtd._suspend =3D concat_suspend;
 	concat->mtd._resume =3D concat_resume;
=20
--=20
2.21.0

