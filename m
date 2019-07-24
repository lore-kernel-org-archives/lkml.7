Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C968C76194
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 00:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50989229F7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 00:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SkD04c66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfGXAYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 20:24:06 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43133 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfGXAYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 20:24:06 -0400
Received: by mail-ot1-f66.google.com with SMTP id j11so21751808otp.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 17:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J2nVwDkl4Vc2+TqH/ItaZawh+L7B1en5I2zjp0bYwpY=;
        b=SkD04c66NBn5hXaCoIbVrb6TbBHE+LSolV4J2czO0MCXjR1lKpDWnQJk/TXm6JnCz+
         36QlbNRsxCcmic/L6UEsGhknb6dYqkoKPDKHfD5JjJsUkfmcdX1eeacNjB2KQGmG1Uvm
         xt5wW3HXqQSWPf/r6nJKfaG39AP1eUWx/myDAtE90v+MOOC+nSAIXEkutZXS9VJ5JScD
         9MNvBoamO9WdTEK4vEA8A3tthmji9Vf/TZavi6PHCUnzKhnubiAryy0zS9irsCXZquDz
         rmo8BHK0YLbitBoz30TJgUGm/HE+OZbqyqZo/yo/hawB4wpt2+Tn0Wti2gK/b34NrvTV
         6X1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J2nVwDkl4Vc2+TqH/ItaZawh+L7B1en5I2zjp0bYwpY=;
        b=Ya3D6UomqdwzGEXGLL6PxtQBv7/wDUyVs9VCFWXmBRyhFmtcP61ebKOVy38Y1ctEoT
         +ZuHOXIVOrcXvulsNAbpI50IL49aJMtCB0rmC/c7tnrNAAmcG6WUxyBLo1SVAh2N37Oz
         fdqubb4kVhz6EioggHz990myawq1B8dgRP1GCRkJRQIGx4No/8ygaPAH9RxTaz/+QBSf
         hH+4f+IC0yNhW0Alw92Fy5GI6foZfQx0zUZMqWUkDNDtxADx+TsZShM5OltJAQjHzAEF
         CqFu3h1z+koPqNBzGveR4ZloJhZDY4ZWItJ4HKtGctFYD0eSe/T0BeCuAMz/rzfCwT7a
         KaHA==
X-Gm-Message-State: APjAAAV2mNpQ86Jade3Z3hs+ds9YYQjh78tnLP6/+hwGURDZNmBK9lNO
        XRdS7ftynRcM91jiZeSmPxeYd0On34Oq4LMlW18tUg==
X-Google-Smtp-Source: APXvYqzJyhGv6saD2HPmrabwaC1QeRe+TtAScdB1yjW/ZVS3zcFy9mlxeNrMvd4l/Myo47Qfp7JTU3TBXoL1OSql0WA=
X-Received: by 2002:a9d:6256:: with SMTP id i22mr37014303otk.139.1563927845258;
 Tue, 23 Jul 2019 17:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com> <20190717222340.137578-3-saravanak@google.com>
 <20190723095316.t5ltprixxd5veuj7@vireshk-i7>
