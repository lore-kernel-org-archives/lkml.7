Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C122CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531322084B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571822116;
	bh=8/4YtXe7yJhKPMfU3SUJkhO8Kk6uO18+fciOIgR9eYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wEHBYzffwCyHRtXuTXqrzj9y6bwDkEVt5yTG1owSj2ut6tfUopWZxYHGslr+9rRt6
	 VY5ibstjAoTCqdtndPTijdK++AwYa42vUUTb4QwWVbj3SwVhZ8KtbJAytDu1GFVGie
	 HVZmm5NE2PcFguCM0WCy8QSSjQd1GO4iJANEpNzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390790AbfJWJPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:15:15 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43681 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390314AbfJWJPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:15:14 -0400
Received: by mail-lf1-f66.google.com with SMTP id 21so6485837lft.10;
        Wed, 23 Oct 2019 02:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aEL8gJRKlNCh14212TGGz6HxJarOVxQCTWxzIntZ7Hs=;
        b=HBs+mR4cUcG4sdmFNaXCJpUZkVqFEcQp4US48ITK9+r3jv9/rCc+xZP2048FlJLjjn
         wpLbX9yK/JhPe+tEdTtwK1OoJo1gPXM/eUTgDOLs49NmJJSk5TwJ+P66OfmvNvpIwESR
         0JK6xeoTw6A8xF54kHVZBe8wdWXGVVhhVyWi3tm2T2lqJ3C4eu6daiJKqlnEI6KIIM9X
         qnam6hW9eB7L3CtwDWzVrb7t9z5eYhLpNK5xioYUmMg6ghqdcIIpplatgBpNkb8ypbOs
         x2oAD39ADZ3RYrvbFtMAsyC2IcmfLGv3kYMo+Ogv260J0AEnlonQEJfHmSBNJ4cfJVoS
         GE7A==
X-Gm-Message-State: APjAAAXFrLrIaD4PBNYwwrLbWtYw4qdIN++Y7tkt/11EWUinpdDqQem6
        8RfgJqWOXoPuf5hElwVNtBo=
X-Google-Smtp-Source: APXvYqy2T8Ncc9TLVP+d0Su9UjJMekkKj3jDsVQXmg1gS/kK4u8vip4ZTTr36rZbe916Pcem93uYOw==
X-Received: by 2002:ac2:4847:: with SMTP id 7mr21368771lfy.180.1571822112594;
        Wed, 23 Oct 2019 02:15:12 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id x16sm743625ljd.69.2019.10.23.02.15.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 02:15:11 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iNCjo-0006Un-8m; Wed, 23 Oct 2019 11:15:28 +0200
Date:   Wed, 23 Oct 2019 11:15:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V2 2/7] USB: serial: f81232: Add tx_empty function
Message-ID: <20191023091528.GQ24768@localhost>
References: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
 <20190923022449.10952-3-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923022449.10952-3-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 10:24:44AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> Add tx_empty() function for F81232.
> 
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
>  drivers/usb/serial/f81232.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
> index c07d376c743d..b42b3738a768 100644
> --- a/drivers/usb/serial/f81232.c
> +++ b/drivers/usb/serial/f81232.c
> @@ -685,6 +685,23 @@ static void f81232_dtr_rts(struct usb_serial_port *port, int on)
>  		f81232_set_mctrl(port, 0, TIOCM_DTR | TIOCM_RTS);
>  }
>  
> +static bool f81232_tx_empty(struct usb_serial_port *port)
> +{
> +	int status;
> +	u8 tmp;
> +
> +	status = f81232_get_register(port, LINE_STATUS_REGISTER, &tmp);
> +	if (status) {
> +		dev_err(&port->dev, "get LSR status failed: %d\n", status);
> +		return false;

You need to return true here on errors like the other drivers do
(consider a disconnected device where you end up with -ENODEV here).

> +	}
> +
> +	if ((tmp & UART_LSR_TEMT) != UART_LSR_TEMT)
> +		return false;
> +
> +	return true;
> +}

Johan
