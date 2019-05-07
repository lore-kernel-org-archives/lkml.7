Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C959C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32F0214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X5pMDITU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfEGNwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:52:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43571 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfEGNwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:52:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id z5so9305398lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 06:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EPoQzBkQ1zE8s4c5QnnroYpNiup0CqZzX75YiTbdOcw=;
        b=X5pMDITU4xTUs89FyUbKVNxI1dULz4AchGJsemeGQeKc974oo/8x4x0zzmlkeHTaxj
         grSzokQ6vtz5jBMDMvTO9Z36j6B8BXtOhbbBOg+BZ23T6PYYVZwwnGyUhesuFl/W9zfG
         yp59GbVoJwWmOQ/fP6SyHuTGTWZj0gAZVpmFHZ31KbbssKZQO0cpwbZ2CLZk1PYrM/I0
         XXEQ1VUHCiqxOhUom8BAeCfgOMTkZwZJCiCME2mqAhkjHeImP8r2644ei07kgIx2G3Bn
         9F2OQoSAEuvUZu4+svzZ7kynaEgTqbGY1MTmkCrXDRR7BcUyY/UhgOcANbkBobijooqO
         ULQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EPoQzBkQ1zE8s4c5QnnroYpNiup0CqZzX75YiTbdOcw=;
        b=AMtYecYfZ8HrpaI6lAGUOqqRsV7ZSqLKR33Bj+JgGKqiznfQaigRFhuPr8+doKz1aV
         yX+1VfxHN5bx22zaQNCkiRBBn2wh6Ipc03pnTugLPa7mdzpFTyjlP1lo0gudFThYkdAh
         Dt2/YePEh2CE6s+3gMnVPPpHae8TbyxdRYqcKBhidE4OyxAOhmUI6aQJUrnr0lHgqoCd
         znYp7+r4hmfSAVPOSRWsMqM2B9kw8Z/2vW8qCOOHvMdd0m0kKVa5COL28wqMxdkz5zbS
         DQRTzq7ZZ5DZKoaJ7VIQV8FWjFqXFnVY3H5J8dz9+XgjvK05+3Y6ue/YA8QBurF5eKUR
         fzFA==
X-Gm-Message-State: APjAAAXEplKhB4DM6/CNWyhmeZmlqwzbgEyOGc/XN7Dh6+o1JF8otB6r
        KK24b3qVlb0XO3UGCDUr23fmnw==
X-Google-Smtp-Source: APXvYqwL5VVD5HrXGmF8UXa/9xftqtUkp+btSbcvAplwC3Cf+NfkBstfI19ADxWgZSyKa78GKtn/kA==
X-Received: by 2002:a2e:9155:: with SMTP id q21mr15689530ljg.178.1557237162934;
        Tue, 07 May 2019 06:52:42 -0700 (PDT)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id r11sm559871ljd.77.2019.05.07.06.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 06:52:42 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     alexander.shishkin@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] intel_th: msu: fix unused variables
Date:   Tue,  7 May 2019 15:52:33 +0200
Message-Id: <20190507135233.31836-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building and CONFIG_X86 isn't set the compiler rightly complains
about an unused varable 'i', see the warning below:

../drivers/hwtracing/intel_th/msu.c: In function ‘msc_buffer_win_alloc’:
../drivers/hwtracing/intel_th/msu.c:783:21: warning: unused variable ‘i’ [-Wunused-variable]
  int ret = -ENOMEM, i;
                     ^
../drivers/hwtracing/intel_th/msu.c: In function ‘msc_buffer_win_free’:
../drivers/hwtracing/intel_th/msu.c:863:6: warning: unused variable ‘i’ [-Wunused-variable]
  int i;
      ^

Rework so that an else part is added where empty functions are created
for set_memory_uc() and set_memory_wb(), in that way we could remove
'#ifdef CONFIG_X86' in function msc_buffer_win_alloc() and
msc_buffer_win_free().

Fixes: ba39bd830605 ("intel_th: msu: Switch over to scatterlist")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/hwtracing/intel_th/msu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 81bb54fa3ce8..5e839d52df87 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -21,6 +21,11 @@
 
 #ifdef CONFIG_X86
 #include <asm/set_memory.h>
+#else
+static void set_memory_uc(unsigned long addr, int numpages)
+{}
+static void set_memory_wb(unsigned long addr, int numpages)
+{}
 #endif
 
 #include "intel_th.h"
@@ -811,11 +816,9 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 	if (ret < 0)
 		goto err_nomem;
 
-#ifdef CONFIG_X86
 	for (i = 0; i < ret; i++)
 		/* Set the page as uncached */
 		set_memory_uc((unsigned long)msc_win_block(win, i), 1);
-#endif
 
 	win->nr_blocks = ret;
 
@@ -870,11 +873,9 @@ static void msc_buffer_win_free(struct msc *msc, struct msc_window *win)
 		msc->base_addr = 0;
 	}
 
-#ifdef CONFIG_X86
 	for (i = 0; i < win->nr_blocks; i++)
 		/* Reset the page to write-back */
 		set_memory_wb((unsigned long)msc_win_block(win, i), 1);
-#endif
 
 	__msc_buffer_win_free(msc, win);
 
-- 
2.20.1

