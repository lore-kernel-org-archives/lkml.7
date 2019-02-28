Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18526C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23E020854
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732680AbfCAC4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 21:56:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:36989 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfCAC4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 21:56:42 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 18:56:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,425,1544515200"; 
   d="scan'208";a="303458248"
Received: from local-michael-cet-test.sh.intel.com (HELO localhost) ([10.239.159.128])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2019 18:56:39 -0800
Date:   Thu, 28 Feb 2019 17:51:17 +0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, yu-cheng.yu@intel.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v3 1/8] KVM:VMX: Define CET VMCS fields and bits
Message-ID: <20190228095116.GA12240@local-michael-cet-test.sh.intel.com>
References: <20190225132716.6982-1-weijiang.yang@intel.com>
 <20190225132716.6982-2-weijiang.yang@intel.com>
 <CALMp9eSnkrk+chKkyGcToqdnvScQ0hJ0eWZ89Y_dccOrEuYHTA@mail.gmail.com>
 <20190228155345.GC6166@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228155345.GC6166@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 07:53:45AM -0800, Sean Christopherson wrote:
> On Tue, Feb 26, 2019 at 11:31:11AM -0800, Jim Mattson wrote:
> > On Mon, Feb 25, 2019 at 10:32 PM Yang Weijiang <weijiang.yang@intel.com> wrote:
> > >
> > > CET - Control-flow Enforcement Technology, it's used to
> > > protect against return/jump oriented programming (ROP)
> > > attacks. It provides the following capabilities to defend
> > > against ROP/JOP style control-flow subversion attacks:
> > > - Shadow Stack (SHSTK):
> > >                  A second stack for the program that is
> > >                  used exclusively for control transfer
> > >                  operations.
> > > - Indirect Branch Tracking (IBT):
> > >                  Free branch protection to defend against
> > >                  Jump/Call Oriented Programming.
> > >
> > > On processors that support CET, VMX saves/restores
> > > the states of IA32_S_CET, SSP and IA32_INTR_SSP_TABL_ADDR MSR
> > > to the VMCS area for Guest/Host unconditionally.
> > >
> > > If VM_EXIT_LOAD_HOST_CET_STATE = 1, the host CET MSRs are
> > > restored from VMCS host-state area at VM exit as follows:
> > >
> > > - HOST_IA32_S_CET: Host supervisor mode IA32_S_CET MSR is loaded
> > >                    from this field.
> > >
> > > - HOST_SSP :       Host SSP is loaded from this field.
> > >
> > > - HOST_INTR_SSP_TABL_ADDR : Host IA32_INTR_SSP_TABL_ADDR
> > >                              MSR is loaded from this field.
> > >
> > > If VM_ENTRY_LOAD_GUEST_CET_STATE = 1, the guest CET MSRs are loaded
> > > from VMCS guest-state area at VM entry as follows:
> > >
> > > - GUEST_IA32_S_CET : Guest supervisor mode IA32_S_CET MSR is loaded
> > >                      from this field.
> > >
> > > - GUEST_SSP :        Guest SSP is loaded from this field.
> > >
> > > - GUEST_INTR_SSP_TABL_ADDR : Guest IA32_INTR_SSP_TABL_ADDR
> > >                              MSR is loaded from this field.
> > >
> > > Additionally, to context switch guest and host CET states, the VMM
> > > uses xsaves/xrstors instructions to save/restore the guest CET states
> > > at VM exit/entry. The CET xsave area is within thread_struct.fpu area.
> > > If OS execution flow changes during task switch/interrupt/exception etc.,
> > > the OS also relies on xsaves/xrstors to switch CET states accordingly.
> > >
> > > Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> > > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > > ---
> > >  arch/x86/include/asm/vmx.h | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> > > index ade0f153947d..395c1f7e5938 100644
> > > --- a/arch/x86/include/asm/vmx.h
> > > +++ b/arch/x86/include/asm/vmx.h
> > > @@ -98,6 +98,7 @@
> > >  #define VM_EXIT_LOAD_IA32_EFER                  0x00200000
> > >  #define VM_EXIT_SAVE_VMX_PREEMPTION_TIMER       0x00400000
> > >  #define VM_EXIT_CLEAR_BNDCFGS                   0x00800000
> > > +#define VM_EXIT_LOAD_HOST_CET_STATE             0x10000000
> > >
> > >  #define VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR      0x00036dff
> > >
> > > @@ -109,6 +110,7 @@
> > >  #define VM_ENTRY_LOAD_IA32_PAT                 0x00004000
> > >  #define VM_ENTRY_LOAD_IA32_EFER                 0x00008000
> > >  #define VM_ENTRY_LOAD_BNDCFGS                   0x00010000
> > > +#define VM_ENTRY_LOAD_GUEST_CET_STATE           0x00100000
> > >
> > >  #define VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR     0x000011ff
> > >
> > > @@ -325,6 +327,9 @@ enum vmcs_field {
> > >         GUEST_PENDING_DBG_EXCEPTIONS    = 0x00006822,
> > >         GUEST_SYSENTER_ESP              = 0x00006824,
> > >         GUEST_SYSENTER_EIP              = 0x00006826,
> > > +       GUEST_IA32_S_CET                = 0x00006828,
> > > +       GUEST_SSP                       = 0x0000682a,
> > > +       GUEST_INTR_SSP_TABL_ADDR        = 0x0000682c,
> > 
> > Nit: TABL is an unusual abbreviation. Perhaps TBL here and below?
> 
> I don't see any reason to abbreviate TABLE, we don't need the two
> characters for anything.
> 
> > And why did you drop the 'IA32' here, but not in GUEST_IA32_S_CET above?
> > (It is true that there seems to be no rhyme or reason to the mnemonics
> > chosen here. For example, EFER keeps its IA32, but SYSENTER_EIP
> > doesn't. Sigh.)
> 
> My vote is to always drop IA32, IMO it's redundant.

How about GUEST_S_CET, GUEST_SSP and GUEST_INTR_SSP_TABLE?

