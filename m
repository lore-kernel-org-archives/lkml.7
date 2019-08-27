Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E27EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3F720828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfH0JSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:18:55 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35541 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfH0JSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:18:54 -0400
Received: by mail-oi1-f194.google.com with SMTP id a127so14408428oii.2;
        Tue, 27 Aug 2019 02:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OVULxG89XFAHB1HH6NIasvz1p9D2uKsiFcCnfRE8CtE=;
        b=TRxrPt8vSJP5G11IsVCYVPwBYMAgO7cBB6Ea/g2g+eOIL00XKvRYr2l/K1j40GlxqL
         xR92uUxLb6zCEU/UdSdrmiwiPj7Md/IGkmHTOq3hPZDQno0nbjQ/1O/Ajri/4KfZJ3XA
         XfSD56seUZ3f6Ldkgqae5DdcG4HPjIMSSk/OOs+2dYocT1x0VpgZrA2eS2FE2yX3RfiR
         W+qQf4Nq+8DcYc8HArh4JkerEsnpitM2opeA3FjjaU/gcorEFGyEvZNtMV2QtbySg8Z7
         RvXRkjYo400GtGdcJwUScgJ9D6oUSVCQP8XaXScboSPxc7vc2Cnu6vm6QJHCelF82fdp
         hYwg==
X-Gm-Message-State: APjAAAUT9PsbZiGzl6bnhUeBijEFOHChOATATVCZ2BQCEFUJG7L0frCj
        82t/S4Wk/KFFWwq55Wt4z744EuBBiMsjkg5HVsoavg==
X-Google-Smtp-Source: APXvYqznMhXUExLuIctyuUXvUpp1m+dbcAX8l5N1M3gPdd5A2IghYw0lD32NruIo8f1qmoDoeL8ybGZyqyyUyBwsE0I=
X-Received: by 2002:aca:b154:: with SMTP id a81mr14710961oif.148.1566897533576;
 Tue, 27 Aug 2019 02:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190826195740.29415-1-peda@axentia.se> <20190826195740.29415-3-peda@axentia.se>
 <CAMuHMdVx77aOyUVhZ2_N76VAP+AJ3X8w-gdHLjnjUEeRKcZmOA@mail.gmail.com> <a31ff144-f037-3580-08b5-aa368572c69d@axentia.se>
In-Reply-To: <a31ff144-f037-3580-08b5-aa368572c69d@axentia.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Aug 2019 11:18:42 +0200
Message-ID: <CAMuHMdXTm8n=SXyRejT27Q9Vxv0hw5C8DQDXiNM=06aYXq=dgQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fbdev: fbmem: allow overriding the number of
 bootup logos
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Aug 27, 2019 at 10:54 AM Peter Rosin <peda@axentia.se> wrote:
> On 2019-08-27 10:36, Geert Uytterhoeven wrote:
> > On Mon, Aug 26, 2019 at 10:46 PM Peter Rosin <peda@axentia.se> wrote:
> >> Probably most useful if you only want one logo regardless of how many
> >> CPU cores you have.
> >>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >
> > Thanks for your patch!
> >
> >> --- a/Documentation/fb/fbcon.rst
> >> +++ b/Documentation/fb/fbcon.rst
> >> @@ -174,6 +174,11 @@ C. Boot options
> >>         displayed due to multiple CPUs, the collected line of logos is moved
> >>         as a whole.
> >>
> >> +9. fbcon=logo-count:<n>
> >> +
> >> +       The value 'n' overrides the number of bootup logos. Zero gives the
> >> +       default, which is the number of online cpus.
> >
> > Isn't that a bit unexpected for the user?
> > What about making -1 the default (auto), and zero meaning no logos?
>
> I just naively assumed there was some other mechanism to disable it.

That was my first thought, too, but I couldn't find one.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
