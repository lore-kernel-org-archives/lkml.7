Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07780C5DF61
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 21:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98A221882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 21:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLZGt4VB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbfKEVn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 16:43:29 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44902 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbfKEVn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 16:43:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id q26so16939793pfn.11;
        Tue, 05 Nov 2019 13:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PzgUCHmX4SKtXHoHzT3qESrsCOYBynwOpztbmGqg0O0=;
        b=JLZGt4VBlvn/7SRVm30hukJ/2OU401CXRI3XTJ61J3zbU4ssJnUO+4xrJ8sN/DwYCT
         x5wn2/2MYlKgORmDMnwlhUEMCVAsDM4/1tdkkozSRr37vW8XKFh6UyNDnwEureqLvjpE
         76W3UkaFhT7K42bsMGh44ExnE3mEOHPdYEs3/54hhQ8tcQ3RjZtm2a559+C44TELGW5n
         GOzNUVWoFadfAb9rNOv5hMSFE4s59D/keKeFuov20FSUM+VaWBE9/imO1GyA3GOeh4ZF
         kGZj2Xd+a6QPyX4vqN+nfIL3j3jqzvF1yKG+a8IOmvad1A5/2PIRaWftWwNrR52ehMgP
         /4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PzgUCHmX4SKtXHoHzT3qESrsCOYBynwOpztbmGqg0O0=;
        b=j8hcIs2sfMI4vF2IJukLLQzVimQvQ1SAoiVTGbaLn6+Kom85ho1uCDczHUkqfEtcbV
         sivI5cNsFmkhmbKD+PtbOg0nBIJ9zUxLPbtFoWnc7RMZws+ejbnF6gueI1WzgTC65JOR
         ec+49R38iMUY//J6Jo6Qla1/6s9+wFDEH3XhWPYMhzZGr7+F081ZHw2OQgrodtaT35MH
         KiPRQJ0h5bnPMpsbxpTB2uVlR26/kF2++9KBXW4ahNMJ0TgE8dn2Aw4idvFRbSFr1N3g
         KV8OxgbfFt5ykADIKb2ZtWwUVy/TIvauW1MuK2ewiEcnaXIVxd0rz/WAKiCclM+humHZ
         9PkQ==
X-Gm-Message-State: APjAAAUpnkYPRzRsr724aDzbCuuDWlZ1zCElFWzNo7fV8VpE4jspZ2Y1
        HvJSTinlmZVPfGCKqcDpGBg=
X-Google-Smtp-Source: APXvYqzh7qCItQmbwlGWFB35LJmpSi0Zx9nz8WPKkZC+a4Y2dKLaZ7uhpWoO6DnwyRQS4JGyI7QgvA==
X-Received: by 2002:a63:cf4d:: with SMTP id b13mr38055347pgj.396.1572990206533;
        Tue, 05 Nov 2019 13:43:26 -0800 (PST)
Received: from debian.net.fpt ([2405:4800:58f7:3f8f:27cb:abb4:d0bd:49cb])
        by smtp.gmail.com with ESMTPSA id c12sm25428790pfp.67.2019.11.05.13.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 13:43:25 -0800 (PST)
From:   Phong Tran <tranmanphong@gmail.com>
To:     frextrite@gmail.com, paulmck@kernel.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org, jiangshanlai@gmail.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        mathieu.desnoyers@efficios.com, joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH] Doc: whatisRCU: Add more Markup
Date:   Wed,  6 Nov 2019 04:42:34 +0700
Message-Id: <20191105214234.17116-1-tranmanphong@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191105165938.GA10903@workstation>
References: <20191105165938.GA10903@workstation>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

o Adding more crossrefs.
o Bold some words.
o Add header levels.

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 Documentation/RCU/whatisRCU.rst | 67 ++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index ae40c8bcc56c..3e24e0155a91 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -150,7 +150,7 @@ later.  See the kernel docbook documentation for more info, or look directly
 at the function header comments.
 
 rcu_read_lock()
-
+^^^^^^^^^^^^^^^
 	void rcu_read_lock(void);
 
 	Used by a reader to inform the reclaimer that the reader is
@@ -164,7 +164,7 @@ rcu_read_lock()
 	longer-term references to data structures.
 
 rcu_read_unlock()
-
+^^^^^^^^^^^^^^^^^
 	void rcu_read_unlock(void);
 
 	Used by a reader to inform the reclaimer that the reader is
@@ -172,13 +172,13 @@ rcu_read_unlock()
 	read-side critical sections may be nested and/or overlapping.
 
 synchronize_rcu()
