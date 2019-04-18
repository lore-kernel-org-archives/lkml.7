Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E764BC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FD4206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d45XVkiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388327AbfDRJAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:00:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38427 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfDRJAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:00:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so892578pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 02:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AR1RP7f6kZifZ7FeB0P9Q2kh0p04YoT/2fg9i6FFRjE=;
        b=d45XVkiBIHj4d50vGS6UL25afAP+GwNkW1AT4uquixx64Bkbkxtg+qchQxRY0yfcib
         WnEQAf+YRh2PP/StgKkC++L2w3Dn8uzkN6tpKKlE44ZQk6gDmg22ebPBEWl47M/wkVMd
         R926WMDAUrwrJTGVNGcevasOORF6WfPbThgZ0SmKYVqIiY5eW78q718X7woBxj+Xc/J0
         rdDEvFYgsKdymHxppa9sncmUU3lvXXP2XqfM+FuYr1IQS0RiR5LGUE+kHA+lRB5QGV1b
         BGwqPU2TGLcr8QSdWBl1562TJkl+sxaD77CZXH/Uqwu29q/+/6cZ43e2zb7v0p8Zka9w
         rvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AR1RP7f6kZifZ7FeB0P9Q2kh0p04YoT/2fg9i6FFRjE=;
        b=m0c8y9dPf5iB/bjhamMOaUPpsXD9JdhwRtCWCZrhKE4xBzMD+eky5E19xMMbH6PNlX
         OS6XYIbDLZ2xbNCZOLqCYTeQJebE6+UlzzK/NKBnq8VLqjGJf5mVizFSdt+F5YyWuhbc
         umZ1GxPTX0ziQn5xB3OaTGEtk2lsDh5D36blU2dOzhjwdvLTk1sCTLpa4SnAu1Eff9Ps
         D2P6ZC1GkMVIJhgglwY45NOAQWX2lWThsZVaY0XrCh2LTMIyxDDG4yJSNy7cB6xgpodI
         NfYyxdc4VgOjEMsZu9yNI1G/UuUx11LMP59xvGX9AbTQP0G8CFZlVBAz1vMC+VmuM3Jn
         F3Ng==
X-Gm-Message-State: APjAAAWmLuGWuLwdfPOLdAQuBCg8aRbrXcX4SlE9x5poUF8MvQAmuMPE
        HMBP+rDBgeCKI2dfDCsNYfY=
X-Google-Smtp-Source: APXvYqzNMmtMyDebuNNZgKECpUn3goSspWHCCs8OulR0f1awwQxvw5m0sIpcxmT/6vQQhlyE43um0Q==
X-Received: by 2002:a63:c104:: with SMTP id w4mr88228953pgf.409.1555578020180;
        Thu, 18 Apr 2019 02:00:20 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id y8sm2377070pgk.20.2019.04.18.02.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 02:00:19 -0700 (PDT)
Date:   Thu, 18 Apr 2019 02:00:12 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: fsl_esai: Add pm runtime function
Message-ID: <20190418090011.GA4028@Asurada>
References: <1555558152-32196-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555558152-32196-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 03:29:09AM +0000, S.j. Wang wrote:
> In imx8 when systerm enter suspend state, the power of subsystem will
> be off, the clock enable state will be lost and register configuration

Just for curiosity, we had similar situation on imx6sx, so we
added suspend/resume with regcache. Why will the clock enable
state be lost too? Does CCM on imx8 (might not be called CCM
though) have any difference? What about clock rate settings?

> will be lost. So the driver need to enter runtime suspend state in
> suspend.

> With this implementation the suspend function almost same as runtime
> suspend function, so remove the suspend function, just use
> pm_runtime_force_suspend instead, and same for the resume function.
> 
> And also need to move clock enablement to runtime resume and clock
> disablement to runtime suspend.


> -static int fsl_esai_suspend(struct device *dev)
> -	regcache_cache_only(esai->regmap, true);
> -	regcache_mark_dirty(esai->regmap);

> +static int fsl_esai_runtime_resume(struct device *dev)
>  	regcache_cache_only(esai->regmap, false);
> +	regcache_mark_dirty(esai->regmap);

Why move the regcache_mark_dirty from suspend to resume?
(I am not saying it's wrong but wondering if this is the
 preferable way.)
