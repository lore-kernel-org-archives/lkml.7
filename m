Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED57C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5247620830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfDCOQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:16:40 -0400
Received: from semf04.mfg.siteprotect.com ([64.26.60.167]:49852 "EHLO
        semf04.mfg.siteprotect.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbfDCOQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:16:39 -0400
Received: from smtpauth02.mfg.siteprotect.com ([64.26.60.151])
        by semf04.mfg.siteprotect.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <vince@deater.net>)
        id 1hBggL-0000oA-54; Wed, 03 Apr 2019 10:16:10 -0400
Received: from pianoman.cluster.toy (unknown [100.16.227.202])
        (Authenticated sender: vince@deater.net)
        by smtpauth02.mfg.siteprotect.com (Postfix) with ESMTPSA id 44Z7Qk1vBhz2YQfJ1;
        Wed,  3 Apr 2019 10:15:42 -0400 (EDT)
Date:   Wed, 3 Apr 2019 10:15:33 -0400 (EDT)
From:   Vince Weaver <vince@deater.net>
X-X-Sender: vince@pianoman.cluster.toy
To:     Cyrill Gorcunov <gorcunov@gmail.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [RFC PATCH v3 0/3] x86/perf/amd: AMD PMC counters and NMI
 latency
In-Reply-To: <20190402213151.GC23501@uranus>
Message-ID: <alpine.DEB.2.21.1904031009300.26186@pianoman.cluster.toy>
References: <155415519143.24457.2706922532995302758.stgit@tlendack-t1.amdoffice.net> <20190402130302.GL12232@hirez.programming.kicks-ass.net> <20190402132200.GA23501@uranus> <alpine.DEB.2.21.1904021050090.15645@pianoman.cluster.toy> <20190402150936.GB23501@uranus>
 <alpine.DEB.2.21.1904021709340.24692@pianoman.cluster.toy> <20190402213151.GC23501@uranus>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: mfg.siteprotect.com; auth=pass smtp.auth=vince@deater.net smtp.mailfrom=<vince@deater.net>
X-Originating-IP: 64.26.60.151
X-portal.siteprotect.com-Domain: mfg.outbound
X-portal.siteprotect.com-Username: 64.26.60.150/31
Authentication-Results: mfg.siteprotect.com; auth=pass smtp.auth=64.26.60.150/31@mfg.outbound
X-portal.siteprotect.com-Outgoing-Class: ham
X-portal.siteprotect.com-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5vOuj42349fjsCzUJrWh+JV602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO80kiOOXohirsWhwY064v2npeso7Ho1FT6opA0QnLMBdpVMzexAGJZ2+mPn7fP4I3bGQ
 T8H3NmQhNu2O3z+K3mZwnXeuRadH9eS/0qlAQIeNVTCxY3GOeQ66b90JBslLPIYZZS/DUBLA5nGN
 6cIn1z9sSeI2joq9+ZZE6ghVOZbTTcd1LQTPB4kZ4onMihMMZ7yZgsqocyZY4jxjE3qUu/6r1AV5
 UTHwbtCAXgD9KinxOsXa9bPF5P+TU1Hkgqx+i85wXGAwCBBM9Wuz7xpUTUsouBFVfnbvOnQHVZOr
 UVdzPmpotkU9W6DwXKJZEzKGAWFx656NU5IkTRH0Up7qB8Lzno4t3kssqrr3QsvSu8BVGE1lcStX
 Kcni7YkebcsPef+Bu4/uGdQrw1B0vCxVYoig1tMG8QVeXDZzT/jhEuU0mDZaYzQnZ01Yuj9k2p8z
 ZQS8oWDbSKQ3tXcknJwLqWmW2UPE+vsQVOjHQoB8kKI5VBlSQp3tVGVu81giwHSvsh/iSK71nlwT
 kZ/FUjBxvQvLVJD2VTUQ+kGxg2Pv3GfZNme3cik5CexJz1ox3HYe0QjaC0seZkfC0iy+spcexjk7
 SHzg1GyOaFo+K3vVD2LSW+n8Hj6CJNEWfIqe3AMrex08L8pZyQFEYMQabfOl4IqgLgoO+53/F59y
 H4idlSUpteH5C3/pSoxYOXdzgcqBafjL6IM/NPtmtMb38N+gNB/lgTl6fJxyntEfhZCKje4ZwyYO
 nmpuMeHRjSmbB6RrUkSyszVtUeslVn8uY5bzuQsgr/U0flMcy2Vi/IcBgY4amwfEOQVUNYnWQ300
 Dp6cJDE37L8A/sfCSfmp70N6CAkwoGPe+nvh19VPEW3k7miLRGgHloEW8jEP1L/Rx27Xz2ze7YS9
 31MmOCeh9kCpbzF+Ok8PhSKp+hqEBIgRN/xOGisIGxUJr7hu9AMHjQD/EXDMIS0tLJXIAOtcIzBo
 I6meQp3k9SVx0LF1z2PwQHAv6PNCU/yT9rVFGLmNNL3pin9QfQfyieJWOKWrOSedp3vvZ+cXa4SP
 MMsvIvQ05tn8jrZXLGyv7MvlzLexb6aw2cRuWfncyDI2igUAoM6ZzRGyfJobVz7fY0YurTrklOi8
 ZuM7jUXIESohoO51xWmU8XetsAn+dGLdW9wFnbfnLqlCsHZa6ansnqA1PsylvLlEhieaPV2+qeEY
 bMldDm0nFGt17RWWL3HibWMuPdCMisXylIuYEMGLGYbBbBR3JTh3+HGJA0RGaAhm/MWtyZJn3DMa
 IL48SHdwBur7C9FrSAVwMG9k36g/7bjS2E6qjwtRGvsY2hs/S+9Z3xB10KGOcqjxugQ/FndyXRUg
 v2aA0ZQ=
