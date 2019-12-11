Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F049C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5774E21556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576078849;
	bh=n4GvizVDzxPXRCyPq8+nCL+CKfZkX/TznNEEnntdSts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=amgUl6ZCWa6bAlXyF7b/KVmKlPynAGPIIDjZAJHXs9MUZ4gu4iP+g3yME74Fbr0OG
	 L3MAgPlFRp5qSUrYbfQ5jsWE3YcWeEwaRhYVya139Yf+nacu7qWb+SEZk8CSeL4MyS
	 0NrtybrBkbo59NkYCn11SLMbah1f+MA5EWl90qC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388480AbfLKPks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:40:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:48794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388386AbfLKPiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:38:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C13F422B48;
        Wed, 11 Dec 2019 15:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078703;
        bh=n4GvizVDzxPXRCyPq8+nCL+CKfZkX/TznNEEnntdSts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ftpuHtLmjbF2xQw/7sjDy0BJTByFvESr7IWIcYmZu8jSBx5FffvEGNZrauqxflBWL
         0XtPegFEjxSILfpFrH4uUiUq/Dre9wSxh9tT3Q++uzdPMg19r1VS6sGI2YQ26yVsbG
         Pj4XyB0wVKkPjBgjTNyG7JQttv0Vyh+3hx662Srk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 09/37] dma-debug: add a schedule point in debug_dma_dump_mappings()
Date:   Wed, 11 Dec 2019 10:37:45 -0500
Message-Id: <20191211153813.24126-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211153813.24126-1-sashal@kernel.org>
References: <20191211153813.24126-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 9ff6aa027dbb98755f0265695354f2dd07c0d1ce ]

debug_dma_dump_mappings() can take a lot of cpu cycles :

lpk43:/# time wc -l /sys/kernel/debug/dma-api/dump
163435 /sys/kernel/debug/dma-api/dump

real	0m0.463s
user	0m0.003s
sys	0m0.459s

Let's add a cond_resched() to avoid holding cpu for too long.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Corentin Labbe <clabbe@baylibre.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/dma-debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/dma-debug.c b/lib/dma-debug.c
index 51a76af25c663..173013f5e41b9 100644
--- a/lib/dma-debug.c
+++ b/lib/dma-debug.c
@@ -427,6 +427,7 @@ void debug_dma_dump_mappings(struct device *dev)
 		}
 
 		spin_unlock_irqrestore(&bucket->lock, flags);
+		cond_resched();
 	}
 }
 EXPORT_SYMBOL(debug_dma_dump_mappings);
-- 
2.20.1

