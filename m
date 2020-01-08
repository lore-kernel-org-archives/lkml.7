Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3553C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8072070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eHZPn0qF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgAHGRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 01:17:04 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40879 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgAHGRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 01:17:03 -0500
Received: by mail-oi1-f193.google.com with SMTP id c77so1696213oib.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 22:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7eJrxhaP/aaAfcxtlL9c20UfMMdfSSzkJiRKVZy1Dns=;
        b=eHZPn0qFgiwR3TqFdduhITPTiKflxh0LGckrcuBVonlJemqgmLHotGKYPwlHp1FJMi
         xNnCmo6tTnLgl2axxjjps13sWddlfqJLjuY7gDwHJgGruJMUq6NdN2PVTMetx8SRM4So
         +15FJC2MFVzhNDSkf3N433EGhGJBDxaDNMdrcbsPRbUB3kCnIlCCM4rQLlneQQI8gKsv
         lIttIgNYq4KMNjKAHWH+QBINXldzaIjxFu6EEkdCq+MQmui8YHyvI1PxwXY9taRR3pt1
         mjGO/QDtkelqlR9gjQuP7z6LR9nM/W+onOl3mqOcEmHmiYOvmiHX2A94xcqB8N4eWqTD
         a+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7eJrxhaP/aaAfcxtlL9c20UfMMdfSSzkJiRKVZy1Dns=;
        b=FANIjjzsYEew+jizQko1c3aSMiRrmnUjJhrMj6Uhsz2kx47neqm+R1m9HbgfiHFlWC
         ZfvTDquNGHxKrR4+NUckP8VDr2BbMXszqNZFKqsps+JawjqhDlvWY/qKhhzlw3teLD3l
         RUsvy+Htu3vqlJbfCLd98wjYujwe0d+URas/NZgWBsHq7lOaUAUZJEm1c9REZSy+LzGx
         QRuRusCPJbK58UUj0hVg4qVTOsCaDjjQu5iY/G5mKwOTlWSSqO3PmwYOgedcCHewkbx3
         uZFP+m5zpzf6VcHOQxo8hnPWwaeDZmbaJWZY6oIHVSccxxbzY6CLh3IuC7WmgGikQCB6
         vffQ==
X-Gm-Message-State: APjAAAWVf3iReHYZgT6GACbhPCMA1+egWtRdIp65ot6+lUwZfrHYp8rK
        9zlDpCpFKAuGICdBlGVtuIlqLvMnXm1L3kPYPz/xJQ==
X-Google-Smtp-Source: APXvYqwrxujGPx+8mslow3vxWpXeXFymV/tHcUenrLe4Wf7W57KW9I6GPXuC3PeiLqPMCiatJJf8YGVK7zVdiZMj9AA=
X-Received: by 2002:aca:d4c1:: with SMTP id l184mr1907823oig.172.1578464220518;
 Tue, 07 Jan 2020 22:17:00 -0800 (PST)
MIME-Version: 1.0
References: <20191207002424.201796-1-saravanak@google.com> <20191207002424.201796-3-saravanak@google.com>
 <c701fe1d94631e3aba92a8c80070c6a4@codeaurora.org>
In-Reply-To: <c701fe1d94631e3aba92a8c80070c6a4@codeaurora.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 7 Jan 2020 22:16:24 -0800
Message-ID: <CAGETcx9Or==EEL6jRMEh4bG4cmFmLqk_n1ReKT=cg-MEsL9w0w@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] OPP: Add support for bandwidth OPP tables
To:     Sibi Sankar <sibis@codeaurora.org>
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

On Tue, Jan 7, 2020 at 11:28 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Hey Saravana,
>
> Spent some time testing this series while
> trying out dcvs on SDM845/SC7180. Apart from
> the few minor issues it works quite well!

Thanks a lot for testing Sibi. Can you give a tested-by? Glad to hear
it works well.

