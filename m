Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF829C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE02921774
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575317624;
	bh=MXoENw3cYJ6J7KpnVVbH5KT0PBuJDBdvZjwKlnHQKOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CDsl+o/6qHftSdZh1EdrtGlZqcbnAckt6TaZDGYJn3s6C+DGnDccMS1+IGh+hRLln
	 YJTiIREPFJlp2E1ZvYwxoceJrxXNMm1XKoLVCJYuw3h7aDvxmukjHNA9oovqDb0I79
	 PNTaYla6YlTZg2mfS9ylazHpyaD354IbAFdos1xI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfLBUNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 15:13:43 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:45950 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbfLBUNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 15:13:41 -0500
Received: by mail-qk1-f172.google.com with SMTP id x1so869215qkl.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 12:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sBnzwv1UojXwcxoE01fHXt46ZRgERe+2cEMc8lTvX3E=;
        b=DreL1zkTtshzjI6V8vid1mjQeP7Xu5Jhh4ucMAJDI/aufGo89p2/2FjWEuriutdG/6
         A6J4ubhi5yiggUNWynoR6LH4+WP/qJXRSWiD1/klNtlKQkRDib8nvBe907UnPdA5vXT/
         SAWV1S9UfscHSRPXMPugVgxQDX50BoyGuoE2uujTqS9ZX3/vFomSjyPJuptQwAUHt1/D
         chYqWMnWEkbMTFl5xOVEAhyXnC29sYI8iltxCnZDDgrD4Uv8JtdYghGRGkj0y4+YBP0u
         LQc8bg0E1RB4toTajCpiaMo241Cvl6uLCLvTkndyjrFqKhGAiK8d5CRwRuvNjD5C/ijy
         MiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sBnzwv1UojXwcxoE01fHXt46ZRgERe+2cEMc8lTvX3E=;
        b=Tnuy7mzdDyLeWsooYhbv77P+hFptmHjH8LvGwbtdWHpm+zXaZtpLiaaYVXwf1b/T2O
         DdEzcdq+r3mNAZBwbTg2dm3Y+C6plFpHRVoSJxkrPwzeFqBPjLg60TxW9LY6UKe0KZYs
         YVZo52EzafuwfUmyA3xpk69E2FDvXIBdfoW0ODDzvERDXXqSr1uFxEQSEAm/XNdiHItE
         LSa6dkD9tPrF2w6CzEVuq6/FewkiZhG4hB36bBELmETlQuUu7amLg1NPpQTQxM2t7TzL
         HahZwAgkw5BdXQTgY4vKNZijSi9X3xWww68K4DIU1ev4Tjd5N0dWTEKRtkDyYnweO7el
         H31w==
X-Gm-Message-State: APjAAAVCrUL6WOdWCeRgXmr88VUT+Z5uWP45qe36400XJemwOlygzhYA
        KcG6C8Cz13VGHvfiCIU5cZE=
X-Google-Smtp-Source: APXvYqyNNKabKnJy9SL+NWsZ7LyYz0TW4CMLLMVJiO8Rdt1NNMt7sN2QiHqv19Ep9cYz0AaCQwJ8sQ==
X-Received: by 2002:a05:620a:1363:: with SMTP id d3mr713037qkl.263.1575317620556;
        Mon, 02 Dec 2019 12:13:40 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:c909])
        by smtp.gmail.com with ESMTPSA id 13sm350850qke.85.2019.12.02.12.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 12:13:39 -0800 (PST)
Date:   Mon, 2 Dec 2019 12:13:38 -0800
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Workqueues splat due to ending up on wrong CPU
Message-ID: <20191202201338.GH16681@devbig004.ftw2.facebook.com>
References: <20191125230312.GP2889@paulmck-ThinkPad-P72>
 <20191126183334.GE2867037@devbig004.ftw2.facebook.com>
 <20191126220533.GU2889@paulmck-ThinkPad-P72>
 <20191127155027.GA15170@paulmck-ThinkPad-P72>
 <20191128161823.GA24667@paulmck-ThinkPad-P72>
 <20191129155850.GA17002@paulmck-ThinkPad-P72>
 <20191202015548.GA13391@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202015548.GA13391@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Paul.

(cc'ing scheduler folks - workqueue rescuer is very occassionally
triggering a warning which says that it isn't on the cpu it should be
on under rcu cpu hotplug torture test.  It's checking smp_processor_id
is the expected one after a successful set_cpus_allowed_ptr() call.)

On Sun, Dec 01, 2019 at 05:55:48PM -0800, Paul E. McKenney wrote:
> > And hyperthreading seems to have done the trick!  One splat thus far,
> > shown below.  The run should complete this evening, Pacific Time.
> 
> That was the only one for that run, but another 24*56-hour run got three
> more.  All of them expected to be on CPU 0 (which never goes offline, so
> why?) and the "XXX" diagnostic never did print.

Heh, I didn't expect that, so maybe set_cpus_allowed_ptr() is
returning 0 while not migrating the rescuer task to the target cpu for
some reason?

The rescuer is always calling to migrate itself, so it must always be
running.  set_cpus_allowed_ptr() migrates live ones by calling
stop_one_cpu() which schedules a migration function which runs from a
highpri task on the target cpu.  Please take a look at the following.

  static bool cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
  {
          ...
	  enabled = stopper->enabled;
	  if (enabled)
		  __cpu_stop_queue_work(stopper, work, &wakeq);
	  else if (work->done)
		  cpu_stop_signal_done(work->done);
          ...
  }

So, if stopper->enabled is clear, it'll signal completion without
running the work.  stopper->enabled is cleared during cpu hotunplug
and restored from bringup_cpu() while cpu is being brought back up.

  static int bringup_wait_for_ap(unsigned int cpu)
  {
          ...
	  stop_machine_unpark(cpu);
          ....
  }

  static int bringup_cpu(unsigned int cpu)
  {
	  ...
	  ret = __cpu_up(cpu, idle);
          ...
	  return bringup_wait_for_ap(cpu);
  }

__cpu_up() is what marks the cpu online and once the cpu is online,
kthreads are free to migrate into the cpu, so it looks like there's a
brief window where a cpu is marked online but the stopper thread is
still disabled meaning that a kthread may schedule into the cpu but
not out of it, which would explain the symptom that you were seeing.

This makes the cpumask and the cpu the task is actually on disagree
and retries would become noops.  I can work around it by excluding
rescuer attachments against hotplugs but this looks like a genuine cpu
hotplug bug.

It could be that I'm misreading the code.  What do you guys think?

Thanks.

-- 
tejun
