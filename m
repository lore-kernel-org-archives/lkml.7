Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F46C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 04:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B842166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 04:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KeT43MVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733115AbfKGEY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 23:24:56 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46664 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733034AbfKGEYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 23:24:55 -0500
Received: by mail-io1-f66.google.com with SMTP id c6so747469ioo.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 20:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NkSeoMnuWg5T7g24I3SC9PrtQXIiA61Z2VNxVdt/qfE=;
        b=KeT43MVjU2B4DpAy2SYkA6NIhlp0NXSIvrPo/xsJrBm01MgR7r5J7gwjL6ER2SKvvu
         6zZI/iChBctFpUxgVnyp2K9HXsspnceqjcg0uSaOkMkVpQYDzb35q4B4mpiwWuV4v6yj
         34iZRafJSCVKeLd8feC04XhdnMKrH3chAmGDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NkSeoMnuWg5T7g24I3SC9PrtQXIiA61Z2VNxVdt/qfE=;
        b=YhA5gC7SJrdM1FIZUIeTJsMql+Sx9ir5s3kfDH6F8a4YbO8khYNP214HBNVjdSmHnq
         4nvEJ0u2sTKANxX7wnenHuYnKqRUr55qi9O3kTYHFFGBV3MYFVyar5Vj2Nxxdg48SI23
         IpDB4K+14kIjbA82OU/bTiKn4FcwwQiJd/jpzJUbdk7PjscLcgDFDv42e+4jRgjUzN86
         ya8VSqqTHYRT5oP4+6GQ/vp2LaSJvkMxWHopaseMhQ0ZVIHlDHprpqh9UYao26Usr+Yy
         9GMY744vB9ABr6OjBsPam6UXu6oI3VDPoD9jD/taimh6KAjKuFySbqtznosmJ2fu9P3K
         hkCw==
X-Gm-Message-State: APjAAAWaip6ZUW6Na6cHvRcOrriYmCsF6p5K9XEkJ3PDlz2WsMzIbFh2
        GCSRXLY+q1TBD0ZmLr6qkDP+q9Bi/Do=
X-Google-Smtp-Source: APXvYqzzgAzcAxfsI8gc1lqs+bJg/AzCKvORydeuJt3kMGYpAAALapFBx/djM8gmdDlxdIkIoxo8/w==
X-Received: by 2002:a6b:7213:: with SMTP id n19mr1204010ioc.219.1573100694521;
        Wed, 06 Nov 2019 20:24:54 -0800 (PST)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id k22sm89282iot.34.2019.11.06.20.24.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 20:24:53 -0800 (PST)
Received: by mail-il1-f179.google.com with SMTP id a7so157011ild.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 20:24:53 -0800 (PST)
X-Received: by 2002:a92:109c:: with SMTP id 28mr1827293ilq.142.1573100692855;
 Wed, 06 Nov 2019 20:24:52 -0800 (PST)
MIME-Version: 1.0
References: <1572524473-19344-1-git-send-email-tdas@codeaurora.org> <1572524473-19344-2-git-send-email-tdas@codeaurora.org>
In-Reply-To: <1572524473-19344-2-git-send-email-tdas@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 Nov 2019 20:24:41 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UjwO25HeVtYvzqEdUxyA4ED18ZxcwEaYVzBGRFTa2FTw@mail.gmail.com>
Message-ID: <CAD=FV=UjwO25HeVtYvzqEdUxyA4ED18ZxcwEaYVzBGRFTa2FTw@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] clk: qcom: clk-alpha-pll: Add support for Fabia
 PLL calibration
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 31, 2019 at 5:21 AM Taniya Das <tdas@codeaurora.org> wrote:
>
> @@ -1141,15 +1160,11 @@ static int alpha_pll_fabia_set_rate(struct clk_hw *hw, unsigned long rate,
>                                                 unsigned long prate)
>  {
>         struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
> -       u32 val, l, alpha_width = pll_alpha_width(pll);
> +       u32 l, alpha_width = pll_alpha_width(pll);
>         u64 a;
>         unsigned long rrate;
>         int ret = 0;
>
> -       ret = regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
> -       if (ret)
> -               return ret;

My compiler happened to notice that with the change to this function:

drivers/clk/qcom/clk-alpha-pll.c:1166:6: error: unused variable 'ret'
[-Werror,-Wunused-variable]
        int ret = 0;

-Doug
