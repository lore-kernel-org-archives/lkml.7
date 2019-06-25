Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAA1C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 04:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC7120659
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 04:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CweMukdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfFYEK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 00:10:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41489 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfFYEK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 00:10:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id m7so8062034pls.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 21:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WhRE5I+VNZGCoUBaxMbI4Od/sWraEBpUeY2juijKEG0=;
        b=CweMukdbhQlsigDWluCViQbmqKgyaxfS34dX9w771cwI3Hf3xULECQBsU1EtuZhqhI
         zUZGLq58EjaE2vGXVecXMI2v08ZhIU4esluIgOM6pfTlUcs2reC9PQGFAu+GfLIyynZp
         N9Y6ZEkxKQc6WokUMgJ4s9woUnBdUfDzMl6XSV99/eaVQcumbkPibBMM4xE6iloG7lcD
         lGzKrrs3ef9lEeRR5rmgHja3fQeJUi6uj+EuSrUznfERnmBK9JzLHEzHsZgnArixJQfq
         m4/90jLs8Wcztgg7gF2UO98KTthInN+mz5z6OanA004gpxFQ02Ml/YGDKl8IFH3Sl8hg
         0T6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WhRE5I+VNZGCoUBaxMbI4Od/sWraEBpUeY2juijKEG0=;
        b=UG+UZfGHWnfWUsit7eoaIfg+kFgzk/va1Fg/Va9HBrdP4ZXrs7zlvJylScMrYQo0hU
         jEAPjxEKU+3XldTTe17Tod0aUtaKZhiYtVWJ/2Yl/2QRpRqjYx9y5YchyEjH0ydpifgB
         RuDCHkTVQLa+lvfBND+qCIdo3SibsKFc03MbJFyzUlNflt+Gq5b6MH55SeH6mMgPzuSo
         DlmJ87dE1800GGRp5WM0XK8EVP/Vzv7IhxEKm3+O8asrOXVIukfrFjg8gj+IuAcdrwEV
         rAS92kn6W31KWVVWC1/HLDWintSZek/QsQtKHR6EsvR4CROV16jHx56jyKZKSst3kp5p
         CDgQ==
X-Gm-Message-State: APjAAAWTrJtTJK0VFEHnrt4zUDHcaPS44eEHTq0wA5a1kMT0AK6X5MVn
        yBMgjaaORllrvtgiRM3sudn4qg==
X-Google-Smtp-Source: APXvYqwuvJ+cGsSoEVo728fguFKP5vudi02Rk2JQbkF6MKhfnZ3qgvM7yfLpmFMfkn8SLTCEKaA0RQ==
X-Received: by 2002:a17:902:7041:: with SMTP id h1mr5817739plt.133.1561435858318;
        Mon, 24 Jun 2019 21:10:58 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id l2sm11028290pff.107.2019.06.24.21.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 21:10:56 -0700 (PDT)
Date:   Tue, 25 Jun 2019 09:40:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] Add required-opps support to devfreq passive gov
Message-ID: <20190625041054.2ceuvnuuebc6hsr5@vireshk-i7>
References: <20190622003449.33707-1-saravanak@google.com>
 <20190624094349.rtjb7nuv6g7zmsf2@vireshk-i7>
 <CAGETcx_ggG8oDnAVaSfuHfip1ozjQpFiGs15cz8nLQnzjTiSTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_ggG8oDnAVaSfuHfip1ozjQpFiGs15cz8nLQnzjTiSTg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-06-19, 15:17, Saravana Kannan wrote:
> Here's an example. This can't be done today, but can be done with this change.
> 
> In arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi you have something
> like this with the following changes:
> 
>         bus_g2d_400: bus0 {
>                 compatible = "samsung,exynos-bus";
>                 clocks = <&cmu_top CLK_ACLK_G2D_400>;
>                 clock-names = "bus";
>                 operating-points-v2 = <&bus_g2d_400_opp_table>;
>                 status = "disabled";
>         };
> 
>         bus_noc2: bus9 {
>                 compatible = "samsung,exynos-bus";
>                 clocks = <&cmu_mif CLK_ACLK_BUS2_400>;
>                 clock-names = "bus";
>                 operating-points-v2 = <&bus_noc2_opp_table>;
>                 status = "disabled";
>         };

And what is the relation between these two busses ?

>         bus_g2d_400_opp_table: opp_table2 {
>                 compatible = "operating-points-v2";
>                 opp-shared;
> 
>                 opp-400000000 {
>                         opp-hz = /bits/ 64 <400000000>;
>                         opp-microvolt = <1075000>;
> +                       required-opps = <&noc2_400>;
>                 };
>                 opp-267000000 {
>                         opp-hz = /bits/ 64 <267000000>;
>                         opp-microvolt = <1000000>;
> +                       required-opps = <&noc2_200>;
>                 };
>                 opp-200000000 {
>                         opp-hz = /bits/ 64 <200000000>;
>                         opp-microvolt = <975000>;
> +                       required-opps = <&noc2_200>;
>                 };
>                 opp-160000000 {
>                         opp-hz = /bits/ 64 <160000000>;
>                         opp-microvolt = <962500>;
> +                       required-opps = <&noc2_134>;
>                 };
>                 opp-134000000 {
>                         opp-hz = /bits/ 64 <134000000>;
>                         opp-microvolt = <950000>;
> +                       required-opps = <&noc2_134>;
>                 };
>                 opp-100000000 {
>                         opp-hz = /bits/ 64 <100000000>;
>                         opp-microvolt = <937500>;
> +                       required-opps = <&noc2_100>;
>                 };
>         };
> 
>         bus_noc2_opp_table: opp_table6 {
>                 compatible = "operating-points-v2";
> 
> -               opp-400000000 {
> +               noc2_400: opp-400000000 {
>                         opp-hz = /bits/ 64 <400000000>;
>                 };
> -               opp-200000000 {
> +               noc2_200: opp-200000000 {
>                         opp-hz = /bits/ 64 <200000000>;
>                 };
> -               opp-134000000 {
> +               noc2_134: opp-134000000 {
>                         opp-hz = /bits/ 64 <134000000>;
>                 };
> -               opp-100000000 {
> +               noc2_100: opp-100000000 {
>                         opp-hz = /bits/ 64 <100000000>;
>                 };
>         };
> 
> Thanks,
> Saravana

-- 
viresh