> On 2019-12-07 05:54, Saravana Kannan wrote:
> > Not all devices quantify their performance points in terms of
> > frequency.
> > Devices like interconnects quantify their performance points in terms
> > of
> > bandwidth. We need a way to represent these bandwidth levels in OPP.
> > So,
> > add support for parsing bandwidth OPPs from DT.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/opp/core.c | 15 +++++++++--
> >  drivers/opp/of.c   | 63 ++++++++++++++++++++++++++++++++--------------
> >  drivers/opp/opp.h  |  5 ++++
> >  3 files changed, 62 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index be7a7d332332..c79bbfac7289 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -1282,11 +1282,21 @@ static bool
> > _opp_supported_by_regulators(struct dev_pm_opp *opp,
> >       return true;
> >  }
> >
> > +int opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2)
> > +{
> > +     if (opp1->rate != opp2->rate)
> > +             return opp1->rate < opp2->rate ? -1 : 1;
> > +     if (opp1->peak_bw != opp2->peak_bw)
> > +             return opp1->peak_bw < opp2->peak_bw ? -1 : 1;
> > +     return 0;
> > +}
> > +
> >  static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp
> > *new_opp,
> >                            struct opp_table *opp_table,
> >                            struct list_head **head)
> >  {
> >       struct dev_pm_opp *opp;
> > +     int opp_cmp;
> >
> >       /*
> >        * Insert new OPP in order of increasing frequency and discard if
> > @@ -1297,12 +1307,13 @@ static int _opp_is_duplicate(struct device
> > *dev, struct dev_pm_opp *new_opp,
> >        * loop.
> >        */
> >       list_for_each_entry(opp, &opp_table->opp_list, node) {
> > -             if (new_opp->rate > opp->rate) {
> > +             opp_cmp = opp_compare_key(new_opp, opp);
> > +             if (opp_cmp > 0) {
> >                       *head = &opp->node;
> >                       continue;
> >               }
> >
> > -             if (new_opp->rate < opp->rate)
> > +             if (opp_cmp < 0)
> >                       return 0;
> >
> >               /* Duplicate OPPs */
> > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > index 1cbb58240b80..b565da5a2b1f 100644
> > --- a/drivers/opp/of.c
> > +++ b/drivers/opp/of.c
> > @@ -521,6 +521,44 @@ void dev_pm_opp_of_remove_table(struct device
> > *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
> >
> > +static int _read_opp_key(struct dev_pm_opp *new_opp, struct
> > device_node *np,
> > +                      bool *rate_not_available)
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
> > +             goto out;
> > +     }
> > +
> > +     ret = of_property_read_u32(np, "opp-peak-kBps", &bw);
> > +     if (!ret) {
> > +             new_opp->peak_bw = bw;
> > +
> > +             if (!of_property_read_u32(np, "opp-avg-kBps", &bw))
> > +                     new_opp->avg_bw = bw;
> > +     }
> > +
> > +out:
> > +     *rate_not_available = !!ret;
> > +     /*
> > +      * If ret is 0 at this point, we have already found a key. If we
> > +      * haven't found a key yet, then ret already has an error value. In
> > +      * either case, we don't need to update ret.
> > +      */
> > +     of_property_read_u32(np, "opp-level", &new_opp->level);
> > +
> > +     return ret;
> > +}
> > +
> >  /**
> >   * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT
> > bindings)
> >   * @opp_table:       OPP table
> > @@ -558,26 +596,12 @@ static struct dev_pm_opp
> > *_opp_add_static_v2(struct opp_table *opp_table,
> >       if (!new_opp)
> >               return ERR_PTR(-ENOMEM);
> >
> > -     ret = of_property_read_u64(np, "opp-hz", &rate);
> > -     if (ret < 0) {
> > -             /* "opp-hz" is optional for devices like power domains. */
> > -             if (!opp_table->is_genpd) {
> > -                     dev_err(dev, "%s: opp-hz not found\n", __func__);
> > -                     goto free_opp;
> > -             }
> > -
> > -             rate_not_available = true;
> > -     } else {
> > -             /*
> > -              * Rate is defined as an unsigned long in clk API, and so
> > -              * casting explicitly to its type. Must be fixed once rate is 64
> > -              * bit guaranteed in clk API.
> > -              */
> > -             new_opp->rate = (unsigned long)rate;
> > +     ret = _read_opp_key(new_opp, np, &rate_not_available);
> > +     if (ret) {
>
> if (!opp_table->is_genpd) {
>
> _read_opp_key returns an error for genpd
> opps so please check if it is a genpd
> opp_table before erroring out here.

Thanks. I'll fix it in the next version.

> > +             dev_err(dev, "%s: opp key field not found\n", __func__);
> > +             goto free_opp;
> >       }
> >
> > -     of_property_read_u32(np, "opp-level", &new_opp->level);
> > -
> >       /* Check if the OPP supports hardware's hierarchy of versions or not
> > */
> >       if (!_opp_is_supported(dev, opp_table, np)) {
> >               dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
> > @@ -616,7 +640,8 @@ static struct dev_pm_opp
> > *_opp_add_static_v2(struct opp_table *opp_table,
> >       if (of_property_read_bool(np, "opp-suspend")) {
> >               if (opp_table->suspend_opp) {
> >                       /* Pick the OPP with higher rate as suspend OPP */
> > -                     if (new_opp->rate > opp_table->suspend_opp->rate) {
> > +                     if (opp_compare_key(new_opp,
> > +                                         opp_table->suspend_opp) > 1) {
>
> shouldn't the condition be > 0?

Duh. Thanks. I'll fix it in the next version.

I'm guessing you tested with the fixes you pointed out?

-Saravana
