Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BC2C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC87E2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495241;
	bh=XWqmKbaZJnwJXOI1BCuEW0MZBFSgtSB3KxXwW3nwP7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lidBIEpW4+7T37TP1ScAyek9uC4dG0Lan4G+G9tEpMJB5y9R4sdxZB6d/Fm/LfYfy
	 ur+v87aNC8jj7mWg9dMqP76ag949je3WSLIpL+2Jd2Yjt/PxuPZ68x/tTcd2lbo3VN
	 q/HMp/XNw7HCIsrFv/V3UAtwPjJej1v9tJ6ugzsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392525AbfHVReA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:34:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404465AbfHVRZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:25:39 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CCA22341D;
        Thu, 22 Aug 2019 17:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494738;
        bh=XWqmKbaZJnwJXOI1BCuEW0MZBFSgtSB3KxXwW3nwP7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IMEURfJp8pKLGrF7COVsK0/n0AlU4fIl7sR6qAl5NpmDtoJ9xX1NGrHbdmcDEMbZE
         pXju5TJglir5nnnKxNQsZV8aR2d+wX67mA3349fp9KfPmESv7a8VQ6kvGUJS0hqBed
         KCBdVz8aLbETWCCJwaK4wBH8D7B2MzGwYMHXw4Ok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nianyao Tang <tangnianyao@huawei.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 30/85] irqchip/gic-v3-its: Free unused vpt_page when alloc vpe table fail
Date:   Thu, 22 Aug 2019 10:19:03 -0700
Message-Id: <20190822171732.644622471@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171731.012687054@linuxfoundation.org>
References: <20190822171731.012687054@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index ee30e8965d1be..9ba73e11757d9 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2883,7 +2883,7 @@ static int its_vpe_init(struct its_vpe *vpe)
 
 	if (!its_alloc_vpe_table(vpe_id)) {
 		its_vpe_id_free(vpe_id);
-		its_free_pending_table(vpe->vpt_page);
+		its_free_pending_table(vpt_page);
 		return -ENOMEM;
 	}
 
-- 
2.20.1



