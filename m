Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11F8C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 00:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B7120866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 00:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfEAAN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 20:13:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:47284 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfEAAN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 20:13:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 17:13:58 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 30 Apr 2019 17:13:56 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hLcsl-0006w2-SM; Wed, 01 May 2019 08:13:55 +0800
Date:   Wed, 1 May 2019 08:13:46 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Ingo Molnar <mingo@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [tip:x86/mm 14/35] kernel/trace/bpf_trace.c:179:16: error: implicit
 declaration of function 'nmi_uaccess_okay'; did you mean '__access_ok'?
Message-ID: <201905010844.3Y1Kne3b%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
head:   3950746d9d8ef981c1cb842384e0e86e8d1aad76
commit: c7b6f29b6257532792fc722b68fcc0e00b5a856c [14/35] bpf: Fail bpf_probe_write_user() while mm is switched
config: s390-defconfig (attached as .config)
compiler: s390x-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c7b6f29b6257532792fc722b68fcc0e00b5a856c
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:11:0,
                    from kernel/trace/bpf_trace.c:5:
   kernel/trace/bpf_trace.c: In function '____bpf_probe_write_user':
>> kernel/trace/bpf_trace.c:179:16: error: implicit declaration of function 'nmi_uaccess_okay'; did you mean '__access_ok'? [-Werror=implicit-function-declaration]
     if (unlikely(!nmi_uaccess_okay()))
                   ^
   include/linux/compiler.h:77:42: note: in definition of macro 'unlikely'
    # define unlikely(x) __builtin_expect(!!(x), 0)
                                             ^
   cc1: some warnings being treated as errors

