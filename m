Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49737C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0DC2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsHY8NEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfEWG7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 02:59:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44673 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfEWG7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 02:59:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so2604634pgp.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 23:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ttP/4fpxH6Y8Dru2/qv3TInM/GG4T6a2AqT579g6WtY=;
        b=LsHY8NEgXvz4fbJbH3G2r3/rwzZdFJcfqoKgUrt94Qm4vAAZSYJpPw8rL2jkS4yJag
         thV+CubU9iRnlRDUlcducksBWNxB9XVPmR4gBP1R5Al1An9LdnxSwXyigiPJeje8WJzw
         SV8ZxkHkrauUNgjzyXgb5/8CAldf1Ytt3wg4SQPXrOyVIZQGvlir1nBuAiiat9k/6ORV
         SZeG6rk9X0xVf9+VqTyhY8qrGu7wMdtB385ZT+QK+sTNVwwArCaVun4kGOb653ze2Z38
         jnVfs6Jos0wNILgIrbPk3r2LqiMR7tn1V24W/cpx9lZFpAjKrejzFSRe5B8lTNIQGBZm
         tFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ttP/4fpxH6Y8Dru2/qv3TInM/GG4T6a2AqT579g6WtY=;
        b=iD1OfISsKO1Pc37Sci+NtgMpx4j7NvBjGPBEtjVpIIyKTVZBuhHRZ0e409yw6Iebp5
         c/UeaCLdmbaKYkLN6h6k4ZnPlKB0arZRl84arus0XBe74jFzmTQbDiviqCxo8trqXmMc
         8zjqfR7LKkNfEE+fQB/N59x1eSZazrtGkr/ODgAdxjjvIdp9H2QYrgvU30nSh4Mty051
         vD7PX2mxWGKS7emBXd4dyw0VDhEE+7ABHcKsxpbMVoGUWK4xDhpDziDEPXUPs4PiATzQ
         WVj1xI7eZ/W77UMgUxCaGByTLmBMf3qheUWqEWPeYhUIk0V9fqm8O0JJl1rGtm3byhE3
         1A5Q==
X-Gm-Message-State: APjAAAUsYln5QWeq/LTdR+y+SFSDMQjxUBq1SfxUiEWICATDlzoA9UlM
        lvGukuADbMm1VluourV1fDQ=
X-Google-Smtp-Source: APXvYqztAm+HRTVxFcCMQOrTwcYmrmZ7Lcw/Ye5QFRvDfuScthzWWIz20vs2srxigaXFQs2RIvzdCg==
X-Received: by 2002:a62:54c7:: with SMTP id i190mr79166699pfb.87.1558594792896;
        Wed, 22 May 2019 23:59:52 -0700 (PDT)
Received: from localhost ([110.70.27.122])
        by smtp.gmail.com with ESMTPSA id a9sm38161607pgw.72.2019.05.22.23.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 23:59:52 -0700 (PDT)
Date:   Thu, 23 May 2019 15:59:47 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv2 4/4] printk: make sure we always print console disabled
 message
Message-ID: <20190523065947.GB18333@jagdpanzerIV>
References: <20190426053302.4332-1-sergey.senozhatsky@gmail.com>
 <20190426053302.4332-5-sergey.senozhatsky@gmail.com>
 <20190426054445.GA564@jagdpanzerIV>
 <20190515144702.uja2mk2vfip6maws@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515144702.uja2mk2vfip6maws@pathway.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/15/19 16:47), Petr Mladek wrote:
> On Fri 2019-04-26 14:44:45, Sergey Senozhatsky wrote:
> > 
> > Forgot to mention that the series is still in RFC phase.
> > 
> > 
> > On (04/26/19 14:33), Sergey Senozhatsky wrote:
> > [..]
> > > +++ b/kernel/printk/printk.c
> > > @@ -2613,6 +2613,12 @@ static int __unregister_console(struct console *console)
> > >  	pr_info("%sconsole [%s%d] disabled\n",
> > >  		(console->flags & CON_BOOT) ? "boot" : "",
> > >  		console->name, console->index);
> > > +	/*
> > > +	 * Print 'console disabled' on all the consoles, including the
> > > +	 * one we are about to unregister.
> > > +	 */
> > > +	console_unlock();
> > > +	console_lock();
> > >  
> > >  	res = _braille_unregister_console(console);
> > >  	if (res)
> > 
> > Need to think more if this is race free...
> 
> I am afraid that it is racy against for_each_console() when
> removing the boot consoles.

Can you explain? Do you mean that we can execute two paths unregistering
the same bcon?

	CPU0					CPU1

	console_lock();
	__unregister_console(bconA)		console_lock();
	console_unlock();

						__unregister_console(bconA);
						for (a = console_drivers->next ...)
							if (a == console)
								unregister();
							// console bconA is
							// not in the list
							// anymore
						console_unlock();

	for (a = console_drivers->next ...)
		if (a == console)
	console_unlock();


This CPU0 will never see bconA in the console drivers list.
But... it will try to do

	console->flags &= ~CON_ENABLED;

Which we need to fix.

Do not disable console which is not on the console_drivers list.

---
index 1177ea4b3fe1..e729992cb4e4 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2660,7 +2660,8 @@ static int __unregister_console(struct console *console)
 	if (console_drivers != NULL && console->flags & CON_CONSDEV)
 		console_drivers->flags |= CON_CONSDEV;
 
-	console->flags &= ~CON_ENABLED;
+	if (!res)
+		console->flags &= ~CON_ENABLED;
 	return res;
 }
 
---
	-ss
