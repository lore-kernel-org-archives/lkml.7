Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D270C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 20:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7265520880
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 20:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jWK9JgU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389496AbfHGUqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 16:46:52 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36498 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730045AbfHGUqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 16:46:51 -0400
Received: by mail-ot1-f66.google.com with SMTP id r6so109741297oti.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 13:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1drnZsNJ30h8VB1p7exPq6Ba5yiKi2dka+MQPDhn2UQ=;
        b=jWK9JgU9V08mGULS627pv+JWIbES/c1ddmqDJQCSA18TSPZ65qxQOlPswgfzd06XFf
         DRuWrk80lcdXWpPZRX+lIiOY93ECSJoiQCGKN/wDU+EHHTbLZ8A9wjLZy2dhklRZT0SV
         ykhyFs4wnZb/eB8ScZ1OXkw5hUNFhxlruQsR0XTMfWapA9vp6BDhr992fOZ3AEoL2FLA
         lTbqUyJLr0fHXCfTQ5bhr8BrSoe2tf84CsXyxhWG3n/xTeJIcF9wZwunMgBBHsjHoYc3
         1k3vEGC/zWh0DYG+xWHddiDWHVd0EVvrz8u2z/NZYuLxsh34HPkSdCGcEmk1//SEwzBY
         GK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1drnZsNJ30h8VB1p7exPq6Ba5yiKi2dka+MQPDhn2UQ=;
        b=uB2aKxNFRvVMJTTl1+5C/4wKTeGpo/Paj2uALmKVtUXzu5MJwwTOJhNOGJo1H9rJ/i
         CnUfOPfsT69zCE52dlamNqIZnzCGaQpZ5jvhK8fz0qUUM/HUNNahoNPS3Z/+5/uX6Vbn
         82jrA+Gg9z9OgFIrhb2W99ja5Pbe3l3DfjcjDpvLh0zkO5qU038HxiZcCYzKAsp8OR2R
         xvON7a7HFXkQlMdcPKdlJQdhN1WeSOOU/E6MXA0Xgl3O1CJcJfcRDmtNKH1uJ8uNnHLO
         kLafsIS0hvKZbVks8rlFWPPd0UsQwr+ngEk/FtuicGyVjOGiwSGRz2AtyK7fG2U0n5iY
         AdPw==
X-Gm-Message-State: APjAAAXJ71QK6DQRPjcUJFAqGcEpPezaL5D8LurCoXUzPKpju1XiOZCv
        hZx9aJYsbHhtVYOK5SPx+1Gywz43GkfyjPPNWv2r4g==
X-Google-Smtp-Source: APXvYqwL+5I/uBwlSg65FPxVLioe2KXP4DO+byd51b7MUvPmh84Vp0qaLSYhdhuW8vbescgu2ff0lZyh/Irbvl1/Cbc=
X-Received: by 2002:a9d:6256:: with SMTP id i22mr9805438otk.139.1565210810189;
 Wed, 07 Aug 2019 13:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190726231558.175130-1-saravanak@google.com> <20190726231558.175130-3-saravanak@google.com>
 <fc8e4a77-5544-0dd7-f103-147f87e44a28@linaro.org>
In-Reply-To: <fc8e4a77-5544-0dd7-f103-147f87e44a28@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 7 Aug 2019 13:46:14 -0700
Message-ID: <CAGETcx8n_YfPH1Fbvb2ay5A=AqG60V6nvtfE0s1OAJMhVQjDmA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] OPP: Add support for bandwidth OPP tables
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Wed, Aug 7, 2019 at 5:53 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Hi Saravana,
>
> On 7/27/19 02:15, Saravana Kannan wrote:
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
> > index b313aca9894f..ac73512f4416 100644
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
>
> So we can't have a single OPP table with both frequency and bandwidth?

Right, because we can have only 1 "key" for the OPP table. Having more
than one "key" for an OPP table makes a lot of things pretty messy.
Most of the helper functions need to be rewritten to say which key is
being referred to when searching. A lot of the error checking when
creating OPP tables becomes convoluted -- can we allow more than one
OPP entry with the same frequency just because the opp-peak-kBps is
different? Etc. Seems like a lot of code change for something that I
don't think is a very useful.

Also, an OPP table is either going to represent performance levels of
a clock domain (opp-hz) or the performance levels of an interconnect
path (opp-peak-kBps) or an OPP table for genpd. Mixing them all up is
just going to make it convoluted with not enough benefit or use case
that can't be handled as is (separate BW and freq OPP tables).

> > +     }
> > +
> > +     ret = of_property_read_u32(np, "opp-peak-KBps", &bw);
> > +     if (ret)
> > +             return ret;
> > +     new_opp->rate = (unsigned long) bw;
> > +
> > +     ret = of_property_read_u32(np, "opp-avg-KBps", &bw);
> > +     if (!ret)
> > +             new_opp->avg_bw = (unsigned long) bw;
> > +
> > +     return 0;
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
> > +                     dev_err(dev, "%s: opp-hz or opp-peak-bw not found\n",
>
> s/opp-peak-bw/opp-peak-kBps/

Thanks. Will fix.

-Saravana
