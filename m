Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F8DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08ED20854
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l/5bNc1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409267AbfJRQxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:53:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34794 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409040AbfJRQxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:53:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id b128so4260814pfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NlVpUWWb77Jgx8c6AKiFTKsV64mXcIM59rzR3NbF5X0=;
        b=l/5bNc1UOgviL8cXU+xAaLQOtmOhi56H7mopre3Lu97/kYO2lo5DMOwuqzo16GPpU7
         en2sBDgJn/rwquPVBU6NOvsJuW2lX6njpbipp3wFM2DBhFIibFMM7Ji7fEC+5JJ3IyVd
         xmgPjfeDjfUjmiuPFwMOJKKQPuPQXWocZgmkWMoeUMAGd+Y1IMhD+QsOMDWHzASPJjmn
         lB5yUIilNr+WEfcrkyxzN7+9VZZe/t2KW0WOBj8DSGeKn0smaVryK+M4jM3Lud2alJ9k
         WAQharx87X1yFjofhhWaCKeNztbH7vyUakUyu1a+f2UZ/C/+XEK3z2xhCu3JouqnP4le
         Y57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NlVpUWWb77Jgx8c6AKiFTKsV64mXcIM59rzR3NbF5X0=;
        b=Jk77AA8hzom4iwxksVrPDvohre6rABNbovpyiCDskuwVLX9g4DHSplldYNabz5tjDb
         nhrJNquiMsD4iHfl1iGvX6su//OvqjK8ViybHxyodK9RcY3xEoELKez2RcGa/rJo5mnH
         bfG9kau5/d0NPDhRE2oEIrcvl9ADMdvn/oB72IrLtkGVIKxEh43O0QMaoX3VHjlbr60m
         keRjnlqFm2wUpmti88mhu09SJPlSxPqfD7zF7vVH8R6BNa7QxAmB/Ptn834K9HPVZ+79
         xZgTKSd9uausIiNycRzhRnbkMRxIp0wWcdcRAdZ7NuBEZNIukX3xkcZrRvF7GNdz90VJ
         m0mg==
X-Gm-Message-State: APjAAAX7ZJOARWZHRQ5g56BxOVnryATMqibPwK9qD2elWpXgsTlAxzcj
        bAQcV4QTrWGyprHQE/9o7f/wPQ==
X-Google-Smtp-Source: APXvYqy4EO909F7HnCUZ2Fmo7UCAUkdG66jUJnEgoxHT/sDHoXa2mMyp6Et3xVZh7h0kG3B3iUDOAg==
X-Received: by 2002:a17:90a:a00c:: with SMTP id q12mr12481013pjp.102.1571417590960;
        Fri, 18 Oct 2019 09:53:10 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k66sm6624950pjb.11.2019.10.18.09.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 09:53:10 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:53:07 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <mripard@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Alex Elder <elder@linaro.org>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm remoteproc dependencies
Message-ID: <20191018165307.GD1669@tuxbook-pro>
References: <20191009001442.15719-1-bjorn.andersson@linaro.org>
 <95a80ff0e89a568d223fab6eb1f9362a@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95a80ff0e89a568d223fab6eb1f9362a@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18 Oct 03:38 PDT 2019, Sibi Sankar wrote:

> On 2019-10-09 05:44, Bjorn Andersson wrote:
[..]
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
[..]
> > @@ -780,6 +783,8 @@ CONFIG_PWM_ROCKCHIP=y
> >  CONFIG_PWM_SAMSUNG=y
> >  CONFIG_PWM_SUN4I=m
> >  CONFIG_PWM_TEGRA=m
> > +CONFIG_RESET_QCOM_AOSS=y
> 
> I should probably fix this ^^
> 

Please do, afaict this driver should be tristate.

Regards,
Bjorn

> > +CONFIG_RESET_QCOM_PDC=m
> >  CONFIG_RESET_TI_SCI=y
> >  CONFIG_PHY_XGENE=y
> >  CONFIG_PHY_SUN4I_USB=y
> 
> -- 
> -- Sibi Sankar --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project.
