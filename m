Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E29C76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8552173E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSA1pWuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388294AbfGPTLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 15:11:12 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32861 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbfGPTLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:11:11 -0400
Received: by mail-ot1-f67.google.com with SMTP id q20so22280741otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 12:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3H0cienAlZ+Zv0tFhkXjnmPbMEeRYyOryne9l976TMI=;
        b=XSA1pWuhJTplykTcj9mU38IbFHPceiRxCZ+WTBXEDymwQlb9JFzlHwDnUcIRwawIS2
         wH7ENYinK78KzmH4WXncBa0vPz3op3gMZ5Urp49G6PZQXtppUDNCsmLJfPRPF07IJHpU
         xcdbjaqOmbsEImPcjGV1E2PMWj4FmJzFFvgrcg/PS8jMNwpvOuiJ7pE8WvL6qO3GESAk
         JAqkQlI6RlcjO8h30vGF2DxLzr1lkXOYiSR5dAHYxCoVMPlkLpgirUpSb5uK7Tqvf0cq
         h5Fsi8v9UAH8Rjo9ppO+2uE7z8c0N4vu0Ty4O5YdvsWygBOtacLw74jewcLXY7+EMHXn
         BW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3H0cienAlZ+Zv0tFhkXjnmPbMEeRYyOryne9l976TMI=;
        b=p+ZShliSRHWTuD0T8ZPAvRCRlbFVagGmnXHcSMfq9mqh6lAzq6boXnwLqxFugHtEr/
         eJAzOdmb9joN8wWNz5/kGbfhJ7bMlByDigvdbA+smQBeZBDUfOWIfZ1XuiVi3XmhcfyB
         ruywlliuIXlYWlSVKy/BML6McpQFfbDdCYqnONphGlyVDbovenm9oJNYg3N2SulDU8Hv
         L1YgwVfn6CwejxREbiH86K3Mh03mT+mVOjfZZRt8KCfbjWVs+1R6kA3HPMxhaZGWyZX0
         HCCXYKabvK3n1mHcCSNMsJuJaQuyf2y/hUbwHFytGGaRo82/GSyRvKy0Y+r0pnjCgRPp
         zjAw==
X-Gm-Message-State: APjAAAU3gZZtXQadNbZR2sCdBqOzjuUHiflYmC/RXK89LdgCxPbt388I
        yhZ0s8wmJjuLFP06My6DWG564budvcl8lTUYoAIoiA==
X-Google-Smtp-Source: APXvYqzvfCt6sCR4T4XqzPAhOtvsYyVOWwVzg9O4IjGSyx0lFEbqjlUxvAZG44/eRFQK9LAUMu2c8h6yjV3U3zwUQ8U=
X-Received: by 2002:a9d:6201:: with SMTP id g1mr26712811otj.195.1563304270351;
 Tue, 16 Jul 2019 12:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com> <20190703011020.151615-3-saravanak@google.com>
 <5dd35be3-fd03-c9cc-1eed-ce4bc1433363@codeaurora.org>
In-Reply-To: <5dd35be3-fd03-c9cc-1eed-ce4bc1433363@codeaurora.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 16 Jul 2019 12:10:34 -0700
Message-ID: <CAGETcx9NpYY4OmXdjHHCjqN7eZ4=7H9TdGZvw2Qr0K9Aq==ENg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] OPP: Add support for bandwidth OPP tables
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        adharmap@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:33 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Hey Saravana,
>
> On 7/3/19 6:40 AM, Saravana Kannan wrote:
> > Not all devices quantify their performance points in terms of frequency.
> > Devices like interconnects quantify their performance points in terms of
> > bandwidth. We need a way to represent these bandwidth levels in OPP. So,
> > add support for parsing bandwidth OPPs from DT.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >   drivers/opp/of.c  | 34 ++++++++++++++++++++++++++++++++--
> >   drivers/opp/opp.h |  4 +++-
> >   2 files changed, 35 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > index c10c782d15aa..54fa70ed2adc 100644
> > --- a/drivers/opp/of.c
> > +++ b/drivers/opp/of.c
> > @@ -552,6 +552,35 @@ void dev_pm_opp_of_remove_table(struct device *dev)
> >   }
> >   EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
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
> > +             new_opp->rate = (unsigned long)rate
> now that the rate gets set here, please remove the rate assignment in
> _opp_add_static_v2
>
> > +             return 0;
> > +     }
> > +
> > +     ret = of_property_read_u32(np, "opp-peak-KBps", &bw);
> > +     if (ret)
> > +             return ret;
> > +     new_opp->rate = (unsigned long) &bw;
>
> should be bw instead

Good catch. Thanks!

>
> > +
> > +     ret = of_property_read_u32(np, "opp-avg-KBps", &bw);
> > +     if (!ret)
> > +             new_opp->avg_bw = (unsigned long) &bw;
>
> ditto
>
> > +
> > +     return 0;
> > +}
> > +
> >   /**
> >    * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
> >    * @opp_table:      OPP table
> > @@ -589,11 +618,12 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
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
> > +                             __func__);
>
> please remove the else part where rate value will be reset.

Ah! I flipped the meaning of the "if" check in my head. Thanks!

-Saravana
