Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8605AC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463B2206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="NQQjvORh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389228AbfHAVjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 17:39:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37790 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389175AbfHAVjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:39:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1so2095004pgp.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 14:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kT6d62v3IkstWdOxiS46a/cLyvcRbEdBparblNqkUuo=;
        b=NQQjvORho9kJQQ2IzD8WqRk3/pXGXfIdnxH+fkC6qgXk0sSN2OtDUpI6sa7OKd/0nW
         XeKn9c4Zjgw+uT9+Y12kI0VVIkflkSeL06HubY6fxQluDH3CQ9AiaIqI/fFnCZU40iIR
         Rq3cFbzm2ldhmVJWIlFT86ZdK82S/+ceQXsNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kT6d62v3IkstWdOxiS46a/cLyvcRbEdBparblNqkUuo=;
        b=pHhaGvfpF/bwcCaT0ekwcMGHlPJdCkJrdbPulDjrrIAL/op2JftQL5YFKCg7k1OkRP
         Bm6AMbTYQP25Yeo4blqfT3K/RZbNk5RvOYjBj++Dyor5uX/n3IFlldcyHkuRNB2LBiJj
         bbi6klVS6viHxJ0Ta3klWG1zhdjx3x8wlDLMjP/E9rXyH8fsZKRNpY1pDIGa21+BKuk/
         pZhWAL+DvDKoyP0g1sBxXGJ2XOTZVZLhYBM83l1ewqqxDbivMk6+ZqdS7AkG8IqABBgw
         L3YvwiowrRecHQsdnEBSera9hauWSaJI/Vnskr1vsfpjLv8lWIHOnQ2ODoSHWcgvAMY5
         kTxg==
X-Gm-Message-State: APjAAAXEQVWy6amic0ROP6W5l7SMI6XQYQpIesDiw24wSj9mnLNSMUT6
        f2nUSDNiRORg4yYTaubAUAFDG3eD
X-Google-Smtp-Source: APXvYqxBuvaOwDQOmLSNT5ONs6xK/VAALi6FxYdPhMhSXB3Y0JXx8OUA04+SKQ+wyjGbiig18TeUSA==
X-Received: by 2002:a62:e20b:: with SMTP id a11mr56432547pfi.0.1564695575463;
        Thu, 01 Aug 2019 14:39:35 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r61sm5940423pjb.7.2019.08.01.14.39.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 14:39:34 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org
Subject: ['PATCH v2' 1/7] Revert docs from "rcu: Restore barrier() to rcu_read_lock() and rcu_read_unlock()"
Date:   Thu,  1 Aug 2019 17:39:16 -0400
Message-Id: <20190801213922.158860-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801213922.158860-1-joel@joelfernandes.org>
References: <20190801213922.158860-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts docs from commit d6b9cd7dc8e041ee83cb1362fce59a3cdb1f2709.
---
 .../RCU/Design/Requirements/Requirements.html | 71 -------------------
 1 file changed, 71 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
index 467251f7fef6..bdbc84f1b949 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.html
+++ b/Documentation/RCU/Design/Requirements/Requirements.html
@@ -2129,8 +2129,6 @@ Some of the relevant points of interest are as follows:
 <li>	<a href="#Hotplug CPU">Hotplug CPU</a>.
 <li>	<a href="#Scheduler and RCU">Scheduler and RCU</a>.
 <li>	<a href="#Tracing and RCU">Tracing and RCU</a>.
-<li>	<a href="#Accesses to User Memory and RCU">
-Accesses to User Memory and RCU</a>.
 <li>	<a href="#Energy Efficiency">Energy Efficiency</a>.
 <li>	<a href="#Scheduling-Clock Interrupts and RCU">
 	Scheduling-Clock Interrupts and RCU</a>.
@@ -2523,75 +2521,6 @@ cannot be used.
 The tracing folks both located the requirement and provided the
 needed fix, so this surprise requirement was relatively painless.
 
-<h3><a name="Accesses to User Memory and RCU">
-Accesses to User Memory and RCU</a></h3>
-
-<p>
-The kernel needs to access user-space memory, for example, to access
-data referenced by system-call parameters.
-The <tt>get_user()</tt> macro does this job.
-
-<p>
-However, user-space memory might well be paged out, which means
-that <tt>get_user()</tt> might well page-fault and thus block while
-waiting for the resulting I/O to complete.
-It would be a very bad thing for the compiler to reorder
-a <tt>get_user()</tt> invocation into an RCU read-side critical
-section.
-For example, suppose that the source code looked like this:
-
-<blockquote>
-<pre>
- 1 rcu_read_lock();
- 2 p = rcu_dereference(gp);
- 3 v = p-&gt;value;
- 4 rcu_read_unlock();
- 5 get_user(user_v, user_p);
- 6 do_something_with(v, user_v);
-</pre>
-</blockquote>
-
-<p>
-The compiler must not be permitted to transform this source code into
-the following:
-
-<blockquote>
-<pre>
- 1 rcu_read_lock();
- 2 p = rcu_dereference(gp);
- 3 get_user(user_v, user_p); // BUG: POSSIBLE PAGE FAULT!!!
- 4 v = p-&gt;value;
- 5 rcu_read_unlock();
- 6 do_something_with(v, user_v);
-</pre>
-</blockquote>
-
-<p>
-If the compiler did make this transformation in a
-<tt>CONFIG_PREEMPT=n</tt> kernel build, and if <tt>get_user()</tt> did
-page fault, the result would be a quiescent state in the middle
-of an RCU read-side critical section.
-This misplaced quiescent state could result in line&nbsp;4 being
-a use-after-free access, which could be bad for your kernel's
-actuarial statistics.
-Similar examples can be constructed with the call to <tt>get_user()</tt>
-preceding the <tt>rcu_read_lock()</tt>.
-
-<p>
-Unfortunately, <tt>get_user()</tt> doesn't have any particular
-ordering properties, and in some architectures the underlying <tt>asm</tt>
-isn't even marked <tt>volatile</tt>.
-And even if it was marked <tt>volatile</tt>, the above access to
-<tt>p-&gt;value</tt> is not volatile, so the compiler would not have any
-reason to keep those two accesses in order.
-
-<p>
-Therefore, the Linux-kernel definitions of <tt>rcu_read_lock()</tt>
-and <tt>rcu_read_unlock()</tt> must act as compiler barriers,
-at least for outermost instances of <tt>rcu_read_lock()</tt> and
-<tt>rcu_read_unlock()</tt> within a nested set of RCU read-side critical
-sections.
-
 <h3><a name="Energy Efficiency">Energy Efficiency</a></h3>
 
 <p>
-- 
2.22.0.770.g0f2c4a37fd-goog

