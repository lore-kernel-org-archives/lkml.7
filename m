Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B12C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B967217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561595601;
	bh=73PQYF2L2BDVxfxaOYor0jforq0w+e8jO2ib5QUiBcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WMoscGMBAjgOd9z3/PLpDp9uPFz9eyzynMK6MaBZ38qkvNWXFmSYuxvYRG5fTvX/m
	 dt/gfXseVu+SaF3mXyNDyrBHQbGZQZSGTPIIJyrR3ub6c45GoM92iFzZeaKKNcqz24
	 MMymXGqkpc28NHRBYWXZzlxvk5vxwBKXnHwBbKiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfF0AdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:33:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbfF0AdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:33:13 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15E5921726;
        Thu, 27 Jun 2019 00:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595592;
        bh=73PQYF2L2BDVxfxaOYor0jforq0w+e8jO2ib5QUiBcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GYQ2uVABktkemdvgsWoxZ+xkwDayZR1VIndR7K0JucFkr/5LoLLq+B1LFIOFNFO6m
         P58E/ylxGo8RNPRj9CxZPYuyxmXEYS1e8nB7x6kcDeuxAfWMVra1jpCtFSLT/a/Cwe
         w+rjM/9lS9j8t6vmbOBx44gei+uLgOdFuv7dMI6Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Deepak Rawat <drawat@vmware.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.1 50/95] drm/vmwgfx: Honor the sg list segment size limitation
Date:   Wed, 26 Jun 2019 20:29:35 -0400
Message-Id: <20190627003021.19867-50-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

[ Upstream commit bde15555ba61c7f664f40fd3c6fdbdb63f784c9b ]

When building sg tables, honor the device sg list segment size limitation.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Deepak Rawat <drawat@vmware.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
index a3357ff7540d..97adee1f0575 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
@@ -454,11 +454,11 @@ static int vmw_ttm_map_dma(struct vmw_ttm_tt *vmw_tt)
 		if (unlikely(ret != 0))
 			return ret;
 
-		ret = sg_alloc_table_from_pages(&vmw_tt->sgt, vsgt->pages,
-						vsgt->num_pages, 0,
-						(unsigned long)
-						vsgt->num_pages << PAGE_SHIFT,
-						GFP_KERNEL);
+		ret = __sg_alloc_table_from_pages
+			(&vmw_tt->sgt, vsgt->pages, vsgt->num_pages, 0,
+			 (unsigned long) vsgt->num_pages << PAGE_SHIFT,
+			 dma_get_max_seg_size(dev_priv->dev->dev),
+			 GFP_KERNEL);
 		if (unlikely(ret != 0))
 			goto out_sg_alloc_fail;
 
-- 
2.20.1

