Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AA8C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A618720578
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfH1JAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 05:00:22 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36511 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfH1JAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:00:22 -0400
Received: by mail-qk1-f193.google.com with SMTP id d23so1743674qko.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 02:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OUW305HffLjg7EH9ex82HE6wB5d1znsqD2HU0SvH2s0=;
        b=PVkZBNwLn1A4IJIg0z1hVTbo3Z5N3996Uj+L7RVlU3nwxYykXl5vE1+8ArwEyXBXwq
         OPW544TeT/E7TUi/NpnAH+8DUPw8cEPIBDfSWIFFwmNP7MFqirsO/toCwWBs6UFz1aYp
         ZvIY7i7js8RhMjTtin7a2JgkaIQC6fGwTtoaYkBBFgBS8C+euPT7F/LMfkHiW6vtGBTG
         0Z1RJVZdHZhz9c1Q/XxBVoMCZSQ4NJpQ5nS5m3dYkvs18wruF2n+v6ow+Jp+yPqzGmO+
         Uazx0T72mKiHTCu3FpHYntjSAnaScjt9vIpRCMKFIdvOvSE7j0lgRPdahQQNhMIHggz+
         LRaQ==
X-Gm-Message-State: APjAAAWE5APCQaEvHBOA8+NHOkPqfsJYKQ5bNr13+mP0IjzFSOITNVIG
        lL4o+VGAPI7KXnwqxcKptCj4wu2X3R01Bf03/es=
X-Google-Smtp-Source: APXvYqwJOO5I6fF0gr0PYLpYbF/QjxnD+oXCLd1PTBJE1DhdcFGD7pr1erRfXbytnjpGkfq6UNoGb5uQ+ANVrydrN3g=
X-Received: by 2002:a37:4b0d:: with SMTP id y13mr2720341qka.3.1566982821079;
 Wed, 28 Aug 2019 02:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3G=GCpLtNztuoLR4BuugAB=zpa_Jrz5BSft6Yj-nok1g@mail.gmail.com>
 <20190827145102.p7lmkpytf3mngxbj@treble> <CAHFW8PRsmmCR6TWoXpQ9gyTA7azX9YOerPErCMggcQX-=fAqng@mail.gmail.com>
 <CAK8P3a2TeaMc_tWzzjuqO-eQjZwJdpbR1yH8yzSQbbVKdWCwSg@mail.gmail.com>
 <20190827192255.wbyn732llzckmqmq@treble> <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
 <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com>
In-Reply-To: <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 28 Aug 2019 11:00:04 +0200
Message-ID: <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 11:22 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> On Tue, Aug 27, 2019 at 12:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Aug 27, 2019 at 9:23 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > > On Tue, Aug 27, 2019 at 09:00:52PM +0200, Arnd Bergmann wrote:
> > > > On Tue, Aug 27, 2019 at 5:00 PM Ilie Halip <ilie.halip@gmail.com> wrote:
> Thanks for the description of the issue and the reduced test case.  It
> almost reminds me of
> https://github.com/ClangBuiltLinux/linux/issues/612.
>
> I've filed https://bugs.llvm.org/show_bug.cgi?id=43128, anything I
> should add to the bug report?

I tried the suggestion to add

diff --git a/Makefile b/Makefile
index 1b23f95db176..97f7bc4c9b4e 100644
--- a/Makefile
+++ b/Makefile
@@ -755,7 +755,7 @@ endif

 KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
 ifdef CONFIG_FRAME_POINTER
-KBUILD_CFLAGS  += -fno-omit-frame-pointer -fno-optimize-sibling-calls
+KBUILD_CFLAGS  += -fno-omit-frame-pointer -fno-optimize-sibling-calls
$(call cc-option, -mno-omit-leaf-frame-pointer)
 else
 # Some targets (ARM with Thumb2, for example), can't be built with frame
 # pointers.  For those, we don't have FUNCTION_TRACER automatically

from https://bugs.llvm.org/show_bug.cgi?id=43128, this avoids all the
"uses BP as a scratch register" warnings as well as almost all the "call without
frame pointer save/setup" warnings I also saw.

Only a few unique objtool warnings remain now, here are the ones I
currently see,
along with .config files. Let me know which ones I should investigate further,
I assume a lot of these are known issues:

