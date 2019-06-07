Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAC1C468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D426208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpm6iVMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbfFGSZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:25:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33326 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731759AbfFGSZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:25:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id x15so1665787pfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ughYalIGjkGsb98cUH1P99ZWcKHBcsvb9srQAxeeo2s=;
        b=jpm6iVMCznr2vRYrorTPJP89oxr89YawAel6X5Azs1gy8vXeiCWt7zBZGY7b3ebpsk
         FnUPKUZtQyaygKK2Bv4Pj1SVxnfQttx4WZ7czUTIaM4gvEu57zMPvMcW3h2wZs+7xGJL
         Q9/OLmCotuxiwUGXIc2eQ660Q3cMPr6XaHyZyx2Z4cnkxLV57+VuNH1uTWbNQ9vJhTjj
         HKpBQHrF7lSCvl3r2BSURh86HrqAHmMn+f9gW+TCFbb3ZkZMfyalbbQWfOe+CQOkNMNd
         Ig5jcjQA8xohIgJ65/0t4FzHKZ5bkntCWtd476L5TjZZVVG4AC5fxjRH98Bg5+ysmMVL
         nTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ughYalIGjkGsb98cUH1P99ZWcKHBcsvb9srQAxeeo2s=;
        b=SfOE7qPRYBOw/7r/1R7/v+f/MXGX1F51AhQokK+N2Y0A2Uk7gJmo4vCE7nZUB9Fb44
         0pN69vBjMb4WTDCPG9/9okuDwOJrNPQ7BniWrZi7NwGG+b5srxW7eo8YqcsFnXNw9UhY
         x0fVmpTxSOfVNaOeUnZPHhkBSk3whqQCiygimKHUnboRHAErEqrucuxXFB2xVOsSA5td
         e4w0dVDak1SPh2WasnypKy4SeJrCUPP746te1JtD9vgFr8tfyf+fmI2DgKJQpOZNKkGg
         yKbKw2e1aE2JSUW32nxFXCjWFznQUEQsVW1+YXKZikT35Qxka6lt3E5bNoiK7pjHYJCA
         x3CA==
X-Gm-Message-State: APjAAAXZH03bKFVBC7qdFCNOuh+f7dlzCZ3h1f+GvlZnpkw2bEuqgRco
        AOJiMX55Z6QvSdFyTufUo60uqwOp/JQ=
X-Google-Smtp-Source: APXvYqyOIEqpIyOsbHsg5sC1NUkTYO3xXp3lP33MPJtyFyNJu3ypqPoL5MYQlCTYk9G8/i64uOQkQA==
X-Received: by 2002:a17:90a:9305:: with SMTP id p5mr7309230pjo.33.1559931927296;
        Fri, 07 Jun 2019 11:25:27 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id v64sm2788877pjb.3.2019.06.07.11.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 11:25:26 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tytso@mit.edu, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/5] random: convert to ENTROPY_BITS
Date:   Fri,  7 Jun 2019 14:25:14 -0400
Message-Id: <20190607182517.28266-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190607182517.28266-1-tiny.windzz@gmail.com>
References: <20190607182517.28266-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to enhance code readability.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/char/random.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index bebf622c61c4..d714a458f088 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -788,7 +788,7 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 			if (entropy_bits < 128)
 				return;
 			crng_reseed(&primary_crng, r);
-			entropy_bits = r->entropy_count >> ENTROPY_SHIFT;
+			entropy_bits = ENTROPY_BITS(r);
 		}
 
 		/* initialize the blocking pool if necessary */
@@ -1396,8 +1396,7 @@ EXPORT_SYMBOL_GPL(add_disk_randomness);
 static void _xfer_secondary_pool(struct entropy_store *r, size_t nbytes);
 static void xfer_secondary_pool(struct entropy_store *r, size_t nbytes)
 {
-	if (!r->pull ||
-	    r->entropy_count >= (nbytes << (ENTROPY_SHIFT + 3)) ||
+	if (!r->pull || ENTROPY_BITS(r) >= (nbytes << 3) ||
 	    r->entropy_count > r->poolinfo->poolfracbits)
 		return;
 
@@ -1435,8 +1434,7 @@ static void push_to_pool(struct work_struct *work)
 					      push_work);
 	BUG_ON(!r);
 	_xfer_secondary_pool(r, random_read_wakeup_bits/8);
-	trace_push_to_pool(r->name, r->entropy_count >> ENTROPY_SHIFT,
-			   r->pull->entropy_count >> ENTROPY_SHIFT);
+	trace_push_to_pool(r->name, ENTROPY_BITS(r), ENTROPY_BITS(r->pull));
 }
 
 /*
@@ -1479,8 +1477,7 @@ static size_t account(struct entropy_store *r, size_t nbytes, int min,
 		goto retry;
 
 	trace_debit_entropy(r->name, 8 * ibytes);
-	if (ibytes &&
-	    (r->entropy_count >> ENTROPY_SHIFT) < random_write_wakeup_bits) {
+	if (ibytes && ENTROPY_BITS(r) < random_write_wakeup_bits) {
 		wake_up_interruptible(&random_write_wait);
 		kill_fasync(&fasync, SIGIO, POLL_OUT);
 	}
-- 
2.17.0

