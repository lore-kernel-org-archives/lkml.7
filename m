Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1639C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEC2218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FZp1XDmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfDXEBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 00:01:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40558 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfDXEBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 00:01:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so8562310pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 21:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=diRklryQQJnoiQLs7RRdCQUcCRp6YjW5rvtbtHyh1S0=;
        b=FZp1XDmAv33euV2xXFccCcmPHxIlYbit0UknuHyND8T5CgNOwpKoSgKEAKuDlJKXm7
         QhIPTL8d4GQIkdHBYv4odoX0CCQHqUGC1UgHh2ODMiSX8nxgQDbZ3biJUk+oa1T0mFLc
         TId4HnKXwxtuQQdEdMC5+iv90No4VRopC0lPlGfmIu1jdT5GtpYzNpLCPL18/D3oZ2mp
         Dr8aJRXqmCmNO8QPUpmB4nRCFkTXi3vCbMtiCriJlkCLZn0MCGveUOKllYRPEnCIlih4
         6bXmBbEU7iRv92X2ofKUgWvKxzrrnTagNOu1hgmx18Egu/xLTZfv4R712To31fSK4u79
         c1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=diRklryQQJnoiQLs7RRdCQUcCRp6YjW5rvtbtHyh1S0=;
        b=cZxO5zKkT4LO20D8E0AqaH7J8NXZEO2RLh9pTKXYB0ZkxmebBLpi308LNlt9vsg3iH
         MHZC/ipW9dYZX4Js1wlsn66m9/Gq/fZD917DFO374Ffzjg7/EiAQk7dgQ8kjZmp8eX9g
         0kPvaMtGB5MJotmr7SPfx+KYwXLic0NA3nm3EJebbnikFgYLnO5+eKh9WBxxKXAVfvp1
         3HLlFt8dqejo3NX9Ll26QHXfSJLkqKp5lfve3hfpwam557vyAE8713S+u8+ebUtAGH4F
         grYLN/gWovmNv9fqVZwqnlIMgD+OqYoh2TYmY3r+xcP5qq+33mfoDIF7IA1Rp5FvUjg4
         dkFg==
X-Gm-Message-State: APjAAAVSuZJ867QrC/33PBM+5HpRIeRwjWbtxh0Hv+kGEY7Ryts4VB8J
        ebwamt+sMG4sp7fOdOgFTgqewz2gXhc=
X-Google-Smtp-Source: APXvYqwACHDJwHgzJ4EMy29/HZzw4s4WnbGhvpdWTbvCv0+QcL0w3NDlp1nEfH8m/ISKTZQdZ+7ILg==
X-Received: by 2002:a63:5d44:: with SMTP id o4mr28435994pgm.15.1556078476263;
        Tue, 23 Apr 2019 21:01:16 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id o67sm27194130pga.55.2019.04.23.21.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 21:01:15 -0700 (PDT)
Date:   Wed, 24 Apr 2019 09:31:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     andy.tang@nxp.com
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qoriq: Add ls1028a chip support
Message-ID: <20190424040113.aiyaia2p7xrn5ywo@vireshk-i7>
References: <20190424023223.29614-1-andy.tang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424023223.29614-1-andy.tang@nxp.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-04-19, 10:32, andy.tang@nxp.com wrote:
> From: Yuantian Tang <andy.tang@nxp.com>
> 
> Enable cpufreq feature on ls1028a chip by adding its compatible
> string.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---
>  drivers/cpufreq/qoriq-cpufreq.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index 4295e54..d308c4d 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -280,6 +280,7 @@ static int qoriq_cpufreq_target(struct cpufreq_policy *policy,
>  
>  	{ .compatible = "fsl,ls1012a-clockgen", },
>  	{ .compatible = "fsl,ls1021a-clockgen", },
> +	{ .compatible = "fsl,ls1028a-clockgen", },
>  	{ .compatible = "fsl,ls1043a-clockgen", },
>  	{ .compatible = "fsl,ls1046a-clockgen", },
>  	{ .compatible = "fsl,ls1088a-clockgen", },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
