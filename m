Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87A7C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7569120748
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574401816;
	bh=NIBG/DzQYeupRi6YDd/Ko+G1upVp5K5Gk4rxGAwR4UQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NytYswE4JinQIQOPtDPOpqgQ07glxuHfZillxu3QwZ/tmrQf73IrHBgrR31Z+0SCY
	 v+JFgAgcwH2eNif4jbM17zcpB1/l/eQhsMBen6RNSJj8O3kv2QF/+AKZFgib/N+Vce
	 1v4mfivxQvBzgK69CgkMuCY0qLBzf1g/l/ZUVr5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfKVFuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:50:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:54596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727530AbfKVFuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:50:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28F5E2071F;
        Fri, 22 Nov 2019 05:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401809;
        bh=NIBG/DzQYeupRi6YDd/Ko+G1upVp5K5Gk4rxGAwR4UQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eWktz9/DNvouk9H42TfUHimTFYe7mPscaBIKN28Vd2mS0UXVe2ayKyelDWBS76ggu
         1qng3dLFy3N/w4kWz9gJgLGAQM4xL8RujQeNb8xwl16NIQrmFD4mIXGqpG4TO7viTk
         /S3Om8fheGBFhgLOQIQAQaBKtv4a0jHgjeRkzvt8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pan Bian <bianpan2016@163.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>, linux-mtd@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 054/219] ubi: Put MTD device after it is not used
Date:   Fri, 22 Nov 2019 00:46:26 -0500
Message-Id: <20191122054911.1750-47-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
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
index d2a726654ff11..c120c8761fcd2 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1101,10 +1101,10 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway)
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

