Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE88CC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79CF2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PXycLjrh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfFSOSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:18:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43446 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfFSOSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:18:06 -0400
Received: by mail-pl1-f194.google.com with SMTP id cl9so7293058plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mlNb/IaItSyqkmca1yT8QCZfXO867q6hvVBmX/nB+c4=;
        b=PXycLjrhAM+mZu18Pk5r0Od9xKOFKkduE9WzkYHJ+odD7+1IRtjO4DeJCKBNBl3JHx
         MyFgo7eGQcG0sQ1v7ihSGKKMlr8obsid9FYzfjVsDrlyC9sf4IZ+z+eY2SiGxKvVZ7WC
         dn7L00CNezvaaSwh2MnzUqCs079oy4zciUBqKvkppkuLpfvyyYYdLePxiQqBvmlC9ZSJ
         8PS96NAHVgpfyrqt7VqB+pZB9SuCEkLSPIE57z4760HJYsp3EL/p+LV5jD8IabQex6Yy
         Wch6Es7GeVkfWy+smOE9y8t1vr7gUItR7MyOzKJr73c//uQhEmvYEvKHyyhhyMPMozJb
         /qkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mlNb/IaItSyqkmca1yT8QCZfXO867q6hvVBmX/nB+c4=;
        b=ao/dZpSuRXhDwSPLVrsDtOEr+NVT8dJhQZnfCD5dOCAV5yJZyG/8BwGs+ZF9jfyVgR
         tPWGfdqAqaqVs7X8DFpPjDOEdMwCqbstPwaFv0btJNP5D5zRnsuI98trb2YnjFK5/Kei
         ERFHaSNQ0eAzigKxm88XYP2NCf3IeDQf+0tkgS6Im+Sy44wZQNy+3TouygCCHpIJ/iHu
         1yt/SCsJcXLUAzMIpXjwxYvoESpCq+K+8K9Xz1Szuz+BwfPLtShTeVkRhFigtEN5aj4t
         h2rmPgfE8Ak1R2kBFybK1qvQBtA7rB/IEIJgwZbY5xPtbZfrVFpIL3LEB1VyQ5B5U9t0
         hv0w==
X-Gm-Message-State: APjAAAU9q1xoGDwZra67nnZ4zksGsxcIPJeP4dWK04c/0MvJHchBQmny
        meo+PN3fjU1fuawRUbiKBqoH4g==
X-Google-Smtp-Source: APXvYqzFqF0kPamb4VkHuPaXiQxrSC5szQYQtdITcGzbILhiG/SpxFzTNoiwSg0DTPW+Cc7LtHv3Kw==
X-Received: by 2002:a17:902:42a5:: with SMTP id h34mr83369858pld.16.1560953886202;
        Wed, 19 Jun 2019 07:18:06 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id r6sm2247795pji.0.2019.06.19.07.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:18:05 -0700 (PDT)
Date:   Wed, 19 Jun 2019 19:48:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] cpufreq: Replace few CPUFREQ_CONST_LOOPS checks with
 has_target()
Message-ID: <20190619141803.ywsod6ayhrqdreck@vireshk-i7>
References: <cover.1560944014.git.viresh.kumar@linaro.org>
 <0660b023a0d80c63ec7a1f7fcb692de9a9f4d604.1560944014.git.viresh.kumar@linaro.org>
 <CAJZ5v0g1avBwjezWpMimGbs1NHOchib9pmTKoxaixKtpw_CGJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g1avBwjezWpMimGbs1NHOchib9pmTKoxaixKtpw_CGJw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-19, 14:20, Rafael J. Wysocki wrote:
> On Wed, Jun 19, 2019 at 1:36 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 54befd775bd6..e59194c2c613 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -359,12 +359,10 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
> >                  * which is not equal to what the cpufreq core thinks is
> >                  * "old frequency".
> >                  */
> > -               if (!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
> > -                       if (policy->cur && (policy->cur != freqs->old)) {
> > -                               pr_debug("Warning: CPU frequency is %u, cpufreq assumed %u kHz\n",
> > -                                        freqs->old, policy->cur);
> > -                               freqs->old = policy->cur;
> > -                       }
> > +               if (has_target() && policy->cur && policy->cur != freqs->old) {
> > +                       pr_debug("Warning: CPU frequency is %u, cpufreq assumed %u kHz\n",
> > +                                freqs->old, policy->cur);
> > +                       freqs->old = policy->cur;
> 
> Is cpufreq_notify_transition() ever called if ->setpolicy drivers are in use?

I tried to find it, but I couldn't find any driver from where we can
get this called for setpolicy drivers.

-- 
viresh
