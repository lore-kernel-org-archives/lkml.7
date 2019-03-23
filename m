Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D43C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 22:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E222133F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 22:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="m6rtzOJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfCWWj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 18:39:56 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:36208 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfCWWjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 18:39:55 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 6C4EEA9A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 22:39:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4ucePQoesEWz for <linux-kernel@vger.kernel.org>;
        Sat, 23 Mar 2019 17:39:54 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 433EDA2C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 17:39:54 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id c2so4862855ioh.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 15:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aicOTmUHmiFSYikM8BDl1oQkhVALsRhj9kFFnLcxAB4=;
        b=m6rtzOJM9RbifpHFI+0N9+R/YyQly4z2ZztzncMBmD0Ob1Pp+5orMAnJHKtZEi/VKy
         7U6haeWhkwcxChtNb8sOEvYzquV8kP6HNVkE8HAbZ7jf1gVXsRcie/Mpu3+c3/TTruee
         jEkHxep5Em1g4f3gEWH4a7jfQLhzOrTCj375S1zEmJe9R+IroWENx36cNCtG76CnUOcW
         q/Ij/TMZutGSXGteY49F2Y+kXJSCq8hP/ZOrQq3rX5y31U0pAifn42gLFjU2MXMlHGaI
         iw9Zj7D/izLv3+sGG0Yi2O/+nBqZ5w2W27MOKUjUR4ykIFhXCgvNX6kH2KWl32oEV3JO
         H0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aicOTmUHmiFSYikM8BDl1oQkhVALsRhj9kFFnLcxAB4=;
        b=q7m2ma5YFTh8uZYGSuVQjo749pwVKafykMHTKtg1TrP5kzSboccDKarmQse5phKi3u
         w7XlqJdkjzQS85mI+2hbfH2pXeEtqogg/mldG624S+4WQ9JLPG9PDeovf5CVWNjjfj++
         p2VPIuyedTfgs5NQTzleggcZbbBa/fiAsR+468SxtAGvLc9VhQbobULUMJrmwegDPMRl
         Ek5EDwKhPswK0GACzaguvU2OMdy1Nb4w9LeUfDaPfJFKcauyh/e4uOg9Dkfjuzb9Yrwv
         NbchkeqHAQ6lo2F4mYo1zWHU7tGd/OkzRuXlf+f6lVmcpOTIb3IpNBJmeVhhM0989CxH
         hkFw==
X-Gm-Message-State: APjAAAXVNd3YqOMl+nXEavsPLWyznCn8tM9IvyWSotsOrBbUMzu+N/Cb
        wPPFZF6EFAbUytth8RPMfbB0LJgGkjk4bY/oLU4ANYuwRvMKfopKQP1yq1SYlNqQRnqOA9bBrGC
        i1rC4bkGi6B8WPYZqP8cut8VVjjge
X-Received: by 2002:a6b:b258:: with SMTP id b85mr13230604iof.122.1553380793900;
        Sat, 23 Mar 2019 15:39:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzVEbI0SOTW1+wOwQxn9KuRX4Fn1jPWqwsLphkXgqJfKuZeKItJ/bBPp6XwgMRl3zZ2Kv/x7A==
X-Received: by 2002:a6b:b258:: with SMTP id b85mr13230592iof.122.1553380793703;
        Sat, 23 Mar 2019 15:39:53 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id t74sm3583130itb.11.2019.03.23.15.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 15:39:52 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma: ti: fix a missing check in omap_dma_prep_dma_cyclic
Date:   Sat, 23 Mar 2019 17:39:43 -0500
Message-Id: <20190323223948.13885-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is invalid when "buf_len" is not aligned with "period_len".

The fix adds a check for the alignment.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/dma/ti/omap-dma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index a4a931ddf6f6..5f0ce1975e52 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1065,6 +1065,9 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
 	unsigned es;
 	u32 burst;
 
+	if (buf_len % period_len)
+		return NULL;
+
 	if (dir == DMA_DEV_TO_MEM) {
 		dev_addr = c->cfg.src_addr;
 		dev_width = c->cfg.src_addr_width;
-- 
2.17.1

