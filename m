Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AECC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 04:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8080B20863
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 04:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZR3U7pzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfI0E0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 00:26:21 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36972 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfI0E0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 00:26:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id u20so546966plq.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 21:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LqoDp4s5JsL7s70Cggl17PTDKj5q+AMhTrGDa8ncCoA=;
        b=ZR3U7pzQfDAxRbpurb4MonYHb93y+K2tBoU2/OVH7shSIHzNEjqbIQH4D2UepyjtRp
         8YwsKpJCe54R9jjmnqSBm5+QYmq5YH7xqHY56heUVbmIY2cO+2mfe8KhmooIgeza+F4W
         eiKSQTGoLDRa2Uo6pPOcqnuw9X7c1G2iSuXN19313qa8N/9O778ubBJWy7UmPoz7Tj3E
         iI1q/tVX6ESoSUwj0tFyV29T/gNzK0R29AYgih8JnF46QD0GqpB1JopH4gbKHbVaRYwe
         P60ByvnARiuWTe1wke4y5mUl+nC095lZi6y22k5NuASoaKoTucAUlrOU0iyuz85F2I6E
         AEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LqoDp4s5JsL7s70Cggl17PTDKj5q+AMhTrGDa8ncCoA=;
        b=Rxs35zrH1qqaitaG0CXBNnBBUxTbySgnhzbyM6MCqZwSZ/3298jH0GOLbn9nfIM0ud
         V73wvjsqrc+FBCUgAYYzApXh9ec0VSvW/+nwd+Rr9CVdKpl3T6ncCV/lrJKcINCDd7lC
         9mQt0y9qKVvRSAyP3QlfhpD2bY8Wa4zlf9oL7bAvXbBJSk3/jTUujS0CHFtkCbhgRwMF
         3p9UqKmnsbzyw/OGHfqWDLzaKrO6V8FqDfKA2lt12IOv8325FK5HcGk3a0Q2Y4yytkmG
         IW4tFA6Lr4BHIfXLc/k63UJMySMlZrd0HGTvpC7d53dSu4BMlH7dnfIACJAbF6nRrES5
         6I2A==
X-Gm-Message-State: APjAAAX5TTM+fR9xx+C/zhYGea2s1K2kCkcZp5OjN9rNovo2r/SMUqHN
        ZMCKTBTiGldnJBU0SOIgrPY=
X-Google-Smtp-Source: APXvYqyp97hFIJFTAsr7rP8K2KH8G8PiN9RbkIgpuyzz2gJUPMZ+gAuRauIT6ghalMliiodfAsV+JA==
X-Received: by 2002:a17:902:b497:: with SMTP id y23mr2469613plr.82.1569558379860;
        Thu, 26 Sep 2019 21:26:19 -0700 (PDT)
Received: from localhost ([39.7.18.162])
        by smtp.gmail.com with ESMTPSA id k31sm4263163pjb.14.2019.09.26.21.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 21:26:18 -0700 (PDT)
Date:   Fri, 27 Sep 2019 13:26:14 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: Regression in dbdda842fe96 ("printk: Add console owner and
 waiter logic to load balance console writes") [Was: Regression in
 fd5f7cde1b85 ("...")]
Message-ID: <20190927042614.GA784@jagdpanzerIV>
References: <20190917141034.gvjg7bgylqbbxyv7@pengutronix.de>
 <20190918013032.GA2895@jagdpanzerIV>
 <20190918071158.rtw45jch2roa2wum@pengutronix.de>
 <20190918075252.GA30808@jagdpanzerIV>
 <20190926085855.debu7t46s7kgb26p@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926085855.debu7t46s7kgb26p@pathway.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/26/19 10:58), Petr Mladek wrote:
[..]
> > -	spin_lock(&sport->port.lock);
> > -
> > +	uart_port_lock_irqsave(&sport->port, flags);
> 
> uart_port_lock_irqsave() does not exist.

... Oh. Good catch! Apparently I still carry around my patch set
which added printk_safe to TTY/UART locking API.

> Instead the current users do:
> 
>      spin_lock_irqsave(&port->lock, flags);

Right.

[..]

> I like this approach. It allows to remove hacks with locks.

[..]

> Or I would keep the locking as is and add some API
> just for the sysrq handling:
>
>
>    int uart_store_sysrq_char(struct uart_port *port, unsigned int ch);
>    unsigned int uart_get_sysrq_char(struct uart_port *port);

Looks good. We also probably can remove struct uart_port's
->sysrq member and clean up locking in drivers' ->write()
callbacks:

	if (sport->sysrq)
		locked = 0;
	else if (oops_in_progress)
		locked = spin_trylock_irqsave(&sport->lock, flags);
	else
		spin_lock_irqsave(&sport->lock, flags);

Because this ->sysrq branch makes driver completely lockless globally,
for all CPUs, not only for sysrq-CPU.

> And use it the following way:
> 
> 	int handle_irq()
> 	{
> 		unsined int sysrq, sysrq_ch;
> 
> 		spin_lock(&port->lock);
> 		[...]
> 			sysrq = uart_store_sysrq_char(port, ch);
> 			if (!sysrq)
> 				[...]
> 		[...]
> 
> 	out:
> 		sysrq_ch = uart_get_sysrq_char(port);
> 		spin_unlock(&port->lock);
> 
> 		if (sysrq_ch)
> 			handle_sysrq(sysrq_ch);
> 	}

Looks good.

	-ss
