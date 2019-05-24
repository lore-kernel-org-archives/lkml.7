Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5822C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 23:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D7221848
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 23:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfEXXVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 19:21:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfEXXVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 19:21:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E55D03082E55;
        Fri, 24 May 2019 23:21:39 +0000 (UTC)
Received: from krava (ovpn-204-34.brq.redhat.com [10.40.204.34])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5CD4C5D9D3;
        Fri, 24 May 2019 23:21:36 +0000 (UTC)
Date:   Sat, 25 May 2019 01:21:35 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 05/12] perf tools: Read also the end of the kernel
Message-ID: <20190524232135.GA30645@krava>
References: <20190508132010.14512-1-jolsa@kernel.org>
 <20190508132010.14512-6-jolsa@kernel.org>
 <20190524181506.GE17479@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524181506.GE17479@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 24 May 2019 23:21:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 03:15:06PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 08, 2019 at 03:20:03PM +0200, Jiri Olsa escreveu:
> > We mark the end of kernel based on the first module,
> > but that could cover some bpf program maps. Reading
> > _etext symbol if it's present to get precise kernel
> > map end.
> 
> Investigating... Have you run 'perf test' before hitting the send
> button? :-)

yea, I got skip test.. for not having the vmlinux in place

[jolsa@krava perf]$ sudo ./perf test 1
 1: vmlinux symtab matches kallsyms                       : Skip

did not realized it would break.. because I have 'Skip' in
this one always :-\ sry

jirka

