Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB413CA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F89C2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uwsWF08I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfJ3Q43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:56:29 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:39720 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfJ3Q43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:56:29 -0400
Received: by mail-io1-f51.google.com with SMTP id 18so3350262ion.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 09:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSpmawBarbqhnPciRCHob+Ubj7vDm18R/O6y6DK5PxM=;
        b=uwsWF08IAZwQ14BkrU9tIaTBJznjqAf/Iwph9uYqbrahm7sYb6EhsYZpzy3JPHRlHa
         NalOvuvillKIVTXXx1TgtHES5kZKu8yFcd6FD311Wr0ja2FMAidA8l4hbcIHLxSWNztQ
         VdaC6QotLQpTXXFBSdTnkNMt2DnqrkYBV2Ej77rsth/JOajLgm95LnmUWWYBfqgnp72t
         KlPUhFpsyEhU11tjiqMjG5Su3idDofKpNI6XlSwTbPZUhS4/8T8tKqHWPzSK8hUJvzK3
         NHElwAQ+2Zx7A8/yKfWeCl5xc32E4TQe7ZEzjEfAxh2P/SkiB1DtIQKqEUTSffaS3gDY
         ocrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSpmawBarbqhnPciRCHob+Ubj7vDm18R/O6y6DK5PxM=;
        b=asS3swwDq9VEePUXGvfJDRDgAtg54SoJbvPdBU/lIvAY0M8xhsklqA/qmIyiuzFCVY
         6dZQMiOQqK2MH1Dm/l+BCq+pm7PjEDuqt6VN80m6IabWGMCwMmnlp5/L70YJkHKzE5IY
         2U8SnbK7QYiC3VO3tuXkawbrgxR6A1Z+SDCyEVU5iNyASAY4d6Xwy7OFGPRg+JJ+EK+o
         tNIFkB62tJfLQ8Ale0mOUchhG/ljB5JKU3OQ9K8GoNmaXGIzmYyZscVejpUiTg6nFKvF
         FW6pkuWbBlFQLI/cwEUPYLvjY4G7+wLbPKpeewRS3pCQQSeXuDMYJ2TfbhPu5NgPcAgR
         RUOg==
X-Gm-Message-State: APjAAAXpGzRiXvg+qewhv4tLo+0NJ+dV+MrYSiWy3qvmrLg0JxYuW6Jx
        FKJfKRRQe4P183Mzp7QWxr+nsOzLUE9YJzn2Ipk+RQ==
X-Google-Smtp-Source: APXvYqzzZhgTbtaSooTkKMRp0RLu20sJAejAcM43OqOKPzCGw+vfk0ZlMBCLk+RQ7IG7sCoXWe+85WzD/1wdwrpU6qg=
X-Received: by 2002:a6b:ee07:: with SMTP id i7mr833488ioh.26.1572454587405;
 Wed, 30 Oct 2019 09:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191030142358.GB6853@xsang-OptiPlex-9020>
