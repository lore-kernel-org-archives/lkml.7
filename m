Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAD3C2D0BE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 14:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C392467B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 14:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3aQ1qbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfLGOdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 09:33:24 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45863 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfLGOdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 09:33:24 -0500
Received: by mail-lj1-f193.google.com with SMTP id d20so10709766ljc.12;
        Sat, 07 Dec 2019 06:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/FFDjLwGzWA9HSQGVIzBQAFJnVseiTav15XJa3GBc3M=;
        b=K3aQ1qbnb55GNOBjWlsAMHcHx4YpXkTmspJZNtQXfZdFyWE+cwSXhC+prKM7Cj+7LU
         jduHbB8Y3SawAfvF6BiO8joJc70Bkgx827I05VZk19e5S08pWQHu0Xcj6ubmkd9v01yz
         8vUqyzhjuQuo0tipFfpM4TEbT+am9WsUMgmv74hmFUD5Zr2yprED8P8W42B5XsatRe9S
         38WrXZFsAGdVu3KbEql7dhqguT+YQlZWhEvwJyyK9ghBvbfEPEAFUPiFXdK9weISgcb/
         /GbNBmS+Dg67t1paCZbFk9QohnHq8yqD2EqOYGBFRHLDRRrZm8Dj+vv5w6l+R7nUiWbP
         PXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/FFDjLwGzWA9HSQGVIzBQAFJnVseiTav15XJa3GBc3M=;
        b=T7fb5wCFhWuvVJfSa4GmugX89IJzMVSQYSSLAo3z9q6cLHGbX6wdI7weAMNCOOyFct
         v9yd3epjvugCovTamoN7zKzBBphs9V/D8FWHHJZ5foHBj1gamdmUiFZhUCJ3fqvj9y+7
         YqMAskPjFNOXbISmT6pjZw8ix3J6BNlab+Hmmz6y256W0kEuXZcRanPtxbky1KlHf37X
         8uVL3XU/wX4PCssGBwvjDfWgrrSSfbe3cpRiXd2Th5gbKKtbEE56/eKXVpKCrUG4Ac/B
         MopbppdatA2KZmoOt++MRoBZTuTeAQQOEw2QcFzUw1zT2gD6JjGDSSgLzALA7nwqqWDG
         eO1g==
X-Gm-Message-State: APjAAAXUWqmpLXDGkRnSKrO5TKazXNollmxTY5SYgzJNmItG00XaSEb3
        b9tcpwy8hxmC4Iu4eQOVttQ=
X-Google-Smtp-Source: APXvYqwlXFJb8W4yPOfhW3/16zy5CO9BLcreipXry+ldYRegUMcmqCBo+2yeOXVRJRYvTKIUZaTVpA==
X-Received: by 2002:a2e:9705:: with SMTP id r5mr10932018lji.114.1575729201868;
        Sat, 07 Dec 2019 06:33:21 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id l28sm8132397lfk.21.2019.12.07.06.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 06:33:21 -0800 (PST)
Subject: Re: [PATCH v3 06/15] clk: tegra: Remove tegra_pmc_clk_init along with
 clk ids
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     allison@lohutok.net, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, horms+renesas@verge.net.au,
        Jisheng.Zhang@synaptics.com, krzk@kernel.org, arnd@arndb.de,
        spujar@nvidia.com, josephl@nvidia.com, vidyas@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alexios.zavras@intel.com, alsa-devel@alsa-project.org
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
 <1575600535-26877-7-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3880aa15-c47a-5ab2-dd39-e8a47f6a3d6a@gmail.com>
Date:   Sat, 7 Dec 2019 17:33:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575600535-26877-7-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.12.2019 05:48, Sowjanya Komatineni пишет:
> Current Tegra clock driver registers PMC clocks clk_out_1, clk_out_2,
> clk_out_3 and blink output in tegra_pmc_init() which does direct Tegra
> PMC access during clk_ops and these PMC register read and write access
> will not happen when PMC is in secure mode.
> 
> Any direct PMC register access from non-secure world will not go
> through and all the PMC clocks and blink control are done in Tegra PMC
> driver with PMC as clock provider.
> 
> This patch removes tegra_pmc_clk_init along with corresponding clk ids
> from Tegra clock driver.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---

[snip]

> @@ -1230,9 +1222,6 @@ static struct tegra_clk_init_table init_table[] __initdata = {

>  	{ TEGRA30_CLK_PLL_A, TEGRA30_CLK_CLK_MAX, 564480000, 1 },
>  	{ TEGRA30_CLK_PLL_A_OUT0, TEGRA30_CLK_CLK_MAX, 11289600, 1 },
>  	{ TEGRA30_CLK_EXTERN1, TEGRA30_CLK_PLL_A_OUT0, 0, 1 },

Perhaps these clocks do not need to be always-enabled?

[snip]
