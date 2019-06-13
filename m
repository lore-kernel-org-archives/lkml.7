Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEF1C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9293820665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WDkShjUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393039AbfFMQwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:52:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40342 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbfFMD27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 23:28:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id d30so10067560pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 20:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y0RXF4gWpg6oRev0V7qX7zvfsm8kw/NN62sxjqPfMWk=;
        b=WDkShjUqr7OdKx3xze67gTatNDPEQdHEKzUEZhf5VJRnMGTGr+0TodpBpsYi22fHXQ
         yGX/7D1trCLjI/pOgYmz5EPF09mx/zBREXyL1gtGJdqmJK3XHEOQuIStQCknN/QZqo/j
         Sk7x0EBYLCtp3BsdU6cuy+FGNu+spl6f+yLvhYv6T8SDHZ7agwTJeQ9W6jw/sWCbL+uQ
         9BwjOFSDhTsTZ7Gpc7BHSibDsj5XrvD/jVwsjQQMU9fX5bUHY0tK9IebaADaeMUnOjBS
         KVTizgjHB/l863d+4fw5SjiN6weba69/fRrdFPSu41y/vnn0i9+TZj3uetd+6VAADhGe
         DP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y0RXF4gWpg6oRev0V7qX7zvfsm8kw/NN62sxjqPfMWk=;
        b=nTArBctHqIkH/xGtqyT2a1NVV4MahgQwELkX58Ukr1iGiqeBiKbrnB5Wg48KlUKMp6
         isXpzkjYZJVsI0Hx5o3B4se5k3qt/qusjxAKVJ8QBwMOl9eOqK8JTd9FODJe8Lyc6csl
         bN+MQPZlLl2KUJS6kAi3E0eT/q/4YAK6WuXNU/zGsInaYWevFHgfXrI8ZA2KUaQO+YCz
         xeOY+QtDTTXGm5YkVkQ0cp+RsNuVpdaHqhKiYIv8oHNa66/ntk027LZFZk/HDWDe0PNV
         aDkF0ORIEd9Wh1rP1NmiDmknfML3/m3Y5mvz2g2es6+xpPcXOOTWBtc/YDOpKXpZhIwn
         wN1w==
X-Gm-Message-State: APjAAAVAlCqIxKBo/0mJTC+c3Erqcz/nI38k+Gen6AJH13koELDUtOxo
        8pP5DMI08Yf1nj53ooAjp/Mr9g==
X-Google-Smtp-Source: APXvYqzeOaLF3t0SmMiR779Mvfmp+z/EooCVSQRsNsjXE6iUYXAx0qAfy9hRnNnJItYipyXKylLwlw==
X-Received: by 2002:a17:90a:aa88:: with SMTP id l8mr2523399pjq.65.1560396538076;
        Wed, 12 Jun 2019 20:28:58 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id f88sm818781pjg.5.2019.06.12.20.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 20:28:56 -0700 (PDT)
Date:   Thu, 13 Jun 2019 08:58:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     stefan.wahren@i2se.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        mbrugger@suse.de, sboyd@kernel.org, eric@anholt.net,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        ptesarik@suse.com, linux-rpi-kernel@lists.infradead.org,
        ssuloev@orpaltech.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/7] cpufreq: add driver for Raspberry Pi
Message-ID: <20190613032854.wz76t3mq5t2zqcup@vireshk-i7>
References: <20190612182500.4097-1-nsaenzjulienne@suse.de>
 <20190612182500.4097-5-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612182500.4097-5-nsaenzjulienne@suse.de>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-06-19, 20:24, Nicolas Saenz Julienne wrote:
> Raspberry Pi's firmware offers and interface though which update it's
> performance requirements. It allows us to request for specific runtime
> frequencies, which the firmware might or might not respect, depending on
> the firmware configuration and thermals.
> 
> As the maximum and minimum frequencies are configurable in the firmware
> there is no way to know in advance their values. So the Raspberry Pi
> cpufreq driver queries them, builds an opp frequency table to then
> launch cpufreq-dt.
> 
> Also, as the firmware interface might be configured as a module, making
> the cpu clock unavailable during init, this implements a full fledged
> driver, as opposed to most drivers registering cpufreq-dt, which only
> make use of an init routine.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Acked-by: Eric Anholt <eric@anholt.net>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Applied. Thanks.

-- 
viresh
