Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3155C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB3A2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="ACjs9sNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbfDDOJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:09:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41616 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfDDOJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:09:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so1431309pfd.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 07:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qthb5FxTS34oZRKNGNc31r3AS8cRmEwNyjpH5d4wSfc=;
        b=ACjs9sNW44KDmXEBiEb/wXuLbyNvXb0UQkJ6DPmXoP9e4VNxEUr1ma254mmLIYQGj9
         37JwYuY/Mu+VMYsArkP59jat1aKDU8ga5xDZ6D/jAzwYnfjBKnE/XOIsKbwL9BqBJOff
         s7dNioLbkdoZsdNTISAKIaAGGk8DoP1nBIvyXouqzu8oMEooO99Xkhn/O9JCRJwag493
         NBerugI+2KKW/Nyqexu1mi3T8r26w/H4jB5AsSmgbty7+Qy44fkipaHa3ak4SZtmMXzd
         LCljzCZU8BkVFl7xud/86loG+Luin7usGerIBLzMPpB4KfFpr+QCQvOogGlcwUOc9ZH5
         8Zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qthb5FxTS34oZRKNGNc31r3AS8cRmEwNyjpH5d4wSfc=;
        b=PCg+gVqpS0xsdjn0x50IFQbztI7dt1gQX59/KXfwrDko00M7FcfCT8QK7YucsTSJQY
         QYXKKuJ7YywyEFwh8snytAggOw7CH9ps7YTieblu6VcMePfELZY0yhXtdG72wNVWK3qP
         +Kzez9jAS9NborhvRnna6HEK714WKfb17djpFLWgus7dzKjurr2c5Hp25ZWdzW/YqrQA
         7wUgviC2CIV45hIBfZYAttuSlPuvM1+ViDC4S5m9Ie2W85FVn7xeb34gN1dh1YHBnAfB
         Uu0cGfXVKSSJIvDcz/3OuuDvMaiLXkIllWz31XszzmMXEzajC6Oxp7cW5prfrclBIuqB
         Z8+A==
X-Gm-Message-State: APjAAAWzwtsYpq9uswbYuGegk0xfaOanjDW3mudL4rOAa5THklqRgDhT
        ltvvSY3vYIa2fw4VbEWnEUP0ww==
X-Google-Smtp-Source: APXvYqxg/MXV8HU7H6AFd710KDsfFJXNfsIZkRrx1io0Fhpnbm2Z5r1AUiMEpjGl1qwTM98yIOehbQ==
X-Received: by 2002:aa7:87c5:: with SMTP id i5mr6340930pfo.20.1554386981207;
        Thu, 04 Apr 2019 07:09:41 -0700 (PDT)
Received: from brauner.io ([172.56.31.243])
        by smtp.gmail.com with ESMTPSA id b15sm27426615pgg.90.2019.04.04.07.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 07:09:40 -0700 (PDT)
Date:   Thu, 4 Apr 2019 16:09:33 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Zev Weiss <zev@bewilderbeest.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kernel/sysctl.c: fix out of bounds access in fs.file-max
Message-ID: <20190404140931.zpmcbfgdnlq6jkqn@brauner.io>
References: <20190328130306.25384-1-mcroce@redhat.com>
 <20190403140203.qq37rgcikvoawb5f@brauner.io>
 <CAGnkfhx+igF579dez6qwAxrtT-JrGSSEn-QmK+92447qBqXPpg@mail.gmail.com>
 <20190403155108.GI22763@bombadil.infradead.org>
 <CAGnkfhxBafq4KeR8Jp5XBd7yWrMiofmEwqsCpb_7eL+ddgWagw@mail.gmail.com>
 <CAGnkfhyY7QmrGEk-YF9w-X78dHSDOPQMYtxBkVnpb0MS8DkVhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGnkfhyY7QmrGEk-YF9w-X78dHSDOPQMYtxBkVnpb0MS8DkVhQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 07:08:47PM +0200, Matteo Croce wrote:
> On Wed, Apr 3, 2019 at 6:40 PM Matteo Croce <mcroce@redhat.com> wrote:
> >
> > On Wed, Apr 3, 2019 at 5:51 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Wed, Apr 03, 2019 at 05:24:26PM +0200, Matteo Croce wrote:
> > > > On Wed, Apr 3, 2019 at 4:02 PM Christian Brauner <christian@brauner.io> wrote:
> > > > > Yeah, maybe but it still feels cleaner and more obvious to just add:
> > > > >
> > > > > static long long_zero;
> > > > >
> > > > > given that most callers actually seem to want an (unsigned) int.
> > > > >
> > > > > I don't have a strong opinion though so if others feel that it's just a
> > > > > waste of space consider it acked.
> > > > >
> > > >
> > > > Well, given that the value is zero, in this expectional case we could
> > > > avoid duplicating the symbol and save 4 bytes.
> > > > What the maintainers think?
> > >
> > > If we care about saving four bytes, we could just pass the address of
> > > ZERO_PAGE(0).
> >
> > That would work, work too, maybe it's a bit overkill.
> > int zero is always there and it's static, so enlarging it to long
> > should be a straightforward fix.
> > Obviously we can't do it for other numbers, but we can alias it just
> > for the zero case..
> >
> > Regards,
> >
> > --
> > Matteo Croce
> > per aspera ad upstream
> 
> Anyway, I'm fine with both solutions, as I have other patches in the

I think Matthew's idea gets us best of both worlds so I'd suggest to use
it and resend the patch. You likely want to Cc stable@vger.kernel.org
since the original patch this fixes got backported by Greg quite a bit
since this was a rather long-standing issue. Please also Cc Andrew this
time since he's likely going to pick it up.

Thanks for the patch!
Christian
