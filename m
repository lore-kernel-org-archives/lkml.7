Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACC1C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4E5214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXkUOQ2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfDYJhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:37:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34582 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfDYJhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:37:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so10878871pfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 02:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=buZzVWfXn2UAyIgat8bZPbs15h+TmI1CAcI3bSwwJtg=;
        b=cXkUOQ2T9Nk4b/IevDkFKIhH0zDUw1cPgd5c3oj4NvNrE2YDkdjXu4Z14/KQBS+MwJ
         jM/kx0m/4PwsD46t7PHGtXeqSOwvBzcxN1hgvKL5X9IXGXY6i9ds0n+aOrXL8iUnDkW7
         rKipi2b/IAuYhO//aR2f0yNlVTA3QcCTaNtiTdelmqhbdPiHtFI0dHv/KutuIGij0DFO
         3HiLP/14x/3BNLa7sDqF4bNtyTDZ/whZ2FODS+sgLli+eQi5AB0OeRpi0oy9aBpUKmiE
         6Q7fXrxFvveQy2oCD8+f+ng0le9XFNlGVTuJ4VclG3yUe9eRdKVyAPp5ljvQGDJkWtp7
         WoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=buZzVWfXn2UAyIgat8bZPbs15h+TmI1CAcI3bSwwJtg=;
        b=g3pMVyJyUUSCOeiyLcRmE6Orn4a7YoYvaLfQTwvPJWTLaQR9KZaLFADWj3OUnGeacK
         4VY2SC3Qypl+x9wiiPVOYxSOM2ZTb/PwmwSWtx7Ik9ykXdYdhpEg9u62vL+jtxseomz6
         m1qc9I0HTlq8M8h3Ly+2CkubTQx44X8flH4619CvK4DH3/VPIIQILOXW3js3AtSI6yLr
         YjYLeONQ9CMnnAix5KTWlEYlGpoHYz5uYLQOOt+WsNaqGuHgnu/Zjl18+EvZiQfOUrOj
         1vTBNXvJ9uQjYGrw32ZvurSN0keZc8zsNwm64oi8Yv3NP3t5e4uWsjCVPwSXp+uy5SF+
         8KyQ==
X-Gm-Message-State: APjAAAVaXxEF/L23w6aDrPl3BVq/3F/ygkQ0bgYc4ixXGPzDUufUWF3h
        PmOiFK0HK4nr8XUsRsheLOs=
X-Google-Smtp-Source: APXvYqwXR6O9Z7Qa48bVq+/xAIV/UGUhCK5hM9h2b3kJ6cJQS9fPFqQ6w9mxmt+vkjlGMfQPhTCs9w==
X-Received: by 2002:a63:da51:: with SMTP id l17mr12710599pgj.115.1556185039260;
        Thu, 25 Apr 2019 02:37:19 -0700 (PDT)
Received: from localhost ([175.223.37.83])
        by smtp.gmail.com with ESMTPSA id d11sm23461859pgq.6.2019.04.25.02.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 02:37:18 -0700 (PDT)
Date:   Thu, 25 Apr 2019 18:37:12 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 1/2] printk: lock console_sem before we unregister
 boot consoles
Message-ID: <20190425093712.GA11375@jagdpanzerIV>
References: <20190423062511.1118-1-sergey.senozhatsky@gmail.com>
 <20190423062511.1118-2-sergey.senozhatsky@gmail.com>
 <20190424144924.lw5sgl7qa2yrpxsj@pathway.suse.cz>
 <20190425035233.GA8532@jagdpanzerIV>
 <20190425075002.r4g325fyh5jmabzs@pathway.suse.cz>
 <20190425075606.GA16917@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425075606.GA16917@jagdpanzerIV>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/25/19 16:56), Sergey Senozhatsky wrote:
> > Great idea!
> > 
> > It would deserve a separate patch that moves the pr_info()
> > and removes the invalid comment.
> > 
> > Actually, the pr_info() would deserve a comment explaining
> > why it should be called before console_unlock().
> 
> Good. So I think I'll drop patch #1 from the series, add
> two more patches - invalid comment + pr_info() - and rework
> locking in patch #3 (this should take care of a race which
> patch #1 was intended to fix).

D'oh, I can't drop patch #1, we still need to factor out
__unregister_console(). Calling unregister_console(bcon)
under console_sem will deadlock us. So I'll just end up
having __registed_console() and __unregister_console(),
both should be called under console_sem:

register_console()
{
	console_lock()
	__register_console()
	{
		...
		for_each_console(bcon)
			if (bcon->flags & CON_BOOT)
				__unregister_console(bcon);
	}
	console_unlock()
}

	-ss
