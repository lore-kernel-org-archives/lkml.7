Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B2FC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 19:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27EE21A4C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 19:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569957267;
	bh=NVHxr3CjQawNdLKQctuV8Hb+nWP0P5RF9cJYIzWEZ64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lNKAkqXLcKmTF0D9fzTEBaPtlg4KWMAlyzvaHn09Pup7BvLQbAI8odGjzJcL0apTv
	 oXVR3+eYCneC2grFb9GY/HHxTgQr6pIvoFm9nTUGjfp9mKuCdBAkbp0QP0xxsTC0Oy
	 Nv6TCpF9Da3ppmF6Y4aSS9tXMai1iAaY5ZsCLhQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfJATO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 15:14:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35841 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfJATO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 15:14:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so16863411wrd.3;
        Tue, 01 Oct 2019 12:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CQLUqS12o3E7JRqYPNwzncPftf2wy1G+8WY+i5RSSMc=;
        b=HMwtxRwK7pI/OiyiLap4r74RPWTOOFyw0x/lS0MeyNE/jJUyK01co9RGtc1d3RcCU9
         bHfhMFco3utqIAXOWnPyOuWBhHq9XRWoUfry6MCAB5d5bKHA6q7ALXYU825Cw8l61Di5
         aucpSoMyghClBQwzqxRzuLgWbRTGpsPZAntkSJRa+imJyG/9u+dTqvX0BXYe6Jdodpl+
         olcp9WVJRRtyOpHzY9AG+fQLN0y45vcS7/VYgilKWaQFhWw5EIs42ZR+JTIvurw3l8hk
         aQyi3+UIp9gddrLs+dgAHjUCHfzvxG1FqBtOWsySf4pw6l1vkDtVSsIXS/wMpKCzE2Vh
         gCcg==
X-Gm-Message-State: APjAAAU9PihF7fA+ZkXTPWxxWNF2LKu2oT+e534AUzzNTRsqxU7utMM5
        plIZv0O2JWNWVRyPPEkgd7M=
X-Google-Smtp-Source: APXvYqzVFOVq4N8sE1r+S49chs28jalopnOHn56iSfJSaDhrCdoQlTiDaEqmIDWKO7ksT+tG/sm/qg==
X-Received: by 2002:a05:6000:11cb:: with SMTP id i11mr2368549wrx.171.1569957264390;
        Tue, 01 Oct 2019 12:14:24 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id v6sm8289511wma.24.2019.10.01.12.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 12:14:23 -0700 (PDT)
Date:   Tue, 1 Oct 2019 21:14:21 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH 2/2] arm64: dts: exynos: split phandle in dmas property
Message-ID: <20191001191421.GA30663@kozik-lap>
References: <CAL_JsqJ=QWk07y=h7dHFiRrKuE7NGoUr50bu3kiOC+YU8qS9jg@mail.gmail.com>
 <20190920121431.31678-1-m.szyprowski@samsung.com>
 <CGME20190920121526eucas1p2e2165c088519094752066db49aa8ae51@eucas1p2.samsung.com>
 <20190920121431.31678-2-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190920121431.31678-2-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 02:14:31PM +0200, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> Change representation of phandle array as then
> dt-schema counts number of its items properly.

Thanks, applied. Please split the commit msg according to Coding Style
(submitting patches, chapter 2 and 14).

Best regards,
Krzysztof

