Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E293BCA9ED0
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF11020862
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnWMI5MI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfKBLzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 07:55:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40330 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfKBLzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 07:55:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id r4so8796839pfl.7;
        Sat, 02 Nov 2019 04:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7u/iOR7HJqtZD8nquIFJaMlxUwUZ2mligFudZlnPrWU=;
        b=UnWMI5MI5/gxEd8ihgP7kS9XWpzKHAH7ezgi6KAANGgBemAcX1+iFM6NVxnzuzVjf4
         tn0H2sMS8+m71lBTPPzsca+MSFg5ULBumVtzCY/TYQcMdGZpkWwQems7wB74qLPNXsaA
         w2VJremR97MGbNCqbv+mXjqQvVyJz4li6FdYz7V8n9ubDmsrBk5TjeGYWkdTXKEBfDpX
         NkCQj4P0XePvhDx8OUWuaFwtYeb20FutncuFZvt2sQqJ7By14n8Oo4iy/RIMyk/OWOXX
         fAF5ALjaQvnr3PWHJ6/1qDqLcqs/hxOg74Y6H4yWVkAjA6eYNDX8lM+zZJjb8ErwBMLV
         Wfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7u/iOR7HJqtZD8nquIFJaMlxUwUZ2mligFudZlnPrWU=;
        b=jI5JO8Duikbx/YoTtnCj3+OlY34z+npR9Idtp96QS7i2dhtsl5sXWTqf9xZ/r4VX55
         MjBQA6/nFiE/bkd1aAsjXmaRSxsF7SnjFPVfkjZjVaV0gr9nuCzIRH32ISjvwLv5iuLr
         F4UhU1wYwSX/BfOAs5/GPcpdPez8b+c9D8UoA+go1JF7LCvN1O2zdHC/2Nbm0lVt27c7
         4CED+zU5AgITviDAMig9WdtxhEYna2D+j0LenK+3alaYBG7/+vgE6hq4tDKI2bVwqFz/
         exG6YE1xDLm1fu7mLxZkO5PwAzz6nc+qaTqhhY/D/cyT2Fdz7Arc6D1FjKAD7WWMyk99
         DOMw==
X-Gm-Message-State: APjAAAVQj9FAhGfOIv4rZGcdDXazE+wBZYtJU8kYjVG8B+cYciBtI9E7
        PY7DQVu/kmM0UiqcDz5ksy8=
X-Google-Smtp-Source: APXvYqx5DViiAj0X3gP1IMt5ru+wl84hoOd5wSYkowEoxDjDaT8Br+oaj/Eo+YAEW9+cN7erRjKmRg==
X-Received: by 2002:a17:90a:d993:: with SMTP id d19mr21679885pjv.26.1572695733504;
        Sat, 02 Nov 2019 04:55:33 -0700 (PDT)
Received: from debian.net.fpt ([2405:4800:58f7:55d9:3e01:3008:2e64:188f])
        by smtp.gmail.com with ESMTPSA id a12sm5122320pfo.136.2019.11.02.04.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2019 04:55:32 -0700 (PDT)
From:   Phong Tran <tranmanphong@gmail.com>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net,
        madhuparnabhowmik04@gmail.com
Cc:     rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH] Doc: Improve format for whatisRCU.rst
Date:   Sat,  2 Nov 2019 18:55:17 +0700
Message-Id: <20191102115517.6378-1-tranmanphong@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding crossreference target for some headers, answer of quizzes

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 Documentation/RCU/whatisRCU.rst | 73 +++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 21 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 70d0e4c21917..ae40c8bcc56c 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -1,4 +1,4 @@
-.. _rcu_doc:
+.. _whatisrcu_doc:
 
 What is RCU?  --  "Read, Copy, Update"
 ======================================
@@ -27,14 +27,21 @@ the experience has been that different people must take different paths
 to arrive at an understanding of RCU.  This document provides several
 different paths, as follows:
 
