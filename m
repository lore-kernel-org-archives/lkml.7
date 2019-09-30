Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F7EC35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4778121855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbfI3K42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:56:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:51423 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730705AbfI3K42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 06:56:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 03:56:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,565,1559545200"; 
   d="scan'208";a="204804555"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 30 Sep 2019 03:56:24 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 30 Sep 2019 13:56:23 +0300
Date:   Mon, 30 Sep 2019 13:56:23 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Tuowen Zhao <ztuowen@gmail.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, acelan.kao@canonical.com,
        bhelgaas@google.com, kai.heng.feng@canonical.com
Subject: Re: [PATCH] mfd: intel-lpss: use devm_ioremap_uc for mmio
Message-ID: <20190930105623.GU2714@lahna.fi.intel.com>
References: <20190927175513.31054-1-ztuowen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927175513.31054-1-ztuowen@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In $subject, use MMIO instead of mmio.

On Fri, Sep 27, 2019 at 11:55:13AM -0600, Tuowen Zhao wrote:
> Write-combining BAR for intel-lpss-pci in MTRR causes system hangs
> during boot.
> 
> This patch adds devm_ioremap_uc as a new managed wrapper to ioremap_uc
> and with it forces the use of strongly uncachable mmio in intel-lpss.
> 
> This bahavior is seen on Dell XPS 13 7390 2-in-1:
> 
> [    0.001734]   5 base 4000000000 mask 6000000000 write-combining

I think it is worth mentioning that this is actually a BIOS bug and
fixed by some vendors via BIOS upgrade.

> 4000000000-7fffffffff : PCI Bus 0000:00
>   4000000000-400fffffff : 0000:00:02.0 (i915)
>   4010000000-4010000fff : 0000:00:15.0 (intel-lpss-pci)
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203485
> Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
> ---
>  drivers/mfd/intel-lpss.c |  2 +-
>  include/linux/io.h       |  2 ++
>  lib/devres.c             | 19 +++++++++++++++++++
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
> index 277f48f1cc1c..06106c9320bb 100644
> --- a/drivers/mfd/intel-lpss.c
> +++ b/drivers/mfd/intel-lpss.c
> @@ -395,7 +395,7 @@ int intel_lpss_probe(struct device *dev,
>  	if (!lpss)
>  		return -ENOMEM;
>  
> -	lpss->priv = devm_ioremap(dev, info->mem->start + LPSS_PRIV_OFFSET,
> +	lpss->priv = devm_ioremap_uc(dev, info->mem->start + LPSS_PRIV_OFFSET,
>  				  LPSS_PRIV_SIZE);

Can you add a comment here explaining why this particular driver needs
to use _uc version? Normally drivers call the plain devm_ioremap() and
expect to get non-cached memory, however ioremap() (which resolves to
ioremap_nocache()) does not touch x86 PAT configuration which is the
reason we need to call _uc variant here.

Otherwise looks good to me.
