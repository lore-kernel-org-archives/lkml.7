Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E951C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138A120882
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DM1MD4xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfEJQUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 12:20:40 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:54137 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbfEJQUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 12:20:39 -0400
Received: by mail-it1-f180.google.com with SMTP id m141so8888150ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 09:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=12k3jWQ0JutayB4pYTFiifF3qbZAFod36oxGbGWYTL4=;
        b=DM1MD4xkQL6qZVNRbFsqulgRFd7kcuZeaaF1otjmrfxY6P35bMMGBmFNpP7uuyqu59
         LCrtr60OPM+MIvJ8mTs8SDvfWBzsNDFJkN0t+7jXf5pF4Q/7jCXHV7iCb9Gc8R++k5Ch
         SIdl8H6o5ZUlkE7RC3C0sQ1cBXoitSI+t9w/ai3+C3OMG3+fs5pfuAoww4+2ksl/M41i
         qLbdVqhmFcQjYCBgmOy9FOBJHwNt31GzIddfg6oQ/36kLgUabQWBdKqFnUcdknD5am9E
         LHTd1oRI+8T58ABXPcrSQOXM6RUm28+CIQW1I3EaH0LLwMmJEGtdEwVxmGjIPTXzz760
         2JEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=12k3jWQ0JutayB4pYTFiifF3qbZAFod36oxGbGWYTL4=;
        b=kyo33LZL41fyR7U/kToNFSqJx/05/QgSSMASHXy2A9DvmeaGlP435JPU1Qf37AtWT8
         UUlZF+lzeI5hesOoRrGVh3zy7haABqLZ+DQp9LERTqq1t+8PxAF64MDJ4tKWdiabT9kF
         BVWW9dCmAOdBGaD6NwUVesEINf/gI/nBckFMBP8u6Nk53D1VORODJG+QJs+rb0H7yhYj
         2/VTSpeRmQbaphWHL7PV9zMpxuOvy9r0ZDSYk2RLwpz2EKypy4txoz7c602tLKGaLU28
         alxX0tfbmX0DsufPyTC5Rhwiq+R0jDkw13imzpwzeSX01KO47xmdUoZzIOgujM48P8Wb
         9Zcg==
X-Gm-Message-State: APjAAAXvQsynOuBT+TajncexN+9pVt6+/snzXsRXjkZ9qlO7+IB3fHMl
        wR8A1NcBualrbubxbWvsxSdbNFMONDGq54LTH/QE6g==
X-Google-Smtp-Source: APXvYqy6r4u/9FxZ/sqXyVZnJLhaLccKOai9l9fDW51iJ7io13Qgg+/BFMRaQhJVVdqUgo52HfdHzZtLHjbIJcT/gz0=
X-Received: by 2002:a02:1986:: with SMTP id b128mr8973936jab.136.1557505238682;
 Fri, 10 May 2019 09:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190411094944.12245-1-brgl@bgdev.pl> <20190411094944.12245-5-brgl@bgdev.pl>
 <CAFLxGvwb8YzNiXCXru8Tw9pxH9qoc7gAO4sk0MXK1Xmp7fm-2g@mail.gmail.com>
 <0e8fbdf3-c40d-e4e8-6235-c744ec7317c3@cambridgegreys.com> <684874198.48863.1557299587958.JavaMail.zimbra@nod.at>
 <CAMRc=MdsA7A1DdS1ZJ8NS8xtuCjgc_7WZD1797H3oZ=2w+fOBA@mail.gmail.com>
In-Reply-To: <CAMRc=MdsA7A1DdS1ZJ8NS8xtuCjgc_7WZD1797H3oZ=2w+fOBA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 10 May 2019 18:20:27 +0200
Message-ID: <CAMRc=McCxvwHgk-3wYE0e+qxJNoHK0AmpJWjNsOZBmGF2yFT6Q@mail.gmail.com>
Subject: Re: [RESEND PATCH 4/4] um: irq: don't set the chip for all irqs
To:     Richard Weinberger <richard@nod.at>
Cc:     anton ivanov <anton.ivanov@cambridgegreys.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Jeff Dike <jdike@addtoit.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-um@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 10 maj 2019 o 11:16 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a=
):
>
> =C5=9Br., 8 maj 2019 o 09:13 Richard Weinberger <richard@nod.at> napisa=
=C5=82(a):
> >
> > ----- Urspr=C3=BCngliche Mail -----
> > >> Can you please check?
> > >> This patch is already queued in -next. So we need to decide whether =
to
> > >> revert or fix it now.
> > >>
> > > I am looking at it. It passed tests in my case (I did the usual round=
).
> >
> > It works here too. That's why I never noticed.
> > Yesterday I noticed just because I looked for something else in the ker=
nel logs.
> >
> > Thanks,
> > //richard
>
> Hi,
>
> sorry for the late reply - I just came back from vacation.
>
> I see it here too, I'll check if I can find the culprit and fix it today.
>
> Bart

Hi Richard, Anton,

I'm not sure yet what this is caused by. It doesn't seem to break
anything for me but since it's a new error message I guess it's best
to revert this patch (others are good) and revisit it for v5.3.

Bart
