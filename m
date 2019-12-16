Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBF7C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F02206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576498257;
	bh=E6GDnobX0hs/eJuDG0WReNb9IeFOloPE6cOn/QltNuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FODG8t0BGJsBm4mpmuqkZf5hA5hms9j1YnlC/r7NhPj3t1JJMBSIeUIOV2Gll8GHQ
	 PrClDzdjbpNuBwvxA6KLOorllJ+Knqe16vvI1nwszU5ZD7Y7QoxVyjSygamKpaOjKS
	 W9iiJYITkuJSQICi9Mi81PkQQrFhAoRTUP83gyIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfLPMK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:10:56 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41001 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfLPMK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:10:56 -0500
Received: by mail-lf1-f65.google.com with SMTP id m30so4033267lfp.8;
        Mon, 16 Dec 2019 04:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sr1hrtMKkls88LsnLuMmgz2a9nF+WC42j/GNFnp1e0k=;
        b=uSQtrYUbZD/FxXqgdbSRBbnZQRZMel/V/oQkiyTPjM+U8kQEoqtL3uUl5Y9grf91dF
         iaiXII4XU79C087HcQ975NMhQmnwxub6jKhme4c3LSLNq7tRln+deEwAYx2ERKphRtVU
         w/lBlxM6Y/wSh0SP8LTWDyf5vP1p+RjT+fwjDNbxXRuQ+paXUBaPQWdHQ366gkBBDo5H
         qOXNcpbXPIB04w/UD9knBRTOMSMGMffAgaN3njBf/BQPeqRg8Qs42r4LHmQtCUWU4+qX
         oFDnJG12QYVWSDsdcsbrArQdsNcm6cvD7IBzo7al1gfrc5OqasAuPybpTgS4SO7+mEZ2
         INfg==
X-Gm-Message-State: APjAAAW1d3MxGsQnjh71EeGNiFNVSufVWKXIn7vF+/1lIwUPnXw8gI4z
        vG5GDwPBjyU2EDL0KgvPxio=
X-Google-Smtp-Source: APXvYqyHuIzLNWPXPczWyUkoi3mlK606LCK1TehDuUooG5xaaJOLl5MEOdxk4UPrY6Rfom3APXH2Hg==
X-Received: by 2002:ac2:485c:: with SMTP id 28mr16443739lfy.118.1576498254061;
        Mon, 16 Dec 2019 04:10:54 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id p4sm10627846lji.107.2019.12.16.04.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 04:10:53 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1igpD8-0003l3-Rr; Mon, 16 Dec 2019 13:10:50 +0100
Date:   Mon, 16 Dec 2019 13:10:50 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 33/58] serial/f81534: Don't check port->sysrq
Message-ID: <20191216121050.GD22665@localhost>
References: <20191213000657.931618-1-dima@arista.com>
 <20191213000657.931618-34-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213000657.931618-34-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 12:06:32AM +0000, Dmitry Safonov wrote:
> usb_serial_handle_sysrq_char() already checks it.
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  drivers/usb/serial/f81534.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/serial/f81534.c b/drivers/usb/serial/f81534.c
> index 2b39bda035c7..67a8e343eba1 100644
> --- a/drivers/usb/serial/f81534.c
> +++ b/drivers/usb/serial/f81534.c
> @@ -1238,10 +1238,8 @@ static void f81534_process_per_serial_block(struct usb_serial_port *port,
>  			schedule_work(&port_priv->lsr_work);
>  		}
>  
> -		if (port->port.console && port->sysrq) {
> -			if (usb_serial_handle_sysrq_char(port, data[i]))
> -				continue;
> -		}
> +		if (usb_serial_handle_sysrq_char(port, data[i]))
> +			continue;

This is unrelated to the rest of the series.

Please break all usb-serial patches out of this series and submit them
to me and the usb list for review.

Johan
