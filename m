Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F62C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5AE2341F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzOKPbc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfICLvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:51:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34373 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfICLvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:51:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id b24so10665322pfp.1;
        Tue, 03 Sep 2019 04:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=t2PxMG5OIm2u7yWMEpUqisBZ79ACocY8nzC9BY2ai8g=;
        b=BzOKPbc4/MSMJfSK7LLEp7SNUCYYvBh4HDURdwaOsyyPnkmUTy/AKujgqW6L8uCJl6
         XaL05v//eas0UdRSvSlKHyqwRFpRc/OqfKXo+pv6LGkymd+s1Q3HNWnKJfOg/3glY8pA
         UUEmInY3y7aOIKQyPJKGU/KHvZRRANXNdyo1DVJX8D0D0PC4xTX0IRU/sdg2mPjLYCl2
         jIgp072oXsEGLUyrYylNlT/GrfN3zP675thrTvlGYnNIaaJAvY4G9CdB4bMXBkzbQqzA
         diGhS8KsD5HlryTqkAqj6N+3g9AW/tTi1c5Tn27Dwh2RyL5s1K+yw6JRQ1O6IkAT4M0I
         AyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=t2PxMG5OIm2u7yWMEpUqisBZ79ACocY8nzC9BY2ai8g=;
        b=RznjvVOVUqxloO9dz3xRveY4yWKs9OWwMCDCnqgp+CrGXQqK8vugruwpP4+RHVudCl
         B6vAUeZZaSSuTeb3GCaGAyNZHRBsMWdQ5s5+4f/tCPD3XOZAkZMowcjyEIdIWIWmryZj
         8cxqNPyDoyxeGP8lD9lGltxMp5vcFWCcYRLqavDHi9kX9pRdwj0voefEAbSY279RScoF
         cvrAk9YQS18LrqGkAD0opg7HIsKayMR8+fMefulAaOPSZ32x1w4WDBYWRf10+CqiaGv2
         RNPcBROWPFDQKrGzUjKYwXoerFaufiUDwHitoKt3Wb0U2XymqCmOtvyYrhX8ZOiVrkTn
         Kdew==
X-Gm-Message-State: APjAAAXO/ii+qd4tdqpQz6KkxuqNrUrXg8vA+sTT+UDrbCyIpjdKgAOj
        3oHzf4mxUNqonyHIyj3IxlI=
X-Google-Smtp-Source: APXvYqzaQC+6kNqfUI/eVx4HPCBbmJTTOPyiSjSJY5k6LjVLpW9HArFoDoPFVW2rvicRDKjCvdCQRA==
X-Received: by 2002:aa7:9303:: with SMTP id 3mr19787525pfj.29.1567511495522;
        Tue, 03 Sep 2019 04:51:35 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r23sm7173244pjo.22.2019.09.03.04.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 04:51:34 -0700 (PDT)
Date:   Tue, 3 Sep 2019 04:51:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] mfd: don't select DMA_DECLARE_COHERENT for the sm501
 and tc6393xb drivers
Message-ID: <20190903115133.GA3543@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 10:46:15AM +0200, Christoph Hellwig wrote:
> Now that these drivers use the usb localmem pool there is no need to
> select DMA_DECLARE_COHERENT.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Tested-by: Guenter Roeck <linux@roeck-us.net>

for SM501.

> ---
>  drivers/mfd/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index f129f9678940..c8cbde59bbf6 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1105,7 +1105,6 @@ config MFD_SI476X_CORE
>  config MFD_SM501
>  	tristate "Silicon Motion SM501"
>  	depends on HAS_DMA
> -	select DMA_DECLARE_COHERENT
>  	 ---help---
>  	  This is the core driver for the Silicon Motion SM501 multimedia
>  	  companion chip. This device is a multifunction device which may
> @@ -1714,7 +1713,6 @@ config MFD_TC6393XB
>  	select GPIOLIB
>  	select MFD_CORE
>  	select MFD_TMIO
> -	select DMA_DECLARE_COHERENT
>  	help
>  	  Support for Toshiba Mobile IO Controller TC6393XB
>  
> -- 
> 2.20.1
> 
