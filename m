Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E923C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE7E2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfHXGDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 02:03:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39558 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfHXGCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 02:02:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id z3so6896000pln.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 23:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JW1I/e1f0li5uTuaaXr1L7jto5OSOJdjz8Xl7/i+z+Q=;
        b=iEyYEMSsaJKGZtHggclB36vX9RKYIo/tL8coiMZrfoOLYHZcKD88YJtyCy8//T0auC
         TGurdobIyJYsmXZ0VyWY4u/YBgLLpCdvfDbaXjTL6rJoIyxwsqVAjFwDkxxPM7L7CPfk
         fsfgAs3SJgCqKf09OHSrDdImDJrlyBV/Xr2sFH1ApE7uWPg/zqRa+otwDJnbID7ogPFI
         7NvqtY1kjhGMG0erL/+XD1HBilWy8cHPl9B8fJFzJ7S2pjbPENOX0nijczc/1hYBjmDj
         KISa+U6dPl2zoh+gy7VCbosp2g2Nmodzp+/3ycqbYVda/D58JUTfMdzuh+Ie8S+2ZEwI
         iklw==
X-Gm-Message-State: APjAAAUJLqD4fMbm5r6yTAhk219x4lQT6Usv5i0lCLvPoRkTGiZHfP5R
        Us2FhfHK4L6auUdKjMhb7m0=
X-Google-Smtp-Source: APXvYqwI9IbZRBP0YsUb5OaBiakWA4IDPR1Yg9W/qgh9yj/Qi86ij1nfmKwVRBQw4oVLqAT/RW5zCQ==
X-Received: by 2002:a17:902:e413:: with SMTP id ci19mr8717199plb.256.1566626573758;
        Fri, 23 Aug 2019 23:02:53 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id i11sm6505645pfk.34.2019.08.23.23.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 23:02:52 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v4 7/9] cpumask: Mark functions as pure
Date:   Fri, 23 Aug 2019 15:41:51 -0700
Message-Id: <20190823224153.15223-8-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823224153.15223-1-namit@vmware.com>
References: <20190823224153.15223-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpumask_next_and() and cpumask_any_but() are pure, and marking them as
such seems to generate different and presumably better code for
native_flush_tlb_multi().

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 include/linux/cpumask.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index b5a5a1ed9efd..2579700bf44a 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -225,7 +225,7 @@ static inline unsigned int cpumask_last(const struct cpumask *srcp)
 	return find_last_bit(cpumask_bits(srcp), nr_cpumask_bits);
 }
 
-unsigned int cpumask_next(int n, const struct cpumask *srcp);
+unsigned int __pure cpumask_next(int n, const struct cpumask *srcp);
 
 /**
  * cpumask_next_zero - get the next unset cpu in a cpumask
@@ -242,8 +242,8 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 	return find_next_zero_bit(cpumask_bits(srcp), nr_cpumask_bits, n+1);
 }
 
-int cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
-int cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
+int __pure cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
+int __pure cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
 unsigned int cpumask_local_spread(unsigned int i, int node);
 
 /**
-- 
2.17.1

