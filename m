Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601F0C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C9D25191
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oc42Z+Or"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfFCT7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:59:31 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34316 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfFCT7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:59:31 -0400
Received: by mail-oi1-f194.google.com with SMTP id u64so13834911oib.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 12:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eci32UX11XZAmfFBMlUtTnZ6oSQ0Ys3O/AZLucwt+oU=;
        b=Oc42Z+OrRE+FDuLw+8/NrfZmtjNGzedWopcf0ByHhUA3W9IzBOsbqxEK11L/KqW997
         Wp8YWRFzA7n/2ueLDyZUpqyZm7ASfxo6XMCOELfRrOyshRWqDMq/cmtWhmyj3WyEnQt1
         dZPPqQevwyGE9GqAWV3NGe9+VUO/tMUpz8vfGHj6h77ewLg/JNjj2ofHmevGbDoXIC5V
         Obyv1k0k/i+rTSF9H87lOXmTk0kLSxyxTZRBTpviTvKS7Jp+IT3V6iuNcyAiKVq9EQJU
         CYVhKjEEbbQpCIbCzdqZ+64LVv1dYj5WIiUhu1+iMg/yY6D5l754gjj9qvqGZypeStnj
         8dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=eci32UX11XZAmfFBMlUtTnZ6oSQ0Ys3O/AZLucwt+oU=;
        b=XTe0zn3dtHBxgxHk9JZFy4w6oxgXsC0URcCpquQjKjkQJ+Eh7b7sZsNB6hPV0Mc1Ni
         x8bPcl7NYlf+g37phuP8CKxB9jWcP1npOBj9s2MKPxnjZnz72t9F9amm1tzhbwvNAIC6
         7G6Wk5FhHmrszQvIgIYaBb3CG9ERnIgMS/9RSnwSazfXuy4NkNOOAvRtTLm4w5mi3k0w
         8YRW1okhtDv75Zu7DgoVqkzIu9pivlRaUaA6HElkS+1EjOvvub8TfBPzC5ThqdUOjBn4
         oe6nimZB7PKgufQBos6SDEOAdohgk7Z7eLn9HxtfX4juMJzvorzqNbrH5hRPr6ExbSRh
         SaOg==
X-Gm-Message-State: APjAAAUypB/Jd7tvdKMfPDapi+DskuNpJrv9VxVhVwXXKf3ShuWnoEGA
        CbqnlVjpfKn7zarLGNOjgQ==
X-Google-Smtp-Source: APXvYqzYFqpj1dL/P4DgT+s0Id58pPdbS1Jttmt8ea8E6iyZBPRhHOoh1DnNZYbQ66Rn/fuSTijcrA==
X-Received: by 2002:aca:dd08:: with SMTP id u8mr169386oig.27.1559591970098;
        Mon, 03 Jun 2019 12:59:30 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
        by smtp.gmail.com with ESMTPSA id t206sm1826721oig.30.2019.06.03.12.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 12:59:29 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:c2:e16b:3a60:98fc])
        by serve.minyard.net (Postfix) with ESMTPSA id 5AAAA1800CD;
        Mon,  3 Jun 2019 19:59:28 +0000 (UTC)
Date:   Mon, 3 Jun 2019 14:59:27 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 02/57] drivers: ipmi: Drop device reference
Message-ID: <20190603195927.GN2742@minyard.net>
Reply-To: minyard@acm.org
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-3-git-send-email-suzuki.poulose@arm.com>
 <20190603190921.GC6487@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603190921.GC6487@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 09:09:21PM +0200, Greg KH wrote:
> On Mon, Jun 03, 2019 at 04:49:28PM +0100, Suzuki K Poulose wrote:
> > Drop the reference to a device found via bus_find_device()
> > 
> > Cc: Corey Minyard <minyard@acm.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > ---
> >  drivers/char/ipmi/ipmi_si_platform.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
> > index f2a91c4..ff82353 100644
> > --- a/drivers/char/ipmi/ipmi_si_platform.c
> > +++ b/drivers/char/ipmi/ipmi_si_platform.c
> > @@ -442,6 +442,7 @@ void ipmi_remove_platform_device_by_name(char *name)
> >  				      pdev_match_name))) {
> >  		struct platform_device *pdev = to_platform_device(dev);
> >  
> > +		put_device(dev);
> >  		platform_device_unregister(pdev);
> 
> So you drop the reference, and then actually use the pointer?

I did think about this, and in this case you can, I think.
platform_device_unregister() does a put_device() at the end of it's
processing, right?

But it is better style to do it the other way, so I can change it.

-corey

> 
> The drop needs to be _after_ the call to platform_device_unregister().
> 
> thanks,
> 
> greg k-h
