Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2EEC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E28B20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgAHQpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:45:39 -0500
Received: from mga11.intel.com ([192.55.52.93]:4236 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbgAHQpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:45:39 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 08:45:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="217559465"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jan 2020 08:45:33 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipESb-0005Wn-Rg; Wed, 08 Jan 2020 18:45:33 +0200
Date:   Wed, 8 Jan 2020 18:45:33 +0200
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
Subject: Re: [PATCH v2 17/36] platform/x86: intel_scu_ipcutil: Convert to use
 new SCU IPC API
Message-ID: <20200108164533.GG32742@smile.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-18-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108114201.27908-18-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:41:42PM +0300, Mika Westerberg wrote:
> Convert the IPC util to use the new SCU IPC API where the SCU IPC
> instance is passed to the functions.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/platform/x86/intel_scu_ipcutil.c | 43 +++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_scu_ipcutil.c b/drivers/platform/x86/intel_scu_ipcutil.c
> index 8afe6fa06d7b..b7c10c15a3d6 100644
> --- a/drivers/platform/x86/intel_scu_ipcutil.c
> +++ b/drivers/platform/x86/intel_scu_ipcutil.c
> @@ -22,6 +22,9 @@
>  
>  static int major;
>  
> +struct intel_scu_ipc_dev *scu;
> +static DEFINE_MUTEX(scu_lock);
> +
>  /* IOCTL commands */
>  #define	INTE_SCU_IPC_REGISTER_READ	0
>  #define INTE_SCU_IPC_REGISTER_WRITE	1
> @@ -52,12 +55,12 @@ static int scu_reg_access(u32 cmd, struct scu_ipc_data  *data)
>  
>  	switch (cmd) {
>  	case INTE_SCU_IPC_REGISTER_READ:
> -		return intel_scu_ipc_readv(data->addr, data->data, count);
> +		return intel_scu_ipc_dev_readv(scu, data->addr, data->data, count);
>  	case INTE_SCU_IPC_REGISTER_WRITE:
> -		return intel_scu_ipc_writev(data->addr, data->data, count);
> +		return intel_scu_ipc_dev_writev(scu, data->addr, data->data, count);
>  	case INTE_SCU_IPC_REGISTER_UPDATE:
> -		return intel_scu_ipc_update_register(data->addr[0],
> -						    data->data[0], data->mask);
> +		return intel_scu_ipc_dev_update(scu, data->addr[0], data->data[0],
> +						data->mask);
>  	default:
>  		return -ENOTTY;
>  	}
> @@ -91,8 +94,40 @@ static long scu_ipc_ioctl(struct file *fp, unsigned int cmd,
>  	return 0;
>  }
>  
> +static int scu_ipc_open(struct inode *inode, struct file *file)
> +{
> +	int ret = 0;
> +
> +	/* Only single open at the time */
> +	mutex_lock(&scu_lock);
> +	if (scu) {
> +		ret = -EBUSY;
> +		goto unlock;
> +	}
> +
> +	scu = intel_scu_ipc_dev_get();
> +	if (!scu)
> +		ret = -ENODEV;
> +
> +unlock:
> +	mutex_unlock(&scu_lock);
> +	return ret;
> +}
> +
> +static int scu_ipc_release(struct inode *inode, struct file *file)
> +{
> +	mutex_lock(&scu_lock);
> +	intel_scu_ipc_dev_put(scu);
> +	scu = NULL;
> +	mutex_unlock(&scu_lock);
> +
> +	return 0;
> +}
> +
>  static const struct file_operations scu_ipc_fops = {
>  	.unlocked_ioctl = scu_ipc_ioctl,
> +	.open = scu_ipc_open,
> +	.release = scu_ipc_release,
>  };
>  
>  static int __init ipc_module_init(void)
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


