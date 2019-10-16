Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ED5ECE58E
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 05:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CC22067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 05:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDcpx0nQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfJPFX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 01:23:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33056 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfJPFX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 01:23:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so13957112pfl.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 22:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=saoyAGsKjDvsSfjCA3zQdLH5MPFlT8Eo8WfiHM6JM8o=;
        b=PDcpx0nQR0OqGsEB4yG6vkxy48xHjjJeP0Jw2SJQ0QMf5Z3+Sbof0vkXDD3Ig7W0LU
         N4ShRgxolreDnGeu6EPvbi0GFIeez8L4jq77E0vvdQ1OXsvyU13hMz5Dy/3BGOMZrFBE
         gFlboTcZufi+A+nfIv+54/cpQKfxk9lSFyIzpU/EL7AYPvPFMMUu9CPXbgapX4Ehy1C+
         ec8kfnp4XH6zOxZWSbRsutzzMTVZzYfWbRicUOlR4xErWsJUDKDtZHNFPP/FRARARjca
         yKt21E/zpTd+HOjkVX/hH0jEuWAyw1D8gsKOH9hmro5fwlPfKeJOvTrLZ3OIWUvTFFz/
         Bxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=saoyAGsKjDvsSfjCA3zQdLH5MPFlT8Eo8WfiHM6JM8o=;
        b=HibyNOKLOT9Di0113rVi3qFKh/IwOhxzXA4JSJyy6UQf6ZsVVX68nDSEDrE90CmTiA
         53+WuD6i0zAvhC5H0TiQThwAMyTl5JPqg1RhRkaKPijcKwF8tSO/SQqPOza6E7JBwM6Q
         BlYckLelBEjzIiZeGgZGgoz3Jn938NbqbbDW1sjKRMCTzuPBnpQ6uoLT28dzFzpa/6Lv
         iE8kUpgrW1AcNYiNQDQmnZEtbzKD4DQVWHi30zFLdLEI2pQzgcQ7FIllY5uRjr9Luu2D
         74tT+FLf2lgMZz6Z/DSuLziAU9Vc9kUpZYyw3ptoRoEgBskBpJvVDYC39FmhSyOF+G4J
         zSYw==
X-Gm-Message-State: APjAAAVL5MA4wQkEbYovw7KV9MgsypUMuKFad8dFPPnYzf11/e9JZvro
        tZbAnXR9I2l6/kC4HnSaENoAWA==
X-Google-Smtp-Source: APXvYqxJXrMIsdHO4Rsjym8iDMxG0peczoTX8o2q55MtDIt8QZRw17a5QLaERi2EsvfikM/HZIzraw==
X-Received: by 2002:aa7:86cb:: with SMTP id h11mr43684402pfo.59.1571203405710;
        Tue, 15 Oct 2019 22:23:25 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id 22sm24303865pfo.131.2019.10.15.22.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 22:23:24 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:53:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 11/17] ARM: dts: tegra20: Add CPU Operating
 Performance Points
Message-ID: <20191016052323.w6hav4qqn3ybt55q@vireshk-i7>
References: <20191015211618.20758-1-digetx@gmail.com>
 <20191015211618.20758-12-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015211618.20758-12-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-10-19, 00:16, Dmitry Osipenko wrote:
> Operating Point are specified per HW version. The OPP voltages are kept
> in a separate DTSI file because some boards may not define CPU regulator
> in their device-tree if voltage scaling isn't necessary, like for example
> in a case of tegra20-trimslice which is outlet-powered device.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../boot/dts/tegra20-cpu-opp-microvolt.dtsi   | 201 ++++++++++++
>  arch/arm/boot/dts/tegra20-cpu-opp.dtsi        | 302 ++++++++++++++++++
>  2 files changed, 503 insertions(+)
>  create mode 100644 arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi
>  create mode 100644 arch/arm/boot/dts/tegra20-cpu-opp.dtsi
> 
> diff --git a/arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi b/arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi
> new file mode 100644
> index 000000000000..e85ffdbef876
> --- /dev/null
> +++ b/arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi
> @@ -0,0 +1,201 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/ {
> +	cpu0_opp_table: cpu_opp_table0 {
> +		opp@216000000_750 {

Maybe just drop the _750 (i.e. voltage) from the names as we don't generally
follow it :)

> +			opp-microvolt = <750000 750000 1125000>;
> +		};

-- 
viresh
