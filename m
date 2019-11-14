Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55305C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33807206EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZEM9ymYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfKNIfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:35:40 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41014 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfKNIfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:35:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id p26so3684327pfq.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 00:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KOPAYD9rJ6T5pXowo644iwloHMGuospHdAqm9/FhUfU=;
        b=ZEM9ymYYdqKln15E8v8hbV9aygf3SvvymQ34CWF9ygNTgcB0lOMI2IT1VNECXK44Te
         a+oepcNzzYZ+OzohIZwuIQwjyXdvxTWCs/DqnrF9EboHYR1XWBNUIa6wpa4km3xEkYmb
         qZ4F8m5+SuBvi0YR1PMUmF6YJhFs1NM/LMa5Zl66E6pXppfOjCpXpQFTInqGmLYmchHi
         gvi/Wp6w7Msxo5YFs7C29nOL2U1iacRKO2GZSTYVZb73sD8ph/prgsS5XG7WNRLC4mcz
         VvoAAwQEOaDnTNoBRWbr0RxXog1QIIHv9LocZ+GnceEH+zfG6JbNgGMANgTsZJwpLyJ2
         Ut0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KOPAYD9rJ6T5pXowo644iwloHMGuospHdAqm9/FhUfU=;
        b=puyxehPn975Is1BfbBpA/gLpzLEstmhsAY8doqeZ0nV0X7T0S+VYVBPykTKfH7nTNr
         dQwRYnTrp/7dDYJF0VCUQEVutc/+ZzQz6cHI3nb6NpjaJZxdEvKCsJe1REZALv0wwIsL
         NJhXZ2sixgOUVWpmY0gDTh2L9TERltH6yVGhXHUw47C4CN/Vs3n5G0ClJY5W4zuR0gn7
         JvZEC1fBjaf4pZM90kkw8sJ4hsx3PE0h5FX6NFNGPSMrYqEep7u0hPsl1cEFae10o+ko
         6BuhAE52Rtm/BTfhw966wQCkCVXANjorePv5jMKFbqryQdpXvlJDiLfjkPOXQTNX7otf
         ZYrw==
X-Gm-Message-State: APjAAAWRhLHuEcXCJdQvPfR1+TMgI5t/40VpsPzO3rnxaAQzf82iZy6+
        iOj/oGuH/ZMnVzvoppb3yfql6A==
X-Google-Smtp-Source: APXvYqxmTxGM1IiN6OpVPLDDiyX0bI0q7LyUQz8F+gfxxG+OF6nAmsTALDimy2OtdnFJxBcT0tJexA==
X-Received: by 2002:a63:25c7:: with SMTP id l190mr8889490pgl.429.1573720538574;
        Thu, 14 Nov 2019 00:35:38 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id o15sm9773835pgf.2.2019.11.14.00.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 00:35:37 -0800 (PST)
Date:   Thu, 14 Nov 2019 14:05:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/5] Add required-opps support to devfreq passive gov
Message-ID: <20191114083532.vmccmqgj2uj73tcn@vireshk-i7>
References: <CGME20190724014230epcas5p371a5fdee330f91a646d619fbcc024acf@epcas5p3.samsung.com>
 <20190724014222.110767-1-saravanak@google.com>
 <cb0d4aad-81e4-0b8d-40f2-7f58ef1e38d9@samsung.com>
 <CAGETcx-tUtnX0T47YGdf7-cgp6e8K9Rgb34Mfe5Za9L4YMGS1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-tUtnX0T47YGdf7-cgp6e8K9Rgb34Mfe5Za9L4YMGS1g@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-11-19, 00:23, Saravana Kannan wrote:
> Thanks for checking. I haven't abandoned this patch series. This patch
> series depends on "lazy linking" of required-opps to avoid a cyclic
> dependency between devfreq and OPP table population. But Viresh wasn't
> happy with my implementation of the lazy liking for reasonable
> reasons.
> 
> I had a chat with Viresh during one of the several conferences that I
> met him at. To fix the lazy linking in the way he wanted it meant we
> had to fix other issues in the OPP framework that arise when OPP
> tables are shared in DT but not in memory. So he was kind enough to
> sign up to add lazy linking support to OPPs so that I won't have to do
> it. So, I'm waiting on that. So once that's added, I should be able to
> drop a few patches in this series, do some minor updates and then this
> will be good to go.

I am fixing few other issues in OPP core right now and lazy linking
is next in the list :)

-- 
viresh
