Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95769C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA722081C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="iGZm5JJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfE1OO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 10:14:28 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36158 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfE1OO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 10:14:28 -0400
Received: by mail-vs1-f65.google.com with SMTP id l20so193809vsp.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 07:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=yycQnruD0ZJD8cM+b1TzxdPNaekN7XdcTOe1/yw98l4=;
        b=iGZm5JJcLX6eDDl+1tiMIqYvqnFnLPBmkC2Rd37zLaMaEzM86s3s0eAZ9wGH0kCK/B
         pIfsYVKQEGf8Ivjb32oEm3jr3+NocFrs2HSrubPpg2zDbaygg6jLzCQXpfKgQ3xp9tnf
         fXnJ8GfIrv3v/E57X5MX1wu+/Ka0qKkebhAOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=yycQnruD0ZJD8cM+b1TzxdPNaekN7XdcTOe1/yw98l4=;
        b=ctZbG+T12TVrmric+4MYtnbshcXw/Z9FnhpZ6l+lnTFKzcDj+5AyVCatamD8flEKnZ
         Zf7GieLY7KXc+YTTGqgVkiM68sESV56ecvuOe+rJ2LDC7li4Z7wbog7exOxW4UYRQQWw
         hLc9x2EJHj7vixnvfV6+Cpl09k14pw4uj3NzIDCgLmepDFa8tv0uy3XXHVoY+rNQZlJG
         LENWdd3wTDnLY6pd5oKKWvqIc+Jo+pK1e5pJgqH4S7m6tzMz0VUdC35/FCpKA/zgT34o
         TkMag3+9JiG6cUgZzWUD8jeGf0d43+bSSYkHorPBizb3YF1NgrTVEbNyVtbkrT+rQFM1
         qK+A==
X-Gm-Message-State: APjAAAU/SrftVdjSBVVIVVjVLYNBjgPUPr+p/OJASvS17a8Y/zPVakOp
        j7BPzPQD7O8Xem+A2TZHBizH7w==
X-Google-Smtp-Source: APXvYqzW7/jbRfPG5SJryxPeKGOtAccFynbM0bNMz4XIg5K7dKvf33D95PpTnGVLG/sszVJduOL+aw==
X-Received: by 2002:a67:8d03:: with SMTP id p3mr17528012vsd.190.1559052866512;
        Tue, 28 May 2019 07:14:26 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id b78sm5162917vkb.10.2019.05.28.07.14.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 28 May 2019 07:14:25 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Tue, 28 May 2019 10:14:21 -0400 (EDT)
X-X-Sender: vince@macbook-air
To:     Peter Zijlstra <peterz@infradead.org>
cc:     "Liang, Kan" <kan.liang@linux.intel.com>, mingo@kernel.org,
        acme@redhat.com, vincent.weaver@maine.edu,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com, jolsa@redhat.com, eranian@google.com
Subject: Re: [PATCH V2 1/3] perf/x86: Disable non generic regs for software/probe
 events
In-Reply-To: <20190528140518.GU2623@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1905281012260.21972@macbook-air>
References: <1558984077-7773-1-git-send-email-kan.liang@linux.intel.com> <20190528085601.GL2623@hirez.programming.kicks-ass.net> <7c8d8998-4722-e059-d378-b8517193e32f@linux.intel.com> <20190528140518.GU2623@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019, Peter Zijlstra wrote:

> On Tue, May 28, 2019 at 09:33:40AM -0400, Liang, Kan wrote:
> > Uncore PMU doesn't support sampling. It will return -EINVAL.
> > There is no regs support for counting. The request will be ignored.
> > 
> > I think current check for uncore is good enough.
> 
> breakpoints then.. There's also no guarantee you covered all software
> events, and the core rewrite will allow other per-task/sampling PMUs
> too.

possibly related, even with the patches applied, the skylake machine 
eventually did still crash while fuzzing:

