Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FE3CA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32ADE217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Na/pRE3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbfJ1VoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:44:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42230 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730592AbfJ1VoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:44:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id 21so7836831pfj.9;
        Mon, 28 Oct 2019 14:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=drfMRjPwU02ASI4D8UPPiRYEp0GQr7RmuUSXzOJ1M7c=;
        b=Na/pRE3OIbMvOU5Volk0BYefi+jBZUfF4rzcDoqfVGzl4K2s0TVoZleBlNrJ5KuDID
         8TQrHao/fBEgJOQyZHPyC16TNS/P4HeERIeymPCbIWVXPvfDfIJdh4f//ixuZSnE1My5
         QAcgtngX9mQQReaS+9pAeOA0zkn9swASNPOPY5j1zMf11hp9c25f3VhowuSsYXvc1QOS
         5DiEfLzgKfgpzDOV03RGhHff8lha/yzPDlkvrHxvZ0VAKGLp6++h5ih7KD32BBmjGDOF
         47na+6tLBIey1QH9Qnbwub48NVQM7WhRVIv47FK/Wi6PpDHt/SGahMy+DGke+igaesJM
         XZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=drfMRjPwU02ASI4D8UPPiRYEp0GQr7RmuUSXzOJ1M7c=;
        b=krwFqVzPQZJeBd09gGqA3Dms1BOKGiolEeu/J8fAqICrhYSfpFy5GJBV/4CusYXbWO
         dEWZYty0c/JYDcVeP45TwnkLGyNdBzCiryP33rKyHIfAKCQU1tSJ2IEqONYTOkcCo240
         RKlPtWD7TLvvub9JO+dir3YoMhPQ9v1C7dvxvOZqmZinZMbHzVr8JPBtShAbe7Uka+b+
         EaUYF26CtYLyMazSXHL6uwgwE9AU6AUspTncDU/0Zc1lkGgiOx7aZm4naXeXaxmJlhZO
         kBRa1BOtAexr+1sD5kqav1NCN1FyndDmsw0+GkkvqaygNI1wLgZiDurBZUxnLf9tevoc
         qH1Q==
X-Gm-Message-State: APjAAAXdVCY7DSUBGq0/eE3MbA9cGnqmuOVEuNgTwx8Uz81R6ev8rd90
        RAvkbUJkj/J+A7RSyioAnRkbgQmhAZ4=
X-Google-Smtp-Source: APXvYqwLPAL5HbcRKZvVZt2XxMfc6yX6k45Zo9pjgV++L6/nE9p6IGd9f9PIWWYsu5p/nVlN1KtQsA==
X-Received: by 2002:a17:90a:dd43:: with SMTP id u3mr1866546pjv.130.1572299047213;
        Mon, 28 Oct 2019 14:44:07 -0700 (PDT)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:539:24ac:ac7b:1049:baaf:a6f9])
        by smtp.gmail.com with ESMTPSA id t1sm1693013pgp.9.2019.10.28.14.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 14:44:06 -0700 (PDT)
From:   madhuparnabhowmik04@gmail.com
To:     paulmck@kernel.org, joel@joelfernandes.org, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH] Documentation: RCU: NMI-RCU: Converted NMI-RCU.txt to NMI-RCU.rst.
Date:   Tue, 29 Oct 2019 03:12:52 +0530
Message-Id: <20191028214252.17580-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch converts NMI-RCU from txt to rst format.
Also adds NMI-RCU in the index.rst file.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 .../RCU/{NMI-RCU.txt => NMI-RCU.rst}          | 53 ++++++++++---------
 Documentation/RCU/index.rst                   |  1 +
 2 files changed, 29 insertions(+), 25 deletions(-)
 rename Documentation/RCU/{NMI-RCU.txt => NMI-RCU.rst} (73%)

diff --git a/Documentation/RCU/NMI-RCU.txt b/Documentation/RCU/NMI-RCU.rst
similarity index 73%
rename from Documentation/RCU/NMI-RCU.txt
rename to Documentation/RCU/NMI-RCU.rst
index 881353fd5bff..da5861f6a433 100644
--- a/Documentation/RCU/NMI-RCU.txt
+++ b/Documentation/RCU/NMI-RCU.rst
@@ -1,4 +1,7 @@
+.. _NMI_rcu_doc:
+
 Using RCU to Protect Dynamic NMI Handlers
+=========================================
 
 
 Although RCU is usually used to protect read-mostly data structures,