-1.	RCU OVERVIEW
-2.	WHAT IS RCU'S CORE API?
-3.	WHAT ARE SOME EXAMPLE USES OF CORE RCU API?
-4.	WHAT IF MY UPDATING THREAD CANNOT BLOCK?
-5.	WHAT ARE SOME SIMPLE IMPLEMENTATIONS OF RCU?
-6.	ANALOGY WITH READER-WRITER LOCKING
-7.	FULL LIST OF RCU APIs
-8.	ANSWERS TO QUICK QUIZZES
+:ref:`1.	RCU OVERVIEW <1_whatisRCU>`
+
+:ref:`2.	WHAT IS RCU'S CORE API? <2_whatisRCU>`
+
+:ref:`3.	WHAT ARE SOME EXAMPLE USES OF CORE RCU API? <3_whatisRCU>`
+
+:ref:`4.	WHAT IF MY UPDATING THREAD CANNOT BLOCK? <4_whatisRCU>`
+
+:ref:`5.	WHAT ARE SOME SIMPLE IMPLEMENTATIONS OF RCU? <5_whatisRCU>`
+
+:ref:`6.	ANALOGY WITH READER-WRITER LOCKING <6_whatisRCU>`
+
+:ref:`7.	FULL LIST OF RCU APIs <7_whatisRCU>`
+
+:ref:`8.	ANSWERS TO QUICK QUIZZES <8_whatisRCU>`
 
 People who prefer starting with a conceptual overview should focus on
 Section 1, though most readers will profit by reading this section at
@@ -52,6 +59,7 @@ everything, feel free to read the whole thing -- but if you are really
 that type of person, you have perused the source code and will therefore
 never need this document anyway.  ;-)
 
+.. _1_whatisRCU:
 
 1.  RCU OVERVIEW
 ----------------
@@ -120,6 +128,7 @@ So how the heck can a reclaimer tell when a reader is done, given
 that readers are not doing any sort of synchronization operations???
 Read on to learn about how RCU's API makes this easy.
 
+.. _2_whatisRCU:
 
 2.  WHAT IS RCU'S CORE API?
 ---------------------------
@@ -381,13 +390,15 @@ c.	RCU applied to scheduler and interrupt/NMI-handler tasks.
 Again, most uses will be of (a).  The (b) and (c) cases are important
 for specialized uses, but are relatively uncommon.
 
+.. _3_whatisRCU:
 
 3.  WHAT ARE SOME EXAMPLE USES OF CORE RCU API?
 -----------------------------------------------
 
 This section shows a simple use of the core RCU API to protect a
 global pointer to a dynamically allocated structure.  More-typical
