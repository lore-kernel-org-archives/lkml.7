Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDC6C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 22:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77432332B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 22:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gBZfJunh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbfHTW2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 18:28:02 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35637 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730330AbfHTW2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 18:28:02 -0400
Received: by mail-oi1-f195.google.com with SMTP id a127so126622oii.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 15:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W0w7UzUnHmk5b124mO4PsSNiLAwHeO3yLuvu+ZdadVw=;
        b=gBZfJunhL9Z7cpDZq49K8STyAy+CWT0+KXC18XUv4xsHEnCA0qYDePRiSIqQtorxcW
         ju29Bkn5vM9Qt/fMlpEEb94Dp0oTrsRGVbOf4XeK49ypVUsG/BmfTWYMqCFHbXxSmbhs
         WwanrTP5koVzovZj3xqJ6FKOxJHIWrUkODcj5xhJZgNIejzrmEDxv7z3g/kIIjoqTkvE
         pP2mJirm2G1Oo+s8++tHGyUD07SyN15BNzLHS65W4KyOyjzoKAP5IXTPf+4vCE+1YRJ0
         SDtNEAsgvOrqeepyb3zkDrzjJFvetzBTx4w/HyKw67V2gDuvj+/Ygx9cNBY2toI0QEC+
         2KSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W0w7UzUnHmk5b124mO4PsSNiLAwHeO3yLuvu+ZdadVw=;
        b=FbYngItUGOk8LQXogGe/fVXIboffeYCk4vCcmfIIg30/AXTEoX3HmN8E+shSdTqETL
         E2CUu3wbS7kbHr2EEXIr/l4GY7tuGVer1M49OiYZdVoxt+5ExnImZ+9BpaIK1GLpTEqV
         lCbFpSkc3SjBc4R49znTdmOWse0QtO23WURpo4yQP5VQGCnjF9iZ5EKT6Pyc6NlqErFt
         kdSvcpqOIZnnJoGehY10i9J2G5QHqofiYtaTnYbU6O4HFu0yV1LCVens+1HRIUa7dyjG
         GJm4IHhHwCITRIjAIWEKkrb+kzwlyhQdvEwTbClHu8vlZSi98tcbBqYNR9OU+jMaC2Yy
         bUzQ==
X-Gm-Message-State: APjAAAVYAj6gQGgzqrYqrCUZKI6Ejq5ZCDCHEZJpPEJPwLY1j5Yo4Ork
        zZdZuTlGL74yIwR/bc+aEE9CEOFjDSwyPAyI7azWaw==
X-Google-Smtp-Source: APXvYqzsfI05rWAHNaziTNmTVZjXNrbSR6J5n4T7FhWHdVSKiN5Z+moyz1H1unhmfZWj9WvaoP/4QHlm/mbpb6qXrcA=
X-Received: by 2002:aca:5106:: with SMTP id f6mr1695129oib.69.1566340080746;
 Tue, 20 Aug 2019 15:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190807223111.230846-1-saravanak@google.com> <20190807223111.230846-3-saravanak@google.com>
 <20190820061300.wa2dirylb7fztsem@vireshk-i7>
