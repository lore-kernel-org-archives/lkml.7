Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421B9C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0954B20651
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7YukDqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfGRGaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 02:30:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50912 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfGRG37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 02:29:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so24341529wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 23:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O71ReyyfIMfn6gxA/QsNgwUZ9rVFehQHxeS9W6xMfvs=;
        b=u7YukDqUKNSf05PsuG432+7ZzVHtctSbBxgs7A42q4ShY2iRLXdXd4JTXqNWOTtMeP
         kUW7EgqSYqjCwXiAKScdrNS1oCYMKBo6QpnpWn/5xbiasC9fLfE4Ves3isetbmF8P14V
         KWpn6yb0B5G0s+QHTE4jmdTr4o1Wi0Jghi0+hExjetoDhxrYU88RUZOu0t+JD70f0N1f
         daYbeaAhyozbEtLdZknIUrhXnJZi4f4dQhVBq6gM+sh3Z88wpsDbgjKxquBn07nQbNKH
         76Myi4dqjVnELRDWYfiIIHuqEebygO3/E1bwwpoiHOBz+nn1pw69VqDak04VLjDmV2HO
         Liaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O71ReyyfIMfn6gxA/QsNgwUZ9rVFehQHxeS9W6xMfvs=;
        b=LJT38qOC4RZ3K2fxn+nydLpdPrLkuJmi/1NubKgzsvCWwqQTHwOs6umTxBUmeptRli
         jPeNNeAWpDj9wGF6Lc0eUuwsmiQriXAE5JocALAET/VBLzvNNy/Ncpa85YfyLcTzKgrt
         A/Rh1vmqbAj0wEt9bTYAKp+mPTsEo6qXlb/91Tkl2CGtp3l0woPEZjqV/eA82FXxV5+D
         9ODcLjvyrIVia0jM4sEYA49/JAf7TSUn1bY13z03Gaz6eSp93KGLIS3kpSy+ahIRicyz
         Igi0gdTKJrANwj9ZzGD2QriKvIUMlCKmAiokVTfyYSzDin8r8OIS7wbYjIgNF2SnQtaM
         XTQQ==
X-Gm-Message-State: APjAAAWfDRolPJMmQka79/cSPG8cpxLkQBJ8XT2ASSbay2koe6xYquLC
        H3z36ATQE+t7OfYTfT+QUPaP+HUj
X-Google-Smtp-Source: APXvYqwaFU2n6MH3CSEX/B6TzE9BJkfVk3mZnsRorxgnvoLxr+yYv9yIBkbU6ZX8wtUQmTv41e40EA==
X-Received: by 2002:a1c:f418:: with SMTP id z24mr40020220wma.80.1563431396966;
        Wed, 17 Jul 2019 23:29:56 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id j189sm27721368wmb.48.2019.07.17.23.29.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 23:29:56 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: add debug print when rejecting CS
Date:   Thu, 18 Jul 2019 09:29:54 +0300
Message-Id: <20190718062954.15283-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When rejecting CS because of too many in-flight CS, print a debug message
about it as it useful to know when the user is debugging (it indicates a
back-pressure from the driver as the device is not fast enough to consume
the CS)

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index 6ad83d5ef4b0..f4e2c2ad0057 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -305,6 +305,8 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	other = ctx->cs_pending[fence->cs_seq & (HL_MAX_PENDING_CS - 1)];
 	if ((other) && (!dma_fence_is_signaled(other))) {
 		spin_unlock(&ctx->cs_lock);
+		dev_dbg(hdev->dev,
+			"Rejecting CS because of too many in-flights CS\n");
 		rc = -EAGAIN;
 		goto free_fence;
 	}
-- 
2.17.1