-uses of RCU may be found in listRCU.txt, arrayRCU.txt, and NMI-RCU.txt.
+uses of RCU may be found in :ref:`listRCU.rst <list_rcu_doc>`,
+:ref:`arrayRCU.rst <array_rcu_doc>`, and :ref:`NMI-RCU.rst <NMI_rcu_doc>`.
 ::
 
 	struct foo {
@@ -470,9 +481,11 @@ o	Use synchronize_rcu() -after- removing a data element from an
 	data item.
 
 See checklist.txt for additional rules to follow when using RCU.
-And again, more-typical uses of RCU may be found in listRCU.txt,
-arrayRCU.txt, and NMI-RCU.txt.
+And again, more-typical uses of RCU may be found in :ref:`listRCU.rst
+<list_rcu_doc>`, :ref:`arrayRCU.rst <array_rcu_doc>`, and :ref:`NMI-RCU.rst
+<NMI_rcu_doc>`.
 
+.. _4_whatisRCU:
 
 4.  WHAT IF MY UPDATING THREAD CANNOT BLOCK?
 --------------------------------------------
@@ -567,6 +580,7 @@ to avoid having to write your own callback::
 
 Again, see checklist.txt for additional rules governing the use of RCU.
 
+.. _5_whatisRCU:
 
 5.  WHAT ARE SOME SIMPLE IMPLEMENTATIONS OF RCU?
 ------------------------------------------------
@@ -657,10 +671,12 @@ that the only thing that can block rcu_read_lock() is a synchronize_rcu().
 But synchronize_rcu() does not acquire any locks while holding rcu_gp_mutex,
 so there can be no deadlock cycle.
 
-Quick Quiz #1:	Why is this argument naive?  How could a deadlock
+Quick Quiz #1:
+		Why is this argument naive?  How could a deadlock
 		occur when using this algorithm in a real-world Linux
 		kernel?  How could this deadlock be avoided?
 
+:ref:`Answers to Quick Quiz <8_whatisRCU>`
 
 5B.  "TOY" EXAMPLE #2: CLASSIC RCU
 
@@ -709,13 +725,20 @@ synchronize_rcu().  Once synchronize_rcu() returns, we are guaranteed
 that there are no RCU read-side critical sections holding a reference
 to that data item, so we can safely reclaim it.
 
-Quick Quiz #2:	Give an example where Classic RCU's read-side
+Quick Quiz #2:
+		Give an example where Classic RCU's read-side
 		overhead is -negative-.
 
-Quick Quiz #3:  If it is illegal to block in an RCU read-side
+:ref:`Answers to Quick Quiz <8_whatisRCU>`
+
+Quick Quiz #3:
+		If it is illegal to block in an RCU read-side
 		critical section, what the heck do you do in
 		PREEMPT_RT, where normal spinlocks can block???
 
+:ref:`Answers to Quick Quiz <8_whatisRCU>`
+
+.. _6_whatisRCU:
 
 6.  ANALOGY WITH READER-WRITER LOCKING
 --------------------------------------
@@ -842,6 +865,7 @@ delete() can now block.  If this is a problem, there is a callback-based
 mechanism that never blocks, namely call_rcu() or kfree_rcu(), that can
 be used in place of synchronize_rcu().
 
+.. _7_whatisRCU:
 
 7.  FULL LIST OF RCU APIs
 -------------------------
@@ -1001,16 +1025,19 @@ g.	Otherwise, use RCU.
 Of course, this all assumes that you have determined that RCU is in fact
 the right tool for your job.
 
+.. _8_whatisRCU:
 
 8.  ANSWERS TO QUICK QUIZZES
 ----------------------------
 
-Quick Quiz #1:	Why is this argument naive?  How could a deadlock
+Quick Quiz #1:
+		Why is this argument naive?  How could a deadlock
 		occur when using this algorithm in a real-world Linux
 		kernel?  [Referring to the lock-based "toy" RCU
 		algorithm.]
 
-Answer:		Consider the following sequence of events:
+Answer:
+		Consider the following sequence of events:
 
 		1.	CPU 0 acquires some unrelated lock, call it
 			"problematic_lock", disabling irq via
@@ -1049,10 +1076,12 @@ Answer:		Consider the following sequence of events:
 		approach where tasks in RCU read-side critical sections
 		cannot be blocked by tasks executing synchronize_rcu().
 
-Quick Quiz #2:	Give an example where Classic RCU's read-side
+Quick Quiz #2:
+		Give an example where Classic RCU's read-side
 		overhead is -negative-.
 
-Answer:		Imagine a single-CPU system with a non-CONFIG_PREEMPT
+Answer:
+		Imagine a single-CPU system with a non-CONFIG_PREEMPT
 		kernel where a routing table is used by process-context
 		code, but can be updated by irq-context code (for example,
 		by an "ICMP REDIRECT" packet).	The usual way of handling
@@ -1074,11 +1103,13 @@ Answer:		Imagine a single-CPU system with a non-CONFIG_PREEMPT
 		even the theoretical possibility of negative overhead for
 		a synchronization primitive is a bit unexpected.  ;-)
 
-Quick Quiz #3:  If it is illegal to block in an RCU read-side
+Quick Quiz #3:
+		If it is illegal to block in an RCU read-side
 		critical section, what the heck do you do in
 		PREEMPT_RT, where normal spinlocks can block???
 
-Answer:		Just as PREEMPT_RT permits preemption of spinlock
+Answer:
+		Just as PREEMPT_RT permits preemption of spinlock
 		critical sections, it permits preemption of RCU
 		read-side critical sections.  It also permits
 		spinlocks blocking while in RCU read-side critical
-- 
2.20.1

