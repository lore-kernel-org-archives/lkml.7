Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807AFC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 23:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF6D2077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 23:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QL8DwBfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbgAGXVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 18:21:18 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43612 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgAGXVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 18:21:17 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so1328636ljm.10;
        Tue, 07 Jan 2020 15:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BHPrdDHqTKocOGcYfuy3x5Um1jHg9IyVUnjzU2JWoYI=;
        b=QL8DwBfL+BLZKTsTBTsRCs2N6zzFV1Ra8IEXR0QxykP7MyptQ3jsWpfRQ1U6ZNph2r
         aK9SFrpCm0/KXmQeB2vu342tIL9584Z+Qhq+73ynu1BE9RFUfyO7fJtrJ+pmtqhGPC9S
         IqUnvv3JB5TvX/rEuQH9n6eJzz8uLVh/cIs6hdrcW14du5S5/H3spSFxmoRkKyHXh6As
         shXgNr0V+ZZlFFZwPuOoQIZgXpYimHmsCz8GfAULAo/KhazWYlovx63+ffp4fhCg1/DM
         VhgU7WGXEXcTbrblUKbKW8oc/ds1blQqru66JYaIcyLeRcB1M38o+Qv5fKAH7BhAw8K1
         ZT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BHPrdDHqTKocOGcYfuy3x5Um1jHg9IyVUnjzU2JWoYI=;
        b=acd9zjxPzB0loUYFRTAjtRFZorb3QTnm/VqiEDx/ko9siqR0u5r9Ax2d6A4eOQI/fA
         rNyF1pTnWgeFwjsvMU+rPWN1NTrSHTDkc0lMIOmdxrLXVoTdb3BBAaAY2TeDsXpkYkAG
         9xYFh/yIMaw/K5tcmAGfIEeVTJt8J5gjxYwH5EI0sI9JeEi9wtU75W6Kc9CAx3Fpyk1o
         4EOg4LJBxK57CUxylc5Ky80AWrRYZGh/j/A71uvw+pJSr9wgr+bwe4MSuEAFgjoIxr7/
         QoQvVwr7sxb4U+moEffTlg20B/Vx+eH+OaGXBhEdcCsUaoERipkrWBm6T/vO84e3ZQCO
         h0IQ==
X-Gm-Message-State: APjAAAVmWWdHCSozx+XJppMymhNbIFxiTyn/xHF5iXg7j32SyVRTL5O+
        NY7aN/yiAx8OyItVCuvlkv4xh64s
X-Google-Smtp-Source: APXvYqy3Pfx8xEhpQCKLQ6v4BWD6JxoP/FWFEIRic4iZQLGzhqU6udoZIvtOlmRmBU7xHAlS0PddMg==
X-Received: by 2002:a2e:9e16:: with SMTP id e22mr1063208ljk.220.1578439275004;
        Tue, 07 Jan 2020 15:21:15 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id x4sm401012ljb.66.2020.01.07.15.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 15:21:14 -0800 (PST)
Subject: Re: [PATCH RESEND for 5.6 v1 2/3] clk: tegra20/30: Don't
 pre-initialize displays parent clock
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191218184407.25790-1-digetx@gmail.com>
 <20191218184407.25790-2-digetx@gmail.com>
Message-ID: <fc28fdc2-12b0-7625-5086-b22a1f96c8c6@gmail.com>
Date:   Wed, 8 Jan 2020 02:21:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191218184407.25790-2-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.12.2019 21:44, Dmitry Osipenko пишет:
> Both Tegra20 and Tegra30 are initializing display's parent clock
> incorrectly because PLLP is running at 216/408MHz while display rate is
> set to 600MHz, but pre-setting the parent isn't needed at all because
> display driver selects proper parent anyways.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clk/tegra/clk-tegra20.c | 2 --
>  drivers/clk/tegra/clk-tegra30.c | 2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
> index 4d8222f5c638..0c14fb570343 100644
> --- a/drivers/clk/tegra/clk-tegra20.c
> +++ b/drivers/clk/tegra/clk-tegra20.c
> @@ -1046,8 +1046,6 @@ static struct tegra_clk_init_table init_table[] __initdata = {
>  	{ TEGRA20_CLK_SBC3, TEGRA20_CLK_PLL_P, 100000000, 0 },
>  	{ TEGRA20_CLK_SBC4, TEGRA20_CLK_PLL_P, 100000000, 0 },
>  	{ TEGRA20_CLK_HOST1X, TEGRA20_CLK_PLL_C, 150000000, 0 },
> -	{ TEGRA20_CLK_DISP1, TEGRA20_CLK_PLL_P, 600000000, 0 },
> -	{ TEGRA20_CLK_DISP2, TEGRA20_CLK_PLL_P, 600000000, 0 },
>  	{ TEGRA20_CLK_GR2D, TEGRA20_CLK_PLL_C, 300000000, 0 },
>  	{ TEGRA20_CLK_GR3D, TEGRA20_CLK_PLL_C, 300000000, 0 },
>  	{ TEGRA20_CLK_VDE, TEGRA20_CLK_CLK_MAX, 300000000, 0 },
> diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
> index c8bc18e4d7e5..bd4d42005897 100644
> --- a/drivers/clk/tegra/clk-tegra30.c
> +++ b/drivers/clk/tegra/clk-tegra30.c
> @@ -1251,8 +1251,6 @@ static struct tegra_clk_init_table init_table[] __initdata = {
>  	{ TEGRA30_CLK_SBC6, TEGRA30_CLK_PLL_P, 100000000, 0 },
>  	{ TEGRA30_CLK_PLL_C, TEGRA30_CLK_CLK_MAX, 600000000, 0 },
>  	{ TEGRA30_CLK_HOST1X, TEGRA30_CLK_PLL_C, 150000000, 0 },
> -	{ TEGRA30_CLK_DISP1, TEGRA30_CLK_PLL_P, 600000000, 0 },
> -	{ TEGRA30_CLK_DISP2, TEGRA30_CLK_PLL_P, 600000000, 0 },
>  	{ TEGRA30_CLK_TWD, TEGRA30_CLK_CLK_MAX, 0, 1 },
>  	{ TEGRA30_CLK_GR2D, TEGRA30_CLK_PLL_C, 300000000, 0 },
>  	{ TEGRA30_CLK_GR3D, TEGRA30_CLK_PLL_C, 300000000, 0 },
> 

Hello people,

Could anyone please take a look at these trivial patches and give an
ACK? Thanks in advance!
