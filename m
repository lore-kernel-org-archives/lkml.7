Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4780DC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F6221901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i2UY4eJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389505AbfGYC6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 22:58:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37690 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389248AbfGYC6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 22:58:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so21928926pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 19:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K0weWVGXZjkvj8mXma8Dpnxrjjl3kZYS+QAphCpV/Js=;
        b=i2UY4eJwQFs3tYiMrQYRnZmJPTDMTzK1Ti9myZX4gnA3WJb98B9whPZhbo6nUhB/KE
         ffRcks6RmvOKz+/BkGel6WlQrhwZQxC4K9q6o787vkSqrlzpnPX/+WaBTh9/mFt5v819
         z7DJuSSQf4FYkjbMBzvBctYzRBcJDoCZwiIfgSKTb+Lnym5O8xZG+2wZwrzZXzmvsgKZ
         X9aiR7+XjkTLKuVlvkz45TUu49boMgO5mIA+kyADfiB300LAggL0GEXmGjoEBj7oalLt
         iflLxPC9Vti0t8EsxBd0DcOV9wIdjgQipFM5DMylDWC++nAj1B68w6tIz2CfEYJU9ZJl
         k5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K0weWVGXZjkvj8mXma8Dpnxrjjl3kZYS+QAphCpV/Js=;
        b=HSsW/Hev2r7g7ETdM85fLbtQ3xPgDND7rlXPc3vkE0Flix528nxR9krZSrC0Oh2rMS
         VUb3EBAbWnIG3QNXbYSc3b8QxYNZuHWMrreqjSnwszlLS35nLdpg2Zs3HoXi/iNbFRbF
         Ww+prWMQ1vayi4n/1eEdno96pve43uiloQMfwWk79kc0iM9xWx0pCRspcwCRnU/MEKRg
         WRMrNx3dTlYW6uuY8RXyQREGhXfZlhTsl7JHiQkKNxNTNFi74Xa2aJk9x4F2824VPe6c
         jyDpNz137enfK/wWEmw2g0EHQSm9176j9QI/w18X5Wa77afDmpnXjFKk89FrKBniq4WW
         hdIw==
X-Gm-Message-State: APjAAAWvgrJkHXMfIFaAzTBsIoaWNZzLgdHb829h8RreeVfEY3Dx8k+g
        SNmzfMLTivSEVtmpn7YTXpb7Ww==
X-Google-Smtp-Source: APXvYqyWzdD1gl9CklGAM5HgrGjIaVpp1C8jVT6frK+CFL+QwAeR92Y86iKbLOvFyl7IftGjZGE57A==
X-Received: by 2002:a63:f456:: with SMTP id p22mr8471318pgk.45.1564023533373;
        Wed, 24 Jul 2019 19:58:53 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id k6sm57336209pfi.12.2019.07.24.19.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 19:58:51 -0700 (PDT)
Date:   Thu, 25 Jul 2019 08:28:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
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
Subject: Re: [PATCH v3 2/5] OPP: Add function to look up required OPP's for a
 given OPP
Message-ID: <20190725025849.y2xyxmqmgorrny6k@vireshk-i7>
References: <20190717222340.137578-1-saravanak@google.com>
 <20190717222340.137578-3-saravanak@google.com>
 <20190723095316.t5ltprixxd5veuj7@vireshk-i7>
 <CAGETcx-r6fZH0xYea-YXyXDwe33pimtfNerLzzBn4UHT2qQVvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-r6fZH0xYea-YXyXDwe33pimtfNerLzzBn4UHT2qQVvA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-19, 17:23, Saravana Kannan wrote:
