Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9010C3A59F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 00:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C35A21783
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 00:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3sGogWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfHRAKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 20:10:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35213 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfHRAKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 20:10:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id d85so5056188pfd.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 17:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2P41VmpgH709MNjHtQjn5kqjWZE/eE2T7peV7aC9s3c=;
        b=o3sGogWvJviB7R6PAM2ZAPgtxpcOjEugWQ8M4NTCjhEyK7O1HITcRLaHJBElmqbjao
         tsADmvTpZRmCbm9xUVuEcaLTIvcS8H0Yg18MEcyLqpRENzCq4kDA2cI34BF5DMy9CPDB
         akbgXsac8k4R954sOTrsifvNYGKYx45C67svRpjGoWWdiShZ1f0oTl7fLWh6fuJTEJQy
         I9jYrG8UreC7ov8hIIAeh38qcNvSjY3HYex+hT1E/xDcOX/ZWtvT6+CoGHNNDoqDrkc4
         X0R+3Pw87KKTdaSuHYJmJm4FhnGvrk90hvxZ2JgT9pLusd2W2O2eg0+SJ9K8DKRLMcfM
         EHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2P41VmpgH709MNjHtQjn5kqjWZE/eE2T7peV7aC9s3c=;
        b=ADO02myVrQI4uDM/+l00DjX4bUZ9taii2y7+p0fy4v117evo1YM9VEtaZq4DrdI431
         6Yq07ZQLjHjELMg+1Gkbd+lIEp6mDEaooZkswRDdDkXbIy+Eby6s6KbnR17YnDaBRXwY
         XM7JTqbFaF3Skng3vajKICJ3M8GMuUZFBdSyDq8y5NBF81S1ELcpEj2hnAei1rSitU1+
         uLQIP+Pu5cQ6NfWwsnj5CoDbKhpmjiN9XkzfrJfcktPudydh0Aq2enA/axXKu2TJPjw2
         KcGp6LBubI6Rm34FJ453McOd6y6pwvi5y7RJUil3Sy5PLW9zLt2I8pchsnYHRuGad0c2
         1c4w==
X-Gm-Message-State: APjAAAWMwFgiLJLPHYncdyUFvLSMCxyI3bk1bdGyL0Zabz8s2cOSv/8W
        AZFpvlMTY1uVkrPlFFvOnJBtvQ==
X-Google-Smtp-Source: APXvYqxx9Yp9jc1UsaQxsOLh+ZbdBrM65L0qU1Ys+W3yCPVRifCRRIBAFjP9lfKXMe4c4uP55xWvtA==
X-Received: by 2002:a65:518a:: with SMTP id h10mr11820901pgq.117.1566087053602;
        Sat, 17 Aug 2019 17:10:53 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h11sm10630488pfn.120.2019.08.17.17.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 17:10:52 -0700 (PDT)
Date:   Sat, 17 Aug 2019 17:12:35 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Dewar <alex.dewar@gmx.co.uk>
Cc:     agross@kernel.org, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl/qcom: Fix -Wimplicit-fallthrough
Message-ID: <20190818001235.GX26807@tuxbook-pro>
References: <20190817082520.7751-1-alex.dewar@gmx.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817082520.7751-1-alex.dewar@gmx.co.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 17 Aug 01:25 PDT 2019, Alex Dewar wrote:

> In pinctrl-spmi-gpio.c there is a switch case which is obviously
> intended to fall through to the next label. Add a comment to suppress
> -Wimplicit-fallthrough warning.
> 

Thanks for your patch Alex, this was fixed in 6161dc03587b ("pinctrl:
qcom: spmi-gpio: Mark expected switch fall-through")

Regards,
Bjorn

> Signed-off-by: Alex Dewar <alex.dewar@gmx.co.uk>
> ---
>  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> index f39da87ea185..b035dd5e25b8 100644
> --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> @@ -813,6 +813,7 @@ static int pmic_gpio_populate(struct pmic_gpio_state *state,
>  	switch (subtype) {
>  	case PMIC_GPIO_SUBTYPE_GPIO_4CH:
>  		pad->have_buffer = true;
> +		/* FALLS THROUGH */
>  	case PMIC_GPIO_SUBTYPE_GPIOC_4CH:
>  		pad->num_sources = 4;
>  		break;
> --
> 2.22.1
> 
