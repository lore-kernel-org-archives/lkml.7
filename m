Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C4ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 06:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC58D20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 06:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387715AbfJVGQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 02:16:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:49039 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387508AbfJVGQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 02:16:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 23:16:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,326,1566889200"; 
   d="scan'208";a="227583987"
Received: from local-michael-cet-test.sh.intel.com (HELO localhost) ([10.239.159.128])
  by fmsmga002.fm.intel.com with ESMTP; 21 Oct 2019 23:16:21 -0700
Date:   Tue, 22 Oct 2019 14:19:15 +0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        yu.c.zhang@intel.com, alazar@bitdefender.com
Subject: Re: [PATCH v5 0/9] Enable Sub-page Write Protection Support
Message-ID: <20191022061915.GA18889@local-michael-cet-test>
References: <20190917085304.16987-1-weijiang.yang@intel.com>
 <CALMp9eSTz+XbmLtWZLqWvSNjjb4Ado4s+SfABtRuVNQBXUHStQ@mail.gmail.com>
 <20191011075033.GA11817@local-michael-cet-test>
 <CALMp9eTnS+-FtoO29XFQ8-1=gczXYP0eDPUKZssJ73-=gf1MGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eTnS+-FtoO29XFQ8-1=gczXYP0eDPUKZssJ73-=gf1MGg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 09:11:54AM -0700, Jim Mattson wrote:
> On Fri, Oct 11, 2019 at 12:48 AM Yang Weijiang <weijiang.yang@intel.com> wrote:
> >
> > On Thu, Oct 10, 2019 at 02:42:51PM -0700, Jim Mattson wrote:
> > > On Tue, Sep 17, 2019 at 1:52 AM Yang Weijiang <weijiang.yang@intel.com> wrote:
> > > >
> > > > EPT-Based Sub-Page write Protection(SPP)is a HW capability which allows
> > > > Virtual Machine Monitor(VMM) to specify write-permission for guest
> > > > physical memory at a sub-page(128 byte) granularity. When this
> > > > capability is enabled, the CPU enforces write-access check for sub-pages
> > > > within a 4KB page.
> > > >
> > > > The feature is targeted to provide fine-grained memory protection for
> > > > usages such as device virtualization, memory check-point and VM
> > > > introspection etc.
> > > >
> > > > SPP is active when the "sub-page write protection" (bit 23) is 1 in
> > > > Secondary VM-Execution Controls. The feature is backed with a Sub-Page
> > > > Permission Table(SPPT), SPPT is referenced via a 64-bit control field
> > > > called Sub-Page Permission Table Pointer (SPPTP) which contains a
> > > > 4K-aligned physical address.
> > > >
> > > > To enable SPP for certain physical page, the gfn should be first mapped
> > > > to a 4KB entry, then set bit 61 of the corresponding EPT leaf entry.
> > > > While HW walks EPT, if bit 61 is set, it traverses SPPT with the guset
> > > > physical address to find out the sub-page permissions at the leaf entry.
> > > > If the corresponding bit is set, write to sub-page is permitted,
> > > > otherwise, SPP induced EPT violation is generated.
> > >
> > > How do you handle sub-page permissions for instructions emulated by kvm?
> > How about checking if the gpa is SPP protected, if it is, inject some
> > exception to guest?
> The SPP semantics are well-defined. If a kvm-emulated instruction
> tries to write to a sub-page that is write-protected, then an
> SPP-induced EPT violation should be synthesized.
Hi, Jim,

Regarding the emulated instructions in KVM, there're quite a few
instructions can write guest memory, such as MOVS, XCHG, INS etc.,
check each destination against SPP protected area would be trivial if
deals with them individually, and PIO/MMIO induced vmexit/page_fault also
can link to a SPP protected page, e.g., a string instruction's the destination
is SPP protected memory. Is there a good way to intercept these writes?
emulate_ops.write_emulated() is called in most of the emulation cases to
check and write guest memory, but not sure it's suitable.
Do you have any suggestion?

Thanks!
