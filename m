Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139BCC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 05:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF61218DE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 05:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570684830;
	bh=OjsgxPp6g+K1tFbCY+kL0wFsiuNuwU5K3PbXoj4jLJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xeoN8aOiPtUaxA27+u/oI8aow2HZWLq+tA9lgOuiV0lCaiYrrtNeRwYWsbjjDzQT6
	 N04clWVx0romECjNEjvpXl3guIY3jvjQAr4VTd8Ul6bvUhbIxCAMLluP2aI766AIF1
	 WbuTdgDoALPDNLJFmDeJ4aVtqUd497/7e/x5Qb1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732720AbfJJFU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 01:20:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfJJFU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 01:20:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99A4120659;
        Thu, 10 Oct 2019 05:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570684828;
        bh=OjsgxPp6g+K1tFbCY+kL0wFsiuNuwU5K3PbXoj4jLJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sc4iSPZ/mNe+m5vif9BPR7tZwp8Tg8nuta2n72t5jpWVATAp1RYAVodrXBs8blK9Z
         b/ijt0CZYvkeqzNHhjeo7BRT3/qzDf9TYh+RfRv0lZCfX9dmCinGcVHFbddvzjGBDY
         ltAxXmXLDEdR/5gQioNmIdYE2kIn3YsR8ryPxGV4=
Date:   Thu, 10 Oct 2019 07:20:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Douglas Anderson <dianders@chromium.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jan-Marek Glogowski <glogow@fbihome.de>,
        Mathieu Malaterre <malat@debian.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: core: Fix potental Null Pointer dereference
Message-ID: <20191010052025.GA235874@kroah.com>
References: <20191010010205.25739-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010010205.25739-1-yzhai003@ucr.edu>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 06:02:02PM -0700, Yizhuo wrote:
> Inside function usb_device_is_owned(), usb_hub_to_struct_hub()
> could return NULL but there's no check before its dereference,
> which is potentially unsafe.
> 
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---
>  drivers/usb/core/hub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 236313f41f4a..8d628c8e0c1b 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -1977,7 +1977,7 @@ bool usb_device_is_owned(struct usb_device *udev)
>  	if (udev->state == USB_STATE_NOTATTACHED || !udev->parent)
>  		return false;
>  	hub = usb_hub_to_struct_hub(udev->parent);
> -	return !!hub->ports[udev->portnum - 1]->port_owner;
> +	return hub && !!hub->ports[udev->portnum - 1]->port_owner;

How can hub ever not be valid?

thanks,

greg k-h
