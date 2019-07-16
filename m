Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40318C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E9720693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DeeInblY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388239AbfGPSz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:55:27 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36386 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbfGPSz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:55:27 -0400
Received: by mail-oi1-f193.google.com with SMTP id w7so16424563oic.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 11:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v2qNIAYunawQIOohUStC2uepdglhwjwNOkwTkSmuqwA=;
        b=DeeInblYehK96jBMO3XTQUdyzYaeEVHMZgQIndRYrUd9D1cOKxD8eTfnqmgOSgcWy6
         hitcxSyOWzAU8UsMCUrjhnTI7MRbGSyXY690citOC32HcgrbvpSF5TcgLApM7Cc8CGIx
         SJCkuTpkpVX5wAE6kht0Q+nou/kd5HugDoIUXHr59eCA16ydTVoQ/cjxSjPZ7KIsrgGi
         CPNWtPYU+XGPiIrUdQyYcumIPK8ai++jlqHQIhkqPXF9+HPAZT0jODNb9EW6lShGkCun
         auq/F5854ub9jzRFf+PRksDCB06DskHTntI609gpESvV2yCam3ieYSRYrzkKzpHOeVjZ
         6W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2qNIAYunawQIOohUStC2uepdglhwjwNOkwTkSmuqwA=;
        b=mbeZmLUWb+5I/oZnrk4baDLETbbF/sztzoXr7hTB94SG1FABB48qDNb764mTObVtPv
         OqO68LrWBohmPcd5u6FShNuenep51OodQAqsZU+JAwFjyjgpo5nwxx2M/DhyPqc4GnsT
         vgD2c6pY39HG5PzBgmvlF83oZl14H+Ysaga2cKqkmvWRW2Tpqnq/JM9ou4iOqUBNmobE
         dz5VaxSEuEVOfztTjBK1UQPvDUbSaW7O8FWtJaufDWw9NBc8KBWR8JsUpl/OpLZE2K7C
         zgRzczrW15gEHo0zqHP7k1zzdXv/XbGOaPpuUyMiIy0824WyYbtEm3YLAg/TG2jckhQq
         Mb1g==
X-Gm-Message-State: APjAAAWpSsFpe/QFUrnCygs7HU+4ZArmxfJhf/eeBF6bssVfCN6JlnXT
        nmJF/2W4M5N4zMn0IdIhPmSiIaexBKffZAOc4j8Mtw==
X-Google-Smtp-Source: APXvYqyZHRObC1IQXBl7JWeBwdhhIJvZKAUPMDYyGOaNWtOTh51kTOUJLNL2kGv1V4wKcLNIT7kbgrPtItAfztGuAbs=
X-Received: by 2002:aca:5106:: with SMTP id f6mr18146549oib.69.1563303326562;
 Tue, 16 Jul 2019 11:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190625213337.157525-1-saravanak@google.com> <20190625213337.157525-2-saravanak@google.com>
 <e7a5b387-fa85-15a8-8d79-fbc441c36293@codeaurora.org>
In-Reply-To: <e7a5b387-fa85-15a8-8d79-fbc441c36293@codeaurora.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 16 Jul 2019 11:54:50 -0700
Message-ID: <CAGETcx_LLj0Kd_1STijmPm+BbOK4UoY=qQ5Ruhjei3JCoOGhFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] OPP: Allow required-opps even if the device
 doesn't have power-domains
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:18 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Hey Saravana,
> Thanks for taking time to post out this series.
>
> On 6/26/19 3:03 AM, Saravana Kannan wrote:
> > A Device-A can have a (minimum) performance requirement on another
> > Device-B to be able to function correctly. This performance requirement
> > on Device-B can also change based on the current performance level of
> > Device-A.
> >
> > The existing required-opps feature fits well to describe this need. So,
> > instead of limiting required-opps to point to only PM-domain devices,
> > allow it to point to any device.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >   drivers/opp/core.c |  2 +-
> >   drivers/opp/of.c   | 14 --------------
> >   2 files changed, 1 insertion(+), 15 deletions(-)
> >
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index 0e7703fe733f..74c7bdc6f463 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -710,7 +710,7 @@ static int _set_required_opps(struct device *dev,
> >               return 0;
> >
> >       /* Single genpd case */
> > -     if (!genpd_virt_devs) {
> > +     if (!genpd_virt_devs && required_opp_tables[0]->is_genpd) {
> https://patchwork.kernel.org/patch/10940671/
> This was already removed as a part of ^^ and is in linux-next.

Thanks for the heads up.

>
> >               pstate = opp->required_opps[0]->pstate;
> >               ret = dev_pm_genpd_set_performance_state(dev, pstate);
> >               if (ret) {
> > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > index c10c782d15aa..7c8336e94aff 100644
> > --- a/drivers/opp/of.c
> > +++ b/drivers/opp/of.c
> > @@ -195,9 +195,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
> >        */
> >       count_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
> >                                             "#power-domain-cells");
> > -     if (!count_pd)
> > -             goto put_np;
> > -
> >       if (count_pd > 1) {
> >               genpd_virt_devs = kcalloc(count, sizeof(*genpd_virt_devs),
> >                                       GFP_KERNEL);
> > @@ -226,17 +223,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
> >
> >               if (IS_ERR(required_opp_tables[i]))
> >                       goto free_required_tables;
> > -
> > -             /*
> > -              * We only support genpd's OPPs in the "required-opps" for now,
> > -              * as we don't know how much about other cases. Error out if the
> > -              * required OPP doesn't belong to a genpd.
> > -              */
> > -             if (!required_opp_tables[i]->is_genpd) {
> > -                     dev_err(dev, "required-opp doesn't belong to genpd: %pOF\n",
> > -                             required_np);
> > -                     goto free_required_tables;
> > -             }
>
> I expect the series to not work as is in its current state since I
> see a circular dependency here. The required-opp tables of the parent
> devfreq won't be populated until we add the opp-table of the child
> devfreq node while the child devfreq using passive governor would
> return -EPROBE_DEFER until the parent devfreq probes.

I looked into this when I wrote the patches. I thought I handled it
correctly. Let me take another look.

-Saravana

> The same applies to this patch -> https://patchwork.kernel.org/patch
> /11046147/ I posted out based on your series. So we would probably have
> to address the dependency here.
>
> >       }
> >
> >       goto put_np;
> >
>
> --
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