-
+^^^^^^^^^^^^^^^^^
 	void synchronize_rcu(void);
 
 	Marks the end of updater code and the beginning of reclaimer
 	code.  It does this by blocking until all pre-existing RCU
 	read-side critical sections on all CPUs have completed.
-	Note that synchronize_rcu() will -not- necessarily wait for
+	Note that synchronize_rcu() will **not** necessarily wait for
 	any subsequent RCU read-side critical sections to complete.
 	For example, consider the following sequence of events::
 
@@ -196,7 +196,7 @@ synchronize_rcu()
 	any that begin after synchronize_rcu() is invoked.
 
 	Of course, synchronize_rcu() does not necessarily return
-	-immediately- after the last pre-existing RCU read-side critical
+	**immediately** after the last pre-existing RCU read-side critical
 	section completes.  For one thing, there might well be scheduling
 	delays.  For another thing, many RCU implementations process
 	requests in batches in order to improve efficiencies, which can
@@ -225,10 +225,10 @@ synchronize_rcu()
 	checklist.txt for some approaches to limiting the update rate.
 
 rcu_assign_pointer()
-
+^^^^^^^^^^^^^^^^^^^^
 	void rcu_assign_pointer(p, typeof(p) v);
 
-	Yes, rcu_assign_pointer() -is- implemented as a macro, though it
+	Yes, rcu_assign_pointer() **is** implemented as a macro, though it
 	would be cool to be able to declare a function in this manner.
 	(Compiler experts will no doubt disagree.)
 
@@ -245,7 +245,7 @@ rcu_assign_pointer()
 	the _rcu list-manipulation primitives such as list_add_rcu().
 
 rcu_dereference()
-
+^^^^^^^^^^^^^^^^^
 	typeof(p) rcu_dereference(p);
 
 	Like rcu_assign_pointer(), rcu_dereference() must be implemented
@@ -280,8 +280,8 @@ rcu_dereference()
 	unnecessary overhead on Alpha CPUs.
 
 	Note that the value returned by rcu_dereference() is valid
-	only within the enclosing RCU read-side critical section [1].
-	For example, the following is -not- legal::
+	only within the enclosing RCU read-side critical section [1]_.
+	For example, the following is **not** legal::
 
 		rcu_read_lock();
 		p = rcu_dereference(head.next);
@@ -304,9 +304,11 @@ rcu_dereference()
 	at any time, including immediately after the rcu_dereference().
 	And, again like rcu_assign_pointer(), rcu_dereference() is
 	typically used indirectly, via the _rcu list-manipulation
-	primitives, such as list_for_each_entry_rcu() [2].
+	primitives, such as list_for_each_entry_rcu() [2]_.
+
+	.. [1]
 
