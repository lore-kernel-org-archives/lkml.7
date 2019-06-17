Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19486C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D799720657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C6LL7GNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfFQVia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:38:30 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36479 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfFQVi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:38:27 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so24837251ioh.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 14:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SrvOCOvD/npMq+rdmG0iHCrr8LGFgDfdEB1g1qFDyfA=;
        b=C6LL7GNcUBRJQpB4zer0JYaPOPHc6GgFgTD7zFDsGTMWqtavFEHHHuJY9nGPFDlXPO
         F4ENymilLNms/n63xiUPRRFNez8BJWTxNgoXwuTVW7uotERbMl0IbQ7apAg9paydetvx
         lD1n/XeTl9m3wdlz++cGBLpYAeATZ+/bVS6H7s1sD7egag9nX3ECnEP220eRW2T2Ai6r
         11tQf01dDaKEYauJ3XSiCh7V71ll0lk62RmmRFg6Mhn7VomHCrA9+1zNNk6pmG261jGj
         5ymslLp68rXct5A/uqKLTRCpTU3n39CZRertUHgD/LyL5E2M7qzTrDHi51ez+hRDy/Ho
         vjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SrvOCOvD/npMq+rdmG0iHCrr8LGFgDfdEB1g1qFDyfA=;
        b=Q/kjwtO2F25kRQFzKZaSaDhaDTDy9NefKHVFRtDFP96wBxUixO1YI5GAcctuUa5F+E
         1F9QCbOKjwkMmUZAj32DLZKxEahO38cKde2/UGit38j+bfFc4pZEnU0r7dnRVvvAEcoj
         +GbhQvbfZkFCnY8XkB6DJhNmPaz3ISJN15/iMgvep9H4yKsbOHsBFmmz/SZYJQli3lz+
         06iBeAwoRLmF7BanVQt+1PkcUcA3FS/+xjsdghVNxj5PM5XkrIZMMvm2kPOQ7vvcmlZA
         G7ThYxOcHPvBKkIXJUwmvdLrCN1v3pMq+fELEMEvxSMbDWM4k6jRJ5yQmBHVumPs0NXM
         9Kqw==
X-Gm-Message-State: APjAAAUmx3Cg+GA/8NlahmOOd/h8AvjRV8aFX2CR/ES9aUrGNRdNFSJN
        BfNI35KipZyuD7RJNFg4WAy1dnPAmcQQz4mGiuNnfQ==
X-Google-Smtp-Source: APXvYqxVirGRZJLjpWkTV40u2qY6sBuMI814IzMWFyU7NNbfyMpV+sjw99r1+rkY9sz6ebwCFPPIRXNd0ehymU/LPM4=
X-Received: by 2002:a5e:c207:: with SMTP id v7mr2637922iop.163.1560807506670;
 Mon, 17 Jun 2019 14:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1558660583-28561-21-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <alpine.DEB.2.21.1906162049300.1760@nanos.tec.linutronix.de> <alpine.DEB.2.21.1906171007360.1760@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906171007360.1760@nanos.tec.linutronix.de>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 17 Jun 2019 14:38:14 -0700
Message-ID: <CABPqkBTai76Bgb4E61tF-mJUkFNxVa4B8M2bxTEYVgBsuAANNQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 20/21] iommu/vt-d: hpet: Reserve an interrupt
 remampping table entry for watchdog
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 17, 2019 at 1:25 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
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
> > > +   u32 destid = apic->calc_dest_apicid(hdata->handling_cpu);
> > > +   struct intel_ir_data *data;
> > > +
> > > +   data = (struct intel_ir_data *)hdata->intremap_data;
> > > +   data->irte_entry.dest_id = IRTE_DEST(destid);
> > > +   return modify_irte(&data->irq_2_iommu, &data->irte_entry);
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
>
> Can you tell my why am I actually reviewing patches and spending time on
> this when the result is ignored anyway?
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
>
Let me add some context to this whole patch series. The pressure on
the core PMU counters
is increasing as more people want to use them to measure always more
events. When the PMU
is overcommitted, i.e., more events than counters for them, there is
multiplexing. It comes
with an overhead that is too high for certain applications. One way to
avoid this is to lower the
multiplexing frequency, which is by default 1ms, but that comes with
loss of accuracy. Another approach is
to measure only a small number of events at a time and use multiple
runs, but then you lose consistent event
view. Another approach is to push for increasing the number of
counters. But getting new hardware
counters takes time. Short term, we can investigate what it would take
to free one cycle-capable
counter which is commandeered by the hard lockup detector on all X86
processors today. The functionality
of the watchdog, being able to get a crash dump on kernel deadlocks,
is important and we cannot simply
disable it. At scale, many bugs are exposed and thus machines
deadlock. Therefore, we want to investigate
what it would take to move the detector to another NMI-capable source,
such as the HPET because the
detector does not need high low granularity timer and interrupts only every 2s.

Furthermore, recent Intel erratum, e.g., the TSX issue forcing the TFA
code in perf_events, have increased the pressure
even more with only 3 generic counters left. Thus, it is time to look
at alternative ways of  getting a hard lockup detector
(NMI watchdog) from another NMI source than the PMU. To that extent, I
have been discussing about alternatives.
Intel suggested using the HPET and Ricardo has been working on
producing this patch series. It is clear from your review
that the patches have issues, but I am hoping that they can be
resolved with constructive feedback knowing what the end goal is.

As for the round-robin changes, yes, we discussed this as an
alternative to avoid overloading CPU0 with handling
all of the work to broadcasting IPI to 100+ other CPUs.

Thanks.
