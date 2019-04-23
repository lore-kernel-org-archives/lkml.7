Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932E8C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B43A2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="ZtqpIGoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfDWQSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:18:37 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55811 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfDWQSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:18:37 -0400
Received: by mail-it1-f196.google.com with SMTP id y134so1103321itc.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=P40/LD9uIlHxn4vzWFRnqItKARtsU9eLOhXzRAPryO0=;
        b=ZtqpIGojsTOTBVsxqs0FSFZiDWuQRVxKTlsLXL17NsEmzZIfUPpnJ8kESmA0fRsyZH
         l1MQdB8HKG/nx5xJIlkpAqmPmGzH7Ud5/abyiUrxMWKI9NpTcLID4JZGMpAW7IMFy3gr
         ph5kV1cfnqiH1A0YOWfKOIa/Nn/K8lekuY6po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=P40/LD9uIlHxn4vzWFRnqItKARtsU9eLOhXzRAPryO0=;
        b=in/K/cT+ioTLRSw9jLYmFfpXH+pDFBjcA7qDBpJVwKl1H2fU0kw6vyyQ+DeWaVJz3p
         9yGJt6Ocn5Awk6i4PHvt8dUJKVchX/zdqDubts0rZiKAi0CQxEnHuX8UBmcGHgoArLTI
         QUc5+MR4zQ1+hKrpqdOgH8i7WjTYFGiGFMRhrYyAoYpXo7jZGNjNIC7IN49D+FEqUmku
         ZZ7w8ALfz9t5ig/49Zqrw0A2LDKAaUMdTIzglaOz3CciaSYeE0+33w6aqtRc0/62vQeb
         uWHWebi7ESde+/1HUn3OO+yq1fKdtEaBXnpJBi9WtZtsjkdDQv/eFNKjDsXaUI+NAqUV
         UUaA==
X-Gm-Message-State: APjAAAV41LvyKXpaW0wNyDDlIkdYH1VeejCC/Al5e97HXzHoLMDKiWop
        QyC+GAWkQh3gOd1sAbtTTuNoXA==
X-Google-Smtp-Source: APXvYqwV1GgYNpS0mu93ZoChWAbHgYy0A1PasILvS8HW4Gnkbc/sW1JM8nbdWBa13f4JVKGvOlYEMw==
X-Received: by 2002:a24:1f50:: with SMTP id d77mr2655361itd.25.1556036316191;
        Tue, 23 Apr 2019 09:18:36 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id b8sm7898604itb.20.2019.04.23.09.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 09:18:35 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v2 02/17] sched: Fix kerneldoc comment for ia64_set_curr_task
Date:   Tue, 23 Apr 2019 16:18:07 +0000
Message-Id: <69ce8b60cad07a90a891b38c273c7e2feed219e3.1556025155.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra (Intel) <peterz@infradead.org>

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4778c48a7fda..416ea613eda8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6287,7 +6287,7 @@ struct task_struct *curr_task(int cpu)
 
 #ifdef CONFIG_IA64
 /**
- * set_curr_task - set the current task for a given CPU.
+ * ia64_set_curr_task - set the current task for a given CPU.
  * @cpu: the processor in question.
  * @p: the task pointer to set.
  *
-- 
2.17.1

