Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F8DC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6E32186A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565127400;
	bh=wdq+/b6wjxif/d4ZjVblztZEPaDTsEPHclcNCvKTkPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VPQGcwQ0kRH0p6h/C9BUpq3qufDEy8KnCp0+hzdPXInWjSTOhW5uX3viGVJdsABQl
	 R6NuQYS5RtqNVGWuN1KeKgUqVYctuqYL+iXKwiY/2n5+pazb37iybkGJyuvVOeAHyO
	 Oi2RWlHvEQv5ZMY1vhhb23tX/NWO8rYMXeWSLqO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbfHFVgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:36:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbfHFVgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:36:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48164217F5;
        Tue,  6 Aug 2019 21:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127394;
        bh=wdq+/b6wjxif/d4ZjVblztZEPaDTsEPHclcNCvKTkPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nrShrKdtm6vALjw2EgrSSBfTtFsVsRX1Pmqlgf80/N8zefitxnbppK/uNNx+GJwwm
         iyUGDqQwIkuW/qDcER/N/Q4NJzo+Dh8xbiNRS5BftSUH/26/7RFkRrE66O9LngRtnt
         L3Lk1kXlM9K3ZqRAobf66e/uTOtBZQ39+cIZraH8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nianyao Tang <tangnianyao@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 05/25] irqchip/gic-v3-its: Free unused vpt_page when alloc vpe table fail
Date:   Tue,  6 Aug 2019 17:36:02 -0400
Message-Id: <20190806213624.20194-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806213624.20194-1-sashal@kernel.org>
References: <20190806213624.20194-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nianyao Tang <tangnianyao@huawei.com>

[ Upstream commit 34f8eb92ca053cbba2887bb7e4dbf2b2cd6eb733 ]

In its_vpe_init, when its_alloc_vpe_table fails, we should free
vpt_page allocated just before, instead of vpe->vpt_page.
Let's fix it.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 121fb552f8734..f80666acb9efd 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2631,7 +2631,7 @@ static int its_vpe_init(struct its_vpe *vpe)
 
 	if (!its_alloc_vpe_table(vpe_id)) {
 		its_vpe_id_free(vpe_id);
-		its_free_pending_table(vpe->vpt_page);
+		its_free_pending_table(vpt_page);
 		return -ENOMEM;
 	}
 
-- 
2.20.1

