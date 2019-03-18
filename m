Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C454FC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9632120863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552934306;
	bh=s91BsIfTGiC9zXegJ6Tw4HMNjINgGzjfkAwn1RMmiKI=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=ts/i7MRlqHk/rTXccpupSeuWDmCZzwCP63eYd6lnYwX5tS3+pX+I2J+AuQ9xnI54e
	 KM8VzRxBAz4wblST5XICwbV/S+Hl6So0J+cXzjUt0CEEKVREcxyZC7kG5Qm7hDlWW3
	 6JR/43SXd85Rjv+WPiD649T9Sg9UMtJxXLrbht3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfCRSiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:38:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42910 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfCRSiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:38:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so14163072wrr.9;
        Mon, 18 Mar 2019 11:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f4z6tXM76JhG3eUGSwIrcOrox0AugsjGgYBZnS+uayY=;
        b=IU0p81HlwBZwUBb76t6gb3rL8aY21QAIcI8a15n+tvzHeJXFiS77c0u9/3hbGcBZw/
         mMLWJTuYr5U2/2Ma3diYnzAzjCtpGbnsrGQ0dxcxFiH07HhrnRGSzcAVZnU92f168qGe
         NEGokv1BBaFgoQE63FiTpfxBsz12wjyG/cmrTqrCbyS0X40UEcCs388wCtWh/fhpWu4I
         Jq2ck3RmVqzmY/SfDs3k/Xq9IVty7bnnNgTfHdVEopNaUAWzKEdFr6OeVkvQnP3+aMGh
         5eSWHWNOMpDgQX3jhqbvabUaZhsiNjA18nRUir7/KY820i8N8iNciy6Ok9apz0gFINid
         6KlQ==
X-Gm-Message-State: APjAAAWF+Tl8wtx8HnwKI1a9i/H2YPlaMIM0cWwigo3sO6WjlTEPjuR0
        289S2SqERMXKBY/EbWX4zjIUaF+W
X-Google-Smtp-Source: APXvYqwVeQFDNKPfI0IZk76UoZNeHVTEvIJYOYc4AOvS7VdO4FNVhiHYm7TuyDk/UDykBm3xV9ijFA==
X-Received: by 2002:a5d:5506:: with SMTP id b6mr12766845wrv.33.1552934302727;
        Mon, 18 Mar 2019 11:38:22 -0700 (PDT)
Received: from kozik-lap ([194.230.155.153])
        by smtp.googlemail.com with ESMTPSA id z20sm205926wma.9.2019.03.18.11.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 11:38:21 -0700 (PDT)
Date:   Mon, 18 Mar 2019 19:38:19 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: exynos: Use ADC for Exynos4x12 on Exyno4412
Message-ID: <20190318183819.GA4730@kozik-lap>
References: <20190212174550.4383-1-krzk@kernel.org>
 <20190212174550.4383-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190212174550.4383-3-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 06:45:50PM +0100, Krzysztof Kozlowski wrote:
> Exynos4412 should use "samsung,exynos4212-adc" compatible to report
> proper number of (four) channels.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos4412.dtsi | 2 +-

Applied.

Best regards,
Krzysztof

