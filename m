Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CE4C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6C220720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgAHQjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:39:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:3078 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727127AbgAHQjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:39:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 08:39:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="254278028"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jan 2020 08:39:03 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipEMJ-0005RW-N4; Wed, 08 Jan 2020 18:39:03 +0200
Date:   Wed, 8 Jan 2020 18:39:03 +0200
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
Subject: Re: [PATCH v2 03/36] platform/x86: intel_scu_ipc: Add constants for
 register offsets
Message-ID: <20200108163903.GW32742@smile.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-4-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108114201.27908-4-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:41:28PM +0300, Mika Westerberg wrote:
> This makes the code more readable. These are taken from intel_pmc_ipc.c
> which implements the same thing.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/platform/x86/intel_scu_ipc.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index cdab916fbf92..a8be5bcb9832 100644
> --- a/drivers/platform/x86/intel_scu_ipc.c
> +++ b/drivers/platform/x86/intel_scu_ipc.c
> @@ -99,11 +99,15 @@ struct intel_scu_ipc_dev {
>  
>  static struct intel_scu_ipc_dev  ipcdev; /* Only one for now */
>  
> +#define IPC_STATUS		0x04
> +#define IPC_STATUS_ERR		BIT(1)
> +#define IPC_STATUS_BUSY		BIT(0)
> +
>  /*
> - * IPC Read Buffer (Read Only):
> - * 16 byte buffer for receiving data from SCU, if IPC command
> - * processing results in response data
> + * IPC Write/Read Buffers:
> + * 16 byte buffer for sending and receiving data to and from SCU.
>   */
> +#define IPC_WRITE_BUFFER	0x80
>  #define IPC_READ_BUFFER		0x90
>  
>  #define IPC_I2C_CNTRL_ADDR	0
> @@ -135,7 +139,7 @@ static inline void ipc_command(struct intel_scu_ipc_dev *scu, u32 cmd)
>   */
>  static inline void ipc_data_writel(struct intel_scu_ipc_dev *scu, u32 data, u32 offset)
>  {
> -	writel(data, scu->ipc_base + 0x80 + offset);
> +	writel(data, scu->ipc_base + IPC_WRITE_BUFFER + offset);
>  }
>  
>  /*
> @@ -147,7 +151,7 @@ static inline void ipc_data_writel(struct intel_scu_ipc_dev *scu, u32 data, u32
>   */
>  static inline u8 ipc_read_status(struct intel_scu_ipc_dev *scu)
>  {
> -	return __raw_readl(scu->ipc_base + 0x04);
> +	return __raw_readl(scu->ipc_base + IPC_STATUS);
>  }
>  
>  /* Read ipc byte data */
> @@ -169,17 +173,17 @@ static inline int busy_loop(struct intel_scu_ipc_dev *scu)
>  	u32 loop_count = 100000;
>  
>  	/* break if scu doesn't reset busy bit after huge retry */
> -	while ((status & BIT(0)) && --loop_count) {
> +	while ((status & IPC_STATUS_BUSY) && --loop_count) {
>  		udelay(1); /* scu processing time is in few u secods */
>  		status = ipc_read_status(scu);
>  	}
>  
> -	if (status & BIT(0)) {
> +	if (status & IPC_STATUS_BUSY) {
>  		dev_err(scu->dev, "IPC timed out");
>  		return -ETIMEDOUT;
>  	}
>  
> -	if (status & BIT(1))
> +	if (status & IPC_STATUS_ERR)
>  		return -EIO;
>  
>  	return 0;
> @@ -196,7 +200,7 @@ static inline int ipc_wait_for_interrupt(struct intel_scu_ipc_dev *scu)
>  	}
>  
>  	status = ipc_read_status(scu);
> -	if (status & BIT(1))
> +	if (status & IPC_STATUS_ERR)
>  		return -EIO;
>  
>  	return 0;
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


