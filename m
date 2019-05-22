Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0F9C16A69
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 00:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDE121773
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 00:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="R8M9aUSD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfEVAH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 20:07:59 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:37154 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfEVAH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 20:07:58 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3E61D891AA;
        Wed, 22 May 2019 12:07:56 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1558483676;
        bh=b7vi3evCHUpG9dV383KMpTjNqi3Fn1SneFPfhOJgyJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=R8M9aUSD1FTAVRNfnrEUw4AiKn7BYdJeZDYb+k+O0W/8RnPemSonF9fiTAdaR8JCK
         5pcmTeC0yArLIfyKExGsUFKPXmWb2X3/3IrFHz4krQ4AIJPC3EOpfJei7MJFco22Lh
         XRg6KFYR3yY6TrSPsBw+medL2YpJuV5FWBxD1tdWCn7E49NTrCZ8J1ON81eyN9zrdr
         jlzggLasDzg+/ldM1uvz2AU5w6OazA0lKK8BpFJB1nb81LZ7m9j7jJ/vdsz4Y2f4Hf
         LY2e43vuSaxqkyq8TXKsAtjKzA+8U5NCdFgOrLuBLvbUbCgCrBb5M+PkTIMTwXuG0d
         Y8wV+N4WSdxlA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ce492db0001>; Wed, 22 May 2019 12:07:56 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 2DC8A13EF07;
        Wed, 22 May 2019 12:07:56 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 878251E1DDA; Wed, 22 May 2019 12:07:55 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/2] mtd: concat: implement _is_locked mtd operation
Date:   Wed, 22 May 2019 12:07:53 +1200
Message-Id: <20190522000753.13300-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190522000753.13300-1-chris.packham@alliedtelesis.co.nz>
References: <20190522000753.13300-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an implementation of the _is_locked operation for concatenated mtd
devices. As with concat_lock/concat_unlock this can simply use the
common helper and pass mtd_is_locked as the operation.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/mtd/mtdconcat.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index 9514cd2db63c..0e919f3423af 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -496,6 +496,11 @@ static int concat_unlock(struct mtd_info *mtd, loff_=
t ofs, uint64_t len)
 	return __concat_xxlock(mtd, ofs, len, mtd_unlock);
 }
=20
+static int concat_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t l=
en)
+{
+	return __concat_xxlock(mtd, ofs, len, mtd_is_locked);
+}
+
 static void concat_sync(struct mtd_info *mtd)
 {
 	struct mtd_concat *concat =3D CONCAT(mtd);
@@ -695,6 +700,7 @@ struct mtd_info *mtd_concat_create(struct mtd_info *s=
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

