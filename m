Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47D6C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49B42073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574793219;
	bh=DoxSBZYEpRQykiJU0eF8x24dPheYXejp57k7Cn1HnwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dH0jtM+fPi1Edzz5AQgPLIYhdE8HSkC+c4BMFJMBXMecA9QSnC2awUort6EdzL/By
	 euQcNtt9p3JI+t9ljXzON+6wgkkW8D2p0vhSI1syHi1snie5zg6dERghT4hK5+3gDz
	 BZpP2tuyU4x7ea9iuexwhl1yLeEK4vNAw0LPJc7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKZSdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 13:33:38 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:33647 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfKZSdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 13:33:38 -0500
Received: by mail-qk1-f172.google.com with SMTP id c124so12610490qkg.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 10:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0jeP7KaHv7YsCv1jCoWE5LK+r6qAeG4La8v/St6ahg8=;
        b=InwV8hK7aBz1KrmcBg7SZ68jx75YYmhnbQ2YYBqIBpo5Rx/QOlvehIC1Q3/SuOVyoH
         2W+UPtH/i07F69enErahBDnQ3OuIFhxZhJj0lv0KCW2bHuMickxoX8wvshN88b8EXSwK
         hJHjtpjMxLEGdc/hqg2mNk2JS5+cTsEp2bU3BOza3ZM1FvN4iRLIxQs/O+f2du0Et4s/
         5RS3UaT6nf5AYqyEVRthbPBqdIBNfbMx2kqV2ziPAUdgUL+svRgSOUJxIv6S6JKV6FKb
         TD+Ec44Z9fmIywYYz1KATEHS8cVJhwpgYqc49eZ0CuevK01i3q2dmDEusBZdaR8zW/9e
         okkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0jeP7KaHv7YsCv1jCoWE5LK+r6qAeG4La8v/St6ahg8=;
        b=TGLQ9jNzaejiq7NX+ioaMSYRAfgk6zaicFQq6O7FpOkp0/it95ytj1POUnEP9Neqn8
         /awgs7W01nFq73/HmwxB6Fnau37Usycq/04efFcr8AiAsVtmE9obSHiAD8wGSRLcNzxE
         izROaPgQZG6e3qS9OKyUb71e7eL8bo93SnqmX8As6QpfVRU76842hEDuBDhqO1YiBphd
         P8vchvj8hvnAJt7qcJfrZEJzwhI5g52eiScFr2aO3v9wQbfZZXkYirry63YuDUOrwZUg
         YqtI3SKWyWSAXmLmh5you5+jdWeo7vQiCqyln2w2v6gMmj24CFQiUP0D0pbpP4ANkHq2
         uFkg==
X-Gm-Message-State: APjAAAUmJ8nJaQzo90VzoDJsQ4c6NJ31IOz4OA1q3NGIsCa5wp+q8yyz
        ZIgLAlE3FIFauPRbWudAptc=
X-Google-Smtp-Source: APXvYqxnfhLvNwviBus4PnQ80CjE83hA0BDOBKC8rNBC7rR/AfxNbUi1JIga8VGRPpO3fO0Ck6R+rg==
X-Received: by 2002:a05:620a:149b:: with SMTP id w27mr3373101qkj.37.1574793216599;
        Tue, 26 Nov 2019 10:33:36 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:a515])
        by smtp.gmail.com with ESMTPSA id d134sm5548172qkc.42.2019.11.26.10.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 10:33:36 -0800 (PST)
Date:   Tue, 26 Nov 2019 10:33:34 -0800
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Workqueues splat due to ending up on wrong CPU
Message-ID: <20191126183334.GE2867037@devbig004.ftw2.facebook.com>
References: <20191125230312.GP2889@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125230312.GP2889@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Paul.

On Mon, Nov 25, 2019 at 03:03:12PM -0800, Paul E. McKenney wrote:
> I am seeing this occasionally during rcutorture runs in the presence
> of CPU hotplug.  This is on v5.4-rc1 in process_one_work() at the first
> WARN_ON():
> 
> 	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
> 		     raw_smp_processor_id() != pool->cpu);

Hmm... so it's saying that this worker's pool is supposed to be bound
to a cpu but it's currently running on the wrong cpu.

> What should I do to help further debug this?

Do you always see rescuer_thread in the backtrace?  Can you please
apply the following patch and reproduce the problem?

Thanks.

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 914b845ad4ff..6f7f185cd146 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1842,13 +1842,18 @@ static struct worker *alloc_worker(int node)
 static void worker_attach_to_pool(struct worker *worker,
 				   struct worker_pool *pool)
 {
+	int ret;
+
 	mutex_lock(&wq_pool_attach_mutex);
 
 	/*
 	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
 	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
 	 */
-	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
+	ret = set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
+	if (ret && !(pool->flags & POOL_DISASSOCIATED))
+		printk("XXX worker pid %d failed to attach to cpus of pool %d, ret=%d\n",
+		       task_pid_nr(worker->task), pool->id, ret);
 
 	/*
 	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
@@ -2183,8 +2188,10 @@ __acquires(&pool->lock)
 	lockdep_copy_map(&lockdep_map, &work->lockdep_map);
 #endif
 	/* ensure we're on the correct CPU */
-	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
-		     raw_smp_processor_id() != pool->cpu);
+	WARN_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
+		  raw_smp_processor_id() != pool->cpu,
+		  "expected on cpu %d but on cpu %d, pool %d, workfn=%pf\n",
+		  pool->cpu, raw_smp_processor_id(), pool->id, work->func);
 
 	/*
 	 * A single work shouldn't be executed concurrently by

-- 
tejun
