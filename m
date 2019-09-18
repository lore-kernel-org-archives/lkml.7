Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC45CC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B32218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4Pzj31U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfIRHWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 03:22:10 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36930 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbfIRHWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 03:22:10 -0400
Received: by mail-yb1-f196.google.com with SMTP id v5so2369065ybq.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 00:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3waIZxFnfruYn6UWTx/U0ZPW+zFOtuGmcVoVDfSXecQ=;
        b=L4Pzj31UcS3ktSop76cqcgLFAqAdFLv2e88WBeTP3SfgkwJy55J4Q+phq0d1PoSwoL
         hJzcUtCB+vkKh3RwZ/SBuzM+h1WeeEd46MAsKsRX111CVnAk+bYgTezaN+fxK4uNji5C
         JEqvEi1a0EIWtqnpjNodKxI5koMHy4uUybQQZ4SgypQ5nHg9/si5gDJs0+NxUeOfXmw/
         NkXBvpV1IdLuL0828ziaWJ1Ssm8VKbaJbjpCK2zaG8VvX7FH9j5pWF2NGHHpAD/0LhBZ
         WfESJHMHP+47p0+qEbwxuu2vs7CxyEwH2haK8OEQLAV7VRMKEfnTJWUt+KFMEP91MPU2
         3MfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3waIZxFnfruYn6UWTx/U0ZPW+zFOtuGmcVoVDfSXecQ=;
        b=Zg83p94wlZKbAICJE5whnuA7AlAn6j6w8q9Cu6BSCevT+C1lpp3J8AAjZZ3F6gVoP6
         h8bfY+i6k8KSXuy7AtbXL3BqXFtOOOuOySimG2mkhLp5EoBQOcFefkQ1t4rNzyEs1ljn
         WsGZe5lPzN724dqT+RlU3yPeu2nIUabtDuMCc8iXnQhFgIaMFAoK5cB6fKNVw4NpC8tI
         315V9BQMRmYQEfFrY8C2Vhk8Sr0wV6HUT1AY6zguyhsHVsN/CmKVhiNGd77Gckest/7a
         AmMGKhpKo1HwrggEegwqlnJgmjGpmbZE07PzAvnh0Al3xhQvL6U7vn6tdvMAK68ZhsUH
         WoQA==
X-Gm-Message-State: APjAAAXKtl/dI9ba5/a+rTtHD0nS/oFbtg8eC4Gy6ZkbdX6D8p+jRCoi
        7Ff4H2T0pQYetLTOSrUCZEQ2u3s93s6bK0X4XJM=
X-Google-Smtp-Source: APXvYqwMINabRag2TO51mwH36zD4OhkI5JYI+tim5VswZxut2oWIVpUZEfWVldmVRgOhRArtaqVmU3aaKCI3S6UI6Io=
X-Received: by 2002:a25:76ca:: with SMTP id r193mr1780653ybc.33.1568791328924;
 Wed, 18 Sep 2019 00:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190601082722.44543-1-irogers@google.com> <20190621082422.GH3436@hirez.programming.kicks-ass.net>
 <CAP-5=fW7sMjQEHm+1e=cdAi+ZyP53UyU7xhAbnouMApuxYqrhw@mail.gmail.com>
 <20190624075520.GC3436@hirez.programming.kicks-ass.net> <CAP-5=fU=xbP39b6WZV4h92g6Ub_w4tH2JdApw5t6DTyZqxShUQ@mail.gmail.com>
 <CAKTKpr6m7YzqJ7U2icNHq7ZwoG0pw8ws_EHcLR+-T6ZeEfe15Q@mail.gmail.com>
 <20190823115946.GM2349@hirez.programming.kicks-ass.net> <CAKTKpr5N6thBR+SJ8rdRTCEjv+7GVsw3R9EY+cKTGexz-yr4sg@mail.gmail.com>
 <20190823130322.GO2349@hirez.programming.kicks-ass.net>
