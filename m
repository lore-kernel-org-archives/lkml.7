Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C06C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275A42146F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="LG4g0FzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfGBGzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 02:55:47 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45597 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfGBGzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 02:55:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id j19so17316574qtr.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 23:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AaShN4uzWBaZgTNfwJ+uYc/JtqMs0g8gjyrH491TL9U=;
        b=LG4g0FzNQCEpM6Jgott6CJtfjELkxt2QX5zMxIHtRrLMXVV4JP4v3Ao+9+Z16gemDc
         StGo3rufp8Ml9CrSTk1rK+M+yUBMMn9iT5yxx//AaXqGEWybzpz9bSz4CY3jTQ+k/ILs
         AnV/JqiPfUhzCX5jnj7vPRXN0aoFmFJ6I2MLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AaShN4uzWBaZgTNfwJ+uYc/JtqMs0g8gjyrH491TL9U=;
        b=iQ4lvWNryOtUzZQbWWCD3Me9u6Wym2ZK4RzuxnXf2gP+PvX+xowWOIY62h04+OAdjW
         n50fRvUvJPu6tk1P4deuWns9AWXL/gq6UpXD+MxJPp2bjJoxItprfbyN7fWftEkAsRki
         baLXqg1HyPhBIRfg+PKBdZzuP12xOZYEuCr0V/PVm0pNlFMIUQAda3w1oFypEbM+59RT
         dGCfpha1EZylOdRFdSV4quz2k/8hjWUgFKMyGxwE5kg68EQCj2ygjVHietPJ+OMwxGir
         njGrUkwRzlAzeB2xIjasiU7MwPXeJMKoKj+hf4wc8iINXUjdNW7kwGQ35HP6efNZx6j3
         8Z7g==
X-Gm-Message-State: APjAAAVr3QwJRn5tS/1NGVOvGSg90T2hlV7UZBjOjrRYaHwLgGjCeVf3
        9kfc4VRtznaD/HW5cyhkJncx5DeT42+dFw9/e7o=
X-Google-Smtp-Source: APXvYqxxL32lDW2eJq5ZR/Bwv4c7ZoKjvNF5ploCqIwlzJx1ZYe4X32zlkFmLYa3y6+UuIj+8ElkFM3sDRFDhFXS70Q=
X-Received: by 2002:ac8:1887:: with SMTP id s7mr23797517qtj.220.1562050546348;
 Mon, 01 Jul 2019 23:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190702043706.15069-1-joel@jms.id.au> <20190702063323.GA53677@archlinux-epyc>
In-Reply-To: <20190702063323.GA53677@archlinux-epyc>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 2 Jul 2019 06:55:33 +0000
Message-ID: <CACPK8Xd0cnpJ5L9pAjy=9qyhq6sGuyjoqMyneK4bD3+HvCb+kQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add FSI subsystem
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2019 at 06:33, Nathan Chancellor <natechancellor@gmail.com> wrote:
>
> Hi Joel,
>
> On Tue, Jul 02, 2019 at 02:07:05PM +0930, Joel Stanley wrote:
> > The subsystem was merged some time ago but we did not have a maintainers
> > entry.
> >
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> >  MAINTAINERS | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 01a52fc964da..2a5df9c20ecb 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6498,6 +6498,19 @@ F:     fs/crypto/
> >  F:   include/linux/fscrypt*.h
> >  F:   Documentation/filesystems/fscrypt.rst
> >
> > +FSI SUBSYSTEM
> > +M:   Jeremy Kerr <jk@ozlabs.org>
> > +M:   Joel Stanley <joel@jms.id.au>
> > +R:   Alistar Popple <alistair@popple.id.au>
> > +R:   Eddie James <eajames@linux.ibm.com>
> > +L:   linux-fsi@lists.ozlabs.org
> > +T:   git git://git.kernel.org/pub/scm/joel/fsi.git
>
> Just a drive by review, this link does not work, seems it should be:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git

Thanks Nathan, good catch.
