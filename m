Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FC3C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1CC2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgXIAX7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbfDYFTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:19:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47079 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbfDYFTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 01:19:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id 9so10497246pfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 22:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qFPWnf6Le6aJkS62VqbYlAu1OT1Uv7eQ0DcMcSSP4NE=;
        b=PgXIAX7ibmpmX3mt/TUFXAqXRLDQbPvWziPwptV/gQNISHrJQg1v+x9IduSP6nePfl
         QxkJCsS2uvjGEoB584yddjjfGfnth22p2Wv7Dk37ZJhPu8mZYXSgleoKoFgtEL+t5CFv
         jQN/RoDs/f0Zd0lJsC4fcG5B9HLS1cyrYST1pfX8P/SSoynuFXApr4lmByhbPt2iYgOs
         aZNW7kk+SG+CxMdP3YLZE9JdkfFfujUDMNGWNwvbZ8vQ+aJPQ2SkjVoMt8ytqf0HdmuL
         XSvo13HvD6HqSsBkcf5B+Di3IQ0nHsvpuYxA664KOYxgaDRierDHqRCICjkZPk2/xAZ8
         MJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qFPWnf6Le6aJkS62VqbYlAu1OT1Uv7eQ0DcMcSSP4NE=;
        b=MsIpSkTyxh+gMYFOxwsLAW0xiInqqt5uyWExvYPjxM6MmeD6/OjJAp6x+QrtzlXoAm
         Zll5SHwAQqmAR1Dwuvv+Kc9NHUBjsue4F6yzlJ19hO9g2g3LOg5JEiu+VyNKQwhnBoQJ
         GzAOr3IlWoBL3BPP99qNDOWCLJ0/M/UgPYURkvPK/Wn2MGvcPzq2/0FydUIasCCCpnZA
         Aa6LbNX3lQbQAcG5ONy9ueCwSPCmDnkcgotNyxnsO5QscefPolrm9PJCa0kvDfNnfywA
         bw5PdeQ0gtaqpOTnHFMjsHQzJc2+AqxH14KGQP3/q0OhHcMFpgKBfQhsg7GUV1eqv5ip
         1Zgg==
X-Gm-Message-State: APjAAAXqKUfNVkMU4ORLRz25TWvcQ9MDISWHoFhMAg9ssWEZMDXAu9g7
        UKY1jqzTjTM0EEFrnwAMwXk=
X-Google-Smtp-Source: APXvYqyN9haRLAbX7gPY4653w6nCOcn1npbtX8dAbPhVUAwO9OPLxKUyzxKO0YrYdiMjNF3vXKYmPA==
X-Received: by 2002:a63:f115:: with SMTP id f21mr34663194pgi.65.1556169588680;
        Wed, 24 Apr 2019 22:19:48 -0700 (PDT)
Received: from localhost ([175.223.37.83])
        by smtp.gmail.com with ESMTPSA id g5sm32599436pfo.53.2019.04.24.22.19.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 22:19:47 -0700 (PDT)
Date:   Thu, 25 Apr 2019 14:19:44 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 2/2] printk: take console_sem when accessing console
 drivers list
Message-ID: <20190425051944.GB8532@jagdpanzerIV>
References: <20190423062511.1118-1-sergey.senozhatsky@gmail.com>
 <20190423062511.1118-3-sergey.senozhatsky@gmail.com>
 <20190424151306.jcmygibltizcorgk@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424151306.jcmygibltizcorgk@pathway.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/24/19 17:13), Petr Mladek wrote:
> >  	/*
> >  	 * before we register a new CON_BOOT console, make sure we don't
> > @@ -2691,6 +2696,7 @@ void register_console(struct console *newcon)
> >  			if (!(bcon->flags & CON_BOOT)) {
> >  				pr_info("Too late to register bootconsole %s%d\n",
> >  					newcon->name, newcon->index);
> > +				console_unlock();
> >  				return;
> >  			}
> >  		}
> > @@ -2701,6 +2707,7 @@ void register_console(struct console *newcon)
> >  
> >  	if (!has_preferred || bcon || !console_drivers)
> >  		has_preferred = preferred_console >= 0;
> > +	console_unlock();

Thanks for taking a look!

> We should keep it until the console is added into the list. Otherwise
> there are races with accessing the static has_preferred and
> the global preferred_console variables.

We don't modify `preferred_console' in register_console(), only
read-access it. Write-access, at the same time, is not completely
race free. That global `preferred_console' is modified from

 add_preferred_console() -> __add_preferred_console() -> WRITE preferred_console
 console_setup() -> __add_preferred_console() -> WRITE preferred_console

So `preferred_console' is not WRITE protected by console_sem, that's
why I didn't make sure to READ protected it in register_console().

As of static `has_preferred'... I kind of couldn't figure out if
we really need to protect it, but can do.

> Also the value of bcon should stay synchronized until we decide
> about replaying the log.

Good catch. So we, basically, can do the same thing as we did to
__unregister_console(): factor out the registration code and call
that new __register_console() under console_lock, and do
console_unlock()/console_lock() after we add console to the list,
but before we unregister boot consoles.

Except for one small detail:

> IMHO, the only danger might be when con->match() or con->setup()
> would want to take console_lock() as well. I checked few drivers
> and they looked safe. But I did not check all of them.
>
> What do you think, please?

That's a hard question. I would assume that ->match() has
no business in console_sem; but I'm not completely sure about
->setup().

E.g. 8250 does take console_sem during port configuration:
	config_port()
	 serial8250_config_port()
	  autoconfig_irq()
	   console_lock()

But it doesn't look like we hit this path from ->setup(); seems
to be early serial setup stage.

So may be we can move the whole thing under console_sem.

	-ss
