Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796D1C04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5FE20989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ezjf3jfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfEHLqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:46:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46134 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbfEHLqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:46:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id r7so26752339wrr.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 04:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JMXRWT/F4hp5WfrQGRhzI2YLNPd4nX+eBcUO3CBizws=;
        b=Ezjf3jfdQWt8+1oRjIl4JHtShWCjon4HaXtoPv6Q4hNQ3C9AYRYsISbe45hvnNGK4D
         IpQ8TzgeTJW8y2uF820mzyoewxCakvkiC0aiQa6YXUlZWI4l/YNPujRMIH1fS2ezveq5
         gipjHBqcB7fbPOf61V+fdWG72epbFItzz8D6aQazvQieVRNrOGxtDE08vMRgXP+30dcj
         2qLGIJkrHiJSQ5mcj9N12O8BESc0QMIvYA9EHApOALMkRwIvjmXi/p6ZVarTlrDVmjvF
         AZ9sEqNvBClVOIRuLRdfCM0Uu3ml0OFgMMjRu/4x06T7h/+f0KOZJzbD4WGqqRhpd5/g
         p7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JMXRWT/F4hp5WfrQGRhzI2YLNPd4nX+eBcUO3CBizws=;
        b=ioDs5/MuqEY4EHNPXbwwcaOwelPd5Ct5Z6GDZtsjJwZO+2bHVxnjQX62p0ju2veMRk
         w+PHKtXtVeDjcNhksADsz9kd31i9hk+4N/JCGY8LxBGDsECRUbWNQ+tGYRlXIhLgcZaP
         eet2KffQ2XR/y6teqmCAUrmoYVAU5yjJdzqrw/1nDTiX1ObkqSudFdHD0iuRuw3yxDI1
         5HFZyGMa8YKA5I1kVWxbTUt1MEEdUKOEuHs0WB+OGPcvktU687uRR7Uq5YJXoTpptwkQ
         ElyG9yghYtsr+tGy6cQVndNCnPUkxNTkZQzM7DGjy+2MxHKWcFp17MY8Sx8b25lST1v0
         hTcg==
X-Gm-Message-State: APjAAAXF6Vzh6HoePYzAb8jTVjBdSltlW9ozDrLQZJsLKW5kttz/zL69
        aCtNWqEuseLijg4soiyG23p5nQ==
X-Google-Smtp-Source: APXvYqyXTmLI4JXav9TDocJWmcd5fIHJYqnB6gupx9rImn0d0mLlJ8TiDiXRuOldMiuSCLR8SkGzIA==
X-Received: by 2002:adf:a202:: with SMTP id p2mr27045648wra.166.1557315973156;
        Wed, 08 May 2019 04:46:13 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id b10sm28889467wrh.59.2019.05.08.04.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 04:46:12 -0700 (PDT)
Date:   Wed, 8 May 2019 12:46:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] dt-bindings: mfd: max77620: Add compatible for
 Maxim 77663
Message-ID: <20190508114611.GH31645@dell>
References: <20190505154325.30026-1-digetx@gmail.com>
 <20190505154325.30026-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190505154325.30026-2-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 May 2019, Dmitry Osipenko wrote:

> Maxim 77663 has a few minor differences in regards to hardware interface
> and available capabilities by comparing it with 77620 and 20024 models,
> hence re-use 77620 device-tree binding for the 77663.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
