Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B960C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8939206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfCDS4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:56:23 -0500
Received: from mga06.intel.com ([134.134.136.31]:8126 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfCDS4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:56:23 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 10:56:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,440,1544515200"; 
   d="scan'208";a="324116530"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga006.fm.intel.com with ESMTP; 04 Mar 2019 10:56:21 -0800
Date:   Mon, 4 Mar 2019 10:56:21 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, rkrcmar@redhat.com,
        jmattson@google.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, mst@redhat.com, yu-cheng.yu@intel.com,
        yi.z.zhang@intel.com, hjl.tools@gmail.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v2 1/7] KVM:VMX: Define CET VMCS fields and bits
Message-ID: <20190304185621.GG17120@linux.intel.com>
References: <20190122205909.24165-1-weijiang.yang@intel.com>
 <20190122205909.24165-2-weijiang.yang@intel.com>
 <5a31eef0-2b6c-bdc2-c54b-5dc4cecf084d@redhat.com>
 <20190128103345.GA29895@local-michael-cet-test.sh.intel.com>
 <4d9a5393-163b-f32a-4657-cec54093ee88@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d9a5393-163b-f32a-4657-cec54093ee88@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 04:19:34PM +0100, Paolo Bonzini wrote:
> On 28/01/19 11:33, Yang Weijiang wrote:
> >> There is no code in this series to pass these fields to and from
> >> userspace, and also to save/restore U_CET, INT_SSP_TAB, PL0_SSP and
> >> PL3_SSP across context switches.
> >>
> > The kernel consumes these MSRs, please see kernel CET patch:
> > https://lkml.org/lkml/fancy/2018/11/20/225
> 
> Still, even if the kernel saves these fields across context switch in
> XSAVE areas, KVM must support accesses to the MSRs from userspace, for
> example in order to perform live migration.
> 
> For example, when reading/writing these in kvm_set_msr or
> kvm_get_msr_common, you would have to do a read/write from the host
> MSRs.  You also have to put kvm_load_guest_fpu/kvm_put_guest_fpu calls
> in __msr_io.

Paolo, can you elaborate on why KVM would read the host MSRs?  Wouldn't
kvm_{get,set}_msr() pull the values from the VMCS when necessary?
