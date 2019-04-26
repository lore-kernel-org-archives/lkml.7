Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432EDC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3B320675
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556259798;
	bh=NRlTn4ixG4dtv3tzgCreysO5tJr4PVNeW5zqitBMs+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uSQuK0Rnf/lxBH+/Z6tGvijVWe3BaI9e8eK3pqAEATcJs0lxKSwn4wrGON1bkfuv/
	 zXM31c4zhbk+DIUhXS1no/RBKnn7nxCN6TQd8tlecE0PuOD1s92DjYH8Xuh/f8Hg6H
	 BzGHlfsnEVlaY6tx0vUCzeBsjD5pddhyJ02FRlCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfDZGXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:23:16 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42058 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfDZGXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:23:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id w23so1470121lfc.9;
        Thu, 25 Apr 2019 23:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zp0hKrUQvX8Kab6K2VQ62FXiQKZQzPjRXrLcwYdpUdo=;
        b=sMMuULXi0SlLHk04MtOZZXOEuO7Z8TLy5/c6MqqVVX9r7omVpRDwwEzl1gs/T6xgaW
         UDp4tR+bPNRzJ7aprFIOwZndIzuC+pkIMijj6fSEzDmxXmz/NYfE9H+131BlZvRwML1V
         z6dR1kh8hvp+tDkVkAyc/dzs1ZUZkSme9grD5Mga4F3vOzdAYuSEZ5MFY5lqTjvQ+lKN
         bIKxIgJr6l/3whRI5TXUrmy5QIW51qihHWchYXlkx00gpyPfuCvJVhqVe52SVNNTHcLg
         9vxpuOV13eIeLpKf/uRfa6jy9K5SpJQDHi2FtQQvemhNWmb3v4m62yc473bzRvU2lgUT
         n5Tg==
X-Gm-Message-State: APjAAAVZGL707AR0D7wfWLYzI7UtL+nJ1vLMC7xZL7hv0D4dQraZvBAi
        hkPqxAUWvX5hC2dZ1QPLB8EPfmTJ
X-Google-Smtp-Source: APXvYqz7AkaHrAAQ93SSzjKVpWpCLt7stSbrb+fPb8WJItSj9D+WE/ZedIXa2YChnc8Mi/n92ClX/Q==
X-Received: by 2002:ac2:51d9:: with SMTP id u25mr11268500lfm.91.1556259794292;
        Thu, 25 Apr 2019 23:23:14 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id p76sm6085456ljb.63.2019.04.25.23.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 23:23:13 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hJuGO-0003kw-IX; Fri, 26 Apr 2019 08:23:12 +0200
Date:   Fri, 26 Apr 2019 08:23:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH V8 1/4] USB: serial: f81232: clear overrun flag
Message-ID: <20190426062312.GB12280@localhost>
References: <1555641933-19336-1-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555641933-19336-1-git-send-email-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 10:45:30AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> The F81232 will report data and LSR with bulk like following format:
> bulk-in data: [LSR(1Byte)+DATA(1Byte)][LSR(1Byte)+DATA(1Byte)]...
> 
> LSR will auto clear frame/parity/break error flag when reading by H/W,
> but overrrun will only cleared when reading LSR. So this patch add a
> worker to read LSR when overrun and flush the worker on close() &
> suspend().
> 
> Cc: Oliver Neukum <oneukum@suse.com>
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
> v8:
> 	1: Fix usb_submit_urb() in f81232_resume() with GFP_NOIO, not
> 	   GFP_KERNEL.
> 
> v7:
> 	1: Remove serial->suspending check
> 	2: Add port priv is_port_open to save port open state. We'll
> 	   register interrupt-in urb in f81232_resume() when port is
> 	   opened.
> 	3: Using usb_kill_urb for read/interrupt urb to ensure urb
> 	   stopped.

>  drivers/usb/serial/f81232.c | 97 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 89 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
> index 0dcdcb4b2cde..1f0dd4087d79 100644
> --- a/drivers/usb/serial/f81232.c
> +++ b/drivers/usb/serial/f81232.c
> @@ -41,12 +41,15 @@ MODULE_DEVICE_TABLE(usb, id_table);
>  #define FIFO_CONTROL_REGISTER		(0x02 + SERIAL_BASE_ADDRESS)
>  #define LINE_CONTROL_REGISTER		(0x03 + SERIAL_BASE_ADDRESS)
>  #define MODEM_CONTROL_REGISTER		(0x04 + SERIAL_BASE_ADDRESS)
> +#define LINE_STATUS_REGISTER		(0x05 + SERIAL_BASE_ADDRESS)
>  #define MODEM_STATUS_REGISTER		(0x06 + SERIAL_BASE_ADDRESS)
>  
>  struct f81232_private {
>  	struct mutex lock;
>  	u8 modem_control;
>  	u8 modem_status;
> +	bool is_port_open;

This patch can be simplified by using the tty_port_initialized() macro
in resume instead of adding a new open flag. This is the common way USB
serial drivers deal with this and will allow a lot the new locking to go
away.

> +static int f81232_resume(struct usb_serial *serial)
> +{
> +	struct usb_serial_port *port = serial->port[0];
> +	struct f81232_private *port_priv = usb_get_serial_port_data(port);
> +	int result = 0;
> +
> +	mutex_lock(&port_priv->lock);
> +
> +	if (port_priv && port_priv->is_port_open) {
> +		result = usb_submit_urb(port->interrupt_in_urb, GFP_NOIO);
> +		if (result) {
> +			dev_err(&port->dev,
> +					"%s: submit interrupt urb failed: %d",
> +					__func__, result);

Missing '\n', also please drop the function prefix.

Johan
