Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26896C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E230F20731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YCOEKUs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgAFOh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 09:37:28 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:41658 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgAFOh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 09:37:27 -0500
Received: by mail-il1-f194.google.com with SMTP id f10so42708263ils.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 06:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1Z14qoOtbTxvDPVboAUI1bo3wkIy9GLdLGtgSdoaN+w=;
        b=YCOEKUs2FxhokEcK3I2+fHUSruJtt1C6yvAJH4TPBs4Ti8IDZi9H/7isTYEtNYdT0q
         3SqpMgKgbKVN9c512cMaYZBWt9WtlKjCES3/StUa3UR4IHHhm4kY3w3abKtyJNckIPM8
         v+YmDzTvWyBdEcbWu4JDrEQw0clfQ+5YqkEjSk84DBK1ALrw3jnhymOrph/jxLbedMhz
         a8Of6PvtJPIn28pZjBVjxpM1N6SsIsfEHi83CfInb38AfZqP1FJ27wBLmpR4UlN2ZOCs
         9OekvCETC6pPuzbS8qjmRVwofCd/z/SQG8/vkiES25L/oz/qE9T98L94/iqSWykAQniz
         NSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1Z14qoOtbTxvDPVboAUI1bo3wkIy9GLdLGtgSdoaN+w=;
        b=b/k2l4XTkaRQiKeB83e/Xl3GyD3CL2VAFEb17pfVTpPeRc6mHYcBsQZI/rFrQR5mh2
         szCvftao0et9e2ejY/PFathObiwjLMK7saVypdyY50ec7qeB0+oO5KhrRwGSdPrlzAzv
         oo9xn/vzGKZEyTWb23jdZnkG3RrVA0O1a6X6Ayu7/bl56kMvKLzFmkT+zUCTdqvyoojy
         IxbMlRhNeA91cKxh9RHVbQNbblWCytLQlKu1QRqkXTD/yadbJHuq5DPW6wnLbxeJBfjs
         qwmRmfHe8Y1Hu5IQoN1WgbkSIrZB7X4W/dtQgumM0ErnYpmScAbt13ES5gD8Owv1FV25
         ESsA==
X-Gm-Message-State: APjAAAVKl/qPggS6JNWykZxyW/1jNthZxsUK25Qaft0nA6uL9yRuHJEl
        ZZBPDUiPVzDyLj+PFONrg+h+sA==
X-Google-Smtp-Source: APXvYqxoq5vB6+1tEInish5ag1fISYrMKCFCWvtHt6kJVL6pVvNve7/P1AjlUMy4Eh2q+K2QTrXzCA==
X-Received: by 2002:a92:3991:: with SMTP id h17mr91202047ilf.131.1578321446634;
        Mon, 06 Jan 2020 06:37:26 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1058-79.members.linode.com. [45.33.121.79])
        by smtp.gmail.com with ESMTPSA id n17sm10364536ile.68.2020.01.06.06.37.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jan 2020 06:37:26 -0800 (PST)
Date:   Mon, 6 Jan 2020 22:37:17 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     "liwei (GF)" <liwei391@huawei.com>
Cc:     acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, ilubashe@akamai.com,
        peterz@infradead.org, mingo@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huawei.libin@huawei.com
Subject: Re: [RFC PATCH] perf tools: cs-etm: fix endless record after being
 terminated
Message-ID: <20200106143717.GC29905@leoy-ThinkPad-X240s>
References: <20200102074144.10407-1-liwei391@huawei.com>
 <20200103082414.GB9814@leoy-ThinkPad-X240s>
 <acc0afd9-5d0e-dcb8-d56a-ac5680049c8c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acc0afd9-5d0e-dcb8-d56a-ac5680049c8c@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On Mon, Jan 06, 2020 at 11:00:19AM +0800, liwei (GF) wrote:
> Hi Leo,
> 
> Thanks for your test and sorry for missing the reproducing info.
> The attachment is my test procedure, i can reproduce this issue
> with it on kernel 5.5-rc4 definitely.
> 
> I have tested these patches on kernel 5.5-rc4, with intel-pt on Xeon
> Gold 6140 (72 cores) and arm-spe on HiSilicon Hi1620 (128 cores).
> But i can not test CoreSight temporarily, could you please test it
> with the test procedure again?

