Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D80C76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9025D20693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kkXFYQ4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388311AbfGPTM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 15:12:57 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41025 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPTM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:12:57 -0400
Received: by mail-oi1-f196.google.com with SMTP id g7so16472409oia.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 12:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EokRdVtnqINNMeRei8g3SJejrlpwhuP/sBz4PdO769o=;
        b=kkXFYQ4BGd2rPaOJss3nxEly+aTRCXPtLhXjo2jX0eHJ0gYk/NfDhYxZt2dbZDt7V/
         Ht9777mnN/JK5uMBe+N50bVXOZEgNz70p1lOWFa86DgeLODas1wW/TEAgBZ+10rmXVg7
         Wl/NA9vC9K+q6hvr5XobK72vptUqBgmytGGAd428TKu6DfFHTGZayCL78o9cxwCMcMZf
         KlCGJ1JfJ09UmfweNDAr/6G8rs5OsBrYixKRVgQE6fURLsnUsOOcZ3iNAIAdA6EnsXeL
         /QkLWj8uHiKK+O5D8RMtOmWM36Sm6GFsXhUA4HhPQWKV57lR6L3ki6Dt26//2+TGwB1i
         g6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EokRdVtnqINNMeRei8g3SJejrlpwhuP/sBz4PdO769o=;
        b=KOz5RxwWkvXIBuKylTLMgf5DYObG3sZ5trWrmz1iF1Ek1ze6cV1Jun8OUV9tjJQqzN
         4Xev09ie2CJkyJVWXrkwi/LPcJngvM96q+s6et5SAjPyob9enlMZIRRyl7LZFgJV7ahH
         9ZcShz+5+hhlUpl3hMm0nbmtYlJGvZQ674Bna8XZ/JlEe5qnZh1WgNYM6nMAFvLdae5C
         UvXBt/XJDcXRKXxjQcj3TOfssCFiGi9WuVvk+MOt608z7ra8x1gN4N2Uk47++5WfL7GI
         u+GebFGPIkhMpAiY8eitGqBnoXYyU4fHgmyNer7YInW6VuXRC/DbMBLkS7MkD2s4Pm5x
         ySOw==
X-Gm-Message-State: APjAAAWgooBpz0HcdnfFQ2Gro4tMZcGQ5F6VTU8cToP88PxQOAncVbVW
        mhR8xz8iYLPPl51cCdtbOx3z+6LcKoTKbYd7VHyCfw==
X-Google-Smtp-Source: APXvYqzvI0Zhyn3SPjXH+FWy4nFoerSYx7E3aeJUm3+PDLU+ilI3ejmzk8U7vgvbRvDquPXrT1qJZqgYVUwbzn5z0iI=
X-Received: by 2002:aca:e641:: with SMTP id d62mr17288062oih.24.1563304376244;
 Tue, 16 Jul 2019 12:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190625213337.157525-1-saravanak@google.com> <20190625213337.157525-4-saravanak@google.com>
 <e9c9b150-43a6-dc6b-5d88-21608120e940@codeaurora.org>
In-Reply-To: <e9c9b150-43a6-dc6b-5d88-21608120e940@codeaurora.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 16 Jul 2019 12:12:20 -0700
Message-ID: <CAGETcx8K3Z65Ru6dytbaJUm3xfWT8RxjKy788BAmksxS50YZqw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] PM / devfreq: Cache OPP table reference in devfreq
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, adharmap@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:36 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Hey Saravana,
>
> On 6/26/19 3:03 AM, Saravana Kannan wrote:
> > The OPP table can be used often in devfreq. Trying to get it each time can
> > be expensive, so cache it in the devfreq struct.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >   drivers/devfreq/devfreq.c | 6 ++++++
> >   include/linux/devfreq.h   | 1 +
> >   2 files changed, 7 insertions(+)
> >
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 6b6991f0e873..ac62b78dc035 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -597,6 +597,8 @@ static void devfreq_dev_release(struct device *dev)
> >       if (devfreq->profile->exit)
> >               devfreq->profile->exit(devfreq->dev.parent);
> >
> > +     if (devfreq->opp_table)
> > +             dev_pm_opp_put_opp_table(devfreq->opp_table);
> >       mutex_destroy(&devfreq->lock);
> >       kfree(devfreq);
> >   }
> > @@ -677,6 +679,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
> >       devfreq->max_freq = devfreq->scaling_max_freq;
> >
> >       devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
> > +     devfreq->opp_table = dev_pm_opp_get_opp_table(dev);
> > +     if (IS_ERR(devfreq->opp_table))
> > +             devfreq->opp_table = NULL;
> > +
> >       atomic_set(&devfreq->suspend_count, 0);
> >
> >       dev_set_name(&devfreq->dev, "devfreq%d",
> > diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> > index fbffa74bfc1b..0d877c9513d7 100644
> > --- a/include/linux/devfreq.h
> > +++ b/include/linux/devfreq.h
> > @@ -156,6 +156,7 @@ struct devfreq {
> >       struct devfreq_dev_profile *profile;
> >       const struct devfreq_governor *governor;
> >       char governor_name[DEVFREQ_NAME_LEN];
> > +     struct opp_table *opp_table;
>
> please add it to the function docs as well

Will do.

-Saravana
