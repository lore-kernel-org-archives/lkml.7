Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36E5ECE599
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24402053B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RoGFrF8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404394AbfJQCcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 22:32:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43254 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389860AbfJQCcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 22:32:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id i32so378176pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 19:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=X6tAGv7Xz958wWNHO8Bq64KdhKc5wOL6Vmp5Zs/f1LQ=;
        b=RoGFrF8CxXw6l3KRULwiAKo4CcCIvLMii/JVsVD7bQjijehEko5h7HIW5ws5tpRsLn
         k4uFFJYB2b4/Jo3YHMn7rIn2CJTiPXBQTpKun+gnprs0VObBH4ZXp0ohNA1VbKJNUsN2
         CVuxt2wtZombnBTgLJ/Lvu4ZZvKo0YFTIrFv0BU19bafe9nhQNFuvdkhKj6wPsXKlSxG
         +vWOZAfh87/ny1Pvy+iCA/46sORy+Yr/YNrOsCiwV9os9JCSvzMxsHsX6HhTAUvcyaUE
         vd9iTuvj1F5mQYM2wf4Ce+N7+TGjXldWbDlgJtOf3zWKDQ1vXgr2ksSZVD9F4vRfXFdf
         E8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=X6tAGv7Xz958wWNHO8Bq64KdhKc5wOL6Vmp5Zs/f1LQ=;
        b=Kx3y9FLO7Qohy9sCjRcjJKj9Jt5POKVIfwniSuAeDAvWRvyA3pk0jx/mcIBj8wqwSA
         6e0iEGuzs2arF+RSZ8LxHSmkvvQgX79mKaFnCfxR1hjQRuJBiqpRwP+7jwLLJ8pdV2ed
         7rnJeoSFYIQYJKZZ8vfk0sF8JAvHgfBpdHN9pKo2wlPxIl8lA8REK6GiWCGb/hIowDyt
         +lSZJpZECCiS63dBSqlV236v8pXoMu19/512tHnRS9ukUdkokOKfGSx0Je/ehzGpWpeC
         HhCYm50Fqgmi2tQEH5nLU+B7m4nb0f7UwPQU9pZyHpD9gtsAxWuYGySw+aNt8of40Yy7
         6OSw==
X-Gm-Message-State: APjAAAVFwnptRzerukyGKOsUl/VA7TiWSmr4WdaiSeaQmLS715nm+75X
        PV3bSPWP2OMhw0cfO3TkxCDLfg==
X-Google-Smtp-Source: APXvYqy7ws3cNv9Ac3aA6W8EqM60vbSd5fn0dl5fR0g/r08zv/z7EMVvkW8HP3i7QE/yNMauN7v89Q==
X-Received: by 2002:a17:90a:8508:: with SMTP id l8mr1387293pjn.15.1571279533556;
        Wed, 16 Oct 2019 19:32:13 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id w6sm488958pfj.17.2019.10.16.19.32.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 19:32:12 -0700 (PDT)
Date:   Thu, 17 Oct 2019 08:02:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/17] cpufreq: tegra20: Use generic cpufreq-dt driver
 (Tegra30 supported now)
Message-ID: <20191017023210.x5vavl542hdkrivw@vireshk-i7>
References: <20191015211618.20758-1-digetx@gmail.com>
 <20191015211618.20758-8-digetx@gmail.com>
 <20191016051802.rrxv56vtvxfm6qqe@vireshk-i7>
 <13a9ebd6-8dce-0217-d306-defb8eb6fb96@gmail.com>
 <CAMdYzYoasuEobJLC4RLW_5WCNGnaKtTth0xKov0tUQuDhkX3EA@mail.gmail.com>
 <b4eca03d-f86c-8e07-e04a-612e02820bd0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4eca03d-f86c-8e07-e04a-612e02820bd0@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-10-19, 21:19, Dmitry Osipenko wrote:
> 16.10.2019 17:58, Peter Geis пишет:
> > On Wed, Oct 16, 2019 at 9:29 AM Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> 16.10.2019 08:18, Viresh Kumar пишет:
> >>> On 16-10-19, 00:16, Dmitry Osipenko wrote:
> >>>> Re-parenting to intermediate clock is supported now by the clock driver
> >>>> and thus there is no need in a customized CPUFreq driver, all that code
> >>>> is common for both Tegra20 and Tegra30. The available CPU freqs are now
> >>>> specified in device-tree in a form of OPPs, all users should update their
> >>>> device-trees.
> >>>>
> >>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>>> ---
> >>>>  drivers/cpufreq/Kconfig.arm          |   4 +-
> >>>>  drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
> >>>>  drivers/cpufreq/tegra20-cpufreq.c    | 236 ++++++---------------------
> >>>>  3 files changed, 55 insertions(+), 187 deletions(-)
> >>>>
> >>>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> >>>> index a905796f7f85..2118c45d0acd 100644
> >>>> --- a/drivers/cpufreq/Kconfig.arm
> >>>> +++ b/drivers/cpufreq/Kconfig.arm
> >>>> @@ -301,8 +301,8 @@ config ARM_TANGO_CPUFREQ
> >>>>      default y
> >>>>
> >>>>  config ARM_TEGRA20_CPUFREQ
> >>>> -    tristate "Tegra20 CPUFreq support"
> >>>> -    depends on ARCH_TEGRA
> >>>> +    bool "Tegra20 CPUFreq support"
> >>>
> >>> Google is currently working on the GKI (generic kernel image) project where they
> >>> want to use a single kernel image with modules for all kind of android devices.
> >>> And for that they need all such drivers to be built as module. Since this is
> >>> already an module, I would ask you to keep it as is instead of moving it to bool
> >>> here. Else some google guy will switch it back as module later on.
> >>>
> >>> LGTM otherwise. Nice work. Thanks.
> >>>
> >>
> >> Okay, I'll keep the modularity in v2.
> >>
> >> Although, tegra20-cpufreq isn't a driver anymore because now it merely
> >> prepares OPP table for the cpufreq-dt driver, which is really a one-shot
> >> action that is enough to do during boot and thus modularity is a bit
> >> redundant here.
> > 
> > I doubt Google will care much, since Android has moved on to aarch64.
> > Do they even support arm32 any more?
> 
> Yes, I don't think there is a real need to care about Google. They won't
> use pure upstream and won't care about older hardware any ways.

Well, using (almost) pure upstream is the idea I believe. And the thing is they
want to use a single multi-platform image which should be as small as possible
in size. So it won't have any drivers or platform stuff (if possible) and
everything is module.

I am not sure about arm32/64 thing though. And it is okay if you don't want to
care about Google right now. That was just some side knowledge I had :)

-- 
viresh
