Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDC9C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0F5206DB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vc5HOWdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbfLEQGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:06:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34867 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLEQGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 11:06:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id c20so2820043wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 08:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/s4H9123KM6cSQFYZYktesHNajGVy0K2OAZRf2rsEsA=;
        b=vc5HOWdrtJsCRrlTj+6bmgg9NGsYEUOJXVu2XK2vRzyVNMcyny5cQqCH/W7oG2r7OG
         B9VB0Jmj+VzXhvz9VhxLlRoOruinbQdlKhKUotk9hisTrs35KHHNkXRzn1ZrzoxTHsvr
         QLCep6vrizqHh7BM7rR3/+qL1UJFhTUwv2Q8Xmz9d4KmRgrQ2z5cXoy9cMyR8UwzGL9Y
         h+umO2o/9GoRtkZ/IeCTLBL+BaTaSZEnpi0OiVLyvH0j+ULA1YeR6OlfiNg5BUA07HUj
         eLqqIIj1xTYo8GKEYGnkSBBRF5Ht1Be3UG/1rmA8XwvA0zQVBc/KQLy8mxeQ+ka2IM/R
         9fJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/s4H9123KM6cSQFYZYktesHNajGVy0K2OAZRf2rsEsA=;
        b=SNAX7vblW4KeF64a451rEpMfwi3vsLKjjHljQR31uj5UAiY9CKeA7riQOH5vM5qmQJ
         GhpdCZB45IfJ0JGHXOdqorbRRnj2wArT03fftQgPxUyeIAr0zv0nAK3u/FCFUvvaK9kp
         y3sbFSC4kGlhHe+XPBDVveSeSEAJLyWl/VcH31KwE0Kwulf0HgCxJ2FnnmvA0f2Zx9sa
         kzECwPM/K8Fx+aQnAHwpuVHDbK5pIgPcJOkTf3xYs+XQBxST5HlDChVCnwMeGUwkRFVr
         iY4DMwAxCBOwLOKts6Av415KYs3+vjcTQct0RUKWRJ9lxTB0iH6Da0W3AOZIIrKz5KDv
         gGgg==
X-Gm-Message-State: APjAAAVsr7zl+gyhoEyTU9yHSzmZOabPxGDL/MZfRDfuG8kvM6ZerTy7
        RBT8o4QOZRXbeEtNWSHp0Up+r/gqS/I2YK6Psh4=
X-Google-Smtp-Source: APXvYqwUaK6wevcF0G2jdgwbeylML3gO2zdknStkUF6zUyLRs8IjpTsXaAyF4wK7eINtAv+qQSOlb4+QXItUzBdKIbw=
X-Received: by 2002:a05:600c:149:: with SMTP id w9mr5872302wmm.132.1575561972305;
 Thu, 05 Dec 2019 08:06:12 -0800 (PST)
MIME-Version: 1.0
References: <20190619052716.16831-1-andrew.smirnov@gmail.com>
 <20190619052716.16831-4-andrew.smirnov@gmail.com> <0d84fa72-bc96-9b88-cd89-c04327109e0e@ti.com>
In-Reply-To: <0d84fa72-bc96-9b88-cd89-c04327109e0e@ti.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 5 Dec 2019 08:06:00 -0800
Message-ID: <CAHQ1cqFK8nd4hs031_2=dk2WBVmP=es1CEadApwJ9MkzCGiQjw@mail.gmail.com>
Subject: Re: [PATCH v6 03/15] drm/bridge: tc358767: Simplify polling in tc_link_training()
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jyri Sarha <jsarha@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 10:27 AM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
> Hi Andrey,
>
> On 19/06/2019 08:27, Andrey Smirnov wrote:
>
> > @@ -748,22 +748,19 @@ static int tc_set_video_mode(struct tc_data *tc,
> >
> >   static int tc_wait_link_training(struct tc_data *tc)
> >   {
> > -     u32 timeout = 1000;
> >       u32 value;
> >       int ret;
> >
> > -     do {
> > -             udelay(1);
> > -             tc_read(DP0_LTSTAT, &value);
> > -     } while ((!(value & LT_LOOPDONE)) && (--timeout));
> > -
> > -     if (timeout == 0) {
> > +     ret = tc_poll_timeout(tc, DP0_LTSTAT, LT_LOOPDONE,
> > +                           LT_LOOPDONE, 1, 1000);
>
> This seems to break DP at least with some monitors for me. I think it's just a timeout problem, as
> increasing the values helps.
>
> Using ktime, I can see that during link training, the first call takes ~2ms, the second ~7ms. I
> think this worked before, as udelay(1) takes much longer than 1 us.
>
> We have 1000us limit in a few other places too, which I don't see causing issues, but might need
> increasing too.
>
> Also, 1us sleep_us may be a bit too small to be sane. If the loops take milliseconds, probably 100us
> or even more would make sense.
>
> This didn't cause any issues with your display?
>

Hmm, not that I know of. Your reasoning makes sense, though. If
increasing the timeout helps, I am all for it. And, yeah, I agree,
this is probably not the only place that could use an increased
timeout.

Thanks,
Andrey Smirnov
