Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75381C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B0D208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfLKHGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 02:06:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:43247 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfLKHGX (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 02:06:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 23:06:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="220384986"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.73]) ([10.239.196.73])
  by fmsmga001.fm.intel.com with ESMTP; 10 Dec 2019 23:06:20 -0800
Subject: Re: [PATCH v1 2/2] perf report: support hotkey to let user select any
 event in group for sorting
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20191210083207.31569-1-yao.jin@linux.intel.com>
 <20191210083207.31569-2-yao.jin@linux.intel.com>
 <20191210160028.GA28084@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <f3e93abb-e840-281e-0e3a-feb959e897a0@linux.intel.com>
Date:   Wed, 11 Dec 2019 15:06:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191210160028.GA28084@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/2019 12:00 AM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Dec 10, 2019 at 04:32:07PM +0800, Jin Yao escreveu:
>> When performing "perf report --group", it shows the event group information
>> together. In previous patch, we have supported a new option "--group-sort-idx"
>> to sort the output by the event at the index n in event group.
>>
>> It would be nice if we can use a hotkey in browser to select a event
>> for sorting.
>>
>> For example,
>>
>>    # perf report --group
>>
>>   Samples: 12K of events 'cpu/instructions,period=2000003/, cpu/cpu-cycles,period=200003/, ...
>>                          Overhead  Command    Shared Object            Symbol
>>    92.19%  98.68%   0.00%  93.30%  mgen       mgen                     [.] LOOP1
>>     3.12%   0.29%   0.00%   0.16%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x0000000000049515
>>     1.56%   0.03%   0.00%   0.04%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x00000000000494b7
>>     1.56%   0.01%   0.00%   0.00%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x00000000000494ce
>>     1.56%   0.00%   0.00%   0.00%  mgen       [kernel.kallsyms]        [k] task_tick_fair
>>     0.00%   0.15%   0.00%   0.04%  perf       [kernel.kallsyms]        [k] smp_call_function_single
>>     0.00%   0.13%   0.00%   6.08%  swapper    [kernel.kallsyms]        [k] intel_idle
>>     0.00%   0.03%   0.00%   0.00%  gsd-color  libglib-2.0.so.0.5600.4  [.] g_main_context_check
>>     0.00%   0.03%   0.00%   0.00%  swapper    [kernel.kallsyms]        [k] apic_timer_interrupt
>>     0.00%   0.03%   0.00%   0.00%  swapper    [kernel.kallsyms]        [k] check_preempt_curr
>>
>> When user press hotkey '3' (event index, starting from 0), it indicates
>> to sort output by the fourth event in group.
>>
>>    Samples: 12K of events 'cpu/instructions,period=2000003/, cpu/cpu-cycles,period=200003/, ...
>>                          Overhead  Command    Shared Object            Symbol
>>    92.19%  98.68%   0.00%  93.30%  mgen       mgen                     [.] LOOP1
>>     0.00%   0.13%   0.00%   6.08%  swapper    [kernel.kallsyms]        [k] intel_idle
>>     3.12%   0.29%   0.00%   0.16%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x0000000000049515
>>     0.00%   0.00%   0.00%   0.06%  swapper    [kernel.kallsyms]        [k] hrtimer_start_range_ns
>>     1.56%   0.03%   0.00%   0.04%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x00000000000494b7
>>     0.00%   0.15%   0.00%   0.04%  perf       [kernel.kallsyms]        [k] smp_call_function_single
>>     0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] update_curr
>>     0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] apic_timer_interrupt
>>     0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] native_apic_msr_eoi_write
>>     0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] __update_load_avg_se
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/builtin-report.c    |  4 ++--
>>   tools/perf/ui/browsers/hists.c | 21 ++++++++++++++++++++-
>>   tools/perf/ui/keysyms.h        |  1 +
>>   3 files changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>> index 729cf7611d8a..02178fc54d67 100644
>> --- a/tools/perf/builtin-report.c
>> +++ b/tools/perf/builtin-report.c
>> @@ -635,7 +635,7 @@ static int report__browse_hists(struct report *rep)
>>   		 * Usually "ret" is the last pressed key, and we only
>>   		 * care if the key notifies us to switch data file.
>>   		 */
>> -		if (ret != K_SWITCH_INPUT_DATA)
>> +		if (ret != K_SWITCH_INPUT_DATA && ret != K_RELOAD)
>>   			ret = 0;
>>   		break;
>>   	case 2:
>> @@ -1538,7 +1538,7 @@ int cmd_report(int argc, const char **argv)
>>   	sort__setup_elide(stdout);
>>   
>>   	ret = __cmd_report(&report);
>> -	if (ret == K_SWITCH_INPUT_DATA) {
>> +	if (ret == K_SWITCH_INPUT_DATA || ret == K_RELOAD) {
>>   		perf_session__delete(session);
>>   		goto repeat;
>>   	} else
>> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
>> index d4d3558fdef4..1de2456f27c3 100644
>> --- a/tools/perf/ui/browsers/hists.c
>> +++ b/tools/perf/ui/browsers/hists.c
>> @@ -2876,7 +2876,8 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
>>   	"s             Switch to another data file in PWD\n"
>>   	"t             Zoom into current Thread\n"
>>   	"V             Verbose (DSO names in callchains, etc)\n"
>> -	"/             Filter symbol by name";
>> +	"/             Filter symbol by name\n"
>> +	"0-9           Sort by event n in group";
>>   	static const char top_help[] = HIST_BROWSER_HELP_COMMON
>>   	"P             Print histograms to perf.hist.N\n"
>>   	"t             Zoom into current Thread\n"
>> @@ -2937,6 +2938,24 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
>>   			 * go to the next or previous
>>   			 */
>>   			goto out_free_stack;
>> +		case '0':
> 
> case '0' ... '9':
> 
> works as well, for instance, in the kernel sources we have:
> 
> [acme@quaco perf]$ grep 'case.*\.\..*:' */*.c
> block/bio.c:	case 2 ... 4:
> block/bio.c:	case 5 ... 16:
> block/bio.c:	case 17 ... 64:
> block/bio.c:	case 65 ... 128:
> block/bio.c:	case 129 ... BIO_MAX_PAGES:
> block/sed-opal.c:		case 0xbfff ... 0xffff:
> fs/binfmt_elf.c:		case PT_LOPROC ... PT_HIPROC:
> fs/binfmt_elf.c:			case PT_LOPROC ... PT_HIPROC:
> kernel/audit.c:	case AUDIT_FIRST_USER_MSG ... AUDIT_LAST_USER_MSG:
> kernel/audit.c:	case AUDIT_FIRST_USER_MSG2 ... AUDIT_LAST_USER_MSG2:
> kernel/audit.c:	case AUDIT_FIRST_USER_MSG ... AUDIT_LAST_USER_MSG:
> kernel/audit.c:	case AUDIT_FIRST_USER_MSG2 ... AUDIT_LAST_USER_MSG2:
> [acme@quaco perf]$
> 

Yes, your code is much better. :)

>> +		case '1':
>> +		case '2':
>> +		case '3':
>> +		case '4':
>> +		case '5':
>> +		case '6':
>> +		case '7':
>> +		case '8':
>> +		case '9':
>> +			symbol_conf.group_sort_idx = key - '0';
>> +			if (!symbol_conf.event_group ||
>> +			    symbol_conf.group_sort_idx >= evsel->core.nr_members) {
>> +				continue;
> 
> Better to put something on the helpline as:
> 
>      The max event group index to sort is N!
> 
> And if symbol_conf.event_group isn't set, something like:
> 
>      Sort by index only available with group events!
> 

Good idea. I will add warning such as:

"Max event group index to sort is 3 (index from 0 to 3)"

>> +			}
>> +
>> +			key = K_RELOAD;
>> +			goto out_free_stack;
>>   		case 'a':
>>   			if (!hists__has(hists, sym)) {
>>   				ui_browser__warning(&browser->b, delay_secs * 2,
>> diff --git a/tools/perf/ui/keysyms.h b/tools/perf/ui/keysyms.h
>> index fbfac29077f2..04cc4e5c031f 100644
>> --- a/tools/perf/ui/keysyms.h
>> +++ b/tools/perf/ui/keysyms.h
>> @@ -25,5 +25,6 @@
>>   #define K_ERROR	 -2
>>   #define K_RESIZE -3
>>   #define K_SWITCH_INPUT_DATA -4
>> +#define K_RELOAD -5
> 
> Can you please split the K_RELOAD logic from this patch?
>

OK, I will split the patch.

Thanks
Jin Yao

>>   #endif /* _PERF_KEYSYMS_H_ */
>> -- 
>> 2.17.1
> 
