Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48E7C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7680B206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=serhei.io header.i=@serhei.io header.b="j/iK/Jsr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BIxOz+2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfEGVLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 17:11:25 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41135 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727209AbfEGVLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 17:11:25 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 15AB422E6B;
        Tue,  7 May 2019 17:11:24 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Tue, 07 May 2019 17:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serhei.io; h=
        mime-version:message-id:date:from:to:cc:subject:content-type; s=
        fm1; bh=yPJ+Nwe/PIIiecmLmSS6mO5e5JH49mkAaPW0jrEfCYg=; b=j/iK/Jsr
        oLjex0bwOSaEvflTfulA+GLXQeT9jWg58KDB7AAvUBB2IZAby5I+DBUKlscfBBtR
        W61uS+Szm2lGJ9qY6VCJCjKQ/dfty/OIvcYEQbj3x7F2CJ7AyAgy7Le1ZFxCrHXg
        O+rDyhfPHSSgbXoxGwUZy79yxBbezZdcIcElFOcpnZuVg9fp9271oAlqhzPM0YIB
        DVSsyWXZ4MDahWh6T0DG0cAWRjkIuYPUoXyC7iMdKVRFB2UwM7lJV1WpBMKZShAw
        tiIncsJuBDuPnlz5wXaETL5misSj7v4tXBd5w8VvA6sawDsFnYeyTg2CwQ6jROK+
        Uh/XbGlsGLGzhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=yPJ+Nwe/PIIiecmLmSS6mO5e5JH49
        mkAaPW0jrEfCYg=; b=BIxOz+2xbL9z4HvElUsXYFysuJ0o3Zv9/nTH1HmFvBwBA
        Hpg7rXdlOIWr1tbdvHs1M633iRLMYbccMIfVioc16jqQiTWC1i9zkj5NNsMZ/X3+
        BH7nupLVRw8mnnwPwYfgqiv0GCjNpi27Cf5A0DwdgkoLkzlvLCukAy5+tvXQtgAT
        uJkIPtZ9Uj/rhAl8XKOk4I7W3HV+uP0PoeWDb4FsxZ1NdfN2vCFTWmXGyJ+WFhkf
        ZhI+pKoC8ikgHNfN+IIR70WPjnGrA4f2T+7QPATtOGbe8Y5UkG6YH4Da3vPawgsi
        jLThetQ6T4P68knaTu865fnLr66FzLMecUQlHVyUA==
X-ME-Sender: <xms:e_TRXGJ_d8F0D66JXxrKuJBFcswGxo8aqEcAyNs6KQhqXjgjYADqfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrkedtgdduieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfufgvrhhhvghiucforghkrghrohhvfdcuoehmvgesshgvrhhh
    vghirdhioheqnecuffhomhgrihhnpehsohhurhgtvgifrghrvgdrohhrghdpfhgvughorh
    grphhrohhjvggtthdrohhrghenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehsvghr
    hhgvihdrihhonecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:e_TRXAAmAA8nlCDOF9skY1a57kmEJc0mq-rIXM_xQzNMXVYqZzGEgg>
    <xmx:e_TRXAE0WexaPlfP-ebIbDtKXC5qqVwnUiP3QWzfdT4EzAHeiDaCeQ>
    <xmx:e_TRXE7iPF55iC8Z0ZB3jylUKfaKAdoaRgqQEN2T5s5m_ufMxw6mwg>
    <xmx:fPTRXF4tI6od1ECfrX_68drqntv6EH9wr-01pcNrZI9xfob2vCOh1g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 64CB07C3DB; Tue,  7 May 2019 17:11:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-449-gfb3fc5a-fmstable-20190430v1
Mime-Version: 1.0
Message-Id: <c91e217c-3caa-4f9d-be22-6d59753278b5@www.fastmail.com>
Date:   Tue, 07 May 2019 17:11:06 -0400
From:   "Serhei Makarov" <me@serhei.io>
To:     systemtap@sourceware.org
Cc:     linux-kernel@vger.kernel.org, lwn@lwn.net
Subject: systemtap 4.1 release
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SystemTap team announces release 4.1!

stapbpf transport improvements and string tapset functions, translator pass-2
performance improvements, @thisN macros provide alternative to @entry mechanism,
preview of stapbpf statistics aggregate functionality

= Where to get it

  https://sourceware.org/systemtap/ - our project page
  https://sourceware.org/systemtap/ftp/releases/
  https://koji.fedoraproject.org/koji/packageinfo?packageID=615
  git tag release-4.1 (commit 984d6d1696ed06626b07cb65ab55d6ae0ece1131)

  There have been over 210 commits since the last release.
  There have 28+ bugs fixed / features added since the last release.


= SystemTap frontend (stap) changes

- New macros @this1, ..., @this8 have been added to the script language.
  The macros can be used to save values in entry probes and later retrieve
  them in return probes. This can be used in instances where @entry does
  not work. For example:

     probe tp_syscall.read {
         @this1 = buf_uaddr
     }

     probe tp_syscall.read.return {
         buf_uaddr = @this1
         printf("%s", user_string(buf_uaddr))
     }

- Operator @var() no longer assumes @entry() in return probes.
  The old behavior can be restored by the '--compatible 4.0' option.

= SystemTap backend changes

- Runtime/tapsets were ported to include up to kernel version 5.1-rc2

- The translator's pass-2 (elaboration) phase has been dramatically
  accelerated by eschewing processing of unreferenced parts of the
  tapset and embedded-C code.

