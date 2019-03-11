Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B592C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6140C20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3o981yR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfCKS0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:26:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39134 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfCKS0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:26:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id t124so118330wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 11:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7CPSEe7aSVAQIPM7Ck55H1c557lLNPU0/InxpZhrbR8=;
        b=V3o981yRhlkGcB6H4L19WwSQEItKytJUEXmIHsAWU4tSywJL/QbWuUtsCvg3wm8Svx
         YmH2Pj1nI+f2cUZwpRhgKAJnEDKh5ML8VLi8x1O86R3C5WwG0DlxsgpYrCTIqTk24kye
         BgmFaBIUWrNba4YhNVsowZ+RE8mp0gss46bVMny4kXSaKw4nGRUN7ov+QLlSILsGc1gY
         uuQaUrO8vPr/jUqCR/XaKP+ZABaRZbZ7846G6ETtXGZghwjsBo3PVmxAtni5PXvfLQM8
         H2cu1kFNRa00qKCpJHT/+WLpmIIOBS0zAVWa91DlJBo+BbqwNfkoMVlKth6P0rW5WVmd
         epaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7CPSEe7aSVAQIPM7Ck55H1c557lLNPU0/InxpZhrbR8=;
        b=ja4jiAxXFQZzoqT4jKfjK6JDgNJPf/bePe3ClXmP61SBdpV29AzlmTiIyfiMNM4840
         BxAEjDSC/H/D+nTpEjMwmx5Go1+QuHt3mSWJyyzCumyNI6zzSV1dryAIBknDKVT22TLQ
         EaxZbxoCQreFUq3VKsZ9vffP1fw5y/gI9bb6oMa4evUzTEHAy7LytPudTCmttwO2PkmU
         5Ekosbks8E8hYykh7GTp2UilvXNUOH0KkqjOUXETKDj6tioxe64EffJPwBENdy1y8w9p
         eieAJXGS57uHuvuG3zjS+RFiWhlJaIlJTB4LPgwsAuhJ8Cs129Ie57W3YL8t62nqS/As
         3NJg==
X-Gm-Message-State: APjAAAVE8MN4zesHO2f8UWUKMypoGXDhepFaCZjA/s8FlXXl/yjicB+y
        qMOSw3N11rCZI/hl3ZRAzlI8o2r3pPJC6I8eLCE=
X-Google-Smtp-Source: APXvYqwjKJBIpkaVC5eaQ8Ko7Gba+/exGrhT08T5T7ImweTu4Eltf7tuidp0EDWcUBDChQOjEzJGNyMvm2G67TSm994=
X-Received: by 2002:a1c:1a08:: with SMTP id a8mr10378wma.37.1552328791247;
 Mon, 11 Mar 2019 11:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
 <20190226193609.9862-6-andrew.smirnov@gmail.com> <20190304123052.GG6325@pendragon.ideasonboard.com>
In-Reply-To: <20190304123052.GG6325@pendragon.ideasonboard.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 11 Mar 2019 11:26:20 -0700
Message-ID: <CAHQ1cqG-5nPPmM307qE_nv5uwgx-99-ziCRQR=buxdfbWsH9hw@mail.gmail.com>
Subject: Re: [PATCH 5/9] drm/bridge: tc358767: Simplify polling in tc_link_training()
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 4:30 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Andrey,
>
> Thank you for the patch.
>
> On Tue, Feb 26, 2019 at 11:36:05AM -0800, Andrey Smirnov wrote:
> > Replace explicit polling in tc_link_training() with equivalent call to
> > regmap_read_poll_timeout() for simplicity. No functional change
> > intended (not including slightly altered debug output).
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Archit Taneja <architt@codeaurora.org>
> > Cc: Andrzej Hajda <a.hajda@samsung.com>
> > Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/gpu/drm/bridge/tc358767.c | 14 +++++---------
> >  1 file changed, 5 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> > index 6455e6484722..ea30cec4a0c3 100644
> > --- a/drivers/gpu/drm/bridge/tc358767.c
> > +++ b/drivers/gpu/drm/bridge/tc358767.c
> > @@ -735,7 +735,6 @@ static int tc_link_training(struct tc_data *tc, int pattern)
> >       const char * const *errors;
> >       u32 srcctrl = tc_srcctrl(tc) | DP0_SRCCTRL_SCRMBLDIS |
> >                     DP0_SRCCTRL_AUTOCORRECT;
> > -     int timeout;
> >       int retry;
> >       u32 value;
> >       int ret;
> > @@ -765,20 +764,17 @@ static int tc_link_training(struct tc_data *tc, int pattern)
> >               tc_write(DP0CTL, DP_EN);
> >
> >               /* wait */
> > -             timeout = 1000;
> > -             do {
> > -                     tc_read(DP0_LTSTAT, &value);
> > -                     udelay(1);
> > -             } while ((!(value & LT_LOOPDONE)) && (--timeout));
> > -             if (timeout == 0) {
> > +             ret = regmap_read_poll_timeout(tc->regmap, DP0_LTSTAT, value,
> > +                                            value & LT_LOOPDONE, 1, 1000);
> > +             if (ret) {
> >                       dev_err(tc->dev, "Link training timeout!\n");
> >               } else {
> >                       int pattern = (value >> 11) & 0x3;
> >                       int error = (value >> 8) & 0x7;
> >
> >                       dev_dbg(tc->dev,
> > -                             "Link training phase %d done after %d uS: %s\n",
> > -                             pattern, 1000 - timeout, errors[error]);
> > +                             "Link training phase %d done: %s\n",
> > +                             pattern, errors[error]);
>
> It's probably not a big deal in this specific case, but in general it
> can be useful to know how long the poll took.

I don't disagree, but bear in mind that the way time is measured in
original loop assumes that tc_read, an I2C transaction over 100KHz
bus, takes insignificant amount of time compared to 1 uS delay. I
think original debug statement does a bit of a false advertising when
it presents a number of polling loop iterations as if it is time it
took to establish a link in microseconds.

> Any hope to enhance regmap_read_poll_timeout() to return either the elapsed time or the
> remaining timeout instead of 0 on success ?
>

I'd rather not go there. That'll take convincing Mark Brown to accept
that semantics change, then fixing all of the callers across the tree
via a separate patch series.

What if instead we just add an extra debug statement before link
training starts, so that duration of the process can be discerned from
logging timestamps? This does require user doing a bit of math by
hand, but it's actually more accurate timing info compared to original
and it doesn't require any API modification.

Thanks,
Andrey Smirnov
