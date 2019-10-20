Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F798CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 12:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA97D21927
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 12:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="QLbN55Fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfJTMdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 08:33:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44774 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfJTMdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 08:33:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id z9so10787307wrl.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 05:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nxh5NV2AmNEFTz2ISM0chZMRRCcl5MowgBSMrJDBPQA=;
        b=QLbN55FbN+5aCDgcspedlQWEDht7Bomwc6LjA6JcVmV46rYLS+OCOkZvnNDEMy5uik
         kgUUwW2V2WSnWxgwcDLuFshRhfCEMouRtPSRK67oZYOpGsiQakyI6tSdhDG3mKE4RNkR
         Qo92Scq4vX9EP0bPnxb+Z7RxKFCQKnsAm5r3HwueysyQ2cV5agXZXZKDHmZp+9vZs4+K
         TE5DcQD/zSd6aSEKotpzC8jOX5SPhJ1B1LPlaTQLJ2TMEBItd4y+MuG9pM8C9R7UkHrP
         nG0NHxWUEYVEoyZAOGq0X2WMI1qL5rZdoI5RjSBHPeij2ldmLjqyAtM8hsfYVRzwgVZo
         3OzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nxh5NV2AmNEFTz2ISM0chZMRRCcl5MowgBSMrJDBPQA=;
        b=SVO46kCVcjCZiPq4LxIxg4laKhgFTwug7WOtVcNObLOZyLX2A1oaaTk0B4jMRzPxS/
         l4kZBqm8hL03UblKxw1IF3UU+eYDY77bLwojuRZrMSUByetikd72yX5r4ETNpPrVBGNw
         BhkvTJJmUjvr7BIEfjpdAjnnxs/mey2UNp/cIKTgJ+ukrIPsFgVEXTMBy6dZT0QatesR
         /WC1jGVtaUTCGEEGjrUYEPF4O0PGD/4ukj67Qboh/8A9WFkjB1Jrb0lm8kjoy8rWeFCm
         5fAnWXBwYcNtKBYK/gfyp/we3ukVc5fZE4ImqrH28TaRApzUz8Q34zq2h1RWfvUZFu6e
         vp8w==
X-Gm-Message-State: APjAAAXdj9pYojaH9BHitzArd45psmz1mxH4i/aO4gzseW0ilQcGKOWu
        sPzKoLOM7UIwRPvreCwY/KiRYHyIrjA=
X-Google-Smtp-Source: APXvYqyTO3HhFtFuCZ3TCQvKH+VkNtZT9SzTHt8rytbwml8c1VH9rKKV/i6d/fx6ZdCfMKCxDSJd/Q==
X-Received: by 2002:adf:e886:: with SMTP id d6mr16040198wrm.188.1571574798617;
        Sun, 20 Oct 2019 05:33:18 -0700 (PDT)
Received: from linux.fritz.box (p200300D99703FC00226A5479D1389944.dip0.t-ipconnect.de. [2003:d9:9703:fc00:226a:5479:d138:9944])
        by smtp.googlemail.com with ESMTPSA id t13sm15065400wra.70.2019.10.20.05.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 05:33:17 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 1/5] smp_mb__{before,after}_atomic(): Update Documentation
Date:   Sun, 20 Oct 2019 14:33:01 +0200
Message-Id: <20191020123305.14715-2-manfred@colorfullife.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020123305.14715-1-manfred@colorfullife.com>
References: <20191020123305.14715-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding the _{acquire|release|relaxed}() variants of some atomic
operations, it was forgotten to update Documentation/memory_barrier.txt:

smp_mb__{before,after}_atomic() is now intended for all RMW operations
that do not imply a memory barrier.

1)
	smp_mb__before_atomic();
	atomic_add();

2)
	smp_mb__before_atomic();
	atomic_xchg_relaxed();

3)
	smp_mb__before_atomic();
	atomic_fetch_add_relaxed();

Invalid would be:
	smp_mb__before_atomic();
	atomic_set();

In addition, the patch splits the long sentence into multiple shorter
sentences.

Fixes: 654672d4ba1a ("locking/atomics: Add _{acquire|release|relaxed}() variants of some atomic operations")

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 Documentation/memory-barriers.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 1adbb8a371c7..fe43f4b30907 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1873,12 +1873,16 @@ There are some more advanced barrier functions:
  (*) smp_mb__before_atomic();
  (*) smp_mb__after_atomic();
 
-     These are for use with atomic (such as add, subtract, increment and
-     decrement) functions that don't return a value, especially when used for
-     reference counting.  These functions do not imply memory barriers.
-
-     These are also used for atomic bitop functions that do not return a
-     value (such as set_bit and clear_bit).
+     These are for use with atomic RMW functions that do not imply memory
+     barriers, but where the code needs a memory barrier. Examples for atomic
+     RMW functions that do not imply are memory barrier are e.g. add,
+     subtract, (failed) conditional operations, _relaxed functions,
+     but not atomic_read or atomic_set. A common example where a memory
+     barrier may be required is when atomic ops are used for reference
+     counting.
+
+     These are also used for atomic RMW bitop functions that do not imply a
+     memory barrier (such as set_bit and clear_bit).
 
      As an example, consider a piece of code that marks an object as being dead
      and then decrements the object's reference count:
-- 
2.21.0

