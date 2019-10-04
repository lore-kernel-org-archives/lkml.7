Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E978C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41259215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yTGJqZkm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389208AbfJDOgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:36:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38539 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388724AbfJDOgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:36:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id w12so7536842wro.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=H+yr5kS5iH2wmnNe9kPeQU/T3tzbAN3a+t+sjJ+iY7U=;
        b=yTGJqZkm09u05ribXQL0uDJJ9aCSfe45YY5Zmi6pWlVEFuFQctsjKj7yLyufgnswfX
         rJd0cAagn5RI67Kf3o9tdxqzvBMT9p9kPSfzME32i5S+eQVWvryxrBzdPlMsUgXwIgHr
         Ds/Ynp/Yf60O8c7I9AKA45KqfdWShNERMT6WfOpXwXHch1+57zBQymt2GLpYU7WVhQ99
         gP+pXFbzcFLFKP0GndNbZIJWmH0G5DyjS1yzgO7s0kQ8YtfMhKZFjKu4/Iv55C2oSVNA
         cCklWMufOaHW4ABU667u118NIZF3O6jrehnSoF/J219zt3lVEZtSgXWz+5WuYfHQwo87
         ETlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=H+yr5kS5iH2wmnNe9kPeQU/T3tzbAN3a+t+sjJ+iY7U=;
        b=baDgE4rZ7wlO6i0bt9nZ+AYgvmU+1y/pSW4aPBC2EokhcD95yMXOWbOKD+JjSu85kR
         KOWEqOwUwvmFFr/H5lmJaugMuUeknwu29XjhGGHwhQDmTorcBgZCf4CMwTZERQlK2z1p
         IWDmyRDXNFTgkdCHLjMSgoRqfBGb/BJs0dONuIFYMMMhBT9l3nU+kBLypXB8mdEB03M6
         3rC5HAOORCmWQsOKjnmquvwW+4S2ljadsOYFey8w1m6F6wfCQZ9uD8s/c5lj5lgBq3HN
         EuDiUH+QuhXXBiYJ+Vk/sPV6Y8mtq7lFPeaZEHPB55RFB++TOZopj7JZ+eGmtr+vrBeL
         4Ctw==
X-Gm-Message-State: APjAAAXB4p1xcZi2LHGS4wMvVIw0l+0F7BHljsAKJo2QLErUWT9xsncq
        Tj66My/5A07oSYFm4wVY6MftVgKspDw=
X-Google-Smtp-Source: APXvYqz2i9TJzrN0Lsg67JBKMSZYobGbOf6d9N2rrnf6nMWRkWoUODo9EYYr7bSLftlbdYhSpmZ0vQ==
X-Received: by 2002:adf:cc8a:: with SMTP id p10mr11756685wrj.321.1570199769269;
        Fri, 04 Oct 2019 07:36:09 -0700 (PDT)
Received: from dell ([2.27.167.122])
        by smtp.gmail.com with ESMTPSA id z189sm6971821wmc.25.2019.10.04.07.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 07:36:08 -0700 (PDT)
Date:   Fri, 4 Oct 2019 15:36:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: max77620: Do not allocate IRQs upfront
Message-ID: <20191004143607.GL18429@dell>
References: <20191002144318.140365-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191002144318.140365-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Oct 2019, Thierry Reding wrote:

> From: Thierry Reding <treding@nvidia.com>
> 
> regmap_add_irq_chip() will try to allocate all of the IRQ descriptors
> upfront if passed a non-zero irq_base parameter. However, the intention
> is to allocate IRQ descriptors on an as-needed basis if possible. Pass 0
> instead of -1 to fix that use-case.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/mfd/max77620.c       | 5 ++---
>  include/linux/mfd/max77620.h | 1 -
>  2 files changed, 2 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
