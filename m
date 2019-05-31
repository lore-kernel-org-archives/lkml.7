Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D53C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E391E2669E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfEaJT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 05:19:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfEaJT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 05:19:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1000308339E;
        Fri, 31 May 2019 09:19:56 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id A3D115C559;
        Fri, 31 May 2019 09:19:45 +0000 (UTC)
Date:   Fri, 31 May 2019 11:19:44 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCHv3 00/12] perf tools: Display eBPF code in intel_pt trace
Message-ID: <20190531091944.GA24672@krava>
References: <20190508132010.14512-1-jolsa@kernel.org>
 <20190530105439.GA5927@leoy-ThinkPad-X240s>
 <20190530120709.GA3669@krava>
 <20190530125709.GB5927@leoy-ThinkPad-X240s>
 <20190530133645.GC21962@kernel.org>
 <20190530140510.GD5927@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530140510.GD5927@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 31 May 2019 09:19:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 10:05:10PM +0800, Leo Yan wrote:
> Hi Arnaldo,
> 
> On Thu, May 30, 2019 at 10:36:45AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> [...]
> 
> > One other way of testing this:
> > 
> > I used perf trace's use of BPF, using:
> > 
> > [root@quaco ~]# cat ~/.perfconfig
> > [llvm]
> > 	dump-obj = true
> > 	clang-opt = -g
> > [trace]
> > 	add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c
> > 	show_zeros = yes
> > 	show_duration = no
> > 	no_inherit = yes
> > 	show_timestamp = no
> > 	show_arg_names = no
> > 	args_alignment = 40
> > 	show_prefix = yes
> > 
> > For arm64 this needs fixing, tools/perf/examples/bpf/augmented_raw_syscalls.c
> > (its in the kernel sources) is still hard coded for x86_64 syscall numbers :-\
> 
> Thanks a lot for sharing this, I will test with this method and let you
> and Jiri know the result in tomorrow.

it's always battle of having too much data but caturing everything,
versus having reasonable data size and being lucky to hit the trace ;-)

with sampling on high freq and 1 second trace in another terminal
I got the trace below:

jirka


---
terminal 1:
  # sampleip -F 1000 20

