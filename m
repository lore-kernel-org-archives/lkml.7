Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E8CC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85462339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbfIDNs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:48:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:31668 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728941AbfIDNs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:48:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 06:48:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="212397283"
Received: from local-michael-cet-test.sh.intel.com (HELO localhost) ([10.239.159.128])
  by fmsmga002.fm.intel.com with ESMTP; 04 Sep 2019 06:48:23 -0700
Date:   Wed, 4 Sep 2019 21:49:25 +0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        mst@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        yu.c.zhang@intel.com, alazar@bitdefender.com
Subject: Re: [PATCH RESEND v4 8/9] KVM: MMU: Enable Lazy mode SPPT setup
Message-ID: <20190904134925.GA25149@local-michael-cet-test.sh.intel.com>
References: <20190814070403.6588-1-weijiang.yang@intel.com>
 <20190814070403.6588-9-weijiang.yang@intel.com>
 <63f8952b-2497-16ec-ff55-1da017c50a8c@redhat.com>
 <20190820131214.GD4828@local-michael-cet-test.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820131214.GD4828@local-michael-cet-test.sh.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 09:12:14PM +0800, Yang Weijiang wrote:
> On Mon, Aug 19, 2019 at 04:46:54PM +0200, Paolo Bonzini wrote:
> > On 14/08/19 09:04, Yang Weijiang wrote:
> > > +
> > > +	if (vcpu->kvm->arch.spp_active && level == PT_PAGE_TABLE_LEVEL)
> > > +		kvm_enable_spp_protection(vcpu->kvm, gfn);
> > > +
> > 
> > This would not enable SPP if the guest is backed by huge pages.
> > Instead, either the PT_PAGE_TABLE_LEVEL level must be forced for all
> > pages covered by SPP ranges, or (better) kvm_enable_spp_protection must
> > be able to cover multiple pages at once.
> > 
> > Paolo
> OK, I'll figure out how to make it, thanks!
Hi, Paolo,
Regarding this change, I have some concerns, splitting EPT huge page
entries(e.g., 1GB page)will take long time compared with normal EPT page
fault processing, especially for multiple vcpus/pages,so the in-flight time increases,
but HW walks EPT for translations in the meantime, would it bring any side effect? 
or there's a way to mitigate it?

Thanks!

