Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0762FC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 03:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E8F24679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 03:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfLPDUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 22:20:17 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7247 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726437AbfLPDUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 22:20:16 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 430BFED8CCFF8D82AE3E;
        Mon, 16 Dec 2019 11:20:14 +0800 (CST)
Received: from [127.0.0.1] (10.133.215.182) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 16 Dec 2019
 11:20:07 +0800
Subject: Re: [RFC v3 5/5] perf tools: Add support to process multi spe events
To:     James Clark <James.Clark@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "yao.jin@linux.intel.com" <yao.jin@linux.intel.com>,
        "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>,
        "brueckner@linux.ibm.com" <brueckner@linux.ibm.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Kim Phillips <Kim.Phillips@arm.com>,
        "Jeremy Linton" <Jeremy.Linton@arm.com>
CC:     "gengdongjiu@huawei.com" <gengdongjiu@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "liwei391@huawei.com" <liwei391@huawei.com>,
        "huawei.libin@huawei.com" <huawei.libin@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        nd <nd@arm.com>
References: <20191123101118.12635-1-tanxiaojun@huawei.com>
 <20191123101118.12635-6-tanxiaojun@huawei.com>
 <2f2db9d2-e468-b327-34e6-1412a40cb5c9@arm.com>
 <1a29399e-4c24-1a55-fa44-9f8b7b46308c@huawei.com>
 <6d059ea1-5051-5d1c-36f0-ef6444688f2c@arm.com>
 <896ba5d6-5a40-5882-5c2b-999974dd5baf@huawei.com>
 <35e583fc-d5ab-fafd-2ce7-b43dd7a3e7fd@arm.com>
From:   Tan Xiaojun <tanxiaojun@huawei.com>
Message-ID: <7e89ed35-4300-6693-1210-d5eab409cc79@huawei.com>
Date:   Mon, 16 Dec 2019 11:20:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <35e583fc-d5ab-fafd-2ce7-b43dd7a3e7fd@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.215.182]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/12 23:50, James Clark wrote:
> 
> Hi Xiaojun,
> 
>> It may be that you did not recompile the kernel. In order to support this method, I modified the spe driver, which requires recompiling the kernel to support it.
> 
> Ah yes sorry I missed that there were kernel changes. I'm currently trying to understand what additional behavior is. The way I understand it, is that it is that it's already
> possible to configure the filtering like this: ./perf record -e arm_spe/ts_enable=1,branch_filter=1/ ls. So the new synthetic SPE events aren't strictly necessary.
> 
> I think it would be best to avoid kernel changes because the SPE driver has been in the kernel for quite some time now. And relying on a new version in perf will
> make it more difficult for people to access this feature easily.
> 
> Do you think it will be possible to get all the functionality with the existing driver? I think RFC v2 was working quite well, apart from the multiple events issue.
> But maybe that is not that important of a use case. And it would be better to get a basic version accepted sooner.
> 

OK, I will modify and send a new version as soon as possible.

Thanks.
Xiaojun.

