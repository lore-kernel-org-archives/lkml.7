Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAB9CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CD520856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="DxCT0iIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfJ3SeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:34:02 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43408 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfJ3SeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:34:01 -0400
Received: by mail-yw1-f65.google.com with SMTP id g77so1179399ywb.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=G5U04p/Pz8N9/yMXvmIpSk5e/OvzTbOVT3JtlMr0icw=;
        b=DxCT0iIj6RQ9VKyRm40z3YMkepG7E5oOVO2fRCEshteIKSua9HarbmBCs8c2UphlMY
         BvD3Zf2OXAjp3pKMfKtUHGMoihPM4wmO/TPdmtQpPiztEv/fAAxciOx1H9dPhmPp8ISk
         piHgBijvMqvyJMq5qq6yZ3yuP/lT9TFqzxg7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=G5U04p/Pz8N9/yMXvmIpSk5e/OvzTbOVT3JtlMr0icw=;
        b=GpOa8cSv1kYeqh91SFfzgjjcQBjCu4StuptxRPLXB/amv5hVuS+6EZUQrKTX9HHZ4S
         EuZNEGBebY+CkM+3Ld0Ou16ZcAX94HmL1WJq/WQxaBUzVjvd59x7rPCyn+NXp6DL64xS
         Mc/Gl/1rNmSS/XfSZtobD6aYWtN5xKNDc6f5u3eP0ODK8WCX2TPhF7H7vm3zx2AsnJ9D
         mBhMTrOeW3Hz3g49oYYKcdVHOYerZVUWJ9UnpDmlYvsIm4tPyH8STiLOOuRtjVyICDcr
         qIF2tt5bvjxsJcer8845uF4w5blufHzFVhw9Mzcf8jCMaCpMxUJqOywm6uwsdXkLcB5K
         I0uw==
X-Gm-Message-State: APjAAAVmMGc0uEwXr1zyPolRr1+nZActKcSU/7yQLK/tX9dp+gvX7Lm7
        hB/FunRCe0yCYadxdifUKHoe2A==
X-Google-Smtp-Source: APXvYqw5nvzXK7JdGlveg5tNGL1510L1AVWCigxJM21uFulvsBTwqa2P4cDOesp5ldJbOuNAgF6WoA==
X-Received: by 2002:a81:455:: with SMTP id 82mr860134ywe.14.1572460438713;
        Wed, 30 Oct 2019 11:33:58 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id y142sm1076279ywy.80.2019.10.30.11.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 11:33:58 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Dario Faggioli <dfaggioli@suse.com>,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v4 02/19] sched: Fix kerneldoc comment for ia64_set_curr_task
Date:   Wed, 30 Oct 2019 18:33:15 +0000
Message-Id: <d23db9c71a9b3310edb4da3765926d2fc3fc3ae5.1572437285.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index df9f1fe5689b..8225ddba344e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6705,7 +6705,7 @@ struct task_struct *curr_task(int cpu)
 
 #ifdef CONFIG_IA64
 /**
- * set_curr_task - set the current task for a given CPU.
+ * ia64_set_curr_task - set the current task for a given CPU.
  * @cpu: the processor in question.
  * @p: the task pointer to set.
  *
-- 
2.17.1

