Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE500C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7480C2133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puFZeen7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfCSOwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:52:35 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46297 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfCSOwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:52:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id z25so22364634qti.13;
        Tue, 19 Mar 2019 07:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0LXNlPnTGCvPLGDVhWpsCfEM4twZo142ZBxbNzqStGM=;
        b=puFZeen7nKFjDFhtRwKN4tYmS2I2x1KPaLGHRT0uQca/M8VTOscsXHT+GU/ie5PoO7
         kYe4oAalaEmXqgQhNtP8giUcSGYEoujAzJAk+BG/eRcZgeMtkKuEv9Jpn/xThlDcmsn2
         x196Phk1PY8YFShtdlzlrQkAnLRwBvJE73HEtzZruQMtx6I15I+LECG4PKsq6kNr6I+0
         73wdmur4VhN/MztxlKEt3grVODeEVazq8EPZdp6sAdgVkyjK+NyCdlo9iLe/R/oCNlQ2
         umingtCM+cBfbWHBneG1SB99m320rdqXS9LghTAS5t5Vyjd1ttiV6t+FF7/ialqWwH3g
         /HfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0LXNlPnTGCvPLGDVhWpsCfEM4twZo142ZBxbNzqStGM=;
        b=qjB9jRoTc5nxjxFSzgQxlh+MP7pHri6xYxOikW9pXLXxsZeag24Hh7et8frKMsiJr1
         axMGfGQ9C46W2blrH/+Jk/GhF8mIv/0ZvhNAx2fEIQJ0TS6A4aNqU6UMIoYAz/FsN/DJ
         0TnRXccDzFPLI5k3XyBu8QzbldRysvbX6CiPELtxxPksNCsggY7Kz2XoSPmwa4hZaSOM
         /WwOWNlkExLMto+LDIgpltJPNdpzVb/vMlKevR4J7Lm88VYD7lATvA3lnBMj46Ev4dd6
         kBVapd5ON9ytJojWcnIiTkd9FM7h8Y1El6k48J4KX8v0zk9bQDEwvb/N+un0fuONIrqh
         B5vg==
X-Gm-Message-State: APjAAAUjdng2pSNzh6+AnTpkFL5o8Md8DbkmeTbmYfKBa8xueRDTqQo5
        Afz/nHgbD4+3xvK4cVB4krs=
X-Google-Smtp-Source: APXvYqw3DxNdNtAXk2TlaSJ4sySJV6R+UeMKrBhbnlEykrc8MVMzxCPcWx1C6zM1fxrBXQ0CyNPh5A==
X-Received: by 2002:a0c:ad90:: with SMTP id w16mr2226494qvc.53.1553007152804;
        Tue, 19 Mar 2019 07:52:32 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id p189sm7292551qkf.20.2019.03.19.07.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 07:52:31 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D55674039C; Tue, 19 Mar 2019 11:52:28 -0300 (-03)
Date:   Tue, 19 Mar 2019 11:52:28 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Stanislav Fomichev <sdf@fomichev.me>
Subject: [WORKS!] Re: [PATCH v9 perf,bpf 12/15] perf, bpf: enable annotation
 of bpf program
Message-ID: <20190319145228.GF3029@kernel.org>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-13-songliubraving@fb.com>
 <20190318163848.GE22548@kernel.org>
 <9BC22A6D-B0A7-47B6-9526-E32924EF409D@fb.com>
 <20190319135813.GC3029@kernel.org>
 <20190319141435.GD3029@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190319141435.GD3029@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 19, 2019 at 11:14:35AM -0300, Arnaldo Carvalho de Melo escreveu:
> 
> Now the test is really being performed, the test-all.bin feature
> detection fast path is working, proceeding.

Now it all works, really nice!

I added a 'Committer testing' section with all the steps to test this
and pushed to:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=6530d44e7dc1d41c73fe70b9e6ea1b9cabebb57f

