Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A371AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726332075E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I7giHjHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfCYWP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:15:58 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35320 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbfCYWP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:15:57 -0400
Received: by mail-ot1-f68.google.com with SMTP id m10so2010007otp.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mgKLCtqSYr9Ki4yiAt+9HJ6QF4zuEc1vdaoGRfW6GoI=;
        b=I7giHjHDi8rVOI2Rj2M30ZWnci1QqF1BImghkOCQqbkje13vCYp3Rc0AsHiLMeHwOi
         sx1vSxztRJyOWKx1OErgkF2CXwfFK/vvkxVplF/sd0er2siDSXIVUGOVUpciqS9bD3ka
         xdx0pBvAiT2glVb+zBLmBjd6Go3N7eIFe1Rp5/i8Ki87yw0yboD8Ngj2SwRnOI3MLMZR
         8xpY9MezFfwc47eyKMv7aqSzaxDdDoVv95460my0XDvqER2Bru4KdskOJLvnAYzlvWtC
         eE4USJmCRtoFqHt6T6jFj5yYM6LylCoN8j289p+tRM+4NInqi3ETTZ7o6xjWw23nqOGh
         3RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mgKLCtqSYr9Ki4yiAt+9HJ6QF4zuEc1vdaoGRfW6GoI=;
        b=jsnKt1e//HXrX/elb0X/m/7FtZGaXK3CZEP+horytB8EoJuSkXHQnODJnfVFNFUzmn
         UQJvdX9zjh/FzpFQOHziq9edqS2F9NM0jb+h2xIpUKKa/TQVWKHQciaTO3vwKskwS+2M
         4NNeNJ2aeMm9df7H7jaKDZ356MhtBuN2i++phpJpve73KxdKSwc8kPW8+rKGd9sFzRIY
         TMNe6luZPrUNfrg4o0ZXgtY/8YDuV9G5zmBqhMrF6DLsr2tq36dkh6Z0OJuA0yZD4oBX
         9Qt5AVUZf+aWQuYwvHAofvNu9yMJK0FafEevXOHxT2jgzhi5YCgAkNwiGCnz+8M0QH+R
         36EQ==
X-Gm-Message-State: APjAAAWaXwZfpiV5wr9b2mi0yhZzyVk1hXvots/uyB+T45pvCvOEtmaM
        ma79Klhbwm4xOGXUzGWRlmYn8jIGmyOJzohHC1RpaA==
X-Google-Smtp-Source: APXvYqzJvek+IoFlhWPin70hAf9vrEOdLe5uyrnjOlS8dUeEAoaxTVrgDEF35PG0gUI7qmRZ4/BORTVxwt3/MldsJSQ=
X-Received: by 2002:a9d:73c2:: with SMTP id m2mr19133805otk.338.1553552156903;
 Mon, 25 Mar 2019 15:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-19-brendanhiggins@google.com> <990bfc7d-dc5e-d8d3-c151-9b321ff2ac10@gmail.com>
 <CAFd5g45tOGgf_sKGYRC=fpnTBKGaG=8frbQdgZ3ZTkQFyTfP5A@mail.gmail.com>
 <88fe0546-7850-5bb4-9673-b1aef2dccb3e@gmail.com> <CAFd5g444f-FBq4x3U7BL-EY+bFxP0rsJhJ14=mjOi89PhMkURg@mail.gmail.com>
 <0e311e88-c4d4-e98d-1720-53a04bd526fc@gmail.com> <CAFd5g44NTZoSAJPMvXP2xvJgn7m5QoV-KJu2AMrr67+eL+CKrQ@mail.gmail.com>
 <d9f7e000-4cac-a35a-3ff9-60130e12ebea@gmail.com> <72cd1c5b-6f68-73ad-c8fd-f3a3268a0529@gmail.com>
 <CAFd5g46UU9wk+F6A5wnKYYtYKmmtv__SaY8eg6v-T9xUjsoxhA@mail.gmail.com>
 <bb5bcd3d-a09a-cfbe-c7fa-16e5eb75b0e4@gmail.com> <CAFd5g448xQLOJwVYU5Zmu4+OPWuboiWZPhBvK6au8Pgm5B9haQ@mail.gmail.com>
 <bf094685-3f2a-dc7b-7291-0340136b87f3@gmail.com>
In-Reply-To: <bf094685-3f2a-dc7b-7291-0340136b87f3@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 25 Mar 2019 15:15:45 -0700
Message-ID: <CAFd5g46tpL8KaqKnAEWNRSBWpYMcptu1Eig+nEzq9HX7DF1YUA@mail.gmail.com>
Subject: Re: [RFC v3 18/19] of: unittest: split out a couple of test cases
 from unittest
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 6:47 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 3/21/19 6:30 PM, Brendan Higgins wrote:
> > On Thu, Mar 21, 2019 at 5:22 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> On 2/27/19 7:52 PM, Brendan Higgins wrote:
>
> < snip >  but thanks for the comments in the snipped section.
>
>
> >>
> >> Thanks for leaving 18/19 and 19/19 off in v4.
> >
> > Sure, no problem. It was pretty clear that it was a waste of both of
> > our times to continue discussing those at this juncture. :-)
> >
> > Do you still want me to try to convert the DT not-exactly-unittest to
> > KUnit? I would kind of prefer (I don't feel *super* strongly about the
> > matter) we don't call it that since I was intending for it to be the
> > flagship initial example, but I certainly don't mind trying to clean
> > this patch up to get it up to snuff. It's really just a question of
> > whether it is worth it to you.
>
> In the long term, if KUnit is adopted by the kernel, then I think it
> probably makes sense for devicetree unittest to convert from using
> our own unittest() function to report an individual test pass/fail
> to instead use something like KUNIT_EXPECT_*() to provide more
> consistent test messages to test frameworks.  That is assuming
> KUNIT_EXPECT_*() provides comparable functionality.  I still have
> not looked into that question since the converted tests (patch 15/17
> in v4) still does not execute without throwing internal errors.

Sounds good.

>
> If that conversion occurred, I would also avoid the ASSERTs.

Noted.
