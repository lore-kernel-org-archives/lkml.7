Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C7FC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF41214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="dAzCeenL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbfCLReY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:34:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36401 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729330AbfCLRd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:33:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id v10so3097987lji.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 10:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DA2zgUS0NG6VNGpeW6eecw0TVGBGR0eCkh17OqOr8k4=;
        b=dAzCeenLZTv+XOMWlEeybh4u0fCR2RmuC8kYePBRE3EarZh9x+RhZJAtqWnvK5HzAz
         iwEWxuXOxKma10yUe6unBkCQR72k8kIHcnw+qGe2G2MKgHxVqWi2gDNMuB2cUHoVfQce
         GafzkijDzz/76wtBVDXba4+EtJ4TxWXjsWGpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DA2zgUS0NG6VNGpeW6eecw0TVGBGR0eCkh17OqOr8k4=;
        b=QO2ekOGVTVr1Tha1ghFsC+xvmMVDqYzfrIjS8EVqb/Km1llO/xpNPxyBXJ23Qr97Li
         gcTQo/OO4A9TmSRLqxQ0rTYQU0sFAZDKaq2FHraCay6VEmdH49LGgWfmPOJE5L8a+Plk
         I3VXlja/4PdsN9Z1+PbGApLHJtHdJ046LHO2M3NuC88/qaSegponygrGxscp/ieFgm5B
         YoB7OWx+VKVYM7nkeBkjKUfLVA3pjruR4l/2FFQa7uun4+kheiF+p9C/CFsJ3OGYnv9Z
         0jYIOGwmX+uIuWzL2popnHXtTjqh2kC9teG4SXugSRhL6C4VnYVXM+GFqyJKf+8kE31e
         ORJg==
X-Gm-Message-State: APjAAAXLb4camM6SI06b76ow0Solv+W70naZUb2rZbZsYK/DTd9Qdt3j
        aDiOpjVsTz50v+nNUTcF6T86tbulhHbCU7O9
X-Google-Smtp-Source: APXvYqwx+o8fDZB7BIzsiNpUPD8PE/3YdT/Kvh/ljYThteuYVUUUOmVc/F1+wcHGoD9sCQrd69oAUA==
X-Received: by 2002:a2e:20b:: with SMTP id 11mr20617573ljc.41.1552412034407;
        Tue, 12 Mar 2019 10:33:54 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id j5sm1473609ljg.47.2019.03.12.10.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 10:33:53 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] irqchip/gic-v3-its: fix comparison logic in lpi_range_cmp
Date:   Tue, 12 Mar 2019 18:33:46 +0100
Message-Id: <20190312173350.4025-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312173350.4025-1-linux@rasmusvillemoes.dk>
References: <20190312173350.4025-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lpi_range_list is supposed to be sorted in ascending order of
->base_id (at least if the range merging is to work), but the current
comparison function returns a positive value if rb->base_id >
ra->base_id, which means that list_sort() will put A after B in that
case - and vice versa, of course.

Fixes: 880cb3cddd16 (irqchip/gic-v3-its: Refactor LPI allocator)
Cc: stable@vger.kernel.org (v4.19+)
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2dd1ff0cf558..7577755bdcf4 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1482,7 +1482,7 @@ static int lpi_range_cmp(void *priv, struct list_head *a, struct list_head *b)
 	ra = container_of(a, struct lpi_range, entry);
 	rb = container_of(b, struct lpi_range, entry);
 
-	return rb->base_id - ra->base_id;
+	return ra->base_id - rb->base_id;
 }
 
 static void merge_lpi_ranges(void)
-- 
2.20.1

