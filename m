Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D452CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 05:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F0C2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 05:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="unyYhVkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389626AbfJWFaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 01:30:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43768 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731374AbfJWFaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 01:30:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id l24so6492585pgh.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 22:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2rDF05/6n06417wlJVscVUcvibGyzQU00P9mXQIXKPI=;
        b=unyYhVkChYE/uDac0HDbcWN0G8GoHP0zxWY0fxtb/LUoGEbwhJnX7Hq4/MHWxVy0GI
         55H5/ynS1xRqnl675xUK6TOKQbmqdwH403PiCwfecCtzIWLiuQ0Hih64KGKiQcs1moN4
         rmaSUaxUfu1MBS/4nKdguaTTHWlr/AE2gAnOFCZoCY+k2yxizr5uv3QofF1JssrjF177
         g0msVuAH6XdCkxKodaYqaow5W6ZPZTpLu3b1pJ8yn7bKa19VfzWEM/XHUj7yb7uI99f8
         kJFdIJIE2CC7nT7/TqQGv0aN1DbEeoFYAwp9A9K9g8BBGzMVTNqZKZT6sIMOoi6GS7dE
         kD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2rDF05/6n06417wlJVscVUcvibGyzQU00P9mXQIXKPI=;
        b=WTxe7CxR94OsfOUcb621EQ4mkNisLrZNWSkPna85sWmUwj7sDDJYxRF/p6Oj0xi4bi
         YZs9MLMz3YXq9CLoW9EZgdJt2p8c78Qw9PNjGHqP2imzcpznV5BaiHBWp0dgyE+xICV3
         uRHD0Ew5B9wwBmBhlk6vt5lJJDJkV45lh9gxUq9Z9ycpY4ubUr/TL70Jc0HHJ41cFnZe
         YgB+PFZx0ZJXr1Hw1RXcQgeA4KaaN9ZRbirAweT06QeLHm4/HR1EP+qd30VOtBd6ja4f
         x6OkBRIqtM+zVerDPCtWjKs1J96F3Nh49LS4O8QNS87QCePWiJgDUcK+7GQsA8/4PGHA
         X4IA==
X-Gm-Message-State: APjAAAV2lu+GszTfotncgajQbHlwRy6kJY41yjK1D9HLsr24xlMiIUKR
        eUsTZCB99Pg7Sz2GXGu0TKN+IQ==
X-Google-Smtp-Source: APXvYqxRwNayP0aERsMuW4AmJWpia1ARqwMiw0nTvlpYpmTN1wiwajanp5beDtUvou4COtPyjAqQnw==
X-Received: by 2002:a63:d450:: with SMTP id i16mr7822345pgj.126.1571808608951;
        Tue, 22 Oct 2019 22:30:08 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id v1sm20270144pjd.22.2019.10.22.22.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 22:30:07 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:00:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        "v5 . 0+" <stable@vger.kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: of: drop incorrect lockdep_assert_held()
Message-ID: <20191023053005.m4y4bcebgi4km35q@vireshk-i7>
References: <6306e18beab9deff6ee6b32f489390908495fe14.1570703431.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6306e18beab9deff6ee6b32f489390908495fe14.1570703431.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-10-19, 16:00, Viresh Kumar wrote:
> _find_opp_of_np() doesn't traverse the list of OPP tables but instead
> just the entries within an OPP table and so only requires to lock the
> OPP table itself.
> 
> The lockdep_assert_held() was added there by mistake and isn't really
> required.
> 
> Fixes: 5d6d106fa455 ("OPP: Populate required opp tables from "required-opps" property")
> Cc: v5.0+ <stable@vger.kernel.org> # v5.0+
> Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/of.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 1813f5ad5fa2..6dc41faf74b5 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -77,8 +77,6 @@ static struct dev_pm_opp *_find_opp_of_np(struct opp_table *opp_table,
>  {
>  	struct dev_pm_opp *opp;
>  
> -	lockdep_assert_held(&opp_table_lock);
> -
>  	mutex_lock(&opp_table->lock);
>  
>  	list_for_each_entry(opp, &opp_table->opp_list, node) {

@Niklas, any inputs from your side  here would be appreciated :)

-- 
viresh
