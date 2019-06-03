Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE86C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604C926B56
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f/VSrUxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfFCTzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:55:19 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44105 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFCTzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:55:19 -0400
Received: by mail-qt1-f195.google.com with SMTP id x47so10916335qtk.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 12:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1KV1EL2zWlz4BNwMzZsPPlusL/bx0yMiXCoqZlXd458=;
        b=f/VSrUxboXoGFGdWMMd2FDeP8+ypIq64epfnLR1+dKU5NMMKQvoEkLcb1gXkzsU7wz
         Jn/pM2dph432cJm0hpfUrbOa2Iqat6S2Hn2aMVwbuIRid7V89u8IdB8eypsxoOh4PeC4
         rCN8Cqwz/u6w2Yn0EgkhmvpUsMx+j0EiV1hm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1KV1EL2zWlz4BNwMzZsPPlusL/bx0yMiXCoqZlXd458=;
        b=RuOypg2+rD/If4TR4sCc2MGdXl5fzUu7IdLWFlupSwOOYMo15AWsFU5j1q8dr7bLkd
         naUskVhbRzi57lCfsFuKKKvEMk/V0DgGZyUDhTLr+VDv9lCFeNLriZMWdG6Bl5xabrIR
         rna1iSx+v9hvKvHFQB4moQ5eec3DvmlnXI8EBvPPWF1HuNqYhu7xdHeOBurMi+DTQJTb
         AFft+pW5dw4tcsAMvUxn/IOjdPYOU2ejO7AYq/uoN+dJYZ3QeOtez0bZtkKC/Mvn8hUc
         e5DKzsW/ucDx5K9jD1W0Ox2Is5sXnvqs+006oaBfI9Ii3lgilaMmF91BeK0qKEg1x7Kw
         twfA==
X-Gm-Message-State: APjAAAVVoWFnFg+6/73Nv05+3xrtKYFp+7Xw4JAT9G3HFbaBk3DzOm8l
        QJuo/wHNa1TNWNICoFS7ZtcGiao6kMbqKnvYNvzv3f86g3oJUA==
X-Google-Smtp-Source: APXvYqw9CyjBN9zLt670R7s4Nqh+tF2Uw/nqdK92LwjcIbHrzECu2UzbVydDyKivYV7rqUCst1Zpy0CU03QqWZF+nkw=
X-Received: by 2002:ac8:2906:: with SMTP id y6mr4604304qty.138.1559591717763;
 Mon, 03 Jun 2019 12:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190522184547.31791-1-f.fainelli@gmail.com> <3734641.73qX0VsHyn@kreacher>
 <013ec7c0-0984-cfc9-ea3a-0180719f5ac4@gmail.com>
In-Reply-To: <013ec7c0-0984-cfc9-ea3a-0180719f5ac4@gmail.com>
From:   Markus Mayer <mmayer@broadcom.com>
Date:   Mon, 3 Jun 2019 12:55:06 -0700
Message-ID: <CAGt4E5tZ1YLbtCDJDXTTZrH5S4Jmw_BVOfz+i-KF=TUjA=yvkQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] cpufreq: brcmstb-avs-cpufreq: Couple fixes
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Markus Mayer <code@mmayer.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "maintainer:BROADCOM STB AVS CPUFREQ DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "open list:BROADCOM STB AVS CPUFREQ DRIVER" 
        <linux-pm@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 at 10:02, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 5/27/19 3:51 AM, Rafael J. Wysocki wrote:
> > On Wednesday, May 22, 2019 8:45:45 PM CEST Florian Fainelli wrote:
> >> Hi Rafael, Viresh,
> >>
> >> These patch series contains two minor fixes for the brcmstb-avs-cpufreq
> >> driver.
> >>
> >> Florian Fainelli (2):
> >>   cpufreq: brcmstb-avs-cpufreq: Fix initial command check
> >>   cpufreq: brcmstb-avs-cpufreq: Fix types for voltage/frequency

To both of these

Acked-by: Markus Mayer <mmayer@broadcom.com>

My apologies for the delay.

> >>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 12 ++++++------
> >>  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > These look straightforward enough to me, but it would be good to get an ACK from the
> > driver maintainer for them.
>
> Adding Markus' other email address.
> --
> Florian
