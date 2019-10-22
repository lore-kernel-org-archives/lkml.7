Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E06CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C8D20700
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivO5b5vu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbfJVKHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 06:07:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40835 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbfJVKHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 06:07:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id 15so4301082pgt.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 03:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hcL7Y1mIHrv+zJufdm/7tWW0i/5Ngmwav5YR6aEz2Qo=;
        b=ivO5b5vurvQ9LA8qtn3cHbpPoRX2yjkgwkpDqqE16TH42wJwB/6rdZXhctRQpTwQx6
         czMO6XZbFR5LH5YX3sED3ZKy4lVOZ8gG+ofEZCZC6jYUG771VczXQdj7a0pHIU921xch
         SBCzpsI3iWnHkfjRuLfKoGDjcXy+gyp5qaifnvDGYwHlb1rPeFGrk5d0NpD5ZAW3u375
         yjcFyeEzpkEZWryMfTAJa3ESs4NpHE/ez/nJKblHqDc0Wpf6QBraSlP18+ciPX2IBcnH
         8Kj7RDbw4qttl+056hF9Z4oEHQBJ5SXmnLEito4He527Qfw/auwXy1JFfgdoaynnaPb7
         FgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hcL7Y1mIHrv+zJufdm/7tWW0i/5Ngmwav5YR6aEz2Qo=;
        b=Xu5ovcu+l/E7z03e+6T49aCWsJyXrOJXWcz8oeuWSonXFNXwhDa64gxIU7sl+BFrrl
         hLahTqu8Mrjiy7fZiiuqaKXtcgmZVePquuosB+p/pJXpelZvYgICAqrJyCCypp/YG3Zy
         Ad5f52vwp6H5QCZrXURFS1anW3xs3r3gHIgScVn3wjUwlNKpbGuLLC2FeZu8cTrmwaHF
         mVFqQCRv/hfOl+q7GMlXjn3pCJz2fUiiGf79+kTwD9PULevYugEWyTQNr9nwrzODsSq1
         uUBXVD89wpb/A8cZlJOYZAzNphPd60QIi+780ez4cNLG3zTZAn8f/hwGXkjJlPavvz1d
         NSjQ==
X-Gm-Message-State: APjAAAWH7cC9brxd5HU/x3E+lI/dDxlsTu4AvI9JQbqRcC11U1MGctiK
        S3vf4jxmENWhhK8QMRNSu7msEw==
X-Google-Smtp-Source: APXvYqxRKGAwKo0zopfJjMo09GhkRf6idef1XrBcgk7k+D4HJD/XZ9UndPzm9f1Mpn9zihgU/3EKZg==
X-Received: by 2002:a63:1e1f:: with SMTP id e31mr2816686pge.303.1571738863006;
        Tue, 22 Oct 2019 03:07:43 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id h186sm22715430pfb.63.2019.10.22.03.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 03:07:39 -0700 (PDT)
Date:   Tue, 22 Oct 2019 15:37:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Move cancelling of policy update work just
 after removing notifiers
Message-ID: <20191022100736.sguepyp2t56peqfr@vireshk-i7>
References: <20191021132818.23787-1-sudeep.holla@arm.com>
 <20191022022508.g3ar735237haybxe@vireshk-i7>
 <CAJZ5v0gEbiyjpT4+RG5ytDHOgcyCHFqOgD59bK6h=Fhbqvv7Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gEbiyjpT4+RG5ytDHOgcyCHFqOgD59bK6h=Fhbqvv7Tw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-19, 11:46, Rafael J. Wysocki wrote:
> On Tue, Oct 22, 2019 at 4:25 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 21-10-19, 14:28, Sudeep Holla wrote:
> > > Commit 099967699ad9 ("cpufreq: Cancel policy update work scheduled before freeing")
> > > added cancel_work_sync(policy->update) after the frequency QoS were
> > > removed. We can cancel the work just after taking the last CPU in the
> > > policy offline and unregistering the notifiers as policy->update cannot
> > > be scheduled from anywhere at this point.
> > >
> > > However, due to other bugs, doing so still triggered the race between
> > > freeing of policy and scheduled policy update work. Now that all those
> > > issues are resolved, we can move this cancelling of any scheduled policy
> > > update work just after removing min/max notifiers.
> > >
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  drivers/cpufreq/cpufreq.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > Hi Rafael,
> > >
> > > Based on Viresh's suggestion, I am posting a patch to move this
> > > cancel_work_sync earlier though it's not a must have change.
> >
> > For me it is :)
> >
> > > I will leave it up to your preference.
> > >
> > > Regards,
> > > Sudeep
> > >
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index 829a3764df1b..48a224a6b178 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -1268,6 +1268,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
> > >       freq_qos_remove_notifier(&policy->constraints, FREQ_QOS_MIN,
> > >                                &policy->nb_min);
> > >
> > > +     /* Cancel any pending policy->update work before freeing the policy. */
> > > +     cancel_work_sync(&policy->update);
> > > +
> > >       if (policy->max_freq_req) {
> > >               /*
> > >                * CPUFREQ_CREATE_POLICY notification is sent only after
> > > @@ -1279,8 +1282,6 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
> > >       }
> > >
> > >       freq_qos_remove_request(policy->min_freq_req);
> > > -     /* Cancel any pending policy->update work before freeing the policy. */
> > > -     cancel_work_sync(&policy->update);
> > >       kfree(policy->min_freq_req);
> > >
> > >       cpufreq_policy_put_kobj(policy);
> >
> > Thanks for doing this.
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Folded into the previous patch and applied.
> 
> Please double check the result in the current linux-next branch in my tree.

I would have kept the blank line after cancel_work_sync() which isn't
there anymore.

-- 
viresh
