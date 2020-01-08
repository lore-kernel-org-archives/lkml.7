Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE8EC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEFD20692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgAHQkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:40:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:27667 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbgAHQkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:40:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 08:40:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="370992633"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 08 Jan 2020 08:40:45 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipENy-0005T1-0v; Wed, 08 Jan 2020 18:40:46 +0200
Date:   Wed, 8 Jan 2020 18:40:46 +0200
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
Subject: Re: [PATCH v2 06/36] platform/x86: intel_scu_ipc: Fix interrupt
 support
Message-ID: <20200108164046.GZ32742@smile.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-7-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108114201.27908-7-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:41:31PM +0300, Mika Westerberg wrote:
> Currently the driver has disabled interrupt support for Tangier but
> actually interrupt works just fine if the command is not written twice
> in a row. Also we need to ack the interrupt in the handler.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/platform/x86/intel_scu_ipc.c | 48 ++++++----------------------
>  1 file changed, 10 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index b39680b53387..43eaf9400c67 100644
> --- a/drivers/platform/x86/intel_scu_ipc.c
> +++ b/drivers/platform/x86/intel_scu_ipc.c
> @@ -58,24 +58,6 @@
>  #define IPC_RWBUF_SIZE    20		/* IPC Read buffer Size */
>  #define IPC_IOC	          0x100		/* IPC command register IOC bit */
>  
> -#define PCI_DEVICE_ID_PENWELL		0x080e
> -#define PCI_DEVICE_ID_CLOVERVIEW	0x08ea
> -#define PCI_DEVICE_ID_TANGIER		0x11a0
> -
> -/* intel scu ipc driver data */
> -struct intel_scu_ipc_pdata_t {
> -	u8 irq_mode;
> -};
> -
> -/* Penwell and Cloverview */
> -static const struct intel_scu_ipc_pdata_t intel_scu_ipc_penwell_pdata = {
> -	.irq_mode = 1,
> -};
> -
> -static const struct intel_scu_ipc_pdata_t intel_scu_ipc_tangier_pdata = {
> -	.irq_mode = 0,
> -};
> -
>  struct intel_scu_ipc_dev {
>  	struct device *dev;
>  	void __iomem *ipc_base;
> @@ -86,6 +68,7 @@ struct intel_scu_ipc_dev {
>  static struct intel_scu_ipc_dev  ipcdev; /* Only one for now */
>  
>  #define IPC_STATUS		0x04
> +#define IPC_STATUS_IRQ		BIT(2)
>  #define IPC_STATUS_ERR		BIT(1)
>  #define IPC_STATUS_BUSY		BIT(0)
>  
> @@ -107,11 +90,8 @@ static DEFINE_MUTEX(ipclock); /* lock used to prevent multiple call to SCU */
>   */
>  static inline void ipc_command(struct intel_scu_ipc_dev *scu, u32 cmd)
>  {
> -	if (scu->irq_mode) {
> -		reinit_completion(&scu->cmd_complete);
> -		writel(cmd | IPC_IOC, scu->ipc_base);
> -	}
> -	writel(cmd, scu->ipc_base);
> +	reinit_completion(&scu->cmd_complete);
> +	writel(cmd | IPC_IOC, scu->ipc_base);
>  }
>  
>  /*
> @@ -549,9 +529,10 @@ EXPORT_SYMBOL_GPL(intel_scu_ipc_raw_command);
>  static irqreturn_t ioc(int irq, void *dev_id)
>  {
>  	struct intel_scu_ipc_dev *scu = dev_id;
> +	int status = ipc_read_status(scu);
>  
> -	if (scu->irq_mode)
> -		complete(&scu->cmd_complete);
> +	writel(status | IPC_STATUS_IRQ, scu->ipc_base + IPC_STATUS);
> +	complete(&scu->cmd_complete);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -568,17 +549,10 @@ static int ipc_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	int err;
>  	struct intel_scu_ipc_dev *scu = &ipcdev;
> -	struct intel_scu_ipc_pdata_t *pdata;
>  
>  	if (scu->dev)		/* We support only one SCU */
>  		return -EBUSY;
>  
> -	pdata = (struct intel_scu_ipc_pdata_t *)id->driver_data;
> -	if (!pdata)
> -		return -ENODEV;
> -
> -	scu->irq_mode = pdata->irq_mode;
> -
>  	err = pcim_enable_device(pdev);
>  	if (err)
>  		return err;
> @@ -605,13 +579,11 @@ static int ipc_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	return 0;
>  }
>  
> -#define SCU_DEVICE(id, pdata)	{PCI_VDEVICE(INTEL, id), (kernel_ulong_t)&pdata}
> -
>  static const struct pci_device_id pci_ids[] = {
> -	SCU_DEVICE(PCI_DEVICE_ID_PENWELL,	intel_scu_ipc_penwell_pdata),
> -	SCU_DEVICE(PCI_DEVICE_ID_CLOVERVIEW,	intel_scu_ipc_penwell_pdata),
> -	SCU_DEVICE(PCI_DEVICE_ID_TANGIER,	intel_scu_ipc_tangier_pdata),
> -	{}
> +	{ PCI_VDEVICE(INTEL, 0x080e) },
> +	{ PCI_VDEVICE(INTEL, 0x08ea) },
> +	{ PCI_VDEVICE(INTEL, 0x11a0) },
> +	{ }
>  };
>  
>  static struct pci_driver ipc_driver = {
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


