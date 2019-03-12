Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730A4C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3CA21734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfCLRp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:45:29 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36055 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfCLRp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:45:26 -0400
Received: by mail-oi1-f194.google.com with SMTP id t206so2837019oib.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 10:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HccK+fYLtqpEZfMwiBe6D8C3e7wDwbf9WW50Z/PProI=;
        b=UXNMbyYBza5sJEFoi1/vcgDkbRLTW1TfQ7IWFmCzFM9vheV8fRROMdOmbLAejVlrUp
         9aSZfDWZvU/PVz+jnc2ofMq4GYdqNKDT5/4GcTtA3u8fcrpko5Gs2/KD//JeR49SlgSr
         hYer0d2p/b3AM1yQ8qvRW8CD1SbfFLdtlz0NRjEHUQz6xkWGL4QKM+CW5C/rdw7Fcz/3
         it6oMNcPj7aBu6y1Fw8F38EOeFQQn1JJwAUPDoNEUpNKDtnqnnmp+Y+LydZxMvfI2lU5
         bahUvBbQ4Xo/2rvZcDClJEVOdSGkC9n3Q7b7nJJPS7Dm4UUE4cRkLqciXDebAzrBy23+
         X29w==
X-Gm-Message-State: APjAAAVpPzP+4G5V7ZwlE3Gu2ens9gHpOvXjnNQmcce+Ifn7dEGV3sgy
        HE1Ycx6Eq7zZ8DpPeFJ5vu8=
X-Google-Smtp-Source: APXvYqye0hnmv7pAGXdBIolazCUN2OVPVRFmxBCKF9wVuEGFBFrjN4yDlavLRNISW9yrF7O+Mdtchg==
X-Received: by 2002:aca:6cc9:: with SMTP id h192mr2487951oic.161.1552412726061;
        Tue, 12 Mar 2019 10:45:26 -0700 (PDT)
Received: from sultan-box.localdomain ([107.193.118.89])
        by smtp.gmail.com with ESMTPSA id x3sm3536175otg.52.2019.03.12.10.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 10:45:25 -0700 (PDT)
Date:   Tue, 12 Mar 2019 10:45:20 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Tim Murray <timmurray@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190312174520.GA9276@sultan-box.localdomain>
References: <20190310203403.27915-1-sultan@kerneltoast.com>
 <20190311174320.GC5721@dhcp22.suse.cz>
 <20190311175800.GA5522@sultan-box.localdomain>
 <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
 <20190311204626.GA3119@sultan-box.localdomain>
 <CAJuCfpGpBxofTT-ANEEY+dFCSdwkQswox3s8Uk9Eq0BnK9i0iA@mail.gmail.com>
 <20190312080532.GE5721@dhcp22.suse.cz>
 <20190312163741.GA2762@sultan-box.localdomain>
 <CAEe=Sxn_uayj48wo7oqf8mNZ7QAGJUQVmkPcHcuEGjA_Z8ELeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEe=Sxn_uayj48wo7oqf8mNZ7QAGJUQVmkPcHcuEGjA_Z8ELeQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 10:17:43AM -0700, Tim Murray wrote:
> Knowing whether a SIGKILL'd process has finished reclaiming is as far
> as I know not possible without something like procfds. That's where
> the 100ms timeout in lmkd comes in. lowmemorykiller and lmkd both
> attempt to wait up to 100ms for reclaim to finish by checking for the
> continued existence of the thread that received the SIGKILL, but this
> really means that they wait up to 100ms for the _thread_ to finish,
> which doesn't tell you anything about the memory used by that process.
> If those threads terminate early and lowmemorykiller/lmkd get a signal
> to kill again, then there may be two processes competing for CPU time
> to reclaim memory. That doesn't reclaim any faster and may be an
> unnecessary kill.
> ...
> - offer a way to wait for process termination so lmkd can tell when
> reclaim has finished and know when killing another process is
> appropriate

Should be pretty easy with something like this:
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1549584a1..6ac478af2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1199,6 +1199,7 @@ struct task_struct {
 	unsigned long			lowest_stack;
 	unsigned long			prev_lowest_stack;
 #endif
+	ktime_t sigkill_time;
 
 	/*
 	 * New fields for task_struct should be added above here, so that
diff --git a/kernel/fork.c b/kernel/fork.c
index 9dcd18aa2..0ae182777 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -435,6 +435,8 @@ void put_task_stack(struct task_struct *tsk)
 
 void free_task(struct task_struct *tsk)
 {
+	ktime_t sigkill_time = tsk->sigkill_time;
+	pid_t pid = tsk->pid;
 #ifndef CONFIG_THREAD_INFO_IN_TASK
 	/*
 	 * The task is finally done with both the stack and thread_info,
@@ -455,6 +457,9 @@ void free_task(struct task_struct *tsk)
 	if (tsk->flags & PF_KTHREAD)
 		free_kthread_struct(tsk);
 	free_task_struct(tsk);
+	if (sigkill_time)
+		printk("%d killed after %lld us\n", pid,
+		       ktime_us_delta(ktime_get(), sigkill_time));
 }
 EXPORT_SYMBOL(free_task);
 
@@ -1881,6 +1886,7 @@ static __latent_entropy struct task_struct *copy_process(
 	p->sequential_io	= 0;
 	p->sequential_io_avg	= 0;
 #endif
+	p->sigkill_time = 0;
 
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	retval = sched_fork(clone_flags, p);
diff --git a/kernel/signal.c b/kernel/signal.c
index 5d53183e2..1142c8811 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1168,6 +1168,8 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 	}
 
 out_set:
+	if (sig == SIGKILL)
+		t->sigkill_time = ktime_get();
 	signalfd_notify(t, sig);
 	sigaddset(&pending->signal, sig);
