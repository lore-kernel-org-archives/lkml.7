Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86732C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494D920818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7ZOC0g3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfKLTSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:18:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39501 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfKLTSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:18:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id l7so8243628wrp.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 11:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oXIfziVZw7Y8YB+U/H+A8E7j7mdgw7KPd8TkxpnLw/w=;
        b=o7ZOC0g3VEfY8wREMzeySe9Dh5QhqIpKo2YMTVSS+gQTEI84LsqPuLHuJsdh5uGqCW
         KsA6nuAqnPA5URCV+Oj3B/2lVfU2XgAjEbIPI3er/XY9f5uXZFEAarXycWmXRgEF3F/l
         pbQNT7vffch4MO40SxYIdzJx5pw3NMIaAcBZpej70dTC7TLsTu+D34cxPtoO5LqxArro
         Pjozy5H11OuFqBqJSTi4aUC13njlni1EJRx0BKjzUniGtO4D+vVlCoWYlDzMBPRgHU6R
         aLgD4SkRpwOkbVvg7pngpR76gZCL6PdsyzHq54RnBsPkxlvcZKFYOHII2t77sGUtZ31j
         9tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oXIfziVZw7Y8YB+U/H+A8E7j7mdgw7KPd8TkxpnLw/w=;
        b=hvFdmrzRttNzhPPuRcYUmQE6fHUiTboKDt1YoRrcKecKHf6a0Zk3a1B283HQ31ZTnm
         1ZmfADVvrIMZcvilunWaygPQ84gTBfmovxZhHUVFo6lzCfXSs8FSJe0AvgET40a7z6xW
         X44ODmR781VB95ULWxidT7Il6m65pHInh+3zgrahkM0UALmvwopIql3otUoTkF7Kjwle
         QbVEBGi2um+tCHIXotGfagDh1EfftKftBAb4gb4FUJtTi8QEGrz6YT7ZuVT+M7oaoT8/
         XZj5phgpx8couCwWm+558vNqLc9nRcYbXzCnfF+1ghS+xaI9CojN8mtBqFopMda0q6Tg
         QQwQ==
X-Gm-Message-State: APjAAAWoJP0ntP1qVlV0BQsGp7yH3Msc1kKZzUz7HajHIPRjx4rRt/nw
        Qja5c+d5OyjwyjneU1Lk36sBFmhJRUY=
X-Google-Smtp-Source: APXvYqwh1DxMBAiiArhj1BLtmYLNvW+fu1PXXz7MICsQ28Ustudx7b1fleNwOElvrjX69g9euasPJA==
X-Received: by 2002:a5d:678f:: with SMTP id v15mr560972wru.242.1573586289862;
        Tue, 12 Nov 2019 11:18:09 -0800 (PST)
Received: from localhost.localdomain ([141.226.31.91])
        by smtp.gmail.com with ESMTPSA id t134sm4565850wmt.24.2019.11.12.11.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 11:18:09 -0800 (PST)
From:   Ramon Fried <rfried.dev@gmail.com>
To:     tytso@mit.edu, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH] random: switch pr_notice with pr_info
Date:   Tue, 12 Nov 2019 21:17:25 +0200
Message-Id: <20191112191724.13818-1-rfried.dev@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because there's no need to shout that loud.
In a lot of systems pr_notice ends up also on the console
especially in embedded systems, where it just annoying
to get the "fast init done" just when you type a command
in the terminal.

Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
---
 drivers/char/random.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index de434feb873a..a619002f96af 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -885,7 +885,7 @@ static void crng_initialize(struct crng_state *crng)
 		invalidate_batched_entropy();
 		numa_crng_init();
 		crng_init = 2;
-		pr_notice("random: crng done (trusting CPU's manufacturer)\n");
+		pr_info("random: crng done (trusting CPU's manufacturer)\n");
 	}
 	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
 }
@@ -948,7 +948,7 @@ static int crng_fast_load(const char *cp, size_t len)
 		invalidate_batched_entropy();
 		crng_init = 1;
 		wake_up_interruptible(&crng_init_wait);
-		pr_notice("random: fast init done\n");
+		pr_info("random: fast init done\n");
 	}
 	return 1;
 }
@@ -1033,15 +1033,15 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
 		crng_init = 2;
 		process_random_ready_list();
 		wake_up_interruptible(&crng_init_wait);
-		pr_notice("random: crng init done\n");
+		pr_info("random: crng init done\n");
 		if (unseeded_warning.missed) {
-			pr_notice("random: %d get_random_xx warning(s) missed "
+			pr_info("random: %d get_random_xx warning(s) missed "
 				  "due to ratelimiting\n",
 				  unseeded_warning.missed);
 			unseeded_warning.missed = 0;
 		}
 		if (urandom_warning.missed) {
-			pr_notice("random: %d urandom warning(s) missed "
+			pr_info("random: %d urandom warning(s) missed "
 				  "due to ratelimiting\n",
 				  urandom_warning.missed);
 			urandom_warning.missed = 0;
-- 
2.23.0

