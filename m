Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AB9C3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 00:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87C7233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 00:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbfHWAYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 20:24:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:46819 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfHWAYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 20:24:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 17:24:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,419,1559545200"; 
   d="scan'208";a="379525172"
Received: from unknown (HELO localhost) ([10.239.159.128])
  by fmsmga006.fm.intel.com with ESMTP; 22 Aug 2019 17:24:45 -0700
Date:   Fri, 23 Aug 2019 08:26:10 +0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        mst@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        yu.c.zhang@intel.com, alazar@bitdefender.com
Subject: Re: [PATCH RESEND v4 7/9] KVM: VMX: Handle SPP induced vmexit and
 page fault
Message-ID: <20190823002610.GA16936@local-michael-cet-test>
References: <20190814070403.6588-1-weijiang.yang@intel.com>
 <20190814070403.6588-8-weijiang.yang@intel.com>
 <5f6ba406-17c4-a552-2352-2ff50569aac0@redhat.com>
 <fb6cd8b4-eee9-6e58-4047-550811bffd58@redhat.com>
 <20190820134435.GE4828@local-michael-cet-test.sh.intel.com>
 <20190822131745.GA20168@local-michael-cet-test>
 <62748fe8-0a3b-0554-452e-3bb5ebaf0466@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62748fe8-0a3b-0554-452e-3bb5ebaf0466@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 06:38:41PM +0200, Paolo Bonzini wrote:
> On 22/08/19 15:17, Yang Weijiang wrote:
> > On Tue, Aug 20, 2019 at 09:44:35PM +0800, Yang Weijiang wrote:
> >> On Mon, Aug 19, 2019 at 05:04:23PM +0200, Paolo Bonzini wrote:
> >>> fast_page_fault should never trigger an SPP userspace exit on its own,
> >>> all the SPP handling should go through handle_spp.
> >  Hi, Paolo,
> >  According to the latest SDM(28.2.4), handle_spp only handles SPPT miss and SPPT
> >  misconfig(exit_reason==66), subpage write access violation causes EPT violation,
> >  so have to deal with the two cases into handlers.
> 
> Ok, so this part has to remain, though you do have to save/restore
> PT_SPP_MASK according to the rest of the email.
> 
> Paolo
>
Got it, thanks!
> >>> So I think that when KVM wants to write-protect the whole page
> >>> (wrprot_ad_disabled_spte) it must also clear PT_SPP_MASK; for example it
> >>> could save it in bit 53 (PT64_SECOND_AVAIL_BITS_SHIFT + 1).  If the
> >>> saved bit is set, fast_page_fault must then set PT_SPP_MASK instead of
> >>> PT_WRITABLE_MASK.
