Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800B0CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52ABC20679
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572448557;
	bh=E2VeR4DpC8qlFCo3RxqjxseT2yjTygu+f2xhqjwmhAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fep0H5wnwS1a/W5zWjQ2W3JoYrgay7i+ogtL1gXDhJgSW7QOEUuPWAMZs6xOT9NEp
	 iBtzJb36Bnh4457OO3tsJ2dzB6GN8g4/b9Pq+u6FF0x8QfRFEfSEMzV7uueanZlrUL
	 35bBsTJRfkFh50kMJ2/BqrMSQ5ZTdQdHR19LeboA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfJ3PP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:15:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35217 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfJ3PP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:15:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id k2so2059413edx.2;
        Wed, 30 Oct 2019 08:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y+WK5GKecV/KBDUIy9GWTH4bwpBGohOzkeFmBQZf1R0=;
        b=nfWQzkkf4PhLpKtA94RjGAhAZG4wqbg/1DGKs9XoN9ILhlAKw3anczuzfN9NpGDRRJ
         XIOP3/cVplHJCsQDuoltwlOgecJaKjLACrNJMOYsXp0Zjo3QIJWCJ+cVlmaMCIFIcWmr
         204QilFckeUrG2141XFOBHcZ0ZwG3wA6KIL/8Zw5KADiX8djTmsh7/VzyVDTRqYVCJwy
         DubfI8lvWWkJ1eeJZsR1sj5LwnZG41IrrsWGD3PM7UMPA4sQKucwz7+/Xp34Q8IDR3Dc
         1npOEJOzQipz2F5HFaAuHgdQf6s0Ie8sTOgssHAcOkciUkSMjp3NL7/M2hAhZg2fLZJa
         CR1w==
X-Gm-Message-State: APjAAAUGQXGq6ANzKT4oW5bKtBAgfTvpAqxqIU+7lRYqXzq5Iw1ZsG2Q
        Ph5JTp63Z0JJQ01FpI/AzNU=
X-Google-Smtp-Source: APXvYqzW36JMfOP+9Ckkk57hi580dnNzKCE+o0IDHat7XROi4wbyfWLMRXpJoPeDKapILbXIURAeVg==
X-Received: by 2002:a17:906:85da:: with SMTP id i26mr25000ejy.186.1572448553957;
        Wed, 30 Oct 2019 08:15:53 -0700 (PDT)
Received: from pi3 ([194.230.155.180])
        by smtp.googlemail.com with ESMTPSA id 32sm6111edq.23.2019.10.30.08.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 08:15:53 -0700 (PDT)
Date:   Wed, 30 Oct 2019 16:15:51 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] soc: samsung: exynos-asv: fix potential overflow
 in multiply
Message-ID: <20191030151551.GA25718@pi3>
References: <20191030145457.10120-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191030145457.10120-1-colin.king@canonical.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 02:54:57PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The multiplication of opp_freq by MHZ is performed using unsigned int
> multiplication however the result is being passed into a function where
> the frequency is an unsigned long, so there is an expectation that the
> result won't fit into an unsigned int. Fix any potential integer overflow
> my making opp_freq an unsigned long.  Also change from %u to %lu format
> specifiers
> 
> Addresses-Coverity: ("Unintentional integer overflow")
> Fixes: 5ea428595cc5 ("soc: samsung: Add Exynos Adaptive Supply Voltage driver")

Although I like the idea of using the same type as the
dev_pm_opp_find_freq_exact() interface, but I do not agree with severity
of this. This is currently only ARMv7 (32-bit) driver, so using long
does not change anything. It's still 4 bytes and it is still up to 4
GHz.

Therefore on ARMv7, the possibility of overflow is exactly the same as
before. Nothing was fixed.

If we really want to fix it, then all this should be "long long" or
value should be checked while parsing DT.

Semantically I agree, so I would prefer to adjust only the commit
message.

Best regards,
Krzysztof


> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/soc/samsung/exynos-asv.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/samsung/exynos-asv.c b/drivers/soc/samsung/exynos-asv.c
> index 8abf4dfaa5c5..d66fc74379a3 100644
> --- a/drivers/soc/samsung/exynos-asv.c
> +++ b/drivers/soc/samsung/exynos-asv.c
> @@ -30,7 +30,7 @@ static int exynos_asv_update_cpu_opps(struct exynos_asv *asv,
>  {
>  	struct exynos_asv_subsys *subsys = NULL;
>  	struct dev_pm_opp *opp;
> -	unsigned int opp_freq;
> +	unsigned long opp_freq;
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(asv->subsys); i++) {
> @@ -51,7 +51,7 @@ static int exynos_asv_update_cpu_opps(struct exynos_asv *asv,
>  
>  		opp = dev_pm_opp_find_freq_exact(cpu, opp_freq * MHZ, true);
>  		if (IS_ERR(opp)) {
> -			dev_info(asv->dev, "cpu%d opp%d, freq: %u missing\n",
> +			dev_info(asv->dev, "cpu%d opp%d, freq: %lu missing\n",
>  				 cpu->id, i, opp_freq);
>  
>  			continue;
> @@ -68,11 +68,11 @@ static int exynos_asv_update_cpu_opps(struct exynos_asv *asv,
>  						new_volt, new_volt, new_volt);
>  		if (ret < 0)
>  			dev_err(asv->dev,
> -				"Failed to adjust OPP %u Hz/%u uV for cpu%d\n",
> +				"Failed to adjust OPP %lu Hz/%u uV for cpu%d\n",
>  				opp_freq, new_volt, cpu->id);
>  		else
>  			dev_dbg(asv->dev,
> -				"Adjusted OPP %u Hz/%u -> %u uV, cpu%d\n",
> +				"Adjusted OPP %lu Hz/%u -> %u uV, cpu%d\n",
>  				opp_freq, volt, new_volt, cpu->id);
>  	}
>  
> -- 
> 2.20.1
> 
