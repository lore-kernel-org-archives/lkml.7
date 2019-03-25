Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABA0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EE220850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfCYTVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:21:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:19193 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729473AbfCYTVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:21:12 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 12:21:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="310322464"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga005.jf.intel.com with ESMTP; 25 Mar 2019 12:21:11 -0700
Date:   Mon, 25 Mar 2019 12:21:11 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     KVM <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kvm/x86: Move MSR_K7_HWCR to svm.c
Message-ID: <20190325192111.GH31069@linux.intel.com>
References: <20190325171649.7311-1-bp@alien8.de>
 <20190325171649.7311-2-bp@alien8.de>
 <20190325182133.GG31069@linux.intel.com>
 <20190325183909.GQ12016@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325183909.GQ12016@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 07:39:09PM +0100, Borislav Petkov wrote:
> On Mon, Mar 25, 2019 at 11:21:33AM -0700, Sean Christopherson wrote:
> > Won't this prevent emulating an AMD guest on Intel hardware, e.g. due to
> > injecting #GPs during boot?
> 
> I guess, but...
> 
> > Keeping support in kvm_{get,set}_msr_common
> > doesn't preclude svm_{get,set}_msr() from having SVM-specific handling for
> > the MSR.
> 
> ... is kvm_{get,set}_msr_common() supposed to cover for all those
> overlapping MSRs between AMD and Intel? svm_{get,set}_msr() have a lot
> more AMD-specific MSRs just like vmx_{get,set}_msr() respectively for
> Intel.
> 
> Which would mean that if you really want to support those cross-vendor
> emulations, you don't need the svm* and vmx* MSR accessors... or am I
> missing something?

Generally speaking, the goal is to support cross-vendor VMs without having
to modify the guest kernel, i.e. exact emulation is out of scope.  This
means "emulating" cross-vendor MSRs that the guest expects to exist to the
point where the guest won't explode, e.g. in the case of MSR_K7_HWCR, Linux
expects the MSR to exist on all AMD platforms and AFAICT will die during
boot if it doesn't.

The rule of thumb for "what MSRs can a guest reasonably expect to exist"
is fluid.  The most clear cut cases are when support is explicitly
enumerated via some feature bit and KVM reports support for said feature
to userspace, e.g. if userspace advertises a feature (to the guest) that
KVM doesn't support, then it's a userspace bug.

But for MSRs like MSR_K7_HWCR and MSR_F10H_DECFG where their existence is
implicit, whoever came first often wins.  For example, MSR_K7_HWCR existed
long before KVM and guest kernels expect it to exist on all AMD CPUs, so
KVM emulates it unconditionally.  Whereas MSR_F10H_DECFG was recently
added and obviously not emulated on existing hypervisors, so the kernel
has to assume the MSR might not exist when running under a hypervisor,
which means KVM doesn't need to pretend the MSR uncondtionally exists.
