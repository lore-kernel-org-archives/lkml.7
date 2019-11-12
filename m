Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720DFC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C60D206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CdDTpHJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfKLIed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:34:33 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35770 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfKLIec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:34:32 -0500
Received: by mail-oi1-f195.google.com with SMTP id n16so14089970oig.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 00:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MTG7lQ0u9d8+q6rZMou9pMrXlqU/RMiDOcUJ4lZKiNI=;
        b=CdDTpHJF5JfhHDfSz4685fIPM0bW1Po430XfabG9F39pJJ1M9kCJeqGRakUVSC+FLC
         tT8Vos+VLGJcTMF0Sb1FEJtfUC0msCmnXmvPehTqz0iJYxwaGKWSN/j1cIbr07RzNQHs
         H5SlgF0t/HyHHC/YDR1W/r3rulnzQmYVK56eZvmgcUwREDnf60xguJnI18NNXp0Sh5GD
         j0lVfM/Q1du8kbgLkazEg4HXI6gmX5A0tYsNGm8wI1Nc9BRWeUGgIOh1dBx+XLO12fhU
         DwqlDy022kjhZFw+BQthvhXTui3Z06Aq+ubLFo4UmJYb+6zCs+YUAIZy/SiCfXvvmp4y
         CfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MTG7lQ0u9d8+q6rZMou9pMrXlqU/RMiDOcUJ4lZKiNI=;
        b=GKULl4Yp5+Cbk6LNSLm3IcfzFlLYfNIpzq8o2MrcL0AqSPUsFUf2SwayOrFwRvYmyJ
         5NpOzeOlSZ6ihH5j364NnaJLTqQ2WpRPTKMtO8dBwvJ9DG5rMGKWCXbVNwC9rYmsPsY+
         kHWCsSl/K7feJ5m8fI3EZV+LCMbLRUVQzgijcWxQy0MSlHN5XgeepwP5uNQNNYQMiEM9
         tuNLLmexxbbvVG6oURZePN0t3zFmVlLR+06io6cO8ssNvCIuibIVXjz3YcKwDOP9m1+M
         qRxx4cZklRLfJFlcZBfPJ/Y8IpFQhBGg5DBPaPFdmrOev/GLUti3+zQ/jMLWPArlVWDC
         pMGA==
X-Gm-Message-State: APjAAAWOkm8LV4dwQtWpUspXS6eFrpwiwuen79VkWkiI5JJRy4k+aRhy
        Zf1hha5/qhKARFiZOj1NuErdpChaj2VDQIoLwO1rpw==
X-Google-Smtp-Source: APXvYqzZSK4e0j7BXXGNWcEizolV+MKKXgi6/U6VUYoFSuN01kfxTSzYRyGOR2AKFnJjEAXlcGYuPy+laClqHV/y/cA=
X-Received: by 2002:a05:6808:9a1:: with SMTP id e1mr2995041oig.175.1573547671896;
 Tue, 12 Nov 2019 00:34:31 -0800 (PST)
MIME-Version: 1.0
References: <20191109155836.223635-1-colin.king@canonical.com>
 <CAMpxmJVC5GGhR0z_4CkF7Opfw-5HpEKD8fUrKsgBZTbz0wDd-Q@mail.gmail.com> <alpine.DEB.2.21.1911120033220.1833@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1911120033220.1833@nanos.tec.linutronix.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 12 Nov 2019 09:34:21 +0100
Message-ID: <CAMpxmJVjVNXBu5t9Mv8PT854Fh=hH6K-L-BTjhEFMt3nkCcwUA@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/davinci: fix memory leak on
 clockevent on error return
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Colin King <colin.king@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 12 lis 2019 o 00:37 Thomas Gleixner <tglx@linutronix.de> napisa=C5=82(=
a):
>
> Bartosz,
>
> On Sun, 10 Nov 2019, Bartosz Golaszewski wrote:
> > sob., 9 lis 2019 o 16:58 Colin King <colin.king@canonical.com> napisa=
=C5=82(a):
> > >
> > > From: Colin Ian King <colin.king@canonical.com>
> > >
> > > In the case where request_irq fails, the return path does not kfree
> > > clockevent and hence we have a memory leak.  Fix this by kfree'ing
>
> s/we have/creates/  or whatever verb you prefer.
>
> > > clockevent before returning.
> > >
> > > Addresses-Coverity: ("Resource leak")
> > > Fixes: 721154f972aa ("clocksource/drivers/davinci: Add support for cl=
ockevents")
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > ---
> > >  drivers/clocksource/timer-davinci.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksourc=
e/timer-davinci.c
> > > index 62745c962049..910d4d2f0d64 100644
> > > --- a/drivers/clocksource/timer-davinci.c
> > > +++ b/drivers/clocksource/timer-davinci.c
> > > @@ -299,6 +299,7 @@ int __init davinci_timer_register(struct clk *clk=
,
> > >                          "clockevent/tim12", clockevent);
> > >         if (rv) {
> > >                 pr_err("Unable to request the clockevent interrupt");
> > > +               kfree(clockevent);
> > >                 return rv;
> > >         }
> > >
> > > --
> > > 2.20.1
> > >
> >
> > Hi Daniel,
> >
> > this is what I think the third time someone tries to "fix" this
> > driver's "memory leaks". I'm not sure what the general approach in
> > clocksource is but it doesn't make sense to free resources on
> > non-recoverable errors, does it? Should I add a comment about it or
> > you'll just take those "fixes" to stop further such submissions?
>
> There are two ways to deal with that:
>
>   1) If the error is really unrecoverable, panic right there. No point
>      to continue.

Fair enough.

Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

>
>   2) If there is even a minimal chance to survive, free the memory and
>      return.
>
> Adding a comment is just a useless non-option.
>
> Thanks,
>
>         tglx
