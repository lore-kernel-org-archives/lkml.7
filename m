Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD5DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D063B2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfCKXDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:03:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37177 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfCKXDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 19:03:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id q206so267733pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 16:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b8pvfQl4bi9tCeV/6Zw6LeCUuPdxTvAXUEDOkeR57uA=;
        b=txVfDvNX/V0DFw/AnNiwM72NwpiwOZNREgaN7XGXsTKZ3UI0/ArAFmR4N8KYn2NHvZ
         /44Av3tgkjmSvWPCTMHD4K+ZrUb8txiQYI/aX280fOHRIsWbZB8WT+FiMZVNb48SEYcO
         39WLKWTn0c1ksUtbZadsptBFSb8icmsecGNk60XO4En7bltA5ougRzkpwDYLvzMEA76Q
         XjhWRs/P0QZp7RaIquTzuWoMxG05uIaz1FdwPlNHQNCgDaqyefYWYMzuzqROFCPZm4SA
         Q6waH+GoFQj2VQjEq+z4zXdvYlZGZXZd9txeU5yZtsJQ8tNLS7A08O9jl+3auCr13Wpu
         queQ==
X-Gm-Message-State: APjAAAXCaH1vRi69VNeT+7Bd2knrkY3Kh2PFKMGYT/Z/vUqeBRev1ZrE
        xxIOotBOt/2Vjc1k2R+OpOg=
X-Google-Smtp-Source: APXvYqyDlC1qLAy3R3LkKYA9I4djp413UjwYQzluuPC/tS7Pi8KrvO7N6EkzMqiJjBLcA/qMMD1mcw==
X-Received: by 2002:a63:cf01:: with SMTP id j1mr32049226pgg.342.1552345382929;
        Mon, 11 Mar 2019 16:03:02 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id t10sm9678807pgo.27.2019.03.11.16.03.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 16:03:02 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, Qian Cai <cai@lca.pw>,
        syzbot+be0c198232f86389c3dd@syzkaller.appspotmail.com
Subject: [PATCH] kernel/workqueue: Only unregister a lockdep key if it has been registered first
Date:   Mon, 11 Mar 2019 16:02:55 -0700
Message-Id: <20190311230255.176081-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only call wq_unregister_lockdep() if wq_register_lockdep() has been
called first. This patch avoids that the following warning is reported:

WARNING: CPU: 1 PID: 6970 at kernel/locking/lockdep.c:4925 lockdep_unregister_key+0x21c/0x4e0

That warning refers to the following source code statement:

	WARN_ON_ONCE(!found);

Cc: Tejun Heo <tj@kernel.org>
Cc: Qian Cai <cai@lca.pw>
Reported-by: syzbot+be0c198232f86389c3dd@syzkaller.appspotmail.com
Fixes: 009bb421b6ce ("workqueue, lockdep: Fix an alloc_workqueue() error path")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/workqueue.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 4026d1871407..ddee541ea97a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4266,7 +4266,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	INIT_LIST_HEAD(&wq->list);
 
 	if (alloc_and_link_pwqs(wq) < 0)
-		goto err_free_wq;
+		goto err_unreg_lockdep;
 
 	if (wq_online && init_rescuer(wq) < 0)
 		goto err_destroy;
@@ -4292,9 +4292,10 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	return wq;
 
-err_free_wq:
+err_unreg_lockdep:
 	wq_unregister_lockdep(wq);
 	wq_free_lockdep(wq);
+err_free_wq:
 	free_workqueue_attrs(wq->unbound_attrs);
 	kfree(wq);
 	return NULL;
-- 
2.21.0

