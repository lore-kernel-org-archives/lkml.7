Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FB1C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 15:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67EED2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 15:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cuJ/5gZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgAGPUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 10:20:12 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39085 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgAGPUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 10:20:11 -0500
Received: by mail-qk1-f193.google.com with SMTP id c16so42937488qko.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 07:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zMC0D14dj2hnqDpOJqe45pC1Dp6N7qVxQJPEatsCc6I=;
        b=cuJ/5gZ9X97GklVq8JVr7wE+lIXTURkffRI2tKFtW3cdXYU2i3a5Gl168bjtwsSMlL
         pmU6MhafV0yWNwSZwKsyGd24X8U/l29rOE+PLYIgRuiFMDfzuH1vsISZjrV0lvZtViPN
         IEDf8SHVYwwIynT9JoD/Oz0+ba0LEPIJgbDBNRDeCLb24g6hkLDMpOaJStJ2HWWPxRU3
         A/QfFAplWmou3GbTLNBCLIs8L+uXdeynUz0U3QGxNMoVsOwBdKRDo1yWaZc9ERwbtjr6
         OiHlUzy9HsH9NmIYj0s2syHm9/5fPvA2kHqFdtNNpVv3rvTlLBn2jSeD2LWJS/muZgmJ
         ZfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zMC0D14dj2hnqDpOJqe45pC1Dp6N7qVxQJPEatsCc6I=;
        b=Cw5p4Ju+as/Y6mtg48FAtKzelL7huelrjXw1iLGyRNMq2PrDAQCkCvS7+suXaOPy8B
         VkjQXUgqIjSUXsAp7Cl9sIBLZPX+Juv0I5ggYDFRo7m3cDX4zkHjbXDYwMuUvy0j/m4a
         HnHz6R0mtyVplSwSv9GeH4/g08ws4/FYfyJ8XaQ7IpRvy/sTYq83PG27VTaM+5Nhv/Ki
         ym5tyCA8HhyhsYaZbsLgGl6ijo8sHmjoGcshRU5JWv6XEha91R6ytUpZhPgkjS0pQE09
         UcElWvUvSRtOw7tLBqtLNo6ssr1PLd3voq4B7B5EoyvL1KQUsX/yCYseMFQn7nvttPYj
         hk5Q==
X-Gm-Message-State: APjAAAWoExM7rghxmPBn901MRD63mEsf2kyJUB7GsIvCWroNwfL6cn7J
        rjhUVHr2buON9vg0DE1c/WZeA0f3RTAkzqQN05S1jFkl
X-Google-Smtp-Source: APXvYqzkx9Kde1+bXWo1koJC0GZ8OeGh8BvVia6pS/1d7YHZTR5Syg3ap2uzqVl2IouNuEmhFVt3jJ/cqFmSlc15j+8=
X-Received: by 2002:ae9:e413:: with SMTP id q19mr13427713qkc.323.1578410410735;
 Tue, 07 Jan 2020 07:20:10 -0800 (PST)
MIME-Version: 1.0
References: <20191224120709.18247-1-brgl@bgdev.pl> <CACRpkdZ_TroKCAnDWiY-jPbe0NL+ingm1pMLQLPxT1Uh78kx8g@mail.gmail.com>
 <CAMpxmJXikLw0d1e1Eq7vVzoORz3utEBxfG6nRmkngLqezVqtuA@mail.gmail.com>
 <CACRpkdY2NXNrAk9VY18YDeQ2WDfDfAyi4mgW26JuTPHdEOE-uQ@mail.gmail.com>
 <20200107144455.GF32742@smile.fi.intel.com> <20200107144548.GG32742@smile.fi.intel.com>
In-Reply-To: <20200107144548.GG32742@smile.fi.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 7 Jan 2020 16:19:59 +0100
Message-ID: <CAMpxmJWkKPQYAE3_JdWVkdtSZLeky=bouOyyJ+c2ySMc+1LFyw@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] gpiolib: add an ioctl() for monitoring line
 status changes
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefani Seibold <stefani@seibold.net>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 7 sty 2020 o 15:45 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Tue, Jan 07, 2020 at 04:44:55PM +0200, Andy Shevchenko wrote:
> > On Tue, Jan 07, 2020 at 01:50:28PM +0100, Linus Walleij wrote:
> >
> > ...
> >
> > > Let's try to CC the actual author (Stefani Seibold) and see if the ma=
il
> > > address works and if he can look at it. Or did you already talk to
> > > Stefani?
> > >
> > > (git blame is always my best friend in cases like this, hehe)
> >
> > Recently I started to be smarted in such cases, i.e. I run also
> > `git log --author=3D'$AUTHOR'` to see if they are still active and
> > what address had been used lately.
>
> ...and another possibility to `git log --grep '$AUTHOR'`.
>
> --
> With Best Regards,
> Andy Shevchenko
>

So if some module doesn't have an official maintainer listed in
MAINTAINERS, we should still get a review from the original author?
KFIFO lives in lib/ - is there even an official maintainer for all
library helpers?

Bart