In-Reply-To: <20190820061300.wa2dirylb7fztsem@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 20 Aug 2019 15:27:24 -0700
Message-ID: <CAGETcx9BV9qj17LY30vgAaLtz+3rXt_CPpu4wB_AQCC5M7qOdA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] OPP: Add support for bandwidth OPP tables
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 11:13 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 07-08-19, 15:31, Saravana Kannan wrote:
> > Not all devices quantify their performance points in terms of frequency.
> > Devices like interconnects quantify their performance points in terms of
> > bandwidth. We need a way to represent these bandwidth levels in OPP. So,
> > add support for parsing bandwidth OPPs from DT.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/opp/of.c  | 41 ++++++++++++++++++++++++++++++++---------
> >  drivers/opp/opp.h |  4 +++-
> >  2 files changed, 35 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > index 1813f5ad5fa2..e1750033fef9 100644
> > --- a/drivers/opp/of.c
> > +++ b/drivers/opp/of.c
> > @@ -523,6 +523,35 @@ void dev_pm_opp_of_remove_table(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
> >
> > +static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np)
> > +{
> > +     int ret;
> > +     u64 rate;
> > +     u32 bw;
> > +
> > +     ret = of_property_read_u64(np, "opp-hz", &rate);
> > +     if (!ret) {
> > +             /*
> > +              * Rate is defined as an unsigned long in clk API, and so
> > +              * casting explicitly to its type. Must be fixed once rate is 64
> > +              * bit guaranteed in clk API.
> > +              */
> > +             new_opp->rate = (unsigned long)rate;
> > +             return 0;
> > +     }
> > +
>
> Please read opp-level also here and do error handling.

Can you please explain what's the reasoning? opp-level doesn't seem to
be a "key" based on looking at the code.

>
> > +     ret = of_property_read_u32(np, "opp-peak-kBps", &bw);
> > +     if (ret)
> > +             return ret;
> > +     new_opp->rate = (unsigned long) bw;
> > +
> > +     ret = of_property_read_u32(np, "opp-avg-kBps", &bw);
> > +     if (!ret)
> > +             new_opp->avg_bw = (unsigned long) bw;
>
> If none of opp-hz/level/peak-kBps are available, print error message here
> itself..

But you don't print any error for opp-level today. Seems like it's optional?

>
> > +
> > +     return 0;
>
> You are returning 0 on failure as well here.

Thanks.

> > +}
> > +
> >  /**
> >   * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
> >   * @opp_table:       OPP table
> > @@ -560,22 +589,16 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
> >       if (!new_opp)
> >               return ERR_PTR(-ENOMEM);
> >
> > -     ret = of_property_read_u64(np, "opp-hz", &rate);
> > +     ret = _read_opp_key(new_opp, np);
> >       if (ret < 0) {
> >               /* "opp-hz" is optional for devices like power domains. */
> >               if (!opp_table->is_genpd) {
> > -                     dev_err(dev, "%s: opp-hz not found\n", __func__);
> > +                     dev_err(dev, "%s: opp-hz or opp-peak-kBps not found\n",
> > +                             __func__);
> >                       goto free_opp;
> >               }
> >
> >               rate_not_available = true;
>
> Move all above as well to read_opp_key().

Ok. I didn't want to print an error at the API level and instead print
at the caller level. But if that's what you want, that's fine by me.

>
> > -     } else {
> > -             /*
> > -              * Rate is defined as an unsigned long in clk API, and so
> > -              * casting explicitly to its type. Must be fixed once rate is 64
> > -              * bit guaranteed in clk API.
> > -              */
> > -             new_opp->rate = (unsigned long)rate;
> >       }
> >
> >       of_property_read_u32(np, "opp-level", &new_opp->level);
> > diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> > index 01a500e2c40a..6bb238af9cac 100644
> > --- a/drivers/opp/opp.h
> > +++ b/drivers/opp/opp.h
> > @@ -56,7 +56,8 @@ extern struct list_head opp_tables;
> >   * @turbo:   true if turbo (boost) OPP
> >   * @suspend: true if suspend OPP
> >   * @pstate: Device's power domain's performance state.
> > - * @rate:    Frequency in hertz
> > + * @rate:    Frequency in hertz OR Peak bandwidth in kilobytes per second
> > + * @avg_bw:  Average bandwidth in kilobytes per second
>
> Please add separate entry for peak_bw here.
>
> I know you reused rate because you don't want to reimplement the helpers we
> have. Maybe we can just update them to return peak_bw when opp-hz isn't present.

How about I just rename this to "key"? That makes a lot more sense
than trying to save 3 different keys and going through them one at a
time.

> >   * @level:   Performance level
> >   * @supplies:        Power supplies voltage/current values
> >   * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
> > @@ -78,6 +79,7 @@ struct dev_pm_opp {
> >       bool suspend;
> >       unsigned int pstate;
> >       unsigned long rate;
> > +     unsigned long avg_bw;
> >       unsigned int level;
> >
> >       struct dev_pm_opp_supply *supplies;
> > --
> > 2.23.0.rc1.153.gdeed80330f-goog

-Saravana
