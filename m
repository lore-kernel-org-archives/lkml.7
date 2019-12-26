Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1F7C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 23:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BFB2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 23:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577402691;
	bh=iv8SAplNCuZfpGsNlu4rGyQUXADNLfKHnoVysxdlapY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QSZewcZ78fO8/tb2BVHwmE+dq9MWkuzjjB9xLpd1cSO5qohOxMOLrYjniF2aXmguI
	 P1hQBPfLXHjTB5xKwSyRI0IpA9HQX8dh+NYknbZ2Qac4RGz0xJeqsabTnFu0buMfda
	 cxXwvWtHY/otyFP/9rn2okGvXbWqKoBNhoKP2WTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfLZXYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 18:24:50 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35201 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfLZXYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 18:24:50 -0500
Received: by mail-io1-f68.google.com with SMTP id v18so24437539iol.2;
        Thu, 26 Dec 2019 15:24:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ofQy2VSWPHALE3qoyAs1KhhhbZb7Rihmh2PxTdarzlw=;
        b=WcGVFbvwiXuYdEAyWlHeVayPjNCBVcQ48QF+O6qX62AcOVniUAzCt8VvTWtugGUHN0
         swkwPKqjS3KAXfyllT1r8YciF9enJxdMklyM2xIQWC1utiwR4UT39X3Aj+A6VjXAH2Yh
         QRl0PMZ7nGO02G/E7hEoZu9l68CymzwDfayEjmZhLizyLdCbkEZVP9+r0R5ypcWPFfgn
         m4whKxJA8WTRzUVdsv63V+UQgkSS2bawClb4ipqO4RytVR4vSeWZVkHrtpdKx/547Nf7
         Nu+24b83g/mspfYJUv12rnycUY/Ayg0t19iXq0S50SDqRqbTQBI6+N2SekUugQPXbDr4
         KDJQ==
X-Gm-Message-State: APjAAAVkynOnDo7+yQkonMFNJviwtcf9pICGkCEpW3VTfS/tsGL41jMB
        tD4LEueuCvYqRx/wDMUmwg==
X-Google-Smtp-Source: APXvYqw3ZduDwVjxncxDc1SsatqTiGg654nS5arrJy2F9dEt6pK6m2b9QoMEKbgxr2O/BN5rGy9BJw==
X-Received: by 2002:a5e:8417:: with SMTP id h23mr31446198ioj.17.1577402689357;
        Thu, 26 Dec 2019 15:24:49 -0800 (PST)
Received: from localhost ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id v64sm12717080ila.36.2019.12.26.15.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 15:24:48 -0800 (PST)
Date:   Thu, 26 Dec 2019 16:24:47 -0700
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     skomatineni@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, broonie@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, digetx@gmail.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 05/19] dt-bindings: soc: tegra-pmc: Add Tegra PMC
 clock bindings
Message-ID: <20191226232447.GA449@bogus>
References: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
 <1576880825-15010-6-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576880825-15010-6-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2019 14:26:51 -0800, Sowjanya Komatineni wrote:
> Tegra PMC has 3 clocks clk_out_1, clk_out_2, and clk_out_3.
> 
> This patch documents PMC clock bindings and adds a header defining
> Tegra PMC clock ids.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml | 12 ++++++++++++
>  include/dt-bindings/soc/tegra-pmc.h                       | 15 +++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 include/dt-bindings/soc/tegra-pmc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
