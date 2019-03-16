Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CDEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E1A218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfCPIa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:30:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:18747 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfCPIa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:30:27 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Mar 2019 01:30:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,485,1544515200"; 
   d="scan'208";a="214704371"
Received: from raj-desk2.iind.intel.com ([10.223.107.30])
  by orsmga001.jf.intel.com with ESMTP; 16 Mar 2019 01:30:23 -0700
Date:   Sat, 16 Mar 2019 13:47:52 +0530
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        furquan@google.com, evgreen@google.com, rajatxjain@gmail.com,
        rajneesh.bhardwaj@linux.intel.com,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH 1/2] platform/x86: intel_pmc_core: Convert to a
 platform_driver
Message-ID: <20190316081752.GA21812@raj-desk2.iind.intel.com>
References: <20190313222124.229371-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313222124.229371-1-rajatja@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 03:21:23PM -0700, Rajat Jain wrote:
> Convert the intel_pmc_core driver to a platform driver. There is no
> functional change. Some code that tries to determine what kind of
> CPU this is, has been moved code is moved from pmc_core_probe() to

Possible typo here.

> pmc_core_init().
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>

Thanks for sending this. This is certainly useful to support suspend-resume
functionality for this driver which is otherwise only possible with PM
notifiers otherwise and that is not desirable. Initially this was a PCI
driver and after design discussion it was converted to module. I would like
to consult Andy and Srinivas for their opinion about binding it to actual
platform bus instead of the virtual bus as in its current form. In one of the
internal versions, we used a known acpi PNP HID.

> ---
> This is rebased off
> git://git.infradead.org/linux-platform-drivers-x86.git/for-next
> 
>  drivers/platform/x86/intel_pmc_core.c | 93 ++++++++++++++++++++-------
>  1 file changed, 68 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index f2c621b55f49..55578d07610c 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -19,6 +19,7 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/platform_device.h>
>  #include <linux/uaccess.h>
>  
>  #include <asm/cpu_device_id.h>
> @@ -854,12 +855,59 @@ static const struct dmi_system_id pmc_core_dmi_table[]  = {
>  	{}
>  };
>  
> -static int __init pmc_core_probe(void)
> +static int pmc_core_probe(struct platform_device *pdev)
>  {
> -	struct pmc_dev *pmcdev = &pmc;
> +	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
> +	int err;
> +
> +	pmcdev->regbase = ioremap(pmcdev->base_addr,
> +				  pmcdev->map->regmap_length);
> +	if (!pmcdev->regbase)
> +		return -ENOMEM;
> +
> +	mutex_init(&pmcdev->lock);
> +	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit();
> +
> +	err = pmc_core_dbgfs_register(pmcdev);
> +	if (err < 0) {
> +		dev_warn(&pdev->dev, "debugfs register failed.\n");
> +		iounmap(pmcdev->regbase);
> +		return err;
> +	}
> +
> +	dmi_check_system(pmc_core_dmi_table);
> +	dev_info(&pdev->dev, " initialized\n");
> +	return 0;
> +}
> +
> +static int pmc_core_remove(struct platform_device *pdev)
> +{
> +	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
> +
> +	pmc_core_dbgfs_unregister(pmcdev);
> +	mutex_destroy(&pmcdev->lock);
> +	iounmap(pmcdev->regbase);
> +	return 0;
> +}
> +
> +static struct platform_driver pmc_core_driver = {
> +	.driver = {
> +		.name = "pmc_core",
> +	},
> +	.probe = pmc_core_probe,
> +	.remove = pmc_core_remove,
> +};
> +
> +static struct platform_device pmc_core_device = {
> +	.name           = "pmc_core",
> +};
> +
> +static int __init pmc_core_init(void)
> +{
> +	int ret;

Please use reverse x-mas tree style.

>  	const struct x86_cpu_id *cpu_id;
> +	struct pmc_dev *pmcdev = &pmc;
>  	u64 slp_s0_addr;
> -	int err;
>  
>  	cpu_id = x86_match_cpu(intel_pmc_core_ids);
>  	if (!cpu_id)
> @@ -880,36 +928,31 @@ static int __init pmc_core_probe(void)
>  	else
>  		pmcdev->base_addr = slp_s0_addr - pmcdev->map->slp_s0_offset;
>  
> -	pmcdev->regbase = ioremap(pmcdev->base_addr,
> -				  pmcdev->map->regmap_length);
> -	if (!pmcdev->regbase)
> -		return -ENOMEM;
> +	platform_set_drvdata(&pmc_core_device, pmcdev);
>  
> -	mutex_init(&pmcdev->lock);
> -	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit();
> +	ret = platform_device_register(&pmc_core_device);
> +	if (ret)
> +		return ret;
>  
> -	err = pmc_core_dbgfs_register(pmcdev);
> -	if (err < 0) {
> -		pr_warn(" debugfs register failed.\n");
> -		iounmap(pmcdev->regbase);
> -		return err;
> -	}
> +	ret = platform_driver_register(&pmc_core_driver);
> +	if (ret)
> +		goto out_remove_dev;
>  
> -	dmi_check_system(pmc_core_dmi_table);
> -	pr_info(" initialized\n");
>  	return 0;
> +
> +out_remove_dev:
> +	platform_device_unregister(&pmc_core_device);
> +	return ret;
>  }
> -module_init(pmc_core_probe)
>  
> -static void __exit pmc_core_remove(void)
> +static void __init pmc_core_exit(void)
>  {
> -	struct pmc_dev *pmcdev = &pmc;
> -
> -	pmc_core_dbgfs_unregister(pmcdev);
> -	mutex_destroy(&pmcdev->lock);
> -	iounmap(pmcdev->regbase);
> +	platform_driver_unregister(&pmc_core_driver);
> +	platform_device_unregister(&pmc_core_device);
>  }
> -module_exit(pmc_core_remove)
> +
> +module_init(pmc_core_init);
> +module_exit(pmc_core_exit);
>  
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("Intel PMC Core Driver");
> -- 
> 2.21.0.360.g471c308f928-goog
> 

-- 
Best Regards,
Rajneesh
