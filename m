Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1219EC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 03:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D1C205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 03:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QriXxRhH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgAIDhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 22:37:31 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36081 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgAIDh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 22:37:29 -0500
Received: by mail-oi1-f194.google.com with SMTP id c16so4715937oic.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 19:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EBxPdPI6aGH8o6hu5DCWy787QjzgPIZLXI5gO+WcD1Y=;
        b=QriXxRhHliJ3F/O3q0F2UmNA0QcFD7cijma9/Wt6o+qK90uPmfucUNK0n87888Y3Ke
         3aufsx2bK7ekHdLdoK4qcpIJbn1zaW7R5dXT9D7tbxC2KwIgg/F5SWxbkCpRZn23VNxI
         VYfYenU2XvlqEaadnZWM1rkSQtrCbBveapwdS5lWiBh5rTbellnWqG72eF/z3hrr5c7n
         /x8YuKYUEt0jWq0gKzxLSniEMZi4/A16mjHl8/j4hu+L7eSeLXr3e8xTWP6dHmGeurQg
         sTo9pbNc2bfNfN7pBwDkbCoywkC+LzWeOz+aIAbkYKK4DYiXEzke9wl26C6FNRT47X9z
         PmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EBxPdPI6aGH8o6hu5DCWy787QjzgPIZLXI5gO+WcD1Y=;
        b=iB2FwgyV0HmbgQzq2Y1tasg+NGfdJIKoV12M3XoS47ZPW4X+gbK6ZFk/R92j07bWuu
         2mjsExxO7PCuH7DYI2gq5+hmcQGFc7gRL0Y8W/6qYGa3kAitBvV/L1Li3XKo9a9w9QOo
         ScM8NpdFal3rUkV8yCFXwS6IN6B3PYDYU7HN60O1INHfPxSQgFqncVGpOc8ng2ghcISs
         l7ovVgveEiXQScU8N/p3HEPWmRJfInQupgJh/PeiPNzmIKJgVNjsAV03Nbkd8gKVkQ5/
         DVPsZ+s4TJsS8iV8SwLnZtCQ52VlFRjigdpe7ao6lr5u5JHSrXp9xD3jcqEAqqBxff9L
         8g2A==
X-Gm-Message-State: APjAAAW0HYFmPqMLMwBYR7g3fTtVnR2FsSrlnU+IydzIwnZ5cOpxg2x+
        oPCMgJmDgtXwKiU3sonvHF4HpTW1MoRfC60VyE+xJw==
X-Google-Smtp-Source: APXvYqx3Uob/RWYjP3Mq5nseaUALTA1i4stN0ZiBAI3/wbVgdUWsj38KXuEm4Va+vnVVWxZ1CTr9+sKRSuUfGnQT+hg=
X-Received: by 2002:aca:5490:: with SMTP id i138mr1579922oib.69.1578541048669;
 Wed, 08 Jan 2020 19:37:28 -0800 (PST)
MIME-Version: 1.0
References: <20191207002424.201796-1-saravanak@google.com> <20191207002424.201796-4-saravanak@google.com>
 <20200108111947.q5aafrlz26tnk3nq@vireshk-i7> <CAGETcx_T7VONkSd-r9CY-5OpZBZ2iD0tFoCf0+d8CY2b5zgr9g@mail.gmail.com>
In-Reply-To: <CAGETcx_T7VONkSd-r9CY-5OpZBZ2iD0tFoCf0+d8CY2b5zgr9g@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 8 Jan 2020 19:36:52 -0800
Message-ID: <CAGETcx8cro3FHqZhbia6ZUy41XGHwMMSTZgX7QN_2wToWa-Yww@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] OPP: Add helper function for bandwidth OPP tables
To:     Viresh Kumar <viresh.kumar@linaro.org>
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

On Wed, Jan 8, 2020 at 4:58 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Wed, Jan 8, 2020 at 3:19 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 06-12-19, 16:24, Saravana Kannan wrote:
> > > The frequency OPP tables have helper functions to search for entries in the
> > > table based on frequency and get the frequency values for a given (or
> > > suspend) OPP entry.
> > >
> > > Add similar helper functions for bandwidth OPP tables to search for entries
> > > in the table based on peak bandwidth and to get the peak and average
> > > bandwidth for a given (or suspend) OPP entry.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/opp/core.c     | 301 +++++++++++++++++++++++++++++++++++------
> > >  include/linux/pm_opp.h |  43 ++++++
> > >  2 files changed, 305 insertions(+), 39 deletions(-)
> > >
> > > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > > index c79bbfac7289..3ff33a08198e 100644
> > > --- a/drivers/opp/core.c
> > > +++ b/drivers/opp/core.c
> > > @@ -127,6 +127,29 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
> > >  }
> > >  EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
> > >
> > > +/**
> > > + * dev_pm_opp_get_bw() - Gets the bandwidth corresponding to an available opp
> > > + * @opp:     opp for which peak bandwidth has to be returned for
> >
> > s/peak //
>
> Ack

Actually, isn't this correct as is? peak bandwidth is "returned".
Average bandwidth is updated through the pointer.

-Saravana
