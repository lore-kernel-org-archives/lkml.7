Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65340C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4194221670
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567621513;
	bh=fG4//tWhx9xzYmwCvisGMWODHLy5eOjE33qAobE9dVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tm/M1Mh9jgisjp80swVXcYOCDnEmgcirZ+PCrsKKycyjWMkusrwbm1NNgcRfW6u/J
	 qmS/5HZxWjhIUY8GMsvt0R5ZAdjC7INdXd0fLDQuSLXQAvAwSdZVvmW2BTXOPS63H1
	 bkbrwYWav0lv+6s+eBV9g/BrGUDFjF6EqRmiyXvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388583AbfIDSZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:25:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39642 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387988AbfIDSZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:25:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id q12so3136353wmj.4;
        Wed, 04 Sep 2019 11:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZNs26im8IZSiycRp5YdzdEf5xY+Panks2L0eHlZ793s=;
        b=Qo/FhpDlrpLbmZy2AOO5cvsZQKPxLx53cw2F2bhjcD0IsT8ffwi1wSd1LFXmvLDYwV
         uAjyijfk2M8YwZw9XktUtF0rEnGNek0Jc+/GLiJugzvXmuXQH5v6NeR9Mt+VZMP3iqJo
         0w84fJY9gcNsEEadVnwtp8l8D2ZxfvkTkRfMepAvTM68WvVEmxYwaYsWyKdVD4Vn6BEZ
         +J6HUcR2kK6fbwi6P6LSYTJ21ATYfqOLBNKu2XNSwIxvV4F+gEAe7tV6qG5dSOVbATIs
         totGlRUmDm93sUTk01IkMB2zvoohqdRHukj0bTaJFepQ5knMAZW0AkLrjMnTw+6IS+6Q
         hVqg==
X-Gm-Message-State: APjAAAXOaj5RRNDWDMszx/cHmK+Quj8KaTlgVEiF1ML+wNjtLwP4gs3l
        W7kL4tpsY8zSTedTfVVRAts=
X-Google-Smtp-Source: APXvYqzKhl9Da3x+NOQGn/asSthLbZVbQBHuEIslYz5CVROihkX7N/X4nng7WKd5gmnOLs0uBCdTJA==
X-Received: by 2002:a1c:c78f:: with SMTP id x137mr6042843wmf.42.1567621506722;
        Wed, 04 Sep 2019 11:25:06 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id k6sm71403811wrg.0.2019.09.04.11.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 11:25:05 -0700 (PDT)
Date:   Wed, 4 Sep 2019 20:25:02 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, b.zolnierkie@samsung.com, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v13 7/8] ARM: dts: exynos: add DMC device for exynos5422
Message-ID: <20190904182502.GA12918@kozik-lap>
References: <20190821104303.32079-1-l.luba@partner.samsung.com>
 <CGME20190821104324eucas1p16bdeb27250c8c9fa87591d6bd9743a17@eucas1p1.samsung.com>
 <20190821104303.32079-8-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190821104303.32079-8-l.luba@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 12:43:02PM +0200, Lukasz Luba wrote:
> Add description of Dynamic Memory Controller and PPMU counters.
> They are used by exynos5422-dmc driver.
> There is a definition of the memory chip, which is then used during
> calculation of timings for each OPP.
> The algorithm in the driver needs these two sets to bound the timings.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi             |  71 +++++++++++
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 116 ++++++++++++++++++
>  2 files changed, 187 insertions(+)

Thanks, applied conditionally. Please send a follow up fixing the
checkpatch error about undocumented binding:
https://krzk.eu/#/builders/26/builds/392

You should not skip such checkpatch warning.

Best regards,
Krzysztof

