Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A04C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1446B2190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rSsfQjeJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390574AbfGYFWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:22:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34646 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390562AbfGYFWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:22:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so22944345plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 22:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/xZxGXc0Ivxqr92bf1BipffjFV4zTI0LPpEMDctA4sg=;
        b=rSsfQjeJREPnV1Zd0y8XVUwIPaLW1Mk6hoim+fB9ibMquuACj+uIFH7x/+VzUt7CrZ
         2HDtB9T4fLvxla0hXbinFc02wCSXsdSPMKZl3kvALhMtFnskG7Q2pOeZIgEQG0EcRJcO
         W4TPnwHjb9Z6z4YqYfry9+yDoNPMkTOVJPuamGW/LGaddBvDctGgZ9Y28ozdwu98yWLv
         bL4ul3ZDkofYEDajqCyMmSUP0aNFNZtV7tVcBvh4JCElexCsucFGb4YJqcpEFBkqoBsN
         shJ5FfukcfpaHy05XzzxmqamcvmTPcP0/jphlSUIZBOlbzVzVqP8yGwyRfEznpWcfo9l
         obnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/xZxGXc0Ivxqr92bf1BipffjFV4zTI0LPpEMDctA4sg=;
        b=B3/fL3531OfEGaEYtnnOQcolkfL1vKd0ntpVWKnEdjwBdhQyoSuXHc2ubz0w81wy7r
         ZeUlrS+nn3Qto+DPOFR87efSDnoPEXFMd6Q6cRl2rMicH02U0jjeiyfZOu/VMiJvwzEM
         fXvTvOjNh1oOgznvjpayzgaveft98Ygr3Mq4vkk5WVA72lN7ZUeLR2xJMNJd9MMtUdP6
         fJmpazWjFRPhcZqihUBS3WGziiwlDusH/WPL5iHcX51ONkH8ta4s/os/I2TxGN0aihV1
         LZQQAUnHNWxq4qqWE/rLHgxUQC0PJbLkEXdhbqXpavUh0ulu3pKlvG50ibm++jQjkXXA
         K9mQ==
X-Gm-Message-State: APjAAAWFwsC43oXmwg1OFolpAJZsY9MJeYi5HVRczuVyCZEo+RvF5X1o
        d33VLDisCSg5f1Kx9Zj8K4570Q==
X-Google-Smtp-Source: APXvYqzsumr0UqkwlGeOG7n6Wk6nxVjmT7yfiqwz9Ib4PjshFHVHMFgbschdLdFDiNL9McSo8p6NTg==
X-Received: by 2002:a17:902:2ac8:: with SMTP id j66mr85115769plb.273.1564032152747;
        Wed, 24 Jul 2019 22:22:32 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id u134sm45825640pfc.19.2019.07.24.22.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 22:22:31 -0700 (PDT)
Date:   Thu, 25 Jul 2019 10:52:29 +0530
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
Subject: Re: [PATCH v4 0/5] Add required-opps support to devfreq passive gov
Message-ID: <20190725052229.znf6asnvl44rjqxg@vireshk-i7>
References: <20190724014222.110767-1-saravanak@google.com>
 <20190725023050.7ggjbwsthoxpkexv@vireshk-i7>
 <CAGETcx_ZHXkjZMBhO8YTW2fMyVqmsj8f9F8d6oJTn=NmRL1q=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_ZHXkjZMBhO8YTW2fMyVqmsj8f9F8d6oJTn=NmRL1q=A@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-07-19, 20:40, Saravana Kannan wrote:
> On Wed, Jul 24, 2019 at 7:30 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 23-07-19, 18:42, Saravana Kannan wrote:
> > > The devfreq passive governor scales the frequency of a "child" device based
> > > on the current frequency of a "parent" device (not parent/child in the
> > > sense of device hierarchy). As of today, the passive governor requires one
> > > of the following to work correctly:
> > > 1. The parent and child device have the same number of frequencies
> > > 2. The child device driver passes a mapping function to translate from
> > >    parent frequency to child frequency.
> >
> > > v3 -> v4:
> > > - Fixed documentation comments
> > > - Fixed order of functions in .h file
> > > - Renamed the new xlate API
> > > - Caused _set_required_opps() to fail if all required opps tables aren't
> > >   linked.
> >
> > We are already in the middle of a discussion for your previous version
> > and I haven't said yet that I am happy with what you suggested just 2
> > days back. Why send another version so soon ?
> 
> I wanted you to see how I addressed your comments.

Sure, but that is just half the comments.

> It didn't look like
> you were going to make more comments on the code.

I posted some queries and you posted your opinions on them. Now
shouldn't I get a chance to reply again to see if I agree with your
replies or if we can settle to something else ? I only got one day in
between where I was busy with other stuff and so couldn't come back to
it. Please wait a little longer specially when the comments aren't
minor in nature.

Anyway, lets get over it now. Lets continue our discussion on V3 and
then we can have a V5 :)

Have a good day Saravana.

-- 
viresh
