Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3779FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 01:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010C520CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 01:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfLQBrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 20:47:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:31362 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfLQBrF (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 20:47:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 17:47:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; 
   d="scan'208";a="365217929"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.81]) ([10.239.196.81])
  by orsmga004.jf.intel.com with ESMTP; 16 Dec 2019 17:47:02 -0800
Subject: Re: [PATCH v3 1/3] perf report: Change sort order by a specified
 event in group
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20191212123337.23600-1-yao.jin@linux.intel.com>
 <20191216073113.GB18240@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <fcedac74-7fb4-1c3b-67a3-9af24c256f40@linux.intel.com>
Date:   Tue, 17 Dec 2019 09:47:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191216073113.GB18240@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/2019 3:31 PM, Jiri Olsa wrote:
> On Thu, Dec 12, 2019 at 08:33:35PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/Documentation/perf-report.txt |   4 +
>>   tools/perf/builtin-report.c              |  10 +++
>>   tools/perf/ui/hist.c                     | 108 +++++++++++++++++++----
>>   tools/perf/util/symbol_conf.h            |   1 +
>>   4 files changed, 108 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
>> index 8dbe2119686a..9ade613ef020 100644
>> --- a/tools/perf/Documentation/perf-report.txt
>> +++ b/tools/perf/Documentation/perf-report.txt
>> @@ -371,6 +371,10 @@ OPTIONS
>>   	Show event group information together. It forces group output also
>>   	if there are no groups defined in data file.
>>   
>> +--group-sort-idx::
>> +	Sort the output by the event at the index n in group. If n is invalid,
>> +	sort by the first event. WARNING: This should be used with --group.
> 
> --group in record or report?
> 

This --group is in perf-report. So even if it's not created with -e '{}' 
in perf-record, it still supports to show event information together.

> you can also create groups with -e '{}', not just --group option
> 
> I wonder you could check early on 'evlist->nr_groups' and fail
> if there's no group defined if the option is enabled
> 

Maybe we don't need to check that because it supports the case of no 
group defined.

For example,
perf record -e cycles,instructions
perf report --group --group-sort-idx 1 --stdio

#         Overhead  Command  Shared Object      Symbol
# ................  .......  ................. 
.............................
#
      0.00%  39.68%  swapper  [kernel.kallsyms]  [k] file_free_rcu
      0.00%  31.85%  swapper  [kernel.kallsyms]  [k] ___perf_sw_event
      3.96%   4.68%  swapper  [kernel.kallsyms]  [k] 
tick_nohz_idle_stop_tick
      0.00%   4.49%  perf     [kernel.kallsyms]  [k] update_load_avg
      0.00%   4.49%  swapper  [kernel.kallsyms]  [k] tcp_ack
      4.06%   3.75%  swapper  [kernel.kallsyms]  [k] update_rt_rq_load_avg
      3.54%   3.71%  swapper  [kernel.kallsyms]  [k] update_blocked_averages
      1.88%   2.06%  swapper  [kernel.kallsyms]  [k] load_balance

The output is sorted by the second event.

> also what happens when we have more groups?
>

Let me take an example.

perf record -e '{cycles,instructions}' -e '{branches,cache-misses}' -a

perf report --group  --group-sort-idx 1 --stdio

# Samples: 116  of events 'anon group { cycles, instructions }'
# Event count (approx.): 17552917
#
#         Overhead  Command          Shared Object      Symbol
# ................  ...............  ................. 
...............................
#
      0.00%  13.81%  perf             [kernel.kallsyms]  [k] number
      0.00%  12.50%  swapper          [kernel.kallsyms]  [k] cpuidle_select
      0.00%  12.02%  sleep            [kernel.kallsyms]  [k] 
filemap_map_pages
      0.00%  11.40%  perf             [kernel.kallsyms]  [k] rcu_all_qs
      0.00%  11.30%  perf             [kernel.kallsyms]  [k] alloc_set_pte
      0.00%  10.54%  swapper          [kernel.kallsyms]  [k] 
timekeeping_advance
      0.00%   9.89%  kworker/5:2-mm_  [kernel.kallsyms]  [k] 
update_rt_rq_load_avg
      0.00%   7.86%  rcu_sched        [kernel.kallsyms]  [k] 
finish_task_switch
......

# Samples: 100  of events 'anon group { branches, cache-misses }'
# Event count (approx.): 1214391
#
#         Overhead  Command          Shared Object            Symbol
# ................  ...............  ....................... 
...............................
#
      0.00%  23.13%  perf             [kernel.kallsyms]        [k] 
ext4_dirty_inode
      0.00%  18.66%  sleep            [kernel.kallsyms]        [k] 
free_pipe_info
      0.00%  10.74%  perf             [kernel.kallsyms]        [k] 
unmap_page_range
      0.00%   9.35%  sleep            [kernel.kallsyms]        [k] 
__wake_up_common_lock
      0.00%   7.71%  wpa_supplicant   libc-2.27.so             [.] 
cfree@GLIBC_2.2.5
      0.00%   6.55%  thermald         libglib-2.0.so.0.5600.4  [.] 
g_mutex_lock
      0.00%   3.43%  perf             [kernel.kallsyms]        [k] 
_raw_spin_lock
      0.00%   3.12%  migration/0      [kernel.kallsyms]        [k] 
kthread_should_stop
      0.00%   2.87%  migration/1      [kernel.kallsyms]        [k] 
__bitmap_and
      0.00%   2.37%  migration/3      [kernel.kallsyms]        [k] 
