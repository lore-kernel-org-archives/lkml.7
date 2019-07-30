Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D138C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 23:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1A6204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 23:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uM+oBlrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfG3XVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 19:21:37 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33715 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfG3XVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 19:21:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id q20so68092251otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 16:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t68EXPEyPb2/r7j8LTsJ+u3l3tFbqRdeyuThoSQX0Z8=;
        b=uM+oBlrX9psFtPZuEZkbi0e4Vpn7VCy/YMTrHPulqmY/1qWEEVwhjuNGmHxf0E+HQb
         rrVW1W3yK4x96wQG6KFPEOMXHduMyfhAQI8JN0qpPDLRkrcCCIgVXsBuzLc5TUcz+K3T
         Xytm0P1ezA9fyvj74lY/B/scgzyuVwmiZgx6NTTkVY5m3nd5O9As83CCE5rfnmLc8C4D
         4fjPHIMupHeP0Dj5o3dD+/fXTIW3YSjXyaZYfi9rhJNLh6j1deJZ7RO0iWXIII1Mx7nE
         VhZwiJeSFCWbeKH88s58QktIT6+OC4rNZm5C8a9ZaLSu3WqAoKh7sybL/QwFkQM6e7tx
         UzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t68EXPEyPb2/r7j8LTsJ+u3l3tFbqRdeyuThoSQX0Z8=;
        b=rfqDYs980lqrx60dM3uddwCzUtYGq8Ft0hAYeRGbw3clgXxi1kTJxvY+8yS2/I2415
         x6pqjhqj57Cjb6mJrJOwpHw1rXzmG5IGcnSsXYWZZUKlHwG925rKoQ1DrLy7UE1wA8AD
         UteZ0o/qkntuUgMQW3hHqj/cdWYpPcLFkduWrvc1RN93a4UoRiEAqhPVgOhzzASG79B5
         W3tue8NpfWuYkyhBeHT6Cnwib8VUywF1BejqwN8i75Aje95UVaAjb2TAYJ1F7cA8JcMI
         02TQRtV6IUUNUuek03UDWilIi5ChJ0sKCa/pUhrlRf2jvjQbwjDyoZCkVCFs0lVSiaMi
         5vhA==
X-Gm-Message-State: APjAAAVXnjjfBpum5ZQqldJ25OBODYGnul8OQLmEHI1Tq0HH36pqDSza
        OvUsNKrrWmwgjUenCu024f/WPFqM/lC6SBUfEOSADg==
X-Google-Smtp-Source: APXvYqxF/lQBcl9VxeFdGQwyL2cwO0iPXqbd56cQNfFXEZQ5pknZKItQoFD9aLi9hff7bgWRRh9wTQkrYevQ0y5/0pA=
X-Received: by 2002:a9d:6201:: with SMTP id g1mr89652643otj.195.1564528895800;
 Tue, 30 Jul 2019 16:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com> <20190703011020.151615-3-saravanak@google.com>
 <CAHLCerP81Eotae5s4-Qye77SSF6-BbqFhckvkTEQWBD9biwzbw@mail.gmail.com>
In-Reply-To: <CAHLCerP81Eotae5s4-Qye77SSF6-BbqFhckvkTEQWBD9biwzbw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 30 Jul 2019 16:20:59 -0700
Message-ID: <CAGETcx-2vKLkr1Mcs-ujLdgOmztK655X2ybOnFqhupXe2xu+xg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] OPP: Add support for bandwidth OPP tables
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 3:57 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> On Wed, Jul 3, 2019 at 6:40 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Not all devices quantify their performance points in terms of frequency.
> > Devices like interconnects quantify their performance points in terms of
> > bandwidth. We need a way to represent these bandwidth levels in OPP. So,
> > add support for parsing bandwidth OPPs from DT.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/opp/of.c  | 34 ++++++++++++++++++++++++++++++++--
> >  drivers/opp/opp.h |  4 +++-
> >  2 files changed, 35 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > index c10c782d15aa..54fa70ed2adc 100644
> > --- a/drivers/opp/of.c
> > +++ b/drivers/opp/of.c
> > @@ -552,6 +552,35 @@ void dev_pm_opp_of_remove_table(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
> >
> > +static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np)
> > +{
> > +       int ret;
> > +       u64 rate;
> > +       u32 bw;
> > +
> > +       ret = of_property_read_u64(np, "opp-hz", &rate);
> > +       if (!ret) {
> > +               /*
> > +                * Rate is defined as an unsigned long in clk API, and so
> > +                * casting explicitly to its type. Must be fixed once rate is 64
> > +                * bit guaranteed in clk API.
> > +                */
> > +               new_opp->rate = (unsigned long)rate;
> > +               return 0;
> > +       }
> > +
> > +       ret = of_property_read_u32(np, "opp-peak-KBps", &bw);
> > +       if (ret)
> > +               return ret;
> > +       new_opp->rate = (unsigned long) &bw;
> > +
> > +       ret = of_property_read_u32(np, "opp-avg-KBps", &bw);
> > +       if (!ret)
> > +               new_opp->avg_bw = (unsigned long) &bw;
> > +
> > +       return 0;
> > +}
> > +
> >  /**
> >   * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
> >   * @opp_table: OPP table
> > @@ -589,11 +618,12 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
> >         if (!new_opp)
> >                 return ERR_PTR(-ENOMEM);
> >
> > -       ret = of_property_read_u64(np, "opp-hz", &rate);
> > +       ret = _read_opp_key(new_opp, np);
> >         if (ret < 0) {
> >                 /* "opp-hz" is optional for devices like power domains. */
> >                 if (!opp_table->is_genpd) {
> > -                       dev_err(dev, "%s: opp-hz not found\n", __func__);
> > +                       dev_err(dev, "%s: opp-hz or opp-peak-bw not found\n",
> > +                               __func__);
> >                         goto free_opp;
> >                 }
> >
> > diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> > index 569b3525aa67..ead2cdafe957 100644
> > --- a/drivers/opp/opp.h
> > +++ b/drivers/opp/opp.h
> > @@ -59,7 +59,8 @@ extern struct list_head opp_tables;
> >   * @turbo:     true if turbo (boost) OPP
> >   * @suspend:   true if suspend OPP
> >   * @pstate: Device's power domain's performance state.
> > - * @rate:      Frequency in hertz
> > + * @rate:      Frequency in hertz OR Peak bandwidth in kilobytes per second
>
> rate is most often used for clk rates. Let us not overload this just
> to save one struct member. IMO, you should introduce a peak_bw member
> and then have an error check if the DT provides both rate and peak_bw
> during parsing.

This is not about saving space. It avoids having to rewrite a lot of
helper functions. If you want, I can rename this to "key" but I'm not
going to create a different field.

-Saravana
