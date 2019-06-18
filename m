Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3034EC31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 23:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E49D20873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 23:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbfFRXPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:15:50 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49088 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFRXPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 19:15:50 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hdNKG-0008Hx-Ui; Wed, 19 Jun 2019 01:15:41 +0200
Date:   Wed, 19 Jun 2019 01:15:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
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
Subject: Re: [RFC PATCH v4 18/21] x86/apic: Add a parameter for the APIC
 delivery mode
In-Reply-To: <20190618224738.GC30488@ranerica-svr.sc.intel.com>
Message-ID: <alpine.DEB.2.21.1906190115240.1765@nanos.tec.linutronix.de>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1558660583-28561-19-git-send-email-ricardo.neri-calderon@linux.intel.com> <alpine.DEB.2.21.1906161151240.1760@nanos.tec.linutronix.de>
 <20190618224738.GC30488@ranerica-svr.sc.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019, Ricardo Neri wrote:

> On Sun, Jun 16, 2019 at 11:55:03AM +0200, Thomas Gleixner wrote:
> > On Thu, 23 May 2019, Ricardo Neri wrote:
> > >  
> > >  struct irq_cfg {
> > > -	unsigned int		dest_apicid;
> > > -	unsigned int		vector;
> > > +	unsigned int				dest_apicid;
> > > +	unsigned int				vector;
> > > +	enum ioapic_irq_destination_types	delivery_mode;
> > 
> > And how is this related to IOAPIC?
> 
> In my view, IOAPICs can also be programmed with a delivery mode. Mode
> values are the same for MSI interrupts.

> > I know this enum exists already, but in
> > connection with MSI this does not make any sense at all.
> 
> Is the issue here the name of the enumeration?
> 
> > 
> > > +
> > > +		/*
> > > +		 * Initialize the delivery mode of this irq to match the
> > > +		 * default delivery mode of the APIC. This is useful for
> > > +		 * children irq domains which want to take the delivery
> > > +		 * mode from the individual irq configuration rather
> > > +		 * than from the APIC.
> > > +		 */
> > > +		 apicd->hw_irq_cfg.delivery_mode = apic->irq_delivery_mode;
> > 
> > And here it's initialized from apic->irq_delivery_mode, which is an
> > u32. Intuitive and consistent - NOT!
> 
> Yes, this is wrong. Then should the member in the structure above be an
> u32 instead of enum ioapic_irq_destination_types?
> 
> Thanks and BR,
> Ricardo
> 
