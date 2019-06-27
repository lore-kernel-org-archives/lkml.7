Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315D0C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021F521851
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="M2wbLo02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfF0CeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:34:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41435 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbfF0Cd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 22:33:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id 136so453659lfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 19:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4b7/ubf4vkLlp5qWHvN/PAs6ZU1PXb8yUcJaPeC8pO0=;
        b=M2wbLo02ZzOrDWU24SdeShWDHCx/81xRgD4TyEGEyUnpFg4i2x2UzC6RrRixuGgxJK
         1dMZq90FPT5UWZr/T5V5V8AOs2r8b5xCJZ39dRIIMLgW8LZAS9Zw90eau7rwEcYgYJTf
         BUAQRXASfuNPwsMKAkTiS9rGTmNPErAKZntfcOW1/VpVBhrjJWxmTZ0EGXxkEpZ3IkFW
         xVkbU+ZlqNwtIq2DrZwa3S3UB1W4/7rSRWCkNAX2k4sgM8x5OOdtOZtvC5k0JhDcCHYd
         wln1vAV0vaSAPZdNYW0ns/XFjj8lEqc7y1hdHAvQ8bMk9NmhIZUwZi9Ik96Yd3ZOxC6v
         jhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4b7/ubf4vkLlp5qWHvN/PAs6ZU1PXb8yUcJaPeC8pO0=;
        b=e4L8RasxZjtfRcBOSdoplXkyeV5UnWHWi+PTsmBjwSyyH4ZFFpJHmcup3sqAa2m/UB
         8zpFXNRljJQJN07CIcLxFYOWsx3rKN/gLWY/X61qRu9ngSR53l7ZN32qyxDV6x0SoLbA
         XekPSa6cEqYdSnf+A17vHLhjNsA6FVqcCXpskVc749Y/yd4UdJ+8G+4Wgjy1z/KL6gNl
         barOUua6iPErkPSK6XFyKxVgie5ieEGgvOkyjTkTw9Hh12qI8Z/rtGhHGiSasgo1bveV
         fpZGilPqg9/dXd+Zc17ltOmzIrMqt5A2ntaC53yfBTiQg2pOiSbU3p0MOi2rZIDha/Rr
         bMuw==
X-Gm-Message-State: APjAAAWMAo7BAQiuFjQDHpOY2LnfhxBKtRcjvHBSquSz4HNlcdw8k9Ex
        dFLoL5X4kCJkDeSykHgWXjLFpA==
X-Google-Smtp-Source: APXvYqzEmmjAqWcvkiOXn6f2836spzpdCg++jHRsx5lH/kBQMzgDxjtikA2wbs/Sy3cv5yJt0oSAPA==
X-Received: by 2002:a19:ed0c:: with SMTP id y12mr605234lfy.191.1561602834392;
        Wed, 26 Jun 2019 19:33:54 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id u18sm106626lfe.65.2019.06.26.19.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 19:33:53 -0700 (PDT)
Date:   Wed, 26 Jun 2019 19:23:29 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 2/4] ARM: dts: exynos: Second pull for v5.3
Message-ID: <20190627022329.cr3iungll7n3r2sp@localhost>
References: <20190625193451.7696-1-krzk@kernel.org>
 <20190625193451.7696-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625193451.7696-2-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 09:34:49PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> On top of previous pull request.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit d2cac68e0d9b038da7207c0b63e1399c4f9f60c4:
> 
>   ARM: dts: exynos: Add ADC node to Exynos5410 and Odroid XU (2019-06-11 20:37:21 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.3-2
> 
> for you to fetch changes up to 13efd80acaa4cdb61fde52732178ff9eb4141104:
> 
>   ARM: dts: exynos: Add GPU/Mali 400 node to Exynos4 (2019-06-24 20:03:42 +0200)
> 
> ----------------------------------------------------------------
> Samsung DTS ARM changes for v5.3, second round
> 
> 1. Add camera flash to Galaxy S3 boards,
> 2. Fix PMU affinity interrupt warning on Exynos4,
> 3. Improve regulator configuration on Odroid XU3/XU4/HC1 family and
>    Arndale Octa by disabling unneeded regulators and adding suspend
>    configuration.  The suspend configuration brings significant reduce of
>    energy usage in Suspend to RAM (e.g. 120 -> ~7 mA on Odroid HC1).
> 4. Add Mali nodes to Exynos3 and Exynos4.


Merged, thanks!


-Olof
