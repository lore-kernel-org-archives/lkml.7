Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFEAC742A6
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 23:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913EE2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 23:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="tCGTNt4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbfGKXoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 19:44:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33002 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730497AbfGKXob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 19:44:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id c14so3827256plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 16:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sb5/sBlO0o0IY+ND5ZXjrKZw9gM/z/BZ2b8OMvqM37o=;
        b=tCGTNt4ClbRqV/NfTPLBheEFeH7Zn70VzEPVb6u6yQtg9GPOuDTUPJlXw6bBhUJ1CR
         QpGk/qoWbRMoK0Pts8WznAkBiv/X+3OAFvGO2tXIqriAKW54HJaBcZeAgZjm6E+3gJ7u
         xfrwf9Vd3o1AR/P1EbjFliZLl/0moKn0MvFEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sb5/sBlO0o0IY+ND5ZXjrKZw9gM/z/BZ2b8OMvqM37o=;
        b=YF3O6Ir/q1hSXcz8aFYUW7v0jCFJ/dM50UZljo1QiH+7eHhYokzWCjOO9awvp2YcuR
         cPm3xCN+ZoOtL/afoGsHrZsF3couA8gPWDQB1eMoHyAUNCXPmPmr/kwPzWgOfklNLYov
         Di5woNqLixCbipl9d1lvozDYQCx41h4sfc2CFa8xrimYUg47wqT+e7kM1TxaEPhHpm0+
         DgJ/hzNUkbRAorum7A1CbPgQIr92IKjkGcjnVFpDPb8eVBeCKJGPgiEp2pHsJgY6JHgS
         qeo5hCR7BzNoyoW1Rj7VxuIEiZ9kIibc2R1agrkSsYwZz2OvaXEtQ/F3yJ50MhRLHC6D
         Y0Vw==
X-Gm-Message-State: APjAAAU0ewfd1qhAR9S5rJHvkDDUXQL0l3BumBFpU1HIS0WTQWn4hTcg
        nL2j/j+Jhutgj1hXO3oQCa1xrXh5
X-Google-Smtp-Source: APXvYqz7RwC1sXenfqK+KGjrZckG5hTYMGbFgu1GP0DrdQq+/nz6LQrmjYSvr647um8kWQAd2c41tw==
X-Received: by 2002:a17:902:381:: with SMTP id d1mr7408739pld.331.1562888670006;
        Thu, 11 Jul 2019 16:44:30 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t10sm6163450pjr.13.2019.07.11.16.44.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 16:44:29 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>, c0d1n61at3@gmail.com,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neilb@suse.com, netdev@vger.kernel.org, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, peterz@infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH v1 4/6] workqueue: Convert for_each_wq to use built-in list check
Date:   Thu, 11 Jul 2019 19:43:59 -0400
Message-Id: <20190711234401.220336-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190711234401.220336-1-joel@joelfernandes.org>
References: <20190711234401.220336-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

list_for_each_entry_rcu now has support to check for RCU reader sections
as well as lock. Just use the support in it, instead of explictly
checking in the caller.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/workqueue.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9657315405de..91ed7aca16e5 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -424,9 +424,8 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
  * ignored.
  */
 #define for_each_pwq(pwq, wq)						\
-	list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node)		\
-		if (({ assert_rcu_or_wq_mutex(wq); false; })) { }	\
-		else
+	list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node,		\
+				 lock_is_held(&(wq->mutex).dep_map))
 
 #ifdef CONFIG_DEBUG_OBJECTS_WORK
 
-- 
2.22.0.410.gd8fdbe21b5-goog

