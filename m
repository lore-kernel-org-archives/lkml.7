Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0435C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 07:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803F72786E
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 07:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s7BdYue9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfFBHIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 03:08:34 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37906 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfFBHId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 03:08:33 -0400
Received: by mail-qk1-f194.google.com with SMTP id a27so9116926qkk.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 00:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gco0RjkrSxW0hesqZkpGy/xaM8UJuamaEVEPEH+UBnY=;
        b=s7BdYue9QkOGzNeT7fXIMRS+V6XSZJZQotHlbHm2GpIu/HGLi7QH0WldR/pk63VKo4
         Nc7IPgw78ywJR/0wTRb5ShBbFPiymCigKXgdHGbbPwr+P5cDXCpJ7ZUP07emaAEEHI/6
         o9XHKjTh0EYdky/oPDfFyxKQbUN+0GmILcbyfvvo8GYBY2QRwJOYJf3iaXylVTR6c2Ka
         xXomcQkI/qWCdzCRukCt8YXrF9EdPbNHceWdgwAqorUSlcFIS9C49Sd0p/SvMYOzVxTk
         iTnnGw4zEDQjI/aA+iky6CD6AgxQL/wNHt7sXV51aH6m2gP9BPZYbDE3J82GWSOA8gqT
         F23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gco0RjkrSxW0hesqZkpGy/xaM8UJuamaEVEPEH+UBnY=;
        b=XmXQDs6ni+KIrWTXYw0Dawaqo9VAFjczGwGIb+GK/VNCBywxn6y2AQ2yw1jU4mQTnl
         8iKW8NZ8wQWhZDDQk8Htk62a/3V7zMVJ8IYzRpkWIV5UAx9/RkrKqXyK/QNo/XgYMizX
         VkLz/XH47UQCc0cJlcz8kxuZWyvheUvBwjRUX6pE6djvp+BfciwKi7nMYlHPUg6KF5Oy
         LUtqSEQpvnwv7MjLz1d7wYqHTUf30Q539uB5cwPk8hv0Sa1ak6dm8aaOObirOlrhFgyU
         f5agpeZaHSdyZlxsjj2CKm2DsEWAEdBV+5LYercIninQdvb6qglXOZWfL/iiPLr6g8LX
         GPTQ==
X-Gm-Message-State: APjAAAXEJTW2UM6yCXWZXjynSxkNw/k2u4rZp6ZufvEAbSNb5wQN+la6
        tOpBaR1SU2m4z1nZL6Z0j58byQ==
X-Google-Smtp-Source: APXvYqzUx2EdJERlgGDiqFnUy8HnRgi6Z+7Src9sz7T1g70MLLHbRgRFgLvFd3SpVzSGsMunDo0aMg==
X-Received: by 2002:a37:bd86:: with SMTP id n128mr16463319qkf.318.1559457742794;
        Sat, 01 Jun 2019 23:42:22 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li174-127.members.linode.com. [173.230.134.127])
        by smtp.gmail.com with ESMTPSA id v186sm7083243qkc.36.2019.06.01.23.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Jun 2019 23:42:21 -0700 (PDT)
Date:   Sun, 2 Jun 2019 14:42:11 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jiri Olsa <jolsa@redhat.com>
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
Message-ID: <20190602064211.GB9580@leoy-ThinkPad-X240s>
References: <20190508132010.14512-1-jolsa@kernel.org>
 <20190530105439.GA5927@leoy-ThinkPad-X240s>
 <20190530120709.GA3669@krava>
 <20190530125709.GB5927@leoy-ThinkPad-X240s>
 <20190530133645.GC21962@kernel.org>
 <20190530140510.GD5927@leoy-ThinkPad-X240s>
 <20190531091944.GA24672@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531091944.GA24672@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 11:19:44AM +0200, Jiri Olsa wrote:
