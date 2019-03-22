Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5DDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A625321900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mu9ZwL/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfCVTZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:25:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53464 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfCVTZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:25:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so3233986wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 12:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Qjv601xqfVs/anB+9Xc4DVxOhxdW+n1JoKQ3jie1Gg=;
        b=Mu9ZwL/RKkVabqf34ZKWmyj4IrfTZIEls1t10Rx0AaoKbhTUdw6pwnGe0aAsHFaqdV
         p3EKdHzr00ZsIWPEjPltGB+t2dUcbux6P9ylvK3D61z4R0N+CZhkluSilEzPyZCwHN8G
         fjdmFvebMxO/b2CH5oNTXLiz5OEN2O061wJ5xxWVkym0quVS23b00XnQOJ8gk4Xaz9bI
         iLjXiBZGqT+HVyg3BTGQAKgw03E9KklMiN3cvJjC+dbTVL66DULTEKUrW7He3vIIXWWW
         kEl8ZxiGG4IL99+ojlyI957coc3/88axZqwDJEE3jJz9SMOqGe+X4oQvBfW0o1JyunZj
         +lvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Qjv601xqfVs/anB+9Xc4DVxOhxdW+n1JoKQ3jie1Gg=;
        b=h7xByUjGD018a5NerXfSxfk75TBHTefb+NPliotvQQImPpSslgK7YywCFVZ10Dm8sf
         3tYn6mvtueqeCIl87D1pj3r4aIivDKsiq6tBrc1CX860tzG4ymdB1SBPvcxF2almCohK
         P2GkoorivZGx1CGT3wguD8fFKHSgxcS+vWW7lfUYktsXuZUH2WusR7Ph99S+t+KO3qBb
         zc2B+lGUavGvTj8WaYlQ49gSWWIJ/Qr+8RRINzONhZ+lLLIlIlMEOSw+tj9FvG0VH2rY
         CHO4qhfY7KlHl669YApgiurM5nPsfGbvytWAYOdu1HIty9efO6QmRE7//ZFApoGxMZpE
         ydrg==
X-Gm-Message-State: APjAAAWeLFi5MPOixwLh6JWAtcqPJds8duFgk6vQiqXJTkzrH/Nfr8W2
        elJvmr2QK1oNHvC5L22NYjyQGs8LG1NEsQT42Fk=
X-Google-Smtp-Source: APXvYqwzUvBwamholWMq0yiK6OPk3LBOBqgc5Rhssj8PBC6SjAqUoAMMqfPI6F4UWuNfRpbPJ5aePaqhIgHRw4Ldnl8=
X-Received: by 2002:a1c:f10f:: with SMTP id p15mr4107138wmh.27.1553282715635;
 Fri, 22 Mar 2019 12:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190322032901.12045-1-andrew.smirnov@gmail.com> <13bb7213-54bd-b38b-57ad-c8adc7950200@ti.com>
In-Reply-To: <13bb7213-54bd-b38b-57ad-c8adc7950200@ti.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 22 Mar 2019 12:25:04 -0700
Message-ID: <CAHQ1cqF6SX-cQ=gdv4xkyx4weJ6NDbzbNwy=Qk72MSG2HrJ_AA@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] tc358767 driver improvements
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 1:06 AM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
> Hi,
>
> On 22/03/2019 05:28, Andrey Smirnov wrote:
> > Everyone:
> >
> > This series contains various improvements (at least in my mind) and
> > fixes that I made to tc358767 while working with the code of the
> > driver. Hopefuly each patch is self explanatory.
> >
> > Feedback is welcome!

Ugh, I just realized that I messed up CC list of "drm/bridge:
tc358767: Simplify AUX data read" and it only went to dri-devel. Will
fix in next version.

>
> Ah, I hadn't realized there was another series for tc358767 going
> around. I should've checked dri-devel list. Sorry about that!
>

No worries, lucky for me Lucas Stach noticed your series and pointed
me to it, so it all worked out in the end.

> I'm not able to apply your patches, it fails at "Simplify
> tc_set_video_mode()", even if I think I've got the exact same base as
> you have.
>
> Can you push your branch somewhere?

Sure, it should be available here:
https://github.com/ndreys/linux/commits/rdu1-rdu2 Please ignore
"drm/bridge: tc358767: Add code to control VDCC rail", sitting on top.
I need it on my board, but it's currently purely experimental and not
meant to be upstreamed yet (or maybe ever)

Thanks,
Andrey Smirnov