vim +179 kernel/trace/bpf_trace.c

   > 5	#include <linux/kernel.h>
     6	#include <linux/types.h>
     7	#include <linux/slab.h>
     8	#include <linux/bpf.h>
     9	#include <linux/bpf_perf_event.h>
    10	#include <linux/filter.h>
    11	#include <linux/uaccess.h>
    12	#include <linux/ctype.h>
    13	#include <linux/kprobes.h>
    14	#include <linux/syscalls.h>
    15	#include <linux/error-injection.h>
    16	
    17	#include <asm/tlb.h>
    18	
    19	#include "trace_probe.h"
    20	#include "trace.h"
    21	
    22	#ifdef CONFIG_MODULES
    23	struct bpf_trace_module {
    24		struct module *module;
    25		struct list_head list;
    26	};
    27	
    28	static LIST_HEAD(bpf_trace_modules);
    29	static DEFINE_MUTEX(bpf_module_mutex);
    30	
    31	static struct bpf_raw_event_map *bpf_get_raw_tracepoint_module(const char *name)
    32	{
    33		struct bpf_raw_event_map *btp, *ret = NULL;
    34		struct bpf_trace_module *btm;
    35		unsigned int i;
    36	
    37		mutex_lock(&bpf_module_mutex);
    38		list_for_each_entry(btm, &bpf_trace_modules, list) {
    39			for (i = 0; i < btm->module->num_bpf_raw_events; ++i) {
    40				btp = &btm->module->bpf_raw_events[i];
    41				if (!strcmp(btp->tp->name, name)) {
    42					if (try_module_get(btm->module))
    43						ret = btp;
    44					goto out;
    45				}
    46			}
    47		}
    48	out:
    49		mutex_unlock(&bpf_module_mutex);
    50		return ret;
    51	}
    52	#else
    53	static struct bpf_raw_event_map *bpf_get_raw_tracepoint_module(const char *name)
    54	{
    55		return NULL;
    56	}
    57	#endif /* CONFIG_MODULES */
    58	
    59	u64 bpf_get_stackid(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
    60	u64 bpf_get_stack(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
    61	
    62	/**
    63	 * trace_call_bpf - invoke BPF program
    64	 * @call: tracepoint event
    65	 * @ctx: opaque context pointer
    66	 *
    67	 * kprobe handlers execute BPF programs via this helper.
    68	 * Can be used from static tracepoints in the future.
    69	 *
    70	 * Return: BPF programs always return an integer which is interpreted by
    71	 * kprobe handler as:
    72	 * 0 - return from kprobe (event is filtered out)
    73	 * 1 - store kprobe event into ring buffer
    74	 * Other values are reserved and currently alias to 1
    75	 */
    76	unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
    77	{
    78		unsigned int ret;
    79	
    80		if (in_nmi()) /* not supported yet */
    81			return 1;
    82	
    83		preempt_disable();
    84	
    85		if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
    86			/*
    87			 * since some bpf program is already running on this cpu,
    88			 * don't call into another bpf program (same or different)
    89			 * and don't send kprobe event into ring-buffer,
    90			 * so return zero here
    91			 */
    92			ret = 0;
    93			goto out;
    94		}
    95	
    96		/*
    97		 * Instead of moving rcu_read_lock/rcu_dereference/rcu_read_unlock
    98		 * to all call sites, we did a bpf_prog_array_valid() there to check
    99		 * whether call->prog_array is empty or not, which is
   100		 * a heurisitc to speed up execution.
   101		 *
   102		 * If bpf_prog_array_valid() fetched prog_array was
   103		 * non-NULL, we go into trace_call_bpf() and do the actual
   104		 * proper rcu_dereference() under RCU lock.
   105		 * If it turns out that prog_array is NULL then, we bail out.
   106		 * For the opposite, if the bpf_prog_array_valid() fetched pointer
   107		 * was NULL, you'll skip the prog_array with the risk of missing
   108		 * out of events when it was updated in between this and the
   109		 * rcu_dereference() which is accepted risk.
   110		 */
   111		ret = BPF_PROG_RUN_ARRAY_CHECK(call->prog_array, ctx, BPF_PROG_RUN);
   112	
   113	 out:
   114		__this_cpu_dec(bpf_prog_active);
   115		preempt_enable();
   116	
   117		return ret;
   118	}
   119	EXPORT_SYMBOL_GPL(trace_call_bpf);
   120	
   121	#ifdef CONFIG_BPF_KPROBE_OVERRIDE
   122	BPF_CALL_2(bpf_override_return, struct pt_regs *, regs, unsigned long, rc)
   123	{
   124		regs_set_return_value(regs, rc);
   125		override_function_with_return(regs);
   126		return 0;
   127	}
   128	
   129	static const struct bpf_func_proto bpf_override_return_proto = {
   130		.func		= bpf_override_return,
   131		.gpl_only	= true,
   132		.ret_type	= RET_INTEGER,
   133		.arg1_type	= ARG_PTR_TO_CTX,
   134		.arg2_type	= ARG_ANYTHING,
   135	};
   136	#endif
   137	
   138	BPF_CALL_3(bpf_probe_read, void *, dst, u32, size, const void *, unsafe_ptr)
   139	{
   140		int ret;
   141	
   142		ret = probe_kernel_read(dst, unsafe_ptr, size);
   143		if (unlikely(ret < 0))
   144			memset(dst, 0, size);
   145	
   146		return ret;
   147	}
   148	
   149	static const struct bpf_func_proto bpf_probe_read_proto = {
   150		.func		= bpf_probe_read,
   151		.gpl_only	= true,
   152		.ret_type	= RET_INTEGER,
   153		.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
   154		.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
   155		.arg3_type	= ARG_ANYTHING,
   156	};
   157	
   158	BPF_CALL_3(bpf_probe_write_user, void *, unsafe_ptr, const void *, src,
   159		   u32, size)
   160	{
   161		/*
   162		 * Ensure we're in user context which is safe for the helper to
   163		 * run. This helper has no business in a kthread.
   164		 *
   165		 * access_ok() should prevent writing to non-user memory, but in
   166		 * some situations (nommu, temporary switch, etc) access_ok() does
   167		 * not provide enough validation, hence the check on KERNEL_DS.
   168		 *
   169		 * nmi_uaccess_okay() ensures the probe is not run in an interim
   170		 * state, when the task or mm are switched. This is specifically
   171		 * required to prevent the use of temporary mm.
   172		 */
   173	
   174		if (unlikely(in_interrupt() ||
   175			     current->flags & (PF_KTHREAD | PF_EXITING)))
   176			return -EPERM;
   177		if (unlikely(uaccess_kernel()))
   178			return -EPERM;
 > 179		if (unlikely(!nmi_uaccess_okay()))
   180			return -EPERM;
   181		if (!access_ok(unsafe_ptr, size))
   182			return -EPERM;
   183	
   184		return probe_kernel_write(unsafe_ptr, src, size);
   185	}
   186	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--HlL+5n6rz5pIUxbD
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
1ABQ/wfDP1RkVacAAA==

--HlL+5n6rz5pIUxbD--
