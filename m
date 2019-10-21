Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A414ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76780205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L8KbCMIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbfJUQ0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:26:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34880 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729595AbfJUQ0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:26:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id c8so3300668pgb.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 09:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FeEqDDuvyH1j0FkwnEHXEhJ7z7vVV3mb+til5JuVy4E=;
        b=L8KbCMIZMxP2/ikOEVCaVOtgQiYYSXPdgW250Tq1STkF49vaQk3R5o7/jn3v5ajZbp
         ydqA0q4Y7eZeucZjxDPT/99FlOAjOoFBxXR+42r+/Rkiey25D2gehkw0tu3RhUlmCKpG
         o2oUle2jrjk5Q8f35+5xyrFgxajAkboXJop9KDriQvfZyaTxqY8uY3Bazh4lD8gAnlBZ
         2yU3WuGv0nljF2MGSgD1AkYO3QrFrbykPlnVsu+7xKD+/7ecDGB35eephrOR/tbVALDD
         1ImzxUDYILfSZGXq51tA24qE+j5WKw/gYMUVr0JgAIjxRFtWuQSpYxx3WYEg9n5T5D6/
         UjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FeEqDDuvyH1j0FkwnEHXEhJ7z7vVV3mb+til5JuVy4E=;
        b=RTE0mJKTQzAiXjqojP/aKVcezJwlEqso2mX/zkRBh4voq8aRT5giQOebDnOCcPVnFY
         V5+Z260NYaKkTXdzUkOtDqG64usudQOqAZZW1D8DWPv6aJcquLVZUsHxmKXiAkvCLD10
         AJ+X7ZZ39eX5JfGZh3CtkrBgCtEzm/vgL1G/iC+zCCJ3dfJy4aMByueYfz9F6LxUq1rU
         PLqmrdDSFBxvmkzDtdUKKrJjvdl4oHi4Yua6QfNa/xj3cEXCXmjscwW8x5eGGNd+ps9g
         zyx8eenWVMgbEdvxud5nqoAOV1dmgWP0KHo04lpfKbnO4xGFOd/oKks3PZ0t6xyZl6+t
         MnHw==
X-Gm-Message-State: APjAAAUaCZckDBaINkuNHbEF4vmNZxuUGREU279I29bfc/IEnGNiCuu/
        5MnFv0O6MyPcj5sJBjtY+n7y6g==
X-Google-Smtp-Source: APXvYqy5d6rToN0TKdq5fL7MqUzExsdEL3H+tedaCNY+lPF4cHGJooqBtskg5MACrNiAARL8PJwnqw==
X-Received: by 2002:a62:b504:: with SMTP id y4mr15005944pfe.40.1571675173480;
        Mon, 21 Oct 2019 09:26:13 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x5sm15983429pfi.32.2019.10.21.09.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 09:26:12 -0700 (PDT)
Date:   Mon, 21 Oct 2019 09:26:10 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     agross@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: serial: msm_serial: Fix flow control
Message-ID: <20191021162610.GC1204@tuxbook-pro>
References: <20191021154616.25457-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021154616.25457-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21 Oct 08:46 PDT 2019, Jeffrey Hugo wrote:

> hci_qca interfaces to the wcn3990 via a uart_dm on the msm8998 mtp and
> Lenovo Miix 630 laptop.  As part of initializing the wcn3990, hci_qca
> disables flow, configures the uart baudrate, and then reenables flow - at
> which point an event is expected to be received over the uart from the
> wcn3990.  It is observed that this event comes after the baudrate change
> but before hci_qca re-enables flow. This is unexpected, and is a result of
> msm_reset() being broken.
> 
> According to the uart_dm hardware documentation, it is recommended that
> automatic hardware flow control be enabled by setting RX_RDY_CTL.  Auto
> hw flow control will manage RFR based on the configured watermark.  When
> there is space to receive data, the hw will assert RFR.  When the watermark
> is hit, the hw will de-assert RFR.
> 
> The hardware documentation indicates that RFR can me manually managed via
> CR when RX_RDY_CTL is not set.  SET_RFR asserts RFR, and RESET_RFR
> de-asserts RFR.
> 
> msm_reset() is broken because after resetting the hardware, it
> unconditionally asserts RFR via SET_RFR.  This enables flow regardless of
> the current configuration, and would undo a previous flow disable
> operation.  It should instead de-assert RFR via RESET_RFR to block flow
> until the hardware is reconfigured.  msm_serial should rely on the client
> to specify that flow should be enabled, either via mctrl() or the termios
> structure, and only assert RFR in response to those triggers.
> 
> Fixes: 04896a77a97b ("msm_serial: serial driver for MSM7K onboard serial peripheral.")
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>

Looks good!

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> 
> v2:
> -mask out RX_RDY_CTL in msm_reset() to close a small race window for RFR
> 
>  drivers/tty/serial/msm_serial.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index 3657a24913fc..00964b6e4ac1 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -980,6 +980,7 @@ static unsigned int msm_get_mctrl(struct uart_port *port)
>  static void msm_reset(struct uart_port *port)
>  {
>  	struct msm_port *msm_port = UART_TO_MSM(port);
> +	unsigned int mr;
>  
>  	/* reset everything */
>  	msm_write(port, UART_CR_CMD_RESET_RX, UART_CR);
> @@ -987,7 +988,10 @@ static void msm_reset(struct uart_port *port)
>  	msm_write(port, UART_CR_CMD_RESET_ERR, UART_CR);
>  	msm_write(port, UART_CR_CMD_RESET_BREAK_INT, UART_CR);
>  	msm_write(port, UART_CR_CMD_RESET_CTS, UART_CR);
> -	msm_write(port, UART_CR_CMD_SET_RFR, UART_CR);
> +	msm_write(port, UART_CR_CMD_RESET_RFR, UART_CR);
> +	mr = msm_read(port, UART_MR1);
> +	mr &= ~UART_MR1_RX_RDY_CTL;
> +	msm_write(port, mr, UART_MR1);
>  
>  	/* Disable DM modes */
>  	if (msm_port->is_uartdm)
> -- 
> 2.17.1
> 
