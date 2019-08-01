Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF90C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7491520838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FI9pCSok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389276AbfHAVjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 17:39:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34561 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389198AbfHAVjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:39:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so28688660pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 14:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sa7dl9/Bg+B6qij2R03P065SrXCEeaEiOhF+kfqmyI8=;
        b=FI9pCSokvG3H6vsTXt0B9KmGnGubyGFBgM4M1njVQMJ1DkURP0wkrBj0v5Zf8ZAvel
         MOQTYfkUS5uRh5kds8LdXiYK3I0guUC0sS75de4twfoQc/KegraznSl5+vlDd6fvZe5g
         7jfAW0tAXw38d2tVrj70mIl8J9M459YIsXjck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sa7dl9/Bg+B6qij2R03P065SrXCEeaEiOhF+kfqmyI8=;
        b=LKmCc8lBkxpk3hzdYsxHIZ0R6xIOO/sx/nGhc7RoGahiYjLd2L84jeIHZ9txsYEOQ3
         fLaJqdi4Deu+1K95SeYn7Jl9lvzXlLkf6UWjy0yGZ8aWM7lnkWt6XgGmXLHUH6B6kTcb
         l0uGQMia40qhHIxVI9sRIJGuulLDyoUBvVHybBCCLqOTGSn2IQUPGl7fpFMHpMPQO8PP
         zWoOLitGq2i7Pt0EILdBSImM1HoeP1E4B1W3UY0V4Fmf1mun68cYldw8OAm1Yf6EdQEM
         T6chTlLAdoazxgxh1D/lIBfQdGWmv2XP9QVBCijKaRRZ5t7NYM+V+rrGCb7PqmxhqAmE
         ScuA==
X-Gm-Message-State: APjAAAXBotpbKJurGq2EsDYN+hSrycRCWdeCY67yPMwbgzV82CgE23Fy
        GpNLOlhpLmhZAckZsC7uHuqvkfVh
X-Google-Smtp-Source: APXvYqweHt9TEHKnVR54CT5pPpsfDW2i7AM+lKCqk704wd5AiCNzUY2F4eYlA45raVZ3uF9Aon7qVQ==
X-Received: by 2002:a62:1883:: with SMTP id 125mr55694381pfy.178.1564695587051;
        Thu, 01 Aug 2019 14:39:47 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r61sm5940423pjb.7.2019.08.01.14.39.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 14:39:46 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org
Subject: ['PATCH v2' 7/7] Restore docs "rcu: Restore barrier() to rcu_read_lock() and rcu_read_unlock()"
Date:   Thu,  1 Aug 2019 17:39:22 -0400
Message-Id: <20190801213922.158860-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801213922.158860-1-joel@joelfernandes.org>
References: <20190801213922.158860-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This restores docs back in ReST format.
---
 .../RCU/Design/Requirements/Requirements.rst  | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 0b222469d7ce..fd5e2cbc4935 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1691,6 +1691,7 @@ follows:
 #. `Hotplug CPU`_
 #. `Scheduler and RCU`_
 #. `Tracing and RCU`_
+#. `Accesses to User Memory and RCU`_
 #. `Energy Efficiency`_
 #. `Scheduling-Clock Interrupts and RCU`_
 #. `Memory Efficiency`_
@@ -2004,6 +2005,59 @@ where RCU readers execute in environments in which tracing cannot be
 used. The tracing folks both located the requirement and provided the
 needed fix, so this surprise requirement was relatively painless.
 
+Accesses to User Memory and RCU
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The kernel needs to access user-space memory, for example, to access data
+referenced by system-call parameters.  The ``get_user()`` macro does this job.
+
+However, user-space memory might well be paged out, which means that
+``get_user()`` might well page-fault and thus block while waiting for the
+resulting I/O to complete.  It would be a very bad thing for the compiler to
+reorder a ``get_user()`` invocation into an RCU read-side critical section.
+
+For example, suppose that the source code looked like this:
+
+  ::
+
+       1 rcu_read_lock();
+       2 p = rcu_dereference(gp);
+       3 v = p->value;
+       4 rcu_read_unlock();
+       5 get_user(user_v, user_p);
+       6 do_something_with(v, user_v);
+
+The compiler must not be permitted to transform this source code into
+the following:
+
+  ::
+
+       1 rcu_read_lock();
+       2 p = rcu_dereference(gp);
+       3 get_user(user_v, user_p); // BUG: POSSIBLE PAGE FAULT!!!
+       4 v = p->value;
+       5 rcu_read_unlock();
+       6 do_something_with(v, user_v);
+
+If the compiler did make this transformation in a ``CONFIG_PREEMPT=n`` kernel
+build, and if ``get_user()`` did page fault, the result would be a quiescent
+state in the middle of an RCU read-side critical section.  This misplaced
+quiescent state could result in line 4 being a use-after-free access,
+which could be bad for your kernel's actuarial statistics.  Similar examples
+can be constructed with the call to ``get_user()`` preceding the
+``rcu_read_lock()``.
+
+Unfortunately, ``get_user()`` doesn't have any particular ordering properties,
+and in some architectures the underlying ``asm`` isn't even marked
+``volatile``.  And even if it was marked ``volatile``, the above access to
+``p->value`` is not volatile, so the compiler would not have any reason to keep
+those two accesses in order.
+
+Therefore, the Linux-kernel definitions of ``rcu_read_lock()`` and
+``rcu_read_unlock()`` must act as compiler barriers, at least for outermost
+instances of ``rcu_read_lock()`` and ``rcu_read_unlock()`` within a nested set
+of RCU read-side critical sections.
+
 Energy Efficiency
 ~~~~~~~~~~~~~~~~~
 
-- 
2.22.0.770.g0f2c4a37fd-goog

