Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D533CC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 05:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77C72087E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 05:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ubYm8RR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfHRFrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 01:47:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46952 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfHRFrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 01:47:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so5347958wru.13
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 22:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=47N6p8ewhRYWGQW91JnAoiOPqrVveWjmELOO6gChjRg=;
        b=ubYm8RR1SF+vF2IDo8InoxG2GymC8UKdnTR/E3SnOZXyzpSDG8yeL4kcktvfNHo2RN
         2+tnzqrXe3E9yvYk1PTo6Kitv86fL3Ufbuz+uJY5bmejmUG1d6/y4untXoI074mS2kKF
         fM8mJdfJW0To3J+OZ1n7HhKIl167reS57IrX1gLV/+sQ7po+QGnvO0fKwf/RbvoAsxyU
         TZxgJHUp0TBu58vsmABJCbS2SG3MViPApZOFn2daEmkH1cPUkagrSreOt/2shKZxHrCq
         LG8MAylKl58PCaEztoUPZSsU9M1uX8/CY8unYj2p1M970N+kh10GYwR0hpl9eqnKoQkz
         oRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=47N6p8ewhRYWGQW91JnAoiOPqrVveWjmELOO6gChjRg=;
        b=aUx7AQHjwiwuFT8lWkBxSnhWEyVr2/RtA3/MtBFKukUvr8EAwf0oC0I8SjFdA9PJ57
         78j085VIjYeKer130eBWeRmKNjoNPavuyvSt8nO5bmmZrbwwsZ29wbvLCalvJWz9CSEn
         Uyvh6XH3AiJKQBeO3KfTcKUs5kK2ZptIYiDpfjjoxBjrpP/Cqf/z4Dvkm0nWe5+4cTkk
         w6kxp+fJ80evCB2CpYr4WKPNsNCdnl3gXCRhUt4Er4IATNYw+BYp42+9kUYCZ+v5Asya
         3yUEmmhQkh9Ua6hJ3l1kegdvHVXq84tMRwN0PKG8tv6DYoxh7KzQL6ZtfG0Vwyc+oDYS
         crmQ==
X-Gm-Message-State: APjAAAUFtmYE5QIZg5L+cgVA1bETJ5O0sq7NgqatgJaVL1KovVrpYwmy
        73Q78Ctx3Rh7H9tWQsYmhpimyCo3DGh1FsSHxFM=
X-Google-Smtp-Source: APXvYqzkeMFUgv/IqcD5ibqLV+bqm5r5ug3eV8xRb+0IXBkIdlknz/8e31uo35M2fzyBnwgTwYgMJFatnuB7akH8Eo8=
X-Received: by 2002:adf:aa8d:: with SMTP id h13mr20358914wrc.307.1566107271462;
 Sat, 17 Aug 2019 22:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190817213758.5868-1-donald.yandt@gmail.com> <20190818050317.GA8147@kroah.com>
In-Reply-To: <20190818050317.GA8147@kroah.com>
From:   Donald Yandt <donald.yandt@gmail.com>
Date:   Sun, 18 Aug 2019 01:47:38 -0400
Message-ID: <CADm=fgmb-JN-t-VxFSfWw_UzvxO__P6NkNh+U3XhR6+NRtK9yw@mail.gmail.com>
Subject: Re: [PATCH] staging: android: Remove ion device tree bindings from
 the TODO
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, tkjos@android.com,
        linux-kernel@vger.kernel.org, arve@android.com,
        joel@joelfernandes.org, maco@android.com, christian@brauner.io
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 1:03 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Aug 17, 2019 at 05:37:58PM -0400, Donald Yandt wrote:
> > This patch removes the todo for the ion chunk and
> > carveout device tree bindings.
> >
> > Signed-off-by: Donald Yandt <donald.yandt@gmail.com>
> > ---
> >  drivers/staging/android/TODO | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/staging/android/TODO b/drivers/staging/android/TODO
> > index fbf015cc6..767dd98fd 100644
> > --- a/drivers/staging/android/TODO
> > +++ b/drivers/staging/android/TODO
> > @@ -6,8 +6,6 @@ TODO:
> >
> >
> >  ion/
> > - - Add dt-bindings for remaining heaps (chunk and carveout heaps). This would
> > -   involve putting appropriate bindings in a memory node for Ion to find.
> >   - Split /dev/ion up into multiple nodes (e.g. /dev/ion/heap0)
> >   - Better test framework (integration with VGEM was suggested)
> >
>
> This is already done?  Do you have a pointer to the git commit id(s)
> that did it?
>
> thanks,
>
> greg k-h

Hi Greg,

Both the chunk and carveout heaps were removed from ion,
so unless I'm mistaken there's no need to implement the device tree
bindings for them.

Commits that removed both heaps:
  - 23a4388f2 staging: android: ion: Remove file ion_chunk_heap.c
  - eadbf7a34 staging: android: ion: Remove file ion_carveout_heap.c

thanks,

Donald
