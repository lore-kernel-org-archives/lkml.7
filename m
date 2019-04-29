Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A52C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 05:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B022075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 05:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FLVNsElE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfD2FQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 01:16:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37939 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfD2FQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 01:16:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so4732676pfo.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 22:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rV+0C/EON+pvDwsZQc/OUGkTOpYnucsaznZ9bpbDOkk=;
        b=FLVNsElEyponMvp2tw0g1/rwadVUC3oIEVxbL5Pt/yKLjYQyZcB+f0QArwRbnoGwyw
         RK+akSUCU0EiZcbuUnu5FyzuCStfNuoV6RDGDf/Nb1ajKutbPduzMvA6zW+uYFR5igX/
         eeThXFLw3vSjQiJl+mctB21oEXlFPYjOKRlLOU9zOm7GRUSmW25Ny4dpk9Y8mEGxM4Qf
         uoV4jvsPyGUcELNXu08VUCbxljMIQzZBw1SArflS8kE7KnixyCPNYiMnS7mb2LPOHFeC
         oeANbLiO4apfOBtZRuoAnMtpiH34xCvO1YG+qtQurskT7A3KC0WSf2Fs+uWIpLZ/NrBK
         yMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rV+0C/EON+pvDwsZQc/OUGkTOpYnucsaznZ9bpbDOkk=;
        b=bXk/b4FSojlOTYhQVsYt8WCv1bQLqBV/AMP+AZRISkwNks7ufCxz/shhtblgNGOyCk
         +OCYDUs395qbpxG174fzo629u9gWOx3C+TWVBiejaUV0pfVQblwbSxPzbFZC6oiDH5l6
         9DWgBgkvl7SnSfZBMYCAkFVCcpoVA0E7lXnUPwAZE5FxjcBTQZqn9bfm4CmjihTzXHSq
         hGJ1+oZocsWP8lF3lwOcuwVZlj6QKuPrD7xNCCO6bZoCcfvzgjYne6l6yXUJBC7jQ6rW
         LZbaknxlQt1AlSBeYfB/C05j+e/Hgk5ID/wOLX3ZIO8daaSnw4uVETfWETchNnXw4C5h
         CdfQ==
X-Gm-Message-State: APjAAAVgldKCKSW55gaM0kx33izch7UHWjIfkQOxaP2A2IDuCSf9wtvN
        tl10MljCOmiIUN+93FVvcCzw/w==
X-Google-Smtp-Source: APXvYqw9OtoTofFhkVXnADqbQ31Jt9Iv4WhmeGWuuddOU2HvaUXX65CnrzcWl37LRwe1n2EXyX3XfA==
X-Received: by 2002:a63:730f:: with SMTP id o15mr38706699pgc.315.1556514999383;
        Sun, 28 Apr 2019 22:16:39 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id g6sm2474079pgi.70.2019.04.28.22.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 22:16:38 -0700 (PDT)
Date:   Mon, 29 Apr 2019 10:46:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vabhav Sharma <vabhav.sharma@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        Andy Tang <andy.tang@nxp.com>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: Re: [PATCH v4] cpufreq: qoriq: add support for lx2160a
Message-ID: <20190429051637.d5y4cfiekrysli3w@vireshk-i7>
References: <1556261743-20584-1-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556261743-20584-1-git-send-email-vabhav.sharma@nxp.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-04-19, 06:55, Vabhav Sharma wrote:
> Enable support of NXP SoC lx2160a to handle the
> lx2160a SoC.
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Acked-by: Scott Wood <oss@buserror.net>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Changes for v4:
> - Incorporated review comments from Stephen Boyd
> 
> Changes for v3:
> - Incorporated review comments of Rafael J. Wysocki
> - Updated commit message
> 
> Changes for v2:
> - Subject line updated
> 
>  drivers/cpufreq/qoriq-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index 4295e54..81f0288 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -284,6 +284,7 @@ static const struct of_device_id node_matches[] __initconst = {
>  	{ .compatible = "fsl,ls1046a-clockgen", },
>  	{ .compatible = "fsl,ls1088a-clockgen", },
>  	{ .compatible = "fsl,ls2080a-clockgen", },
> +	{ .compatible = "fsl,lx2160a-clockgen", },
>  	{ .compatible = "fsl,p4080-clockgen", },
>  	{ .compatible = "fsl,qoriq-clockgen-1.0", },
>  	{ .compatible = "fsl,qoriq-clockgen-2.0", },

@Rafael, please apply this version. Thanks.

-- 
viresh
