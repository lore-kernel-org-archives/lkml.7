Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C469BC10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD84208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688391;
	bh=DOfVXKSdfbJlGNXbihxBKy7hldGfobdoGXNWgVK3LBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nqsDaXZsmmZomuj1/e2q6iM+BWsl9oK3XbOmpOARLZiA4B8nN2KSqjDw2dSoC3Fhe
	 7WAwoef2yvrQt8swWrVUW7tlmLTajHQab6lPRm8kBPr2WlpRQ8c6iPIcGl6LVcUS6c
	 d+FUzLbTh6+57nDcznlQgDYzYViOHaqz6ZyEVmZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfCDIdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:33:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728158AbfCDIdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:33:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A388E21473;
        Mon,  4 Mar 2019 08:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688385;
        bh=DOfVXKSdfbJlGNXbihxBKy7hldGfobdoGXNWgVK3LBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zlwYREc017t4+zBbSCj48ajVW06/4z0bO1iHmTN5Cbyeb/wtNy8NM3+PesKIq7xpW
         /xS8llrlOG5IZix01C8QIiq8qbZMHcn2M7DqPvm3E5E743KPAOAUdm3KQSNVpDCkRz
         ky5mwnxzj9JxMnApwJ8VptIsImRLAgXjIASRktAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 29/88] irqchip/gic-v3-mbi: Fix uninitialized mbi_lock
Date:   Mon,  4 Mar 2019 09:22:12 +0100
Message-Id: <20190304081631.756766978@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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



