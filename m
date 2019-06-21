Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C94C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC84D20673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfFUIxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 04:53:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54823 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfFUIxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 04:53:04 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1heFI7-0007Qp-Fi
        for linux-kernel@vger.kernel.org; Fri, 21 Jun 2019 08:53:03 +0000
Received: by mail-pl1-f200.google.com with SMTP id e7so3303960plt.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 01:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=u1hSlNEter5h1ru+YK0xU7QWME8tCkI1M6jD8mwebc0=;
        b=bRt/hiP5wINhpFosJ8vOkpXjcPHpm+Ha1L3l/24Ng1ZQ22j/FgNxXi/A8CcX87YfEI
         97BzIj1jzpzuoBQZ9bvTxAfRPMsrZ8QYoZPcCbNU7sw0AQs+jjvxytrPYlXpfsemT8ol
         BvdZw24d7EAIkdirqcyC7Y6rb+E5nUEoFiodPvls02ouYnjYfEnBX20igZs3MNrPsjk0
         R6wKWol+BXPLpmEl6Ckd8Xku2Opsjwu3v8Wcriutff3LFyrCX5GqhRYfhJkJFODH9EQ0
         +QksVpFUNjg2JzHYWjHli4512YQOJByGtlX1NFfpnzs2o4EAtwTTeDJtTOkw3JjNwNDu
         Hm6w==
X-Gm-Message-State: APjAAAVOuAfoMbNDZoV/8KbELAf8SxnJtfFvYwPsGi0wD5cZpAPoEkpU
        HMCfGDJTgRWQ/c9b9Rg/yK30fMPsZgOrgabAFYJqpV3EAfRM61IOr8Qa0C3xcJ8kpqywKM6fojz
        aemyUBrdgw9sAMxMve0Um2z/PFXdsnunMWTANp6awEA==
X-Received: by 2002:a17:902:e281:: with SMTP id cf1mr48855014plb.271.1561107182194;
        Fri, 21 Jun 2019 01:53:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz8nVP924V3DK7kjmQuC0S7gMYc5j/LFZzSXMJFzmTAzQwvANHE7EWYdGbGTao99GI3cwnXmQ==
X-Received: by 2002:a17:902:e281:: with SMTP id cf1mr48854995plb.271.1561107181925;
        Fri, 21 Jun 2019 01:53:01 -0700 (PDT)
Received: from 2001-b011-380f-3511-28ca-1aa7-7f48-7d86.dynamic-ip6.hinet.net (2001-b011-380f-3511-28ca-1aa7-7f48-7d86.dynamic-ip6.hinet.net. [2001:b011:380f:3511:28ca:1aa7:7f48:7d86])
        by smtp.gmail.com with ESMTPSA id l44sm4959357pje.29.2019.06.21.01.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 01:53:01 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/2] PCI: pciehp: Do not disable interrupt twice on
 suspend
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190618125051.2382-1-mika.westerberg@linux.intel.com>
Date:   Fri, 21 Jun 2019 16:52:57 +0800
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <62F7BEE7-F38E-41C8-A181-B03F9308DE81@canonical.com>
References: <20190618125051.2382-1-mika.westerberg@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 20:50, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> We try to keep PCIe hotplug ports runtime suspended when entering system
> suspend. Due to the fact that the PCIe portdrv sets NEVER_SKIP driver PM
> flag the PM core always calls system suspend/resume hooks even if the
> device is left runtime suspended. Since PCIe hotplug driver re-uses the
> same function for both it ends up disabling hotplug interrupt twice and
> the second time following is printed:
>
>   pciehp 0000:03:01.0:pcie204: pcie_do_write_cmd: no response from device
>
> Prevent this from happening by checking whether the device is already
> runtime suspended when system suspend hook is called.
>
> Fixes: 9c62f0bfb832 ("PCI: pciehp: Implement runtime PM callbacks")
> Reported-by: Kai Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> ---
>  drivers/pci/hotplug/pciehp_core.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/hotplug/pciehp_core.c  
> b/drivers/pci/hotplug/pciehp_core.c
> index 6ad0d86762cb..3f8c13ddb3e8 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -248,7 +248,7 @@ static bool pme_is_native(struct pcie_device *dev)
>  	return pcie_ports_native || host->native_pme;
>  }
>
> -static int pciehp_suspend(struct pcie_device *dev)
> +static void pciehp_disable_interrupt(struct pcie_device *dev)
>  {
>  	/*
>  	 * Disable hotplug interrupt so that it does not trigger
> @@ -256,7 +256,19 @@ static int pciehp_suspend(struct pcie_device *dev)
>  	 */
>  	if (pme_is_native(dev))
>  		pcie_disable_interrupt(get_service_data(dev));
> +}
>
> +#ifdef CONFIG_PM_SLEEP
> +static int pciehp_suspend(struct pcie_device *dev)
> +{
> +	/*
> +	 * If the port is already runtime suspended we can keep it that
> +	 * way.
> +	 */
> +	if (dev_pm_smart_suspend_and_suspended(&dev->port->dev))
> +		return 0;
> +
> +	pciehp_disable_interrupt(dev);
>  	return 0;
>  }
>
> @@ -274,6 +286,7 @@ static int pciehp_resume_noirq(struct pcie_device *dev)
>
>  	return 0;
>  }
> +#endif
>
>  static int pciehp_resume(struct pcie_device *dev)
>  {
> @@ -287,6 +300,12 @@ static int pciehp_resume(struct pcie_device *dev)
>  	return 0;
>  }
>
> +static int pciehp_runtime_suspend(struct pcie_device *dev)
> +{
> +	pciehp_disable_interrupt(dev);
> +	return 0;
> +}
> +
>  static int pciehp_runtime_resume(struct pcie_device *dev)
>  {
>  	struct controller *ctrl = get_service_data(dev);
> @@ -313,10 +332,12 @@ static struct pcie_port_service_driver  
> hpdriver_portdrv = {
>  	.remove		= pciehp_remove,
>
>  #ifdef	CONFIG_PM
> +#ifdef	CONFIG_PM_SLEEP
>  	.suspend	= pciehp_suspend,
>  	.resume_noirq	= pciehp_resume_noirq,
> +#endif
>  	.resume		= pciehp_resume,
> -	.runtime_suspend = pciehp_suspend,
> +	.runtime_suspend = pciehp_runtime_suspend,
>  	.runtime_resume	= pciehp_runtime_resume,
>  #endif	/* PM */
>  };
> -- 
> 2.20.1