X-Report-Abuse-To: spam@semfq01.mfg.siteprotect.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019, Cyrill Gorcunov wrote:

> > Shame on Intel though for not providing perf JSON files for the 
> > Pentium 4 event names.
> 
> Mind to point me where json events should lay, I could try to convert
> names.

I was mostly joking about that.  But the event lists are in the kernel 
tree in
	tools/perf/pmu-events/arch/x86/
I don't think anything older than Nehalem is included.

After letting the fuzzer run a bit longer I did manage to get it 
to hard-lock with no messages in the log, though eventually while I was 
fiddling with alt-sysrq over serial port did get this to trigger.
Though if I'm going to start reporting p4 crashes I should start a 
separate thread.

[ 2352.198361] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [perf_fuzzer:27005]
[ 2352.257304] CPU: 1 PID: 27005 Comm: perf_fuzzer Tainted: G        W         5.1.0-rc3+ #6
[ 2352.265458] Hardware name: LENOVO 88088NU/LENOVO, BIOS 2JKT37AUS 07/12/2007
[ 2352.272407] RIP: 0010:smp_call_function_single+0xc9/0xf0
[ 2352.277700] Code: 8b 4c 24 38 65 48 33 0c 25 28 00 00 00 75 34 c9 c3 48 89 d1 48 89 f2 48 89 e6 e8 a2 fe ff ff 8b 54 24 18 83 e2 01 74 0b f3 90 <8b> 54 24 18 83 e2 01 75 f5 eb ca 8b 05 06 c4 45 01 85 c0 75 88 0f
[ 2352.296415] RSP: 0018:ffffc90004d0fb80 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
[ 2352.303961] RAX: 0000000000000000 RBX: ffff888039962500 RCX: ffff88803e520d80
[ 2352.311071] RDX: 0000000000000001 RSI: ffffc90004d0fb80 RDI: ffffc90004d0fb80
[ 2352.318180] RBP: ffffc90004d0fbc0 R08: 0000000000000000 R09: 0000000000000000
[ 2352.325291] R10: ffff888036cc8010 R11: ffff888039978e98 R12: ffffffff8115ec70
[ 2352.332412] R13: 0000000000000001 R14: ffff88803aa15108 R15: ffff88803d5fdb70
[ 2352.339524] FS:  0000000000000000(0000) GS:ffff88803e500000(0000) knlGS:0000000000000000
[ 2352.347587] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2352.353313] CR2: 00007f9d2e56d3b4 CR3: 000000000200e000 CR4: 00000000000006e0
[ 2352.360428] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2352.367540] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[ 2352.374649] Call Trace:
[ 2352.377104]  ? perf_cgroup_attach+0x70/0x70
[ 2352.381276]  ? slab_destroy+0xa5/0x120
[ 2352.385016]  ? perf_cgroup_attach+0x70/0x70
[ 2352.389186]  task_function_call+0x49/0x80
[ 2352.393186]  ? bpf_jit_compile+0x30/0x30
[ 2352.397095]  event_function_call+0x85/0x100
[ 2352.401265]  ? perf_swevent_hrtimer+0x150/0x150
[ 2352.405781]  perf_remove_from_context+0x20/0x60
[ 2352.410295]  perf_event_release_kernel+0x75/0x2e0
[ 2352.414983]  perf_release+0xc/0x10
[ 2352.418373]  __fput+0xaf/0x1f0
[ 2352.421425]  task_work_run+0x7e/0xa0
[ 2352.424990]  do_exit+0x2c6/0xb40
[ 2352.428213]  ? event_function_local.constprop.132+0xe0/0xe0
[ 2352.433767]  ? visit_groups_merge+0xcd/0x180
[ 2352.438027]  do_group_exit+0x3a/0xa0
[ 2352.441598]  get_signal+0x123/0x6c0
[ 2352.445080]  ? __perf_event_task_sched_in+0xed/0x1a0
[ 2352.450030]  do_signal+0x30/0x6a0
[ 2352.453334]  ? finish_task_switch+0x10a/0x290
[ 2352.457685]  ? __schedule+0x207/0x800
[ 2352.461336]  exit_to_usermode_loop+0x5d/0xc0
[ 2352.465593]  prepare_exit_to_usermode+0x53/0x80
[ 2352.470110]  retint_user+0x8/0x8