In-Reply-To: <20191030142358.GB6853@xsang-OptiPlex-9020>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 30 Oct 2019 09:56:16 -0700
Message-ID: <CALMp9eQv4Qbx-6r5cxDXcari5jKNx6_tb9rgJa8X43ftVEOSbw@mail.gmail.com>
Subject: Re: [KVM] 671ddc700f: kvm-unit-tests.vmx.fail
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Dan Cross <dcross@google.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 7:16 AM kernel test robot <oliver.sang@intel.com> wrote:
>
> FYI, we noticed the following commit (built with gcc-7):
>
> commit: 671ddc700fd08b94967b1e2a937020e30c838609 ("KVM: nVMX: Don't leak L1 MMIO regions to L2")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> in testcase: kvm-unit-tests
> with following parameters:
>
>         ucode: 0x27
>
>
>
> on test machine: 8 threads Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 8G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
> 2019-10-29 16:17:51 ./run_tests.sh
>  [32mPASS [0m apic-split (53 tests)
>  [32mPASS [0m ioapic-split (19 tests)
>  [32mPASS [0m apic (53 tests)
>  [32mPASS [0m ioapic (19 tests)
>  [32mPASS [0m smptest (1 tests)
>  [32mPASS [0m smptest3 (1 tests)
>  [32mPASS [0m vmexit_cpuid
>  [32mPASS [0m vmexit_vmcall
>  [32mPASS [0m vmexit_mov_from_cr8
>  [32mPASS [0m vmexit_mov_to_cr8
>  [32mPASS [0m vmexit_inl_pmtimer
>  [32mPASS [0m vmexit_ipi
>  [32mPASS [0m vmexit_ipi_halt
>  [32mPASS [0m vmexit_ple_round_robin
>  [32mPASS [0m vmexit_tscdeadline
>  [32mPASS [0m vmexit_tscdeadline_immed
>  [32mPASS [0m access
>  [33mSKIP [0m smap (0 tests)
>  [33mSKIP [0m pku (0 tests)
>  [32mPASS [0m asyncpf (1 tests)
>  [32mPASS [0m emulator (125 tests, 2 skipped)
>  [32mPASS [0m eventinj (13 tests)
>  [32mPASS [0m hypercall (2 tests)
>  [32mPASS [0m idt_test (4 tests)
>  [32mPASS [0m memory (8 tests)
>  [32mPASS [0m msr (12 tests)
>  [32mPASS [0m pmu (67 tests)
>  [31mFAIL [0m vmware_backdoors (11 tests, 5 unexpected failures)
>  [32mPASS [0m port80
>  [32mPASS [0m realmode
>  [32mPASS [0m s3
>  [32mPASS [0m sieve
>  [32mPASS [0m syscall (2 tests)
>  [32mPASS [0m tsc (3 tests)
>  [32mPASS [0m tsc_adjust (5 tests)
>  [32mPASS [0m xsave (17 tests)
>  [32mPASS [0m rmap_chain
>  [33mSKIP [0m svm (0 tests)
>  [33mSKIP [0m taskswitch (i386 only)
>  [33mSKIP [0m taskswitch2 (i386 only)
>  [32mPASS [0m kvmclock_test
>  [32mPASS [0m pcid (3 tests)
>  [32mPASS [0m rdpru (1 tests)
>  [32mPASS [0m umip (21 tests)
>  [31mFAIL [0m vmx (timeout; duration=90s)
>  [33mSKIP [0m ept (0 tests)
>  [33mSKIP [0m vmx_eoi_bitmap_ioapic_scan (1 tests, 1 skipped)
>  [33mSKIP [0m vmx_hlt_with_rvi_test (1 tests, 1 skipped)
>  [33mSKIP [0m vmx_apicv_test (2 tests, 2 skipped)
>  [32mPASS [0m vmx_apic_passthrough_thread (8 tests)
>  [32mPASS [0m vmx_init_signal_test (8 tests)
>  [32mPASS [0m vmx_vmcs_shadow_test (142218 tests)
>  [32mPASS [0m debug (11 tests)
>  [32mPASS [0m hyperv_synic (1 tests)
>  [33mSKIP [0m hyperv_connections (1 tests, 1 skipped)
>  [32mPASS [0m hyperv_stimer (12 tests)
>  [32mPASS [0m hyperv_clock
>  [32mPASS [0m intel_iommu (11 tests)
>
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
>
>
>
> Thanks,
> Oliver Sang

It's unclear to me what the delta is, but I do see that the 'vmx'
suite has failed. That is to be expected if you're getting your
kvm-unit-tests from the 'master' branch of the kvm-unit-tests repo.
You will need commit 591b5b54bba1 ("x86: Skip APIC-access address
tests beyond mapped RAM"), which is in the 'next' branch of the
kvm-unit-tests repo, but which has not yet made it to the 'master'
branch.
