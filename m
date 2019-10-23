Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74A1CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB33C2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571833516;
	bh=DT35g6FBEdDYLHOpKIGQnUtMrJx3RLigno4xMKAPn1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SX2/7XGvoWWMJ+wUdmwag5DbWKtjufvWx1g0oE4vSkl++KQxDCWh99gJg2NYyUuyz
	 Ue5n3bb9RKDWjDBKdWEzXSdxPrJ5HSs3PJPs7FrGS98W/UwsjD8UeLNk5gyl9ZXIWZ
	 MZqY2oQV/+XQ0TqvD02zdARFX5IEYBP65+eRS3WU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391287AbfJWMZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:25:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35560 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfJWMZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:25:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id m7so20912252lji.2;
        Wed, 23 Oct 2019 05:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r9+MqOGg237UtvCUQdK1EPhEYug24PsHTPELGNNApqE=;
        b=G4lrrxtFgBigL8IIJzBRET+s0UBBLXZAmQtsIN7YoDugmdcQ36L1IygnzS02rprq0e
         zgao5uNIAg9LZ93Re+eIWwb+nydm/m7qEU65QsT3gv3KQGBWs7j66CMvqrB8sICj03G5
         LCyZ1xugiTt2hm4IGWbx/u38VR6XFO3QRCbDhNYD+6JEYCLHmauschGPhmgCVYEnF0x5
         Nmw+qZ+a5edSrN46Mz2HvqoOvF3gYhU6c3fHuplrA0fEkP6ODJqUd/FI41kNz8e6jjvo
         6cBbXHiAcBcQk0cCXFSgPW43uFEqtDlh7BzwVx58g/BhiDu3GtBoNZTd8rKNOxouEFjw
         YHtQ==
X-Gm-Message-State: APjAAAUMf2RfAzQLsdr9Z2leEE5z5GYOJzUaUo+IMAJDc6CaKPGkJqnr
        kqaAAkzZBeAtO0WVjCYhfiM=
X-Google-Smtp-Source: APXvYqxU2PDif2P0Gg8wHE54RZBKfO0WSlwbdj4/2t8iczBY1GjzcRG+ByigXXBVn8grG65+d3Ut2w==
X-Received: by 2002:a2e:9848:: with SMTP id e8mr946107ljj.155.1571833512095;
        Wed, 23 Oct 2019 05:25:12 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id t8sm9233160lfc.80.2019.10.23.05.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 05:25:11 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iNFhg-0007Fv-Fr; Wed, 23 Oct 2019 14:25:28 +0200
Date:   Wed, 23 Oct 2019 14:25:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V2 6/7] USB: serial: f81232: Add generator for F81534A
Message-ID: <20191023122528.GX24768@localhost>
References: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
 <20190923022449.10952-7-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923022449.10952-7-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 10:24:48AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> The Fintek F81534A series is contains 1 HUB / 1 GPIO device / n UARTs,
> but the UART is default disable and need enabled by GPIO device(2c42/16F8).
> 
> When F81534A plug to host, we can only see 1 HUB & 1 GPIO device and we
> need write 0x8fff to GPIO device register F81534A_CMD_ENABLE_PORT(116h)
> to enable all available serial ports.
> 
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
>  drivers/usb/serial/f81232.c | 135 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 134 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
> index 01cb5a5ea1d2..82cc1e6cff62 100644
> --- a/drivers/usb/serial/f81232.c
> +++ b/drivers/usb/serial/f81232.c
> @@ -36,6 +36,9 @@
>  	{ USB_DEVICE(0x2c42, 0x1635) },	/* 8 port UART device */ \
>  	{ USB_DEVICE(0x2c42, 0x1636) }	/* 12 port UART device */
>  
> +#define F81534A_CTRL_ID		\
> +	{ USB_DEVICE(0x2c42, 0x16f8) }	/* Global control device */
> +
>  static const struct usb_device_id id_table[] = {
>  	F81232_ID,
>  	{ }					/* Terminating entry */
> @@ -46,6 +49,11 @@ static const struct usb_device_id f81534a_id_table[] = {
>  	{ }					/* Terminating entry */
>  };
>  
> +static const struct usb_device_id f81534a_ctrl_id_table[] = {
> +	F81534A_CTRL_ID,
> +	{ }					/* Terminating entry */
> +};
> +
>  static const struct usb_device_id all_serial_id_table[] = {
>  	F81232_ID,
>  	F81534A_SERIES_ID,

Forgot to mention: don't you want F81534A_CTRL_ID in the combined
(MODULE_DEVICE_TABLE) as well?

Johan
