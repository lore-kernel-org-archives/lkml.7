Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D08C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 16:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102E220748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 16:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBYGlJ0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfL2Q2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 11:28:14 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42148 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfL2Q2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 11:28:14 -0500
Received: by mail-pg1-f193.google.com with SMTP id s64so16905384pgb.9;
        Sun, 29 Dec 2019 08:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HvI5d4aaE+b1gi+5iN8aWxiRIjRZNL1uGE+EfHEfZQk=;
        b=PBYGlJ0D9gPGe0FmW8TJD9OC0RPCKukP47iBau4B9fq4O14dzRwP4sesF4P5cjwfyw
         dozPRoYbANtEjZnDVlxntKxNffKZaCWGR0304Y7TwOw5VodfSo6AOc8eePWIooNou/8q
         bHe3jZZzaU7IIil2bzIzYZUU3kFffVHcNML/WQPoCvacxi+gyEBl0ZNrxzqEPu0wtej4
         AzJaT7AZepxrPHiU/u0Vae4oIVtAwh+hxUK20nBm0koSLf/oMh8UDZDBdf37yswHZcQb
         TGQ5U2yD5lSdJK2SOQlAkTpQiiHoSOJGqOOKtnSYkTh85FVB9Ug7XJXRIN1ppa+5qY5u
         MzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HvI5d4aaE+b1gi+5iN8aWxiRIjRZNL1uGE+EfHEfZQk=;
        b=CYqKSlLWjuGUMjbhGspCa7KTG/ogWTK6WrVoYeXP73169SwXQ5DQwOizCHavp5OryW
         hJdq+rlz8W9i3YXDzVvsuQPiwqLTMukXXCxxnQ1Ft4X2UKZR/4im/JTJxoOi8P3UY8um
         rNuPLdD5mMS7F1DX42jmDdCvt4n/C8ne8O0OmIztkDCLVFrH5Yx/SzkOAgoGXOycJ8K7
         kMN2pNZzXzaZe+PFfBC6kLNSvtX20RWONU48jppcU1UdJzWVkyreQ5iN4Q/GI82fitGw
         YZJd9bH8Bo1ekrlyz2a6XqG9Jrj0QxwJ/nEtCErUrqbavozOV41v6IXd6bm4CjygcfRX
         wSyA==
X-Gm-Message-State: APjAAAXpswBjttI0KFly/LH9Ralv6pfxd8bfA8Tfar1XJVsvXXVplX+W
        +SrS+eBWsaLXscdLybdtVqI=
X-Google-Smtp-Source: APXvYqzh1668xttmkGagNpJIV4NcN8NMICBHJ5hpyXU8kB3s4sXZdyHSdkPIogj3gq18bZMYshW9ow==
X-Received: by 2002:a63:3404:: with SMTP id b4mr66183401pga.438.1577636893413;
        Sun, 29 Dec 2019 08:28:13 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j10sm21812709pjb.14.2019.12.29.08.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 08:28:12 -0800 (PST)
Date:   Sun, 29 Dec 2019 08:28:11 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Peter Chen <peter.chen@freescale.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        stable@vger.kernel.org
Subject: Re: [PATCH] usb: chipidea: host: Disable port power only if
 previously enabled
Message-ID: <20191229162811.GA21566@roeck-us.net>
References: <20191227165543.GA15950@roeck-us.net>
 <Pine.LNX.4.44L0.1912281431190.18379-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1912281431190.18379-100000@netrider.rowland.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2019 at 02:33:01PM -0500, Alan Stern wrote:
> 
> Let's try a slightly different approach.  What happens with this patch?
> 
> Alan Stern
> 
> 
> Index: usb-devel/drivers/usb/core/hub.c
> ===================================================================
> --- usb-devel.orig/drivers/usb/core/hub.c
> +++ usb-devel/drivers/usb/core/hub.c
> @@ -1065,6 +1065,7 @@ static void hub_activate(struct usb_hub
>  		if (type == HUB_INIT) {
>  			delay = hub_power_on_good_delay(hub);
>  
> +			hub->power_bits[0] = ~0UL;	/* All ports on */
>  			hub_power_on(hub, false);
>  			INIT_DELAYED_WORK(&hub->init_work, hub_init_func2);
>  			queue_delayed_work(system_power_efficient_wq,
> 

That doesn't make a difference - the traceback is still seen with this patch
applied.

Guenter
