Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1E2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBFA20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9dpc4cz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfCKRwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:52:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43871 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbfCKRwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:52:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id d17so6144652wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 10:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5WJlj62angRrnndWKK9F/YA5IGAM8Pn/yZ5/AD45Wjw=;
        b=c9dpc4czO8ieofx6usrYRJlLoECLKpO1XVzHO9bt31bhE1twt91zg9BslQrqOD7mwW
         PdtGON1h4JTLN7LwWmklLDMbkIlcEQbqIYgfZjEbQbcQsaC6dguNrFMitOGbWACNZ0Aq
         q2Dc47mkidWlfAT8ltNggf2FH1xVP2ik0xiT9ski6SGLsHhbzFGfvUpRv7TIWqmO8ymr
         CvJwiEWDTVdxaUxGaGDcD+4eKaRWIxEQ2IOcXH41Q4N+bzY3Zu6iq/BLaj+h82KQegv9
         nByc1l2C8QBTYARDKmsSX1mZmMQqKXlzo34K6ceA1lG8L/5mLhH+tKNstl9t49+NnAbm
         C9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5WJlj62angRrnndWKK9F/YA5IGAM8Pn/yZ5/AD45Wjw=;
        b=YWclpGP5LVW/9ayrIaQRvuQ6/V4dF1WeVa0OE6aQkyoGcjuM86Sn+/rxEQGS/xsZiF
         9yqukhQXw5q5dlBRb0Rx3cBxaXpUDce+VIiMFm8p2YlehM1pNIk7bVSrY/ck0woxUKYJ
         xxosi1rrApbhLx3oBdUfm53JHrcx571DfF57Fp9opRGkWDGgF0DrtspRIvfEi7pwgyqn
         e+cEIglcbD/rxINQBoewyHu5vgPxAK/nusdaSqFOTck12gwq+tibGfgDlNRmw2eYudts
         4is++sbFjjJ12QbLSTRawzVU8H4+VtLy33A/v9a1Tx5QjORO2tURybzvI2fxpe4EN97I
         s3Kg==
X-Gm-Message-State: APjAAAU9PfOiQ0hEA2i/cwDesn7HxdHOO3godwY0Fc3DgfzwtHQ7963X
        lP4UzwBfAzEsU6gx/Guqu8/eRF4v2WbuYFe1lPo=
X-Google-Smtp-Source: APXvYqxq0TdY9neE5OEiJdnxed/ANnEdihZ7aikdtvsOMVtPAPtRU1olUlK8fb5bUj/pnSHVq6n66aZ1sUG6lcPtiXA=
X-Received: by 2002:adf:e548:: with SMTP id z8mr21670735wrm.52.1552326728235;
 Mon, 11 Mar 2019 10:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
 <CGME20190226193632epcas4p139e0002746989958fef4913a0af9fc0d@epcas4p1.samsung.com>
 <20190226193609.9862-3-andrew.smirnov@gmail.com> <bad3c902-8ead-dbe4-fa77-e365dd29e6f2@samsung.com>
 <20190304122021.GD6325@pendragon.ideasonboard.com>
In-Reply-To: <20190304122021.GD6325@pendragon.ideasonboard.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 11 Mar 2019 10:51:56 -0700
Message-ID: <CAHQ1cqFq3-A7O4ywoAfqXmLk9i9q5D6h4Y0k8XjiGNUUDMc7Qw@mail.gmail.com>
Subject: Re: [PATCH 2/9] drm/bridge: tc358767: Simplify tc_stream_clock_calc()
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 4:20 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hello,
>
> On Mon, Mar 04, 2019 at 10:42:20AM +0100, Andrzej Hajda wrote:
> > On 26.02.2019 20:36, Andrey Smirnov wrote:
> > > Drop the use of tc_write() as well as "magicly" used "ret" and "err:"
> > > and replace it with a simple call to regmap_write(). No functional
> > > change intended.
> > >
> > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > > Cc: Archit Taneja <architt@codeaurora.org>
> > > Cc: Andrzej Hajda <a.hajda@samsung.com>
> > > Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> > > Cc: Chris Healy <cphealy@gmail.com>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: linux-kernel@vger.kernel.org
> > > ---
> > >  drivers/gpu/drm/bridge/tc358767.c | 7 +------
> > >  1 file changed, 1 insertion(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> > > index b0f8264a1285..86ebd49194b7 100644
> > > --- a/drivers/gpu/drm/bridge/tc358767.c
> > > +++ b/drivers/gpu/drm/bridge/tc358767.c
> > > @@ -504,7 +504,6 @@ static int tc_pxl_pll_dis(struct tc_data *tc)
> > >
> > >  static int tc_stream_clock_calc(struct tc_data *tc)
> > >  {
> > > -   int ret;
> > >     /*
> > >      * If the Stream clock and Link Symbol clock are
> > >      * asynchronous with each other, the value of M changes over
> > > @@ -520,11 +519,7 @@ static int tc_stream_clock_calc(struct tc_data *tc)
> > >      * M/N = f_STRMCLK / f_LSCLK
> > >      *
> > >      */
> > > -   tc_write(DP0_VIDMNGEN1, 32768);
> > > -
> > > -   return 0;
> > > -err:
> > > -   return ret;
> > > +   return regmap_write(tc->regmap, DP0_VIDMNGEN1, 32768);
> >
> >
> > The patch looks semantically correct, but you are dropping here custom
> > accessor (tc_write) in favor of regmap API.
> >
> > I think the best would be consistent across the whole driver: either use
> > only  accessors, either drop them entirely and use regmap API.
>
> I agree with this. The tc_write macro with its goto err is pretty nasty,
> and I'd like to see it removed from the whole driver, or at least
> replaced with an accessor that wouldn't hide the goto.
>
> > And it would be good to have comment of the original authors about this
> > change.
> >

OK, I'll create a patch to remove tc_write/read in v2 and add original
authors to CC.

Thanks,
Andrey Smirnov
