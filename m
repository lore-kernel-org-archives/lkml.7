Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A851C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8552082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfCEDVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:21:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:20163 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbfCEDV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:21:29 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 19:21:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,442,1544515200"; 
   d="scan'208";a="149288646"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga004.fm.intel.com with ESMTP; 04 Mar 2019 19:21:27 -0800
Date:   Mon, 4 Mar 2019 19:21:27 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v3 5/8] KVM:VMX: Pass through host CET related MSRs to
 Guest.
Message-ID: <20190305032127.GA23534@linux.intel.com>
References: <20190225132716.6982-1-weijiang.yang@intel.com>
 <20190225132716.6982-6-weijiang.yang@intel.com>
 <20190304185326.GE17120@linux.intel.com>
 <20190304100714.GA3683@local-michael-cet-test.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304100714.GA3683@local-michael-cet-test.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 06:07:14PM +0800, Yang Weijiang wrote:
> On Mon, Mar 04, 2019 at 10:53:27AM -0800, Sean Christopherson wrote:
> > On Mon, Feb 25, 2019 at 09:27:13PM +0800, Yang Weijiang wrote:
> > > The CET runtime settings, i.e., CET state control bits(IA32_U_CET/
> > > IA32_S_CET), CET SSP(IA32_PL3_SSP/IA32_PL0_SSP) and SSP table address
> > > (IA32_INTERRUPT_SSP_TABLE_ADDR) are task/thread specific, therefore,
> > > OS needs to save/restore the states properly during context switch,
> > > e.g., task/thread switching, interrupt/exception handling, it uses
> > > xsaves/xrstors to achieve that.
> > > 
> > > The difference between VMCS CET area fields and xsave CET area, is that
> > > the former is for state retention during Guest/Host context
> > > switch while the latter is for state retention during OS execution.
> > > 
> > > Linux currently doesn't support CPL1 and CPL2, so SSPs for these level
> > > are skipped here.
> > 
> > But don't we want to allow a guest to access the MSRs regardless of
> > the host kernel's behavior?
> >
> Do you see any necessity of exposing the access to guest?

No, but isn't exposing them to the guest effectively free since XSAVES
and XRSTORS will always save/restore them along with SSP0 and SSP3?
