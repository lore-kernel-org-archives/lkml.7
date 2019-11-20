Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F1AC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27D720898
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i8pNQf1Q";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="RMkQ4XWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfKTTQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 14:16:45 -0500
Received: from a27-21.smtp-out.us-west-2.amazonses.com ([54.240.27.21]:57398
        "EHLO a27-21.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726236AbfKTTQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574277403;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=ysEVlFSsz2PUiWOZ41QMYdlfsngVTjcEZPWdndUQq/4=;
        b=i8pNQf1QaLpBVtZYOcYf3+PYq5YTp4vMVNXKhKyr6NTYWHZ/I2iFs0I6MVhu21O1
        HzL7UFiyZmO0s2W1Mjjh7GXNQkhD6ly4bjq8yjxgb8G1Qitlpz9RN897o4DemYeKNGd
        GjTWEN/Pc9Ba4tgZnim5rz9ybfTOX2PDzaJSPxnM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574277403;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
        bh=ysEVlFSsz2PUiWOZ41QMYdlfsngVTjcEZPWdndUQq/4=;
        b=RMkQ4XWTdc8ecSAOpyUf2ofBLnKDq9vcK6JQhirnUG5ZAehs5+XgimWmakKCeZ3P
        zi+3tfkaHoWr78FkuH1c8ObF7KIYQzfBmFdT1khYcGRf6I2ReovUKZMTD3dHGyjBIhU
        JrqlW6d/HUHiBKSX3Aqc75nOh73U2hzSAzeIuCqE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B85EDC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jackp@codeaurora.org
Date:   Wed, 20 Nov 2019 19:16:43 +0000
From:   Jack Pham <jackp@codeaurora.org>
To:     Henry Lin <henryl@nvidia.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: xhci: only set D3hot for pci device
Message-ID: <0101016e8a3ed308-9e380a62-79e0-4334-9d23-7c4d59142618-000000@us-west-2.amazonses.com>
References: <20191113014927.11915-1-henryl@nvidia.com>
 <20191119081656.8746-1-henryl@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119081656.8746-1-henryl@nvidia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SES-Outgoing: 2019.11.20-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 04:16:56PM +0800, Henry Lin wrote:
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 6c17e3fe181a..e59346488f64 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -770,7 +770,7 @@ static void xhci_stop(struct usb_hcd *hcd)
>   *
>   * This will only ever be called with the main usb_hcd (the USB3 roothub).
>   */
> -static void xhci_shutdown(struct usb_hcd *hcd)
> +void xhci_shutdown(struct usb_hcd *hcd)
>  {
>  	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
>  
> @@ -789,10 +789,6 @@ static void xhci_shutdown(struct usb_hcd *hcd)
>  	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
>  			"xhci_shutdown completed - status = %x",
>  			readl(&xhci->op_regs->status));
> -
> -	/* Yet another workaround for spurious wakeups at shutdown with HSW */
> -	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
> -		pci_set_power_state(to_pci_dev(hcd->self.sysdev), PCI_D3hot);
>  }

Shouldn't this function also now need to be EXPORTed?

Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
