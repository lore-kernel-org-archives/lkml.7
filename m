Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B007C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23036208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wf71Wq0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbfL2RjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:39:20 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33380 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbfL2RdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:33:18 -0500
Received: by mail-ed1-f67.google.com with SMTP id r21so30447764edq.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 09:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g+ZqxN5m5gAkIByhRJf04aggcuX7J+K/cyMPSK2p+QA=;
        b=wf71Wq0yMOB58FsNbi2p888B5RLQ+mTavSy4HA7XvUnu6YC98zDS1ey+qK1HxpzbCz
         6L2tloRWFY4Q7RvQIsEA9ZbK5V1v4V5avPP+9GCeSHiPIbf7Tpmorx0qZXXba7X2DB5W
         kwmNwUUsBAk2CmQxiD6T2LL+e7bhOpjNvW2pbsPNyLF+/+jQlCa1UL01REnyBo48MJuh
         JumoHJbyuy81K+RyvAR81dhk9zZwR/fTiDARReOxK4iG/D7vF0f+jbXECX1btRxqyckv
         0ABHpABgoZ4jGMtVfG/I5hdTjow6AKldsBt3vO0+5UKn1ClaUEw6AKa9x3tu06mRS6wa
         JArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g+ZqxN5m5gAkIByhRJf04aggcuX7J+K/cyMPSK2p+QA=;
        b=CMnGkfJA0A1M0AHbbrQPxzJrWlpzQbRt4gldEsCKrEG/S2Yf9QY+xOZEomHoJlZOba
         D8Ug1KUmn7vzVKjTw5aXDOFnifxsmZesNdT71d27EQJWgaHUtrM9fwCoDisS/gBeZdKH
         i4nkIhwg+pCe/6+XSzRHO06DICugHFpxtYV5seN2usW8ZXdrh+QjsL1Q8uGGlUXnJ33F
         7CAx487/xh1Zj0DtA8Fqgm0437UhXnHdcVQ4aa2p6kT/7TTRRnZSh/P9TFAozdcOqPG2
         YwyCfVT0AmO/609cgXAJMJI1nor1aCaCh1M7o1R9g6CH8ZBJqEL1RcJp3cwS7blKT2iE
         L9UA==
X-Gm-Message-State: APjAAAVSEO7BMo2jx2o/KW14ckb0AS3IqH/g2LVpRN8xzI97cI5B4a43
        4wBb4HOUkSvHbXScZc5rSfA12Q==
X-Google-Smtp-Source: APXvYqxl8lf/vPqrZynpCjFh+E2DeE1Gmv+uphj+YiOjk0n+Mhaq4H+8GfqCzbvQgw4NmnTE2TrGcg==
X-Received: by 2002:a17:906:7b96:: with SMTP id s22mr65320610ejo.213.1577640796290;
        Sun, 29 Dec 2019 09:33:16 -0800 (PST)
Received: from [192.168.0.104] ([91.139.216.39])
        by smtp.googlemail.com with ESMTPSA id c19sm5162660edu.76.2019.12.29.09.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2019 09:33:15 -0800 (PST)
Subject: Re: [PATCH v3 6/6] clk: qcom: Add video clock controller driver for
 SC7180
To:     Taniya Das <tdas@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org
References: <1577428714-17766-1-git-send-email-tdas@codeaurora.org>
 <1577428714-17766-7-git-send-email-tdas@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <8f744444-428c-56e2-2565-35b55f1e4aae@linaro.org>
Date:   Sun, 29 Dec 2019 19:33:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577428714-17766-7-git-send-email-tdas@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taniya,

On 12/27/19 8:38 AM, Taniya Das wrote:
> Add support for the video clock controller found on SC7180
> based devices. This would allow video drivers to probe
> and control their clocks.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/clk/qcom/Kconfig          |   8 ++
>  drivers/clk/qcom/Makefile         |   1 +
>  drivers/clk/qcom/videocc-sc7180.c | 259 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 268 insertions(+)
>  create mode 100644 drivers/clk/qcom/videocc-sc7180.c
> 

<cut>

> +static const struct freq_tbl ftbl_video_cc_venus_clk_src[] = {
> +	F(19200000, P_BI_TCXO, 1, 0, 0),

Do you know is this frequency (19.2MHz) has real usage? The lower freq
I've seen for Venus was 75MHz.

> +	F(150000000, P_VIDEO_PLL0_OUT_MAIN, 4, 0, 0),
> +	F(270000000, P_VIDEO_PLL0_OUT_MAIN, 2.5, 0, 0),
> +	F(340000000, P_VIDEO_PLL0_OUT_MAIN, 2, 0, 0),
> +	F(434000000, P_VIDEO_PLL0_OUT_MAIN, 2, 0, 0),
> +	F(500000000, P_VIDEO_PLL0_OUT_MAIN, 2, 0, 0),
> +	{ }
> +};
> +
-- 
regards,
Stan
