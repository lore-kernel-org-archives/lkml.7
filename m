Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EB1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368E92183E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554367903;
	bh=xKVGh0QeE4fwNObygIshxftammKd4g3jnhm2Ztstoms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ezDx36cYsJRf68To+p7IO30XGq1XDOYb+90xIonbAIKT46A5/YSbFbtC6dH7zOJ6a
	 PNPqMt6R7SAC80Hu7oY7ZuNoOV5f8uraPVhnqm4u0ZKhEe4nD8nrNPtZ47ateDz220
	 y3Zdt2HqKh0eZ85wmm6/OR3SN+MNq3+rv8FHzenk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbfDDIvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:51:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729400AbfDDIvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:51:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C44C217D7;
        Thu,  4 Apr 2019 08:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367895;
        bh=xKVGh0QeE4fwNObygIshxftammKd4g3jnhm2Ztstoms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ad2q5yfKWWavwKU58ltEI0TxTvI7z8fV3g2qND4v3+Vsx4bmu1E+oDsiHlxAS9XyL
         v9kHkcgKvSIdv5BukV60gYj8+TrrdLjvM68wz6xajY39Bqf6oeb/YFvT/M9yGRdVs9
         NM4CF6FtKDcLb642EawtqiZFRo1wHhEuKIuW64wg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Boichat <drinkcat@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 37/91] iommu/io-pgtable-arm-v7s: Only kmemleak_ignore L2 tables
Date:   Thu,  4 Apr 2019 10:47:21 +0200
Message-Id: <20190404084537.610022556@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 032ebd8548c9d05e8d2bdc7a7ec2fe29454b0ad0 ]

L1 tables are allocated with __get_dma_pages, and therefore already
ignored by kmemleak.

Without this, the kernel would print this error message on boot,
when the first L1 table is allocated:

[    2.810533] kmemleak: Trying to color unknown object at 0xffffffd652388000 as Black
[    2.818190] CPU: 5 PID: 39 Comm: kworker/5:0 Tainted: G S                4.19.16 #8
[    2.831227] Workqueue: events deferred_probe_work_func
[    2.836353] Call trace:
...
[    2.852532]  paint_ptr+0xa0/0xa8
[    2.855750]  kmemleak_ignore+0x38/0x6c
[    2.859490]  __arm_v7s_alloc_table+0x168/0x1f4
[    2.863922]  arm_v7s_alloc_pgtable+0x114/0x17c
[    2.868354]  alloc_io_pgtable_ops+0x3c/0x78
...

Fixes: e5fc9753b1a8314 ("iommu/io-pgtable: Add ARMv7 short descriptor support")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index d68a552cfe8d..3085b47fac1d 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -207,7 +207,8 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 		if (dma != virt_to_phys(table))
 			goto out_unmap;
 	}
-	kmemleak_ignore(table);
+	if (lvl == 2)
+		kmemleak_ignore(table);
 	return table;
 
 out_unmap:
-- 
2.19.1



