Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AF6C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9862253D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576221475;
	bh=TcV73ux/rT14foW4JR+jEOy6K1C56V5DPpX3f3yf/2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lp/8shC2s9B/SzViB9RfluqgJTasBGqLAT0R79jAwhmtcdtGam055Sr8K3iAekVsP
	 fKJOwkf7tgocNeRWT5N3UAO1QqYjZSJIZ1ZOfj4EllIwSi9na+bI0Vgt/7+AkfG0Uc
	 s5Rt6EGgdfOCOuCyWQ+Qru9Fnf/Ih2da+jzekASc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfLMHRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 02:17:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfLMHRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 02:17:53 -0500
Received: from localhost (unknown [84.241.199.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 535B222527;
        Fri, 13 Dec 2019 07:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576221472;
        bh=TcV73ux/rT14foW4JR+jEOy6K1C56V5DPpX3f3yf/2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z/c2byN9k7PIZtxcbGAj8x46Fc78ertWq5pFnimXr01IT8VqnHLIyLTvD7LQ2dvPr
         NsjS4XTTlB2ZOwrx/i4cd1LJeyB4xS3E1WoOiQtaO2ggCkrFNKv4lrI11mAt2S68Fl
         sIL3UFagZmJMKcxf/KVRspd4bPGfNRtkwdfwo7jI=
Date:   Fri, 13 Dec 2019 08:17:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 02/58] serial: Move sysrq members above
Message-ID: <20191213071749.GA1750354@kroah.com>
References: <20191213000657.931618-1-dima@arista.com>
 <20191213000657.931618-3-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213000657.931618-3-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 12:06:01AM +0000, Dmitry Safonov wrote:
> At the current place members those follow are:
> :	upf_t			flags;
> :	upstat_t		status;
> :	int			hw_stopped;
> :	unsigned int		mctrl;
> :	unsigned int		timeout;
> :	unsigned int		type;
> :	const struct uart_ops	*ops;
> 
> Together, they give (*ops) 8-byte align on 64-bit platforms.
> And `sysrq_ch` introduces 4-byte padding.
> 
> On the other side, above:
> :	struct device		*dev;
> :	unsigned char		hub6;
> :	unsigned char		suspended;
> :	unsigned char		unused[2];
> :	const char		*name;
> 
> Adds another 4-byte padding.
> 
> Moving sysrq members just before `hub6` allows to save 8 bytes
> per-uart_port on 64-bit platforms:
> On my gcc, x86_64 sizeof(struct uart_port) goes from 528 to 520.
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  include/linux/serial_core.h | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 2b78cc734719..bbbe57bf5163 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -161,11 +161,6 @@ struct uart_port {
>  	struct uart_icount	icount;			/* statistics */
>  
>  	struct console		*cons;			/* struct console, if any */
> -#if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(SUPPORT_SYSRQ)
> -	unsigned long		sysrq;			/* sysrq timeout */
> -	unsigned int		sysrq_ch;		/* char for sysrq */
> -#endif
> -
>  	/* flags must be updated while holding port mutex */
>  	upf_t			flags;
>  
> @@ -244,6 +239,12 @@ struct uart_port {
>  	resource_size_t		mapbase;		/* for ioremap */
>  	resource_size_t		mapsize;
>  	struct device		*dev;			/* parent device */
> +
> +#if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(SUPPORT_SYSRQ)
> +	unsigned long		sysrq;			/* sysrq timeout */
> +	unsigned int		sysrq_ch;		/* char for sysrq */
> +#endif

Let's just always have these 2 fields in the structure, no need for a
#ifdef at all, right?  There is no real "savings" from removing them (8
bytes for a structure that is maybe created 2-4 times per machine?)

That way it would keep any of this mess of if the SUPPORT_SYSRQ is
enabled or not to keep everything in sync.

thanks,

greg k-h
