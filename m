Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF81AC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0B620B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eLCpJfoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfHEScA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 14:32:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46416 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730055AbfHEScA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:32:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id c3so16929914pfa.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 11:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=GAZtoqMTbDsSEkTKLvtg+7SDqJDueQbXtR/WE8SM+Mc=;
        b=eLCpJfoh/+Lkf3U5Jq1Gw1cvSEsPrPw2J+Jj1cKEaDJJOhXr0kqg4nEbozdiW9YyZW
         MxwXt8S6yghOSjDY3p0XzVPZkQ9IDX8wNCa+Qv6vXmaUTiEb+PublVJvS7pSWJGp8KEx
         w9HQXI6qhlsTEtJk/CdDPSdHkxIWQIH6hjn96/vYSQJ8y01/RqngcS6Oq2O9DA5M5rVN
         fvxg1/cP+66yiU9OGP3cgIMltSY6quBi6snXE8Lh6SdljDPnXzTsPpnLyTbyUbk8aWam
         aCjEgEpKTEI7REjqoFE/WpbKcnCBuJMhe6vk5dAdvMc2bGkn8nFYuZ1PobjwNlCPV9X1
         L22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=GAZtoqMTbDsSEkTKLvtg+7SDqJDueQbXtR/WE8SM+Mc=;
        b=dldxz27WoVkCuurFSBQwMWqEVVq856D0siQ1qENiuNvIFYTzrvCmmtxRp/xdLlvgEy
         pS5c1vljpKOSXpyDqy4zVf0CWl7Rfs0/LdgEzrB/1BDEPgdD/wVMRlDVB8bhjGCf4fHV
         pT/dyXNls8GafCHtzZRbunAF7aQPBfZewpfr/TNYy78Y0mXiHe5oEL7PVRex9eOQM7tp
         H5DsWJjYAc2dZNmeja9rw0UtbA6pfVsx3BJ3Ir9o0ruOLuf6/y9oUn01fszzDrp9S1th
         +il80AFobn8iNM3rVZvfTf7TfgQ0HraRSZ4eZU8uWnoG80ipTvWPYeTPEObwQ77c7lIp
         qsLg==
X-Gm-Message-State: APjAAAWcf7mMzsmued2LQWX9zdXQTrppM63FOqU06zFisV9pPl9wOfAU
        GTg+ql43rUYl9Cj1Q23IB1hOZQ==
X-Google-Smtp-Source: APXvYqy5L3JR07HcEnA00M1CL8VNhKg77fHOWXFhUU5EGpQJP/FGGVXDbvKX2iSPUCmowPs/39oslw==
X-Received: by 2002:a63:c118:: with SMTP id w24mr136487259pgf.347.1565029919532;
        Mon, 05 Aug 2019 11:31:59 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:7483:80d6:7f67:2672])
        by smtp.googlemail.com with ESMTPSA id a1sm51592199pgh.61.2019.08.05.11.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2019 11:31:58 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Alexander Clouter <alex@digriz.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: Re: [PATCH] ARM: Replace strncmp with str_has_prefix
In-Reply-To: <20190730024426.17262-1-hslester96@gmail.com>
References: <20190730024426.17262-1-hslester96@gmail.com>
Date:   Mon, 05 Aug 2019 11:31:57 -0700
Message-ID: <7hzhknh3aa.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chuhong Yuan <hslester96@gmail.com> writes:

> In commit b6b2735514bc
> ("tracing: Use str_has_prefix() instead of using fixed sizes")
> the newly introduced str_has_prefix() was used
> to replace error-prone strncmp(str, const, len).
> Here fix codes with the same pattern.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  arch/arm/kernel/module-plts.c        | 2 +-
>  arch/arm/mach-omap2/omap_device.c    | 4 ++--
>  arch/arm/mach-omap2/pm-debug.c       | 8 ++++----
>  arch/arm/mach-omap2/pm.c             | 2 +-
>  arch/arm/mach-omap2/pm44xx.c         | 2 +-
>  arch/arm/mach-omap2/sr_device.c      | 8 ++++----
>  arch/arm/mach-orion5x/ts78xx-setup.c | 4 ++--

For the OMAP stuff:

Reviewed-by: Kevin Hilman <khilman@baylibre.com>  # arch/arm/mach-omap2/*

Kevin
