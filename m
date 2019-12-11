Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0731DC2D0C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF7A214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vVvt1OVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfLKFGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 00:06:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33927 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfLKFGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 00:06:52 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so10171575pgf.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 21:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ifjsPJTQzkQ2KlgKp76bEF84qFDaLY48iNcB7Bofick=;
        b=vVvt1OVHSL5OQJeIbM36oMNSMhmv1CaIQUmRcBppurMgdJYqfT4JjdCQECqr5i9T9j
         SnaN/VrPUt5s6UNCAyFFMkg401bPAC1kakvx6GZ7yl9cMeqVjr2Dv3YBwCMrQXSVxRaR
         M36+jQ48T8w5U/vVOk+BEyfH7Cu068fg+ppB1MF/h7Odyacbk4Fv1MyZ3e8RWJYPe8Wj
         DAixZ8kOrMDsB8jRPudLtwUR1yGesqx3/VUm2FiBcFXwrQ4Dh7t7DzJfcahilT8IIKEP
         hWtIIUZbJyMyFwXrQRsz5EwWCGWRPZmrPubWqVNs6ZZjERYpBDbNL9XnyRaYCjFhNIA3
         iCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ifjsPJTQzkQ2KlgKp76bEF84qFDaLY48iNcB7Bofick=;
        b=EJjp+dG5X9UNA27rumGOHxOOV2yjlsMEBOeSPHy2EnAgc+pmEF6rZRgmiItE975DWt
         Evv3RAQcXRAp2WQbRdDaJcfvy9zv3PlvE+GCcl+sOAjYW9lobXyAsTGABDlIhI4yrK12
         JGufoCdw177gnzYjKooXdb0YzS2BAnKlCEb7Ya5kW/JwHvNQJm/FfZCC/3wC9d+ip0Xk
         mtSwWiGUv2XW1UrjDTdOyWGZBMak32uNKFOfItboH20DCYc+MXjtZ8Ei9Y/xge3hIZ5y
         259uQHa9h5/+mr1HUQL3u0QoMGodFhQOnOMqgEGtMZ8vuKsxBfHd0dt9a/VjkSVV9vCG
         zB2g==
X-Gm-Message-State: APjAAAWUvoZYy06GaW0m3SYDerSbDEmG5TPr/InBXSXWxsx0So8+Gjtu
        K8Q8d1CR6kK47KL/LCrD3jCSvg==
X-Google-Smtp-Source: APXvYqxbK292MGhDd5Bk+LBvMluPSMJquMNhdtJad9GSB25pwbMbUKFckEq1WO5QxUgL15z0v3EMrg==
X-Received: by 2002:a63:7843:: with SMTP id t64mr2068017pgc.144.1576040812087;
        Tue, 10 Dec 2019 21:06:52 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id w5sm763907pgb.78.2019.12.10.21.06.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 21:06:51 -0800 (PST)
Date:   Wed, 11 Dec 2019 10:36:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the cpufreq-arm
 tree
Message-ID: <20191211050649.2dgu3ufn2ltkgvce@vireshk-i7>
References: <20191211142100.423ef8b0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211142100.423ef8b0@canb.auug.org.au>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-12-19, 14:21, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   dfb3f45d17b6 ("cpufreq: scmi: Match scmi device by both name and protocol id")
> 
> is missing a Signed-off-by from its committer.

Fixed, thanks.

-- 
viresh
