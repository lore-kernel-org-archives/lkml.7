Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883ACC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCB72071C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r2iF6ONz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfKRN5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:57:21 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39780 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfKRN5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 08:57:20 -0500
Received: by mail-lf1-f66.google.com with SMTP id f18so1551306lfj.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 05:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8MT+fGXZDS22JKWSNFBQJuUc1lDOVJUPNg1CD91zNsE=;
        b=r2iF6ONzWZUMA5fsf4vvaji1G06AUx6vdAeR1Wrvf7jngpPilm5yKIjrGPlVR1xhYJ
         F3gcRT+3CsioJ4nPuvY2fiGfNq7p+gf1l03ydpVUy/CRaK4X3BF/DEzSKulsKU7XfD6h
         B+LGcDsP0UyNjQgxDqxPW8YoiV+9wj87LlTD7VsuHgfCnOJBaC10VBoOFqfdvdiG3tOo
         TMWr1rI3DdrTTo+aBS0Y6HUK6k3sed4GxtGoAH4b1ClA50HiCQgrLInl6jl0wPy0JSF5
         BOlbQG2WT2M0Q8sfyut76dHCPXshwgXLuh3O6BizVZYW3SXtH5Ledl32Tw8/Fr2EDKKF
         zjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8MT+fGXZDS22JKWSNFBQJuUc1lDOVJUPNg1CD91zNsE=;
        b=I7bwIl3wJdWzXxRGPZFmKRiqsjoa46XcVU+Cxoy9JA1GroVY0kkLoHrheaHk7MHLq+
         3JUNFYjKrLogzHv9eJRIkcl6rqmeIMzb+GUOC8bMEzkVokYqL0U6ivRrvL86mYSMDSzV
         PwYCOmiKIvl+RT5vJcX0UO8Q8olbbiJ6VUMoJlL04ERlGQwUOxROM/ne5g12XmhzAAVw
         9cb4Rnd+kFtIcC6Y6Oht5QNu/03bBpxAJduwvo4DzstZ9RWRXy446n9/z8u8BzWRfZlp
         B1/shTCXk7CGUP4MhJxkiqedyrUc/UktLTuAi5mNXex+4UaIuIVP1y27nOLcDvpBWTlE
         7T0A==
X-Gm-Message-State: APjAAAWs+typ1fTS1eAE3BBqhe2Fh2w2T1i5XNIgvzA+q+dfhuuh6MV+
        PQjvxArHu/blXodcMobPVfshXlrQ1uRmUu2c5harcQ==
X-Google-Smtp-Source: APXvYqz32WSaaBKP/r0Kr7UU0fzt4JTqsNqb325mUM0kz+ngmPcT6OE5A+BLER8NKPslbFxXe+Ue872Gsm6I6GWuwZg=
X-Received: by 2002:a19:c144:: with SMTP id r65mr4185943lff.133.1574085437090;
 Mon, 18 Nov 2019 05:57:17 -0800 (PST)
MIME-Version: 1.0
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-5-git-send-email-vincent.guittot@linaro.org>
 <20191030154534.GJ3016@techsingularity.net> <20191118135017.GA123637@gmail.com>
In-Reply-To: <20191118135017.GA123637@gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 18 Nov 2019 14:57:05 +0100
Message-ID: <CAKfTPtC-782+HYt9L4CMKpuYJ04XQjBO-v_KEUNikofD8n_0Aw@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] sched/fair: rework load_balance
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2019 at 14:50, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Mel Gorman <mgorman@techsingularity.net> wrote:
>
> > s/groupe_type/group_type/
> >
> > >  enum group_type {
> > > -   group_other = 0,
> > > +   group_has_spare = 0,
> > > +   group_fully_busy,
> > >     group_misfit_task,
> > > +   group_asym_packing,
> > >     group_imbalanced,
> > > -   group_overloaded,
> > > +   group_overloaded
> > > +};
> > > +
> >
> > While not your fault, it would be nice to comment on the meaning of each
> > group type. From a glance, it's not obvious to me why a misfit task should
> > be a high priority to move a task than a fully_busy (but not overloaded)
> > group given that moving the misfit task might make a group overloaded.
>
> This part of your feedback should now be addressed in the scheduler tree
> via:
>
>   a9723389cc75: sched/fair: Add comments for group_type and balancing at SD_NUMA level
>
> > > +enum migration_type {
> > > +   migrate_load = 0,
> > > +   migrate_util,
> > > +   migrate_task,
> > > +   migrate_misfit
> > >  };
> > >
> >
> > Could do with a comment explaining what migration_type is for because
> > the name is unhelpful. I *think* at a glance it's related to what sort
> > of imbalance is being addressed which is partially addressed by the
> > group_type. That understanding may change as I continue reading the series
> > but now I have to figure it out which means it'll be forgotten again in
> > 6 months.
>
> Agreed. Vincent, is any patch brewing here, or should I take a stab?
>

No I haven't patch under preparation for this
So you can go ahead

Thanks,
Vincent

> Thanks,
>
>         Ingo
