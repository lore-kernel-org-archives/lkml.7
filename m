Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AAFC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311B021019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="zdQfL9oG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbfEWMvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:51:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45780 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730856AbfEWMvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:51:53 -0400
Received: by mail-lj1-f195.google.com with SMTP id r76so5317499lja.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 05:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rZdczaVGyQjvanE23Fu/ZU9lf8yYQixA/KoNU+HEtSs=;
        b=zdQfL9oGxUyal2kYcvEy/VcupsF5u0Nn/8dFIvz21lojZBSJhEmgpK2ZudXNpgKroy
         4lS8BbHbgntcu65Ngjyujp6cninufk7E4RziAbRqYFRktsm+4BMAHB1m4oqvDNVDKrgV
         oChMNPpIw9lNsWSGuWmBRvXDMFgGZvTk7Jz0xlaNT8/vL175LLdHQAJQzJi6jdNnsvoY
         fMcQlmO4S9K9XP6/nNtP5Bd/vLLlC7rtpozjrQeS+wjssKo5Z0qzLL62wJLhxSb381bu
         UpDWD6tyEbgN84h55LwhqAogr2rSpAPnTGKfvc1KJH83OFDT9bxNlqGocki2SVZcXmHC
         UUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rZdczaVGyQjvanE23Fu/ZU9lf8yYQixA/KoNU+HEtSs=;
        b=SD6ii8SoRB32khy+mS+6iFH2ZgZtHhgY04mrTueJMJRcz3ya5u7BUAxxzFcZAcqtX0
         6VIwfXYJoaEmDhEeIbl69/6mePiJ823Jtr1cPQNLjeZP2F2Y9OlJdlRBq/8vwYxcOWu+
         y7b4QkTmrs13ABuiU7QdqlD1qdTVhqd0v3QUaRAw9Fw6oFVf50fAgIfaRv/9Ig8FZgbm
         h2A8RTYZvfAz5VFW28hbnoATC0OmLB4jlyTV0gtaTbI3nkrMdJUD9moXwUDJT1vPkjjx
         5dK2lVGJmPexXA4rtHUFGwE/vrd22aEyW9iXyaTQvMNfqHBiJfPh19RGkkBKj6sV75B/
         nU2w==
X-Gm-Message-State: APjAAAXKWZDCTKna13uoPNdeEMLFJf4OZLefGSYAHufoLZvarXLKf3e1
        OPeCJtFYSpFBkML5GxjsUd0rGA==
X-Google-Smtp-Source: APXvYqyqxKhtOfbWZSS2bIR77JBsPl/PPIlE8cDBFj/P7ttRg0jDns1aamVnLjTZIAIWcJm+vGDZ2A==
X-Received: by 2002:a2e:8185:: with SMTP id e5mr16807928ljg.14.1558615911134;
        Thu, 23 May 2019 05:51:51 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id c19sm5947154lfi.69.2019.05.23.05.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 05:51:50 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] staging: kpc2000: remove extra blank lines in cell_probe.c
Date:   Thu, 23 May 2019 14:51:39 +0200
Message-Id: <20190523125143.32511-6-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523125143.32511-1-simon@nikanor.nu>
References: <20190523125143.32511-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warnings "Please don't use multiple blank lines".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index 5b88504b00ec..f8d19e693f21 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -94,7 +94,6 @@ void parse_core_table_entry(struct core_table_entry *cte, const u64 read_val, co
 	}
 }
 
-
 static int probe_core_basic(unsigned int core_num, struct kp2000_device *pcard,
 			    char *name, const struct core_table_entry cte)
 {
@@ -111,7 +110,6 @@ static int probe_core_basic(unsigned int core_num, struct kp2000_device *pcard,
 
 	dev_dbg(&pcard->pdev->dev, "Found Basic core: type = %02d  dma = %02x / %02x  offset = 0x%x  length = 0x%x (%d regs)\n", cte.type, KPC_OLD_S2C_DMA_CH_NUM(cte), KPC_OLD_C2S_DMA_CH_NUM(cte), cte.offset, cte.length, cte.length / 8);
 
-
 	cell.platform_data = &core_pdata;
 	cell.pdata_size = sizeof(struct kpc_core_device_platdata);
 	cell.num_resources = 2;
@@ -137,7 +135,6 @@ static int probe_core_basic(unsigned int core_num, struct kp2000_device *pcard,
 			       NULL);                  // struct irq_domain *
 }
 
-
 struct kpc_uio_device {
 	struct list_head list;
 	struct kp2000_device *pcard;
@@ -346,7 +343,6 @@ static int probe_core_uio(unsigned int core_num, struct kp2000_device *pcard,
 	return 0;
 }
 
-
 static int  create_dma_engine_core(struct kp2000_device *pcard, size_t engine_regs_offset, int engine_num, int irq_num)
 {
 	struct mfd_cell  cell = { .id = engine_num };
-- 
2.20.1