- A new stapbpf transport layer has been implemented based on perf_events
  infrastructure. This transport layer removes some limitations on strings
  and printf() that were previously imposed by BPF's trace_printk() mechanism:
  - It is now possible to use format-width specifiers in printf().
  - It is now possible to use more than three format specifiers in printf().
  - It is now possible to use multiple '%s' format specifiers in printf().
  - Using stapbpf should no longer trigger a trace_printk()-associated
    warning on dmesg.

- In the stapbpf backend, foreach() now supports iteration of arrays
  with string keys.

- A preview version of statistical aggregate functionality for stapbpf
  is now included. For now, in the stapbpf backend, aggregates only
  support @count(), @sum() and @avg() operations.

- Added support for unhandled DWARF operator DW_OP_GNU_parameter_ref in
  location expressions for target symbols.

- Where available (kernel 4.15+), the kernel-module runtime now uses
  the kernel-provided ktime_get_real_fast_ns() mechanism for timekeeping
  rather than the SystemTap runtime's own timekeeping machinery.

= SystemTap tapset changes

- New stapbpf tapset task.stp with function task_current.

- New stapbpf tapset functions kernel_string, kernel_string_n,
  execname, ktime_get_ns.

- Numerous improvements to tapset support for ARM architectures.

- Added prometheus_dump_*_unquoted versions of prometheus_dump_*
  to allow dumping JSON-valid data without redundant quoting.

= SystemTap sample scripts

All 180+ examples can be found at https://sourceware.org/systemtap/examples/

- Numerous changes to existing examples to improve performance, mostly
  by using statistical aggregates instead of ordinary variables where possible.

- Numerous changes to existing examples to improve compatibility with
  recent kernel versions.

- Numerous changes to existing examples to use @this1, ..., @this8 macros
  instead of @entry mechanism.

- New sample script:

ucalls.stp       Profile method invocations in Java, Perl, Php, Python, Ruby, and Tcl

- New stapbpf sample script, with thanks to David Valin:

cachestat.stp    Monitors hits and misses to the page cache
                 and reports a count every 5 seconds.

= Examples of tested kernel versions

2.6.32 (RHEL6 x86_64, i686)
3.10.0 (RHEL7 x86_64)
4.15.0 (Ubuntu 18.04 x86_64)
4.20 (Fedora 29 aarch64)
5.0 (Ubuntu 16.04.6 aarch64)
5.0.7 (Fedora 29 x86_64)
5.0.9 (Fedora 28 i686)
5.1.0-rc2 (Fedora Rawhide x86_64, but see BPF caveat below!)

= Known issues with this release

- Some kernel crashes continue to be reported when a script probes
  broad kernel function wildcards.  (PR2725)

- An upstream kernel commit #2062afb4f804a put "-fno-var-tracking-assignments"
  into KCFLAGS, dramatically reducing debuginfo quality, which can cause
  debuginfo failures. The simplest fix is to erase, excise, nay, eradicate
  this line from the top level linux Makefile:

  KBUILD_CFLAGS   += $(call cc-option, -fno-var-tracking-assignments)

- BPF interpreters in recent Fedora rawhide kernels (version 5.1.0-0.rc7.git1.1.fc31) 
  were found to contain a kernel-panic-triggering bug (RHBZ1706102) that can
  be elicited by stapbpf. Until this is fixed, take care when running BPF programs
  on very recent kernels. (5.1 and later)

= Coming soon

- More stapbpf functionality including full statistics aggregate support

= Contributors for this release

*David Ward, Frank Ch. Eigler, *Hou Tao, Jafeer Uddin,
Mark Wielaard, Martin Cermak, Peter Robinson, Serhei Makarov,
Stan Cox, Torsten Polle, Victor Kamensky, William Cohen,
Yichun Zhang (agentzh)

Special thanks to new contributors, marked with '*' above.

Special thanks to Serhei for assembling these notes.

= Bugs fixed for this release <https://sourceware.org/PR#####>

14689 missing 'syscalls' tracepoints 
16596 Support DW_OP_GNU_entry_value in location expressions 
21080 support needed for new pkey_* syscalls 
22330 bpf: generate printf via event tuples, userspace formatting postprocessing 
23074 unhandled DW_OP operation in DWARF expression (DW_OP_GNU_parameter_ref) 
23391 support {,foo,bar} alternation in wildcards 
23435 stapbpf transport layer can swallow a message before exit() 
23474 bpf kernel_string(), user_string() tapset 
23507 Need a command-line option to disable the automatic (unread) global variable display 
23747 Unknown  section .note.Linux in kernel module cause tests with --all-modules to fail to compile 
23761 generalized @entry 
23775 Pass 2 failed when generate a kernel module for stap script which uses kernel trace-point 
23799 sprint_ustack() returns empty strings while sprint_ubacktrace() does not 
23816 printf with multiple %s does not work on bpf 
23860 unknown opcode 0x8f in string manipulation code 
23875 support string map keys in foreach iteration 
23890 on f29 and later, elf segment/plt rearrangement leads to buildid verification errors 
23891 stap and stapio process are stuck in signal processor and could not terminate properly 
23894 SystemTap_Beginners_Guide: -ldd should be --ldd 
24199 misleading error when providing wrong printf format for pid(). 
24217 pass-2 sloth in probe condition-expression analysis 
24224 tapsets.cxx kernel relocation assert fails when attempting to access some function parameters 
24239 during elaboration pass, avoid unnecessary sym/type resolution of functions/globals not known to be needed 
24327  @defined unable to handle $$parms and $$vars meta variables 
24329 bpf userspace: consecutive map string lookups overwrite each other 
24363 Slow pass 2 due to varuse_collecting_visitor::visit_embeddedcode() 
24408 using @kregister(0) in kernel tracepoint probe handler will cause a kernel crash on linux 5.x.x kernel 
24416 Tests stuck in uprobes_onthefly.exp 

