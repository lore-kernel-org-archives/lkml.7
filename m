Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38C2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38B520700
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3Zs+oXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfCSQp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:45:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38311 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfCSQp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:45:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id n125so14093388pfn.5;
        Tue, 19 Mar 2019 09:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XMwi1gokRLKWKnmdHF7ii++aBZyr6dZb7QlWUm2Pztk=;
        b=P3Zs+oXuxV+EkVuQHoHYHnPE0tRCCmbiXbLBGe5x0rOMelhGIWDgJMsubZZD19XfS/
         9aygcsvdon5Nx9N58H05OTskjwe/hkYlatbJ/QAacKtk1VObukZlcIzPuU0gdcomb7oZ
         i7XScMAzsqR7K8jqWckOsphLFvuZL2P9MxtALxH8EVscv9tpIuePSKCMcvu/5zKm/iVg
         gyMW2hDDA1dxB0pYxXlUqgx+KJ1J8tVBuz/15M+ibS9ial7XT5FyXzuv48WdlPSx88iD
         gPYdx3cTzB6J5kTi2KIThOkHHW6MsH5hMyK/cYK14iDZ9z2SMx/iUIMDEXUu9SYoDYQq
         kOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XMwi1gokRLKWKnmdHF7ii++aBZyr6dZb7QlWUm2Pztk=;
        b=cB5dF6OVGphVkJRST1B1M1myJkil0A7D6mqa/HPVXmphAT7aBSku89rLOYNfwbPknc
         APmQbT00h1s8FTAXSmqFkJwvmBZwdeORUMJ6fmOp+kMrD6KfHZcB5QhthRkrqhdDJ7wN
         znQEim8F6IK6OfMMGFJLr1LqhPlnxNQ+QiMmO7wK4E8c9RDz4JU+0yaNtmFR5lih1848
         xDRg7a4GUbI9SR80ajLVtRorNH/Ro+HwDwXKv+88PBtyjaxLmhJOQn1vcxBVJDcfZWKY
         g78V8quxJfw05wI+NnhYHcF7yUWefvPYJ25voO5gbM+Fx84y2vErtFYxARHGrIiTYhoQ
         c8uA==
X-Gm-Message-State: APjAAAVxYQvU1HLbs1m8LTg6GRFs1eEco+Z77PyZaEvaw/sOPc5BS1mH
        dSJt3Hc16es8HwdxM4svm0U=
X-Google-Smtp-Source: APXvYqzqmO9f9aVRrEHiZG2il4Z18NuzEW374Fg6noap1zBhK4fw/HSUeoPJKH21l82rFVMQ82ySwQ==
X-Received: by 2002:a65:64d5:: with SMTP id t21mr3054011pgv.266.1553013928317;
        Tue, 19 Mar 2019 09:45:28 -0700 (PDT)
Received: from localhost.localdomain ([47.91.249.165])
        by smtp.gmail.com with ESMTPSA id o14sm18275304pgn.65.2019.03.19.09.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Mar 2019 09:45:27 -0700 (PDT)
From:   Jeff Xie <chongguiguzi@gmail.com>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, chongguiguzi@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dma:xgene-dma:move spin_lock_bh to spin_lock in tasklet
Date:   Wed, 20 Mar 2019 00:45:19 +0800
Message-Id: <1553013919-29504-1-git-send-email-chongguiguzi@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is unnecessary to call spin_lock_bh in a tasklet.

Signed-off-by: Jeff Xie <chongguiguzi@gmail.com>
---
 drivers/dma/xgene-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index eafd6c4..0023236 100644
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -703,7 +703,7 @@ static void xgene_dma_cleanup_descriptors(struct xgene_dma_chan *chan)
 
 	INIT_LIST_HEAD(&ld_completed);
 
-	spin_lock_bh(&chan->lock);
+	spin_lock(&chan->lock);
 
 	/* Clean already completed and acked descriptors */
 	xgene_dma_clean_completed_descriptor(chan);
@@ -772,7 +772,7 @@ static void xgene_dma_cleanup_descriptors(struct xgene_dma_chan *chan)
 	 */
 	xgene_chan_xfer_ld_pending(chan);
 
-	spin_unlock_bh(&chan->lock);
+	spin_unlock(&chan->lock);
 
 	/* Run the callback for each descriptor, in order */
 	list_for_each_entry_safe(desc_sw, _desc_sw, &ld_completed, node) {
-- 
2.7.4

