Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1296AC2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06272146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576703947;
	bh=tNuO5VIlpdVijPzbEAZ1AVFcDnTW/8xm/i11h4kishI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F6ZbB6nQg02sXGsHVSxQ6Hh0kxhz6aW6rqtyGt01EaFVXpRTHQNxxomIHLQ19FfBP
	 X9fWw+KClgh3E4mO5mcWe8qc9GgFn3mV+i19kqEEfYqWEoIiolSTVHyS7zlrkhdzVY
	 t+U6TwYpaeg+eKkt6UTRNpgoKsRMMsAWDvIfZboc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfLRVTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:19:07 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46693 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfLRVTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:19:06 -0500
Received: by mail-ot1-f68.google.com with SMTP id c22so4149023otj.13;
        Wed, 18 Dec 2019 13:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e6i3yUht6VZmzoNOaX8eJ66QZuEfJp5v9+9UU4ybVpg=;
        b=BPiuavSXWe2kkeIpA4Bc5/BUB8/HWp4zgbdZeJ6ffG45ttU+s13h1uuN1CzL6eCXqm
         2cvPxG9WYeHjs538jQqoCKlVRowPfOxPLi/FwWYX17voSYOer0+LwHZbzeFMHx9j9dIn
         cKLUmsA7RwE5eaohUG8uxMkfZIpDE9RS3hghUa0wvK1+l2oo33Knha5HhTpMKJZoRDlr
         xJzuVGu1z2eoZeYZ+i40BSqeGRypZ6UtNosbeD+ZN0SfVcPVqtuSTkVJWw9/AY3CfL14
         74d9F/vuw2/RvDRnc52w8iCRJA71oBzwRdRlf+P+WRFh7j7SYTMLtT3cmOIgVFEOhuF1
         aLfg==
X-Gm-Message-State: APjAAAU7RO2nqtdgyo7BmaKWgKGtEwwA8zLNGIj8l4XfOIk8eVDHjJX0
        H4Rnftsuk03YEgRhoJVJ5A==
X-Google-Smtp-Source: APXvYqzcLzQJCSqsqQnYBN6UNLLQYWI1bzp7P0CM3jCsgq3QyEd+dWVqTYn65T8XaPEUnMSXxRmxFQ==
X-Received: by 2002:a05:6830:22ee:: with SMTP id t14mr4677757otc.236.1576703945628;
        Wed, 18 Dec 2019 13:19:05 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z21sm1231040oto.52.2019.12.18.13.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:19:04 -0800 (PST)
Date:   Wed, 18 Dec 2019 15:19:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     skomatineni@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, digetx@gmail.com, mperttunen@nvidia.com,
        gregkh@linuxfoundation.org, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        spujar@nvidia.com, josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/19] dt-bindings: clock: tegra: Change CLK_M_DIV to
 OSC_DIV clocks
Message-ID: <20191218211904.GA5303@bogus>
References: <1576613046-17159-1-git-send-email-skomatineni@nvidia.com>
 <1576613046-17159-2-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576613046-17159-2-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019 12:03:48 -0800, Sowjanya Komatineni wrote:
> Tegra has no CLK_M_DIV2 and CLK_M_DIV4 clocks and instead it has
> OSC_DIV2 and OSC_DIV4 clocks from OSC pads.
> 
> This patch changes CLK_M_DIV2 and CLK_M_DIV4 clock ids to OSC_DIV2
> and OSC_DIV4 clock ids for Tegra30 through Tegra210.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  include/dt-bindings/clock/tegra114-car.h        | 4 ++--
>  include/dt-bindings/clock/tegra124-car-common.h | 4 ++--
>  include/dt-bindings/clock/tegra210-car.h        | 4 ++--
>  include/dt-bindings/clock/tegra30-car.h         | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
