Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F33C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FED920857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f6pryCGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbfCZJf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:35:59 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41432 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbfCZJf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:35:58 -0400
Received: by mail-oi1-f194.google.com with SMTP id v7so9365293oie.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 02:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bIY+fkbexVaxvXrS3bewaeA85IQDnRpprN8nuohZs88=;
        b=f6pryCGzQ2y+gEknsl5UF05Xqv6hslVAz3pE1gT3bHORbG59psOxYQrjltTe1PohQZ
         nTchWO5Os421pnnGnbjUD2rM7flBH006aQ+khABdb5G/QLUpL9yxZ7egdK9Lm7nMzj9b
         d3iIiDxmYpV6cmaB0JfeX0sGBo9AkysCb/7NlYxZIjrZpEwZN27zCkhIaI0WJd7JjQhm
         OT7YjNA+ZwfOuiECzKmeVuIOyIpvWYuldCIfujPvXHV/FGKY8iKaX6EfJfShFVRo3DHX
         9olOk+d/276rc+MF9EyvJSP9YBqg6a5rs6HtilsWSF4TEf08BeHo3S0SgLnNnlFAY1UA
         8ABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bIY+fkbexVaxvXrS3bewaeA85IQDnRpprN8nuohZs88=;
        b=tbXG/C45sGjhTfFqI+vVfoL4ILEQpN3FxR0mCSBc1Wvwwlt38tRiKS7meaUoaiugSg
         tttG+2xwLsTAd6xvuKeb4dItKXbpcmuuKBwMNv+5vUGU0NnpJp/CXlZgvn37ri+HGyIi
         FE6/CdOJvAMP4qm5ZhaLIAjjOvzA8rmCc/SQ0tAxFKavl6Knw22JgrqCMOTedSO2clJF
         7a9ndHEBFIy6ec46F5n4/pYD5l/Jb9q1bbhgcAhauq6FABUAuCe0Rex7eWHYBsrS+I/r
         bCwxxFkWKinoF+ZLMoZFpY/uDOtCPmEQ98Tf36uwg0nD0o0ZBapfJI37hYyr0pooH92j
         +tPA==
X-Gm-Message-State: APjAAAUTbZmrnq6x3b+fxCqQJ/NJrx9bMeJdvXzKY6DXlY8WuvblY2vX
        8KgVWvQk5BlKvJoMXatGuBqooiJpQPRBvgDzyoowvQ==
X-Google-Smtp-Source: APXvYqxqpAOAsh6kfOS/6fvnzYVKb7YEuhNzr0wz8wUhYjUYFJdBRpQiwBkptM7M48fD6Cxixr0LLA9oT75R5DmLgio=
X-Received: by 2002:aca:b607:: with SMTP id g7mr759332oif.6.1553592958180;
 Tue, 26 Mar 2019 02:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190322154425.3852517-1-arnd@arndb.de> <20190322154425.3852517-5-arnd@arndb.de>
 <20190326011319.GC29420@kroah.com> <CAK8P3a1u_2gz=UieoNT7yOqSKFvFOXA34CAs7w+qouoQTjqDgQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1u_2gz=UieoNT7yOqSKFvFOXA34CAs7w+qouoQTjqDgQ@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 26 Mar 2019 17:35:46 +0800
Message-ID: <CAMz4kuJJPS+GBQqJ4p-PebbKJt5MKK4vQv5EwJAPpL64fBDKLQ@mail.gmail.com>
Subject: Re: [BACKPORT 4.4.y 04/25] USB: iowarrior: fix oops with malicious
 USB descriptors
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Ralf Spenneberg <ralf@spenneberg.net>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@spreadtrum.com>,
        Baolin Wang <baolin.wang@spreadtrum.com>,
        orson.zhai@unisoc.com,
        =?UTF-8?B?Q2h1bnlhbiBaaGFuZyAo5byg5pil6ImzKQ==?= 
        <Chunyan.Zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 at 16:21, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Mar 26, 2019 at 2:23 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Mar 22, 2019 at 04:43:55PM +0100, Arnd Bergmann wrote:
> > > From: Josh Boyer <jwboyer@fedoraproject.org>
> > >
> > > The iowarrior driver expects at least one valid endpoint.  If given
> > > malicious descriptors that specify 0 for the number of endpoints,
> > > it will crash in the probe function.  Ensure there is at least
> > > one endpoint on the interface before using it.
> > >
> > > The full report of this issue can be found here:
> > > http://seclists.org/bugtraq/2016/Mar/87
> > >
> > > Reported-by: Ralf Spenneberg <ralf@spenneberg.net>
> > > Cc: stable <stable@vger.kernel.org>
> > > Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > (cherry picked from commit 4ec0ef3a82125efc36173062a50624550a900ae0)
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  drivers/usb/misc/iowarrior.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> >
> > This commit has been in the tree for a long time.  It was in the 4.4.7
> > release, back in April 2016.  And then it was reverted in commit
> > b7321e81fc36 ("USB: iowarrior: fix NULL-deref at probe") as it broke
> > systems.  So why add it back, the correct functionality should be there
> > today, right?
>
> Sorry I missed that history. The script I used to identify patches noticed
> that this patch was not applied, but I did not have a check for already-
> reverted patches.
>
> Chunyan, Baolin: it seems the spreadtrum 4.4 kernel got this wrong
> as well, by backporting the patch again on top of 4.4.172. Can you check
> the latest internal version for this?

Yes, I saw this patch in our 4.4 kernel.

Orson, we should revert this patch from our kernel as Greg mentioned.

-- 
Baolin Wang
Best Regards
