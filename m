Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02697C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBEA208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561734951;
	bh=Gx6kCyMvU3foUUu4wXaddUuw8z1UuNpW8LTKHcfjXTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q5kQTQjVgtUfVLd2oUKC+jHMLJCqxs2W926NTpm/1rMwy1f2sOt/FSuvKH1cbnLC8
	 /Wpn4fdGZmm7TKY2ShR94kyROZMH/1Fr6fGSNG71CzeS4h8pCJQ0b7KfYhpS80FH6G
	 hrP92JPqYynVruznWRnpP2Qn3L3yrQsaHvRpktsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfF1PPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:15:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42540 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfF1PPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:15:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id t28so6342326lje.9;
        Fri, 28 Jun 2019 08:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Mod7XgX0UF5WjrbK2QZuFathVF7Rrka7CyhDtFJsdU=;
        b=CPBjdqzQ6Wv3i6gvtxUIP98ycpiKDyGw1O8yk8YNWV9NYqJCr/anL2Ppa5eVirwBBJ
         56vA+ozMXu1f8OrQHLEqZnACMGNq03yyxHu6IvRk29meH5qpP6KCtXKV8x4VIPsnaM/w
         by+ELJEptFJaFPhbu1xNhYt0ma30Yfm1+K2ClERfRKI48JuBb2S5TK3jqTd2qkA31cbj
         O+NI/EMgNbjDd9otcwmw8mYgLxv+UrIXHEKAJYpqA4o3c+vvlz9h1Wvagx7XIXBGvrW9
         BGpoxVJ+Ajmd535viZQtmPVjDYVSlY5k7bHUHMSks/a0sTI4RP+yQmAUE2Hpd7yr2Kdi
         eAAw==
X-Gm-Message-State: APjAAAV8NPJQcrlaupriYmjE/rP1Q3lJ8+4f0sn+3x5laAl+Owj7HCgV
        yZEL3DkQk2x0jAYNYd7riwM=
X-Google-Smtp-Source: APXvYqwF8mb/EdTGF1HkHWzrVUZKv9spXE+b3bGVHgIccK7oXtCH22+OMHYMff8Lew0uHEdjPBw0sQ==
X-Received: by 2002:a2e:2b57:: with SMTP id q84mr6575971lje.105.1561734946649;
        Fri, 28 Jun 2019 08:15:46 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id z26sm782395ljz.64.2019.06.28.08.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 08:15:45 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92)
        (envelope-from <johan@kernel.org>)
        id 1hgsbH-0002nh-Eq; Fri, 28 Jun 2019 17:15:43 +0200
Date:   Fri, 28 Jun 2019 17:15:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Fritiofson <andreas.fritiofson@unjo.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: ftdi_sio: add ID for isodebug v1
Message-ID: <20190628151543.GO508@localhost>
References: <20190628130834.32432-1-andreas.fritiofson@unjo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628130834.32432-1-andreas.fritiofson@unjo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 03:08:34PM +0200, Andreas Fritiofson wrote:
> This adds the vid:pid of the isodebug v1 isolated JTAG/SWD+UART. Only the
> second channel is available for use as a serial port.
> 
> Signed-off-by: Andreas Fritiofson <andreas.fritiofson@unjo.com>
> ---
>  drivers/usb/serial/ftdi_sio.c     | 1 +
>  drivers/usb/serial/ftdi_sio_ids.h | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
> index 8f5b17471..ba74c2ad6 100644
> --- a/drivers/usb/serial/ftdi_sio.c
> +++ b/drivers/usb/serial/ftdi_sio.c
> @@ -1027,6 +1027,7 @@ static const struct usb_device_id id_table_combined[] = {
>  	{ USB_DEVICE(AIRBUS_DS_VID, AIRBUS_DS_P8GR) },
>  	/* EZPrototypes devices */
>  	{ USB_DEVICE(EZPROTOTYPES_VID, HJELMSLUND_USB485_ISO_PID) },
> +	{ USB_DEVICE_INTERFACE_NUMBER(UNJO_VID, ISODEBUG_V1_PID, 1) },
>  	{ }					/* Terminating entry */
>  };
>  
> diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
> index b863bedb5..5c681f494 100644
> --- a/drivers/usb/serial/ftdi_sio_ids.h
> +++ b/drivers/usb/serial/ftdi_sio_ids.h
> @@ -1541,3 +1541,9 @@
>  #define CHETCO_SEASMART_DISPLAY_PID	0xA5AD /* SeaSmart NMEA2000 Display */
>  #define CHETCO_SEASMART_LITE_PID	0xA5AE /* SeaSmart Lite USB Adapter */
>  #define CHETCO_SEASMART_ANALOG_PID	0xA5AF /* SeaSmart Analog Adapter */
> +
> +/*
> + * Unjo AB
> + */
> +#define UNJO_VID			0x22B7
> +#define ISODEBUG_V1_PID			0x150D

I added an UNJO_ prefix to the PID define since I assume this is your
product (named ISODEBUG).

Now applied, thanks.

Johan
