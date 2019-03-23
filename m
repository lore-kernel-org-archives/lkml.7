Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15F8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 01:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1581218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 01:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="svA0Tptk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfCWB3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 21:29:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39349 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbfCWB3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 21:29:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id h8so2638317pgp.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 18:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5N6D7hDjjGdTr25In9X+DMLqKrd0Dg1k+CEt/RF5aAI=;
        b=svA0TptkO2OiuAGubaBDyr+jj5w23JOEPlUxrnTlPdC8V6Udk0NRfSsiXwWXsDbyIq
         iHrfGjkzcx0c98zbtbdhKcsZdWsMBcH0sRlCeu4kBnKtYV73vVQxQ7lg0kPZUS9jdITp
         CKM8KC2MYKZauZK/0xCP+z/Y4UdjAtWiaVKTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5N6D7hDjjGdTr25In9X+DMLqKrd0Dg1k+CEt/RF5aAI=;
        b=NseJaVoOysLIuYujcYnTBlht65VXCnifQCUHTlMs1LTd0B5H3u/VEz6JgFLtlSsvGi
         c7iGzRzZkjL4b0Ut5hitKKDSAVGDa5BI8adwM4aqzpm/wcJy6jtckhwxw/e8L7jIcZtU
         s3vIBQLPDtglSyZY3QqaDDIR25CoKkhzhuo7ohyxsbBkT3UIzBCzPbPEF+YeLmMC8igB
         Isw4QO/pqsm29iqgJvYyTHadRcG+5XL/sh7ral7EIZ8p13L/7gtp4j+kxIy/DasVNrLT
         nsrJIc50t6Wk4emdwgvsIEGgzre+EDjEe6RuLprH3817M7P2bqVNDvhceJHMpzaZjEmp
         h9Bw==
X-Gm-Message-State: APjAAAVXJf8AR4q2902hOJ39N1mSwhD5PKZ1+368Lpe0/eA8iR7L4ulj
        Q4pz98I+uxEslgoW3dAeaJUUCKR5buM=
X-Google-Smtp-Source: APXvYqxNUITaN7xRaY8xCyQS47WFEsMWa1fFG3yC6psOPSHq8l4qUx7Jyj/DLcvXBLuPC5ot1HLwDA==
X-Received: by 2002:a65:60c1:: with SMTP id r1mr11757594pgv.137.1553304591571;
        Fri, 22 Mar 2019 18:29:51 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l7sm26672525pfj.162.2019.03.22.18.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 18:29:50 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        byungchul.park@lge.com, kernel-team@android.com,
        rcu@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [RFC 2/2] rcutree: Add checks for dynticks counters in rcu_is_cpu_rrupt_from_idle
Date:   Fri, 22 Mar 2019 21:29:39 -0400
Message-Id: <20190323012939.15185-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190323012939.15185-1-joel@joelfernandes.org>
References: <20190323012939.15185-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the future we would like to combine the dynticks and dynticks_nesting
counters thus leading to simplifying the code. At the moment we cannot
do that due to concerns about usermode upcalls appearing to RCU as half
of an interrupt. Byungchul tried to do it in [1] but the
"half-interrupt" concern was raised. It is half because, what RCU
expects is rcu_irq_enter() and rcu_irq_exit() pairs when the usermode
exception happens. However, only rcu_irq_enter() is observed. This
concern may not be valid anymore, but at least it used to be the case.

Out of abundance of caution, Paul added warnings [2] in the RCU code
which if not fired by 2021 may allow us to assume that such
half-interrupt scenario cannot happen any more, which can lead to
simplification of this code.

Summary of the changes are the following:

(1) In preparation for this combination of counters in the future, we
first need to first be sure that rcu_rrupt_from_idle cannot be called
from anywhere but a hard-interrupt because previously, the comments
suggested otherwise so let us be sure. We discussed this here [3]. We
use the services of lockdep to accomplish this.

(2) Further rcu_rrupt_from_idle() is not explicit about how it is using
the counters which can lead to weird future bugs. This patch therefore
makes it more explicit about the specific counter values being tested

(3) Lastly, we check for counter underflows just to be sure these are
not happening, because the previous code in rcu_rrupt_from_idle() was
allowing the case where the counters can underflow, and the function
would still return true. Now we are checking for specific values so let
us be confident by additional checking, that such underflows don't
happen. Any case, if they do, we should fix them and the screaming
warning is appropriate. All these checks checks are NOOPs if PROVE_RCU
and PROVE_LOCKING are disabled.

[1] https://lore.kernel.org/patchwork/patch/952349/
[2] Commit e11ec65cc8d6 ("rcu: Add warning to detect half-interrupts")
[3] https://lore.kernel.org/lkml/20190312150514.GB249405@google.com/

Cc: byungchul.park@lge.com
Cc: kernel-team@android.com
Cc: rcu@vger.kernel.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9180158756d2..d94c8ed29f6b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -381,16 +381,29 @@ static void __maybe_unused rcu_momentary_dyntick_idle(void)
 }
 
 /**
- * rcu_is_cpu_rrupt_from_idle - see if idle or immediately interrupted from idle
+ * rcu_is_cpu_rrupt_from_idle - see if interrupted from idle
  *
- * If the current CPU is idle or running at a first-level (not nested)
+ * If the current CPU is idle and running at a first-level (not nested)
  * interrupt from idle, return true.  The caller must have at least
  * disabled preemption.
  */
 static int rcu_is_cpu_rrupt_from_idle(void)
 {
-	return __this_cpu_read(rcu_data.dynticks_nesting) <= 0 &&
-	       __this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 1;
+	/* Called only from within the scheduling-clock interrupt */
+	lockdep_assert_in_irq();
+
+	/* Check for counter underflows */
+	RCU_LOCKDEP_WARN(
+		(__this_cpu_read(rcu_data.dynticks_nesting) < 0) &&
+		(__this_cpu_read(rcu_data.dynticks_nmi_nesting) < 0),
+		"RCU dynticks nesting counters underflow!");
+
+	/* Are we at first interrupt nesting level? */
+	if (__this_cpu_read(rcu_data.dynticks_nmi_nesting) != 1)
+		return false;
+
+	/* Does CPU appear to be idle from an RCU standpoint? */
+	return __this_cpu_read(rcu_data.dynticks_nesting) == 0;
 }
 
 #define DEFAULT_RCU_BLIMIT 10     /* Maximum callbacks per rcu_do_batch. */
-- 
2.21.0.392.gf8f6787159e-goog