In-Reply-To: <20190823130322.GO2349@hirez.programming.kicks-ass.net>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Wed, 18 Sep 2019 12:51:57 +0530
Message-ID: <CAKTKpr7=U9zLXefvJ-DDxNkeQhZWTPUEzjiZW=28wJo9uCJPPw@mail.gmail.com>
Subject: Re: [PATCH] perf cgroups: Don't rotate events for cgroups unnecessarily
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 6:33 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Aug 23, 2019 at 06:26:34PM +0530, Ganapatrao Kulkarni wrote:
> > On Fri, Aug 23, 2019 at 5:29 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Fri, Aug 23, 2019 at 04:13:46PM +0530, Ganapatrao Kulkarni wrote:
> > >
> > > > We are seeing regression with our uncore perf driver(Marvell's
> > > > ThunderX2, ARM64 server platform) on 5.3-Rc1.
> > > > After bisecting, it turned out to be this patch causing the issue.
> > >
> > > Funnily enough; the email you replied to didn't contain a patch.
> >
> > Hmm sorry, not sure why the patch is clipped-off, I see it in my inbox.
>
> Your email is in a random spot of the discussion for me. At least it was
> fairly easy to find the related patch.
>
> > > > Test case:
> > > > Load module and run perf for more than 4 events( we have 4 counters,
> > > > event multiplexing takes place for more than 4 events), then unload
> > > > module.
> > > > With this sequence of testing, the system hangs(soft lockup) after 2
> > > > or 3 iterations. Same test runs for hours on 5.2.
> > > >
> > > > while [ 1 ]
> > > > do
> > > >         rmmod thunderx2_pmu
> > > >         modprobe thunderx2_pmu
> > > >         perf stat -a -e \
> > > >         uncore_dmc_0/cnt_cycles/,\
> > > >         uncore_dmc_0/data_transfers/,\
> > > >         uncore_dmc_0/read_txns/,\
> > > >         uncore_dmc_0/config=0xE/,\
> > > >         uncore_dmc_0/write_txns/ sleep 1
> > > >         sleep 2
> > > > done
> > >
> > > Can you reproduce without the module load+unload? I don't think people
> > > routinely unload modules.
> >
> > The issue wont happen, if module is not unloaded/reloaded.
> > IMHO, this could be potential bug!
>
> Does the softlockup give a useful stacktrace? I don't have a thunderx2
> so I cannot reproduce.

Sorry for the late reply, below is the dump that i am getting, when i
hit the softlockup.
Any suggestions to debug this further?

sequence of commands, which leads to this lockup,
insmod thunderx2_pmu.ko
perf stat -e \
uncore_dmc_0/cnt_cycles/,\
uncore_dmc_0/data_transfers/,\
uncore_dmc_0/read_txns/,\
uncore_dmc_0/config=0xE/,\
uncore_dmc_0/write_txns/\
rmmod thunderx2_pmu
insmod thunderx2_pmu.ko

root@SBR-26>~>> [ 1065.946772] watchdog: BUG: soft lockup - CPU#117
stuck for 22s! [perf:5206]
[ 1065.953722] Modules linked in: thunderx2_pmu(OE) nls_iso8859_1
joydev input_leds bridge ipmi_ssif ipmi_devintf stp llc
ipmi_msghandler sch_fq_codel ib_iser rdma_cm iw_cm ib_cm ib_core
iscsi_tcp libiscsi_tcp
libiscsi scsi_transport_iscsi ppdev lp parport ip_tables x_tables
autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov
async_memcpy async_pq async_xor async_tx xor xor_neon raid6_pq raid1
raid0 multipat
h linear aes_ce_blk hid_generic aes_ce_cipher usbhid uas usb_storage
hid ast i2c_algo_bit drm_vram_helper ttm drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops drm i40e i2c_smbus bnx2x
crct10dif_ce g
hash_ce e1000e sha2_ce mpt3sas nvme sha256_arm64 ptp ahci raid_class
sha1_ce nvme_core scsi_transport_sas mdio libahci pps_core libcrc32c
gpio_xlp i2c_xlp9xx aes_neon_bs aes_neon_blk crypto_simd cryptd
aes_arm6
4 [last unloaded: thunderx2_pmu]
[ 1066.029640] CPU: 117 PID: 5206 Comm: perf Tainted: G           OE
  5.3.0+ #160
