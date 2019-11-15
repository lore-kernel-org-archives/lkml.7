Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AC3C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E0820674
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfKOPDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:03:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:26618 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727429AbfKOPDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 10:03:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 07:03:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="406694707"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by fmsmga006.fm.intel.com with ESMTP; 15 Nov 2019 07:03:15 -0800
Subject: Re: [PATCH v2] usb: xhci: only set D3hot for pci device
To:     Henry Lin <henryl@nvidia.com>
Cc:     hch@infradead.org, Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191112071831.1043-1-henryl@nvidia.com>
 <20191113014927.11915-1-henryl@nvidia.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <7aa0d839-57f8-54af-4b55-b3e605ae20cc@linux.intel.com>
Date:   Fri, 15 Nov 2019 17:05:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113014927.11915-1-henryl@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.11.2019 3.49, Henry Lin wrote:
> Xhci driver cannot call pci_set_power_state() on non-pci xhci host
> controllers. For example, NVIDIA Tegra XHCI host controller which acts
> as platform device with XHCI_SPURIOUS_WAKEUP quirk set in some platform
> hits this issue during shutdown.
> 

The XHCI_SPURIOUS_WAKEUP quirk both resets the controller at shutdown
and sets it to PCI D3 at remove/shutdown.

Is it so that the NVIDIA Tegra xHC just needs to be reset at shutdown?
The quirk is not set for Tegra xHC in current mainline kernel.

> Signed-off-by: Henry Lin <henryl@nvidia.com>
> ---
>   drivers/usb/host/xhci.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 6c17e3fe181a..61718b126d2b 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -791,8 +791,11 @@ static void xhci_shutdown(struct usb_hcd *hcd)
>   			readl(&xhci->op_regs->status));
>   
>   	/* Yet another workaround for spurious wakeups at shutdown with HSW */
> -	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
> -		pci_set_power_state(to_pci_dev(hcd->self.sysdev), PCI_D3hot);
> +	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP) {
> +		if (dev_is_pci(hcd->self.sysdev))
> +			pci_set_power_state(to_pci_dev(hcd->self.sysdev),
> +					PCI_D3hot);
> +	}

Agree that we shouldn't call PCI specific functions in the generic shutdown code.
Would be better if we could move the PCI parts to xhci-pci.c or hcd-pci.c

Maybe we need to add a xhci_pci_shutdown() function for the xhci pci driver
that could take care of the pci related shutdown quirks before calling
usb_hcd_pci_shutdown(), and call that instead of directly calling
usb_hcd_pci_shutdown().

-Mathias