> On Tue, Jul 23, 2019 at 2:53 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 17-07-19, 15:23, Saravana Kannan wrote:
> > > Add a function that allows looking up required OPPs given a source OPP
> > > table, destination OPP table and the source OPP.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/opp/core.c     | 54 ++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/pm_opp.h | 11 +++++++++
> > >  2 files changed, 65 insertions(+)
> > >
> > > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > > index 438fcd134d93..72c055a3f6b7 100644
> > > --- a/drivers/opp/core.c
> > > +++ b/drivers/opp/core.c
> > > @@ -1883,6 +1883,60 @@ void dev_pm_opp_detach_genpd(struct opp_table *opp_table)
> > >  }
> > >  EXPORT_SYMBOL_GPL(dev_pm_opp_detach_genpd);
> > >
> > > +/**
> > > + * dev_pm_opp_xlate_opp() - Find required OPP for src_table OPP.
> > > + * @src_table: OPP table which has dst_table as one of its required OPP table.
> > > + * @dst_table: Required OPP table of the src_table.
> > > + * @pstate: OPP of the src_table.
> >
> > You should use @ before parameters in the comments as well ? Just like
> > you did that below.
> 
> And I should probably be deleting the @pstate phantom parameter :)
> 
> > > + *
> > > + * This function returns the OPP (present in @dst_table) pointed out by the
> > > + * "required-opps" property of the OPP (present in @src_table).
> > > + *
> > > + * The callers are required to call dev_pm_opp_put() for the returned OPP after
> > > + * use.
> > > + *
> > > + * Return: destination table OPP on success, otherwise NULL on errors.
> > > + */
> > > +struct dev_pm_opp *dev_pm_opp_xlate_opp(struct opp_table *src_table,
> >
> > Please name it dev_pm_opp_xlate_required_opp().
> 
> Ok
> 
> >
> > > +                                     struct opp_table *dst_table,
> > > +                                     struct dev_pm_opp *src_opp)
> > > +{
> > > +     struct dev_pm_opp *opp, *dest_opp = NULL;
> > > +     int i;
> > > +
> > > +     if (!src_table || !dst_table || !src_opp)
> > > +             return NULL;
> > > +
> > > +     for (i = 0; i < src_table->required_opp_count; i++) {
> > > +             if (src_table->required_opp_tables[i]->np == dst_table->np)
> >
> > Why can't we just compare the table pointers instead ? Yeah, I know
> > that's how I wrote that in the other xlate function, but I am confused
> > now :)
> 
> I almost said "not sure. Let me just compare pointers".
> I think (not sure) it has to do with the same OPP table being used to
> create multiple OPP table copies if the "shared OPP table" flag isn't
> set?
> Can you confirm if this makes sense? If so, I can add a comment patch
> that adds comments to the existing code and then copies it into this
> function in this patch.

Right, that was the reason but we also need to fix ...

> > > +                     break;
> > > +     }
> > > +
> > > +     if (unlikely(i == src_table->required_opp_count)) {
> > > +             pr_err("%s: Couldn't find matching OPP table (%p: %p)\n",
> > > +                    __func__, src_table, dst_table);
> > > +             return NULL;
> > > +     }
> > > +
> > > +     mutex_lock(&src_table->lock);
> > > +
> > > +     list_for_each_entry(opp, &src_table->opp_list, node) {
> > > +             if (opp == src_opp) {

... this as well. We must be comparing node pointers here as well.

> > > +                     dest_opp = opp->required_opps[i];
> > > +                     dev_pm_opp_get(dest_opp);
> > > +                     goto unlock;
> > > +             }
> > > +     }
> > > +
> > > +     pr_err("%s: Couldn't find matching OPP (%p: %p)\n", __func__, src_table,
> > > +            dst_table);
> > > +
> > > +unlock:
> > > +     mutex_unlock(&src_table->lock);
> > > +
> > > +     return dest_opp;
> > > +}
> > > +
> > >  /**
> > >   * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.
> > >   * @src_table: OPP table which has dst_table as one of its required OPP table.
> > > diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> > > index af5021f27cb7..36f52b9cf24a 100644
> > > --- a/include/linux/pm_opp.h
> > > +++ b/include/linux/pm_opp.h
> > > @@ -131,6 +131,9 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
> > >  struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names);
> > >  void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
> > >  int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
> > > +struct dev_pm_opp *dev_pm_opp_xlate_opp(struct opp_table *src_table,
> > > +                                     struct opp_table *dst_table,
> > > +                                     struct dev_pm_opp *src_opp);
> > >  int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
> > >  int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
> > >  int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
> > > @@ -304,6 +307,14 @@ static inline int dev_pm_opp_xlate_performance_state(struct opp_table *src_table
> > >       return -ENOTSUPP;
> > >  }
> > >
> > > +static inline struct dev_pm_opp *dev_pm_opp_xlate_opp(
> > > +                                             struct opp_table *src_table,
> > > +                                             struct opp_table *dst_table,
> > > +                                             struct dev_pm_opp *src_opp)
> > > +{
> > > +     return NULL;
> > > +}
> > > +
> >
> > Keep the order of declaring routines same, so this goes before the
> > other xlate routine.
> 
> Will do.
> 
> -Saravana
> 
> > >  static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
> > >  {
> > >       return -ENOTSUPP;
> > > --
> > > 2.22.0.510.g264f2c817a-goog
> >
> > --
> > viresh

-- 
viresh
