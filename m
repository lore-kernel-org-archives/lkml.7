Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3BCC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AE0206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391748AbfIMNco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:32:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:1052 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389185AbfIMNMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:12:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 06:12:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,501,1559545200"; 
   d="scan'208";a="215371241"
Received: from ddungax-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.37.38])
  by fmsmga002.fm.intel.com with ESMTP; 13 Sep 2019 06:12:35 -0700
Date:   Fri, 13 Sep 2019 14:12:34 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vanya Lazeev <ivan.lazeev@gmail.com>
Subject: Re: [PATCH v2 2/2] tpm: tpm_crb: enhance resource mapping mechanism
 for supporting AMD's fTPM
Message-ID: <20190913131234.GA7412@linux.intel.com>
References: <20190909090906.28700-1-kkamagui@gmail.com>
 <20190909090906.28700-3-kkamagui@gmail.com>
 <20190910144215.GA30780@linux.intel.com>
 <20190910150342.GA1920@linux.intel.com>
 <CAHjaAcRf3fcJMp6AwVRTrVaABZVzSkhBwRcpKZogAS4SSDK3zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHjaAcRf3fcJMp6AwVRTrVaABZVzSkhBwRcpKZogAS4SSDK3zg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 12:28:18AM +0900, Seunghun Han wrote:
> > Matthew pointed out that having a hook in NVS driver is better solution
> > because it is nil functionality if the TPM driver is loaded. We need
> > functions to:
> >
> > 1. Request a region from the NVS driver (when tpm_crb loads)
> > 2. Release a region back to the NVS Driver (when tpm_crb unloads).
> >
> > My proposal would unnecessarily duplicate code and also leave a
> > side-effect when TPM is not used in the first place.
> >
> > I see this as the overally best solution. If you can come up with a
> > patch for the NVS side and changes to CRB drivers to utilize the new
> > hooks, then combined with Vanya's changes we have a sustainable solution
> > for AMD fTPM.
> 
> It's a great solution. I will update this patch on your advice and
> send it to you soon.
> 
> By the way, I have a question about your advice.
> If we handle the NVS region with NVS driver, calling devm_ioremap()
> function is fine like crb_ioremap_resource() function in this patch?

No, you should reclaim the resource that conflicts and return it back
when tpm_crb is unregistered (e.g. rmmod tpm_crb).

I would try something like enumerating iomem resources with
walk_iomem_res_desc(). I would advice to peek at arch/x86/kernel/crash.c
for an example how to use this for NVS regions
(IORES_DESC_ACPI_NV_STORAGE).

E.g. you could use a callback for it along the lines of:

static int crb_find_iomem_res_cb(struct resource *res, void *io_res_ptr)
{
	struct resource *io_res = io_res_ptr;

	if (res->start == io_res->start && res->end == io_res->end) {
		/*
		 * Backup all resource data so that it can be inserted
		 * later on with the flags it had etc.
		 */
		*io_res = *res;
		return 1;
	}

	return 0;
}

Then you could __release_region() to unallocate the source. When tpm_crb
is removed you can then allocate and insert a resource with data
matching it had.


/Jarkko