http://paste.ubuntu.com/p/XjdDsypRxX/
0x5BA1B7A1:arch/x86/ia32/ia32_signal.o: warning: objtool:
ia32_setup_rt_frame()+0x238: call to memset() with UACCESS enabled
0x5BA1B7A1:arch/x86/kernel/signal.o: warning: objtool:
__setup_rt_frame()+0x5b8: call to memset() with UACCESS enabled
0x5BA1B7A1:mm/kasan/common.o: warning: objtool: kasan_report()+0x44:
call to __stack_chk_fail() with UACCESS enabled
0x5BA1B7A1:kernel/trace/trace_selftest_dynamic.o: warning: objtool:
__llvm_gcov_writeout()+0x13: call without frame pointer save/setup
0x5BA1B7A1:kernel/trace/trace_selftest_dynamic.o: warning: objtool:
__llvm_gcov_flush()+0x0: call without frame pointer save/setup
0x5BA1B7A1:kernel/trace/trace_clock.o: warning: objtool:
__llvm_gcov_writeout()+0x14: call without frame pointer save/setup
0x5BA1B7A1:kernel/trace/trace_clock.o: warning: objtool:
__llvm_gcov_flush()+0x0: call without frame pointer save/setup
0x5BA1B7A1:kernel/trace/*: # many more of the same, all in this directory
0x5BA1B7A1:kernel/trace/trace_uprobe.o: warning: objtool:
__llvm_gcov_flush()+0x0: call without frame pointer save/setup

http://paste.ubuntu.com/p/PyYNBK5Yx2/
0xC1CF60CC:arch/x86/ia32/ia32_signal.o: warning: objtool:
ia32_setup_rt_frame()+0x205: call to memset() with UACCESS enabled
0xC1CF60CC:arch/x86/kernel/signal.o: warning: objtool:
__setup_rt_frame()+0x597: call to memset() with UACCESS enabled
0xC1CF60CC:arch/x86/kernel/process.o: warning: objtool:
play_dead()+0x3: unreachable instruction
0xC1CF60CC:mm/kasan/common.o: warning: objtool: kasan_report()+0x52:
call to __stack_chk_fail() with UACCESS enabled
0xC1CF60CC:kernel/sched/idle.o: warning: objtool:
switched_to_idle()+0x3: unreachable instruction
0xC1CF60CC:mm/madvise.o: warning: objtool: hugepage_madvise()+0x3:
unreachable instruction
0xC1CF60CC:mm/hugetlb.o: warning: objtool: hugetlb_vm_op_fault()+0x3:
unreachable instruction
0xC1CF60CC:kernel/exit.o: warning: objtool: abort()+0x3: unreachable instruction
0xC1CF60CC:fs/hugetlbfs/inode.o: warning: objtool:
hugetlbfs_write_end()+0x3: unreachable instruction
0xC1CF60CC:fs/xfs/xfs_super.o: warning: objtool:
xfs_fs_alloc_inode()+0x3: unreachable instruction
0xC1CF60CC:drivers/mtd/nand/raw/nand_base.o: warning: objtool:
nand_read_oob()+0x18d4: unreachable instruction

http://paste.ubuntu.com/p/xCXyJR4Gx6/
0x99965895:arch/x86/ia32/ia32_signal.o: warning: objtool:
ia32_setup_rt_frame()+0x1f5: call to memset() with UACCESS enabled
0x99965895:arch/x86/kernel/signal.o: warning: objtool:
__setup_rt_frame()+0x57f: call to memset() with UACCESS enabled
0x99965895:drivers/pinctrl/pinctrl-ingenic.o: warning: objtool:
ingenic_pinconf_set()+0x10d: sibling call from callable instruction
with modified stack frame

http://paste.ubuntu.com/p/SFQXxh6zvy/
0x9278DEDC:drivers/media/dvb-frontends/cxd2880/cxd2880_tnrdmd_dvbt2.o:
warning: objtool: x_tune_dvbt2_demod_setting()+0x7f6: can't find
switch jump table
0x9278DEDC:net/xfrm/xfrm_output.o: warning: objtool:
xfrm_outer_mode_output()+0x109: unreachable instruction
0x9278DEDC:net/xfrm/xfrm_output.o: warning: objtool:
xfrm_outer_mode_output()+0x109: unreachable instruction

http://paste.ubuntu.com/p/9jW8yR6Tph/
0xE872D410:kernel/trace/trace_branch.o: warning: objtool:
ftrace_likely_update()+0x6c: call to __stack_chk_fail() with UACCESS
enabled
0xE872D410:drivers/hwmon/pmbus/adm1275.o: warning: objtool:
adm1275_probe()+0x756: unreachable instruction

http://paste.ubuntu.com/p/qg4bxZbxwq/
0xA833B0C9:drivers/gpu/drm/amd/amdgpu/atom.o: warning: objtool:
atom_op_move() falls through to next function atom_op_and()
0xA833B0C9:drivers/gpu/drm/i915/display/intel_combo_phy.o: warning:
objtool: cnl_set_procmon_ref_values()+0x125: can't find switch jump
table
0xA833B0C9:drivers/gpu/drm/radeon/atom.o: warning: objtool:
atom_op_move() falls through to next function atom_op_and()
0xA833B0C9:drivers/gpu/drm/radeon/evergreen_cs.o: warning: objtool:
evergreen_cs_parse() falls through to next function
evergreen_dma_cs_parse()

http://paste.ubuntu.com/p/W3nq9bSHHZ/
0xFBCA4E34:drivers/gpu/drm/amd/amdgpu/atom.o: warning: objtool:
atom_op_move() falls through to next function atom_op_and()
0xFBCA4E34:drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_opp_csc_v.o:
warning: objtool: dce110_opp_v_set_csc_default()+0x2bc: can't find
switch jump table
0xFBCA4E34:drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.o:
warning: objtool: dce_mem_input_v_program_pte_vm()+0x27f: can't find
switch jump table