In-Reply-To: <20190723095316.t5ltprixxd5veuj7@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 23 Jul 2019 17:23:29 -0700
Message-ID: <CAGETcx-r6fZH0xYea-YXyXDwe33pimtfNerLzzBn4UHT2qQVvA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] OPP: Add function to look up required OPP's for a
 given OPP
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 2:53 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 17-07-19, 15:23, Saravana Kannan wrote:
> > Add a function that allows looking up required OPPs given a source OPP
> > table, destination OPP table and the source OPP.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/opp/core.c     | 54 ++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pm_opp.h | 11 +++++++++
> >  2 files changed, 65 insertions(+)
> >
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index 438fcd134d93..72c055a3f6b7 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -1883,6 +1883,60 @@ void dev_pm_opp_detach_genpd(struct opp_table *opp_table)
> >  }
> >  EXPORT_SYMBOL_GPL(dev_pm_opp_detach_genpd);
> >
> > +/**
> > + * dev_pm_opp_xlate_opp() - Find required OPP for src_table OPP.
> > + * @src_table: OPP table which has dst_table as one of its required OPP table.
> > + * @dst_table: Required OPP table of the src_table.
> > + * @pstate: OPP of the src_table.
>
> You should use @ before parameters in the comments as well ? Just like
> you did that below.

And I should probably be deleting the @pstate phantom parameter :)

> > + *
> > + * This function returns the OPP (present in @dst_table) pointed out by the
> > + * "required-opps" property of the OPP (present in @src_table).
> > + *
> > + * The callers are required to call dev_pm_opp_put() for the returned OPP after
> > + * use.
> > + *
> > + * Return: destination table OPP on success, otherwise NULL on errors.
> > + */
> > +struct dev_pm_opp *dev_pm_opp_xlate_opp(struct opp_table *src_table,
>
> Please name it dev_pm_opp_xlate_required_opp().

Ok

>
> > +                                     struct opp_table *dst_table,
> > +                                     struct dev_pm_opp *src_opp)
> > +{
> > +     struct dev_pm_opp *opp, *dest_opp = NULL;
> > +     int i;
> > +
> > +     if (!src_table || !dst_table || !src_opp)
> > +             return NULL;
> > +
> > +     for (i = 0; i < src_table->required_opp_count; i++) {
> > +             if (src_table->required_opp_tables[i]->np == dst_table->np)
>
> Why can't we just compare the table pointers instead ? Yeah, I know
> that's how I wrote that in the other xlate function, but I am confused
> now :)

I almost said "not sure. Let me just compare pointers".
I think (not sure) it has to do with the same OPP table being used to
create multiple OPP table copies if the "shared OPP table" flag isn't
set?
Can you confirm if this makes sense? If so, I can add a comment patch
that adds comments to the existing code and then copies it into this
function in this patch.

> > +                     break;
> > +     }
> > +
> > +     if (unlikely(i == src_table->required_opp_count)) {
> > +             pr_err("%s: Couldn't find matching OPP table (%p: %p)\n",
> > +                    __func__, src_table, dst_table);
> > +             return NULL;
> > +     }
> > +
> > +     mutex_lock(&src_table->lock);
> > +
> > +     list_for_each_entry(opp, &src_table->opp_list, node) {
> > +             if (opp == src_opp) {
> > +                     dest_opp = opp->required_opps[i];
> > +                     dev_pm_opp_get(dest_opp);
> > +                     goto unlock;
> > +             }
> > +     }
> > +
> > +     pr_err("%s: Couldn't find matching OPP (%p: %p)\n", __func__, src_table,
> > +            dst_table);
> > +
> > +unlock:
> > +     mutex_unlock(&src_table->lock);
> > +
> > +     return dest_opp;
> > +}
> > +
> >  /**
> >   * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.
> >   * @src_table: OPP table which has dst_table as one of its required OPP table.
> > diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> > index af5021f27cb7..36f52b9cf24a 100644
> > --- a/include/linux/pm_opp.h
> > +++ b/include/linux/pm_opp.h
> > @@ -131,6 +131,9 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
> >  struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names);
> >  void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
> >  int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
> > +struct dev_pm_opp *dev_pm_opp_xlate_opp(struct opp_table *src_table,
> > +                                     struct opp_table *dst_table,
> > +                                     struct dev_pm_opp *src_opp);
> >  int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
> >  int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
> >  int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
> > @@ -304,6 +307,14 @@ static inline int dev_pm_opp_xlate_performance_state(struct opp_table *src_table
> >       return -ENOTSUPP;
> >  }
> >
> > +static inline struct dev_pm_opp *dev_pm_opp_xlate_opp(
> > +                                             struct opp_table *src_table,
> > +                                             struct opp_table *dst_table,
> > +                                             struct dev_pm_opp *src_opp)
> > +{
> > +     return NULL;
> > +}
> > +
>
> Keep the order of declaring routines same, so this goes before the
> other xlate routine.

Will do.

-Saravana

> >  static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
> >  {
> >       return -ENOTSUPP;
> > --
> > 2.22.0.510.g264f2c817a-goog
>
> --
> viresh
