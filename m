Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6236ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3600E21655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571931415;
	bh=62aFIdduqU1IHaCj7by8ytH0sqQH+P0+Z5Fs4R/NAjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Q7lpelBoFUqN6tnjc4VdpbAnRGYEmn2YfTJyh+3Ls2k6Jy7Zc5uvQwW09wdM0oo2S
	 38RkIEIYgKCa2Sk00zuvk99oxIWNw4l69uDHv5DNGJ3UzSw7aM+DZhM01gH4uBjd2q
	 YXkxVpCMT0V1UyHAzyemXPwgF9OZgwO7Vg3wAgMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503320AbfJXPgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503224AbfJXPgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:36:53 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F73821655;
        Thu, 24 Oct 2019 15:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571931412;
        bh=62aFIdduqU1IHaCj7by8ytH0sqQH+P0+Z5Fs4R/NAjI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZlTFhNNha0xza3QejEtXYxo77M4hTx54/QxwidaZtttPbJIehAW3Vke+fCoWq4qd0
         8QFFclKV+xku9pGWpkHcJz3aSU696l/GZb/CIRGG4esZoIsLRZhSVnt2ImE/64stqi
         5f8AViw4r2zYWGq+WQzWo8EWuQmo+9Mr1DyuDQCg=
Date:   Fri, 25 Oct 2019 00:36:48 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH 0/3] perf/probe: Fix available line bugs
Message-Id: <20191025003648.af4216cbf71bf2d5e60d2932@kernel.org>
In-Reply-To: <20191024134325.GA1666@kernel.org>
References: <157190834681.1859.7399361844806238387.stgit@devnote2>
        <20191024134325.GA1666@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Thu, 24 Oct 2019 10:43:25 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Thu, Oct 24, 2019 at 06:12:27PM +0900, Masami Hiramatsu escreveu:
> > Hi,
> > 
> > Here are some bugfixes related to showing available line (--line/-L)
> > option. I found that gcc generated some subprogram DIE with only
> > range attribute but no entry_pc or low_pc attributes.
> > In that case, perf probe failed to show the available lines in that
> > subprogram (function). To fix that, I introduced some bugfixes to
> > handle such cases correctly.
> 
> Thanks, applied, next time please provide concrete examples for things
> that don't work before and gets fixed with your patches, this way we can
> more easily reproduce your steps.

OK, I'll try, but I found that this kind of examples depend on
gcc optimization (like build option, gcc version etc.) So even if you
can not reproduce, don't be disappointed ;)

Anyway, for this series, I found that clear_tasks_mm_cpumask() caused
the (triple) issues.

So, without any patch, I got below error.

$ tools/perf/perf probe -k ../build-x86_64/vmlinux -L clear_tasks_mm_cpumask
Specified source line is not found.
  Error: Failed to show lines.

Hmm, there should be something wrong... so I fixed it with [1/3].
(to find appropriate target function, you can use "eu-readelf -w vmlinux"
 and find the subprogram which has no entry_pc nor low_pc but has ranges)

$ tools/perf/perf probe -k ../build-x86_64/vmlinux -L clear_tasks_mm_cpumask
<clear_tasks_mm_cpumask@/home/mhiramat/ksrc/mincs/work/linux/linux/kernel/cpu.c:
         void clear_tasks_mm_cpumask(int cpu)
      1  {
      2         struct task_struct *p;
         
                /*
                 * This function is called after the cpu is taken down and marke
                 * offline, so its not like new tasks will ever get this cpu set
                 * their mm mask. -- Peter Zijlstra
                 * Thus, we may use rcu_read_lock() here, instead of grabbing
                 * full-fledged tasklist_lock.
                 */
     11         WARN_ON(cpu_online(cpu));
     12         rcu_read_lock();
     13         for_each_process(p) {
     14                 struct task_struct *t;
         
                        /*
                         * Main thread might exit, but other threads may still h
                         * a valid mm. Find one.
                         */
     20                 t = find_lock_task_mm(p);
     21                 if (!t)
                                continue;
                        cpumask_clear_cpu(cpu, mm_cpumask(t->mm));
                        task_unlock(t);
                }
     26         rcu_read_unlock();
     27  }
         
OK! it looks working... but a bit wired. why line #0, #23 and #24 are not
available?
I investigated it and found a wrong logic and fixed it with [2/3]

$ tools/perf/perf probe -k ../build-x86_64/vmlinux -L clear_tasks_mm_cpumask:20
<clear_tasks_mm_cpumask@/home/mhiramat/ksrc/mincs/work/linux/linux/kernel/cpu.c:
     20                 t = find_lock_task_mm(p);
     21                 if (!t)
                                continue;
     23                 cpumask_clear_cpu(cpu, mm_cpumask(t->mm));
     24                 task_unlock(t);
                }
     26         rcu_read_unlock();
     27  }

OK, it found line #23 and #24. And add [3/3]

$ tools/perf/perf probe -k ../build-x86_64/vmlinux -L clear_tasks_mm_cpumask
<clear_tasks_mm_cpumask@/home/mhiramat/ksrc/mincs/work/linux/linux/kernel/cpu.c:
      0  void clear_tasks_mm_cpumask(int cpu)
      1  {
      2         struct task_struct *p;

OK, so now it works well :)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
