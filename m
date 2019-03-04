Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B2FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA62D20836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688147;
	bh=RqrkCMC5fYV4vZTb6x+QYi3cIjY+bV3CMYkPtouAkik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R0WobTm0+oaixL/AiKMtjM96bW1FEsVdJQXlrvUIk8i03/w2N0/xEhHzNFO5w9tBd
	 B7xi/71k1jWrs0oxXH6MLbmKmvVyduXUbtYSc/hP2M6QMd+ci1BJrM+a8np7V69Vtl
	 LVAOlkDkASvu3QmhVt8AqIDfK5r7rIHy/8um8S58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfCDI3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:29:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:54860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbfCDI26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:28:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A023D20836;
        Mon,  4 Mar 2019 08:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688138;
        bh=RqrkCMC5fYV4vZTb6x+QYi3cIjY+bV3CMYkPtouAkik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kMB8pi9nNP+V+LW9su7K+VfqgBw7KHfrgaDw3oQvQ2dmLtqnWvztDjoibkDplAIoX
         DG6nuFN97JMd1IisCSPibqSSupr8q0QsO08GpXfBVECzQVGk3adk8tjOxJZqDvScPs
         KaAvaOqXbYpl6U7uwDVizzSRSqh8Sl6ONLIxEOoM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 29/78] irqchip/gic-v3-mbi: Fix uninitialized mbi_lock
Date:   Mon,  4 Mar 2019 09:22:12 +0100
Message-Id: <20190304081626.812858041@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c530bb8a726a37811e9fb5d68cd6b5408173b545 ]

The mbi_lock mutex is left uninitialized, so let's use DEFINE_MUTEX
to initialize it statically.

Fixes: 505287525c24d ("irqchip/gic-v3: Add support for Message Based Interrupts as an MSI controller")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-gic-v3-mbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index ad70e7c416e30..fbfa7ff6deb16 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -24,7 +24,7 @@ struct mbi_range {
 	unsigned long		*bm;
 };
 
-static struct mutex		mbi_lock;
+static DEFINE_MUTEX(mbi_lock);
 static phys_addr_t		mbi_phys_base;
 static struct mbi_range		*mbi_ranges;
 static unsigned int		mbi_range_nr;
-- 
2.19.1



