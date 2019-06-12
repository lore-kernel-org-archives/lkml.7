Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCEBC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E273208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DkNlW945"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437330AbfFLOZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:25:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41126 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407783AbfFLOZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:25:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id 83so9015533pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 07:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=CG5iVPWcjFplF7lR6y3XE62eHLD9eYji1o8inBAtJJY=;
        b=DkNlW945kuLZQ3RMFEaZhtAt/vvk0BfAkLbeAKizzc+dO/m7G5UF9lRQm6NNq+DUQh
         OLjx98iEFsYqoENabN8XQzrRfB0Q9IoWk/uhCskW75d1RLTar/8kKDcJRAxWV50LaX24
         m1lvDmGvJ92HaqHz9OUmZKcjabh54tm4K4IahU9DPDC0JuzJUCJNlET6Y8v5CG9MuDNs
         7inxq7/Pu7rKUo9WkPtzByceY8kkmQdTna1PRVg//7iHjmNAlshnrhZtb5VaiPBqNjFT
         WdX2mmSdhZMr5Iybo/COmIzTsuYbvIaFlP3cddhl+HBvAIaRf7CN1gYZkVTahmdsPgeM
         vHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CG5iVPWcjFplF7lR6y3XE62eHLD9eYji1o8inBAtJJY=;
        b=uAvsz+5d//1HG5GE4NuQqe0o6qC6OSF13XzhqgSAHDaT6el+9XN7TqxY/dHMvIl8Xg
         sUq2RUBQtE8+nUUa4U0GuPFzUz5YGcayp3l60IMgp1+hSMkoDM7Q0i5JbrskZftU8QfI
         9ftuKINurovA2cDrMFDPWNm7cxGAlq45k/DGSEls+ZVt1TgXZHxYNU7LY5vGWw7/PBWM
         kZOAElm7YETI3vY7XamNtaDn3UNeEt5dlHt1CFAOVLScToZC6HeoSCBNWTlpVH//K+id
         vpZFB1ncJ3ST+SmK82u1NK12O6S9EHL5oNyeIugItP98BU1EYwn6AZwYbOhVFy4sarVF
         nFpw==
X-Gm-Message-State: APjAAAUZbGCGF5my+Rc1pANx6fyAG3ccHvN6u6nAG8Ps1xoyXUByA0wo
        aBrZN0k0QCuHJ9oh5tU6qlYcsQ==
X-Google-Smtp-Source: APXvYqzFJUGgeRa9mS5//wWFpkOuEjJAUvNZgOI1pyCzeAI1Y14G2xwuNekpf+1k+vZZVrtDqAnWDA==
X-Received: by 2002:a63:af44:: with SMTP id s4mr25363352pgo.411.1560349529636;
        Wed, 12 Jun 2019 07:25:29 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id y14sm121972pjr.13.2019.06.12.07.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 07:25:27 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] arm64: Add initial support for Odroid-N2
In-Reply-To: <20190603091008.2382-1-narmstrong@baylibre.com>
References: <20190603091008.2382-1-narmstrong@baylibre.com>
Date:   Wed, 12 Jun 2019 07:25:27 -0700
Message-ID: <7hr27y3mp4.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patchset adds basic support for :
> - Amlogic G12B, which is very similar to G12A
> - The HardKernel Odroid-N2 based on the S922X SoC
>
> The Amlogic G12B SoC is very similar with the G12A SoC, sharing
> most of the features and architecture, but with these differences :
> - The first CPU cluster only has 2xCortex-A53 instead of 4
> - G12B has a second cluster of 4xCortex-A73
> - Both cluster can achieve 2GHz instead of 1,8GHz for G12A
> - CPU Clock architecture is difference, thus needing a different
>   compatible to handle this slight difference
> - Supports a MIPI CSI input
> - Embeds a Mali-G52 instead of a Mali-G31, but integration is the same
>
> Actual support is done in the same way as for the GXM support, including
> the G12A dtsi and redefining the CPU clusters.
> Unlike GXM, the first cluster is different, thus needing to remove
> the last 2 cpu nodes of the first cluster.

Tested-by: Kevin Hilman <khilman@baylibre.com>

Queued for v5.3,

Kevin
