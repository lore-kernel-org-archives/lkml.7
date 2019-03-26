Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A49FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3162420823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wR28RfZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbfCZTYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:24:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39687 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfCZTYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 15:24:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id b65so2093267plb.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 12:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03p3ODFVQvd6EJVrQdS1N5Fn4xNiqjPABgOQRHIhcDc=;
        b=wR28RfZ8qqW/OhBxbQWwxK1hqfOW99Wi+R5C9zwy0N/m8KsbEDa+ocRieqjAOL1vBl
         fpzjl+d4iZstuTiyCkdV/5Hp3gFaJQu5KiKH4UOlGzTjOeyYQxQj/+2h5Koi7FMfDpZ4
         cLu6YD37NBR4qIYEP5ZrsWo3itletofOp1DqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03p3ODFVQvd6EJVrQdS1N5Fn4xNiqjPABgOQRHIhcDc=;
        b=jo+0OctTP/LEO3j14EliXNBckkWHk5DQy3OreW84QN352yII15727y2tGZC7neOAV8
         Fi5POUWDkhhbKp3WDGs7UX2JS8GW7VbLjkUuCIgApIAXp5BgR5vUZVd3cNRgV2p1DTvc
         uj7Hfft8K9O5uni2tPhTX6qlkcgJ3o56/sC6c3Ag5PpRG7EQhgu/+XBrI7U5RsPGyt68
         QKqJMGwtsm1+mNa+SJjouMy0DW5mAW5agLZv6f/NpWXI8fP7U9YdBjvchbpgSLkMSf7x
         Nzn7Y8tSeV7GgNmFsS2bSKuFyOdagl2O9PIXSjpBS+3J8+mXQYtNc4+72tedtvuZuIb8
         lgMg==
X-Gm-Message-State: APjAAAVlhqvsODHN25hE8Mg2nec8M48r/OLFgp5x4qQEREQMJ8EiKc6A
        kiGBndiDI8vVXn2kNU8zm4BPOPEiN8k=
X-Google-Smtp-Source: APXvYqz0CpZVgoinljCuzSh12Y9Mbmv/Ll+Vo/kIttOgigpinJboA+vihBRBMjMLEiV4rhip7GywxQ==
X-Received: by 2002:a17:902:2963:: with SMTP id g90mr33228185plb.182.1553628272923;
        Tue, 26 Mar 2019 12:24:32 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l12sm36761889pgn.83.2019.03.26.12.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 12:24:32 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        byungchul.park@lge.com, kernel-team@android.com,
        rcu@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 2/4] rcutree: Add checks for dynticks counters in rcu_is_cpu_rrupt_from_idle
Date:   Tue, 26 Mar 2019 15:24:09 -0400
Message-Id: <20190326192411.198070-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190326192411.198070-1-joel@joelfernandes.org>
References: <20190326192411.198070-1-joel@joelfernandes.org>
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
index 9180158756d2..dbff8a274c46 100644
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
+	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) < 0,
+			 "RCU dynticks_nesting counter underflow!");
+	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
+			 "RCU dynticks_nmi_nesting counter underflow/zero!");
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

