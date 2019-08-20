Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C30EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 22:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E08422DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 22:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NKg7jJl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbfHTWeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 18:34:44 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32801 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730649AbfHTWeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 18:34:44 -0400
Received: by mail-oi1-f196.google.com with SMTP id l2so147025oil.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 15:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wW0cWS0eh3TlrDo6fyrKO5TnCZveD/eXLSqHEjO60kQ=;
        b=NKg7jJl1l6lbCqiWVTNePZN2GTkmHu35mU+BCl8b7NWqGZorqm7+Zacj1b33yACq7T
         v+raWi7luC+Co9ifi/WXXhjU5yJoGsTBzhBo/3/zl5oY4/oJVK9SsO4cICA1cZPPHxN5
         SOfgQP1gXJ75QBmJmWdZi2zOS87/f24hHukrbfshHbpTb6cB+t4fS6rgEfXaEf/im5+e
         B9ZZ0NQRlIYF8Uk+XPDqphnEqz8+TO9w/qk3iLK2YlhcEY+0+ERQCOuiOIvWsST5WiY7
         pKsH/pUB2lYfeIy1xXnQmFeW9y5Z5bfu4gWn+pTLHVQq6+6mQU4wLP5FWVpSH5F/7P/y
         AW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wW0cWS0eh3TlrDo6fyrKO5TnCZveD/eXLSqHEjO60kQ=;
        b=JOQgrXsNv6JoFwpNw3JFr8+wiHuWMuMGaKR21PUAmunO70e05lW51FIx/qdkRyS2BN
         KUF3sXpALDBQd3Tzf/eBJsfuS300lHlF4I+sH0OVR6TAQL7diBdMrcyHVmm+Ftdhxaxh
         CVtYYqPoI71JEmfHsLeUiR+Hsu/HVCHFretddQZxGuFiyvispcR1dG4MUVoIETbYW3hz
         mu4nvTNuQLzaIBpObv2LtW3JNrLf1BxZV6PP3JmsNkrpF9w47F6+OGHzmY8coZM+zZbG
         JYgpPbarnkCX08JIYDc5Y13DZGD+f8UIax8HLhh4iTSguCGb/Nk72DY+5I2Pt2QyoS7l
         yH6Q==
X-Gm-Message-State: APjAAAXCoAKAtklEbmr7ayOncff5z+rklN1j6+nvjY3Se5AQRFYUpAfs
        sXcXyzPKyccC/O0teW+lVLce1tULrnSQ4d0XDT/a5A==
X-Google-Smtp-Source: APXvYqzCK4bK7zyRJiy+KGcqESReBaEiNjLOmVgKh7dWTAFMwYMrrfcI4OQ8cbpTbfl+h48VAdzfMGWN1uTMOoNKgTA=
X-Received: by 2002:aca:c396:: with SMTP id t144mr1691981oif.172.1566340482904;
 Tue, 20 Aug 2019 15:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190807223111.230846-1-saravanak@google.com> <20190807223111.230846-3-saravanak@google.com>
 <20190816182131.A692E206C1@mail.kernel.org>
In-Reply-To: <20190816182131.A692E206C1@mail.kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 20 Aug 2019 15:34:07 -0700
Message-ID: <CAGETcx8h2v054eS6pZ3iEsM2AGfN45_fqJGsVt+1UhbrK_dbdQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] OPP: Add support for bandwidth OPP tables
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
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

On Fri, Aug 16, 2019 at 11:21 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Saravana Kannan (2019-08-07 15:31:10)
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
> > +       ret = of_property_read_u32(np, "opp-peak-kBps", &bw);
> > +       if (ret)
> > +               return ret;
> > +       new_opp->rate = (unsigned long) bw;
> > +
> > +       ret = of_property_read_u32(np, "opp-avg-kBps", &bw);
> > +       if (!ret)
>
> I would write this as
>
>         if (!of_property_read_u32(np, "opp-avg-kBps", &bw))
>                 new_opp->avg_bw = (unsigned long) bw;
>
> because you don't care about the return value.

Sure, will do.

>
> > +               new_opp->avg_bw = (unsigned long) bw;
> > +
> > +       return 0;
> > +}
> > +
> >  /**
> >   * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
> >   * @opp_table: OPP table
> > diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> > index 01a500e2c40a..6bb238af9cac 100644
> > --- a/drivers/opp/opp.h
> > +++ b/drivers/opp/opp.h
> > @@ -56,7 +56,8 @@ extern struct list_head opp_tables;
> >   * @turbo:     true if turbo (boost) OPP
> >   * @suspend:   true if suspend OPP
> >   * @pstate: Device's power domain's performance state.
> > - * @rate:      Frequency in hertz
> > + * @rate:      Frequency in hertz OR Peak bandwidth in kilobytes per second
>
> Why is Peak capitalized?

Because it's another Key? :)

Just kidding. I'll fix it.

> > + * @avg_bw:    Average bandwidth in kilobytes per second
> >   * @level:     Performance level
> >   * @supplies:  Power supplies voltage/current values
> >   * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
> > @@ -78,6 +79,7 @@ struct dev_pm_opp {
> >         bool suspend;
> >         unsigned int pstate;
> >         unsigned long rate;
>
> If you're trying to save space why not make an anonymous union here of
> 'rate' and 'bandwidth'? Then the code doesn't read all weird.

It's not about saving space. It's about having to rewrite all the
helper functions (see subsequent patch in this series) for different
"keys" with zero difference in the actual comparisons/logic. I'm
proposing I rename this to "key" in another email.


-Saravana
