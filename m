Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0CCC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4375920843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qMdw+xMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfHNIcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:32:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42491 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfHNIcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:32:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id l14so1348981ljj.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 01:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qprk97I1dFe+WA8kDtJTqkPzn2PSILy5kREIC5Uixm4=;
        b=qMdw+xMV024LAbvccUI3jC70aaEEO5YWomLZhuABCdzO2cL+7TrxzWBaQItupTGIe5
         V5iI287R6yEzuK4400Xf11LNmZT5SP6D3BpwXIiP0REHYCp8lEccJQsiTnSQK7+qJw5c
         Adf6kT0NahAxCaB61a4PDzWh0bZsvpdye0vrJeeZ3SE9yW+n4tXTOd0BO1uq9rjGvYuB
         5Nnv5m31Aj9HkD49sGMjQwz//29/ywzsTipoA+S2vbv/e5ERHrl6TQtuGZhTkqDX2q/6
         Bt86uvuXeQ6/przYNgkxiJfzspWLBBF/cOGwWI6Nx23yadkF0Xae3G66sAVLnvA6hs3F
         KrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qprk97I1dFe+WA8kDtJTqkPzn2PSILy5kREIC5Uixm4=;
        b=NhpWDt60NqzsFGqGNRLkKMblDaji80kSUAECk09ZeIKv1gaZSwzGWvjmjcIE/ZLx/M
         ffYihIkVKvVEr10rrxunGgY1swaADecvZYpKuCZOla/bdCF8w6BDZSZsycVZS/NI2X31
         AvIKehE9GjLJ/q+sTa+Bz1p9K4FKry0Y3zSCqOj2J5jlH/XKf6yEqqAA/c1pTQpfgj0d
         gKQg5wDM2hQB1zMmdYsJgKcBjYkXabJnyhFwfgFbj65qsEpgfOLYie4g18K2AqpDdJgW
         HYZgq1vh9pkaj5HGHcFfCFMM1lyI8nVgBiCOaX5zdTdLQ5UlY5uCKtPJ+c5lcHMZHqyK
         WbeA==
X-Gm-Message-State: APjAAAXLaGORNTbKhZoqfvszsk0peBOvqeyMhRzri16wevxE06Kv4Pn2
        VuCsLqy0bTOyOemcO676YRKtvH/G050VxjH6FlnN8A==
X-Google-Smtp-Source: APXvYqx+fft1SOz2IQDyCGJ15XAqb3Zjb5OEqzoV7vIlggjkoFNfsMZU8eWQaIcFkhj1gV1hUfaGOfz43NWpoIBxdXE=
X-Received: by 2002:a2e:9f0f:: with SMTP id u15mr14722764ljk.54.1565771559322;
 Wed, 14 Aug 2019 01:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com> <1565308020-31952-2-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1565308020-31952-2-git-send-email-skomatineni@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Aug 2019 10:32:28 +0200
Message-ID: <CACRpkdasx8AooB_bhUpVhU9ig_ztri3hbryiO_FEGEO+eUXwkg@mail.gmail.com>
Subject: Re: [PATCH v8 01/21] pinctrl: tegra: Fix write barrier placement in pmx_writel
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        jckuo@nvidia.com, Joseph Lo <josephl@nvidia.com>, talho@nvidia.com,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>, spatra@nvidia.com,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        viresh kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 1:47 AM Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:

> pmx_writel uses writel which inserts write barrier before the
> register write rather.
>
> This patch has fix to replace writel with writel_relaxed followed
> by a write barrier to ensure write operation before the barrier
> is completed for successful pinctrl change.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Patch applied with the ACKs.

Yours,
Linus Walleij
