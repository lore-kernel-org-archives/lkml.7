Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C141C4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B31220663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="shTVoSS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfFXWRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 18:17:45 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42609 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfFXWRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 18:17:45 -0400
Received: by mail-oi1-f194.google.com with SMTP id s184so10974326oie.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 15:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DyZtJbcLWTPh/r2aMOqaTZJx82vxwJ/WY4Wjw83iZpY=;
        b=shTVoSS2XF2z+5OjiXnPdpQNeCEMWeGPtAs7//zeOzORNDFb9q5ViyY1xp6ezKCq0W
         XwwqyCJ2zfHsHrYOFIlsV9OqWweSRHXF1mvq+OhyWhgzeKr71SD/Rc/h/1XqeT4EKTKj
         /4SPpaXk7yzD9NVyU+4qg9iEFXFbHeaJw6mbAzXlhDK6emEJOaeBl81kHCCJ2Wx6wuEQ
         t/gUxhtFVfDk4P+bdfARYQ/MfxwnZZifmXnwNtG3ZsYYtKR7m7vKNAt5K0Bm3OGYVx5L
         7lmRiM6g2OTicSiZr98RUXrRaLq58K3rh9nloQNLCr6NkApaHrb5su8T7eLqOTHperBT
         qVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DyZtJbcLWTPh/r2aMOqaTZJx82vxwJ/WY4Wjw83iZpY=;
        b=F1MfD9DuNCqtn5PjG4m8W5SFXpOQaDGUhLALcPnm7X+oDAt9TajHufT7m9NL+MR1xj
         5FLqMIAIKrzJrdZqTyPrH8jIhlsW6Ce5mGp2VCWYEzxsxa7NmHpM+dqJ+uSz2uSMMy3C
         klqwlNS2m5np6bvfQ43b0Phwb2WPsbaBkuQKkgHcSaxZZSfCee0UB0sXE06CuwYgKClY
         35XlME8kMoGnld/hIEQstzoT6wDdqSJWJTvXcshkBDmOyYNBZoB8uV9h/pqRxw+cTsUH
         YaByKKWlqYa3kMN7bAd8BQnhI1auWpwfGqWyDhiKdZ5/K1p7YR68W0fw5BhOeCMNOsCW
         y2DQ==
X-Gm-Message-State: APjAAAXfkmMfuFsdXuqzN6tZ1YbSE8rBNj5SimjuJW0XX5kJ/SYMf9st
        Se+59OLnkTEoQScRh91hs+ZNwxj96gDfCKKAafVrcw==
X-Google-Smtp-Source: APXvYqzNRa1SDtLuepKsEqIVimP3WUsxe43gNIRcxXWSJxVlgx1+CG0a2uP3Ow4kd/dieKuxWRi6HY1aLU+xIacMwzk=
X-Received: by 2002:aca:e641:: with SMTP id d62mr12090301oih.24.1561414664083;
 Mon, 24 Jun 2019 15:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190622003449.33707-1-saravanak@google.com> <20190624094349.rtjb7nuv6g7zmsf2@vireshk-i7>
In-Reply-To: <20190624094349.rtjb7nuv6g7zmsf2@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 24 Jun 2019 15:17:08 -0700
Message-ID: <CAGETcx_ggG8oDnAVaSfuHfip1ozjQpFiGs15cz8nLQnzjTiSTg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Add required-opps support to devfreq passive gov
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 2:43 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 21-06-19, 17:34, Saravana Kannan wrote:
> > The devfreq passive governor scales the frequency of a "child" device
> > based on the current frequency of a "parent" device (not parent/child in
> > the sense of device hierarchy). As of today, the passive governor
> > requires one of the following to work correctly:
> > 1. The parent and child device have the same number of frequencies
> > 2. The child device driver passes a mapping function to translate from
> >    parent frequency to child frequency.
> >
> > When (1) is not true, (2) is the only option right now. But often times,
> > all that is required is a simple mapping from parent's frequency to
> > child's frequency.
> >
> > Since OPPs already support pointing to other "required-opps", add
> > support for using that to map from parent device frequency to child
> > device frequency. That way, every child device driver doesn't have to
> > implement a separate mapping function anytime (1) isn't true.
>
> Can you please provide a real world example with DT code here so I
> can understand it better ?
>

Here's an example. This can't be done today, but can be done with this change.

In arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi you have something
like this with the following changes:

        bus_g2d_400: bus0 {
                compatible = "samsung,exynos-bus";
                clocks = <&cmu_top CLK_ACLK_G2D_400>;
                clock-names = "bus";
                operating-points-v2 = <&bus_g2d_400_opp_table>;
                status = "disabled";
        };

        bus_noc2: bus9 {
                compatible = "samsung,exynos-bus";
                clocks = <&cmu_mif CLK_ACLK_BUS2_400>;
                clock-names = "bus";
                operating-points-v2 = <&bus_noc2_opp_table>;
                status = "disabled";
        };

        bus_g2d_400_opp_table: opp_table2 {
                compatible = "operating-points-v2";
                opp-shared;

                opp-400000000 {
                        opp-hz = /bits/ 64 <400000000>;
                        opp-microvolt = <1075000>;
+                       required-opps = <&noc2_400>;
                };
                opp-267000000 {
                        opp-hz = /bits/ 64 <267000000>;
                        opp-microvolt = <1000000>;
+                       required-opps = <&noc2_200>;
                };
                opp-200000000 {
                        opp-hz = /bits/ 64 <200000000>;
                        opp-microvolt = <975000>;
+                       required-opps = <&noc2_200>;
                };
                opp-160000000 {
                        opp-hz = /bits/ 64 <160000000>;
                        opp-microvolt = <962500>;
+                       required-opps = <&noc2_134>;
                };
                opp-134000000 {
                        opp-hz = /bits/ 64 <134000000>;
                        opp-microvolt = <950000>;
+                       required-opps = <&noc2_134>;
                };
                opp-100000000 {
                        opp-hz = /bits/ 64 <100000000>;
                        opp-microvolt = <937500>;
+                       required-opps = <&noc2_100>;
                };
        };

        bus_noc2_opp_table: opp_table6 {
                compatible = "operating-points-v2";

-               opp-400000000 {
+               noc2_400: opp-400000000 {
                        opp-hz = /bits/ 64 <400000000>;
                };
-               opp-200000000 {
+               noc2_200: opp-200000000 {
                        opp-hz = /bits/ 64 <200000000>;
                };
-               opp-134000000 {
+               noc2_134: opp-134000000 {
                        opp-hz = /bits/ 64 <134000000>;
                };
-               opp-100000000 {
+               noc2_100: opp-100000000 {
                        opp-hz = /bits/ 64 <100000000>;
                };
        };

Thanks,
Saravana
