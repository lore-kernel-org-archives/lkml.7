Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E56C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7443621741
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552930995;
	bh=UAVlSvX7KALeTZcWxjui/etBtlz5c8X0YszkVu6dDKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FW+0cIkuHrNoViCegcJ8JmcnFR2k6E1P5P4/Bdme/RwDQxDyEW6+CsNa5neXMvE9U
	 Uae7MVzkyGlBUhZm74pv9d1775YA20hvEDQEB5hRXri/cy6eyPiflMjH5xxIEHfQal
	 JF1y242VZUZ8DS1AJZqF6iE3uoM03EfEUAIHna4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfCRRnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:43:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbfCRRmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:42:50 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78FB720989;
        Mon, 18 Mar 2019 17:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552930970;
        bh=UAVlSvX7KALeTZcWxjui/etBtlz5c8X0YszkVu6dDKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qx+oU95rhGqpI/GZCwtAiHLRW/0oEZAiNgDi9LfO0tKDhDg2psd7YKfaicWQbcFxC
         M+adKABMrwmiLyF1s8e4V/Mi1zl0d6jDSHKhhHnFq3qaDGT1WDBCTpuOuLf7hOItdS
         LkqWQMrcOQ1svO1P5ABL4G6YEcW3f3vi1W/n8aC4=
Date:   Mon, 18 Mar 2019 18:42:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     VizXu <xujiweigo@163.com>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add code to support USBIP Project for Windows
Message-ID: <20190318174247.GA22350@kroah.com>
References: <1552927048-15857-1-git-send-email-xujiweigo@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552927048-15857-1-git-send-email-xujiweigo@163.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 09:37:28AM -0700, VizXu wrote:
> Signed-off-by: VizXu <xujiweigo@163.com>
> ---

I can not take patches without any changelog text, sorry.

Please fix up and resend so we have an idea of what this patch is for
and why it is needed.

>  drivers/usb/usbip/stub_dev.c     |  4 ++++
>  drivers/usb/usbip/stub_rx.c      | 37 +++++++++++++++++++++++++++++++++++++
>  drivers/usb/usbip/usbip_common.h | 16 ++++++++++++++++
>  3 files changed, 57 insertions(+)
> 
> diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
> index c0d6ff1..be95c72 100644
> --- a/drivers/usb/usbip/stub_dev.c
> +++ b/drivers/usb/usbip/stub_dev.c
> @@ -270,6 +270,10 @@ static struct stub_device *stub_device_alloc(struct usb_device *udev)
>  	sdev->ud.tcp_socket	= NULL;
>  	sdev->ud.sockfd		= -1;
>  
> +#ifdef SUPPORT_WIN
> +	sdev->ud.is_configured = false;
> +#endif

#ifdef should never be in a .c file if at all possible.  Please rework
this to use the proper style of doing this type of thing in a .h file.

thanks,

greg k-h