Thanks for the test code.

I tested it with perf/cs-etm, but cannot reproduce the issue.  But after
capturing trace data with trace-cmd, I think this indeed is an
potential issue; the reason for Arm cs-etm cannot produce this issue,
one possibility is because cs-etm doesn't trigger interrupt; if the
interrupt is triggered, perf tool might fail to stop hardware events
with below flow:

  Perf thread:                           Profiled thread(s)

  __cmd_record()
    evlist__disable()
      set_affinity()
        migration to prfiled thread's CPU
          evsel__disable_cpu()
            ioctl(PERF_EVENT_IOC_DISABLE)

                                      Thread is scheduled out
                                        ctx_sched_out()
                                          event_sched_out()
                                            etm4_disable()

  record__mmap_read_all()
    record__auxtrace_mmap_read()
      auxtrace_mmap__read()
        itr->read_finish()
          cs_etm_read_finish()
            ioctl(PERF_EVENT_IOC_ENABLE)

                                     Thread is scheduled in
                                       __perf_event_task_sched_in()
                                         perf_event_sched_in()
                                           event_sched_in()
                                             etm4_enable()

  the condition (hits == rec->samples) is
  never true, infinite loop in
  __cmd_record()


So a minor suggestion for your patch:

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index ede040cf82ad..29c5eefa6e41 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -864,6 +864,9 @@ static int cs_etm_read_finish(struct auxtrace_record *itr, int idx)
                        container_of(itr, struct cs_etm_recording, itr);
        struct evsel *evsel;
 
