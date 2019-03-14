Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8DAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A76420854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGJbpjxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfCNMPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:15:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37396 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfCNMPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:15:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id y15so5611594wro.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 05:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P8Musrq+Zf+Vn7QYOvAJ2kgQ4P8kl8oepHXj9wkd3GA=;
        b=GGJbpjxB7uPfBqHRz/ucVfC1craEJiLjv6ESissugbbKUE5jF75Cg5PDhH3kamtnS9
         dFY4dGb9fxqD8D7aMhmyY1i0qVay1r2TK8fsssUWIsTLIlcfew+rCpBEFa8yvr1UhDkM
         mJEzD/DJR60fl5oY5gOKB5m4+EZ1tb0i5qwrJPLDN7HtNDbZlHlEWiQjmAMmT20Prl4R
         1KpR9nojkwpm+IOfCFk+ilW6u1O9KjACz+oxUHuZWBNtyL2hCe2pJiIY+nO06LXK2d3x
         UDokWQtmR9ThGVefQauo2Q3rhlfS2JufOF+H4Y1bUnQO+5MlW5dfOnGbX91uTp/QTDtp
         HAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P8Musrq+Zf+Vn7QYOvAJ2kgQ4P8kl8oepHXj9wkd3GA=;
        b=s3EnL2GfxWMJhAM2gP19WHGkAzvcTqQCn1Tofv2TMyJ5GMptYcMpEhDA0dcUbFWgpL
         5mqD+ir0ecw1oPwWgh174N6kokiz3qaYDgGGDrP6pV6FJWPTYVn43m0Y2ud4I+CwWphK
         0/c/LQIu9s/rHsch44MZ4IE+mnxVKp9BkEqSYyShiFDp5Jo7hgxraX5rw9p2oVQxsvq6
         TKFk/xkR6fi67O1hi+tsdMOxJiZeMP7Tk8uwHZn+VTlomlZ5jE4h8ClHpSQkdtm+1uiq
         k8RrCGS2LxhW/kcnjghVlDsaXS9QcC4fr86RgAUvgcnQgs1btU1r7GoyWl3Kc7Qfftgg
         onIQ==
X-Gm-Message-State: APjAAAU3J9T5oDMFuSHjX6hSB5iimd40imlOIIARaPMEPi+bXD8HEBnl
        ku8fMmVXV6zp6ePt4bp9iDHzVQ==
X-Google-Smtp-Source: APXvYqyIKACOcbNCjO/NnBPLjcHRAhMfJhnAqlC++nMC5MUv1Jm9vyeCd2PDhOjydD6d04wPCcdxBQ==
X-Received: by 2002:a5d:464b:: with SMTP id j11mr24102376wrs.307.1552565745062;
        Thu, 14 Mar 2019 05:15:45 -0700 (PDT)
Received: from apalos (ppp-94-64-206-130.home.otenet.gr. [94.64.206.130])
        by smtp.gmail.com with ESMTPSA id o127sm1856038wmo.20.2019.03.14.05.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 05:15:44 -0700 (PDT)
Date:   Thu, 14 Mar 2019 14:15:41 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org,
        Christian Neubert <christian.neubert.86@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] clk: mvebu: armada-37xx-periph: Fix initialization for
 cpu clocks
Message-ID: <20190314121541.GB19385@apalos>
References: <20190313163558.6705-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313163558.6705-1-gregory.clement@bootlin.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gregory, 
> The clock parenting was not setup properly when DVFS was enabled. It was
> expected that the same clock source was used with and without DVFS which
> was not the case.
> 
> This patch fixes this issue, allowing to make the cpufreq support work
> when the CPU clocks source are not the default ones.
> 
> Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada 37xx")
> Cc: <stable@vger.kernel.org>
> Reported-by: Christian Neubert <christian.neubert.86@gmail.com>
> Reported-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  drivers/clk/mvebu/armada-37xx-periph.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
> index 1f1cff428d78..26ed3c18a239 100644
> --- a/drivers/clk/mvebu/armada-37xx-periph.c
> +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> @@ -671,6 +671,17 @@ static int armada_3700_add_composite_clk(const struct clk_periph_data *data,
>  		map = syscon_regmap_lookup_by_compatible(
>  				"marvell,armada-3700-nb-pm");
>  		pmcpu_clk->nb_pm_base = map;
> +
> +		/*
> +		 * Use the same parent when DVFS is enabled that the
> +		 * default parent received at boot time. When this
> +		 * function is called, DVFS is not enabled yet, so we
> +		 * get the default parent and we can set the parent
> +		 * for DVFS.
> +		 */
> +		if (clk_pm_cpu_set_parent(muxrate_hw,
> +					  clk_pm_cpu_get_parent(muxrate_hw)))
> +			dev_warn(dev, "Failed to setup default parent clock for DVFS\n");
>  	}
>  
>  	*hw = clk_hw_register_composite(dev, data->name, data->parent_names,
> -- 
> 2.20.1
> 
Applied this and selected only

CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y

After changing the governor from 'powersave' to 'performance' the board
completely froze (i even lost access to the serial port)

Cheers
/Ilias