Which I repeat here, please go thru it and check if everything is ok, if
the disassembled + original BPF source code looks ok, etc:

    Committer testing:
    
    1) Have a BPF program running, one that has BTF info, etc, I used
       the tools/perf/examples/bpf/augmented_raw_syscalls.c put in place
       by 'perf trace'.
    
      # grep -B1 augmented_raw ~/.perfconfig
      [trace]
            add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c
      #
      # perf trace -e *mmsg
      dnf/6245 sendmmsg(20, 0x7f5485a88030, 2, MSG_NOSIGNAL) = 2
      NetworkManager/10055 sendmmsg(22<socket:[1056822]>, 0x7f8126ad1bb0, 2, MSG_NOSIGNAL) = 2
    
    2) Then do a 'perf record' system wide for a while:
    
      # perf record -a
      ^C[ perf record: Woken up 68 times to write data ]
      [ perf record: Captured and wrote 19.427 MB perf.data (366891 samples) ]
      #
    
    3) Check that we captured BPF and BTF info in the perf.data file:
    
      # perf report --header-only | grep 'b[pt]f'
      # event : name = cycles:ppp, , id = { 294789, 294790, 294791, 294792, 294793, 294794, 294795, 294796 }, size = 112, { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|CPU|PERIOD, read_format = ID, disabled = 1, inherit = 1, mmap = 1, comm = 1, freq = 1, task = 1, precise_ip = 3, sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1, ksymbol = 1, bpf_event = 1
      # bpf_prog_info of id 13
      # bpf_prog_info of id 14
      # bpf_prog_info of id 15
      # bpf_prog_info of id 16
      # bpf_prog_info of id 17
      # bpf_prog_info of id 18
      # bpf_prog_info of id 21
      # bpf_prog_info of id 22
      # bpf_prog_info of id 41
      # bpf_prog_info of id 42
      # btf info of id 2
      #
    
    4) Check which programs got recorded:
    
       # perf report | grep bpf_prog | head
         0.16%  exe              bpf_prog_819967866022f1e1_sys_enter      [k] bpf_prog_819967866022f1e1_sys_enter
         0.14%  exe              bpf_prog_c1bd85c092d6e4aa_sys_exit       [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
         0.08%  fuse-overlayfs   bpf_prog_819967866022f1e1_sys_enter      [k] bpf_prog_819967866022f1e1_sys_enter
         0.07%  fuse-overlayfs   bpf_prog_c1bd85c092d6e4aa_sys_exit       [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
         0.01%  clang-4.0        bpf_prog_c1bd85c092d6e4aa_sys_exit       [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
         0.01%  clang-4.0        bpf_prog_819967866022f1e1_sys_enter      [k] bpf_prog_819967866022f1e1_sys_enter
         0.00%  clang            bpf_prog_c1bd85c092d6e4aa_sys_exit       [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
         0.00%  runc             bpf_prog_819967866022f1e1_sys_enter      [k] bpf_prog_819967866022f1e1_sys_enter
         0.00%  clang            bpf_prog_819967866022f1e1_sys_enter      [k] bpf_prog_819967866022f1e1_sys_enter
         0.00%  sh               bpf_prog_c1bd85c092d6e4aa_sys_exit       [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
      #
    
      This was with the default --sort order for 'perf report', which is:
    
        --sort comm,dso,symbol
    
      If we just look for the symbol, for instance:
    
       # perf report --sort symbol | grep bpf_prog | head
         0.26%  [k] bpf_prog_819967866022f1e1_sys_enter                -      -
         0.24%  [k] bpf_prog_c1bd85c092d6e4aa_sys_exit                 -      -
       #
    
      or the DSO:
    
       # perf report --sort dso | grep bpf_prog | head
         0.26%  bpf_prog_819967866022f1e1_sys_enter
         0.24%  bpf_prog_c1bd85c092d6e4aa_sys_exit
      #
    
    We'll see the two BPF programs that augmented_raw_syscalls.o puts in
    place,  one attached to the raw_syscalls:sys_enter and another to the
    raw_syscalls:sys_exit tracepoints, as expected.
    
    Now we can finally do, from the command line, annotation for one of
    those two symbols, with the original BPF program source coude intermixed
    with the disassembled JITed code:
    
      # perf annotate --stdio2 bpf_prog_819967866022f1e1_sys_enter
    
      Samples: 950  of event 'cycles:ppp', 4000 Hz, Event count (approx.): 553756947, [percent: local period]
      bpf_prog_819967866022f1e1_sys_enter() bpf_prog_819967866022f1e1_sys_enter
      Percent      int sys_enter(struct syscall_enter_args *args)
       53.41         push   %rbp
    
        0.63         mov    %rsp,%rbp
        0.31         sub    $0x170,%rsp
        1.93         sub    $0x28,%rbp
        7.02         mov    %rbx,0x0(%rbp)
        3.20         mov    %r13,0x8(%rbp)
        1.07         mov    %r14,0x10(%rbp)
        0.61         mov    %r15,0x18(%rbp)
        0.11         xor    %eax,%eax
        1.29         mov    %rax,0x20(%rbp)
        0.11         mov    %rdi,%rbx
                    return bpf_get_current_pid_tgid();
        2.02       → callq  *ffffffffda6776d9
        2.76         mov    %eax,-0x148(%rbp)
                     mov    %rbp,%rsi
                   int sys_enter(struct syscall_enter_args *args)
                     add    $0xfffffffffffffeb8,%rsi
                    return bpf_map_lookup_elem(pids, &pid) != NULL;
                     movabs $0xffff975ac2607800,%rdi
    
        1.26       → callq  *ffffffffda6789e9
                     cmp    $0x0,%rax
        2.43       → je     0
                     add    $0x38,%rax
        0.21         xor    %r13d,%r13d
                    if (pid_filter__has(&pids_filtered, getpid()))
        0.81         cmp    $0x0,%rax
                   → jne    0
                     mov    %rbp,%rdi
                    probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
        2.22         add    $0xfffffffffffffeb8,%rdi
        0.11         mov    $0x40,%esi
        0.32         mov    %rbx,%rdx
        2.74       → callq  *ffffffffda658409
                    syscall = bpf_map_lookup_elem(&syscalls, &augmented_args.args.syscall_nr);
        0.22         mov    %rbp,%rsi
        1.69         add    $0xfffffffffffffec0,%rsi
                    syscall = bpf_map_lookup_elem(&syscalls, &augmented_args.args.syscall_nr);
                     movabs $0xffff975bfcd36000,%rdi
    
                     add    $0xd0,%rdi
        0.21         mov    0x0(%rsi),%eax
        0.93         cmp    $0x200,%rax
                   → jae    0
        0.10         shl    $0x3,%rax
    
        0.11         add    %rdi,%rax
        0.11       → jmp    0
                     xor    %eax,%eax
                    if (syscall == NULL || !syscall->enabled)
        1.07         cmp    $0x0,%rax
                   → je     0
                    if (syscall == NULL || !syscall->enabled)
        6.57         movzbq 0x0(%rax),%rdi
    
                    if (syscall == NULL || !syscall->enabled)
                     cmp    $0x0,%rdi
        0.95       → je     0
                     mov    $0x40,%r8d
                    switch (augmented_args.args.syscall_nr) {
                     mov    -0x140(%rbp),%rdi
                    switch (augmented_args.args.syscall_nr) {
                     cmp    $0x2,%rdi
                   → je     0
                     cmp    $0x101,%rdi
                   → je     0
                     cmp    $0x15,%rdi
                   → jne    0
                    case SYS_OPEN:   filename_arg = (const void *)args->args[0];
                     mov    0x10(%rbx),%rdx
                   → jmp    0
                    case SYS_OPENAT: filename_arg = (const void *)args->args[1];
                     mov    0x18(%rbx),%rdx
                    if (filename_arg != NULL) {
                     cmp    $0x0,%rdx
                   → je     0
                     xor    %edi,%edi
                            augmented_args.filename.reserved = 0;
                     mov    %edi,-0x104(%rbp)
                            augmented_args.filename.size = probe_read_str(&augmented_args.filename.value,
                     mov    %rbp,%rdi
                     add    $0xffffffffffffff00,%rdi
                            augmented_args.filename.size = probe_read_str(&augmented_args.filename.value,
                     mov    $0x100,%esi
                   → callq  *ffffffffda658499
                     mov    $0x148,%r8d
                            augmented_args.filename.size = probe_read_str(&augmented_args.filename.value,
                     mov    %eax,-0x108(%rbp)
                            augmented_args.filename.size = probe_read_str(&augmented_args.filename.value,
                     mov    %rax,%rdi
                     shl    $0x20,%rdi
    
                     shr    $0x20,%rdi
    
                            if (augmented_args.filename.size < sizeof(augmented_args.filename.value)) {
                     cmp    $0xff,%rdi
                   → ja     0
                                    len -= sizeof(augmented_args.filename.value) - augmented_args.filename.size;
                     add    $0x48,%rax
                                    len &= sizeof(augmented_args.filename.value) - 1;
                     and    $0xff,%rax
                     mov    %rax,%r8
                     mov    %rbp,%rcx
                    return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, &augmented_args, len);
                     add    $0xfffffffffffffeb8,%rcx
                     mov    %rbx,%rdi
                     movabs $0xffff975fbd72d800,%rsi
    
                     mov    $0xffffffff,%edx
                   → callq  *ffffffffda658ad9
                     mov    %rax,%r13
                   }
                     mov    %r13,%rax
        0.72         mov    0x0(%rbp),%rbx
                     mov    0x8(%rbp),%r13
        1.16         mov    0x10(%rbp),%r14
        0.10         mov    0x18(%rbp),%r15
        0.42         add    $0x28,%rbp
        0.54         leaveq
        0.54       ← retq
      #
    
    Please see 'man perf-config' to see how to control what should be seen,
    via ~/.perfconfig [annotate] section, for instance, one can suppress the
    source code and see just the disassembly, etc.
    
    Alternatively, use the TUI bu just using 'perf annotate', press
    '/bpf_prog' to see the bpf symbols, press enter and do the interactive
    annotation, which allows for dumping to a file after selecting the
    the various output tunables, for instance, the above without source code
    intermixed, plus showing all the instruction offsets:
    
      # perf annotate bpf_prog_819967866022f1e1_sys_enter
    
    Then press: 's' to hide the source code + 'O' twice to show all
    instruction offsets, then 'P' to print to the
    bpf_prog_819967866022f1e1_sys_enter.annotation file, which will have:
    
      # cat bpf_prog_819967866022f1e1_sys_enter.annotation
      bpf_prog_819967866022f1e1_sys_enter() bpf_prog_819967866022f1e1_sys_enter
      Event: cycles:ppp
    
       53.41    0:   push   %rbp
    
        0.63    1:   mov    %rsp,%rbp
        0.31    4:   sub    $0x170,%rsp
        1.93    b:   sub    $0x28,%rbp
        7.02    f:   mov    %rbx,0x0(%rbp)
        3.20   13:   mov    %r13,0x8(%rbp)
        1.07   17:   mov    %r14,0x10(%rbp)
        0.61   1b:   mov    %r15,0x18(%rbp)
        0.11   1f:   xor    %eax,%eax
        1.29   21:   mov    %rax,0x20(%rbp)
        0.11   25:   mov    %rdi,%rbx
        2.02   28: → callq  *ffffffffda6776d9
        2.76   2d:   mov    %eax,-0x148(%rbp)
               33:   mov    %rbp,%rsi
               36:   add    $0xfffffffffffffeb8,%rsi
               3d:   movabs $0xffff975ac2607800,%rdi
    
        1.26   47: → callq  *ffffffffda6789e9
               4c:   cmp    $0x0,%rax
        2.43   50: → je     0
               52:   add    $0x38,%rax
        0.21   56:   xor    %r13d,%r13d
        0.81   59:   cmp    $0x0,%rax
               5d: → jne    0
               63:   mov    %rbp,%rdi
        2.22   66:   add    $0xfffffffffffffeb8,%rdi
        0.11   6d:   mov    $0x40,%esi
        0.32   72:   mov    %rbx,%rdx
        2.74   75: → callq  *ffffffffda658409
        0.22   7a:   mov    %rbp,%rsi
        1.69   7d:   add    $0xfffffffffffffec0,%rsi
               84:   movabs $0xffff975bfcd36000,%rdi
    
               8e:   add    $0xd0,%rdi
        0.21   95:   mov    0x0(%rsi),%eax
        0.93   98:   cmp    $0x200,%rax
               9f: → jae    0
        0.10   a1:   shl    $0x3,%rax
    
        0.11   a5:   add    %rdi,%rax
        0.11   a8: → jmp    0
               aa:   xor    %eax,%eax
        1.07   ac:   cmp    $0x0,%rax
               b0: → je     0
        6.57   b6:   movzbq 0x0(%rax),%rdi
    
               bb:   cmp    $0x0,%rdi
        0.95   bf: → je     0
               c5:   mov    $0x40,%r8d
               cb:   mov    -0x140(%rbp),%rdi
               d2:   cmp    $0x2,%rdi
               d6: → je     0
               d8:   cmp    $0x101,%rdi
               df: → je     0
               e1:   cmp    $0x15,%rdi
               e5: → jne    0
               e7:   mov    0x10(%rbx),%rdx
               eb: → jmp    0
               ed:   mov    0x18(%rbx),%rdx
               f1:   cmp    $0x0,%rdx
               f5: → je     0
               f7:   xor    %edi,%edi
               f9:   mov    %edi,-0x104(%rbp)
               ff:   mov    %rbp,%rdi
              102:   add    $0xffffffffffffff00,%rdi
              109:   mov    $0x100,%esi
              10e: → callq  *ffffffffda658499
              113:   mov    $0x148,%r8d
              119:   mov    %eax,-0x108(%rbp)
              11f:   mov    %rax,%rdi
              122:   shl    $0x20,%rdi
    
              126:   shr    $0x20,%rdi
    
              12a:   cmp    $0xff,%rdi
              131: → ja     0
              133:   add    $0x48,%rax
              137:   and    $0xff,%rax
              13d:   mov    %rax,%r8
              140:   mov    %rbp,%rcx
              143:   add    $0xfffffffffffffeb8,%rcx
              14a:   mov    %rbx,%rdi
              14d:   movabs $0xffff975fbd72d800,%rsi
    
              157:   mov    $0xffffffff,%edx
              15c: → callq  *ffffffffda658ad9
              161:   mov    %rax,%r13
              164:   mov    %r13,%rax
        0.72  167:   mov    0x0(%rbp),%rbx
              16b:   mov    0x8(%rbp),%r13
        1.16  16f:   mov    0x10(%rbp),%r14
        0.10  173:   mov    0x18(%rbp),%r15
        0.42  177:   add    $0x28,%rbp
        0.54  17b:   leaveq
        0.54  17c: ← retq
    
    Another cool way to test all this is to symple use 'perf top' look for
    those symbols, go there and press enter, annotate it live :-)
    
    Signed-off-by: Song Liu <songliubraving@fb.com>
    Reviewed-by: Jiri Olsa <jolsa@kernel.org>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Cc: Alexei Starovoitov <ast@kernel.org>
    Cc: Daniel Borkmann <daniel@iogearbox.net>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Stanislav Fomichev <sdf@google.com>
    Link: http://lkml.kernel.org/r/20190312053051.2690567-13-songliubraving@fb.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
