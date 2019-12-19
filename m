Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F12CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 05:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0542146E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 05:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfLSFKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 00:10:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:34166 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfLSFKf (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 00:10:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 21:10:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="222176614"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.69]) ([10.239.196.69])
  by fmsmga001.fm.intel.com with ESMTP; 18 Dec 2019 21:10:33 -0800
Subject: Re: [PATCH v4 3/3] perf report: support hotkey to let user select any
 event for sorting
From:   "Jin, Yao" <yao.jin@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20191218022443.18958-1-yao.jin@linux.intel.com>
 <20191218022443.18958-3-yao.jin@linux.intel.com>
 <20191218074708.GC19062@krava>
 <879a7e9e-f7e0-29c9-d10a-a3d2732e6c2f@linux.intel.com>
Message-ID: <7d7a722a-9e8c-3245-48a2-5944df19c927@linux.intel.com>
Date:   Thu, 19 Dec 2019 13:10:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <879a7e9e-f7e0-29c9-d10a-a3d2732e6c2f@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/19/2019 9:14 AM, Jin, Yao wrote:
> 
> 
> On 12/18/2019 3:47 PM, Jiri Olsa wrote:
>> On Wed, Dec 18, 2019 at 10:24:43AM +0800, Jin Yao wrote:
>>> When performing "perf report --group", it shows the event group 
>>> information
>>> together. In previous patch, we have supported a new option 
>>> "--group-sort-idx"
>>> to sort the output by the event at the index n in event group.
>>>
>>> It would be nice if we can use a hotkey in browser to select a event
>>> to sort.
>>>
>>> For example,
>>>
>>>    # perf report --group
>>>
>>>   Samples: 12K of events 'cpu/instructions,period=2000003/, 
>>> cpu/cpu-cycles,period=200003/, ...
>>>                          Overhead  Command    Shared 
>>> Object            Symbol
>>>    92.19%  98.68%   0.00%  93.30%  mgen       
>>> mgen                     [.] LOOP1
>>>     3.12%   0.29%   0.00%   0.16%  gsd-color  
>>> libglib-2.0.so.0.5600.4  [.] 0x0000000000049515
>>>     1.56%   0.03%   0.00%   0.04%  gsd-color  
>>> libglib-2.0.so.0.5600.4  [.] 0x00000000000494b7
>>>     1.56%   0.01%   0.00%   0.00%  gsd-color  
>>> libglib-2.0.so.0.5600.4  [.] 0x00000000000494ce
>>>     1.56%   0.00%   0.00%   0.00%  mgen       
>>> [kernel.kallsyms]        [k] task_tick_fair
>>>     0.00%   0.15%   0.00%   0.04%  perf       
>>> [kernel.kallsyms]        [k] smp_call_function_single
>>>     0.00%   0.13%   0.00%   6.08%  swapper    
>>> [kernel.kallsyms]        [k] intel_idle
>>>     0.00%   0.03%   0.00%   0.00%  gsd-color  
>>> libglib-2.0.so.0.5600.4  [.] g_main_context_check
>>>     0.00%   0.03%   0.00%   0.00%  swapper    
>>> [kernel.kallsyms]        [k] apic_timer_interrupt
>>>     0.00%   0.03%   0.00%   0.00%  swapper    
>>> [kernel.kallsyms]        [k] check_preempt_curr
>>>
>>> When user press hotkey '3' (event index, starting from 0), it indicates
>>> to sort output by the forth event in group.
>>>
>>>    Samples: 12K of events 'cpu/instructions,period=2000003/, 
>>> cpu/cpu-cycles,period=200003/, ...
>>>                          Overhead  Command    Shared 
>>> Object            Symbol
>>>    92.19%  98.68%   0.00%  93.30%  mgen       
>>> mgen                     [.] LOOP1
>>>     0.00%   0.13%   0.00%   6.08%  swapper    
>>> [kernel.kallsyms]        [k] intel_idle
>>>     3.12%   0.29%   0.00%   0.16%  gsd-color  
>>> libglib-2.0.so.0.5600.4  [.] 0x0000000000049515
>>>     0.00%   0.00%   0.00%   0.06%  swapper    
>>> [kernel.kallsyms]        [k] hrtimer_start_range_ns
>>>     1.56%   0.03%   0.00%   0.04%  gsd-color  
>>> libglib-2.0.so.0.5600.4  [.] 0x00000000000494b7
>>>     0.00%   0.15%   0.00%   0.04%  perf       
>>> [kernel.kallsyms]        [k] smp_call_function_single
>>>     0.00%   0.00%   0.00%   0.02%  mgen       
>>> [kernel.kallsyms]        [k] update_curr
>>>     0.00%   0.00%   0.00%   0.02%  mgen       
>>> [kernel.kallsyms]        [k] apic_timer_interrupt
>>>     0.00%   0.00%   0.00%   0.02%  mgen       
>>> [kernel.kallsyms]        [k] native_apic_msr_eoi_write
>>>     0.00%   0.00%   0.00%   0.02%  mgen       
>>> [kernel.kallsyms]        [k] __update_load_avg_se
>>
>> when I press 0...9 I'm getting extra columns:
>>
>> Samples: 134  of events 'anon group { cycles:u, instructions:u, 
>> cache-misses:u, cycles:u, instructions:u }', Event count (approx.): 
>> 7107344
>>                                  Overhead  Command  Shared Object     
>> Symbol                                                                  Self 
>>
>>    17.95%  41.20%   0.00%  12.44%  41.30%  ls       libc-2.29.so      
>> [.] __strcoll_l                       17.95%  41.20%   0.00%  12.44%  
>> 41.30%       N/A
>>     0.00%  13.22%   0.00%   0.00%   0.00%  ls       ls                
>> [.] 0x000000000000871c                 0.00%  13.22%   0.00%   0.00%   
>> 0.00%       N/A
>>     8.32%  11.49%   0.00%   2.62%   9.34%  ls       ld-2.29.so        
>> [.] do_lookup_x                        8.32%  11.49%   0.00%   2.62%   
>> 9.34%       N/A
>>     0.00%   8.29%  31.18%  13.34%   3.05%  ls       ld-2.29.so        
>> [.] _dl_lookup_symbol_x                0.00%   8.29%  31.18%  13.34%   
>> 3.05%       N/A
>>     0.00%   6.47%   0.00%   0.00%   0.00%  ls       libc-2.29.so      
>> [.] __strlen_avx2                      0.00%   6.47%   0.00%   0.00%   
>> 0.00%       N/A
>>     0.00%   5.97%   0.00%   0.00%   0.00%  ls       ls                
>> [.] 0x0000000000014001                 0.00%   5.97%   0.00%   0.00%   
>> 0.00%       N/A
>>     5.77%   5.83%   7.79%   4.78%   5.04%  ls       ld-2.29.so        
>> [.] strcmp                             5.77%   5.83%   7.79%   4.78%   
>> 5.04%       N/A
>>     2.31%   4.35%   8.30%   0.00%   0.00%  ls       ld-2.29.so        
>> [.] _dl_map_object_from_fd             2.31%   4.35%   8.30%   0.00%   
>> 0.00%       N/A
>>     0.00%   2.96%   0.00%   1.30%   2.22%  ls       ld-2.29.so        
>> [.] __GI___tunables_init               0.00%   2.96%   0.00%   1.30%   
>> 2.22%       N/A
>>     0.66%   0.22%   0.68%   0.00%   0.21%  ls       ld-2.29.so        
>> [.] _dl_start                          0.66%   0.22%   0.68%   0.00%   
>> 0.21%       N/A
>>     2.42%   0.00%   0.02%   3.16%   0.00%  ls       [unknown]         
>> [k] 0xffffffffa2a012b0                 2.42%   0.00%   0.02%   3.16%   
>> 0.00%       N/A
>>     0.16%   0.00%   0.01%   0.20%   0.00%  ls       ld-2.29.so        
>> [.] _start                             0.16%   0.00%   0.01%   0.20%   
>> 0.00%       N/A
>>     0.00%   0.00%  11.47%   0.00%   0.00%  ls       libcap.so.2.26    
>> [.] 0x0000000000002420                 0.00%   0.00%  11.47%   0.00%   
>> 0.00%       N/A
>>     0.00%   0.00%  10.50%   0.00%   0.00%  ls       libc-2.29.so      
>> [.] __GI___tcgetattr                   0.00%   0.00%  10.50%   0.00%   
>> 0.00%       N/A
>>     0.00%   0.00%   9.14%   0.00%   0.00%  ls       ls                
>> [.] 0x000000000000767a                 0.00%   0.00%   9.14%   0.00%   
>> 0.00%       N/A
>>    13.60%   0.00%   7.14%   2.31%   0.00%  ls       ld-2.29.so        
>> [.] _dl_relocate_object               13.60%   0.00%   7.14%   2.31%   
>> 0.00%       N/A
>>     2.13%   0.00%   6.14%   0.00%   0.00%  ls       ld-2.29.so        
>> [.] _dl_map_object_deps                2.13%   0.00%   6.14%   0.00%   
>> 0.00%       N/A
>>     0.00%   0.00%   5.27%   0.00%   0.00%  ls       ld-2.29.so        
>> [.] strlen                             0.00%   0.00%   5.27%   0.00%   
>> 0.00%       N/A
>>     1.31%   0.00%   2.37%   1.08%   0.00%  ls       ld-2.29.so        
>> [.] _dl_sysdep_start                   1.31%   0.00%   2.37%   1.08%   
>> 0.00%       N/A
>>
>>
>> jirka
>>
> 
> Looks it's an existing issue in perf. We can reproduce it by following 
> steps.
> 
> 1. perf record -a -e cycles,instructions -- sleep 3
> 2. perf report --group
> 3. In browser, we use hotkey 's' to switch to another perf.data
> 4. Now in browser, the extra columns 'Self' and 'Children' will be shown.
> 
> But I have not figured out which patch caused this issue. :(
> 
> Thanks
> Jin Yao

I have debugged this issue and I find that's because setup_sorting() is 
executed again after repeat path, so dimensions are added again.

Could you help to review following fix? Thanks!

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 387311c67264..de988589d99b 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1076,6 +1076,7 @@ int cmd_report(int argc, const char **argv)
         struct stat st;
         bool has_br_stack = false;
         int branch_mode = -1;
+       int last_key = 0;
         bool branch_call_mode = false;
  #define CALLCHAIN_DEFAULT_OPT  "graph,0.5,caller,function,percent"
         static const char report_callchain_help[] = "Display call graph 
(stack chain/backtrace):\n\n"
@@ -1450,7 +1451,8 @@ int cmd_report(int argc, const char **argv)
                 sort_order = sort_tmp;
         }

-       if (setup_sorting(session->evlist) < 0) {
+       if ((last_key != K_SWITCH_INPUT_DATA) &&
+           (setup_sorting(session->evlist) < 0)) {
                 if (sort_order)
                         parse_options_usage(report_usage, options, "s", 1);
                 if (field_order)
@@ -1530,6 +1532,7 @@ int cmd_report(int argc, const char **argv)
         ret = __cmd_report(&report);
         if (ret == K_SWITCH_INPUT_DATA) {
                 perf_session__delete(session);
+               last_key = K_SWITCH_INPUT_DATA;
                 goto repeat;
         } else
                 ret = 0;

Thanks
Jin Yao