terminal2:
  # perf-with-kcore record pt -e intel_pt//k -m100M,100M -C 1 -- sleep 1
  # perf-with-kcore script pt --call-trace
  ...
         swapper     0 [001] 85820.051207146: ([kernel.kallsyms]                                 )                                                  __perf_event_overflow                               
         swapper     0 [001] 85820.051207146: ([kernel.kallsyms]                                 )                                                      __perf_event_account_interrupt                  
         swapper     0 [001] 85820.051207146: ([kernel.kallsyms]                                 )                                                      __x86_indirect_thunk_rax                        
         swapper     0 [001] 85820.051207146: ([kernel.kallsyms]                                 )                                                          __x86_indirect_thunk_rax                    
         swapper     0 [001] 85820.051207146: ([kernel.kallsyms]                                 )                                                              __x86_indirect_thunk_rax                
         swapper     0 [001] 85820.051207146: ([kernel.kallsyms]                                 )                                                                  __x86_indirect_thunk_rax            
         swapper     0 [001] 85820.051207467: (bpf_prog_19578a12836c4115                         )                                                                      __htab_map_lookup_elem          
         swapper     0 [001] 85820.051207788: ([kernel.kallsyms]                                 )                                                                          memcmp                      
  ...
  # perf-with-kcore script pt --insn-trace --xed
  ...
         swapper     0 [001] 85820.051207467:  ffffffff90c00c40 __x86_indirect_thunk_rax+0x10 ([kernel.kallsyms])               retq  
         swapper     0 [001] 85820.051207467:  ffffffffc0557710 bpf_prog_19578a12836c4115+0x0 (bpf_prog_19578a12836c4115)               pushq  %rbp
         swapper     0 [001] 85820.051207467:  ffffffffc0557711 bpf_prog_19578a12836c4115+0x1 (bpf_prog_19578a12836c4115)               mov %rsp, %rbp
         swapper     0 [001] 85820.051207467:  ffffffffc0557714 bpf_prog_19578a12836c4115+0x4 (bpf_prog_19578a12836c4115)               sub $0x38, %rsp
         swapper     0 [001] 85820.051207467:  ffffffffc055771b bpf_prog_19578a12836c4115+0xb (bpf_prog_19578a12836c4115)               sub $0x28, %rbp
         swapper     0 [001] 85820.051207467:  ffffffffc055771f bpf_prog_19578a12836c4115+0xf (bpf_prog_19578a12836c4115)               movq  %rbx, (%rbp)
         swapper     0 [001] 85820.051207467:  ffffffffc0557723 bpf_prog_19578a12836c4115+0x13 (bpf_prog_19578a12836c4115)              movq  %r13, 0x8(%rbp)
         swapper     0 [001] 85820.051207467:  ffffffffc0557727 bpf_prog_19578a12836c4115+0x17 (bpf_prog_19578a12836c4115)              movq  %r14, 0x10(%rbp)
         swapper     0 [001] 85820.051207467:  ffffffffc055772b bpf_prog_19578a12836c4115+0x1b (bpf_prog_19578a12836c4115)              movq  %r15, 0x18(%rbp)
         swapper     0 [001] 85820.051207467:  ffffffffc055772f bpf_prog_19578a12836c4115+0x1f (bpf_prog_19578a12836c4115)              xor %eax, %eax
         swapper     0 [001] 85820.051207467:  ffffffffc0557731 bpf_prog_19578a12836c4115+0x21 (bpf_prog_19578a12836c4115)              movq  %rax, 0x20(%rbp)
         swapper     0 [001] 85820.051207467:  ffffffffc0557735 bpf_prog_19578a12836c4115+0x25 (bpf_prog_19578a12836c4115)              mov $0x1, %esi
         swapper     0 [001] 85820.051207467:  ffffffffc055773a bpf_prog_19578a12836c4115+0x2a (bpf_prog_19578a12836c4115)              movl  %esi, -0xc(%rbp)
         swapper     0 [001] 85820.051207467:  ffffffffc055773d bpf_prog_19578a12836c4115+0x2d (bpf_prog_19578a12836c4115)              movq  (%rdi), %rdi
         swapper     0 [001] 85820.051207467:  ffffffffc0557741 bpf_prog_19578a12836c4115+0x31 (bpf_prog_19578a12836c4115)              movq  0x80(%rdi), %rdi
         swapper     0 [001] 85820.051207467:  ffffffffc0557748 bpf_prog_19578a12836c4115+0x38 (bpf_prog_19578a12836c4115)              movq  %rdi, -0x8(%rbp)
         swapper     0 [001] 85820.051207467:  ffffffffc055774c bpf_prog_19578a12836c4115+0x3c (bpf_prog_19578a12836c4115)              mov %rbp, %rsi
         swapper     0 [001] 85820.051207467:  ffffffffc055774f bpf_prog_19578a12836c4115+0x3f (bpf_prog_19578a12836c4115)              add $0xfffffffffffffff8, %rsi
         swapper     0 [001] 85820.051207467:  ffffffffc0557753 bpf_prog_19578a12836c4115+0x43 (bpf_prog_19578a12836c4115)              mov $0xffff9ac0b2926000, %rdi
         swapper     0 [001] 85820.051207467:  ffffffffc055775d bpf_prog_19578a12836c4115+0x4d (bpf_prog_19578a12836c4115)              callq  0xffffffff901fde70
         swapper     0 [001] 85820.051207467:  ffffffff901fde70 __htab_map_lookup_elem+0x0 ([kernel.kallsyms])          nopl  %eax, (%rax,%rax,1)
         swapper     0 [001] 85820.051207467:  ffffffff901fde75 __htab_map_lookup_elem+0x5 ([kernel.kallsyms])          pushq  %rbx
         swapper     0 [001] 85820.051207467:  ffffffff901fde76 __htab_map_lookup_elem+0x6 ([kernel.kallsyms])          movl  0x1c(%rdi), %r9d
         swapper     0 [001] 85820.051207467:  ffffffff901fde7a __htab_map_lookup_elem+0xa ([kernel.kallsyms])          mov %rsi, %rdx
         swapper     0 [001] 85820.051207467:  ffffffff901fde7d __htab_map_lookup_elem+0xd ([kernel.kallsyms])          movl  0x214(%rdi), %ecx
         swapper     0 [001] 85820.051207467:  ffffffff901fde83 __htab_map_lookup_elem+0x13 ([kernel.kallsyms])                 mov %rdx, %r10
         swapper     0 [001] 85820.051207467:  ffffffff901fde86 __htab_map_lookup_elem+0x16 ([kernel.kallsyms])                 mov %r9d, %r8d
         swapper     0 [001] 85820.051207467:  ffffffff901fde89 __htab_map_lookup_elem+0x19 ([kernel.kallsyms])                 add %r9d, %ecx
         swapper     0 [001] 85820.051207467:  ffffffff901fde8c __htab_map_lookup_elem+0x1c ([kernel.kallsyms])                 leal  -0x21524111(%rcx), %ebx
         swapper     0 [001] 85820.051207467:  ffffffff901fde92 __htab_map_lookup_elem+0x22 ([kernel.kallsyms])                 mov %ebx, %esi
  ...
