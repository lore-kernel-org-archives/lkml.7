Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C70C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 18:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FA420870
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 18:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfFPSml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 14:42:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41993 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfFPSmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 14:42:40 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hca6i-0002sP-VE; Sun, 16 Jun 2019 20:42:25 +0200
Date:   Sun, 16 Jun 2019 20:42:23 +0200 (CEST)
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
Subject: Re: [RFC PATCH v4 20/21] iommu/vt-d: hpet: Reserve an interrupt
 remampping table entry for watchdog
In-Reply-To: <1558660583-28561-21-git-send-email-ricardo.neri-calderon@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1906162039260.1760@nanos.tec.linutronix.de>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1558660583-28561-21-git-send-email-ricardo.neri-calderon@linux.intel.com>
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

On Thu, 23 May 2019, Ricardo Neri wrote:

> When interrupt remapping is enabled, MSI interrupt messages must follow a
> special format that the IOMMU can understand. Hence, when the HPET hard
> lockup detector is used with interrupt remapping, it must also follow this
> special format.
> 
> The IOMMU, given the information about a particular interrupt, already
> knows how to populate the MSI message with this special format and the
> corresponding entry in the interrupt remapping table. Given that this is a
> special interrupt case, we want to avoid the interrupt subsystem. Add two
> functions to create an entry for the HPET hard lockup detector. Perform
> this process in two steps as described below.
> 
> When initializing the lockup detector, the function
> hld_hpet_intremap_alloc_irq() permanently allocates a new entry in the
> interrupt remapping table and populates it with the information the
> IOMMU driver needs. In order to populate the table, the IOMMU needs to
> know the HPET block ID as described in the ACPI table. Hence, add such
> ID to the data of the hardlockup detector.
> 
> When the hardlockup detector is enabled, the function
> hld_hpet_intremapactivate_irq() activates the recently created entry
> in the interrupt remapping table via the modify_irte() functions. While
> doing this, it specifies which CPU the interrupt must target via its APIC
> ID. This function can be called every time the destination iD of the
> interrupt needs to be updated; there is no need to allocate or remove
> entries in the interrupt remapping table.

And except for a few details all of this functionality exists today. There
is no need to hack HPET NMI specific knowledge into the irq remapping
driver. And of course to unbreak AMD you'd have to copy the same hackery
into the AMD interrupt remapping code.

More lines of duplicated duct tape code are better to maintain, right?

Sigh.

	tglx
