Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2484C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE03213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vlXhpm74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfCMTww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:52:52 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42817 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfCMTww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:52:52 -0400
Received: by mail-vs1-f66.google.com with SMTP id c189so1785369vsd.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 12:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cjdeQoiG1CNqxDr3JRQdESRZNgyXUbmkKypj0mAhhmU=;
        b=vlXhpm74SJXur6SrLE48nJ6+mfVl9SDyFvy0gYifys0dVKBh1a6vAYTa0HH3LNCT9T
         ogOf9/IClNoYF+1sAShrEgsksL6UpQBj6U+Wd0XZh8+hBT9v1nrCQTiN4Adme141ZDfQ
         1L7h2ugFFyDqvhYj+Gfiu8KzJewb9VpYRGN7b+oIm9Qxa5tBhXNcfQr4SOsvP3c0LdR1
         9HraVKYsazq1QpAvqCms8Pk5ybzgs0qDKmdnJiadl/SH/nlfubtR/ru8ORph0lIKZIGQ
         ikXygKns8wJUPCSqenfcxlK9rBVjIJPqP249sg0A/72DYiXaGxOcIx2XMAGrv8Q7TDnh
         +nlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cjdeQoiG1CNqxDr3JRQdESRZNgyXUbmkKypj0mAhhmU=;
        b=iMEqSc1K2jCh1ERd3hHKSqAcIaoix0rxcp5I9BrHU0e4n+kbyaSG8+W0iEbhO2UpNf
         MVPNkrJCPQ+wLG1VqM3j0gqhn9pfoIUKMb+on4xFl4SLW7QCIIHmv2BQNs3Cb16cQqkj
         7Wo3/OIgN+1h4lT6NO+kcFM3VZLPV84+rbckHlzrE9cjkFmo1ufUtAiHd/jCZUadF94h
         xmhCVIsDSueIPu6LcehpY6hZ8ZnyzejJh7P7BdQGE4dIPQgPFo3FXDe6sDxRz8TupFdz
         +1DqVl24nnnQ1N3SJsG91XALWthBBawufcFxFRcTJdDJDnJKxDODLGRmpa88vL0CjUwW
         CNeQ==
X-Gm-Message-State: APjAAAWTiE9y6IncV8/r770mXKzqpK8v9Z+FPT3OOHhVFlhcclkGqv4P
        Joed+vgTn8rjXLEE9uhjiWfnEZngzpeDKmCAHAmyNw==
X-Google-Smtp-Source: APXvYqyy6VfIy5GhgM6JCvhHivvrjUdIsOIGIpnjpbo1kO4TEY492dPrJ8asN+wprEt5Ev8O4VE6A3e0GjF2r2dnxQY=
X-Received: by 2002:a67:fe51:: with SMTP id m17mr6089630vsr.35.1552506770869;
 Wed, 13 Mar 2019 12:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190312065128.24994-1-jiada_wang@mentor.com> <CAMuHMdUEnzgwAqBC=vTYWnrzC5HrqC5f5gDLWJFSJRYAu+DD1g@mail.gmail.com>
In-Reply-To: <CAMuHMdUEnzgwAqBC=vTYWnrzC5HrqC5f5gDLWJFSJRYAu+DD1g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Mar 2019 20:52:14 +0100
Message-ID: <CAPDyKFpCOfAURN0=ZfS5yXH-ZrCfpfH+iNUwh=fZZ-wViKYQqQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] PM / Domains: Avoid a potential deadlock
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jiada Wang <jiada_wang@mentor.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 at 15:45, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Jiada,
>
> CC Marek, Jon, Mike, Stephen, linux-clk, linux-renesas-soc
>
> On Tue, Mar 12, 2019 at 7:51 AM Jiada Wang <jiada_wang@mentor.com> wrote:
> > Lockdep warns that prepare_lock and genpd->mlock can cause a deadlock
> > the deadlock scenario is like following:
> > First thread is probing cs2000
> > cs2000_probe()
> >   clk_register()
> >     __clk_core_init()
> >       clk_prepare_lock()                            ----> acquires prepare_lock
> >         cs2000_recalc_rate()
> >           i2c_smbus_read_byte_data()
> >             rcar_i2c_master_xfer()
> >               dma_request_chan()
> >                 rcar_dmac_of_xlate()
> >                   rcar_dmac_alloc_chan_resources()
> >                     pm_runtime_get_sync()
> >                       __pm_runtime_resume()
> >                         rpm_resume()
> >                           rpm_callback()
> >                             genpd_runtime_resume()   ----> acquires genpd->mlock
> >
> > Second thread is attaching any device to the same PM domain
> > genpd_add_device()
> >   genpd_lock()                                       ----> acquires genpd->mlock
> >     cpg_mssr_attach_dev()
> >       of_clk_get_from_provider()
> >         __of_clk_get_from_provider()
> >           __clk_create_clk()
> >             clk_prepare_lock()                       ----> acquires prepare_lock
> >
> > Since currently no PM provider access genpd's critical section
> > in .attach_dev, and .detach_dev callbacks, so there is no need to protect
> > these two callbacks with genpd->mlock.
> > This patch avoids a potential deadlock by moving out .attach_dev and .detach_dev
> > from genpd->mlock, so that genpd->mlock won't be held when prepare_lock is acquired
> > in .attach_dev and .detach_dev
> >
> > Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>
> Thanks a lot for your perseverance!
> I had tried putting each PM Domain in its own lockdep class, but that
> didn't help.
>
> Your patch fixes the lockdep warnings on my Salvator-X(S) boards.
>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Your solution makes sense, as the .{at,de}tach_dev() callbacks are
> owned by the individual PM Domain drivers, and not by the genpd core.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> One thing I'm still wondering about: genpd_add_device() is always called
> with gpd_list_lock held.
> However, the same cannot be said about genpd_remove_device():
>   - pm_genpd_remove_device() does not take gpd_list_lock, unlike
>     pm_genpd_add_device(),
>   - genpd_dev_pm_detach() does not take gpd_list_lock, while
>     __genpd_dev_pm_attach() does take the lock for adding,
>     but not for removing (in the error patch)?

That's correctly observed and it's something that needs to be fixed in
the long run. Although I am not sure that we should use the
gpd_list_lock...

There are race conditions while removing a device at the same time as
the genpd is removed. As a matter of fact, even the debugfs isn't
correctly dropped, when a genpd is removed. However, because almost
none it ever removing a genpd, this isn't a problem in practice.

Anyway, I have a TODO list for genpd (starting to be quite longe) and
this one is already on it, whatever that means. :-)

[...]

Kind regards
Uffe
