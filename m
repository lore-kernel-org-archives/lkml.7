Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BACAC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DEE20692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgAHRhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:37:02 -0500
Received: from mga01.intel.com ([192.55.52.88]:41723 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727287AbgAHRhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:37:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 09:37:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="254297885"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jan 2020 09:36:57 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipFGL-00065H-9i; Wed, 08 Jan 2020 19:36:57 +0200
Date:   Wed, 8 Jan 2020 19:36:57 +0200
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
Subject: Re: [PATCH v2 31/36] x86/platform/intel-mid: Add empty stubs for
 intel_scu_devices_[create|destroy]()
Message-ID: <20200108173657.GB32742@smile.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-32-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108114201.27908-32-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:41:56PM +0300, Mika Westerberg wrote:
> This allows to call the functions even when CONFIG_X86_INTEL_MID is not
> enabled.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  arch/x86/include/asm/intel-mid.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/intel-mid.h b/arch/x86/include/asm/intel-mid.h
> index 8e5af119dc2d..de58391bdee0 100644
> --- a/arch/x86/include/asm/intel-mid.h
> +++ b/arch/x86/include/asm/intel-mid.h
> @@ -88,11 +88,17 @@ static inline bool intel_mid_has_msic(void)
>  	return (intel_mid_identify_cpu() == INTEL_MID_CPU_CHIP_PENWELL);
>  }
>  
> +extern void intel_scu_devices_create(void);
> +extern void intel_scu_devices_destroy(void);
> +
>  #else /* !CONFIG_X86_INTEL_MID */
>  
>  #define intel_mid_identify_cpu()	0
>  #define intel_mid_has_msic()		0
>  
> +static inline void intel_scu_devices_create(void) { }
> +static inline void intel_scu_devices_destroy(void) { }
> +
>  #endif /* !CONFIG_X86_INTEL_MID */
>  
>  enum intel_mid_timer_options {
> @@ -115,9 +121,6 @@ extern enum intel_mid_timer_options intel_mid_timer_options;
>  #define SFI_MTMR_MAX_NUM		8
>  #define SFI_MRTC_MAX			8
>  
> -extern void intel_scu_devices_create(void);
> -extern void intel_scu_devices_destroy(void);
> -
>  /* VRTC timer */
>  #define MRST_VRTC_MAP_SZ		1024
>  /* #define MRST_VRTC_PGOFFSET		0xc00 */
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


