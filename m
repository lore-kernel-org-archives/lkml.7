Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC79C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA5B2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565893364;
	bh=q9IrLXyVIW9FzJWbs4B5Vjg/0/aTKpIxZlPZ4m9pzO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g0Kyy3gR04hmFGvqaUkxVuuYQYxOc0RFaO1xsDdMaQWnzspUYP1YFASa/6vt9EQ1m
	 SDHZ+a+Q87KeKSVpg9n06U51+4sPxTqfPNXP94XFyttxvCMekXKKvHqKfKYSC44KGX
	 6daV0MozCHFNuvOSJk4h02hSQdsqFV43JrpJHqh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732833AbfHOSWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 14:22:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36689 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729565AbfHOSWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 14:22:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so3051512wrt.3;
        Thu, 15 Aug 2019 11:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mh8n/VNiTVWDFrItd4GHUV+f3zt1dfnH+uZF/6gzubw=;
        b=QVqYevEA1IhtJVC/Ut6igsF2qLcAIpugNA0p5f8GP8ZrNLsT/RXU0n1ODamEczE3yK
         YyGsFQI/A27K89WhPY9VQxPlslQvLsCNmzmo2RedR8Ww3OdOtN368vTZO8jeJDnAYXTv
         lFrlkzPTFlJeFDIlh02OnmYQuFeUi1t6IR8XvHTaicf0DKv5JBs7MAOyyRLa33uZMSmT
         q53gYvnrMAgVX06HBKrLEasRg0s+31w/MSk35S4HzfbFvOgpcZ/51Ok/scZNCpNAQq6S
         XBMjxI3tOvTzwGLmY8lop9ARUBoNCKrQPh2ussQpiLIB89VtzLgQHVuAa6VaKiy8msV/
         qZGQ==
X-Gm-Message-State: APjAAAWsi9TMETASn2lvhwC6H50V11ZXWNKUD/rzL/eaMzeo1qHda2Hv
        LKvaYLhj49Gw8v5H6qntTMhFni5v
X-Google-Smtp-Source: APXvYqxAOF7d8gx7S+4KOLrESeMUupXxwlLNiqXx0Gy90/oE4qxtlhlu0qmZit2MPXZBrY1LY5pCKA==
X-Received: by 2002:adf:d4c6:: with SMTP id w6mr6996086wrk.98.1565893360200;
        Thu, 15 Aug 2019 11:22:40 -0700 (PDT)
Received: from kozik-lap ([194.230.155.124])
        by smtp.googlemail.com with ESMTPSA id 16sm4108056wmx.45.2019.08.15.11.22.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Aug 2019 11:22:39 -0700 (PDT)
Date:   Thu, 15 Aug 2019 20:22:37 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH v3 2/9] soc: samsung: Convert exynos-chipid driver to use
 the regmap API
Message-ID: <20190815182237.GC14360@kozik-lap>
References: <20190813150827.31972-1-s.nawrocki@samsung.com>
 <CGME20190813150852eucas1p2be4c0ab5ec2c079e3daf1af24283b27c@eucas1p2.samsung.com>
 <20190813150827.31972-3-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190813150827.31972-3-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 05:08:20PM +0200, Sylwester Nawrocki wrote:
> Convert the driver to use regmap API in order to allow other
> drivers, like ASV, to access the CHIPID registers.
> 
> This patch adds definition of selected CHIPID register offsets
> and register bit fields for Exynos5422 SoC.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v2:
>  - s/_EXYNOS_ASV_H/__LINU_SOC_EXYNOS_ASV_H,
>  - removed __func__ from error log,
>  - removed unneeded <linux/of_address.h> header inclusion.
> 
> Changes since v1 (RFC):
>  - new patch
> ---
>  drivers/soc/samsung/exynos-chipid.c       | 34 ++++++---------
>  include/linux/soc/samsung/exynos-chipid.h | 52 +++++++++++++++++++++++
>  2 files changed, 65 insertions(+), 21 deletions(-)

Thanks, applied.

Best regards,
Krzysztof