[133621.333101] BUG: unable to handle page fault for address: 00000001000000c8
[133621.333102] #PF: supervisor read access in kernel mode
[133621.333103] #PF: error_code(0x0000) - not-present page
[133621.333104] PGD 0 P4D 0 
[133621.333106] Oops: 0000 [#1] SMP PTI
[133621.333108] CPU: 4 PID: 22203 Comm: perf_fuzzer Tainted: G        W         5.2.0-rc1+ #39
[133621.333109] Hardware name: LENOVO 10FY0017US/SKYBAY, BIOS FWKT53A   06/06/2016
[133621.333109] RIP: 0010:perf_reg_value+0x1e/0x50
[133621.333111] Code: 00 48 b8 00 00 00 00 ff ff ff ff c3 0f 1f 44 00 00 8d 46 e0 83 f8 1f 77 1d 48 8b 97 a8 00 00 00 31 c0 48 85 d2 74 0e 48 63 f6 <48> 8b 84 f2 00 ff ff ff c3 31 c0 c3 83 fe 17 77 16 48 63 f6 8b 04
[133621.333112] RSP: 0000:fffffe00000d5a80 EFLAGS: 00010006
[133621.333113] RAX: 0000000000000000 RBX: 0000000000000039 RCX: 0000000000000039
[133621.333114] RDX: 0000000100000000 RSI: 0000000000000039 RDI: fffffe00000d5c88
[133621.333115] RBP: fffffe00000d5b38 R08: 0000000000000000 R09: 0000000000000000
[133621.333116] R10: 00000000bffffff0 R11: 0000000000000012 R12: fffffe00000d5c88
[133621.333117] R13: ffff99883253ed10 R14: 0000000000000050 R15: 0000000000000000
[133621.333118] FS:  00007fb9741d3540(0000) GS:ffff998835b00000(0000) knlGS:0000000000000000
[133621.333119] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[133621.333119] CR2: 00000001000000c8 CR3: 000000023333c004 CR4: 00000000003607e0
[133621.333120] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[133621.333121] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
[133621.333122] Call Trace:
[133621.333122]  <NMI>
[133621.333123]  perf_output_sample_regs+0x43/0xa0
[133621.333124]  perf_output_sample+0x3aa/0x7a0
[133621.333125]  perf_event_output_forward+0x53/0x80
[133621.333125]  __perf_event_overflow+0x52/0xf0
[133621.333126]  handle_pmi_common+0x1b3/0x240
[133621.333127]  ? visit_groups_merge+0xeb/0x180
[133621.333127]  ? native_write_msr+0xb/0x20
[133621.333128]  ? native_write_msr+0x1a/0x20
[133621.333129]  ? native_write_msr+0xc/0x20
[133621.333129]  ? intel_pmu_lbr_read+0x29f/0x3d0
[133621.333130]  ? intel_pmu_lbr_filter+0x7f/0x1f0
[133621.333131]  intel_pmu_handle_irq+0xbf/0x160
[133621.333132]  perf_event_nmi_handler+0x2d/0x50
[133621.333132]  nmi_handle+0x63/0x110
[133621.333133]  default_do_nmi+0x4e/0x100
[133621.333134]  do_nmi+0x14d/0x1b0
[133621.333134]  end_repeat_nmi+0x16/0x50
[133621.333135] RIP: 0010:visit_groups_merge+0xeb/0x180
[133621.333137] Code: c0 75 73 48 8d 7b 30 e8 c3 de 55 00 48 85 c0 0f 84 9a 00 00 00 48 89 c2 48 83 ea 30 74 10 8b b3 74 02 00 00 39 b0 44 02 00 00 <49> 0f 45 d7 48 89 55 00 48 8b 04 24 48 8b 5c 24 08 48 85 c0 48 89
[133621.333137] RSP: 0000:ffffb28f4c897e10 EFLAGS: 00000046
[133621.333139] RAX: ffff998833315830 RBX: ffff99882a17a000 RCX: 0000000000000001
[133621.333140] RDX: ffff998833315800 RSI: 0000000000000004 RDI: ffff99882a17a030
[133621.333140] RBP: ffffb28f4c897e18 R08: 0000000000000000 R09: ffff998835b26a80
[133621.333141] R10: ffff99882a17a000 R11: 0000000000000001 R12: ffffffffb6bb93b0
[133621.333142] R13: ffffb28f4c897e68 R14: ffffb28f4c897e10 R15: 0000000000000000
[133621.333143]  ? __perf_event_disable+0x160/0x160
[133621.333144]  ? visit_groups_merge+0xeb/0x180
[133621.333144]  ? visit_groups_merge+0xeb/0x180
[133621.333145]  </NMI>
[133621.333145]  ctx_sched_in+0xb7/0x180
[133621.333146]  __perf_event_task_sched_in+0x16e/0x1c0
[133621.333147]  ? __switch_to_asm+0x40/0x70
[133621.333147]  ? __switch_to_asm+0x34/0x70
[133621.333148]  ? __switch_to_asm+0x40/0x70
[133621.333149]  ? __switch_to_asm+0x34/0x70
[133621.333149]  finish_task_switch+0xcd/0x270
[133621.333150]  schedule_tail+0xb/0x50
[133621.333151]  ret_from_fork+0x8/0x40
[133621.333151] Modules linked in: intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp kvm irqbypass snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic crct10dif_pclmul crc32_pclmul ledtrig_audio ghash_clmulni_intel snd_hda_intel snd_hda_codec aesni_intel snd_hda_core aes_x86_64 crypto_simd snd_hwdep cryptd snd_pcm mei_me glue_helper snd_timer snd sg mei iTCO_wdt iTCO_vendor_support soundcore wmi_bmof tpm_tis evdev tpm_tis_core acpi_pad tpm rng_core pcspkr pcc_cpufreq fuse parport_pc sunrpc ppdev lp parport ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2 sr_mod sd_mod cdrom i915 i2c_algo_bit ahci libahci crc32c_intel xhci_pci libata drm_kms_helper i2c_i801 xhci_hcd e1000e drm scsi_mod usbcore fan thermal wmi video button
[133621.333183] CR2: 00000001000000c8
[133621.743913] ---[ end trace 7a151c3de6b000fc ]---
[133621.743913] RIP: 0010:perf_reg_value+0x1e/0x50
[133621.743913] Code: 00 48 b8 00 00 00 00 ff ff ff ff c3 0f 1f 44 00 00 8d 46 e0 83 f8 1f 77 1d 48 8b 97 a8 00 00 00 31 c0 48 85 d2 74 0e 48 63 f6 <48> 8b 84 f2 00 ff ff ff c3 31 c0 c3 83 fe 17 77 16 48 63 f6 8b 04
[133621.743913] RSP: 0000:fffffe00000d5a80 EFLAGS: 00010006
[133621.743914] RAX: 0000000000000000 RBX: 0000000000000039 RCX: 0000000000000039
[133621.743914] RDX: 0000000100000000 RSI: 0000000000000039 RDI: fffffe00000d5c88
[133621.743914] RBP: fffffe00000d5b38 R08: 0000000000000000 R09: 0000000000000000
[133621.743914] R10: 00000000bffffff0 R11: 0000000000000012 R12: fffffe00000d5c88
[133621.743915] R13: ffff99883253ed10 R14: 0000000000000050 R15: 0000000000000000
[133621.743915] FS:  00007fb9741d3540(0000) GS:ffff998835b00000(0000) knlGS:0000000000000000
[133621.743915] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[133621.743915] CR2: 00000001000000c8 CR3: 000000023333c004 CR4: 00000000003607e0
[133621.743915] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[133621.743916] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
[133621.743916] Kernel panic - not syncing: Fatal exception in interrupt
[133622.777346] Shutting down cpus with NMI
[133622.777347] Kernel Offset: 0x35a00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
