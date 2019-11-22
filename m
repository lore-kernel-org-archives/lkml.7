Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D6BC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA2320707
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402895;
	bh=abcTTU0ULRcd4e5L+QK2oU5epvpjofTCLsSbQ+zVTFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FIK6Xy1ksTSiXFX/efRcKw5isLhTDccRsJa0GxKG9q70sgHJLmWP72jLDm23TtDKX
	 IEk1RRc8z8+AGBXXeb+UjO1LdBhnJk3hJzq5B/7yGqwi482aSvoxQY4MVy4t/9fJIw
	 oTEfU3V3UDHrjPiTEWI0xLCy4l8lUfqoR0aif8ZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbfKVGIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:08:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:40086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729188AbfKVGBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:01:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6B9A2070A;
        Fri, 22 Nov 2019 06:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402506;
        bh=abcTTU0ULRcd4e5L+QK2oU5epvpjofTCLsSbQ+zVTFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ir1GOXKkayfFcEFYA81McfQ5kM015fcT3z1r40/vaNrAr1hEB5h9yVoCyekQHyT2h
         mRGSUX2/EMaodeWSxsmG0EbdouBAAXTzexXpF6fmeEjxMD/seoofWbfpIthsDP2Unl
         idVWDinZrnEQH7rbRffh/a2B9e8Oq8xKHss+za5Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pan Bian <bianpan2016@163.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>, linux-mtd@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 16/91] ubi: Put MTD device after it is not used
Date:   Fri, 22 Nov 2019 01:00:14 -0500
Message-Id: <20191122060129.4239-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122060129.4239-1-sashal@kernel.org>
References: <20191122060129.4239-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit b95f83ab762dd6211351b9140f99f43644076ca8 ]

The MTD device reference is dropped via put_mtd_device, however its
field ->index is read and passed to ubi_msg. To fix this, the patch
moves the reference dropping after calling ubi_msg.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/ubi/build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index ad2b57c6b13fd..211ee13d36ed4 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1146,10 +1146,10 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway)
 	ubi_wl_close(ubi);
 	ubi_free_internal_volumes(ubi);
 	vfree(ubi->vtbl);
-	put_mtd_device(ubi->mtd);
 	vfree(ubi->peb_buf);
 	vfree(ubi->fm_buf);
 	ubi_msg(ubi, "mtd%d is detached", ubi->mtd->index);
+	put_mtd_device(ubi->mtd);
 	put_device(&ubi->dev);
 	return 0;
 }
-- 
2.20.1