> 
> Regards
> James
> 
>>>
>>> Thanks
>>> James
>>>
>>> On 30/11/2019 00:42, Tan Xiaojun wrote:
>>>> On 2019/11/30 0:32, James Clark wrote:
>>>>> Hi Xiaojun,
>>>>>
>>>>> Sorry for not replying earlier, I was at a conference. Unfortunately I have temporarily lost access to SPE enabled hardware but I will test this out and get back to you as soon as possible.
>>>>>
>>>>>
>>>>> Thanks
>>>>> James
>>>>>
>>>>
>>>> OK.
>>>>
>>>> Thanks.
>>>> Xiaojun.
>>>>
>>>>> On 23/11/2019 10:11, Tan Xiaojun wrote:
>>>>>> Under the original logic, if the user specifies multiple spe
>>>>>> events during the record, perf will report an error and exit
>>>>>> without actually running. This is not very friendly.
>>>>>>
>>>>>> This patch slightly modifies this logic, in which case a
>>>>>> warning is reported and the first spe event is taken as a
>>>>>> record.
>>>>>>
>>>>>> At the same time, this patch also supports the recording of
>>>>>> multi new synthetic events. However, if the user specifies the
>>>>>> spe event and then specifies the synthetic spe events, a warning
>>>>>> will be reported and the above principles will still be followed,
>>>>>> only the first spe event will be recorded.
>>>>>>
>>>>>> Example:
>>>>>> ------------------------------------------------------------------
>>>>>> 1) For multiple spe events
>>>>>> $ perf record -e arm_spe_0/ts_enable=0,load_filter=1,jitter=1,min_latency=0/ -e arm_spe_0/ts_enable=0,store_filter=1,jitter=1,min_latency=0/ ls
>>>>>> Warning:
>>>>>> There may be only one arm_spe_x event. More than one spe event will be ignored, unless they are synthetic events of spe, like:
>>>>>> arm_spe_x/llc_miss/
>>>>>> arm_spe_x/branch_miss/
>>>>>> arm_spe_x/tlb_miss/
>>>>>> arm_spe_x/remote_access/
>>>>>> (see 'perf list')
>>>>>> ...
>>>>>> [ perf record: Woken up 1 times to write data ]
>>>>>> [ perf record: Captured and wrote 0.078 MB perf.data ]
>>>>>>
>>>>>> $ perf report --stdio
>>>>>> ...
>>>>>>  # Samples: 0  of event 'arm_spe_0/ts_enable=0,load_filter=1,jitter=1,min_latency=0/'
>>>>>> ...
>>>>>>
>>>>>> 2) For multiple spe precise ip events (synthetic event)
>>>>>> $ perf record -e arm_spe_0/llc_miss/ -e arm_spe_0/llc_miss/ -e arm_spe_0/tlb_miss/ ls
>>>>>> Warning:
>>>>>> These events are precise ip events, please add :p/pp/ppp after the event.
>>>>>> ...
>>>>>> [ perf record: Woken up 1 times to write data ]
>>>>>> [ perf record: Captured and wrote 0.343 MB perf.data ]
>>>>>>
>>>>>> $ perf report --stdio
>>>>>>  # To display the perf.data header info, please use --header/--header-only options.
>>>>>>  #
>>>>>>  #
>>>>>>  # Total Lost Samples: 0
>>>>>>  #
>>>>>>  # Samples: 0  of event 'arm_spe_0/llc_miss/, arm_spe_0/tlb_miss/'
>>>>>>  # Event count (approx.): 0
>>>>>>  #
>>>>>>  # Children      Self  Command  Shared Object  Symbol
>>>>>>  # ........  ........  .......  .............  ......
>>>>>>  #
>>>>>>
>>>>>>  # Samples: 0  of event 'dummy:u'
>>>>>>  # Event count (approx.): 0
>>>>>>  #
>>>>>>  # Children      Self  Command  Shared Object  Symbol
>>>>>>  # ........  ........  .......  .............  ......
>>>>>>  #
>>>>>>
>>>>>>  # Samples: 83  of event 'llc-miss'
>>>>>>  # Event count (approx.): 83
>>>>>>  #
>>>>>>  # Children      Self  Command  Shared Object      Symbol
>>>>>>  # ........  ........  .......  .................  ....................................
>>>>>>  #
>>>>>>      42.17%    42.17%  ls       [kernel.kallsyms]  [k] perf_iterate_ctx.constprop.64
>>>>>>      14.46%    14.46%  ls       [kernel.kallsyms]  [k] memchr_inv
>>>>>>      13.25%    13.25%  ls       [kernel.kallsyms]  [k] perf_event_mmap
>>>>>>       2.41%     2.41%  ls       [kernel.kallsyms]  [k] available_idle_cpu
>>>>>>       2.41%     2.41%  ls       [kernel.kallsyms]  [k] copy_page
>>>>>>       2.41%     2.41%  ls       [kernel.kallsyms]  [k] try_to_wake_up
>>>>>>       2.41%     2.41%  ls       [kernel.kallsyms]  [k] vma_interval_tree_insert
>>>>>>       2.41%     2.41%  ls       ld-2.28.so         [.] _dl_lookup_symbol_x
>>>>>>       2.41%     2.41%  ls       ld-2.28.so         [.] _dl_relocate_object
>>>>>>       1.20%     1.20%  ls       [kernel.kallsyms]  [k] ext4_getattr
>>>>>>       1.20%     1.20%  ls       [kernel.kallsyms]  [k] get_page_from_freelist
>>>>>>       1.20%     1.20%  ls       [kernel.kallsyms]  [k] get_partial_node.isra.25
>>>>>>       1.20%     1.20%  ls       [kernel.kallsyms]  [k] lock_page_memcg
>>>>>>       1.20%     1.20%  ls       [kernel.kallsyms]  [k] may_open
>>>>>>       1.20%     1.20%  ls       [kernel.kallsyms]  [k] radix_tree_next_chunk
>>>>>>       1.20%     1.20%  ls       [kernel.kallsyms]  [k] rb_prev
>>>>>>       1.20%     1.20%  ls       ld-2.28.so         [.] _dl_map_object_from_fd
>>>>>>       1.20%     1.20%  ls       ld-2.28.so         [.] _dl_start
>>>>>>       1.20%     1.20%  ls       ld-2.28.so         [.] do_lookup_x
>>>>>>       1.20%     1.20%  ls       ld-2.28.so         [.] rtld_lock_default_lock_recursive
>>>>>>       1.20%     1.20%  ls       libc-2.28.so       [.] getenv
>>>>>>       1.20%     1.20%  ls       [unknown]          [.] 0xffff29f1190029b8
>>>>>>
>>>>>>  # Samples: 13  of event 'tlb-miss'
>>>>>>  # Event count (approx.): 13
>>>>>>  #
>>>>>>  # Children      Self  Command  Shared Object      Symbol
>>>>>>  # ........  ........  .......  .................  ............................
>>>>>>  #
>>>>>>      15.38%    15.38%  ls       [kernel.kallsyms]  [k] __audit_syscall_entry
>>>>>>      15.38%    15.38%  ls       [kernel.kallsyms]  [k] get_partial_node.isra.25
>>>>>>      15.38%    15.38%  ls       ld-2.28.so         [.] _dl_relocate_object
>>>>>>      15.38%    15.38%  ls       ld-2.28.so         [.] do_lookup_x
>>>>>>       7.69%     7.69%  ls       [kernel.kallsyms]  [k] memchr_inv
>>>>>>       7.69%     7.69%  ls       ld-2.28.so         [.] _dl_map_object_from_fd
>>>>>>       7.69%     7.69%  ls       ld-2.28.so         [.] _dl_setup_hash
>>>>>>       7.69%     7.69%  ls       ld-2.28.so         [.] _dl_start
>>>>>>       7.69%     7.69%  ls       ls                 [.] 0x00000000000097a0
>>>>>>
>>>>>> ------------------------------------------------------------------
>>>>>>
>>>>>> Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
>>>>>> ---
>>>>>>  tools/perf/arch/arm64/util/arm-spe.c | 47 +++++++++++++++++++++++++---
>>>>>>  tools/perf/util/arm-spe.c            | 25 +++++++++++++++
>>>>>>  tools/perf/util/arm-spe.h            | 20 ++++++++++++
>>>>>>  3 files changed, 88 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
>>>>>> index eba6541ec0f1..68e91f3c9614 100644
>>>>>> --- a/tools/perf/arch/arm64/util/arm-spe.c
>>>>>> +++ b/tools/perf/arch/arm64/util/arm-spe.c
>>>>>> @@ -67,21 +67,60 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
>>>>>>       struct arm_spe_recording *sper =
>>>>>>                       container_of(itr, struct arm_spe_recording, itr);
>>>>>>       struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
>>>>>> -     struct evsel *evsel, *arm_spe_evsel = NULL;
>>>>>> +     struct evsel *evsel, *tmp, *arm_spe_evsel = NULL;
>>>>>>       bool privileged = perf_event_paranoid_check(-1);
>>>>>>       struct evsel *tracking_evsel;
>>>>>> +     char evsel_name[128];
>>>>>>       int err;
>>>>>>
>>>>>>       sper->evlist = evlist;
>>>>>>
>>>>>> -     evlist__for_each_entry(evlist, evsel) {
>>>>>> +     evlist__for_each_entry_safe(evlist, tmp, evsel) {
>>>>>>               if (evsel->core.attr.type == arm_spe_pmu->type) {
>>>>>>                       if (arm_spe_evsel) {
>>>>>> -                             pr_err("There may be only one " ARM_SPE_PMU_NAME "x event\n");
>>>>>> -                             return -EINVAL;
>>>>>> +                             if ((evsel->core.attr.config
>>>>>> +                                             & GENMASK_ULL(ARM_SPE_EVENT_HI,
>>>>>> +                                                     ARM_SPE_EVENT_LO))
>>>>>> +                                             && (arm_spe_evsel->core.attr.config
>>>>>> +                                             & GENMASK_ULL(ARM_SPE_EVENT_HI,
>>>>>> +                                                     ARM_SPE_EVENT_LO))) {
>>>>>> +                                     arm_spe_evsel->core.attr.config |=
>>>>>> +                                                             evsel->core.attr.config;
>>>>>> +
>>>>>> +                                     if (!strstr(arm_spe_evsel->name, evsel->name)) {
>>>>>> +                                             scnprintf(evsel_name, sizeof(evsel_name),
>>>>>> +                                                             "%s, %s", arm_spe_evsel->name,
>>>>>> +                                                             evsel->name);
>>>>>> +                                             arm_spe_evsel->name = strdup(evsel_name);
>>>>>> +                                     }
>>>>>> +                             } else
>>>>>> +                                     pr_warning("Warning:\n"
>>>>>> +                                             "There may be only one "
>>>>>> +                                             ARM_SPE_PMU_NAME "x event."
>>>>>> +                                             " More than one spe event"
>>>>>> +                                             " will be ignored, unless"
>>>>>> +                                             " they are synthetic events"
>>>>>> +                                             " of spe, like:"
>>>>>> +                                             "\narm_spe_x/llc_miss/"
>>>>>> +                                             "\narm_spe_x/branch_miss/"
>>>>>> +                                             "\narm_spe_x/tlb_miss/"
>>>>>> +                                             "\narm_spe_x/remote_access/"
>>>>>> +                                             "\n(see 'perf list')\n");
>>>>>> +                             evlist__remove(evlist, evsel);
>>>>>> +                             evsel__delete(evsel);
>>>>>> +                             continue;
>>>>>>                       }
>>>>>>                       evsel->core.attr.freq = 0;
>>>>>>                       evsel->core.attr.sample_period = 1;
>>>>>> +                     if (evsel->core.attr.config
>>>>>> +                                     & GENMASK_ULL(ARM_SPE_EVENT_HI, ARM_SPE_EVENT_LO)) {
>>>>>> +                             evsel->core.attr.config |= SPE_ATTR_TS_ENABLE;
>>>>>> +                             if (!evsel->core.attr.precise_ip)
>>>>>> +                                     pr_warning("Warning:\n"
>>>>>> +                                             "These events are precise ip events,"
>>>>>> +                                             " please add :p/pp/ppp after the event.\n");
>>>>>> +                     }
>>>>>> +
>>>>>>                       arm_spe_evsel = evsel;
>>>>>>                       opts->full_auxtrace = true;
>>>>>>               }
>>>>>> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
>>>>>> index e7282c2616f3..0c9d7fa518a5 100644
>>>>>> --- a/tools/perf/util/arm-spe.c
>>>>>> +++ b/tools/perf/util/arm-spe.c
>>>>>> @@ -779,6 +779,31 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>>>>>>       attr.sample_id_all = evsel->core.attr.sample_id_all;
>>>>>>       attr.read_format = evsel->core.attr.read_format;
>>>>>>
>>>>>> +     if (evsel->core.attr.config
>>>>>> +                     & GENMASK_ULL(ARM_SPE_EVENT_HI,
>>>>>> +                             ARM_SPE_EVENT_LO)) {
>>>>>> +             spe->synth_opts.llc_miss = false;
>>>>>> +             spe->synth_opts.tlb_miss = false;
>>>>>> +             spe->synth_opts.branch_miss = false;
>>>>>> +             spe->synth_opts.remote_access = false;
>>>>>> +
>>>>>> +             if (evsel->core.attr.config
>>>>>> +                             & (ARM_SPE_EVENT_LLC_MISS << ARM_SPE_EVENT_LO))
>>>>>> +                     spe->synth_opts.llc_miss = true;
>>>>>> +
>>>>>> +             if (evsel->core.attr.config
>>>>>> +                             & (ARM_SPE_EVENT_TLB_MISS << ARM_SPE_EVENT_LO))
>>>>>> +                     spe->synth_opts.tlb_miss = true;
>>>>>> +
>>>>>> +             if (evsel->core.attr.config
>>>>>> +                             & (ARM_SPE_EVENT_BRANCH_MISS << ARM_SPE_EVENT_LO))
>>>>>> +                     spe->synth_opts.branch_miss = true;
>>>>>> +
>>>>>> +             if (evsel->core.attr.config
>>>>>> +                             & (ARM_SPE_EVENT_REMOTE_ACCESS << ARM_SPE_EVENT_LO))
>>>>>> +                     spe->synth_opts.remote_access = true;
>>>>>> +     }
>>>>>> +
>>>>>>       /* create new id val to be a fixed offset from evsel id */
>>>>>>       id = evsel->core.id[0] + 1000000000;
>>>>>>
>>>>>> diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
>>>>>> index 98d3235781c3..db7420121979 100644
>>>>>> --- a/tools/perf/util/arm-spe.h
>>>>>> +++ b/tools/perf/util/arm-spe.h
>>>>>> @@ -9,6 +9,26 @@
>>>>>>
>>>>>>  #define ARM_SPE_PMU_NAME "arm_spe_"
>>>>>>
>>>>>> +#define ARM_SPE_EVENT_LO                     3
>>>>>> +#define ARM_SPE_EVENT_HI                     6
>>>>>> +#define ARM_SPE_EVENT_LLC_MISS                       BIT(0)
>>>>>> +#define ARM_SPE_EVENT_BRANCH_MISS            BIT(1)
>>>>>> +#define ARM_SPE_EVENT_TLB_MISS                       BIT(2)
>>>>>> +#define ARM_SPE_EVENT_REMOTE_ACCESS          BIT(3)
>>>>>> +
>>>>>> +#define SPE_ATTR_TS_ENABLE                   BIT(0)
>>>>>> +#define SPE_ATTR_PA_ENABLE                   BIT(1)
>>>>>> +#define SPE_ATTR_PCT_ENABLE                  BIT(2)
>>>>>> +#define SPE_ATTR_JITTER                              BIT(16)
>>>>>> +#define SPE_ATTR_BRANCH_FILTER                       BIT(32)
>>>>>> +#define SPE_ATTR_LOAD_FILTER                 BIT(33)
>>>>>> +#define SPE_ATTR_STORE_FILTER                        BIT(34)
>>>>>> +
>>>>>> +#define SPE_ATTR_EV_RETIRED                  BIT(1)
>>>>>> +#define SPE_ATTR_EV_CACHE                    BIT(3)
>>>>>> +#define SPE_ATTR_EV_TLB                              BIT(5)
>>>>>> +#define SPE_ATTR_EV_BRANCH                   BIT(7)
>>>>>> +
>>>>>>  enum {
>>>>>>       ARM_SPE_PMU_TYPE,
>>>>>>       ARM_SPE_PER_CPU_MMAPS,
>>>>>>
>>>>> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
>>>>>
>>>>
>>>>
>>
>>


