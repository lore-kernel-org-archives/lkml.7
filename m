Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9B0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EFB2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PawLL4xb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfC1G4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:56:24 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35085 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1G4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:56:24 -0400
Received: by mail-vk1-f193.google.com with SMTP id g24so4279816vki.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 23:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fgPHkgnN7KKOSyAKV3+qOJ0BhuadHjKB+sUVU9lStHo=;
        b=PawLL4xbdBASOeTLTVnw4Bp5rfhWIQ2cAKuo1JvakZDmQ5RLEStqwVG1bZJ/OJU8U4
         3xO97Vs1vZNmbGYYs3hszh2uMe2TBhEFT27X/x2Dlm3oqCoBF5Bv/3jZvE4z/3gvmKA6
         mb7V18qcY4VpS0pVH1urH5lV0XjXE6L7fS5wtBNbbUezqsz/Z7ggj82xd9dv4kxijPKz
         or6T97/RW4iogVn23Xsns2LCVfpzPSaWk2yw++g9otENqwS0w0hhp3OaC+t2kjUhlg33
         eWE3TAMkeTc4sq+TLlwXxge6UoGwUMxBnqMoyuz5fzbbGar7xvEs3lQYxnnx9QsvgPog
         RRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fgPHkgnN7KKOSyAKV3+qOJ0BhuadHjKB+sUVU9lStHo=;
        b=JGoygXG6DBuhot2t632BQNmnF8/CPNe3IOUUWZw4B/vU5Ye2LSbxUxhqL+ql9DTL+D
         XqksKvNsZJQe/e/EKzLzuCGWb1yB8P7DtPVal95tJGYZbbm6682MBSWdE+5SqmC/Hkee
         cx1SwcI7bR3iuyzmka6VZSJoTmwcSo/hcFVZt2h7+XRYQCzOVzveXGXJ2krk6KmwphAN
         kYGJpajwBOEiRUoLrCDIAAx7TAbjG9wMwjp6FO9Xv7Zbq7ixjmWHcRAmp42LMmlXxgH1
         R/MCck3jW+HtGpY8h4RzV9yoeZQwMKcOqtLMNvW7KLji1Mg52yOvCf3vDIjvQ2mxajBt
         SaKQ==
X-Gm-Message-State: APjAAAUksNqUuQBJ6SvwgTZq4lfy4cAS/lhma1Jfc1ziCTjZey/W1/sY
        +gVZBkkEgV+vSTIZtlgzZiFPrZQR2w1d774CZOg=
X-Google-Smtp-Source: APXvYqzVTMYXFmOi0NnD5ecBFfUYA62/CTKJz1gwIuX6g3ulbV8ki0Kn8o9vodFG2RbHVKsX0lxmnFPIXhHVdNGwwK4=
X-Received: by 2002:a1f:84c2:: with SMTP id g185mr344411vkd.30.1553756183258;
 Wed, 27 Mar 2019 23:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190326081335.GA4175@ogabbay-VM> <20190327010901.GA30198@kroah.com>
 <CAFCwf135COOzZmtJEGUFhJaOdBpETLB6VnSmXRabBtyLs3f6Kg@mail.gmail.com> <20190328062951.GA24619@kroah.com>
In-Reply-To: <20190328062951.GA24619@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 28 Mar 2019 08:55:57 +0200
Message-ID: <CAFCwf13V-wZaJfDoz3YjNrRHn3AGQA1jc+jwjVDa-H-UFqsxmw@mail.gmail.com>
Subject: Re: [git pull v2] habanalabs fixes for 5.1-rc3
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 8:29 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Mar 28, 2019 at 08:09:13AM +0200, Oded Gabbay wrote:
> > On Wed, Mar 27, 2019 at 3:09 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Mar 26, 2019 at 10:13:35AM +0200, Oded Gabbay wrote:
> > > > Hi Greg,
> > > >
> > > > A couple of important fixes for habanalabs driver:
> > > >
> > > > - Fix host crash upon resume after suspend
> > > > - Fix MMU related bugs which result in user's jobs getting stuck
> > > > - Fix race between user context cleanup and hard-reset which results in
> > > >   host crash
> > > > - Fix sparse warning
> > >
> > > Much better, thanks, now pulled and pushed out.
> > >
> > > greg k-h
> >
> > Hi Greg,
> > In which branch do I see that ? I tried to find it in your char-misc
> > repo but couldn't find it.
>
> It should be in the char-misc-linus branch of the char-misc.git repo on
> git.kernel.org.  Note, I was in the air for a long time yesterday, so
> the emails probably went out 8 hours before I was able to push out the
> git repo, but it should all be synced up now.  Sorry for any confusion
> there.
>
> greg k-h
ah, ok. no problem, just wanted to make sure I'm looking at the right location.

Oded
