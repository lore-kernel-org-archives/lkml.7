Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DA5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E6A206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="aiQGimhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbfCLReG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:34:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38796 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729756AbfCLRd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:33:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id x13so3076424ljj.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 10:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=etcNNtTzHJ9C5TLik2UUWBM9lxWizQ3uJC9YeUHDamQ=;
        b=aiQGimhN5qtnkWLgB/Bvepsutu7mowEz1yO3avlsbHoT85psJSuc7c9Wm8HSDw7Jyd
         p7sEYeS+J3Qm2CAmZ4qtz7jeCLqeHngOLUASWGpRFZTWUpi+rivjSMMnBUhM+qJqCglq
         4Xe3AAXtAB6/U2C7EvN5EUTRG1arhDldnEjBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=etcNNtTzHJ9C5TLik2UUWBM9lxWizQ3uJC9YeUHDamQ=;
        b=VBtc1+gsi7drpzf0BSw9GMA7BljZND9h7HjeEJpx6F6jhS8VHO4Z0l3dTqCQ6VI+6B
         8s34KnSNtl+EPVJbXihpinWwU8WTt9jHRgbGA6iQQrluPQ3LmE34fF4TWoTRqWpu9Rxh
         LWX0XnZ63TgFPEthq3NcNfTWWKwoEIS+tZEgwrY+e8HPegkzBjxoKwOaltx9Q70elMPF
         8dUPFNzFZaspakD6GwAL5x+4GoeoITMOt7+1wUbjQi6hwutYNp6GaQqHclSsrCEAiqcu
         GW5zKmU8OafJp3lU7f6AR1jtWBW2LriY43eXRjwDTzM30LC7xogoWFp15tHJjqXhXX1i
         25eg==
X-Gm-Message-State: APjAAAW9/q32RyjbsKLHn72OQJ/C8FiJyBfFZMTxFCL3rZC/RZDLJYnl
        UJjqcGe6OStQLFujm1AWkXsJhw==
X-Google-Smtp-Source: APXvYqxIUbNfZlyWSJBVE/SZU0lkItuaE4PpAJYXt+4cCPd4ZGelq2hMgNLIhUxE5oI1+n7kdEp48w==
X-Received: by 2002:a2e:425b:: with SMTP id p88mr19619041lja.78.1552412036520;
        Tue, 12 Mar 2019 10:33:56 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id j5sm1473609ljg.47.2019.03.12.10.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 10:33:56 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] irqchip/gic-v3-its: drop redundant initialization in mk_lpi_range
Date:   Tue, 12 Mar 2019 18:33:48 +0100
Message-Id: <20190312173350.4025-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312173350.4025-1-linux@rasmusvillemoes.dk>
References: <20190312173350.4025-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason to ask kmalloc() to zero the allocation, since all
the fields get initialized immediately afterwards. Except that there's
also not any reason to initialize the ->entry member, since the
element gets added to the lpi_range_list immediately.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/irqchip/irq-gic-v3-its.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5c8232cff290..2ebc28a53d96 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1465,9 +1465,8 @@ static struct lpi_range *mk_lpi_range(u32 base, u32 span)
 {
 	struct lpi_range *range;
 
-	range = kzalloc(sizeof(*range), GFP_KERNEL);
+	range = kmalloc(sizeof(*range), GFP_KERNEL);
 	if (range) {
-		INIT_LIST_HEAD(&range->entry);
 		range->base_id = base;
 		range->span = span;
 	}
-- 
2.20.1

