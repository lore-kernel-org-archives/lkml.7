Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DC9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3631B217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="YcMNr4c3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfCLReR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:34:17 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42191 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729456AbfCLRd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:33:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id v3so640305ljk.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 10:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aLMQFMVJhixMG8sPOakzD1aZ1gzCnZ+9/bpni4kwy9M=;
        b=YcMNr4c3NKK9bKjkfZITHqok0FCE8kteFIV+/s93K9uaQXVrNTs2DBzm4K7rPMVK2H
         gPZ+asT/8f7rNtYcFFfofkMdTl9HKoBU7PinY1Pi1CCmOYUdNwwLiQRLr/fyn6U+BiXy
         5as/GBgtQWjaEv8JBBjuBFlDw4MaUUvfrUOWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aLMQFMVJhixMG8sPOakzD1aZ1gzCnZ+9/bpni4kwy9M=;
        b=pVSoLIyEd5EG/YqrK/FmFoze5yXGZFrhKNaXNimmw4gkGtiD5Gr76bCUQnASCU6S3I
         XafSJCD+O4wYfRPkfAm43/PBWUB3o/tCUehjHf7nNoj6uPae8xDmZqpAU3FLdLeAj57M
         d138TlI+GVqHlDNiAsV/mX5cKy+kQE9pjabQEtVzEb8XinH+g8gyq+R67XZkSgbNAj8R
         FJDmdvvbJLPjede0+Fc24g28KJZJXHLSfg/ouuOCyAw0NH9E6q790C/faCP70vv9zgPv
         sJhsct2L0nPwtLO++lX7Oc9uUx+oEZe23Un7kJLSVBc+pA5/iAFFYs/dMbOVZbnvsUYv
         kC3w==
X-Gm-Message-State: APjAAAVcFOOLyGkOeScxc9jzb25WLb8n1qj283KdDDEv7WHCZyWeUng4
        HghhIkhG0tCGp+8amaXhIwDuRRTtwW6bFa1s
X-Google-Smtp-Source: APXvYqx0pZyxqkLY+J+s+/Ey/OAowWM4u/gO/4Ri69tQ8ouPA5J8uGCXqlvcVexa/XLfR7vvt04FpA==
X-Received: by 2002:a2e:9943:: with SMTP id r3mr2746272ljj.18.1552412035473;
        Tue, 12 Mar 2019 10:33:55 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id j5sm1473609ljg.47.2019.03.12.10.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 10:33:55 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] irqchip/gic-v3-its: move allocation outside mutex
Date:   Tue, 12 Mar 2019 18:33:47 +0100
Message-Id: <20190312173350.4025-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312173350.4025-1-linux@rasmusvillemoes.dk>
References: <20190312173350.4025-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason to do the allocation of the new lpi_range inside the
lpi_range_lock. One could change the code to avoid the allocation
altogether in case the freed range can be merged with one or two
existing ranges (in which case the allocation would naturally be done
under the lock), but it's probably not worth complicating the code for
that.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/irqchip/irq-gic-v3-its.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 7577755bdcf4..5c8232cff290 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1532,22 +1532,19 @@ static int alloc_lpi_range(u32 nr_lpis, u32 *base)
 static int free_lpi_range(u32 base, u32 nr_lpis)
 {
 	struct lpi_range *new;
-	int err = 0;
-
-	mutex_lock(&lpi_range_lock);
 
 	new = mk_lpi_range(base, nr_lpis);
-	if (!new) {
-		err = -ENOMEM;
-		goto out;
-	}
+	if (!new)
+		return -ENOMEM;
+
+	mutex_lock(&lpi_range_lock);
 
 	list_add(&new->entry, &lpi_range_list);
 	list_sort(NULL, &lpi_range_list, lpi_range_cmp);
 	merge_lpi_ranges();
-out:
+
 	mutex_unlock(&lpi_range_lock);
-	return err;
+	return 0;
 }
 
 static int __init its_lpi_init(u32 id_bits)
-- 
2.20.1

