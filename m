Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AC6C10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70C52081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfCHQ2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:28:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:8476 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbfCHQ2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:28:37 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 08:28:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208";a="153281553"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga001.fm.intel.com with ESMTP; 08 Mar 2019 08:28:35 -0800
Date:   Fri, 8 Mar 2019 08:28:35 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, Zhang Yi Z <yi.z.zhang@linux.intel.com>,
        wei.w.wang@intel.com, weijiang.yang@inte.com
Subject: Re: [PATCH v3 6/8] KVM:VMX: Load Guest CET via VMCS when CET is
 enabled in Guest
Message-ID: <20190308162835.GB2528@linux.intel.com>
References: <20190225132716.6982-1-weijiang.yang@intel.com>
 <20190225132716.6982-7-weijiang.yang@intel.com>
 <20190228161715.GF6166@linux.intel.com>
 <20190228083844.GC12006@local-michael-cet-test.sh.intel.com>
 <20190301145819.GC22584@linux.intel.com>
 <20190303122608.GA32013@local-michael-cet-test.sh.intel.com>
 <20190304184307.GC17120@linux.intel.com>
 <20190304095640.GA3576@local-michael-cet-test.sh.intel.com>
 <20190305031202.GI17120@linux.intel.com>
 <20190304123655.GB4185@local-michael-cet-test.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304123655.GB4185@local-michael-cet-test.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 08:36:55PM +0800, Yang Weijiang wrote:
> On Mon, Mar 04, 2019 at 07:12:02PM -0800, Sean Christopherson wrote:
> > On Mon, Mar 04, 2019 at 05:56:40PM +0800, Yang Weijiang wrote:
> > > Cannot agree with you more!
> > > This is some design limitation, but from my point of view, once vmm
> > > exposes CET capability to guest via CPUID, it grants the guest kernel freedom to choose
> > > which features to be enabled, we don't need to add extra constraints on
> > > the usage.
> > 
> > But if KVM allows SHSTK and IBT to be toggled independently then the VMM
> > has only exposed SHSTK or IBT, not CET as whole.
> > 
> > Even if SHSTK and IBT are bundled together the guest still has to opt-in
> > to enabling each feature.  I don't see what we gain by pretending that
> > SHSTK/IBT can be individually exposed to the guest, and on the flip side
> > doing so creates a virtualization hole.
> you almost convinced me ;-), maybe I'll make the feature as a bundle in
> next release after check with kernel team. BTW, what do you mean by
> saying "create a virtualization hole"? Is it what you stated in above
> reply?

By "virtualization hole" I mean the guest would be able to use a feature
that the virtual CPU model says isn't supported.

After rereading the XSS architecture, there's a marginally less crappy
option for handling XRSTOR as we could use the XSS_EXIT_BITMAP to
intercept XRSTOR if SHSTK != IBT and the guest is restoring CET state,
e.g. to ensure the guest isn't setting IA32_PL*_SSP if !SHSTK and isn't
setting bits that are effectively reserved in IA32_U_CET.

But practically speaking that'd be the same as intercepting XRSTORS
unconditionally when the guest is using CET, i.e. it's still going to
tank the performance of a guest that uses CET+XSAVES/XRSTORS.
