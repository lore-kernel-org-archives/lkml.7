Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A472FC04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842932173C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HZXj+31Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfETStn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 14:49:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39371 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfETStm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 14:49:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id z26so7654684pfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vJJECp0MXM+eJWnIRjXUD1/ASNuSVEfMK8V8t4znXkU=;
        b=HZXj+31ZYY4EetINXb7mkWZbDqY6Fg0lbVDC/GCSkTgV+0v3J6syLMb4kqRIvDjfP1
         NHHUIG4SKCx6HjQqY7b6xrv1Gx8dMUYN23qnyrYbxywzlaFq52q5kGkC4L5/rrSXkYkm
         f/OFSAsNoVnXqzbvPzHeIRxiLwh9Ksv6pCHXKgn1wrIzTwKiB54+hV3nccBldLcUxNlZ
         Sw0jTEsPeXnzCQtgYY9KKr49XedDbtVQnTEmoYYYWR0yZ/jGhqj3SQEVBVAZRz6Rhxlt
         +TFjSThQet9+AJ6FRVSdSTeM8I+1P1QRzVmazrDlt3e0GYa3qIAgAJro5NxY6SLMPzeI
         5SMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vJJECp0MXM+eJWnIRjXUD1/ASNuSVEfMK8V8t4znXkU=;
        b=FjOiM4uz7MJpdOn/UoikLDqlvs8EqcuPy8Gwb5O9a8MiIbpjWLlBQ010VChjyv108S
         9nQojqYVJSfexlwbmyrQzXRwgAFy/lXz8GEU60u0YdubTZPDhpq1ZN98ESyp2kY4C/t2
         ET7lJmVm7NNuEeBwLDrTms/GjcNl+lX+uo2YXha1eZucYcTv12yRh9j0m+SBM47q6NLa
         fou9ChOmM3sJSdCiwUnakHgTakdRB9cSekBpxJSL/ahvV2XjljYpZxRbPQ/s2iU9+UM9
         JmHk2k2q0+oxkd/QLeL9sY+84fGlsGjlt/a7Rm4dRgb2oFULPK6sfnmsB8g1t4hMqfTz
         NtkA==
X-Gm-Message-State: APjAAAVN3HkPDQDwc+BTHMh6MJDcjkjSBSwq/B8foXBBfW+IqRZeBdyk
        faiBNkPJ6NvE8lFWFVuwU8EcOw==
X-Google-Smtp-Source: APXvYqxTXwbbq3D+od0+Bx4gQ0t6J+1TElbsgm6HtmILrAJ+dXlh61nvDyLEYwaqO6JbRCWRpYRL0Q==
X-Received: by 2002:a62:604:: with SMTP id 4mr82640684pfg.38.1558378181831;
        Mon, 20 May 2019 11:49:41 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v40sm25152531pgn.17.2019.05.20.11.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 11:49:41 -0700 (PDT)
Date:   Mon, 20 May 2019 11:50:08 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     agross@kernel.org, david.brown@linaro.org,
        gregkh@linuxfoundation.org, sboyd@kernel.org, jslaby@suse.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: serial: msm_serial: Fix XON/XOFF
Message-ID: <20190520185008.GX2085@tuxbook-pro>
References: <20190520183848.27719-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520183848.27719-1-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20 May 11:38 PDT 2019, Jorge Ramirez-Ortiz wrote:

> When the tty layer requests the uart to throttle, the current code
> executing in msm_serial will trigger "Bad mode in Error Handler" and
> generate an invalid stack frame in pstore before rebooting (that is if
> pstore is indeed configured: otherwise the user shall just notice a
> reboot with no further information dumped to the console).
> 
> This patch replaces the PIO byte accessor with the word accessor
> already used in PIO mode.
> 
> Fixes: 68252424a7c7 ("tty: serial: msm: Support big-endian CPUs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

You missed Stephen's

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Regards,
Bjorn

> ---
>  drivers/tty/serial/msm_serial.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index 109096033bb1..23833ad952ba 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -860,6 +860,7 @@ static void msm_handle_tx(struct uart_port *port)
>  	struct circ_buf *xmit = &msm_port->uart.state->xmit;
>  	struct msm_dma *dma = &msm_port->tx_dma;
>  	unsigned int pio_count, dma_count, dma_min;
> +	char buf[4] = { 0 };
>  	void __iomem *tf;
>  	int err = 0;
>  
> @@ -869,10 +870,12 @@ static void msm_handle_tx(struct uart_port *port)
>  		else
>  			tf = port->membase + UART_TF;
>  
> +		buf[0] = port->x_char;
> +
>  		if (msm_port->is_uartdm)
>  			msm_reset_dm_count(port, 1);
>  
> -		iowrite8_rep(tf, &port->x_char, 1);
> +		iowrite32_rep(tf, buf, 1);
>  		port->icount.tx++;
>  		port->x_char = 0;
>  		return;
> -- 
> 2.21.0
> 
