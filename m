Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFB0C31E5D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324BF2166E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DiM9FSZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbfFSOdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:33:12 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41829 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbfFSOdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:33:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id d17so15158147qtj.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 07:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ESSabwCHqaxg+60CbYKqg/kA6SN3/tLL4qlLGPctyzo=;
        b=DiM9FSZq0IUGXP2/BxxGHPv34gQKLwrziAisl2Z94IOvDtTBhY8b3hfIAb47Pl5en3
         N2XOqF0f/2kNqzsG9NXISVq4/pbmn3cxqEp6nrPwkpdsqWpW9MlD3/NZ0V7kVp2dOB1f
         8X40NTjH/Z2m9qlCzyHBbhW3WjfK5Wr/z5DPEJPwVvaL803PHxskE3ds9jEzlIyPNziM
         3oH8KVhNNnqZstaGXQ/68BaTJ9IW5WhgfJpqJAtPLCffLw7htQVQd+UX0ycCbnBRx4xn
         JE0X7uHqFQNqASQ2xP71iAn6f4SoiDCMd9ngYN6YN8KXwPkRp1c/bj/t8QF55JDVj/5B
         g0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ESSabwCHqaxg+60CbYKqg/kA6SN3/tLL4qlLGPctyzo=;
        b=sx4BUDXwhbt3S4xXzIKDxg4cvHv/hQdytJAbzjIesAVAnQGactjyg8AZvFwfTYln02
         hJ0ioctMExQkiWr1+yT/sSFKWogAH6w2tWvRPy0PNiBj4ct2+1FBSKkWB+g7g5FIx2/K
         XQ8M+Vu/ABgV2wX5G2lUGPkP/8OcQDn9xlHCAeYYNr2DJil9ZaMLMb8uE7HbKy5dqmNF
         Jn+PI6y4jI96ynz3AILNac6nvOwa2TVfpqJFs4dyHxRpYhUQyoPp2v1W0a5ga5tWX+H+
         L1CHpXQZgNzedrtqBOFaEbopgtOSLJVjJ6F94i/NpOIEZPFTgB73O/d8FzOx9MESfxRZ
         Hlpg==
X-Gm-Message-State: APjAAAVWpVXIqVzZKPv8mD8M5ujErSDlxyuhWP6yKGSGrUjXxuSZWvZA
        KI9ug2XPAjQw/RDLy5ilU3IKT4UCyo0=
X-Google-Smtp-Source: APXvYqy8ShTGhcuIWgGKSaEwCYpIlR+OqG8QWD4JHvmuCDijQAohUexkPv35wgdhVH9cppjwZ9Qctg==
X-Received: by 2002:aed:22f2:: with SMTP id q47mr28848773qtc.106.1560954791463;
        Wed, 19 Jun 2019 07:33:11 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g54sm14237183qtc.61.2019.06.19.07.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:33:10 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     hpa@zytor.com, sean.j.christopherson@intel.com,
        suravee.suthikulpanit@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] x86/cacheinfo: fix a -Wtype-limits warning
Date:   Wed, 19 Jun 2019 10:32:53 -0400
Message-Id: <1560954773-11967-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpuinfo_x86.x86_model is an unsigned type, so compares it against zero
will generate a compilation warning,

arch/x86/kernel/cpu/cacheinfo.c: In function
'cacheinfo_amd_init_llc_id':
arch/x86/kernel/cpu/cacheinfo.c:662:19: warning: comparison is always
true due to limited range of data type [-Wtype-limits]

"c->x86 == 0x17" is true if and only if c->x86_model was explicitly set
by cpu_detect(), so just remove the unnecessary checking.

Fixes: 68091ee7ac3c ("x86/CPU/AMD: Calculate last level cache ID from number of sharing threads")
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: Update the commit message per Sean.

 arch/x86/kernel/cpu/cacheinfo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 395d46f78582..c7503be92f35 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -658,8 +658,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
 	if (c->x86 < 0x17) {
 		/* LLC is at the node level. */
 		per_cpu(cpu_llc_id, cpu) = node_id;
-	} else if (c->x86 == 0x17 &&
-		   c->x86_model >= 0 && c->x86_model <= 0x1F) {
+	} else if (c->x86 == 0x17 && c->x86_model <= 0x1F) {
 		/*
 		 * LLC is at the core complex level.
 		 * Core complex ID is ApicId[3] for these processors.
-- 
1.8.3.1

