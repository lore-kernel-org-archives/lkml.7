Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A60BC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 03:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24205206DE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 03:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JlDu4etb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403901AbfIFDEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 23:04:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45160 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388215AbfIFDEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 23:04:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id 4so2598378pgm.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 20:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3PTG9G99Umh/O+x7zai5y5HPdUR0mgJht59Vfjck7XQ=;
        b=JlDu4etbqmzw9wXT6FGlXJk4Kybmbh1/HwtZgLtvcc8JacahcRVrky+j2sG5rrZxqY
         ZuWEB7PpdtHHvjpRMr9Hpl8sE7EzzL40ASpLyvsnzjPjtGh9HtWndBXBMMuumMHcmkrj
         y0KB+73vEvTTP5yitiPrGNYRZ60cWlRbfyRqtgeV+0z91OL/2fNXYQCJC3JQpljqLY8T
         oRH7HWg5t/sLhnSxhen5EAdICh6nkloegeVwQg5oNeNOAmzqH9Mug+z3YdIUyu6ad2/f
         5CY1Fjq+vCZAP0hF0/29kPAvJgzAfXzscrMSgkKJo7qZK8vvAqDL5FuHlDH1/wHA8kp2
         EPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3PTG9G99Umh/O+x7zai5y5HPdUR0mgJht59Vfjck7XQ=;
        b=FBZeAkveO3w/GO6EqH3Mi7pJOYsa++tSDQLBEaxE3SOwSt7fz2daS/YhLOdhXpNhzN
         Biusl51pNKHV3HTvWBrwgAwa9SEdg0tzZe/d0N2AGGN69JPU4wp0SfACNDzjdBdahmZK
         o0J3J/t0yFEiISX3sMX0YPsRjNgbdp9NP7BLx+B5t2FKWRr4/mDnMM6UV4RsVvvVotpA
         wdh266LFFewkveBJop75OJcmOaRbs0LogV1lt6YBhaGcRkGKCJawDaG5o4KCnWFehlBt
         yysAE99m4j7bGY3V6Ah94mGoNy9yTku2DkcogD96a7CzrS1gyVJywbs3mvORr2LHvnwY
         GD4w==
X-Gm-Message-State: APjAAAVAcUZIQ4kR2obBT0nEk0ON+wCZIHNHrvgmS2OVxyDhgRj5JweA
        0NTbQ0u8/a9HW71/1JkH4r/Rpw==
X-Google-Smtp-Source: APXvYqwcU7P4KYdNJHTHBUa+PS5plDHub2NwjRt0YWUkZiqMjDWKH6/fIdJ8dd+tt9qVDv5mRdVbYw==
X-Received: by 2002:a65:5cca:: with SMTP id b10mr6247565pgt.365.1567739086676;
        Thu, 05 Sep 2019 20:04:46 -0700 (PDT)
Received: from localhost ([122.167.132.221])
        by smtp.gmail.com with ESMTPSA id e10sm4578936pfh.77.2019.09.05.20.04.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 20:04:46 -0700 (PDT)
Date:   Fri, 6 Sep 2019 08:34:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: Re: [RFC v2 1/3] cpufreq: ti-cpufreq: add support for omap34xx and
 omap36xx
Message-ID: <20190906030444.lklvvpbdqesatohb@vireshk-i7>
References: <cover.1567587220.git.hns@goldelico.com>
 <a889b10386bebfbfd6cdb5491367235290d53247.1567587220.git.hns@goldelico.com>
 <20190905143226.GW52127@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905143226.GW52127@atomide.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-09-19, 07:32, Tony Lindgren wrote:
> Acked-by: Tony Lindgren <tony@atomide.com>

Do you want to pick the series instead as this has lots of DT changes
?

-- 
viresh
