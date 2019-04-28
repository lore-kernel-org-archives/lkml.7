Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDF6C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 20:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6C82064A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 20:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Ex/mj8Zl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfD1UTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 16:19:30 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37732 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfD1UT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 16:19:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id h126so6352923lfh.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 13:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m5G0ZYcf9IjrWASeBFD7kWmvvr5oebcAUaFd3mv0bR8=;
        b=Ex/mj8ZlmBpG6HbMNicv95+YaDtmf0+vnZd9mFB+6bVnElAj1v+XkOFTBl9+soVSwl
         S44ciWDlnZKyd1rEwsxcmAJ3RtVJoyaCVM8mFU2vgu/H3U/lctjSttJ4nwKYtPzjgzMe
         0FBRweWMYyhNT557qd+8mV/FjxucSyxYNGmt5niVvroJkYmp6hFSNIkbKKhi56GI/RRm
         aaBMxaS/rc9nBSqThaeCqFN7xGFi++kVxLtzx6ReMp/mnTAXDM9WTLPFyqZQlk5ZnMup
         j8fY6f73OSeaaljHgBwfeCQxHYPAe44m/FNRM431FGzRACt+ig4nTf42qsbrXCUG5Vuu
         ojjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m5G0ZYcf9IjrWASeBFD7kWmvvr5oebcAUaFd3mv0bR8=;
        b=SXTdej1vnGCkGTZ3EOPKDDp+GlP+eGnTUXPua/b6jPZ/r7D8Ft0BvBTpEmQiBvUnkl
         YXeJWYCPO+1HunEuF7uupFczSRtsilTohY56HoUU3t0BFMQYA3nnYHZt0yHMNyebgjjG
         pnMhO8TBTkBMXBWLkY/xQr5239To/a4M2Ufx+s2hAqgOdpUSyHSp+MQkWKC1qeHxQ//V
         +iGKubVzBKyMhStfbeOtT9OxLte4QmgLbW3Y+Izlhqed+mXwL6bBiveJDKr8PC/+6E4+
         /b0Xxh2lHH5gvWqXJy8gQ8y8q+m8HtQmauZk+hatykaPRjI9EG+kYBxd5QKwJhsKDIqo
         OWFg==
X-Gm-Message-State: APjAAAWi5YWhqq2iLVomvpk0G99wQUC0bjcmiOjU1WwVWYXs1XS/rqdN
        v0OPkyRzX5ecJNfUfpJwuKyZgw==
X-Google-Smtp-Source: APXvYqw9LWXgAKTsHMfjUlepncCzZNfZNIiDe+WUFHS4Xt04W2kPLw5qw1f0/WSJF7vzc64N1kQ1rA==
X-Received: by 2002:ac2:54a9:: with SMTP id w9mr30316294lfk.125.1556482765511;
        Sun, 28 Apr 2019 13:19:25 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id i12sm1616629ljg.47.2019.04.28.13.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 13:19:24 -0700 (PDT)
Date:   Sun, 28 Apr 2019 12:30:09 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 2/3] arm64: dts: exynos: Changes for v5.2
Message-ID: <20190428193009.qfpczki7eyhj4cvu@localhost>
References: <20190414154805.10188-1-krzk@kernel.org>
 <20190414154805.10188-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190414154805.10188-2-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 05:48:04PM +0200, Krzysztof Kozlowski wrote:
> 
> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
> 
>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-5.2
> 
> for you to fetch changes up to 77fc46976e0bfcd78d30fb4c9f0169752b4339c9:
> 
>   arm64: dts: exynos: Add SlimSSS to Exynos5433 (2019-03-20 19:29:57 +0100)
> 
> ----------------------------------------------------------------
> Samsung DTS ARM64 changes for v5.2
> 
> 1. Use proper clock rates for GSCALER module on TM2 boards.
> 2. Add clocks for local paths on DECON and GSCALER modules of
>    Exynos5433.
> 3. Add Slim SecuritySubSystem to Exynos5433.

Merged, thanks!


-Olof
