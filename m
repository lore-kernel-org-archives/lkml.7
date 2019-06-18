Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FF6C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE60E2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbfFRWpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 18:45:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:12786 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730176AbfFRWpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 18:45:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 15:45:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,390,1557212400"; 
   d="scan'208";a="358421836"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jun 2019 15:45:40 -0700
Date:   Tue, 18 Jun 2019 15:45:19 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wincy Van <fanwenyi0529@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH v4 20/21] iommu/vt-d: hpet: Reserve an interrupt
 remampping table entry for watchdog
Message-ID: <20190618224519.GA30488@ranerica-svr.sc.intel.com>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1558660583-28561-21-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <alpine.DEB.2.21.1906162049300.1760@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1906171007360.1760@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906171007360.1760@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 10:25:35AM +0200, Thomas Gleixner wrote:
> On Sun, 16 Jun 2019, Thomas Gleixner wrote:
> > On Thu, 23 May 2019, Ricardo Neri wrote:
> > > When the hardlockup detector is enabled, the function
> > > hld_hpet_intremapactivate_irq() activates the recently created entry
> > > in the interrupt remapping table via the modify_irte() functions. While
> > > doing this, it specifies which CPU the interrupt must target via its APIC
> > > ID. This function can be called every time the destination iD of the
> > > interrupt needs to be updated; there is no need to allocate or remove
> > > entries in the interrupt remapping table.
> > 
> > Brilliant.
> > 
> > > +int hld_hpet_intremap_activate_irq(struct hpet_hld_data *hdata)
> > > +{
> > > +	u32 destid = apic->calc_dest_apicid(hdata->handling_cpu);
> > > +	struct intel_ir_data *data;
> > > +
> > > +	data = (struct intel_ir_data *)hdata->intremap_data;
> > > +	data->irte_entry.dest_id = IRTE_DEST(destid);
> > > +	return modify_irte(&data->irq_2_iommu, &data->irte_entry);
> > 
> > This calls modify_irte() which does at the very beginning:
> > 
> >    raw_spin_lock_irqsave(&irq_2_ir_lock, flags);
> > 
> > How is that supposed to work from NMI context? Not to talk about the
> > other spinlocks which are taken in the subsequent call chain.
> > 
> > You cannot call in any of that code from NMI context.
> > 
> > The only reason why this never deadlocked in your testing is that nothing
> > else touched that particular iommu where the HPET hangs off concurrently.
> > 
> > But that's just pure luck and not design. 
> 
> And just for the record. I warned you about that problem during the review
> of an earlier version and told you to talk to IOMMU folks whether there is
> a way to update the entry w/o running into that lock problem.

I think I misunderstood your feedback. You did mention issues on locking
between NMI and !NMI contexts. However, that was in the context of using the
generic irq code to do things such as set the affinity of the interrupt and
requesting an irq. I understood that I should instead program things directly.
I extrapolated this to the IOMMU driver in which I also added code directly
instead of using the existing layering.

Also, at the time, the question regarding the IOMMU, as I understood, was
whether it was posible to reserve a IOMMU remapping entry upfront. I believe
my patches achieve that, even if they are hacky and ugly, and have locking
issues. I see now that the locking issues are also part of the IOMMU
discussion. Perhaps that was also implicit.
> 
> Can you tell my why am I actually reviewing patches and spending time on
> this when the result is ignored anyway?

Yes, Thomas, I should have checked first with the IOMMU maintainers
first on the issues in the paragraph above. It is not my intention to
waste your time; your feedback has been valuable and has contributed to
improve the code.

> 
> I also tried to figure out why you went away from the IPI broadcast
> design. The only information I found is:
> 
> Changes vs. v1:
> 
>  * Brought back the round-robin mechanism proposed in v1 (this time not
>    using the interrupt subsystem). This also requires to compute
>    expiration times as in v1 (Andi Kleen, Stephane Eranian).
> 
> Great that there is no trace of any mail from Andi or Stephane about this
> on LKML. There is no problem with talking offlist about this stuff, but
> then you should at least provide a rationale for those who were not part of
> the private conversation.

Stephane has already commented the rationale.

Thanks and BR,

Ricardo
