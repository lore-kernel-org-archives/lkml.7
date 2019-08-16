Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C80EC3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7122089E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="gdQSJruo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfHPC7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 22:59:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40238 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfHPC7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 22:59:32 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so1845310pla.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 19:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5TOZw4aX2ouYHWL3SPiBVA6qRZbVTxguU44+pODdzqI=;
        b=gdQSJruoAM1XM+3a/CIqDvm0o6MwERJuLTfpy9OI9EGyi8eqi1yTpNYOYc1pMFygim
         Mj0B864cQw1184rdHxkBe+b5EoTA7r8bRQv+vewlFkxnjYXVlvmIUEPqYeHeaxcuY2kj
         DZeEWsiHhMJMcd0pt4KxN4CQTl7VmYJBYI89Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5TOZw4aX2ouYHWL3SPiBVA6qRZbVTxguU44+pODdzqI=;
        b=tWxGHQ6jP1282wWJ082sP5dSEW/OVOTdoD2XLHywd26yeuTnEJy8VQmmABipa063Yo
         Wu9eWvqI+DRW0fSGJkWK4jfm43W4Jbf1mSSlm+YkGtay3HpdV+z/DWnAzfpvNxHVE38r
         5ehmcHZ4bUs7XVuKnFJuLpAnteCxlyqOlNu4niBQHVUNVx8f+xjuiKCYfoMVvyYPL9mG
         oz7TECt6PfVxDRydHXDRk8e5dYcii0q7LjD3wrXcmQfbpyG/IGpQmyoNuScrkP0bmmNj
         xeDVCT7Nw9LUG695smZVyclQqjOs7Of6MZJl9nMwzIintUvfbznwU3bwYkUIGpi+34iZ
         +NDQ==
X-Gm-Message-State: APjAAAW11HCs9lsz7x+S9pU1fCG6+F/jM2PqV/IxqJ7u3YOfC71Pa4JQ
        U7K0OLcJCgbZCB1/VNg4W4CbHOIZmPo=
X-Google-Smtp-Source: APXvYqzOsc28s9gVz0EkrhaSrs5/PUB6mUriwSSU1aeKlkoNXVLriuQGGqrLsSQSAAAn3wdPYB2XOg==
X-Received: by 2002:a17:902:424:: with SMTP id 33mr7238481ple.34.1565924371577;
        Thu, 15 Aug 2019 19:59:31 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id v184sm3378377pgd.34.2019.08.15.19.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 19:59:30 -0700 (PDT)
Date:   Thu, 15 Aug 2019 22:59:14 -0400
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        frederic@kernel.org
Subject: [PATCH v2 -rcu dev 2/3] rcu/tree: Fix issue where sometimes
 rcu_urgent_qs is not set on IPI
Message-ID: <20190816025914.GB242309@google.com>
References: <20190816025311.241257-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816025311.241257-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes I see rcu_urgent_qs is not set. This could be when the last
IPI was a long time ago, however, the grace period just started. Set
rcu_urgent_qs so the tick can indeed not be stopped.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 322b1b57967c..856d3c9f1955 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1091,6 +1091,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	if (tick_nohz_full_cpu(rdp->cpu) &&
 		   time_after(jiffies,
 			      READ_ONCE(rdp->last_fqs_resched) + jtsq * 3)) {
+		WRITE_ONCE(*ruqp, true);
 		resched_cpu(rdp->cpu);
 		WRITE_ONCE(rdp->last_fqs_resched, jiffies);
 	}
-- 
2.23.0.rc1.153.gdeed80330f-goog

