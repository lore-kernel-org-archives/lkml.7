Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CC5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4027A21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kg+tc6v3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbfCOQMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:12:14 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40540 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729538AbfCOQMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:12:12 -0400
Received: by mail-ua1-f65.google.com with SMTP id b8so1635578uaq.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 09:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7NigTPkmaWts9cCMXyGy6v7s7PJuugA1HlcJvEqE3Ys=;
        b=Kg+tc6v3IXOVM+GTv5rKz0SM28oJWNCpfeQAjaQr5GbxaYTslI0C2fe4Mqk4Fj2sLb
         OZXVq/mNzL+5q6gp2rzs9A58B7rcOyOaCdVLq+btOH7ZweCv6MK8RhCvLfFDR6VoiyMI
         VhWGDOlC+ZYtqvTyk1+lPAz43+byamHNeTZIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7NigTPkmaWts9cCMXyGy6v7s7PJuugA1HlcJvEqE3Ys=;
        b=dF6uFr/6AitmPU35ObniDpaFKlhv7+H+UaVX9A1YQEE7DQw9a7PQ35CyPHxcMj1tNO
         GeGfAM/USJYhSOE8mCy2mJGLNBJCF0N/ii4YOsVvk7Wyfm1wXDiBY1EqaY7cee1C92El
         hvh7tt1DPyUin6rVnNKVyJWWybbPV3A0iidKOAbzF648nNMAJCKyXd/ne50GyqTG415G
         sNYvg4OPT5evobu3rCgTwKAZOmHGlNBEV+mH8todLN+yhu6InTVVxjXy9RWtW5jtYw/5
         zAe9g19mD1xPvUn3cNcg5VvvolDL7D3LIOhaW1ipM7j49TJWCammVc/ihP5+aj+VbN25
         epgw==
X-Gm-Message-State: APjAAAXmUInJIhpSOaThPUuQ3hSDlnNDjyx1GDraQwsPKvz3uvKeeDD6
        qMciQhWGAr5wLRoASYzVAXE68rhIHBg=
X-Google-Smtp-Source: APXvYqzPUbkx8cD9NPWEZQDNvOKaS7kdeGmg7j/BzOHJq9csLHyVfwTPjcWvWtMHrYQLQqtDstpj2Q==
X-Received: by 2002:ab0:6787:: with SMTP id v7mr122791uar.38.1552666331664;
        Fri, 15 Mar 2019 09:12:11 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id c129sm1472419vka.6.2019.03.15.09.12.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 09:12:11 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id z6so5722636vsc.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 09:12:10 -0700 (PDT)
X-Received: by 2002:a67:b60c:: with SMTP id d12mr1229147vsm.149.1552666330617;
 Fri, 15 Mar 2019 09:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190314234159.191745-1-dianders@chromium.org>
 <CAK7LNATa+TnXb+a6on-sx2mjNoAiORe-WeZ8UusETHdSrXowuw@mail.gmail.com>
 <CAK7LNAT=04WAMEfN7u5N_oO2RwT9bYALMN3SZ3WFQo-=3vEjsQ@mail.gmail.com>
 <CAD=FV=XqH7knZwK+a+bsACwc-j2NgH914mLTc_POR_GAipVf7w@mail.gmail.com> <CAK7LNAQff3c9zUMSyj37WT_hgPQ9x7Vf-Hxnm_u0LxNwEMJ+7w@mail.gmail.com>
In-Reply-To: <CAK7LNAQff3c9zUMSyj37WT_hgPQ9x7Vf-Hxnm_u0LxNwEMJ+7w@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 Mar 2019 09:11:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XJycpKS1M8Z9Ks=nrE-=yJemSALWsahzKJNuzyRJQKww@mail.gmail.com>
Message-ID: <CAD=FV=XJycpKS1M8Z9Ks=nrE-=yJemSALWsahzKJNuzyRJQKww@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Make NOSTDINC_FLAGS a simply expanded variable
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 15, 2019 at 9:09 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi,
>
> On Sat, Mar 16, 2019 at 12:41 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Fri, Mar 15, 2019 at 8:37 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > >
> > > On Sat, Mar 16, 2019 at 12:27 AM Masahiro Yamada
> > > <yamada.masahiro@socionext.com> wrote:
> > > >
> > > > On Fri, Mar 15, 2019 at 8:42 AM Douglas Anderson <dianders@chromium.org> wrote:
> > > > >
> > > > > During a simple no-op (nothing changed) build I saw 39 invocations of
> > > > > the C compiler with the argument "-print-file-name=include".  We don't
> > > > > need to call the C compiler 39 times for this--one time will suffice.
> > > > >
> > > > > Let's change NOSTDINC_FLAGS to a simply expanded variable to avoid
> > > > > this since there doesn't appear to be any reason it should be
> > > > > recursively expanded.
> > > > >
> > > > > On my build this shaved ~400 ms off my "no-op" build.
> > > > >
> > > > > Note that the recursive expansion seems to date back to the (really
> > > > > old) commit e8f5bdb02ce0 ("[PATCH] Makefile include path ordering").
> > > > > It's a little unclear to me if the point of that patch was to switch
> > > > > the variable to be recursively expanded (which it did) or to avoid
> > > > > directly assigning to NOSTDINC_FLAGS (AKA to switch to +=) because
> > > > > someone else (out of tree?) was setting it.  I presume later since if
> > > > > the only goal was to switch to recursive expansion the patch would
> > > > > have just removed the ":".
> > > > >
> > > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > >
> > > > Applied to linux-kbuild.
> > > > Thanks.
> > >
> > >
> > > BTW, I noticed no one else
> > > appends NOSTDINC_FLAGS.
> > >
> > >
> > > So, does it make more sense to do as follows?
> > >
> > >
> > > NOSTDINC_FLAGS := -nostdinc -isystem $(shell $(CC) -print-file-name=include)
> >
> > It might.  ...but go back to look at commit e8f5bdb02ce0 ("[PATCH]
> > Makefile include path ordering").  Why did they do a += there since
> > even then nobody was setting it.  Try:
> >
> > $ git grep NOSTDINC_FLAGS e8f5bdb02ce0~
> >
> >
> > Do you understand what was going on in that commit?
>
>
> No, I do not understand.
>
> Maybe, it fixed a problem in downstream code
> since there was no directory like include/asm-xen.
>
>
> If you do not want to take risk,
> I am fine with this patch, though.

OK, let's keep the patch I posted then.  Thanks!

-Doug
