Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA9FC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A19920855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="eM8XKCwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfKUCwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 21:52:54 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38015 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKUCwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 21:52:53 -0500
Received: by mail-qk1-f193.google.com with SMTP id e2so1819411qkn.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 18:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HRBpb1NofTDSzn/r03yAMNZB5b+BCFqizd3KS9TU4pA=;
        b=eM8XKCwLiBTrYDBgxBsRw2BnAmazqG7Yh6EbctgrhhDT/VkJWtpyd4I0jgafYvddrh
         D66QjPZTHqlc9/T9Pq6r+XndN0ChjvCNCAbtD1ti+CxMAcIA0x8gA/v8a9/8DxOw6uTh
         MX6B2lo/1ZzdCXW7YoJyaVCv3hhhg1OJvwgSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HRBpb1NofTDSzn/r03yAMNZB5b+BCFqizd3KS9TU4pA=;
        b=bqJEbPv+Foov9OTxlUr2DXS4b3zp8i4otojewThV1/1VCMmqYbAuFwYq5ypwigtrmL
         cXs4tTTAA07vk6VfgVwGLGU/FBI7VW1MyXEQGi9JejY0iksqFCaKUBZZPHg8cQAqQUTq
         Volubkarb3CS1fCSE1XI/93AatCNb39F66KefRYKbMGPXIYzePEdWDQBf146Y9Hh0HVd
         XPFbPe/chncd4ZHhT6LsyUrpQhzEuCs7x7j1brhIAGlXzHGrRSxOGTLLf5ze6UKCtZ74
         7CA1qxE5puKwKtBk9AHI1W4eihnOLFME4E55Yq7LH2w4PruYpvsUd4MwIe8ZN0Wz///I
         37FQ==
X-Gm-Message-State: APjAAAUp+FouMZUMInMLg90HUuaPpNDom0R/eMH69aEMMma4NGFyplcU
        dq8zE3aYP9wkJWcjC6Tr2UyZxLL2qFQzo/JZAEKB2wi8SEY=
X-Google-Smtp-Source: APXvYqzEOaht5xTwJzZ1PyVm7pSpljnawSJw5pVkoy6TqeJnWlaviiQzQVT03RYWqcb2qhbWWljBiAkv81grK5w5zNg=
X-Received: by 2002:a37:dcc7:: with SMTP id v190mr5861034qki.330.1574304771112;
 Wed, 20 Nov 2019 18:52:51 -0800 (PST)
MIME-Version: 1.0
References: <20191120000647.30551-1-luc.vanoostenryck@gmail.com> <787e54c2-2fe3-4afc-a69b-94771726194b@www.fastmail.com>
In-Reply-To: <787e54c2-2fe3-4afc-a69b-94771726194b@www.fastmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 21 Nov 2019 02:52:39 +0000
Message-ID: <CACPK8XfO=F-BtCuDqyQODJv=6joYmyFiQ5eOYC5YuDJhcLSJtw@mail.gmail.com>
Subject: Re: [PATCH] aspeed: fix snoop_file_poll()'s return type
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Lippert <rlippert@google.com>,
        Patrick Venture <venture@google.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019 at 05:42, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> On Wed, 20 Nov 2019, at 10:36, Luc Van Oostenryck wrote:
> > snoop_file_poll() is defined as returning 'unsigned int' but the
> > .poll method is declared as returning '__poll_t', a bitwise type.
> >
> > Fix this by using the proper return type and using the EPOLL
> > constants instead of the POLL ones, as required for __poll_t.
> >
> > CC: Joel Stanley <joel@jms.id.au>
> > CC: Andrew Jeffery <andrew@aj.id.au>
> > CC: linux-aspeed@lists.ozlabs.org
> > CC: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > ---
> >  drivers/soc/aspeed/aspeed-lpc-snoop.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > index 48f7ac238861..f3d8d53ab84d 100644
> > --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > @@ -97,13 +97,13 @@ static ssize_t snoop_file_read(struct file *file,
> > char __user *buffer,
> >       return ret ? ret : copied;
> >  }
> >
> > -static unsigned int snoop_file_poll(struct file *file,
> > +static __poll_t snoop_file_poll(struct file *file,
> >                                   struct poll_table_struct *pt)
> >  {
> >       struct aspeed_lpc_snoop_channel *chan = snoop_file_to_chan(file);
> >
> >       poll_wait(file, &chan->wq, pt);
> > -     return !kfifo_is_empty(&chan->fifo) ? POLLIN : 0;
> > +     return !kfifo_is_empty(&chan->fifo) ? EPOLLIN : 0;
>
> Looks fine to me as POLLIN and EPOLLIN evaluate to the same value despite
> the type difference.

I assume Luc was using sparse to check:

CHECK   ../drivers/soc/aspeed/aspeed-lpc-snoop.c
../drivers/soc/aspeed/aspeed-lpc-snoop.c:112:19: warning: incorrect
type in initializer (different base types)
../drivers/soc/aspeed/aspeed-lpc-snoop.c:112:19:    expected
restricted __poll_t ( *poll )( ... )
../drivers/soc/aspeed/aspeed-lpc-snoop.c:112:19:    got unsigned int (
* )( ... )

If you fix the return type:

  CHECK   ../drivers/soc/aspeed/aspeed-lpc-snoop.c
../drivers/soc/aspeed/aspeed-lpc-snoop.c:106:45: warning: incorrect
type in return expression (different base types)
../drivers/soc/aspeed/aspeed-lpc-snoop.c:106:45:    expected restricted __poll_t
../drivers/soc/aspeed/aspeed-lpc-snoop.c:106:45:    got int

Reviewed-by: Joel Stanley <joel@jms.id.au>

I will send this to the ARM SOC maintainer. Thanks Luc!

Cheers,

Joel
