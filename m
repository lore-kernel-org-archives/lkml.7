Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E069C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 07:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B751208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 07:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfFVHXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 03:23:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57509 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfFVHXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 03:23:04 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1heaL9-0003VY-9L; Sat, 22 Jun 2019 09:21:35 +0200
Date:   Sat, 22 Jun 2019 09:21:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
cc:     Jacob Pan <jacob.jun.pan@intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
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
        Bjorn Helgaas <bhelgaas@google.com>,
        Juergen Gross <jgross@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [RFC PATCH v4 20/21] iommu/vt-d: hpet: Reserve an interrupt
 remampping table entry for watchdog
In-Reply-To: <20190621235541.GA25773@ranerica-svr.sc.intel.com>
Message-ID: <alpine.DEB.2.21.1906220920270.5503@nanos.tec.linutronix.de>
References: <1558660583-28561-21-git-send-email-ricardo.neri-calderon@linux.intel.com> <alpine.DEB.2.21.1906162049300.1760@nanos.tec.linutronix.de> <alpine.DEB.2.21.1906171007360.1760@nanos.tec.linutronix.de> <CABPqkBTai76Bgb4E61tF-mJUkFNxVa4B8M2bxTEYVgBsuAANNQ@mail.gmail.com>
 <alpine.DEB.2.21.1906172343120.1963@nanos.tec.linutronix.de> <20190619084316.71ce5477@jacob-builder> <alpine.DEB.2.21.1906211732330.5503@nanos.tec.linutronix.de> <20190621103126.585ca6d3@jacob-builder> <20190621113938.1679f329@jacob-builder>
 <alpine.DEB.2.21.1906212201400.5503@nanos.tec.linutronix.de> <20190621235541.GA25773@ranerica-svr.sc.intel.com>
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

On Fri, 21 Jun 2019, Ricardo Neri wrote:
> On Fri, Jun 21, 2019 at 10:05:01PM +0200, Thomas Gleixner wrote:
> > On Fri, 21 Jun 2019, Jacob Pan wrote:
> > > > 
> > > I looked at the code again, seems the per cpu HPET code already taken
> > > care of HPET MSI management. Why can't we use IR-HPET-MSI chip and
> > > domain to allocate and set affinity etc.?
> > > Most APIC timer has ARAT not enough per cpu HPET, so per cpu HPET is
> > > not used mostly.
> > 
> > Sure, we can use that, but that does not allow to move the affinity from
> > NMI context either. Same issue with the IOMMU as with the other hack.
> 
> If I understand Thomas' point correctly, the problem is having to take
> lock in NMI context to update the IRTE for the HPET; both as in my hack
> and in the generic irq code. The problem is worse when using the generic
> irq code as there are several layers and several locks that need to be
> handled.

It does not matter how many locks are involved. One is enough to wedge the
machine.

Thanks,

	tglx


