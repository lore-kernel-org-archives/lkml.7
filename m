Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3492BC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E74217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFRoasOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfDKDfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:35:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43947 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDKDfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:35:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id z9so2766140pgu.10;
        Wed, 10 Apr 2019 20:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OZv6hPSdAHA1swD7FEOslfLZwpmxkzvHikN4MHT7irA=;
        b=GFRoasOJpQPhb1awaLCimBo3kHfJqM/1lwpjAHrqrbcV2K+UypQ9VoQ4tqQFmPBjXG
         8cFfeFW2+OteM9nQdV1xiJGEH0T2q77N39kDTdDvrAdSFHmP71mkI6SvQo6M8rP5WP/S
         hwAF3woe91WxKgGqQzX0eAeqwt7XapDdM+GNHU245hYv72pf0iH/2zVyggIe8s3x/oC5
         2y7pblvESq1nEX0tlN0U0nZSHhGN4kenlzLA7eqyV8j2WV8RuXaA4iPhbDsWgsYWtg9R
         j7kPVDVZBztHEo/NXUdDULwsHooEdlqV2RnDFg0Ym2QyHpikiwo8oKB3NXqM+IBZB40/
         l+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZv6hPSdAHA1swD7FEOslfLZwpmxkzvHikN4MHT7irA=;
        b=ZvfGVEdttCv27Hm0XphCQroIjYO5xSmJ4thYvFG1eKu6zJ52ucASpFRGYhUpqwOiF/
         UutTiawykwCaEHv/ISsOLhNywvxjJv21T37fS8o9V6pKLiHEnP15BtpbZ5819SFJs3KZ
         ff35a2+jhZrt6/fXnICgKeOhRfT30WqwTRrgO2lK81gmKg08xik39I6Tx/pEcRbR8Shl
         7W4nyLQnKueTTHCB/pYp/g97e508iR0lBKKJ9EzBU4PWNp0E+1G8qenEiqt1bZe2LGTY
         lPmEHn6w+VLwKI2wSoGx2kKrAseo1gokWN5ceFBSJBbXJibQf/p3tpalD8MuauhYFZVZ
         Z3Mg==
X-Gm-Message-State: APjAAAWcUbQ5CzZXU7yN47+q1DBxJbpuiO3J9+6lPklAJIMUfr5UzhN3
        9fSE8UmeWoulvmKTiV5Uowc=
X-Google-Smtp-Source: APXvYqwsc0FdRw26an9Arfnk9WRkzB4Ut2g6Vqasz3X3ajdkvlglSDeRCCpSAsQLD70uhmqFVpdwhw==
X-Received: by 2002:a65:64c9:: with SMTP id t9mr44251725pgv.221.1554953707587;
        Wed, 10 Apr 2019 20:35:07 -0700 (PDT)
Received: from bobo.local0.net ([203.63.188.231])
        by smtp.gmail.com with ESMTPSA id b9sm37231416pfd.32.2019.04.10.20.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 20:35:06 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/5] sched/core: allow the remote scheduler tick to be started on CPU0
Date:   Thu, 11 Apr 2019 13:34:44 +1000
Message-Id: <20190411033448.20842-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411033448.20842-1-npiggin@gmail.com>
References: <20190411033448.20842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has no effect yet because CPU0 will always be a housekeeping CPU
until a later change.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4778c48a7fda..10e05ec049b6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5918,7 +5918,7 @@ void __init sched_init_smp(void)
 
 static int __init migration_init(void)
 {
-	sched_rq_cpu_starting(smp_processor_id());
+	sched_cpu_starting(smp_processor_id());
 	return 0;
 }
 early_initcall(migration_init);
-- 
2.20.1