@@ -9,7 +12,7 @@ work in "arch/x86/oprofile/nmi_timer_int.c" and in
 "arch/x86/kernel/traps.c".
 
 The relevant pieces of code are listed below, each followed by a
-brief explanation.
+brief explanation.::
 
 	static int dummy_nmi_callback(struct pt_regs *regs, int cpu)
 	{
@@ -18,12 +21,12 @@ brief explanation.
 
 The dummy_nmi_callback() function is a "dummy" NMI handler that does
 nothing, but returns zero, thus saying that it did nothing, allowing
-the NMI handler to take the default machine-specific action.
+the NMI handler to take the default machine-specific action.::
 
 	static nmi_callback_t nmi_callback = dummy_nmi_callback;
 
 This nmi_callback variable is a global function pointer to the current
-NMI handler.
+NMI handler.::
 
 	void do_nmi(struct pt_regs * regs, long error_code)
 	{
@@ -53,11 +56,12 @@ anyway.  However, in practice it is a good documentation aid, particularly
 for anyone attempting to do something similar on Alpha or on systems
 with aggressive optimizing compilers.
 
-Quick Quiz:  Why might the rcu_dereference_sched() be necessary on Alpha,
-	     given that the code referenced by the pointer is read-only?
+Quick Quiz:
+		Why might the rcu_dereference_sched() be necessary on Alpha, given that the code referenced by the pointer is read-only?
 
+:ref:`Answer to Quick Quiz <answer_quick_quiz_NMI>`
 
-Back to the discussion of NMI and RCU...
+Back to the discussion of NMI and RCU...::
 
 	void set_nmi_callback(nmi_callback_t callback)
 	{
@@ -68,7 +72,7 @@ The set_nmi_callback() function registers an NMI handler.  Note that any
 data that is to be used by the callback must be initialized up -before-
 the call to set_nmi_callback().  On architectures that do not order
 writes, the rcu_assign_pointer() ensures that the NMI handler sees the
-initialized values.
+initialized values::
 
 	void unset_nmi_callback(void)
 	{
@@ -82,7 +86,7 @@ up any data structures used by the old NMI handler until execution
 of it completes on all other CPUs.
 
 One way to accomplish this is via synchronize_rcu(), perhaps as
-follows:
+follows::
 
 	unset_nmi_callback();
 	synchronize_rcu();
@@ -98,24 +102,23 @@ to free up the handler's data as soon as synchronize_rcu() returns.
 Important note: for this to work, the architecture in question must
 invoke nmi_enter() and nmi_exit() on NMI entry and exit, respectively.
 
+.. _answer_quick_quiz_NMI:
 
-Answer to Quick Quiz
-
-	Why might the rcu_dereference_sched() be necessary on Alpha, given
-	that the code referenced by the pointer is read-only?
+Answer to Quick Quiz:
+	Why might the rcu_dereference_sched() be necessary on Alpha, given that the code referenced by the pointer is read-only?
 
-	Answer: The caller to set_nmi_callback() might well have
-		initialized some data that is to be used by the new NMI
-		handler.  In this case, the rcu_dereference_sched() would
-		be needed, because otherwise a CPU that received an NMI
-		just after the new handler was set might see the pointer
-		to the new NMI handler, but the old pre-initialized
-		version of the handler's data.
+	The caller to set_nmi_callback() might well have
+	initialized some data that is to be used by the new NMI
+	handler.  In this case, the rcu_dereference_sched() would
+	be needed, because otherwise a CPU that received an NMI
+	just after the new handler was set might see the pointer
+	to the new NMI handler, but the old pre-initialized
+	version of the handler's data.
 
-		This same sad story can happen on other CPUs when using
-		a compiler with aggressive pointer-value speculation
-		optimizations.
+	This same sad story can happen on other CPUs when using
+	a compiler with aggressive pointer-value speculation
+	optimizations.
 
-		More important, the rcu_dereference_sched() makes it
-		clear to someone reading the code that the pointer is
-		being protected by RCU-sched.
+	More important, the rcu_dereference_sched() makes it
+	clear to someone reading the code that the pointer is
+	being protected by RCU-sched.
diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 8d20d44f8fd4..627128c230dc 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -10,6 +10,7 @@ RCU concepts
    arrayRCU
    rcu
    listRCU
+   NMI-RCU
    UP
 
    Design/Memory-Ordering/Tree-RCU-Memory-Ordering
-- 
2.17.1