> On Thu, May 30, 2019 at 10:05:10PM +0800, Leo Yan wrote:
> > Hi Arnaldo,
> > 
> > On Thu, May 30, 2019 at 10:36:45AM -0300, Arnaldo Carvalho de Melo wrote:
> > 
> > [...]
> > 
> > > One other way of testing this:
> > > 
> > > I used perf trace's use of BPF, using:
> > > 
> > > [root@quaco ~]# cat ~/.perfconfig
> > > [llvm]
> > > 	dump-obj = true
> > > 	clang-opt = -g
> > > [trace]
> > > 	add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c
> > > 	show_zeros = yes
> > > 	show_duration = no
> > > 	no_inherit = yes
> > > 	show_timestamp = no
> > > 	show_arg_names = no
> > > 	args_alignment = 40
> > > 	show_prefix = yes
> > > 
> > > For arm64 this needs fixing, tools/perf/examples/bpf/augmented_raw_syscalls.c
> > > (its in the kernel sources) is still hard coded for x86_64 syscall numbers :-\
> > 
> > Thanks a lot for sharing this, I will test with this method and let you
> > and Jiri know the result in tomorrow.
> 
> it's always battle of having too much data but caturing everything,
> versus having reasonable data size and being lucky to hit the trace ;-)
> 
> with sampling on high freq and 1 second trace in another terminal
> I got the trace below:

Thanks a lot for confirmation, Jiri.

I tries multiple times with different frequency for sampleip command,
but still no luck to capture eBPF object info in perf data.  Will dig
into it and will keep you posted for this.

Thanks,
Leo Yan

