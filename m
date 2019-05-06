Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE6DC04AB0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305252082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m2MNCVwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfEFH3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:29:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32993 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfEFH3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:29:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id h17so56214pgv.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 00:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+ZQ7qGOLCohxzfhci4Colal/Wo1QqAxCtZ4JkQsFwsU=;
        b=m2MNCVwUhd8v/6Vi+YLmIm4RORKUiK2+BdHKTpNvCPAn0wxJbDla+fHvLPcWFxF24t
         T84EOuE6HFY1fWHQmAWxAqsqCJE28N/Q0G7KNTmeQMle8HgYrJSPmR5KWP3wr/cLnM1j
         /c0f7R2vJZshddyoxk2SyPRQECINjDxmV9fqQncGVl/QA9GvfeiJszqIDU4dgDaaIQaI
         WQrX8pw24wULbhMr1vlYfJW2Et9TjSTQaAOJsfn6a/mZ/NWRPupVVl3sEhHeRAs3cufW
         Ifjyz6nHqboVfhQov7y4HniXpqwS8tdMWA3pnpWPwTtmvsy43maQ5kGmZOYGwavkSJLB
         ta6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+ZQ7qGOLCohxzfhci4Colal/Wo1QqAxCtZ4JkQsFwsU=;
        b=U2775Aa8A4E920TzqnnttAfbMQmQn6aIwWzYWdqgCYPnltOJEiXRpLphnu0iuny1u2
         91H9ttAzUYttqo1qJoqmh7YVm6V7eXF0S+wTvtOax9xAgStfbvMQWN0EON0xQ7VUdfj7
         eG+4VAxhoT2l66HxKOI686Vx8XzdHQpRQNR7dqM7DLFdzVDc4eVEd/YmPQ0I9PXUwzuF
         73MQ7z5aMU4sxVQyJQ+RdePiN1f/ioL65jqwJLmpiMQbsGPiKLxgnXfkYZ6f/ABFAY80
         5tb/TJaAk2NhzgauAJMKGi0m5zv2sAD6AcdbVx306D62mjMrpqcWpA6L878C3GliPBiM
         mfXg==
X-Gm-Message-State: APjAAAXjQcPv7jh/JKFDQMQkFfODCTiAd24l76RdjmVeKdM9uqLAtVPj
        YbCSfqAI1oCp+EgfBzbLcRqffu220nLgMA==
X-Google-Smtp-Source: APXvYqwWb4P6O7/nv5TFfuz5VLxhEIjbuhhBJ23cJf8CsXjlTK7gH97n3xhYJyCDvh9Jbr5aDD8xSA==
X-Received: by 2002:a63:1a03:: with SMTP id a3mr1369341pga.412.1557127743650;
        Mon, 06 May 2019 00:29:03 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id w38sm21700894pgk.90.2019.05.06.00.29.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 00:29:03 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     eric.long@unisoc.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        vincent.guittot@linaro.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] dmaengine: sprd: Fix block length overflow
Date:   Mon,  6 May 2019 15:28:31 +0800
Message-Id: <8f9a1748488e9d890995c158375482285253cc46.1557127239.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1557127239.git.baolin.wang@linaro.org>
References: <cover.1557127239.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1557127239.git.baolin.wang@linaro.org>
References: <cover.1557127239.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Long <eric.long@unisoc.com>

The maximum value of block length is 0xffff, so if the configured transfer length
is more than 0xffff, that will cause block length overflow to lead a configuration
error.

Thus we can set block length as the maximum burst length to avoid this issue, since
the maximum burst length will not be a big value which is more than 0xffff.

Signed-off-by: Eric Long <eric.long@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 0f92e60..a01c232 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -778,7 +778,7 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
 	temp |= slave_cfg->src_maxburst & SPRD_DMA_FRG_LEN_MASK;
 	hw->frg_len = temp;
 
-	hw->blk_len = len & SPRD_DMA_BLK_LEN_MASK;
+	hw->blk_len = slave_cfg->src_maxburst & SPRD_DMA_BLK_LEN_MASK;
 	hw->trsc_len = len & SPRD_DMA_TRSC_LEN_MASK;
 
 	temp = (dst_step & SPRD_DMA_TRSF_STEP_MASK) << SPRD_DMA_DEST_TRSF_STEP_OFFSET;
-- 
1.7.9.5