> 
> - Arnaldo
> 
> [root@quaco c]# perf test 1
>  1: vmlinux symtab matches kallsyms                       : FAILED!
> [root@quaco c]# perf test -v 1
>  1: vmlinux symtab matches kallsyms                       :
> --- start ---
> test child forked, pid 17488
> Looking at the vmlinux_path (8 entries long)
> Using /lib/modules/5.2.0-rc1+/build/vmlinux for symbols
> WARN: 0xffffffff8c001000: diff name v: hypercall_page k: xen_hypercall_set_trap_table
> WARN: 0xffffffff8c0275c0: diff name v: __ia32_sys_rt_sigreturn k: __x64_sys_rt_sigreturn
> WARN: 0xffffffff8c06ac31: diff name v: end_irq_irq_disable k: start_irq_irq_enable
> WARN: 0xffffffff8c06ac32: diff name v: end_irq_irq_enable k: start_irq_restore_fl
> WARN: 0xffffffff8c06ac34: diff name v: end_irq_restore_fl k: start_irq_save_fl
> WARN: 0xffffffff8c06ac36: diff name v: end_irq_save_fl k: start_mmu_read_cr2
> WARN: 0xffffffff8c06ac3c: diff name v: end_mmu_read_cr3 k: start_mmu_write_cr3
> WARN: 0xffffffff8c06ac3f: diff name v: end_mmu_write_cr3 k: start_cpu_wbinvd
> WARN: 0xffffffff8c06ac41: diff name v: end_cpu_wbinvd k: start_cpu_usergs_sysret64
> WARN: 0xffffffff8c06ac47: diff name v: end_cpu_usergs_sysret64 k: start_cpu_swapgs
> WARN: 0xffffffff8c06ac4a: diff name v: end_cpu_swapgs k: start__mov64
> WARN: 0xffffffff8c0814b0: diff end addr for aesni_gcm_dec v: 0xffffffff8c083606 k: 0xffffffff8c0817c7
> WARN: 0xffffffff8c083610: diff end addr for aesni_gcm_enc v: 0xffffffff8c0856f2 k: 0xffffffff8c083927
> WARN: 0xffffffff8c085c00: diff end addr for aesni_gcm_enc_update v: 0xffffffff8c087556 k: 0xffffffff8c085c31
> WARN: 0xffffffff8c087560: diff end addr for aesni_gcm_dec_update v: 0xffffffff8c088f2a k: 0xffffffff8c087591
> WARN: 0xffffffff8c08b7c0: diff end addr for aesni_gcm_enc_update_avx_gen2 v: 0xffffffff8c09b13c k: 0xffffffff8c08b818
> WARN: 0xffffffff8c08fac1: diff name v: _initial_blocks_done2259 k: _initial_blocks_encrypted15
> WARN: 0xffffffff8c094943: diff name v: _initial_blocks_done4447 k: _initial_blocks_encrypted2497
> WARN: 0xffffffff8c09a023: diff name v: _initial_blocks_done7187 k: _initial_blocks_encrypted4649
> WARN: 0xffffffff8c09b140: diff end addr for aesni_gcm_dec_update_avx_gen2 v: 0xffffffff8c0ab05f k: 0xffffffff8c09b198
> WARN: 0xffffffff8c09f5b6: diff name v: _initial_blocks_done9706 k: _initial_blocks_encrypted7462
> WARN: 0xffffffff8c0a4619: diff name v: _initial_blocks_done11894 k: _initial_blocks_encrypted9944
> WARN: 0xffffffff8c0a9eda: diff name v: _initial_blocks_done14634 k: _initial_blocks_encrypted12096
> WARN: 0xffffffff8c0abcd0: diff end addr for aesni_gcm_enc_update_avx_gen4 v: 0xffffffff8c0ba4a6 k: 0xffffffff8c0abd28
> WARN: 0xffffffff8c0afaa5: diff name v: _initial_blocks_done17291 k: _initial_blocks_encrypted15047
> WARN: 0xffffffff8c0b4345: diff name v: _initial_blocks_done19479 k: _initial_blocks_encrypted17529
> WARN: 0xffffffff8c0b9443: diff name v: _initial_blocks_done22219 k: _initial_blocks_encrypted19681
> WARN: 0xffffffff8c0ba4b0: diff end addr for aesni_gcm_dec_update_avx_gen4 v: 0xffffffff8c0c9229 k: 0xffffffff8c0ba508
> WARN: 0xffffffff8c0be3fa: diff name v: _initial_blocks_done24738 k: _initial_blocks_encrypted22494
> WARN: 0xffffffff8c0c2e7b: diff name v: _initial_blocks_done26926 k: _initial_blocks_encrypted24976
> WARN: 0xffffffff8c0c815a: diff name v: _initial_blocks_done29666 k: _initial_blocks_encrypted27128
> WARN: 0xffffffff8c0dc2b0: diff name v: __ia32_sys_fork k: __x64_sys_fork
> WARN: 0xffffffff8c0dc2d0: diff name v: __ia32_sys_vfork k: __x64_sys_vfork
> WARN: 0xffffffff8c0e9eb0: diff name v: __ia32_sys_restart_syscall k: __x64_sys_restart_syscall
> WARN: 0xffffffff8c0e9f30: diff name v: __ia32_sys_sgetmask k: __x64_sys_sgetmask
> WARN: 0xffffffff8c0ea4b0: diff name v: __ia32_sys_pause k: __x64_sys_pause
> WARN: 0xffffffff8c0f1610: diff name v: __ia32_sys_gettid k: __x64_sys_gettid
> WARN: 0xffffffff8c0f1630: diff name v: __ia32_sys_getpid k: __x64_sys_getpid
> WARN: 0xffffffff8c0f1650: diff name v: __ia32_sys_getppid k: __x64_sys_getppid
> WARN: 0xffffffff8c0f1980: diff name v: __ia32_sys_getuid k: __x64_sys_getuid
> WARN: 0xffffffff8c0f19b0: diff name v: __ia32_sys_geteuid k: __x64_sys_geteuid
> WARN: 0xffffffff8c0f1b30: diff name v: __ia32_sys_getgid k: __x64_sys_getgid
> WARN: 0xffffffff8c0f1b60: diff name v: __ia32_sys_getegid k: __x64_sys_getegid
> WARN: 0xffffffff8c0f2130: diff name v: __ia32_sys_getpgrp k: __x64_sys_getpgrp
> WARN: 0xffffffff8c0f52f0: diff name v: __ia32_sys_setsid k: __x64_sys_setsid
> WARN: 0xffffffff8c1016d0: diff name v: sys_ni_syscall k: __x64_sys_vm86old
> WARN: 0xffffffff8c10b400: diff name v: __ia32_sys_sched_yield k: __x64_sys_sched_yield
> WARN: 0xffffffff8c1775a0: diff name v: __ia32_sys_getuid16 k: __x64_sys_getuid16
> WARN: 0xffffffff8c1775f0: diff name v: __ia32_sys_geteuid16 k: __x64_sys_geteuid16
> WARN: 0xffffffff8c177640: diff name v: __ia32_sys_getgid16 k: __x64_sys_getgid16
> WARN: 0xffffffff8c177690: diff name v: __ia32_sys_getegid16 k: __x64_sys_getegid16
> WARN: 0xffffffff8c1fa600: diff name v: mark_reg_not_init.part.48 k: mark_reg_unknown.part.51
> WARN: 0xffffffff8c21c1f0: diff name v: perf_pmu_cancel_txn.part.104 k: perf_pmu_commit_txn.part.105
> WARN: 0xffffffff8c23cad0: diff name v: __probe_kernel_read k: probe_kernel_read
> WARN: 0xffffffff8c23cb50: diff name v: __probe_kernel_write k: probe_kernel_write
> WARN: 0xffffffff8c277720: diff name v: __ia32_sys_munlockall k: __x64_sys_munlockall
> WARN: 0xffffffff8c2e9a70: diff name v: __ia32_sys_vhangup k: __x64_sys_vhangup
> WARN: 0xffffffff8c325d30: diff name v: __ia32_sys_sync k: __x64_sys_sync
> WARN: 0xffffffff8c33c310: diff name v: __ia32_sys_inotify_init k: __x64_sys_inotify_init
> WARN: 0xffffffff8c42be70: diff name v: selinux_msg_queue_msgctl.part.37 k: selinux_shm_shmctl.part.36
> WARN: 0xffffffff8c4574c0: diff name v: _rsa_dec.isra.2 k: _rsa_enc.isra.3
> WARN: 0xffffffff8c4c84e0: diff name v: __crc32c_le_base k: __crc32c_le
> WARN: 0xffffffff8c4c8630: diff name v: crc32_le_base k: crc32_le
> WARN: 0xffffffff8c516041: diff name v: quirk_disable_msi.part.30 k: quirk_msi_ht_cap.part.43
> WARN: 0xffffffff8c596c80: diff name v: clkdev_hw_create k: __clk_register_clkdev
> WARN: 0xffffffff8c844430: diff name v: phys_switch_id_show.part.17 k: speed_show.part.22
> WARN: 0xffffffff8c8578f0: diff name v: devlink_fmsg_arr_pair_nest_end.part.56 k: devlink_fmsg_u8_pair_put.part.60
> WARN: 0xffffffff8c9961d0: diff name v: __memcpy k: memcpy
> WARN: 0xffffffff8c996370: diff name v: __memmove k: memmove
> WARN: 0xffffffff8c996510: diff name v: __memset k: memset
> WARN: 0xffffffff8c996b90: diff end addr for csum_partial_copy_generic v: 0xffffffff8c996cf9 k: 0xffffffff8c999590
> WARN: 0xffffffff8c9a6e50: diff name v: default_idle k: __cpuidle_text_start
> WARN: 0xffffffff8ca00000: diff name v: native_usergs_sysret64 k: __entry_text_start
> WARN: 0xffffffff8ca00a3b: diff name v: restore_regs_and_return_to_kernel k: retint_kernel
> ERR : 0xffffffff8cc00e41: __indirect_thunk_end not on kallsyms
> WARN: Maps only in vmlinux:
>  b000000-b02c000 1c00000 [kernel].data..percpu
>  ffffffff8cc00e44-ffffffff8cc01044 e00e44 [kernel].notes
>  ffffffff8ce00000-ffffffff8d1c9372 1000000 [kernel].rodata
>  ffffffff8d1cbfb0-ffffffff8d1cc028 13cbfb0 [kernel].tracedata
>  ffffffff8d1e04d0-ffffffff8d2123a0 13e04d0 [kernel]__ksymtab_strings
>  ffffffff8d2123a0-ffffffff8d2125d0 14123a0 [kernel]__init_rodata
>  ffffffff8d2125d0-ffffffff8d215bb8 14125d0 [kernel]__param
>  ffffffff8d215bb8-ffffffff8d216000 1415bb8 [kernel]__modver
>  ffffffff8d400000-ffffffff8d5679c0 1600000 [kernel].data
>  ffffffff8d933000-ffffffff8d934000 1b33000 [kernel].vvar
>  ffffffff8d960000-ffffffff8d9dcb2f 1d60000 [kernel].init.text
>  ffffffff8d9de000-ffffffff8db46590 1dde000 [kernel].init.data
>  ffffffff8db46590-ffffffff8db465b0 1f46590 [kernel].x86_cpu_dev.init
>  ffffffff8db5ded0-ffffffff8db5df98 1f5ded0 [kernel].iommu_table
>  ffffffff8db5df98-ffffffff8db5dfd8 1f5df98 [kernel].apicdrivers
>  ffffffff8db5dfd8-ffffffff8db5f85e 1f5dfd8 [kernel].exit.text
>  ffffffff8db69000-ffffffff8db6a000 1f69000 [kernel].data_nosave
>  ffffffff8db6a000-ffffffff8e000000 1f6a000 [kernel].bss
> test child finished with -1
> ---- end ----
> vmlinux symtab matches kallsyms: FAILED!
> [root@quaco c]#
> 
> [acme@quaco perf]$ git bisect good
> 7d98e1a73bd7dae6cb321ec8b0b97b9fed7c0e1b is the first bad commit
> commit 7d98e1a73bd7dae6cb321ec8b0b97b9fed7c0e1b
> Author: Jiri Olsa <jolsa@kernel.org>
> Date:   Wed May 8 15:20:03 2019 +0200
> 
>     perf machine: Read also the end of the kernel
> 
>     We mark the end of kernel based on the first module, but that could
>     cover some bpf program maps. Reading _etext symbol if it's present to
>     get precise kernel map end.
> 
>     Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>     Acked-by: Song Liu <songliubraving@fb.com>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     Cc: Andi Kleen <ak@linux.intel.com>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Stanislav Fomichev <sdf@google.com>
>     Cc: Thomas Richter <tmricht@linux.ibm.com>
>     Link: http://lkml.kernel.org/r/20190508132010.14512-6-jolsa@kernel.org
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> :040000 040000 4ca5fa4c6f15fd8cf9a0eee870efbd01e9fe309d 8311b30f94e9cf9a863dc9619b0499863f64960e M	tools
> [acme@quaco perf]$
>  
> > Link: http://lkml.kernel.org/n/tip-ynut991ttyyhvo1sbhlm4c42@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/machine.c | 27 ++++++++++++++++++---------
> >  1 file changed, 18 insertions(+), 9 deletions(-)
> > 
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 3c520baa198c..ad0205fbb506 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -924,7 +924,8 @@ const char *ref_reloc_sym_names[] = {"_text", "_stext", NULL};
> >   * symbol_name if it's not that important.
> >   */
> >  static int machine__get_running_kernel_start(struct machine *machine,
> > -					     const char **symbol_name, u64 *start)
> > +					     const char **symbol_name,
> > +					     u64 *start, u64 *end)
> >  {
> >  	char filename[PATH_MAX];
> >  	int i, err = -1;
> > @@ -949,6 +950,11 @@ static int machine__get_running_kernel_start(struct machine *machine,
> >  		*symbol_name = name;
> >  
> >  	*start = addr;
> > +
> > +	err = kallsyms__get_function_start(filename, "_etext", &addr);
> > +	if (!err)
> > +		*end = addr;
> > +
> >  	return 0;
> >  }
> >  
> > @@ -1440,7 +1446,7 @@ int machine__create_kernel_maps(struct machine *machine)
> >  	struct dso *kernel = machine__get_kernel(machine);
> >  	const char *name = NULL;
> >  	struct map *map;
> > -	u64 addr = 0;
> > +	u64 start = 0, end = ~0ULL;
> >  	int ret;
> >  
> >  	if (kernel == NULL)
> > @@ -1459,9 +1465,9 @@ int machine__create_kernel_maps(struct machine *machine)
> >  				 "continuing anyway...\n", machine->pid);
> >  	}
> >  
> > -	if (!machine__get_running_kernel_start(machine, &name, &addr)) {
> > +	if (!machine__get_running_kernel_start(machine, &name, &start, &end)) {
> >  		if (name &&
> > -		    map__set_kallsyms_ref_reloc_sym(machine->vmlinux_map, name, addr)) {
> > +		    map__set_kallsyms_ref_reloc_sym(machine->vmlinux_map, name, start)) {
> >  			machine__destroy_kernel_maps(machine);
> >  			ret = -1;
> >  			goto out_put;
> > @@ -1471,16 +1477,19 @@ int machine__create_kernel_maps(struct machine *machine)
> >  		 * we have a real start address now, so re-order the kmaps
> >  		 * assume it's the last in the kmaps
> >  		 */
> > -		machine__update_kernel_mmap(machine, addr, ~0ULL);
> > +		machine__update_kernel_mmap(machine, start, end);
> >  	}
> >  
> >  	if (machine__create_extra_kernel_maps(machine, kernel))
> >  		pr_debug("Problems creating extra kernel maps, continuing anyway...\n");
> >  
> > -	/* update end address of the kernel map using adjacent module address */
> > -	map = map__next(machine__kernel_map(machine));
> > -	if (map)
> > -		machine__set_kernel_mmap(machine, addr, map->start);
> > +	if (end == ~0ULL) {
> > +		/* update end address of the kernel map using adjacent module address */
> > +		map = map__next(machine__kernel_map(machine));
> > +		if (map)
> > +			machine__set_kernel_mmap(machine, start, map->start);
> > +	}
> > +
> >  out_put:
> >  	dso__put(kernel);
> >  	return ret;
> > -- 
> > 2.20.1
> 
> -- 
> 
> - Arnaldo