+       if (!ptr->evlist->enabled)
+               return 0;
+
        evlist__for_each_entry(ptr->evlist, evsel) {
                if (evsel->core.attr.type == ptr->cs_etm_pmu->type)
                        return perf_evlist__enable_event_idx(ptr->evlist,

I'd like to wait a bit if others can find more general method to fix
this issue.

Thanks,
Leo

> P.s. Running the test procedure as a normal process is enough.
> 
> Thanks，
> Wei
> 
> On 2020/1/3 16:24, Leo Yan wrote:
> 
> > 
> > I took some time to test on Arm CoreSight, the perf program can be
> > terminated by Ctrl+c with SIGINT signal on the mainline kernel.
> > 
> > And after capturing ftrace data with below log:
> > 
> > 5242      migration/2-19    [002] d..3  4648.383155: sched_migrate_task: comm=perf pid=1692 prio=120 orig_cpu=2 dest_cpu=0
> > 5243      migration/2-19    [002] d..2  4648.383167: sched_switch: prev_comm=migration/2 prev_pid=19 prev_prio=0 prev_state=S ==> next_comm=swapper/2 next_pid=0 next_prio=120
> > 5244           <idle>-0     [000] d..2  4648.383167: sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=perf next_pid=1692 next_prio=120
> > 5245             perf-1692  [000] d..2  4648.383193: sched_stat_runtime: comm=perf pid=1692 runtime=35420 [ns] vruntime=1636633943 [ns]
> > 5246             perf-1692  [000] d..3  4648.383200: sched_waking: comm=migration/0 pid=11 prio=0 target_cpu=000
> > 5247             perf-1692  [000] dN.4  4648.383203: sched_wakeup: comm=migration/0 pid=11 prio=0 target_cpu=000
> > 5248             perf-1692  [000] dN.2  4648.383205: sched_stat_runtime: comm=perf pid=1692 runtime=9340 [ns] vruntime=1636643283 [ns]
> > 5249             perf-1692  [000] d..2  4648.383208: sched_switch: prev_comm=perf prev_pid=1692 prev_prio=120 prev_state=R+ ==> next_comm=migration/0 next_pid=11 next_prio=0
> > 5250      migration/0-11    [000] d..3  4648.383215: sched_migrate_task: comm=perf pid=1692 prio=120 orig_cpu=0 dest_cpu=1
> > 5251       algorithm1-721   [001] dN.2  4648.383225: sched_stat_runtime: comm=algorithm1 pid=721 runtime=2906000 [ns] vruntime=3501282256244 [ns]
> > 5252       algorithm1-721   [001] d..2  4648.383229: sched_switch: prev_comm=algorithm1 prev_pid=721 prev_prio=120 prev_state=R ==> next_comm=perf next_pid=1692 next_prio=120
> > 5253      migration/0-11    [000] d..2  4648.383235: sched_switch: prev_comm=migration/0 prev_pid=11 prev_prio=0 prev_state=S ==> next_comm=swapper/0 next_pid=0 next_prio=120
> > 5254       algorithm1-721   [001] d..4  4648.383241: <stack trace>
> > 5255  => kprobe_breakpoint_handler
> > 5256  => call_break_hook
> > 5257  => brk_handler
> > 5258  => do_debug_exception
> > 5259  => el1_sync_handler
> > 5260  => el1_sync
> > 5261  => etm_event_stop
> > 5262  => event_sched_out.isra.106
> > 5263  => group_sched_out.part.108
> > 5264  => ctx_sched_out
> > 5265  => task_ctx_sched_out
> > 5266  => __perf_event_task_sched_out
> > 5267  => __schedule
> > 5268  => schedule
> > 5269  => do_notify_resume
> > 5270  => work_pending
> > 
> > We can see after send SIGINT signal, the process 'perf' will be
> > migrated from CPU2 to CPU0 (line 5242) and it will preempt process
> > 'algorithm1' (line 5252); after the process 'algorithm1' is scheduled
> > out, the function etm_event_stop() will be invoked to stop tracing.
> > 
> > If we connect with the code in cs_etm_read_finish(), it tries to call
> > ioctl PERF_EVENT_IOC_ENABLE, but because the process 'algorithm1' is
> > scheduled out, so the perf event should not be enabled afterwards.
> > 
> > I may miss something at here ... Could you confirm what's the type of
> > attached process?  normal process or RT process?
> > 
> > Thanks,
> > Leo
> > 
> > P.s. I tested IntelPT with 5.2-rc3 kernel, it also can be terminated
> > properly.
> > 
> >>  	return -EINVAL;
> >> -- 
> >> 2.17.1
> >>
> > 
> > .
> > 
> 

> #define _GNU_SOURCE
> 
> #include <stdlib.h>
> #include <stdio.h>
> #include <sys/types.h>
> #include <sys/sysinfo.h>
> #include <unistd.h>
> #include <sched.h>
> #include <ctype.h>
> #include <string.h>
> #include <pthread.h>
> 
> int num = 0;
> int test[65535];
> 
> int mess_rw(int data)
> {
>     int i;
> 
>     while (1) {
>         for (i = 0; i < (sizeof(test) / sizeof(test[0])); i++) {
>             if (test[i] != data)
>                 test[i] = data;
>         }
>     }
> }
> 
> void *test_thread(void *arg)
> {
>     int cpu = *(int *)arg;
>     cpu_set_t mask;
> 
>     CPU_ZERO(&mask);
>     CPU_SET(cpu, &mask);
>     if (!sched_setaffinity(0, sizeof(mask), &mask))
>         printf("thread %d: running on cpu %d\n", cpu, cpu);
>     else
>         printf("thread %d: fail to set CPU affinity\n", cpu);
> 
>     mess_rw(cpu);
> 
>     return NULL;
> }
> 
> int main(int argc, char *argv[])
> {
>     num = sysconf(_SC_NPROCESSORS_CONF);
>     pthread_t thread[num];
>     int id[num];
>     int i;
> 
>     printf("PID %d on system with %d processor(s)\n", getpid(), num);
> 
>     for (i = 0; i < num; i++) {
>         id[i] = i;
>         pthread_create(&thread[i], NULL, test_thread, (void *)&id[i]);
>     }
> 
>     for (i = 0; i < num; i++) {
>         pthread_join(thread[i], NULL);
>     }
> 
>     return 0;
> }
> 

