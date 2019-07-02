Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DD2C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6891E2187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfGCHO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:14:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33050 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbfGCHON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:14:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id m4so738195pgk.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 00:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VhTZ18hX0yEenw77Q3E7kjklW3RIcvPLHLYFnzx8tTo=;
        b=FntETGZypFmNQf29s+82sGEL/0SLzDgQmDa+DR4SOkXAjaHG+p32B/p6SORUaFSoDq
         F5o426SEdwguoO1QtmSgLl6LIf/Q0s84UTz7xZFtN/imRbh5EaZ2JItm/iWiCK2N7j30
         aoY78ZBJrboSMgpI5bDV02gTmJmzL1taqTRd3C4zjAIaU+xZF1BVkMnXX6sPdc0Qd1Dr
         518oGydyELmcsT7EGcDd8ktOp2d9VC+O8dNIwrSpegDkZJycsHoI4Om5Dqsfqt+PJnTP
         SVGMSh5xkCY/3giU5YzwJuO2kp606WbcesbAIztofJdQCxHI0EYJsrv7TC66HlzZmsma
         zE0g==
X-Gm-Message-State: APjAAAVZzLoUDZLchf0RrBMdg5gL2w5J4w4JnT14WTnlry2/lwQWNDFo
        V/KIhrOdbg4/SWeXDR9cXRE=
X-Google-Smtp-Source: APXvYqzC4CGTMLNck3tIx7EzXNyO1g2d4Mr6ue9VWwe/l1J2IROz1M62rJsJFAr4vhW9atojF5j23Q==
X-Received: by 2002:a65:4786:: with SMTP id e6mr26980658pgs.448.1562138052234;
        Wed, 03 Jul 2019 00:14:12 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j21sm1256593pfh.86.2019.07.03.00.14.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 00:14:11 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v2 7/9] cpumask: Mark functions as pure
Date:   Tue,  2 Jul 2019 16:51:49 -0700
Message-Id: <20190702235151.4377-8-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190702235151.4377-1-namit@vmware.com>
References: <20190702235151.4377-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpumask_next_and() and cpumask_any_but() are pure, and marking them as
such seems to generate different and presumably better code for
native_flush_tlb_multi().

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 include/linux/cpumask.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 693124900f0a..8decc46ca0ce 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -211,7 +211,7 @@ static inline unsigned int cpumask_last(const struct cpumask *srcp)
 	return find_last_bit(cpumask_bits(srcp), nr_cpumask_bits);
 }
 
-unsigned int cpumask_next(int n, const struct cpumask *srcp);
+unsigned int __pure cpumask_next(int n, const struct cpumask *srcp);
 
 /**
  * cpumask_next_zero - get the next unset cpu in a cpumask
@@ -228,8 +228,8 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
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

