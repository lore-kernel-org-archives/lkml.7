Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A60C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC542173B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="eXFCI9Im"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfE0IuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:50:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36100 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfE0IuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:50:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id v22so7734908wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 01:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JSYe47ktmWDVImdRMdjKYkUfFXl23hlJNQIL3W+hEjY=;
        b=eXFCI9ImDvCZKjk0jgbcXG/WbIcHIk+7MQNwJdKDwJNbEzr9PvGux3wik26Mz5q/tx
         H2Ibzxqwhdwns143brs5zym7VWKd5/QQ2XIFU3HnPs1F09NqKgQzR3TZIqfpSabiDjKg
         e2h4YOZwHNXtEVNoUyr2IuvyeaKI5tGdXv98g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JSYe47ktmWDVImdRMdjKYkUfFXl23hlJNQIL3W+hEjY=;
        b=FC7wLUIUGsdFHH77qK8R7fvBp3hg0VQJGmSYgZz+I0fqaXf0NOlE5c5Lrg7oOSLGky
         Znz+WezhP8ejHcDsfiItfcpfw5DSD6K3AvcuJ5uzGFu/WBOldEP6uYi3mEJGhdK/7Boq
         H4sE+IQh+FonmRYFPAsTwXWj6YxGSgyyoA/f8EBIyf2ywvvRhPeFfbHPFCBnkhB0Clzn
         CdD/32nCsk6eaG5vOQ4dmONso53jDoqYv7wbSB41A60j0nkrlgbeA0W1p6Ab0QbPrKzU
         V30h5X13Z4+din9R/2ATPfTVMFo6CWXxuvIxTIrJcvUPEUKPk6o2Iug1itnJOzWziFfu
         9O2Q==
X-Gm-Message-State: APjAAAXSxops5awQyyDRuLNNEhPHJquL0PnIZpAflEC/oZnR2KlQXApr
        OToPKEK3CiHPcEFyRxNCbn6gJ7ZANEruUg==
X-Google-Smtp-Source: APXvYqyCt7v/FXUTPMZGhsTlodF+U+d/X6SYkTSx9P2iis4pvWer/HfaVOOWbV7b5JQTHHKxXjxT0g==
X-Received: by 2002:a7b:c943:: with SMTP id i3mr8400604wml.128.1558947019989;
        Mon, 27 May 2019 01:50:19 -0700 (PDT)
Received: from localhost.localdomain (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id f197sm10308637wme.39.2019.05.27.01.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 01:50:19 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2] rcu: Don't return a value from rcu_assign_pointer()
Date:   Mon, 27 May 2019 10:49:57 +0200
Message-Id: <1558946997-25559-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul [1]:

  "Given that a quick (and perhaps error-prone) search of the uses
   of rcu_assign_pointer() in v5.1 didn't find a single use of the
   return value, let's please instead change the documentation and
   implementation to eliminate the return value."

[1] https://lkml.kernel.org/r/20190523135013.GL28207@linux.ibm.com

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: rcu@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Sasha Levin <sashal@kernel.org>
---
Changes in v2:
  - Fix documentation and style (Paul E. McKenney)
  - Improve subject line (Mark Rutland) 
---
 Documentation/RCU/whatisRCU.txt           | 8 ++++----
 include/linux/rcupdate.h                  | 5 ++---
 tools/include/linux/rcu.h                 | 4 ++--
 tools/testing/radix-tree/linux/rcupdate.h | 2 +-
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
index 981651a8b65d2..7e1a8721637ab 100644
--- a/Documentation/RCU/whatisRCU.txt
+++ b/Documentation/RCU/whatisRCU.txt
@@ -212,7 +212,7 @@ synchronize_rcu()
 
 rcu_assign_pointer()
 
-	typeof(p) rcu_assign_pointer(p, typeof(p) v);
+	void rcu_assign_pointer(p, typeof(p) v);
 
 	Yes, rcu_assign_pointer() -is- implemented as a macro, though it
 	would be cool to be able to declare a function in this manner.
@@ -220,9 +220,9 @@ rcu_assign_pointer()
 
 	The updater uses this function to assign a new value to an
 	RCU-protected pointer, in order to safely communicate the change
-	in value from the updater to the reader.  This function returns
-	the new value, and also executes any memory-barrier instructions
-	required for a given CPU architecture.
+	in value from the updater to the reader.  This macro does not
+	evaluate to an rvalue, but it does execute any memory-barrier
+	instructions required for a given CPU architecture.
 
 	Perhaps just as important, it serves to document (1) which
 	pointers are protected by RCU and (2) the point at which a
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index a8ed624da5556..0c9b92799abc7 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -367,7 +367,7 @@ static inline void rcu_preempt_sleep_check(void) { }
  * other macros that it invokes.
  */
 #define rcu_assign_pointer(p, v)					      \
-({									      \
+do {									      \
 	uintptr_t _r_a_p__v = (uintptr_t)(v);				      \
 	rcu_check_sparse(p, __rcu);					      \
 									      \
@@ -375,8 +375,7 @@ static inline void rcu_preempt_sleep_check(void) { }
 		WRITE_ONCE((p), (typeof(p))(_r_a_p__v));		      \
 	else								      \
 		smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
-	_r_a_p__v;							      \
-})
+} while (0)
 
 /**
  * rcu_swap_protected() - swap an RCU and a regular pointer
diff --git a/tools/include/linux/rcu.h b/tools/include/linux/rcu.h
index 7d02527e5bcea..9554d3fa54f33 100644
--- a/tools/include/linux/rcu.h
+++ b/tools/include/linux/rcu.h
@@ -19,7 +19,7 @@ static inline bool rcu_is_watching(void)
 	return false;
 }
 
-#define rcu_assign_pointer(p, v) ((p) = (v))
-#define RCU_INIT_POINTER(p, v) p=(v)
+#define rcu_assign_pointer(p, v)	do { (p) = (v); } while (0)
+#define RCU_INIT_POINTER(p, v)	do { (p) = (v); } while (0)
 
 #endif
diff --git a/tools/testing/radix-tree/linux/rcupdate.h b/tools/testing/radix-tree/linux/rcupdate.h
index fd280b070fdb1..fed468fb0c78d 100644
--- a/tools/testing/radix-tree/linux/rcupdate.h
+++ b/tools/testing/radix-tree/linux/rcupdate.h
@@ -7,6 +7,6 @@
 #define rcu_dereference_raw(p) rcu_dereference(p)
 #define rcu_dereference_protected(p, cond) rcu_dereference(p)
 #define rcu_dereference_check(p, cond) rcu_dereference(p)
-#define RCU_INIT_POINTER(p, v)	(p) = (v)
+#define RCU_INIT_POINTER(p, v)	do { (p) = (v); } while (0)
 
 #endif
-- 
2.7.4

