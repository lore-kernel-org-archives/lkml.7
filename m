Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9FCC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAD92075D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgAHQ6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:58:03 -0500
Received: from mga05.intel.com ([192.55.52.43]:46379 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbgAHQ6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:58:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 08:57:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="422974167"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jan 2020 08:57:49 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipEeT-0005gJ-AJ; Wed, 08 Jan 2020 18:57:49 +0200
Date:   Wed, 8 Jan 2020 18:57:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 30/36] platform/x86: intel_pmc_ipc: Drop
 intel_pmc_ipc_command()
Message-ID: <20200108165749.GP32742@smile.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-31-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108114201.27908-31-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:41:55PM +0300, Mika Westerberg wrote:
> Now that all callers have been converted over to the SCU IPC API we can
> drop intel_pmc_ipc_command().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  arch/x86/include/asm/intel_pmc_ipc.h |  8 --------
>  drivers/platform/x86/intel_pmc_ipc.c | 21 ---------------------
>  2 files changed, 29 deletions(-)
> 
> diff --git a/arch/x86/include/asm/intel_pmc_ipc.h b/arch/x86/include/asm/intel_pmc_ipc.h
> index ddc964b9c78c..22848df5faaf 100644
> --- a/arch/x86/include/asm/intel_pmc_ipc.h
> +++ b/arch/x86/include/asm/intel_pmc_ipc.h
> @@ -27,19 +27,11 @@
>  
>  #if IS_ENABLED(CONFIG_INTEL_PMC_IPC)
>  
> -int intel_pmc_ipc_command(u32 cmd, u32 sub, u8 *in, u32 inlen,
> -		u32 *out, u32 outlen);
>  int intel_pmc_s0ix_counter_read(u64 *data);
>  int intel_pmc_gcr_read64(u32 offset, u64 *data);
>  
>  #else
>  
> -static inline int intel_pmc_ipc_command(u32 cmd, u32 sub, u8 *in, u32 inlen,
> -		u32 *out, u32 outlen)
> -{
> -	return -EINVAL;
> -}
> -
>  static inline int intel_pmc_s0ix_counter_read(u64 *data)
>  {
>  	return -EINVAL;
> diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
> index 10505fbd01b5..241bce603183 100644
> --- a/drivers/platform/x86/intel_pmc_ipc.c
> +++ b/drivers/platform/x86/intel_pmc_ipc.c
> @@ -194,27 +194,6 @@ static int update_no_reboot_bit(void *priv, bool set)
>  				    PMC_CFG_NO_REBOOT_MASK, value);
>  }
>  
> -/**
> - * intel_pmc_ipc_command() -  IPC command with input/output data
> - * @cmd:	IPC command code.
> - * @sub:	IPC command sub type.
> - * @in:		input data of this IPC command.
> - * @inlen:	input data length in bytes.
> - * @out:	output data of this IPC command.
> - * @outlen:	output data length in dwords.
> - *
> - * Send an IPC command to PMC with input/output data.
> - *
> - * Return:	an IPC error code or 0 on success.
> - */
> -int intel_pmc_ipc_command(u32 cmd, u32 sub, u8 *in, u32 inlen,
> -			  u32 *out, u32 outlen)
> -{
> -	return intel_scu_ipc_dev_command(NULL, cmd, sub, in, inlen, out,
> -					 outlen);
> -}
> -EXPORT_SYMBOL_GPL(intel_pmc_ipc_command);
> -
>  static int ipc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct intel_pmc_ipc_dev *pmc = &ipcdev;
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


