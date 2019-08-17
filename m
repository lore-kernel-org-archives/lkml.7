Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCC8C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 06:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830B62173B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 06:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g43AWVJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfHQGgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 02:36:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44132 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfHQGgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 02:36:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id c81so4217971pfc.11;
        Fri, 16 Aug 2019 23:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+PI8xYMmQT6NNfDdweNs9HSTX3tHpoVnE9BvBVMxdZU=;
        b=g43AWVJbUtAHfp+VhCn/tGUNOVJfJhi3m84lkIc/VGINdE9clGUqqmWUc38kITDIeX
         sCDp1vCgdJzOXtR2EAsq4tOU/nRWv+t+1dWBMRa88YKIUbEd9d1KxoosXN79041AX9Pf
         PYzqs5x2L2MOSMdOroQ6yEhnu6ILfeNo82cvGoOaxKUL95cnmm2wJuJTE0i2zOHXDaKk
         yaQuAxuAwT1Pb+4YgYsR80PaGIkbf1pwP3hjK/ZbbgaoafEtx8lbZM7b0+eYp7EPMsnO
         ZVvGxf5C4Je/24/L44c5z0QuMYDAulErQtmGMUIjzK+GmN1VpbdmR1C5r3SFyaOOj4k/
         sjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+PI8xYMmQT6NNfDdweNs9HSTX3tHpoVnE9BvBVMxdZU=;
        b=e3Alk9b5AspuX07OJSgWkiODghpztStaDERJFpqp6O0Z7WRMRLLk8qnSEeIwScM+t6
         Uj4wJX4lKl/P7cmnElSYGzlR+kORCXQorgUVTJaDZGcU9GPJk+nO/kiY/szEV/vgKnbT
         DfSrqjxXl/64gKEMOP2yLzAG3gefvJAEtYLUgVLmalUoZZhDDv5HhRgEGlhWNouJVudr
         I6C+5TDC3QAyTFJa6vSFwynptN4byQMvdFwUvrIjydcaY/YTY6suWnmpa5mGweBW7POD
         LdkgvSq+g4mFPlVzvlX4LZr2GBJEMa+Ql6KCE1fjzcYX9J7SN22fVMPxGIycx/C5BsTW
         DwNw==
X-Gm-Message-State: APjAAAUCeDYf670FbXC4j0IfLexgGwVBX4GLwNLHgjN5bQw1sePeeFIF
        IxuFCVUQh+FzWOW7SfREzn/PEB1rNkA=
X-Google-Smtp-Source: APXvYqzDGz3eQNNY21M/ZZKpG6/ZSsKwVyqgoHxV2L4+EivxjgniJm5fCYsdrW234k7PrAp/5Ln7dw==
X-Received: by 2002:a62:4e09:: with SMTP id c9mr14974770pfb.130.1566023769267;
        Fri, 16 Aug 2019 23:36:09 -0700 (PDT)
Received: from localhost.localdomain ([106.51.107.242])
        by smtp.gmail.com with ESMTPSA id e5sm7135942pgt.91.2019.08.16.23.36.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Aug 2019 23:36:08 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH] clk: Remove extraneous 'for' word in comments
Date:   Sat, 17 Aug 2019 12:05:59 +0530
Message-Id: <1566023759-7880-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An extra 'for' word is grammatically incorrect in the comment
'verifying ops for multi-parent clks'. This commit removes
this extra for word.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c099070..bea50ee 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2437,7 +2437,7 @@ static int clk_core_set_parent_nolock(struct clk_core *core,
 	if (core->parent == parent)
 		return 0;
 
-	/* verify ops for for multi-parent clks */
+	/* verify ops for multi-parent clks */
 	if (core->num_parents > 1 && !core->ops->set_parent)
 		return -EPERM;
 
-- 
2.7.4

