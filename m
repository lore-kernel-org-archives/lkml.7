Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F24AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3BD21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gV2H0hK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfCOQOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:14:47 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:21222 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfCOQOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:14:46 -0400
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x2FGEVjw009417;
        Sat, 16 Mar 2019 01:14:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x2FGEVjw009417
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552666472;
        bh=lS3uNHzFMk91s+9sZ+0u7Ve+F3hHsuEVIbpCZU+hlLU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gV2H0hK0i360IvlSgmXHJXZYjimeX11C5PzxVU83ztSzFD7Cp6JULwu7LAD53Ra2L
         oPi66viGs+NNk8mP1ViAZIUJwYHTgN+0TkWrda9TFU6diSAx/EMvqWGLvF4ZPNpiHc
         ZpatB0lned0z0H7a3BOcW6LQUCi3jzSM1Qp/xFIBlJhSexHhhSQM/WnY7vveP/JN2p
         OGuQ8Pys9iLwZOrFLa72pgnha6v1VE3zd0th34JvogeJCPvBur/YmXLXgfcanHP2Tp
         hUbdTnbCDXFBtah/4BCl369O2D9GLUyRhZqPtHjduTzv5Z0xufLRKi/Rv3tGDehKFY
         b/EhsV5LbOgaA==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id b8so1638264uaq.7;
        Fri, 15 Mar 2019 09:14:32 -0700 (PDT)
X-Gm-Message-State: APjAAAVLnCsu8ecQ5SFiPZofMrTw9DJaAuGzjPbrByOxDh+8tjzvmooJ
        18RBn3ZtNIDz8y+3HpOOAHTsifd9PKBaF5KI5Mc=
X-Google-Smtp-Source: APXvYqwY9hzON0yx6fx3LGi6T+XYo3dnwkhQNYIqa6JXJMSKpAk6eyyH96lJLYnsSim0Z9NXa42OJEV6gTB9SI6WFL4=
X-Received: by 2002:ab0:2b16:: with SMTP id e22mr89399uar.113.1552666471061;
 Fri, 15 Mar 2019 09:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190314175705.11671-1-dianders@chromium.org> <CAK7LNATvfVD8RfZN37fXGKJeEuawM_7BuVrJ4xw1pZmuz5f_aw@mail.gmail.com>
 <CAD=FV=V=s8e12W7XiMGxwzi9gqkvAqRfKqYBv_ePhh4y77ZkUQ@mail.gmail.com>
In-Reply-To: <CAD=FV=V=s8e12W7XiMGxwzi9gqkvAqRfKqYBv_ePhh4y77ZkUQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 16 Mar 2019 01:13:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNASde0Q9S5GKeQiWhArfER4S4wL1=R_FW8q0++_X3T5=hQ@mail.gmail.com>
Message-ID: <CAK7LNASde0Q9S5GKeQiWhArfER4S4wL1=R_FW8q0++_X3T5=hQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: If the module stripping command fails the build
 should abort
To:     Doug Anderson <dianders@chromium.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


On Sat, Mar 16, 2019 at 12:19 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Mar 15, 2019 at 7:11 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > On Fri, Mar 15, 2019 at 2:59 AM Douglas Anderson <dianders@chromium.org> wrote:
> > >
> > > If the call to strip returns an error code then it makes sense for the
> > > build to fail.  Currently we'll just chug along and ship unstripped
> > > modules.
> > >
> > > Fixes: e2a666d52b48 ("kbuild: sign the modules at install time")
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> >
> > Did you see this problem in the latest kernel?
> >
> > Since commit q,
> > $(call cmd,...) is run with 'set -e'.
> >
> > Any failure in a series of commands will let the build fail.
> >
> >
> > If you have the problem in old versions ( < 4.20),
>
> Ah!  I was in 4.19 when I saw the problem.  I then confirmed that the
> code in mainline was the same and that the new version built fine with
> my patch, but I didn't go back and confirm the problem there.
>
> OK, I just checked linux/master and can confirm there's no problem
> there.  Sorry for the noise then...
>
> I wonder if perhaps we should revert commit caf6fe91ddf6 ("modsign:
> Abort modules_install when signing fails") then to be consistent?


Right.

If you send a patch, I will take it.




> > I do not mind this patch for linux-stable.
>
> It's probably not worth it.  In general I prefer linux-stable to be as
> just cherry-picks of mainline as much as possible.  When it starts
> forking then future picks get harder.  Sure in this case it's unlikely
> that someone will get tripped up by an "&&" vs a ";" when picking
> future changes, but given that it's not super urgent I guess I'd vote
> that we skip it.


Agree.




-- 
Best Regards
Masahiro Yamada
