Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E9DC282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 23:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A982186A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 23:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ExaDqp0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfEXXuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 19:50:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33498 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfEXXuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 19:50:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id z28so6205402pfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 16:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4IUQP+uKyCN66rRAguQBd+uSI/nPEDtpoZNPuNABz7k=;
        b=ExaDqp0kDit6EEuSOcT+FAdLJsr3wasxUTshDnisEPTxiqbsM/iwHBlK5jmEac4uTx
         1WrmYkFMfBW8Hthn8w/kr+CT1si+DUZOuwzHNsk8UBPZv3PhzihaZaVz4saSEqQb9A8/
         P62/INsuK+8WFv0NR63C1VMqjfsXLMIYivmZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4IUQP+uKyCN66rRAguQBd+uSI/nPEDtpoZNPuNABz7k=;
        b=OlDt5bkCHeO+kkFfbGc81BEqpvWAjLESdSVARxnxEpOjey6hSNOvUhxGNOHMmCNsDD
         EAEamN4D5ApWGGSOSZ5EfkDH5P5DuFyK98+ycixPySNt5YNZakIVnReGD4vJvuLue0gH
         pYtyEphvs8KOX/BtbdkJZ6y0P9xeRwkbNukNjgPaVRhC11GF6kvLs9ZNeAiSI4Dy7fek
         rPmR1aSqQkGZ4Bxi0/uu2YqDOuyiyJDLbcWZJgEUe0uQMjX5V/e6OGJ9Qy8r6stM4ozv
         zojxZxR6PETzaKu64+h39cm5KVTDE6G849M54Da3Zjyy3MdjPI5JfPPEsNmcKrdmPfA6
         Do5w==
X-Gm-Message-State: APjAAAURyOWIOd0r+caUpgvPC8JetjensvX5LBQLntFbHa0yLbAu1zZI
        8ZTDrAA8sSaHJNPjm+Qa5WscWWZHaAxUHg==
X-Google-Smtp-Source: APXvYqxNGBpXom3Ado94lkiXFHwXNMChLcccb7ZkYxRn6dsfk/n65WIEwwfbkGKCqFKqFYilSX8ODw==
X-Received: by 2002:a17:90a:372a:: with SMTP id u39mr12987526pjb.19.1558741804955;
        Fri, 24 May 2019 16:50:04 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q4sm3297595pgb.39.2019.05.24.16.50.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 24 May 2019 16:50:04 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, kvm-ppc@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RFC 5/5] rcu: Remove rcu_dereference_raw_notrace since no users
Date:   Fri, 24 May 2019 19:49:33 -0400
Message-Id: <20190524234933.5133-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
In-Reply-To: <20190524234933.5133-1-joel@joelfernandes.org>
References: <20190524234933.5133-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series removes all users of the API and with this patch, the API
itself. Also fix documentation.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/RCU/Design/Requirements/Requirements.html | 6 +++---
 include/linux/rcupdate.h                                | 9 ---------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
index 5a9238a2883c..9727278893e6 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.html
+++ b/Documentation/RCU/Design/Requirements/Requirements.html
@@ -2512,9 +2512,9 @@ disabled across the entire RCU read-side critical section.
 <p>
 It is possible to use tracing on RCU code, but tracing itself
 uses RCU.
-For this reason, <tt>rcu_dereference_raw_notrace()</tt>
-is provided for use by tracing, which avoids the destructive
-recursion that could otherwise ensue.
+This is the other reason for using, <tt>rcu_dereference_raw()</tt>,
+for use by tracing, which avoids the destructive recursion that could
+otherwise ensue.
 This API is also used by virtualization in some architectures,
 where RCU readers execute in environments in which tracing
 cannot be used.
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 922bb6848813..f917a27fc115 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -472,15 +472,6 @@ static inline void rcu_preempt_sleep_check(void) { }
 	__rcu_dereference_check((p), (c) || rcu_read_lock_sched_held(), \
 				__rcu)
 
-/*
- * The tracing infrastructure traces RCU (we want that), but unfortunately
- * some of the RCU checks causes tracing to lock up the system.
- *
- * The no-tracing version of rcu_dereference_raw() must not call
- * rcu_read_lock_held().
- */
-#define rcu_dereference_raw_notrace(p) __rcu_dereference_check((p), 1, __rcu)
-
 /**
  * rcu_dereference_protected() - fetch RCU pointer when updates prevented
  * @p: The pointer to read, prior to dereferencing
-- 
2.22.0.rc1.257.g3120a18244-goog

