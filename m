Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6334DC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F59B2072C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578069730;
	bh=I2X9wjbrKwZTwaNS0KDtFqqXOyBgCetpHii98gM1AAM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=x5/ss6R4fiXN5gJCuGmJz4TM3IqNRycOjJ8XnASfvblgVB5BOsAoB2pTKMdku+1Yj
	 sWb6Kf95Kd/y77SInMsmqgn5EpgP8kKfn6NM33ZqStffNTjr1l0jYPV0tCwfhcRAi4
	 3xehp6mrAUNRoJYVUFrNpHJo0U55OChtlhznYVpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgACQmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 11:42:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:51374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgACQmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 11:42:08 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB45B206E6;
        Fri,  3 Jan 2020 16:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578069728;
        bh=I2X9wjbrKwZTwaNS0KDtFqqXOyBgCetpHii98gM1AAM=;
        h=From:To:Cc:Subject:Date:From;
        b=aqrGsRlS2a621b+qKkT9kA3CrJ0vUkHCKsZZgkB1nM1geNG3RJGDoLiCZT8zqrbrQ
         llKtHd1JgitrcTWJgiWv7twH24pj/UAICZ8jsT8KwBakzdZYtD0siuKnZ8bK6tjBya
         FYIFRkLblGT/5giZ3DnbMlXsVXDIE9JpgjLwhbpA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RFT] mtd: onenand: samsung: Fix iomem access with regular memcpy
Date:   Fri,  3 Jan 2020 17:41:58 +0100
Message-Id: <20200103164158.4265-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __iomem memory should be copied with memcpy_fromio.  This fixes
Sparse warnings like:

    drivers/mtd/nand/onenand/samsung_mtd.c:678:40: warning: incorrect type in argument 2 (different address spaces)
    drivers/mtd/nand/onenand/samsung_mtd.c:678:40:    expected void const *from
    drivers/mtd/nand/onenand/samsung_mtd.c:678:40:    got void [noderef] <asn:2> *[assigned] p
    drivers/mtd/nand/onenand/samsung_mtd.c:679:19: warning: incorrect type in assignment (different address spaces)
    drivers/mtd/nand/onenand/samsung_mtd.c:679:19:    expected void [noderef] <asn:2> *[assigned] p
    drivers/mtd/nand/onenand/samsung_mtd.c:679:19:    got unsigned char *

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---

Not tested

---
 drivers/mtd/nand/onenand/samsung_mtd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/onenand/samsung_mtd.c b/drivers/mtd/nand/onenand/samsung_mtd.c
index 4a78c0aed6dd..01899f8bdfa7 100644
--- a/drivers/mtd/nand/onenand/samsung_mtd.c
+++ b/drivers/mtd/nand/onenand/samsung_mtd.c
@@ -675,12 +675,12 @@ static int s5pc110_read_bufferram(struct mtd_info *mtd, int area,
 normal:
 	if (count != mtd->writesize) {
 		/* Copy the bufferram to memory to prevent unaligned access */
-		memcpy(this->page_buf, p, mtd->writesize);
-		p = this->page_buf + offset;
+		memcpy_fromio(this->page_buf, p, mtd->writesize);
+		memcpy(buffer, this->page_buf + offset, count);
+	} else {
+		memcpy_fromio(buffer, p, count);
 	}
 
-	memcpy(buffer, p, count);
-
 	return 0;
 }
 
-- 
2.17.1

