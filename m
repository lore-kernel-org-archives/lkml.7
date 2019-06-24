Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86924C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F801213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="FemFmQ7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbfFXOAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:00:01 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37240 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfFXN77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:59:59 -0400
Received: by mail-qt1-f193.google.com with SMTP id y57so14567627qtk.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dWzMR/+6+C4EWqwjO5KWjeZwTByN5HKWQ2XxzDb7fKs=;
        b=FemFmQ7yPWKBWwVEAOB02mKzk5MSGAI03+NQDZM+y7+98Um2i+Qvw3kdsF0CXYxU1A
         SL9eLvEW6JA4QFm6ihB4a18E5gTz8Ys/QUfhYvojfCoqPIwB328nGNc67f4o9arx31pV
         PuDD1H6fCBNEJN/OZdHrwVHE86NX70R4WuRJKNz0RYi5uFjK5bG2Sw+nsoEbFoG6LH4B
         vu88cFligLCRiDZzxzcs9Gh2+zu0gM79mDaqJm99zWz0rK5J+oPmAYtRD2nvDJdAy4Lr
         TVP9DeqY9+EWurns8er3LF3XwP94t/kvuc3uiANYwv8d4myRHbh3BuqFuYR++nfLIkqI
         Wp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dWzMR/+6+C4EWqwjO5KWjeZwTByN5HKWQ2XxzDb7fKs=;
        b=Cp1QNzSKYhoqbXeKwmQnwSdclx488HjKGqGRDalwVI8XknEaqzbU3QLDq+wb5rE+zQ
         pvtUF6WupyT/+7xoxQgQ7Wgw5nhUVuHat/vdycitOu7qEXCzey/meZsINEdX7RwOuXQQ
         P9jjsEeKU26R+EKi69GzIIiAQ0BqYeWBob3I//O2409IB7FpjwpJcfmC5D7YMS5YGMCU
         tUiqz1pdO3bJX/SfvaVXPCg/8pws9XM886ury8fW2tgUSW31V7BIGy2orjmGsEuz+rAU
         YP2YcEXloCt9Sa2okGKpdjR6rF3R8SGzpy8HmyL+ylxwgGcX2HfKAR1G8D3GME+CdWt4
         0wiQ==
X-Gm-Message-State: APjAAAXaVjINoQR80tUNmf4AhnU5Y0UyE/p5vy6qdhfvjIVOn2dLi2vd
        CZpNZCCnMqFkG58QYE0LXqF9tQsDQVo=
X-Google-Smtp-Source: APXvYqzY6veWl6Lpp6nkCmmRG4+1zZyOOfbZOucO6Ic+OpZ10wg4EPb78XxOzVw+/uIch+ILWMQD4g==
X-Received: by 2002:ac8:3637:: with SMTP id m52mr115082761qtb.238.1561384798370;
        Mon, 24 Jun 2019 06:59:58 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d123sm6207749qkb.94.2019.06.24.06.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:59:57 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] sched/core: silence a warning in sched_init()
Date:   Mon, 24 Jun 2019 09:59:41 -0400
Message-Id: <1561384781-12308-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling a kernel with both FAIR_GROUP_SCHED=n and RT_GROUP_SCHED=n
will generate a warning using W=1,

kernel/sched/core.c: In function 'sched_init':
kernel/sched/core.c:5906:32: warning: variable 'ptr' set but not used
[-Wunused-but-set-variable]
  unsigned long alloc_size = 0, ptr;
                                ^~~

It apparently the maintainers don't like the proper fix [1] which
contains ugly idefs, so silence it by appending the __maybe_unused
attribute for it instead.

[1] https://lore.kernel.org/lkml/1559681162-5385-1-git-send-email-cai@lca.pw/

Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/sched/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 874c427742a9..9bbad91b3f01 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5903,7 +5903,10 @@ int in_sched_functions(unsigned long addr)
 void __init sched_init(void)
 {
 	int i, j;
-	unsigned long alloc_size = 0, ptr;
+	unsigned long alloc_size = 0;
+
+	/* To silence a -Wunused-but-set-variable warning. */
+	unsigned long ptr __maybe_unused;
 
 	wait_bit_init();
 
-- 
1.8.3.1

