Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F21C31E54
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 08:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474AD216FD
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 08:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfFPIoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 04:44:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41602 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfFPIoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 04:44:22 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hcQln-0007En-Ac; Sun, 16 Jun 2019 10:44:11 +0200
Date:   Sun, 16 Jun 2019 10:44:09 +0200 (CEST)
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
Subject: Re: [RFC PATCH v4 21/21] x86/watchdog/hardlockup/hpet: Support
 interrupt remapping
In-Reply-To: <1558660583-28561-22-git-send-email-ricardo.neri-calderon@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1906161042080.1760@nanos.tec.linutronix.de>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1558660583-28561-22-git-send-email-ricardo.neri-calderon@linux.intel.com>
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
> +/** irq_remapping_enabled() - Detect if interrupt remapping is enabled
> + * @hdata:	A data structure with the HPET block id
> + *
> + * Determine if the HPET block that the hardlockup detector is under
> + * the remapped interrupt domain.
> + *
> + * Returns: True interrupt remapping is enabled. False otherwise.
> + */
> +static bool irq_remapping_enabled(struct hpet_hld_data *hdata)
> +{
> +	struct irq_alloc_info info;
> +
> +	init_irq_alloc_info(&info, NULL);
> +	info.type = X86_IRQ_ALLOC_TYPE_HPET;
> +	info.hpet_id = hdata->blockid;
> +
> +	return !!irq_remapping_get_ir_irq_domain(&info);
> +}
> +
>  /**
>   * compose_msi_msg() - Populate address and data fields of an MSI message
>   * @hdata:	A data strucure with the message to populate
> @@ -161,6 +181,9 @@ static int update_msi_destid(struct hpet_hld_data *hdata)
>  {
>  	u32 destid;
>  
> +	if (irq_remapping_enabled(hdata))
> +		return hld_hpet_intremap_activate_irq(hdata);

No. This is horrible hackery violating all the layering which we carefully
put into place to avoid exactly this kind of sprinkling conditionals into
all code pathes.

With some thought the existing irqdomain hierarchy can be used to achieve
the same thing without tons of extra functions and conditionals.

Thanks,

	tglx
