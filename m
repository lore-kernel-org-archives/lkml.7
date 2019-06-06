Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32948C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B67820872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elYAqTKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfFFTS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:18:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39329 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbfFFTS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:18:56 -0400
Received: by mail-io1-f65.google.com with SMTP id r185so1110210iod.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 12:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k1YXtpNCDOosbHBL0TL+M3WAkRwQkUQShRW6iv3pI/E=;
        b=elYAqTKjzYWFPW2KclIE/7D7+zcK6oEV+i0XXHhZSP+U/FvV2qo6zHq3e8SpKTkBiW
         pIhAHacyghUD4KEMdqoLklkIrGkgpAj5uBTVBQWI3nthQV0FAt/Wy380lL7ZvZubJvDi
         nskJjdPKBrSBrS7G2PXp/+dxi2HhqiOISv7sGMxfmWWc3f3zic/cQOWUc1FmMkG2Va+g
         bsfB7JpSfvq8BIiF03CQddwQhGD551SvzJj8MZ499QH1qbBv/ZD4PRr4wkvcc8nkqwc1
         8CxZP880ZxXM3Bm/h4Vm7ykkkBw/5WnCzk3i65N+KGqcyOwODonNdFFP13QpnHb9+pHJ
         sWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k1YXtpNCDOosbHBL0TL+M3WAkRwQkUQShRW6iv3pI/E=;
        b=JezaVDMXB0nXkqKEq7crO7EdvVxV75jw6XHmiQoyyvePtf13v0xXN20iesAXWeJ7ct
         9yrZ/VpxQMzHsE2pnvhIj0SCJK20c4WmABP04F3AYIv0C8GNYGloKzNzxyIl5Te7zz8o
         FFiEntnW4sbHagZDe54mLjGchqVX5bw5sfFNzxgJpxvBNX7SSGMkimakCkXYW7XxQO5N
         vp8lzVJqQ0+zl2nWNmLjM09k9MNtqlm77GtMNMLIpJCc4QwHPyViXnZlaoAg+vBiIAi9
         eZNik6lWuK+JSZsBvrxd076Fg/djEdwBNnnydaRdweN5/WI1C8/QJqC5PS7P1kLahyIt
         GrKw==
X-Gm-Message-State: APjAAAX7Y+YjC5m0wJxn9SEk1Ag3F+dAS933b57kMPbyTdsM2gnfatAQ
        bsy7tlny0CAw0DOyn4L9OdVPp8i6JrW85Ujoogk=
X-Google-Smtp-Source: APXvYqylaDDGA4PraZOekHKWe7NpeljwK6OKqIM9Pmn2Ow5JNBpDQZ0QcDvmd4FBcWWrCHgBFNyVCSfHaSkhO8aIlms=
X-Received: by 2002:a6b:f607:: with SMTP id n7mr7233987ioh.263.1559848735945;
 Thu, 06 Jun 2019 12:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190605070507.11417-1-andrew.smirnov@gmail.com>
 <CGME20190605070528epcas1p1d9b1d1b09ffaafa511936ed3ded29097@epcas1p1.samsung.com>
 <20190605070507.11417-4-andrew.smirnov@gmail.com> <3c50e3e2-9fb8-6962-9988-32d14aa429b0@samsung.com>
In-Reply-To: <3c50e3e2-9fb8-6962-9988-32d14aa429b0@samsung.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 6 Jun 2019 12:18:44 -0700
Message-ID: <CAHQ1cqExJuKHcXBPszkMymzZg4r4nRKAoySPXLrCurOCoco9-g@mail.gmail.com>
Subject: Re: [PATCH v3 03/15] drm/bridge: tc358767: Simplify polling in tc_link_training()
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 1:08 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> On 05.06.2019 09:04, Andrey Smirnov wrote:
> > Replace explicit polling in tc_link_training() with equivalent call to
> > tc_poll_timeout() for simplicity. No functional change intended (not
> > including slightly altered debug output).
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Archit Taneja <architt@codeaurora.org>
> > Cc: Andrzej Hajda <a.hajda@samsung.com>
> > Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Cory Tusar <cory.tusar@zii.aero>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/gpu/drm/bridge/tc358767.c | 15 ++++++---------
> >  1 file changed, 6 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> > index 5e1e73a91696..115cffc55a96 100644
> > --- a/drivers/gpu/drm/bridge/tc358767.c
> > +++ b/drivers/gpu/drm/bridge/tc358767.c
> > @@ -748,22 +748,19 @@ static int tc_set_video_mode(struct tc_data *tc,
> >
> >  static int tc_wait_link_training(struct tc_data *tc)
> >  {
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
> > +     if (ret) {
> >               dev_err(tc->dev, "Link training timeout waiting for LT_LOOPDONE!\n");
> > -             return -ETIMEDOUT;
> > +             return ret;
> >       }
>
>
> Inconsistent coding, in previous patch you check (ret == -ETIMEDOUT) but
> not here. To simplify the code you can assume that tc_poll_timeout < 0,
> means timeout, in such case please adjust previous patch.
>

Sure, will do.

Thanks,
Andrey Smirnov
