Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DFEC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343E72083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfFUSg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:36:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:32036 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfFUSg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 14:36:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2019 11:36:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,401,1557212400"; 
   d="scan'208";a="151340684"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga007.jf.intel.com with ESMTP; 21 Jun 2019 11:36:25 -0700
Date:   Fri, 21 Jun 2019 11:39:38 -0700
From:   Jacob Pan <jacob.jun.pan@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Wincy Van <fanwenyi0529@gmail.com>,
        Ashok Raj <ashok.raj@intel.com>, x86 <x86@kernel.org>,
        Andi Kleen <andi.kleen@intel.com>,
        Borislav Petkov <bp@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Juergen Gross <jgross@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        jacob.jun.pan@intel.com
Subject: Re: [RFC PATCH v4 20/21] iommu/vt-d: hpet: Reserve an interrupt
 remampping table entry for watchdog
Message-ID: <20190621113938.1679f329@jacob-builder>
In-Reply-To: <20190621103126.585ca6d3@jacob-builder>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
        <1558660583-28561-21-git-send-email-ricardo.neri-calderon@linux.intel.com>
        <alpine.DEB.2.21.1906162049300.1760@nanos.tec.linutronix.de>
        <alpine.DEB.2.21.1906171007360.1760@nanos.tec.linutronix.de>
        <CABPqkBTai76Bgb4E61tF-mJUkFNxVa4B8M2bxTEYVgBsuAANNQ@mail.gmail.com>
        <alpine.DEB.2.21.1906172343120.1963@nanos.tec.linutronix.de>
        <20190619084316.71ce5477@jacob-builder>
        <alpine.DEB.2.21.1906211732330.5503@nanos.tec.linutronix.de>
        <20190621103126.585ca6d3@jacob-builder>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019 10:31:26 -0700
Jacob Pan <jacob.jun.pan@intel.com> wrote:

> On Fri, 21 Jun 2019 17:33:28 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Wed, 19 Jun 2019, Jacob Pan wrote:  
> > > On Tue, 18 Jun 2019 01:08:06 +0200 (CEST)
> > > Thomas Gleixner <tglx@linutronix.de> wrote:    
> > > > 
> > > > Unless this problem is not solved and I doubt it can be solved
> > > > after talking to IOMMU people and studying manuals,    
> > >
> > > I agree. modify irte might be done with cmpxchg_double() but the
> > > queued invalidation interface for IRTE cache flush is shared with
> > > DMA and requires holding a spinlock for enque descriptors, QI tail
> > > update etc.
> > > 
> > > Also, reserving & manipulating IRTE slot for hpet via backdoor
> > > might not be needed if the HPET PCI BDF (found in ACPI) can be
> > > utilized. But it might need more work to add a fake PCI device for
> > > HPET.    
> > 
> > What would PCI/BDF solve?  
> I was thinking if HPET is a PCI device then it can naturally
> gain slots in IOMMU remapping table IRTEs via PCI MSI code. Then
> perhaps it can use the IRQ subsystem to set affinity etc. w/o
> directly adding additional helper functions in IRQ remapping code. I
> have not followed all the discussions, just a thought.
> 
I looked at the code again, seems the per cpu HPET code already taken
care of HPET MSI management. Why can't we use IR-HPET-MSI chip and
domain to allocate and set affinity etc.?
Most APIC timer has ARAT not enough per cpu HPET, so per cpu HPET is
not used mostly.


Jacob