update_rt_rq_load_avg
      0.00%   2.01%  perf             [kernel.kallsyms]        [k] 
security_inode_permission
      0.00%   1.91%  migration/5      [kernel.kallsyms]        [k] 
update_sd_lb_stats
      0.00%   1.86%  perf             [kernel.kallsyms]        [k] 
__alloc_file
      0.00%   1.83%  swapper          [kernel.kallsyms]        [k] 
intel_idle
      0.00%   1.49%  migration/2      [kernel.kallsyms]        [k] 
__switch_to_asm
      0.00%   1.41%  migration/6      [kernel.kallsyms]        [k] 
__bitmap_and
......

The outputs are sorted by the second event.

Let me take one more example of multiple groups with different amount of 
events.

perf record -e '{cycles,instructions}' -e 
'{branches,cache-misses,cache-references}' -a

perf report --group --group-sort-idx 2 --stdio

# Samples: 135  of events 'anon group { cycles, instructions }'
# Event count (approx.): 20558030
#
#         Overhead  Command          Shared Object             Symbol
# ................  ...............  ........................ 
...................................
#
     21.52%   0.00%  perf             [kernel.kallsyms]         [k] 
anon_vma_interval_tree_remove
     10.63%   0.00%  perf             [kernel.kallsyms]         [k] strncpy
      9.61%   0.00%  migration/5      [kernel.kallsyms]         [k] 
put_prev_task_stop
      8.64%   0.00%  migration/3      [kernel.kallsyms]         [k] 
update_blocked_averages
      6.53%   0.00%  migration/2      [kernel.kallsyms]         [k] 
update_sd_lb_stats
      5.41%   0.00%  migration/0      [kernel.kallsyms]         [k] rb_erase
      5.32%   0.00%  migration/4      [kernel.kallsyms]         [k] 
reweight_entity
      4.90%   0.00%  swapper          [kernel.kallsyms]         [k] 
e1000_clean_rx_irq
      4.35%   0.00%  migration/1      [kernel.kallsyms]         [k] schedule
      3.94%   0.00%  migration/6      [kernel.kallsyms]         [k] 
propagate_entity_cfs_rq.isra.97
......

The output for group '{cycles, instructions}' is sorted by default 
(first event) since the group-sort-idx (2) is invalid.

# Samples: 187  of events 'anon group { branches, cache-misses, 
cache-references }'
# Event count (approx.): 2428023
#
#                 Overhead  Command          Shared Object 
Symbol
# ........................  ...............  ........................ 
.........................................
#
      0.00%   0.00%  21.54%  perf             [kernel.kallsyms] 
[k] up_write
      0.00%   0.00%  10.01%  swapper          [kernel.kallsyms] 
[k] note_gp_changes
      0.00%   0.00%   9.51%  kworker/u16:1-e  [kernel.kallsyms] 
[k] finish_task_switch
      0.00%  12.48%   8.06%  swapper          [kernel.kallsyms] 
[k] intel_idle
      0.00%   0.00%   4.08%  perf             [kernel.kallsyms] 
[k] kmem_cache_alloc
      0.00%   0.00%   3.83%  migration/3      [kernel.kallsyms] 
[k] update_blocked_averages
      0.00%   0.00%   3.58%  migration/5      [kernel.kallsyms] 
[k] pick_next_task_rt
      0.00%   0.00%   3.46%  swapper          [kernel.kallsyms] 
[k] rcu_dynticks_eqs_exit
      0.00%   0.00%   3.22%  swapper          [kernel.kallsyms] 
[k] calc_global_load
      0.00%   0.00%   3.13%  swapper          [kernel.kallsyms] 
[k] cpuidle_not_available
......

The output for group '{branches, cache-misses, cache-references}' is 
sorted by the third event. It's expected.

> I think the option is easy to use as it is, just needs to be explained
> consequences for more groups with different amount of events
> 

Thanks. Can we say something as following?

--group-sort-idx::
	Sort the output by the event at the index n in group. If n is invalid, 
sort by the first event. It can support multiple groups with different 
amount of events. WARNING: This should be used with perf report --group.

> SNIP
> 
>> +
>> +static int __hpp__group_sort_idx(struct hist_entry *a, struct hist_entry *b,
>> +				 hpp_field_fn get_field, int idx)
>> +{
>> +	struct evsel *evsel = hists_to_evsel(a->hists);
>> +	u64 *fields_a, *fields_b;
>> +	int cmp, nr_members, ret, i;
>> +
>> +	cmp = field_cmp(get_field(a), get_field(b));
>> +	if (!perf_evsel__is_group_event(evsel))
>> +		return cmp;
>> +
>> +	nr_members = evsel->core.nr_members;
>> +	ret = pair_fields_alloc(a, b, get_field, nr_members,
>> +				&fields_a, &fields_b);
>> +	if (ret) {
>> +		ret = cmp;
>> +		goto out;
>> +	}
>> +
>> +	if (idx >= 1 && idx < nr_members) {
> 
> do we need to continue here if idx is out of the limit?
> I'm not sure but mybe in that case the comparison above
> should be enough?
> 

Yes, we can use simpler code. Something like,

+       cmp = field_cmp(get_field(a), get_field(b));
+       if (!perf_evsel__is_group_event(evsel))
+               return cmp;
+
+       nr_members = evsel->core.nr_members;
+       if (idx < 1 || idx >= nr_members)
+               return cmp;
         ......

Thanks
Jin Yao

> thanks,
> jirka
> 
