Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38F8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83AEE20850
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9UAp7PF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfCUH5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:57:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41965 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUH5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:57:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id d25so3774879pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 00:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gN4E+RszNdEs/XGGnrMCPOEE0TDaBFxJ5QKjz55XENw=;
        b=f9UAp7PFPQW52C7cNsKn37V96Rc83XvkHGMziOJI/zL+jYEAMJ4v+Q0mX/wg+XU+qu
         LOVW1zPwsOggPCVm0wIv3LGKGyaTd6/ugkYuogQefXHgrwQaRsDK7147QWNL+oQ2Aq9j
         pPHtmJD/himtwDe2wKm/p3qxNevO2/1j4XShSIDhIE6LhaN/Iin43I+qXJk8ayPFK3OA
         BhkbY3sfXfi4VY+6Ig2oqB0sFrTXvk3YeqfDc/WSko8BdBR/xcQNnOdd0SKxZf3nxI6l
         9mwSJRpOOK1aOK986An/H07st67pHQ9NgTTNPen6q7ZA8SAqKiqIdfEZdiEMcbx3iQNW
         W3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gN4E+RszNdEs/XGGnrMCPOEE0TDaBFxJ5QKjz55XENw=;
        b=Uc+DpuU3+Ubz2vzoXKajEdOMr7WwFV4CMnu2LfOVgcOlwiaUlyo51FA+0n+nOZhVQD
         ls9QFF3N7KgMwB28QZjOC8hvKfesF2UNbpetaoqzyczl8lTQZ/14x0H7YwcCzRuHRn9M
         K9swsCPXrg3IfwhdpIq3IhQKKnK7nd13r/PWyjhBsbTnPRU4QH1Wbn//ASh5FE94T3Ul
         XVB1bgsWd8cCHSRKxt0t774nylJGlte+WuMKmDVAqdRwaPm2PyBPD07LTjc8BOYNDuqR
         f3PtwNvgMGTNtFPrIWm+Mi54EEkmHPPodg/u4uk78BMj3vWaaawooY++ogISDJIHlFq3
         wk/w==
X-Gm-Message-State: APjAAAWY+iDE19fBGCqrpOGux4bOgbA5vQHADXt2J9qLPq30pVt6sHHX
        masy9228QsjoaW8ca0D0hlA=
X-Google-Smtp-Source: APXvYqwo+Vf4lYvqutm/4AprSJDT0H/rmnS6fV8Z293XFGH+fB6VpJCKR+fJjnxyKel2yEh+g0yuMg==
X-Received: by 2002:a62:f94b:: with SMTP id g11mr2026623pfm.199.1553155065325;
        Thu, 21 Mar 2019 00:57:45 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id e184sm6467148pfc.143.2019.03.21.00.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 00:57:44 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, joe@perches.com,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 04/18] locking/lockdep: Remove useless conditional macro
Date:   Thu, 21 Mar 2019 15:57:11 +0800
Message-Id: <20190321075725.14054-5-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190321075725.14054-1-duyuyang@gmail.com>
References: <20190321075725.14054-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since #defined(CONFIG_PROVE_LOCKING) is used in the scope of #ifdef
CONFIG_PROVE_LOCKING, it can be removed.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index db0473d..eeea722 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1678,7 +1678,7 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	return result;
 }
 
-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+#if defined(CONFIG_TRACE_IRQFLAGS)
 /*
  * Forwards and backwards subgraph searching, for the purposes of
  * proving that two subgraphs can be connected by a new dependency
@@ -2056,7 +2056,7 @@ static inline void inc_chains(void)
 	nr_process_chains++;
 }
 
-#endif
+#endif /* CONFIG_TRACE_IRQFLAGS */
 
 static void
 print_deadlock_scenario(struct held_lock *nxt, struct held_lock *prv)
@@ -2738,7 +2738,7 @@ static inline int validate_chain(struct task_struct *curr,
 {
 	return 1;
 }
-#endif
+#endif /* CONFIG_PROVE_LOCKING */
 
 /*
  * We are building curr_chain_key incrementally, so double-check
-- 
1.8.3.1

