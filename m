Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC879C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CBE21A49
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbfKFOiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 09:38:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:26353 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731926AbfKFOiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:38:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 06:38:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="196226559"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.135])
  by orsmga008.jf.intel.com with ESMTP; 06 Nov 2019 06:38:21 -0800
Date:   Wed, 6 Nov 2019 22:45:48 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Dan Cross <dcross@google.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Subject: Re: [KVM] 671ddc700f: kvm-unit-tests.vmx.fail
Message-ID: <20191106144548.GA32541@xsang-OptiPlex-9020>
References: <20191030142358.GB6853@xsang-OptiPlex-9020>
 <CALMp9eQv4Qbx-6r5cxDXcari5jKNx6_tb9rgJa8X43ftVEOSbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eQv4Qbx-6r5cxDXcari5jKNx6_tb9rgJa8X43ftVEOSbw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 09:56:16AM -0700, Jim Mattson wrote:
> On Wed, Oct 30, 2019 at 7:16 AM kernel test robot <oliver.sang@intel.com> wrote:
> >
> > FYI, we noticed the following commit (built with gcc-7):
> >
> > commit: 671ddc700fd08b94967b1e2a937020e30c838609 ("KVM: nVMX: Don't leak L1 MMIO regions to L2")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > in testcase: kvm-unit-tests
> > with following parameters:
> >
> >         ucode: 0x27
> >
> >
> >
> > on test machine: 8 threads Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 8G memory
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> >
> >
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> >
> > 2019-10-29 16:17:51 ./run_tests.sh
> >  [32mPASS [0m apic-split (53 tests)
> >  [32mPASS [0m ioapic-split (19 tests)
> >  [32mPASS [0m apic (53 tests)
> >  [32mPASS [0m ioapic (19 tests)
> >  [32mPASS [0m smptest (1 tests)
> >  [32mPASS [0m smptest3 (1 tests)
> >  [32mPASS [0m vmexit_cpuid
> >  [32mPASS [0m vmexit_vmcall
> >  [32mPASS [0m vmexit_mov_from_cr8
> >  [32mPASS [0m vmexit_mov_to_cr8
> >  [32mPASS [0m vmexit_inl_pmtimer
> >  [32mPASS [0m vmexit_ipi
> >  [32mPASS [0m vmexit_ipi_halt
> >  [32mPASS [0m vmexit_ple_round_robin
> >  [32mPASS [0m vmexit_tscdeadline
> >  [32mPASS [0m vmexit_tscdeadline_immed
> >  [32mPASS [0m access
> >  [33mSKIP [0m smap (0 tests)
> >  [33mSKIP [0m pku (0 tests)
> >  [32mPASS [0m asyncpf (1 tests)
> >  [32mPASS [0m emulator (125 tests, 2 skipped)
> >  [32mPASS [0m eventinj (13 tests)
> >  [32mPASS [0m hypercall (2 tests)
> >  [32mPASS [0m idt_test (4 tests)
> >  [32mPASS [0m memory (8 tests)
> >  [32mPASS [0m msr (12 tests)
> >  [32mPASS [0m pmu (67 tests)
> >  [31mFAIL [0m vmware_backdoors (11 tests, 5 unexpected failures)
> >  [32mPASS [0m port80
> >  [32mPASS [0m realmode
> >  [32mPASS [0m s3
> >  [32mPASS [0m sieve
> >  [32mPASS [0m syscall (2 tests)
> >  [32mPASS [0m tsc (3 tests)
> >  [32mPASS [0m tsc_adjust (5 tests)
> >  [32mPASS [0m xsave (17 tests)
> >  [32mPASS [0m rmap_chain
> >  [33mSKIP [0m svm (0 tests)
> >  [33mSKIP [0m taskswitch (i386 only)
> >  [33mSKIP [0m taskswitch2 (i386 only)
> >  [32mPASS [0m kvmclock_test
> >  [32mPASS [0m pcid (3 tests)
> >  [32mPASS [0m rdpru (1 tests)
> >  [32mPASS [0m umip (21 tests)
> >  [31mFAIL [0m vmx (timeout; duration=90s)
> >  [33mSKIP [0m ept (0 tests)
> >  [33mSKIP [0m vmx_eoi_bitmap_ioapic_scan (1 tests, 1 skipped)
> >  [33mSKIP [0m vmx_hlt_with_rvi_test (1 tests, 1 skipped)
> >  [33mSKIP [0m vmx_apicv_test (2 tests, 2 skipped)
> >  [32mPASS [0m vmx_apic_passthrough_thread (8 tests)
> >  [32mPASS [0m vmx_init_signal_test (8 tests)
> >  [32mPASS [0m vmx_vmcs_shadow_test (142218 tests)
> >  [32mPASS [0m debug (11 tests)
> >  [32mPASS [0m hyperv_synic (1 tests)
> >  [33mSKIP [0m hyperv_connections (1 tests, 1 skipped)
> >  [32mPASS [0m hyperv_stimer (12 tests)
> >  [32mPASS [0m hyperv_clock
> >  [32mPASS [0m intel_iommu (11 tests)
> >
> >
> >
> > To reproduce:
> >
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp install job.yaml  # job file is attached in this email
> >         bin/lkp run     job.yaml
> >
> >
> >
> > Thanks,
> > Oliver Sang
> 
> It's unclear to me what the delta is, but I do see that the 'vmx'
> suite has failed. That is to be expected if you're getting your
> kvm-unit-tests from the 'master' branch of the kvm-unit-tests repo.
> You will need commit 591b5b54bba1 ("x86: Skip APIC-access address
> tests beyond mapped RAM"), which is in the 'next' branch of the
> kvm-unit-tests repo, but which has not yet made it to the 'master'
> branch.

Thanks for information! We will wait for master upgrade to update our test binary.

