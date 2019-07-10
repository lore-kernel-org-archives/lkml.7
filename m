Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8EBC74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C26921530
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kt1bVy3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfGJSYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 14:24:06 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38324 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfGJSYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 14:24:05 -0400
Received: by mail-qt1-f194.google.com with SMTP id n11so3500994qtl.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 11:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zAcgUolazA7luBwp8paMkjhRVKLXRJL6TdvFMDHQKzA=;
        b=Kt1bVy3oXSYkybEb7FUQPCdO097Dt4isI9Ses2ujAL1YsDGwte6PKN8oQ6YNdAwuSN
         ZWA8xM1IqoPVmtmjACl8m7STmZpn9rSDaorGYvusAi4iUZQycD4VR3E26NVAQ/DXlaNr
         4T49PxWMzreb34xbe+bgLiSrQHJ9hBVn5h1sDRvClBmYRNwC3yCYGLD/D5IKqIR6yW26
         g4rnvI96pinGTapFoziC5ozDI++h/b34Drw4qdW9uraNL5a5BnELNTL8FhzRombuLIt6
         dTPBJw4syTd15RmDgETe7pRIcm9NloYcxbkNxbuPLNK1D7DciqH0CnZhkCGSXqc8I5k+
         iDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zAcgUolazA7luBwp8paMkjhRVKLXRJL6TdvFMDHQKzA=;
        b=BIt5wdm5gHKEY8E03o95+Sd4md1KmXjB2UYV5m04Eiyp54Ycc6WfzEG/jLdTu+PVQi
         i7ko6BxiWv493uhKI07BDDS6iAbHvJ/XrOZahQOTgxUhlr5zcDhXahooXvRVk1qyKO9Q
         sldHyxyY9wOEBCBgMy4H/xTCD0bgyx4kBXzR2dZJGykrV6+DbLBHFogsB50zB8WkRTFr
         vq+fvVhReXXTpg9pSSY5XhkjSrk5IEVVcKsnJM60Ag7SZfKJ1Z4iSg1n7pKO4TjvYICp
         jwe8IjnP/R/EHIqqxVS96cAawYVwuhiR4Z1xv53GSiE3Ga4CfXl7jwqgzCHUH4iSsSg4
         986g==
X-Gm-Message-State: APjAAAWiILA/tOoPVWLCQ/ewgsBblJWKDv/1aBw+RsmOQNz/elG9/dKt
        bP3D2L5SNJJJ3IXu4C04UA==
X-Google-Smtp-Source: APXvYqx9x9Hv8Yb01z7kNT2uDT6YWO3K7fCYZ/dkH2TwctUQ9egiiR8ut6bSAfySZQU4uXvTVDUyAw==
X-Received: by 2002:ac8:374b:: with SMTP id p11mr24711189qtb.316.1562783044890;
        Wed, 10 Jul 2019 11:24:04 -0700 (PDT)
Received: from keyur-pc (modemcable148.230-83-70.mc.videotron.ca. [70.83.230.148])
        by smtp.gmail.com with ESMTPSA id f25sm1608616qta.81.2019.07.10.11.24.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 11:24:03 -0700 (PDT)
Date:   Wed, 10 Jul 2019 10:24:06 -0400
From:   Keyur Patel <iamkeyur96@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, Alex Elder <elder@kernel.org>,
        Johan Hovold <johan@kernel.org>, David Lin <dtwlin@gmail.com>,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: add logging statement when kfifo_alloc
 fails
Message-ID: <20190710142406.GA6669@keyur-pc>
References: <20190710122018.2250-1-iamkeyur96@gmail.com>
 <20190710163538.GA30902@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710163538.GA30902@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 06:35:38PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 10, 2019 at 08:20:17AM -0400, Keyur Patel wrote:
> > Added missing logging statement when kfifo_alloc fails, to improve
> > debugging.
> > 
> > Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
> > ---
> >  drivers/staging/greybus/uart.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
> > index b3bffe91ae99..86a395ae177d 100644
> > --- a/drivers/staging/greybus/uart.c
> > +++ b/drivers/staging/greybus/uart.c
> > @@ -856,8 +856,10 @@ static int gb_uart_probe(struct gbphy_device *gbphy_dev,
> >  
> >  	retval = kfifo_alloc(&gb_tty->write_fifo, GB_UART_WRITE_FIFO_SIZE,
> >  			     GFP_KERNEL);
> > -	if (retval)
> > +	if (retval) {
> > +		pr_err("kfifo_alloc failed\n");
> >  		goto exit_buf_free;
> > +	}
> 
> You should have already gotten an error message from the log if this
> fails, from the kmalloc_array() call failing, right?
> 
> So why is this needed?  We have been trying to remove these types of
> messages and keep them in the "root" place where the failure happens.
> 
> thanks,
> 
> greg k-h

Didn't notice that. I agree that this will result only into redundancy. 
Quick look over files reveal that there are multiple places
where people are using print statements after memory allocation fails. 
Should I go ahead and send patches to remove those
redundant print statements?

Sorry, if you're receiving this message again.

Thnaks.
Keyur Patel
