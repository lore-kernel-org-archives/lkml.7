Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A1BC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC33D20850
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfFNQKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:10:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38817 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfFNQKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:10:34 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hbomR-0002i5-69; Fri, 14 Jun 2019 18:10:19 +0200
Date:   Fri, 14 Jun 2019 18:10:18 +0200 (CEST)
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
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH v4 05/21] x86/hpet: Reserve timer for the HPET
 hardlockup detector
In-Reply-To: <20190614011454.GA6347@ranerica-svr.sc.intel.com>
Message-ID: <alpine.DEB.2.21.1906141726190.1722@nanos.tec.linutronix.de>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1558660583-28561-6-git-send-email-ricardo.neri-calderon@linux.intel.com> <alpine.DEB.2.21.1906112152430.2214@nanos.tec.linutronix.de>
 <20190614011454.GA6347@ranerica-svr.sc.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019, Ricardo Neri wrote:

> On Tue, Jun 11, 2019 at 09:54:25PM +0200, Thomas Gleixner wrote:
> > On Thu, 23 May 2019, Ricardo Neri wrote:
> > 
> > > HPET timer 2 will be used to drive the HPET-based hardlockup detector.
> > > Reserve such timer to ensure it cannot be used by user space programs or
> > > for clock events.
> > > 
> > > When looking for MSI-capable timers for clock events, skip timer 2 if
> > > the HPET hardlockup detector is selected.
> > 
> > Why? Both the changelog and the code change lack an explanation why this
> > timer is actually touched after it got reserved for the platform. The
> > reservation should make it inaccessible for other things.
> 
> hpet_reserve_platform_timers() will give the HPET char driver a data
> structure which specifies which drivers are reserved. In this manner,
> they cannot be used by applications via file opens. The timer used by
> the hardlockup detector should be marked as reserved.
> 
> Also, hpet_msi_capability_lookup() populates another data structure
> which is used when obtaining an unused timer for a HPET clock event.
> The timer used by the hardlockup detector should not be included in such
> data structure.
> 
> Is this the explanation you would like to see? If yes, I will include it
> in the changelog.

Yes, the explanation makes sense. The code still sucks. Not really your
fault, but this is not making it any better.

What bothers me most is the fact that CONFIG_X86_HARDLOCKUP_DETECTOR_HPET
removes one HPET timer unconditionally. It neither checks whether the hpet
watchdog is actually enabled on the command line, nor does it validate
upfront whether the HPET supports FSB delivery.

That wastes an HPET timer unconditionally for no value. Not that I
personally care much about /dev/hpet, but some older laptops depend on HPET
per cpu timers as the local APIC timer stops in C2/3. So this unconditional
reservation will cause regressions for no reason.

The proper approach here is to:

 1) Evaluate the command line _before_ hpet_enable() is invoked

 2) Check the availability of FSB delivery in hpet_enable()

Reserve an HPET channel for the watchdog only when #1 and #2 are true.

Thanks,

	tglx