-	[1] The variant rcu_dereference_protected() can be used outside
+	The variant rcu_dereference_protected() can be used outside
 	of an RCU read-side critical section as long as the usage is
 	protected by locks acquired by the update-side code.  This variant
 	avoids the lockdep warning that would happen when using (for
@@ -319,7 +321,9 @@ rcu_dereference()
 	a lockdep splat is emitted.  See Documentation/RCU/Design/Requirements/Requirements.rst
 	and the API's code comments for more details and example usage.
 
-	[2] If the list_for_each_entry_rcu() instance might be used by
+	.. [2]
+
+	If the list_for_each_entry_rcu() instance might be used by
 	update-side code as well as by RCU readers, then an additional
 	lockdep expression can be added to its list of arguments.
 	For example, given an additional "lock_is_held(&mylock)" argument,
@@ -459,22 +463,22 @@ uses of RCU may be found in :ref:`listRCU.rst <list_rcu_doc>`,
 
 So, to sum up:
 
-o	Use rcu_read_lock() and rcu_read_unlock() to guard RCU
+-	Use rcu_read_lock() and rcu_read_unlock() to guard RCU
 	read-side critical sections.
 
-o	Within an RCU read-side critical section, use rcu_dereference()
+-	Within an RCU read-side critical section, use rcu_dereference()
 	to dereference RCU-protected pointers.
 
-o	Use some solid scheme (such as locks or semaphores) to
+-	Use some solid scheme (such as locks or semaphores) to
 	keep concurrent updates from interfering with each other.
 
-o	Use rcu_assign_pointer() to update an RCU-protected pointer.
+-	Use rcu_assign_pointer() to update an RCU-protected pointer.
 	This primitive protects concurrent readers from the updater,
-	-not- concurrent updates from each other!  You therefore still
+	**not** concurrent updates from each other!  You therefore still
 	need to use locking (or something similar) to keep concurrent
 	rcu_assign_pointer() primitives from interfering with each other.
 
-o	Use synchronize_rcu() -after- removing a data element from an
+-	Use synchronize_rcu() **after** removing a data element from an
 	RCU-protected data structure, but -before- reclaiming/freeing
 	the data element, in order to wait for the completion of all
 	RCU read-side critical sections that might be referencing that
@@ -566,7 +570,7 @@ namely foo_reclaim().
 The summary of advice is the same as for the previous section, except
 that we are now using call_rcu() rather than synchronize_rcu():
 
-o	Use call_rcu() -after- removing a data element from an
+-	Use call_rcu() **after** removing a data element from an
 	RCU-protected data structure in order to register a callback
 	function that will be invoked after the completion of all RCU
 	read-side critical sections that might be referencing that
@@ -603,7 +607,7 @@ more details on the current implementation as of early 2004.
 
 
 5A.  "TOY" IMPLEMENTATION #1: LOCKING
-
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 This section presents a "toy" RCU implementation that is based on
 familiar locking primitives.  Its overhead makes it a non-starter for
 real-life use, as does its lack of scalability.  It is also unsuitable
@@ -671,6 +675,8 @@ that the only thing that can block rcu_read_lock() is a synchronize_rcu().
 But synchronize_rcu() does not acquire any locks while holding rcu_gp_mutex,
 so there can be no deadlock cycle.
 
+.. _quiz_1:
+
 Quick Quiz #1:
 		Why is this argument naive?  How could a deadlock
 		occur when using this algorithm in a real-world Linux
@@ -679,7 +685,7 @@ Quick Quiz #1:
 :ref:`Answers to Quick Quiz <8_whatisRCU>`
 
 5B.  "TOY" EXAMPLE #2: CLASSIC RCU
-
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 This section presents a "toy" RCU implementation that is based on
 "classic RCU".  It is also short on performance (but only for updates) and
 on features such as hotplug CPU and the ability to run in CONFIG_PREEMPT
@@ -710,14 +716,14 @@ CPU in turn.  The run_on() primitive can be implemented straightforwardly
 in terms of the sched_setaffinity() primitive.  Of course, a somewhat less
 "toy" implementation would restore the affinity upon completion rather
 than just leaving all tasks running on the last CPU, but when I said
-"toy", I meant -toy-!
+"toy", I meant **toy**!
 
 So how the heck is this supposed to work???
 
 Remember that it is illegal to block while in an RCU read-side critical
 section.  Therefore, if a given CPU executes a context switch, we know
 that it must have completed all preceding RCU read-side critical sections.
-Once -all- CPUs have executed a context switch, then -all- preceding
+Once **all** CPUs have executed a context switch, then **all** preceding
 RCU read-side critical sections will have completed.
 
 So, suppose that we remove a data item from its structure and then invoke
@@ -725,12 +731,16 @@ synchronize_rcu().  Once synchronize_rcu() returns, we are guaranteed
 that there are no RCU read-side critical sections holding a reference
 to that data item, so we can safely reclaim it.
 
+.. _quiz_2:
+
 Quick Quiz #2:
 		Give an example where Classic RCU's read-side
-		overhead is -negative-.
+		overhead is **negative**.
 
 :ref:`Answers to Quick Quiz <8_whatisRCU>`
 
+.. _quiz_3:
+
 Quick Quiz #3:
 		If it is illegal to block in an RCU read-side
 		critical section, what the heck do you do in
@@ -1076,9 +1086,11 @@ Answer:
 		approach where tasks in RCU read-side critical sections
 		cannot be blocked by tasks executing synchronize_rcu().
 
+:ref:`Back to Quick Quiz #1 <quiz_1>`
+
 Quick Quiz #2:
 		Give an example where Classic RCU's read-side
-		overhead is -negative-.
+		overhead is **negative**.
 
 Answer:
 		Imagine a single-CPU system with a non-CONFIG_PREEMPT
@@ -1103,6 +1115,8 @@ Answer:
 		even the theoretical possibility of negative overhead for
 		a synchronization primitive is a bit unexpected.  ;-)
 
+:ref:`Back to Quick Quiz #2 <quiz_2>`
+
 Quick Quiz #3:
 		If it is illegal to block in an RCU read-side
 		critical section, what the heck do you do in
@@ -1128,6 +1142,7 @@ Answer:
 		Besides, how does the computer know what pizza parlor
 		the human being went to???
 
+:ref:`Back to Quick Quiz #3 <quiz_3>`
 
 ACKNOWLEDGEMENTS
 
-- 
2.20.1

