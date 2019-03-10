Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C54C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AA6206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfCKF0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 01:26:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:50208 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfCKF0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 01:26:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2019 22:26:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,467,1544515200"; 
   d="scan'208";a="198550916"
Received: from local-michael-cet-test.sh.intel.com (HELO localhost) ([10.239.159.128])
  by orsmga001.jf.intel.com with ESMTP; 10 Mar 2019 22:26:10 -0700
Date:   Sun, 10 Mar 2019 20:20:30 +0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v3 7/8] KVM:X86: Add XSS bit 11 and 12 support for CET
 xsaves/xrstors.
Message-ID: <20190310122030.GB24065@local-michael-cet-test.sh.intel.com>
References: <20190225132716.6982-1-weijiang.yang@intel.com>
 <20190225132716.6982-8-weijiang.yang@intel.com>
 <20190228162512.GG6166@linux.intel.com>
 <20190228084404.GD12006@local-michael-cet-test.sh.intel.com>
 <f1b0c3ab-a377-d998-34d3-67c5e951f4e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1b0c3ab-a377-d998-34d3-67c5e951f4e1@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 12:32:04PM +0100, Paolo Bonzini wrote:
> On 28/02/19 09:44, Yang Weijiang wrote:
> >>>  		if (!vmx_xsaves_supported())
> >>>  			return 1;
> >>> +
> >>>  		/*
> >>> -		 * The only supported bit as of Skylake is bit 8, but
> >>> -		 * it is not supported on KVM.
> >>> +		 * Check bits being set are supported in KVM.
> >> I'd drop the comment altogether, it's pretty obvious from the code that
> >> were checking which bits are supported.
> > you won't see these redundancies in next version ;)
> >>>  		 */
> >>> -		if (data != 0)
> >>> +		if (data & ~kvm_supported_xss())
> >>>  			return 1;
> 
> You should instead check this against CPUID[0xD, 1].EDX:ECX.  If CET is
> disabled in CPUID, the guest should not be able to set it in MSR_IA32_CSS.
> 
> Paolo
Thanks, OK, will change it.
