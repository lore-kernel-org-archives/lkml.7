Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273C1C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C282084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556272701;
	bh=R7WPbdQ+/Wvrbcvvu7v/nltqqTfTDu4jGYBWUskiL+A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=plUQ5gd18ZijwcjkU5aRQuzaD0qtaPK35AqTgOZ4sqLoad8QCsXWk4h6o9zyC9ANc
	 Q3QaCbJz6+GtlcnlbhrF7/NZi8Cq8LWfolwkqON6QgG+/kvOb8s0cpPXhSgNqrrgnn
	 Ao2hKHgfsSr3vNIxl+6pMXQ34RhNVprOoymLQhtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfDZJ6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfDZJ6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:58:10 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87DAD2089E;
        Fri, 26 Apr 2019 09:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556272689;
        bh=R7WPbdQ+/Wvrbcvvu7v/nltqqTfTDu4jGYBWUskiL+A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PAnUmEv18l8c6IA6BGSpKR6FQbP/UqGpgcJsSZM6Z+TQoznRzTkZkK9oCUVf1nL/g
         o4IBBGJpJ5r3hD+8zyTvCz7d5PEToTfUuCt4TlAcXKGAyI4pvPNjtZbDJpvx7k16xc
         2sy9nj9lm5tkwqO9u2Vk51H9EBslyVTWAV+dhCjg=
Received: by mail-lj1-f182.google.com with SMTP id k8so2357337lja.8;
        Fri, 26 Apr 2019 02:58:09 -0700 (PDT)
X-Gm-Message-State: APjAAAWzO2z2EyeHxdvgld2r6R3DGJPrXhPrCpU9DgdzFyXdRFFylXcX
        Q6N+xI92Mi8p7xsc76RS2b+unB32Q4PaVpEJYJI=
X-Google-Smtp-Source: APXvYqwADgm7W5o9fjcYm+QQGX1McsZ2QxVQupTUPIAg6yIsx4746GQcC4bAahhuuVRZ9ezM519RYxR1+aN9B+r0rzQ=
X-Received: by 2002:a2e:9ec3:: with SMTP id h3mr24387182ljk.131.1556272687780;
 Fri, 26 Apr 2019 02:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <1556270808-21331-1-git-send-email-krzk@kernel.org> <20190426093243.zazld4wwv4qybwaf@pali>
In-Reply-To: <20190426093243.zazld4wwv4qybwaf@pali>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 26 Apr 2019 11:57:56 +0200
X-Gmail-Original-Message-ID: <CAJKOXPedb=TX=4ZDW4SARPBb5_K_zMFVBA3wJCYTieTuxk+9xg@mail.gmail.com>
Message-ID: <CAJKOXPedb=TX=4ZDW4SARPBb5_K_zMFVBA3wJCYTieTuxk+9xg@mail.gmail.com>
Subject: Re: [PATCH] power: supply: bq27xxx_battery: Notify also about status changes
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019 at 11:32, Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote:
>
> On Friday 26 April 2019 11:26:48 Krzysztof Kozlowski wrote:
> > User-space might be interested in receiving uevents when the charging
> > starts/stops or if conditions of battery changes (e.g.
> > over-temperature).  Notify about changes in battery also when the flags
> > change, not only SoC.
>
> This looks like a good idea.
>
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  drivers/power/supply/bq27xxx_battery.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/sup=
ply/bq27xxx_battery.c
> > index 29b3a4056865..cb9306160c14 100644
> > --- a/drivers/power/supply/bq27xxx_battery.c
> > +++ b/drivers/power/supply/bq27xxx_battery.c
> > @@ -1612,7 +1612,8 @@ void bq27xxx_battery_update(struct bq27xxx_device=
_info *di)
> >                       di->charge_design_full =3D bq27xxx_battery_read_d=
cap(di);
> >       }
> >
> > -     if (di->cache.capacity !=3D cache.capacity)
> > +     if ((di->cache.capacity !=3D cache.capacity) || \
>                                                       ^^
>                                       You have there an extra backslash

Indeed, Thanks! Let me send v2.

Best regards,
Krzysztof
