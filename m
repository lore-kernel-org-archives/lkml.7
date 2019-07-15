Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20397C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE242086C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aDeZNMto"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732814AbfGOVpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:45:31 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36405 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730984AbfGOVpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:45:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so8974938plt.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 14:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hOM2v5hU56mID9YuYmmucDqwTVT51b3w3HZDsPVe9j4=;
        b=aDeZNMtooxl695Jq44V8IEomR07n7GCItQuCyk51sAt4aNCq3TYnWF4Xh3UG6ODhdp
         jtMBYRlMSxN9nyMw4rCHobIDaomN9XCC/6UPxEwHVxs+6ZrtelWkKu6kuExJb1bjm0JI
         DjwmoL0ILn4xq0PFZ3h5zIjDQySyOJh9n5kY020tFPSq2Nbug5FxawMlgX/WQlTOLv3K
         ijeQgwobaTr9/539aQaWP1u4idf2IoHiAWqN0qCE1Qo5uYCItCHK+2G2pBEdJx7rmeyz
         OTUitPvnWzoQ45NJHCVpzC3PHDKzj5ZHPRxq/zlT35MqbPfjy417btF9rf8b0Q+LxCgL
         rGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hOM2v5hU56mID9YuYmmucDqwTVT51b3w3HZDsPVe9j4=;
        b=kQxbbfpaAX3NVeN7rXEQjTong5Jevem9k6YZY/PJAD/H6amJRzGoEoqntaOC1gLaaz
         82GBLKMFbSxCHjegre7kq6i3r49hKOVW0wFKYb3AI8Xjaw+XgfFrVFSk+ihBVK5i+WhX
         jxfQWBwud23M4m1Xmw08Lhv3dCDV63pxtkSPTj4NYVf0pYwOrFH2S2N/e6MgRVbtuEwS
         iHBjvVLiArfQgCZiH6LjAoi/AbXiIDlbayCsMDiFFDUkia+KIY12MvtiaALA6z9RLC/a
         vEgGq6VSqZMgQ2KG+rn+uj0vjoVRIv/Vgw/0/gDQ4ztTYuL1bMrw03cRvAzFbYt59KTC
         jKHw==
X-Gm-Message-State: APjAAAVF/Gm5MPDqBkjtx8n2Xf9RKpWsrWf/3IvncDGfKCsFPhPUAz3j
        jufomBnsNInRNjuydm6KiL9NZA==
X-Google-Smtp-Source: APXvYqygmIThR7CWZd2S/zUr5WJnIk/hHSphgbemuWJ1x8uUYo3hBc6a/yRRRFF2AOHr67pE+h8zfQ==
X-Received: by 2002:a17:902:86:: with SMTP id a6mr31188398pla.244.1563227130294;
        Mon, 15 Jul 2019 14:45:30 -0700 (PDT)
Received: from tuxbook-pro (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id b24sm17017167pfd.98.2019.07.15.14.45.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 14:45:29 -0700 (PDT)
Date:   Mon, 15 Jul 2019 14:46:47 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Neusch?fer <j.neuschaefer@gmx.net>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1] clk: Add devm_clk_{prepare,enable,prepare_enable}
Message-ID: <20190715214647.GY7234@tuxbook-pro>
References: <1d7a1b3b-e9bf-1d80-609d-a9c0c932b15a@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d7a1b3b-e9bf-1d80-609d-a9c0c932b15a@free.fr>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 15 Jul 08:34 PDT 2019, Marc Gonzalez wrote:

[..]
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c0990703ce54..5e85548357c0 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -914,6 +914,18 @@ int clk_prepare(struct clk *clk)
>  }
>  EXPORT_SYMBOL_GPL(clk_prepare);
>  
> +static void unprepare(void *clk)

This deserves a less generic name.

> +{
> +	clk_unprepare(clk);
> +}
> +
> +int devm_clk_prepare(struct device *dev, struct clk *clk)
> +{
> +	int rc = clk_prepare(clk);
> +	return rc ? : devm_add_action_or_reset(dev, unprepare, clk);
> +}
> +EXPORT_SYMBOL_GPL(devm_clk_prepare);
> +
>  static void clk_core_disable(struct clk_core *core)
>  {
>  	lockdep_assert_held(&enable_lock);
> @@ -1136,6 +1148,18 @@ int clk_enable(struct clk *clk)
>  }
>  EXPORT_SYMBOL_GPL(clk_enable);
>  
> +static void disable(void *clk)
> +{
> +	clk_disable(clk);
> +}
> +
> +int devm_clk_enable(struct device *dev, struct clk *clk)

clk_enable() is used in code that can't sleep, in what scenario do you
envision it being useful to enable a clock from such region until devres
cleans up the associated device?

> +{
> +	int rc = clk_enable(clk);
> +	return rc ? : devm_add_action_or_reset(dev, disable, clk);

devm_add_action_or_reset() allocates the devres object with GFP_KERNEL,
so this won't work.

> +}
> +EXPORT_SYMBOL_GPL(devm_clk_enable);
> +
>  static int clk_core_prepare_enable(struct clk_core *core)
>  {
>  	int ret;
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 3c096c7a51dc..d09b5207e3f1 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -895,6 +895,14 @@ static inline void clk_restore_context(void) {}
>  
>  #endif
>  
> +int devm_clk_prepare(struct device *dev, struct clk *clk);
> +int devm_clk_enable(struct device *dev, struct clk *clk);
> +static inline int devm_clk_prepare_enable(struct device *dev, struct clk *clk)

devm_clk_prepare_enable() sounds very useful, devm_clk_prepare() might
be useful, so keep those and drop devm_clk_enable().

Regards,
Bjorn

> +{
> +	int rc = devm_clk_prepare(dev, clk);
> +	return rc ? : devm_clk_enable(dev, clk);
> +}
> +
>  /* clk_prepare_enable helps cases using clk_enable in non-atomic context. */
>  static inline int clk_prepare_enable(struct clk *clk)
>  {
> -- 
> 2.17.1
