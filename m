Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C34C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF23206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrGn7ytf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387423AbfG2RbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 13:31:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35448 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfG2RbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 13:31:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so28399878pfn.2;
        Mon, 29 Jul 2019 10:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OKcy6+wt7mKnNKvhAZHHlWb0p1WzoWRZj+tB4FbIXYQ=;
        b=HrGn7ytfxQNBocxD5hHt7vnh4wJta+tG+sgGQ0Pyziem43ZZM11fwUwf385ZY2PSlq
         dMz7JR70iPQOOGarzjqt/odHQaocDMwadk12oYiMS3EjLAlyKNn3vWi46Dx9LL4urQQ/
         HU1mCwp7vN317tEipp8+ivLKtbkhnsPShcU2JJdnUMK2UOqX/n10qyChIq0Y6AfZRaoy
         arDJWSN2A8n6VXFHAvPztWeIWkPyztbIXtfDg34wn1sGCrg4LPWYXg3qoGeoQO8GCx1Y
         IHR7Nc71x6T0UP3dE+uJRO3JzGSbpyKdrtn0YgRkCpZSVgQtrFB/J5NGEa1Yt5BrOkLL
         YWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OKcy6+wt7mKnNKvhAZHHlWb0p1WzoWRZj+tB4FbIXYQ=;
        b=AwFUXo+u89DAoCVt9n+QCUZn2w2Nby2e9grPIh7S3+pgxw1ihKWJKZk9wwDnEpTaqx
         zNmkhnm/il6lCnPtbQbuJQjIOdavhrdFYTUuor9QYskcIHScTYvDUCrYmN4lkL7krqFN
         8Q6lR8zX971RADFGShLuCqeIcZrxY3rOheCY9oe6MzGU8JB3tvQruiBPYx3mYy32o1Zl
         nH/r7TTWvtO8GzzOuVWLbnbJ8FfCRAO1mp7Rmtz3rh6cQ9sAoyrXTqihO4HFk3H4aGos
         eF3na2lJZstlXdocVpTMX6jlS0osQNpnoPjZTNurna939RD+RnRPcJcqZdeu2kZSx/NS
         ALbQ==
X-Gm-Message-State: APjAAAUvJ/tB97HsNqb4PR2uybBrFq7FoKTvX4tE2fFNcJDfPpnlHlNp
        xiCtbGUGMMJRHQhmwPRHXu31Z46O
X-Google-Smtp-Source: APXvYqwWRi3+CAdfGf7hbUwdnNiZPPuZLmhKADTrnJCf6eqUXXsDbb1zvwm/XQv58BvrOk2YdyAToA==
X-Received: by 2002:a63:b10f:: with SMTP id r15mr35458445pgf.230.1564421467271;
        Mon, 29 Jul 2019 10:31:07 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x24sm59081092pgl.84.2019.07.29.10.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 10:31:05 -0700 (PDT)
Date:   Mon, 29 Jul 2019 10:31:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Douglas Gilbert <dgilbert@interlog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] usb: typec: tcpm: Ignore unsupported/unknown
 alternate mode requests
Message-ID: <20190729173104.GA32556@roeck-us.net>
References: <1564029037-22929-1-git-send-email-linux@roeck-us.net>
 <20190729140457.GC28600@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729140457.GC28600@kuha.fi.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 05:04:57PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> On Wed, Jul 24, 2019 at 09:30:37PM -0700, Guenter Roeck wrote:
> > TCPM may receive PD messages associated with unknown or unsupported
> > alternate modes. If that happens, calls to typec_match_altmode()
> > will return NULL. The tcpm code does not currently take this into
> > account. This results in crashes.
> > 
> > Unable to handle kernel NULL pointer dereference at virtual address 000001f0
> > pgd = 41dad9a1
> > [000001f0] *pgd=00000000
> > Internal error: Oops: 5 [#1] THUMB2
> > Modules linked in: tcpci tcpm
> > CPU: 0 PID: 2338 Comm: kworker/u2:0 Not tainted 5.1.18-sama5-armv7-r2 #6
> > Hardware name: Atmel SAMA5
> > Workqueue: 2-0050 tcpm_pd_rx_handler [tcpm]
> > PC is at typec_altmode_attention+0x0/0x14
> > LR is at tcpm_pd_rx_handler+0xa3b/0xda0 [tcpm]
> > ...
> > [<c03fbee8>] (typec_altmode_attention) from [<bf8030fb>]
> > 				(tcpm_pd_rx_handler+0xa3b/0xda0 [tcpm])
> > [<bf8030fb>] (tcpm_pd_rx_handler [tcpm]) from [<c012082b>]
> > 				(process_one_work+0x123/0x2a8)
> > [<c012082b>] (process_one_work) from [<c0120a6d>]
> > 				(worker_thread+0xbd/0x3b0)
> > [<c0120a6d>] (worker_thread) from [<c012431f>] (kthread+0xcf/0xf4)
> > [<c012431f>] (kthread) from [<c01010f9>] (ret_from_fork+0x11/0x38)
> > 
> > Ignore PD messages if the asociated alternate mode is not supported.
> > 
> > Reported-by: Douglas Gilbert <dgilbert@interlog.com>
> > Cc: Douglas Gilbert <dgilbert@interlog.com>
> > Fixes: e9576fe8e605c ("usb: typec: tcpm: Support for Alternate Modes")
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > Taking a stab at the problem. I don't really know if this is the correct
> > fix, or even if my understanding of the problem is correct, thus marking
> > the patch as RFC.
> 
> My guess is that typec_match_altmode() is the real culprit. We can't
> rely on the partner mode index number when identifying the port alt
> mode.
> 
> Douglas, can you test the attached hack instead of this patch?
> 
> 
> thanks,
> 
> -- 
> heikki

> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index ec525811a9eb..033dc097ba83 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1067,12 +1067,11 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
>  
>  	modep = &port->mode_data;
>  
> -	adev = typec_match_altmode(port->port_altmode, ALTMODE_DISCOVERY_MAX,
> -				   PD_VDO_VID(p[0]), PD_VDO_OPOS(p[0]));
> -
>  	pdev = typec_match_altmode(port->partner_altmode, ALTMODE_DISCOVERY_MAX,
>  				   PD_VDO_VID(p[0]), PD_VDO_OPOS(p[0]));
>  
> +	adev = (void *)typec_altmode_get_partner(pdev);
> +

I understand that typec_altmode_get_partner() returns a const *;
maybe adev should be declared as const struct typec_altmode *
instead of using a typecast.

Also, typec_altmode_get_partner() can return NULL as well if pdev is NULL.
Is it guaranteed that typec_match_altmode() never returns NULL for pdev ?

Thanks,
Guenter

>  	switch (cmd_type) {
>  	case CMDT_INIT:
>  		switch (cmd) {

