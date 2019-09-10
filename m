Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFF4C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B9121019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393380AbfIJOmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:42:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:12299 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393221AbfIJOmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:42:20 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 07:42:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="184187283"
Received: from agreppma-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.7])
  by fmsmga008.fm.intel.com with ESMTP; 10 Sep 2019 07:42:16 -0700
Date:   Tue, 10 Sep 2019 15:42:15 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Vanya Lazeev <ivan.lazeev@gmail.com>
Subject: Re: [PATCH v2 2/2] tpm: tpm_crb: enhance resource mapping mechanism
 for supporting AMD's fTPM
Message-ID: <20190910144215.GA30780@linux.intel.com>
References: <20190909090906.28700-1-kkamagui@gmail.com>
 <20190909090906.28700-3-kkamagui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190909090906.28700-3-kkamagui@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 06:09:06PM +0900, Seunghun Han wrote:
> I got an AMD system which had a Ryzen Threadripper 1950X and MSI
> mainboard, and I had a problem with AMD's fTPM. My machine showed an error
> message below, and the fTPM didn't work because of it.
> 
> [  5.732084] tpm_crb MSFT0101:00: can't request region for resource
>              [mem 0x79b4f000-0x79b4ffff]
> [  5.732089] tpm_crb: probe of MSFT0101:00 failed with error -16
> 
> When I saw the iomem, I found two fTPM regions were in the ACPI NVS area. 
> The regions are below.
> 
> 79a39000-79b6afff : ACPI Non-volatile Storage
>   79b4b000-79b4bfff : MSFT0101:00
>   79b4f000-79b4ffff : MSFT0101:00
> 
> After analyzing this issue, I found that crb_map_io() function called
> devm_ioremap_resource() and it failed. The ACPI NVS didn't allow the TPM
> CRB driver to assign a resource in it because a busy bit was set to
> the ACPI NVS area.
> 
> To support AMD's fTPM, I added a function to check intersects between
> the TPM region and ACPI NVS before it mapped the region. If some
> intersects are detected, the function just calls devm_ioremap() for
> a workaround. If there is no intersect, it calls devm_ioremap_resource().
> 
> Signed-off-by: Seunghun Han <kkamagui@gmail.com>

This problem is still valid and not addressed by Vanya's patch (and
should not be as it is a disjoint issue).  However, calling
devm_ioremap() is somewhat racy as the NVS driver is not aware of that.

My take is that this should be fixed in the code that assigns regions to
the NVS driver e.g. it could look up the regions assigned to the
MSFT0101 and ignore those regions. In the end linux-acpi maintainers
have the say on this but this would be the angle that I'd take to
implement such patch probably.

/Jarkko