[ 1066.037109] Hardware name: Cavium Inc. Saber/Saber, BIOS
TX2-FW-Release-7.2-build_08-0-g14f8c5bf8a 12/18/2018
[ 1066.047009] pstate: 20400009 (nzCv daif +PAN -UAO)
[ 1066.051799] pc : smp_call_function_single+0x198/0x1b0
[ 1066.056838] lr : smp_call_function_single+0x16c/0x1b0
[ 1066.061875] sp : fffffc00434cfc50
[ 1066.065177] x29: fffffc00434cfc50 x28: 0000000000000000
[ 1066.070475] x27: fffffebed4d2d952 x26: ffffffffd4d2d800
[ 1066.075774] x25: fffffddf5da1e240 x24: 0000000000000001
[ 1066.081073] x23: fffffc00434cfd38 x22: fffffc001026adb8
[ 1066.086371] x21: 0000000000000000 x20: fffffc0011843000
[ 1066.091669] x19: fffffc00434cfca0 x18: 0000000000000000
[ 1066.096968] x17: 0000000000000000 x16: 0000000000000000
[ 1066.102266] x15: 0000000000000000 x14: 0000000000000000
[ 1066.107564] x13: 0000000000000000 x12: 0000000000000020
[ 1066.112862] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
[ 1066.118161] x9 : 0000000000000000 x8 : fffffebed44ec5e8
[ 1066.123459] x7 : 0000000000000000 x6 : fffffc00434cfca0
[ 1066.128757] x5 : fffffc00434cfca0 x4 : 0000000000000001
[ 1066.134055] x3 : fffffc00434cfcb8 x2 : 0000000000000000
[ 1066.139353] x1 : 0000000000000003 x0 : 0000000000000000
[ 1066.144652] Call trace:
[ 1066.147088]  smp_call_function_single+0x198/0x1b0
[ 1066.151784]  perf_install_in_context+0x1b4/0x1d8
[ 1066.156394]  __se_sys_perf_event_open+0x634/0xa68
[ 1066.161089]  __arm64_sys_perf_event_open+0x1c/0x28
[ 1066.165881]  el0_svc_common.constprop.0+0x78/0x168
[ 1066.170660]  el0_svc_handler+0x34/0x90
[ 1066.174399]  el0_svc+0x8/0xc
[ 1100.985033] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[ 1100.990944] rcu:     0-...0: (4 ticks this GP) idle=bb6/0/0x1
softirq=2178/2178 fqs=7365
[ 1100.998864]  (detected by 154, t=15005 jiffies, g=14325, q=7133)
[ 1101.004857] Task dump for CPU 0:
[ 1101.008074] swapper/0       R  running task        0     0      0 0x0000002a
[ 1101.015110] Call trace:
[ 1101.017553]  __switch_to+0xbc/0x220
[ 1244.366396] INFO: task kworker/116:1:1364 blocked for more than 120 seconds.
[ 1244.373443]       Tainted: G           OEL    5.3.0+ #160
[ 1244.378847] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 1244.386673] kworker/116:1   D    0  1364      2 0x00000028
[ 1244.392166] Workqueue: events do_free_init
[ 1244.396260] Call trace:
[ 1244.398705]  __switch_to+0x194/0x220
[ 1244.402282]  __schedule+0x30c/0x758
[ 1244.405758]  schedule+0x38/0xa8
[ 1244.408896]  schedule_timeout+0x220/0x3a8
[ 1244.412902]  wait_for_common+0x110/0x220
[ 1244.416819]  wait_for_completion+0x28/0x38
[ 1244.420914]  __wait_rcu_gp+0x170/0x1a8
[ 1244.424658]  synchronize_rcu+0x70/0xa0
[ 1244.428403]  do_free_init+0x3c/0x70
[ 1244.431889]  process_one_work+0x1f8/0x438
[ 1244.435896]  worker_thread+0x50/0x4b8
[ 1244.439554]  kthread+0x130/0x138
[ 1244.442778]  ret_from_fork+0x10/0x18
[ 1280.996503] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[ 1281.002415] rcu:     0-...0: (4 ticks this GP) idle=bb6/0/0x1
softirq=2178/2178 fqs=29040
[ 1281.010420]  (detected by 186, t=60010 jiffies, g=14325, q=22339)
[ 1281.016500] Task dump for CPU 0:
[ 1281.019715] swapper/0       R  running task        0     0      0 0x0000002a
[ 1281.026751] Call trace:
[ 1281.029189]  __switch_to+0xbc/0x220
[ 1365.192710] INFO: task kworker/116:1:1364 blocked for more than 241 seconds.
[ 1365.199756]       Tainted: G           OEL    5.3.0+ #160
[ 1365.205158] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 1365.212984] kworker/116:1   D    0  1364      2 0x00000028
[ 1365.218475] Workqueue: events do_free_init
[ 1365.222569] Call trace:
[ 1365.225014]  __switch_to+0x194/0x220
[ 1365.228589]  __schedule+0x30c/0x758
[ 1365.232065]  schedule+0x38/0xa8
[ 1365.235203]  schedule_timeout+0x220/0x3a8
[ 1365.239209]  wait_for_common+0x110/0x220
[ 1365.243127]  wait_for_completion+0x28/0x38
[ 1365.247222]  __wait_rcu_gp+0x170/0x1a8
[ 1365.250966]  synchronize_rcu+0x70/0xa0
[ 1365.254711]  do_free_init+0x3c/0x70
[ 1365.258198]  process_one_work+0x1f8/0x438
[ 1365.262205]  worker_thread+0x50/0x4b8
[ 1365.265863]  kthread+0x130/0x138
[ 1365.269087]  ret_from_fork+0x10/0x18
[ 1461.008017] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[ 1461.013929] rcu:     0-...0: (4 ticks this GP) idle=bb6/0/0x1
softirq=2178/2178 fqs=51540
[ 1461.021930]  (detected by 123, t=105015 jiffies, g=14325, q=37487)
[ 1461.028096] Task dump for CPU 0:
[ 1461.031311] swapper/0       R  running task        0     0      0 0x0000002a
[ 1461.038347] Call trace:
[ 1461.040785]  __switch_to+0xbc/0x220
[ 1486.023005] INFO: task kworker/116:1:1364 blocked for more than 362 seconds.
[ 1486.030049]       Tainted: G           OEL    5.3.0+ #160
[ 1486.035447] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 1486.043272] kworker/116:1   D    0  1364      2 0x00000028
[ 1486.048762] Workqueue: events do_free_init
[ 1486.052856] Call trace:
[ 1486.055300]  __switch_to+0x194/0x220
[ 1486.058875]  __schedule+0x30c/0x758
[ 1486.062351]  schedule+0x38/0xa8
[ 1486.065487]  schedule_timeout+0x220/0x3a8
[ 1486.069493]  wait_for_common+0x110/0x220
[ 1486.073411]  wait_for_completion+0x28/0x38
[ 1486.077504]  __wait_rcu_gp+0x170/0x1a8
[ 1486.081248]  synchronize_rcu+0x70/0xa0
[ 1486.084994]  do_free_init+0x3c/0x70
[ 1486.088479]  process_one_work+0x1f8/0x438
[ 1486.092486]  worker_thread+0x50/0x4b8
[ 1486.096143]  kthread+0x130/0x138
[ 1486.099367]  ret_from_fork+0x10/0x18
[ 1606.849300] INFO: task kworker/116:1:1364 blocked for more than 483 seconds.
[ 1606.856345]       Tainted: G           OEL    5.3.0+ #160


Thanks,
Ganapat
