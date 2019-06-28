Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF05C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832592086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vvNL9fbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfF1GBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 02:01:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34562 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfF1GBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:01:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so2623808plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 23:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yPRaQJzmFQwYi8hosJXjNAPxaw+qeTsDk1d+L2uAT1Q=;
        b=vvNL9fbJcjLCGE94UWKp38ok8N+6iZufXNYCef+hRYEt93VhjGYVeKaRdM9GFD0kq5
         /fTAzVWftSGRxWLvIiQf0tEwg7U4Mg2PAXVQyVIBmnSB2eO0Mvl3jq1wg7cvLF844thv
         cwA/XYaRACYItx2RywEjMnWdNCJV8fMJSSIgsjnTiZWsICUaHkFztJsRNVxtTvyJn5fq
         EkQxIQ7yqinxpgFe9RfhZkChUKYaAQyXeCMDcPD0hZ0uSWkb2unPMoaeDDbKx33qhn4m
         3sitMlJ2o/JTlsEHUBVmNpqoNA6tt79R8WgiXArCix4nvxu+S9XZVtdQ6gxEJWAenFg8
         zpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yPRaQJzmFQwYi8hosJXjNAPxaw+qeTsDk1d+L2uAT1Q=;
        b=QqR7hlFQ5FrdutPKFS2tPHkwFTSV/aEWpPiO0velkABkLRDfMhM89ANj0k6/4S5Syi
         erUHSDkSttNbaaqN6ilTQXK+I2sykIJRJXwDtiR2C0aYPvIqdY8IZbe2rseymuoojl4n
         KqTbK1koIPr4lOQEvQuyeuS2U+3wGSe94si9eyec1cbjt17LrRU9X4xB9V4A6nL81M2T
         03CwEOwPRYT7zmNz038SL+HNX8JNGevgDYbc+v2FtGt/DJ62KvM5nGwiwWx/ke2UO4GJ
         LzPlTOiH2UY6/wabOkVmZdkqT88BYuRXeJieZ5wQszaoOayWxjHZc14bAP+RtBdghmUq
         IKNQ==
X-Gm-Message-State: APjAAAW0zvHTeija193a3bGSkBy/XT+v/sggotTf3oN1jZ0rnWwNq2Ge
        IIr0uN5pTGnZSJH8/dpM/wc56g==
X-Google-Smtp-Source: APXvYqzbAhcap8BbHfMDCoOkrOvthmGqMacGqdcSZfyzVyXrEL6joFCpneO3Qz+XBoTszEuWTC1xEA==
X-Received: by 2002:a17:902:8490:: with SMTP id c16mr9620055plo.1.1561701702042;
        Thu, 27 Jun 2019 23:01:42 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id c9sm975912pfn.3.2019.06.27.23.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 23:01:41 -0700 (PDT)
Date:   Fri, 28 Jun 2019 11:31:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, edubezval@gmail.com,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Keerthy <j-keerthy@ti.com>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>
Subject: Re: [PATCH V4 3/3] thermal/drivers/cpu_cooling:
 cpufreq_cooling_register returns an int
Message-ID: <20190628060139.czridjqrblu2ufjj@vireshk-i7>
References: <20190627210209.32600-1-daniel.lezcano@linaro.org>
 <20190627210209.32600-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627210209.32600-3-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-06-19, 23:02, Daniel Lezcano wrote:
> It looks like after the changes in the patch the only reason for
> returning (struct thermal_cooling_device *) from
> cpufreq_cooling_register() is error checking, but it would be much
> more straightforward to return int for this purpose.
> 
> Moreover, that would prevent the callers of it from doing incorrect
> things with the returned pointers (like using it to unregister the
> cooling device).
> 
> Replace the returned value an integer instead of a pointer to a
> thermal cooling device structure.
> 
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c                 | 63 +++++++++----------
>  drivers/thermal/imx_thermal.c                 |  6 +-
>  .../ti-soc-thermal/ti-thermal-common.c        |  7 +--
>  include/linux/cpu_cooling.h                   | 16 ++---
>  4 files changed, 40 insertions(+), 52 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
