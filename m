Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586D2C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2613C21848
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570031361;
	bh=b01o6kUsRXwCCJnyaECwmtD2gL1kpsiv3Q1KNxxKdtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BDdLkNv8uOLPllK90vWOYIfuelwVSG4C3ncQkmRnkWSPKsxFWBl3flCQmKtVdh4VW
	 jPkLfbvSgzKkbsOIejDotMueDkKJc3fTaRJgXRPokyuzyfzYDng0xBawq3kSd+auYM
	 YhMCsVOrDQUoj4qRVM9I4eJ/CmPZxSH2OzYgZ9yc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfJBPtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:49:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38673 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfJBPtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:49:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so7531836wmi.3;
        Wed, 02 Oct 2019 08:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hgUS28cg0Ci8+dU8EWiIp1hr9/xKokLLrdm7CPLWAvo=;
        b=SDFQhw/vM5hrNciY/12it34hmjV1m9i1MrP+q/PCJnDF1zYrF11sRzTlMD8nWu4Vsj
         R3lmAJvXYONzboLBlO13j/HNSRs/dZBFBvL5gmYBVtgeWlnC0wVX12qA3H4tyKaDq8j6
         G/G2bog5BrLVGzgXXMQR/b+49cpfblQB4z0DgRISkWFTkL1cyytbbyWA3nfwU9pDlyxz
         26tYeluQyweDQlC0QVhURCaELslucG/9sQ+2gXefWIfkfiFdBLQtwDGu+CBVuzCKwRJA
         yPDTveLH+N20YzDehO7OL1GjqVxEEa4spm5wwnkqTB1ZOXIbDYA1fTMpLiaqeasqQ+cm
         KpWw==
X-Gm-Message-State: APjAAAXFkbi7ixmykYr7TQgb66/152Jl1U3nBSz5IzkeMw+9K3hecVqQ
        Vmgj9NB9ArVnjABRHMXj0fo=
X-Google-Smtp-Source: APXvYqyTeEy+1KjEAYvX0VNyGdGx9sODUOSxgNLAZ2aoIxasQFGDO/mzpLVaIyqmpgn0Y5MQ2y7OYQ==
X-Received: by 2002:a7b:c35a:: with SMTP id l26mr3554413wmj.81.1570031357494;
        Wed, 02 Oct 2019 08:49:17 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id p7sm7527991wma.34.2019.10.02.08.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 08:49:16 -0700 (PDT)
Date:   Wed, 2 Oct 2019 17:49:14 +0200
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
Subject: Re: [PATCH 1/2] ARM: dts: exynos: split phandle in dmas property
Message-ID: <20191002154914.GC4072@kozik-lap>
References: <CAL_JsqJ=QWk07y=h7dHFiRrKuE7NGoUr50bu3kiOC+YU8qS9jg@mail.gmail.com>
 <CGME20190920121525eucas1p27562c205c41200221540b720c9084fb4@eucas1p2.samsung.com>
 <20190920121431.31678-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190920121431.31678-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 02:14:30PM +0200, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> Change representation of phandle array as then
> dt-schema counts number of its items properly.
> 
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi | 14 +++++++-------
>  arch/arm/boot/dts/exynos5410.dtsi |  6 +++---
>  arch/arm/boot/dts/exynos5420.dtsi | 14 +++++++-------

Thanks, applied.

Best regards,
Krzysztof

