Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E295BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB83E20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbpZGFaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbfDPMrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:47:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40967 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729131AbfDPMrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:47:00 -0400
Received: by mail-ot1-f67.google.com with SMTP id 64so17422055otb.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 05:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ThPXTkU7uyFA4dHQXvmrVmc59qRYZafQp+cpAEUbGoU=;
        b=EbpZGFaJTfwjypX5KwG0X9QAo8sEHWhsEPNnxFjqz9OzFJKq5z5hjzGBaes0AZ84yv
         WeRu8v9fGaJLf/u0EVSaEUkqnj5UJ6KexqMaEScqYQ4jazgirTVnnhjJM2HZQF4zHVHD
         Rmw8F4onIwOYhqwKM8hIdkl2ftLIjU3NbdFzKTxkPwuxvzYL4PBes+t5IfkWFou4UOiU
         Xq9Vx08Ywa157t8CM4UqcMRVDjFRFrMy9SbYDsDFbgBhDp0lY/6PG5PppA+KYDfawzxn
         HZ79guD/cnuXa3ZDpYHcVlsW5SQWqgpLA6xB8662lQi9n1YEbhTQW7XBAZbKW66ZhZQs
         LJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ThPXTkU7uyFA4dHQXvmrVmc59qRYZafQp+cpAEUbGoU=;
        b=oY/AwYX4X2nIaynvqHk8tArRDWFQ8lkGg6l/cMnyrpPA/xzC9UyLM7/PF8TFJn1wRU
         gT/4Aqrt8eCLLZ2XKHF7Ny1aNOLueB622DZfh96+hhSd/Hk5oq8iXihhP4oAFfY6lTUF
         fBzmLpj98g0S8mXFkLDpXZFz5TbqSkSx1qj076jNtEcuZDnIKfvODgmSj8UkvuuvorjH
         U8PVK03W9zSAj939s6lgRllND9z3nIgLVjRinvlE01Ah3IkJMh973wXfaKbWJDvYdBuy
         Iwluj3MFbEmyvMXZX2crkypMyCh0totsYBuLP1hdXEDyklKUmtcHzQ5I19XwEOyr+neU
         MQTA==
X-Gm-Message-State: APjAAAVQTCwaXCahhMUbfR/p603g2OF5F/u4XYDnaFqAzfMBaIivbMr7
        aByPl2/kz9xqesnmBJxb4Q==
X-Google-Smtp-Source: APXvYqxvePDCandHH7AxWcS2ap424PnssZ0DJM41P2WuqnRu3r6PjhSMkgtWCU+eddCWfYfYolil2g==
X-Received: by 2002:a9d:7f90:: with SMTP id t16mr53082381otp.9.1555418819197;
        Tue, 16 Apr 2019 05:46:59 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
        by smtp.gmail.com with ESMTPSA id y14sm20555731oie.15.2019.04.16.05.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 05:46:58 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:d5e:aa5a:44d8:6907])
        by serve.minyard.net (Postfix) with ESMTPSA id C51131800CB;
        Tue, 16 Apr 2019 12:46:57 +0000 (UTC)
Date:   Tue, 16 Apr 2019 07:46:56 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ipmi: avoid atomic_inc in exit function
Message-ID: <20190416124656.GI4121@minyard.net>
Reply-To: minyard@acm.org
References: <20190415155509.3565087-1-arnd@arndb.de>
 <20190415164022.GA32090@infradead.org>
 <20190415173935.GE4121@minyard.net>
 <CAK8P3a0MN0U1cZac2t-SE4=nzWfJ-WJCAz=zHAcAKofD_sM1_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a0MN0U1cZac2t-SE4=nzWfJ-WJCAz=zHAcAKofD_sM1_Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 09:00:46PM +0200, Arnd Bergmann wrote:
> On Mon, Apr 15, 2019 at 7:39 PM Corey Minyard <minyard@acm.org> wrote:
> >
> > On Mon, Apr 15, 2019 at 09:40:22AM -0700, Christoph Hellwig wrote:
> > > On Mon, Apr 15, 2019 at 05:55:00PM +0200, Arnd Bergmann wrote:
> > > > This causes a link failure on ARM in certain configurations,
> > > > when we reference each atomic operation from .alt.smp.init in
> > > > order to patch out atomics on non-SMP systems:
> > > >
> > > > `.exit.text' referenced in section `.alt.smp.init' of drivers/char/ipmi/ipmi_msghandler.o: defined in discarded section `.exit.text' of drivers/char/ipmi/ipmi_msghandler.o
> > > >
> > > > In this case, we can trivially replace the atomic_inc() with
> > > > an atomic_set() that has the same effect and does not require
> > > > a fixup.
> > >
> > > I'd rather fіx the arm section management.  Using atomic in exit
> > > routines is perfectly valid, and it would seem odd to forbid it.
> >
> > That was my first thought, too.  It's kind of hard to believe that
> > the IPMI driver is the only thing that does an atomic_inc() in the
> > exit code.
> 
> That's what I had thought as well at first, and I carried a patch
> to work around this by not dropping the .text.exit section on ARM
> when SMP patching is enabled for a few years. I never sent this
> because that can waste a significant amount of kernel memory,
> and I knew the warning is harmless.
> 
> When revisiting it now, I found that this one was the only instance
> I ever hit. It seems to be that using atomics in module_exit() is
> indeed odd, because the function is rarely concurrent with anything
> else.

I've added the change to my tree; it actually makes a little more
sense, so I'm ok with it.

I guess it's up to you to deal with any new ones that happen in
the future ;-).

-corey
