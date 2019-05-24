Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21A9C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B82206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="G2CUD+lT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403761AbfEXTss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 15:48:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37248 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbfEXTss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 15:48:48 -0400
Received: by mail-pl1-f195.google.com with SMTP id p15so4560116pll.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 12:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Kk/YxPQI8pjQg2ClWfvPmzY4EAH0NW1JSdFr4PlUXcM=;
        b=G2CUD+lTa53s9XEHdAu6Uz1rrPmqDKQpcYpqWKb/xMf8WKCTpK8myE/lnyy4PfAr2N
         8femmjlLFP+9ZFA/5GZ0MD5H6avuMvPZoaU9r3IxE0TslHKV2vhuA+vZdTMbBW1RX9Kn
         imV6EDEmvzFX/hrtSokafkqBj1ZoClk4vZmYcFlbZz1s786qS9Npj6R3v4iuIbZM8fQk
         fQqWd4gR5XdWt0R/MZbMEhDrW30G7cE6/6e0yuLeDdajN8wIOGUAvcztTVzSIL+v/n6k
         koFdUzGyjBFPkGPQLkN4CyNPI4jCxURji5Iiry1JNnQ6le0ACb4GB1ftZWez0n9kCm9h
         cN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Kk/YxPQI8pjQg2ClWfvPmzY4EAH0NW1JSdFr4PlUXcM=;
        b=o6GQ29jRnyaaKefanIAjXAZrm9y87lJb6l6U9JAHV4pNrw8RXTA885gHWJ4MKnsjZp
         SoHFPsG5UGQY4YcdpCUK4Hmq9baMWY2LJ4K70FslJ8p8ZOJL+DsiV7YDB6OvpXSNXWZ3
         KxT+wOvR1qGTpD7aGHxUJ7sYHXj0/Y1I+ttkNjl4ZgZtSXQNVU+PGA5vyN5zLdz4LgqA
         HNcxECnBLEQ4lOTNIhPwRdEmYWc8wmyPyar8qYCN1YnoAjkRM6q+oO8+JDKmehxQvqou
         zaWPDEaivbhqAzA7Ad/Vc8U763jIZKU8VJfhsc6A45VaVnALnSu10RBS9l4GBKR2bs2Y
         VuJw==
X-Gm-Message-State: APjAAAVCIBZuhJyISnSp8zQOTdv4FxKC/Xbr1h8OOzoiHM8BndaxsDvY
        aOC71ojQQou+9ligJAmO5qU3G2xPLQwKew==
X-Google-Smtp-Source: APXvYqw5/u338biK4FyupPkQJCokUaMWyzX5A6yHD9gzUPih/c1K3aPdHPLszkcKKfzpGfpbIW1kDg==
X-Received: by 2002:a17:902:8214:: with SMTP id x20mr85789356pln.308.1558727327582;
        Fri, 24 May 2019 12:48:47 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:ed4f:2717:3604:bb3f])
        by smtp.googlemail.com with ESMTPSA id x5sm3383819pjp.21.2019.05.24.12.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 12:48:45 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     "kernelci.org bot" <bot@kernelci.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.1 000/122] 5.1.5-stable review
In-Reply-To: <5ce727ee.1c69fb81.fbeca.2a40@mx.google.com>
References: <20190523181705.091418060@linuxfoundation.org> <5ce727ee.1c69fb81.fbeca.2a40@mx.google.com>
Date:   Fri, 24 May 2019 12:48:44 -0700
Message-ID: <7h7eaf1vmr.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"kernelci.org bot" <bot@kernelci.org> writes:

> stable-rc/linux-5.1.y boot: 138 boots: 1 failed, 121 passed with 14 offline, 2 untried/unknown (v5.1.4-123-gad8ad5ad6200)
>
> Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-5.1.y/kernel/v5.1.4-123-gad8ad5ad6200/
> Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.1.y/kernel/v5.1.4-123-gad8ad5ad6200/
>
> Tree: stable-rc
> Branch: linux-5.1.y
> Git Describe: v5.1.4-123-gad8ad5ad6200
> Git Commit: ad8ad5ad6200a933bc774415620bb31dd8b2da66
> Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> Tested: 76 unique boards, 24 SoC families, 14 builds out of 209
>
> Boot Failure Detected:
>
> arm:
>     multi_v7_defconfig:
>         gcc-8:
>             bcm4708-smartrg-sr400ac: 1 failed lab

FYI, this one has a fix submitted to mainline (and tagged for stable)
this week.

Kevin