> ---
> terminal 1:
>   # sampleip -F 1000 20
> 
> terminal2:
>   # perf-with-kcore record pt -e intel_pt//k -m100M,100M -C 1 -- sleep 1
>   # perf-with-kcore script pt --call-trace
>   ...
>          swapper     0 [001] 85820.051207146: ([kernel.kallsyms]                                 )                                                  __perf_event_overflow                               
>          swapper     0 [001] 85820.051207146: ([kernel.kallsyms]                                 )                                                      __perf_event_account_interrupt                  
>          swapper     0 [001] 85820.051207146: ([kernel.kallsyms]                                 )                                                      __x86_indirect_thunk_rax                        
>          swapper     0 [001] 85820.051207146: ([kernel.kallsyms]                                 )                                                          __x86_indirect_thunk_rax                    
>          swapper     0 [001] 85820.051207146: ([kernel.kallsyms]                                 )                                                              __x86_indirect_thunk_rax                
>          swapper     0 [001] 85820.051207146: ([kernel.kallsyms]                                 )                                                                  __x86_indirect_thunk_rax            
>          swapper     0 [001] 85820.051207467: (bpf_prog_19578a12836c4115                         )                                                                      __htab_map_lookup_elem          
>          swapper     0 [001] 85820.051207788: ([kernel.kallsyms]                                 )                                                                          memcmp                      
>   ...
>   # perf-with-kcore script pt --insn-trace --xed
>   ...
>          swapper     0 [001] 85820.051207467:  ffffffff90c00c40 __x86_indirect_thunk_rax+0x10 ([kernel.kallsyms])               retq  
>          swapper     0 [001] 85820.051207467:  ffffffffc0557710 bpf_prog_19578a12836c4115+0x0 (bpf_prog_19578a12836c4115)               pushq  %rbp
>          swapper     0 [001] 85820.051207467:  ffffffffc0557711 bpf_prog_19578a12836c4115+0x1 (bpf_prog_19578a12836c4115)               mov %rsp, %rbp
>          swapper     0 [001] 85820.051207467:  ffffffffc0557714 bpf_prog_19578a12836c4115+0x4 (bpf_prog_19578a12836c4115)               sub $0x38, %rsp
>          swapper     0 [001] 85820.051207467:  ffffffffc055771b bpf_prog_19578a12836c4115+0xb (bpf_prog_19578a12836c4115)               sub $0x28, %rbp
>          swapper     0 [001] 85820.051207467:  ffffffffc055771f bpf_prog_19578a12836c4115+0xf (bpf_prog_19578a12836c4115)               movq  %rbx, (%rbp)
>          swapper     0 [001] 85820.051207467:  ffffffffc0557723 bpf_prog_19578a12836c4115+0x13 (bpf_prog_19578a12836c4115)              movq  %r13, 0x8(%rbp)
>          swapper     0 [001] 85820.051207467:  ffffffffc0557727 bpf_prog_19578a12836c4115+0x17 (bpf_prog_19578a12836c4115)              movq  %r14, 0x10(%rbp)
>          swapper     0 [001] 85820.051207467:  ffffffffc055772b bpf_prog_19578a12836c4115+0x1b (bpf_prog_19578a12836c4115)              movq  %r15, 0x18(%rbp)
>          swapper     0 [001] 85820.051207467:  ffffffffc055772f bpf_prog_19578a12836c4115+0x1f (bpf_prog_19578a12836c4115)              xor %eax, %eax
>          swapper     0 [001] 85820.051207467:  ffffffffc0557731 bpf_prog_19578a12836c4115+0x21 (bpf_prog_19578a12836c4115)              movq  %rax, 0x20(%rbp)
>          swapper     0 [001] 85820.051207467:  ffffffffc0557735 bpf_prog_19578a12836c4115+0x25 (bpf_prog_19578a12836c4115)              mov $0x1, %esi
>          swapper     0 [001] 85820.051207467:  ffffffffc055773a bpf_prog_19578a12836c4115+0x2a (bpf_prog_19578a12836c4115)              movl  %esi, -0xc(%rbp)
>          swapper     0 [001] 85820.051207467:  ffffffffc055773d bpf_prog_19578a12836c4115+0x2d (bpf_prog_19578a12836c4115)              movq  (%rdi), %rdi
>          swapper     0 [001] 85820.051207467:  ffffffffc0557741 bpf_prog_19578a12836c4115+0x31 (bpf_prog_19578a12836c4115)              movq  0x80(%rdi), %rdi
>          swapper     0 [001] 85820.051207467:  ffffffffc0557748 bpf_prog_19578a12836c4115+0x38 (bpf_prog_19578a12836c4115)              movq  %rdi, -0x8(%rbp)
>          swapper     0 [001] 85820.051207467:  ffffffffc055774c bpf_prog_19578a12836c4115+0x3c (bpf_prog_19578a12836c4115)              mov %rbp, %rsi
>          swapper     0 [001] 85820.051207467:  ffffffffc055774f bpf_prog_19578a12836c4115+0x3f (bpf_prog_19578a12836c4115)              add $0xfffffffffffffff8, %rsi
>          swapper     0 [001] 85820.051207467:  ffffffffc0557753 bpf_prog_19578a12836c4115+0x43 (bpf_prog_19578a12836c4115)              mov $0xffff9ac0b2926000, %rdi
>          swapper     0 [001] 85820.051207467:  ffffffffc055775d bpf_prog_19578a12836c4115+0x4d (bpf_prog_19578a12836c4115)              callq  0xffffffff901fde70
>          swapper     0 [001] 85820.051207467:  ffffffff901fde70 __htab_map_lookup_elem+0x0 ([kernel.kallsyms])          nopl  %eax, (%rax,%rax,1)
>          swapper     0 [001] 85820.051207467:  ffffffff901fde75 __htab_map_lookup_elem+0x5 ([kernel.kallsyms])          pushq  %rbx
>          swapper     0 [001] 85820.051207467:  ffffffff901fde76 __htab_map_lookup_elem+0x6 ([kernel.kallsyms])          movl  0x1c(%rdi), %r9d
>          swapper     0 [001] 85820.051207467:  ffffffff901fde7a __htab_map_lookup_elem+0xa ([kernel.kallsyms])          mov %rsi, %rdx
>          swapper     0 [001] 85820.051207467:  ffffffff901fde7d __htab_map_lookup_elem+0xd ([kernel.kallsyms])          movl  0x214(%rdi), %ecx
>          swapper     0 [001] 85820.051207467:  ffffffff901fde83 __htab_map_lookup_elem+0x13 ([kernel.kallsyms])                 mov %rdx, %r10
>          swapper     0 [001] 85820.051207467:  ffffffff901fde86 __htab_map_lookup_elem+0x16 ([kernel.kallsyms])                 mov %r9d, %r8d
>          swapper     0 [001] 85820.051207467:  ffffffff901fde89 __htab_map_lookup_elem+0x19 ([kernel.kallsyms])                 add %r9d, %ecx
>          swapper     0 [001] 85820.051207467:  ffffffff901fde8c __htab_map_lookup_elem+0x1c ([kernel.kallsyms])                 leal  -0x21524111(%rcx), %ebx
>          swapper     0 [001] 85820.051207467:  ffffffff901fde92 __htab_map_lookup_elem+0x22 ([kernel.kallsyms])                 mov %ebx, %esi
>   ...
