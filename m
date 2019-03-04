Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062E0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF9F2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfCDLVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 06:21:06 -0500
Received: from mga12.intel.com ([192.55.52.136]:20101 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbfCDLVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 06:21:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 03:21:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,439,1544515200"; 
   d="scan'208";a="304211955"
Received: from lxy-dell.sh.intel.com ([10.239.159.147])
  by orsmga005.jf.intel.com with ESMTP; 04 Mar 2019 03:21:03 -0800
Message-ID: <5a9b82659ace27ea03b3c16fc91fdad03fbc32ea.camel@linux.intel.com>
Subject: Re: [PATCH v4 15/17] kvm: x86: Report CORE_CAPABILITY on
 GET_SUPPORTED_CPUID
From:   Xiaoyao Li <xiaoyao.li@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        kvm@vger.kernel.org
Date:   Mon, 04 Mar 2019 19:21:06 +0800
In-Reply-To: <c0a3ef40-fd8a-7baf-9fbc-11baa379af5a@redhat.com>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
         <1551494711-213533-16-git-send-email-fenghua.yu@intel.com>
         <697ee0bd-a5f6-7712-017e-455eed5bc185@redhat.com>
         <f5053983dc12550edabc418b0493c6ec8deb1412.camel@linux.intel.com>
         <79b659fb-1c16-463d-aa74-f1b3d8a9db5d@redhat.com>
         <08b44b2b7aede11a350f234768d5c17f8445984e.camel@linux.intel.com>
         <c0a3ef40-fd8a-7baf-9fbc-11baa379af5a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-04 at 12:14 +0100, Paolo Bonzini wrote:
> On 04/03/19 12:10, Xiaoyao Li wrote:
> > Like you said before, I think we don't need the condition judgment
> > "if(boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT))", but to set
> > F(CORE_CAPABILITY)
> > always for guest since MSR_IA32_CORE_CAPABILITY is emulated.
> > 
> > And we should set the right emulated value of MSR_IA32_CORE_CAPABILITY for
> > guest
> > in function kvm_get_core_capability() based on whether
> > boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) just as you commented in the
> > next
> > patch.
> 
> Yes, that would certainly be better.  However, you'd also have to move
> MSR_IA32_CORE_CAPABILITY handling to x86.c, because you'd have to enable
> X86_FEATURE_CORE_CAPABILITY for AMD.
> 
> Paolo

Thanks for your comments and advises.
I'll do it in next version.

Xiaoyao

