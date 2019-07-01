Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4238EC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 04:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2D9208CA
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 04:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="v/51NHIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfGAEEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 00:04:22 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38959 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfGAEEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 00:04:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so6598024pls.6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 21:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qybcP71evSZ3Czn0uZ7CwmogDfy9EhMz13IGHYQ9cik=;
        b=v/51NHIUki6YLjlvVPl3Jkfy7LUXWmK+iv3xk/Yp5JXZfN1742/jzEvBIYfRQKD8nZ
         ZAoHAoVAOPwhteWQ+O8bq5IIwUuoqa5AaYkLo+24ZtRhoUoQkVBZADwqS64JFYX6WytD
         X0ReoI/87B2gO5zL342T39V9EKj51eCT+uqLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qybcP71evSZ3Czn0uZ7CwmogDfy9EhMz13IGHYQ9cik=;
        b=kiUkbySgJ40Y/nEmENTaEqa9YQvVJdgDpM/eOr8NWEpLl9BCA/0vwkDIdXyi1ILKWZ
         lnXcqDG+8rLqr/nxmJHPVAGRyz/jlKNHGJMOGFphXbvZhyMTRkhPEEheASAZY2kqZlsa
         EVI02DdtNJm8oa/7CXGczj+UPwO6r+b7hizomRmfF+JG3ughIw0FBEcV97qA8hQqGRnH
         Hx4oms+/5QPD7ZpIfDSeZVcfL345TLnUH0owgi55tXsmv4a6r2C5LTm3FveNSaV/J8m7
         jDvdu/Y+8fRdwUUB5pGfroSMnp0Ex7LETPGOlx/+OPYsbrw4aHlp7ObijAg5iUMj+apx
         NlpQ==
X-Gm-Message-State: APjAAAUs2VvTlJx8z+LJlNv5DntOzTdAPKW7TQToC3wWaniKsnc8DPOl
        s1bB0k6ujESMyXLzgCrGfh5vm7uSFd8=
X-Google-Smtp-Source: APXvYqwR9FE1833UFgkphzpSnzxNBVxKDsrfEsL+IpRiKj6qQ2Q0E4uUpp8v0bAB1+jNqfjBrOsa5w==
X-Received: by 2002:a17:902:70c3:: with SMTP id l3mr26445926plt.248.1561953860960;
        Sun, 30 Jun 2019 21:04:20 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id w1sm10841305pjt.30.2019.06.30.21.04.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 21:04:20 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC 1/3] rcu: Expedite the rcu quiescent state reporting if help needed
Date:   Mon,  1 Jul 2019 00:04:13 -0400
Message-Id: <20190701040415.219001-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The t->rcu_read_unlock_special union's need_qs bit can be set by the
scheduler tick (in rcu_flavor_sched_clock_irq) to indicate that help is
needed from the rcu_read_unlock path. When this help arrives however, we
can do better to speed up the quiescent state reporting which if
rcu_read_unlock_special::need_qs is set might be quite urgent. Make use
of this information in deciding when to do heavy-weight softirq raising
where possible.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_plugin.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c588ef98efd3..bff6410fac06 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -622,7 +622,8 @@ static void rcu_read_unlock_special(struct task_struct *t)
 		t->rcu_read_unlock_special.b.exp_hint = false;
 		exp = (t->rcu_blocked_node && t->rcu_blocked_node->exp_tasks) ||
 		      (rdp->grpmask & rnp->expmask) ||
-		      tick_nohz_full_cpu(rdp->cpu);
+		      tick_nohz_full_cpu(rdp->cpu)  ||
+		      t->rcu_read_unlock_special.b.need_qs;
 		// Need to defer quiescent state until everything is enabled.
 		if (irqs_were_disabled && use_softirq &&
 		    (in_interrupt() ||
-- 
2.22.0.410.gd8fdbe21b5-goog

