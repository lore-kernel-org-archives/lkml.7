Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986FEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F30F20693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfCLPEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:04:41 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:36197 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLPEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:04:40 -0400
Received: by mail-vk1-f193.google.com with SMTP id v131so725381vkd.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LC2uMFVcIfOFBJyr6Lnd0zST40zv6r9ebxtQOl8nm4I=;
        b=EbZ7M3SITWXVWlqv/lSm2uBObGaeH7I6b+2G4Qq9+Nxj3sPOTr3jVnYtS3bMt/1yNv
         OB8ptX/9B5i12v7Bv869wi1p+LwI7gJadtF/RHqpszxn4Of5J7/j0tetg7Wne/uN2D5B
         zhs81NF4p8fSomCG15jGDqiHDiB94R6R9b0GEhUa4oZw4MiNIwssyKBL6UX1NsvD0mjl
         x/1HpPoE3WfNHiutx3EJNwBZZThxHC2I+3TyVpGudYry5ESJ7SZ7Lh26S3jVO1klZq5L
         HuWeopSxpq7EWCq5YB4Tsn8QP9BoL46nPa/4ItX9Jexs+6WjglHbV6isLlFfK7arfEdM
         gFGg==
X-Gm-Message-State: APjAAAXeZ35nUZDxseKSUMAfJP9xpjOjODYKRcxcKP+3xgkRXBmBurt0
        WsMh3IpWRdTfUhQwoa5CBIGNox+6xutHavWFm98=
X-Google-Smtp-Source: APXvYqzy7HwD9ZC59g5IYcnbKxewy5ha05SopJ3St6n1IT3KKZBrWsmOQ/Mk/qBKadpEUi8c5icf2kF4OByduGoL9Fo=
X-Received: by 2002:a1f:711:: with SMTP id 17mr20617046vkh.65.1552403079861;
 Tue, 12 Mar 2019 08:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190312131830.4253-1-andriy.shevchenko@linux.intel.com>
 <CAMuHMdVTKRJJDqtpgExmEmwnYcpF8h2xTtbXwKLnVmVPz0bZqw@mail.gmail.com> <20190312144052.GC9224@smile.fi.intel.com>
In-Reply-To: <20190312144052.GC9224@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Mar 2019 16:04:27 +0100
Message-ID: <CAMuHMdUwEdNHdSGHT2urXFm4T74yYVEfHkQJqsZGsQhveqC17g@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] auxdisplay: hd44780: Fix memory leak on ->remove()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Mar 12, 2019 at 3:40 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Mar 12, 2019 at 02:47:01PM +0100, Geert Uytterhoeven wrote:
> > On Tue, Mar 12, 2019 at 2:18 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > We have to free on ->remove() the allocated resources on ->probe().
> > >
> > > Fixes: d47d88361fee ("auxdisplay: Add HD44780 Character LCD support")
> > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Thanks, nice catch!
> >
> > (wearing a newer (and hopefully wiser ;-) hat than when I wrote the code)
> >
> > While this is correct for the current implementation of struct charlcd_priv,
> > this may be a bit fragile.
>
> This patch will be the same in the next version due to possibility to easy
> backport.

OK.

> > What about adding a charlcd_free() wrapper, which can do kfree(to_priv(lcd)),
> > and be used in the probe failure path, too?
>
> This has been partially done in the rest of the series, but I got your advise
> and will change to use to_priv() in v2. Thanks!

Ah, hadn't noticed the rest of the series. Will review...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
