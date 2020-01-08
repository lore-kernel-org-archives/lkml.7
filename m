Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFB4C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6DB20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgAHRMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:12:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:14599 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgAHRMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:12:49 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 09:12:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="216013815"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 08 Jan 2020 09:12:44 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipEsu-0005pI-6f; Wed, 08 Jan 2020 19:12:44 +0200
Date:   Wed, 8 Jan 2020 19:12:44 +0200
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
Subject: Re: [PATCH v2 07/36] platform/x86: intel_scu_ipc: Sleeping is fine
 when polling
Message-ID: <20200108171244.GT32742@smile.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-8-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108114201.27908-8-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:41:32PM +0300, Mika Westerberg wrote:
> There is no reason why the driver would need to block other threads from
> running the CPU while it is waiting for the SCU IPC to complete its
> work. For this reason switch the driver to use usleep_range() instead
> with a bit more relaxed polling loop.

I agree on this and if somebody finds a race condition that had been hidden by
the original code it will mean that somewhere else something is completely
broken.

> 
> Also add constant for the timeout and use the same value for both
> polling and interrupt modes.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/platform/x86/intel_scu_ipc.c | 29 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index 43eaf9400c67..8db0644900a3 100644
> --- a/drivers/platform/x86/intel_scu_ipc.c
> +++ b/drivers/platform/x86/intel_scu_ipc.c
> @@ -79,6 +79,9 @@ static struct intel_scu_ipc_dev  ipcdev; /* Only one for now */
>  #define IPC_WRITE_BUFFER	0x80
>  #define IPC_READ_BUFFER		0x90
>  
> +/* Timeout in jiffies */
> +#define IPC_TIMEOUT		(3 * HZ)
> +
>  static DEFINE_MUTEX(ipclock); /* lock used to prevent multiple call to SCU */
>  
>  /*
> @@ -132,24 +135,20 @@ static inline u32 ipc_data_readl(struct intel_scu_ipc_dev *scu, u32 offset)
>  /* Wait till scu status is busy */
>  static inline int busy_loop(struct intel_scu_ipc_dev *scu)
>  {
> -	u32 status = ipc_read_status(scu);
> -	u32 loop_count = 100000;
> +	unsigned long end = jiffies + msecs_to_jiffies(IPC_TIMEOUT);
>  
> -	/* break if scu doesn't reset busy bit after huge retry */
> -	while ((status & IPC_STATUS_BUSY) && --loop_count) {
> -		udelay(1); /* scu processing time is in few u secods */
> -		status = ipc_read_status(scu);
> -	}
> +	do {
> +		u32 status;
>  
> -	if (status & IPC_STATUS_BUSY) {
> -		dev_err(scu->dev, "IPC timed out");
> -		return -ETIMEDOUT;
> -	}
> +		status = ipc_read_status(scu);
> +		if (!(status & IPC_STATUS_BUSY))
> +			return (status & IPC_STATUS_ERR) ? -EIO : 0;
>  
> -	if (status & IPC_STATUS_ERR)
> -		return -EIO;
> +		usleep_range(50, 100);
> +	} while (time_before(jiffies, end));
>  
> -	return 0;
> +	dev_err(scu->dev, "IPC timed out");
> +	return -ETIMEDOUT;
>  }
>  
>  /* Wait till ipc ioc interrupt is received or timeout in 3 HZ */
> @@ -157,7 +156,7 @@ static inline int ipc_wait_for_interrupt(struct intel_scu_ipc_dev *scu)
>  {
>  	int status;
>  
> -	if (!wait_for_completion_timeout(&scu->cmd_complete, 3 * HZ)) {
> +	if (!wait_for_completion_timeout(&scu->cmd_complete, IPC_TIMEOUT)) {
>  		dev_err(scu->dev, "IPC timed out\n");
>  		return -ETIMEDOUT;
>  	}
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


