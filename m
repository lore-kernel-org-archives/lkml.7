Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA38C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53F4206DE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AWvrPwxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389711AbfIEQlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:41:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33176 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389171AbfIEQlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:41:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so2130538pfl.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 09:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+vE/xgq+/pjwKf8dfb2af/ZSiNrPKjB3ZwnjuHKxh+M=;
        b=AWvrPwxFX1/Q8s8cSwYNJOo0vrKppZiENlQpkaiPEQ2JYZS5lWq5Z2vDi7AsX1zCLW
         Nvu6jA/eDGPnrFojK14zGC20vRKhNafMGTEJwukIJ/vlaPD/ife4+h34NFTqDtIoiGKn
         lW295l8jAE/tibwqfChidrQQOP13hur3oVsPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+vE/xgq+/pjwKf8dfb2af/ZSiNrPKjB3ZwnjuHKxh+M=;
        b=L9WV5i5c8Vdmmc6p5a8bvldtz8ROilfzlqmFFEBCHkura3ziLsMW2eQX85tcxdKK1A
         Yuem2eYySMYB5bijmwAuK/LAXKgmWdw6q00FRr95cCWeYEEP3ArC/TM3MQYBgr7xM6sB
         fZBEl28RgEfTq1Y/FlUTrWWAMgLClZgrNix+ulS0Vxgv+u51OHDoZD2PNcJI5fnTWDuu
         0dOpdyt0gM4imB+u9B7xGyh5vmCY/zgIo6+UgSG1SErPPvRqLfaHySqxreP1WXuF5jHZ
         /nCjkokJrRUBfTX12y6T/caTTo/0HLO/H1a1kxWsrL8O6rKLP7E8hxNZMJJnat1Oie6/
         HO4Q==
X-Gm-Message-State: APjAAAUf66kq+gX9f38tpnYjmvROeLHUVaxDdMz2KJTs6gUx99KWApQM
        acAIk3jqp8GUgeyQZHw30BtTgQ==
X-Google-Smtp-Source: APXvYqzbl/dgUIkoIncTvp0wI0Dzxf5yKuX2pH6zBh62SAMuFpYC8Nvl6x+3TLdpYI4Mj4kPxmn3Hg==
X-Received: by 2002:a17:90a:630a:: with SMTP id e10mr4784273pjj.25.1567701674170;
        Thu, 05 Sep 2019 09:41:14 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id f12sm2663012pgo.85.2019.09.05.09.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 09:41:13 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        linux-crypto@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Keerthy <j-keerthy@ti.com>
Subject: [PATCH] random: Use wait_event_freezable() in add_hwgenerator_randomness()
Date:   Thu,  5 Sep 2019 09:41:12 -0700
Message-Id: <20190905164112.245886-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian reports that after commit ff296293b353 ("random: Support freezable
kthreads in add_hwgenerator_randomness()") we can call might_sleep() when the
task state is TASK_INTERRUPTIBLE (state=1). This leads to the following warning.

 do not call blocking ops when !TASK_RUNNING; state=1 set at [<00000000349d1489>] prepare_to_wait_event+0x5a/0x180
 WARNING: CPU: 0 PID: 828 at kernel/sched/core.c:6741 __might_sleep+0x6f/0x80
 Modules linked in:

 CPU: 0 PID: 828 Comm: hwrng Not tainted 5.3.0-rc7-next-20190903+ #46
 RIP: 0010:__might_sleep+0x6f/0x80

 Call Trace:
  kthread_freezable_should_stop+0x1b/0x60
  add_hwgenerator_randomness+0xdd/0x130
  hwrng_fillfn+0xbf/0x120
  kthread+0x10c/0x140
  ret_from_fork+0x27/0x50

We shouldn't call kthread_freezable_should_stop() from deep within the
wait_event code because the task state is still set as
TASK_INTERRUPTIBLE instead of TASK_RUNNING and
kthread_freezable_should_stop() will try to call into the freezer with
the task in the wrong state. Use wait_event_freezable() instead so that
it calls schedule() in the right place and tries to enter the freezer
when the task state is TASK_RUNNING instead.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Keerthy <j-keerthy@ti.com>
Fixes: ff296293b353 ("random: Support freezable kthreads in add_hwgenerator_randomness()")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

See https://lkml.kernel.org/r/20190904110038.2bx25byitrejlteu@flow for
context on the bug report.

 drivers/char/random.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 9b54cdb301d3..d3beed084c0a 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -327,6 +327,7 @@
 #include <linux/percpu.h>
 #include <linux/cryptohash.h>
 #include <linux/fips.h>
+#include <linux/freezer.h>
 #include <linux/ptrace.h>
 #include <linux/workqueue.h>
 #include <linux/irq.h>
@@ -2429,7 +2430,6 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
 				size_t entropy)
 {
 	struct entropy_store *poolp = &input_pool;
-	bool frozen = false;
 
 	if (unlikely(crng_init == 0)) {
 		crng_fast_load(buffer, count);
@@ -2440,13 +2440,11 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
 	 * We'll be woken up again once below random_write_wakeup_thresh,
 	 * or when the calling thread is about to terminate.
 	 */
-	wait_event_interruptible(random_write_wait,
-			kthread_freezable_should_stop(&frozen) ||
+	wait_event_freezable(random_write_wait,
+			kthread_should_stop() ||
 			ENTROPY_BITS(&input_pool) <= random_write_wakeup_bits);
-	if (!frozen) {
-		mix_pool_bytes(poolp, buffer, count);
-		credit_entropy_bits(poolp, entropy);
-	}
+	mix_pool_bytes(poolp, buffer, count);
+	credit_entropy_bits(poolp, entropy);
 }
 EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
 
-- 
Sent by a computer through tubes

