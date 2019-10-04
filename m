Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6F2C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4482521D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FCCkoMEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbfJDV64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:58:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40379 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731002AbfJDV64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:58:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id d17so5473647lfa.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 14:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j453WNsSMfecyCoQY7VzUIyW3gFQh62iMQgb3cot0yo=;
        b=FCCkoMEVZtJTRMDk1y780eRkneHFdnF4M3fUod6sSrVPv2h4Bswq9TrSTKb8nVuU94
         yHwzKE807k5FccoAl8T5t1M50cnGwzyUw2IedUw6JSIBak/NvtILQH3CzuWTG0ydrEDD
         IHSeQdsWuXBkO0Tk5i0ngM2xcI/JFm2E6oQAiQjIVnfjoVT7EdnuaGhrHUzP4gfrNSEf
         gbu3d9zNlvBE4J2c7XUJOdXXj7TeP4HNIv5agGU7HUgei8nszcLfid709lp1pV6XAFv3
         +EP+WWBQd1cYmVxTM4u/wavzkaO/qeLYhe724YFhCDPtjGAvI2gHC4XtdrTPRWqc3sSd
         9bLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j453WNsSMfecyCoQY7VzUIyW3gFQh62iMQgb3cot0yo=;
        b=IcUOiS9SrFAdQOCD4iHyZrw7fClHM4vPXZXNWM3rE3gIvjmKEmXjXdKfiGHhlDVnQi
         gzaP3Zz2Qv/OY9sL432dgceiU271H89Z92j7qgPevsKmL1mTkkzYc1BXb0rLNxmzrRrS
         5wV0a6t06pM+Urj73LddwHrZD3iho6NGxhsoqIZrvGdPyGhIt6xvPGqAIvzSSUhimwlv
         xjSZLGGiA3CTqzJMocjNszndgYrRHC0N1SABuwKaOGLclsbOar7D9kV8WXRWFsyT4cDJ
         NfMYtEttAt7eEAikAKBNTkr8PXx551W3CeU27l+pWnbcK03ij6Lw1EpRPEgyBvswJufz
         Rw2Q==
X-Gm-Message-State: APjAAAXeN4ryUbhvNFyQ5c+OKW5ekKjEXBOOuRsswD5XiXxhZm9g+d3r
        CHtJfu6VzLyxFyj4knve9ExgylHnjgWKMzdMpP4UcjQxqsg=
X-Google-Smtp-Source: APXvYqy3Z3ai5AV08IvVin/TZlw4UG/kdlBlNxOsNMKq/7fVtBn2PEOEbUPCbfoSvLfZseN9UdTg8Hk1wFafNOLhEZg=
X-Received: by 2002:a19:14f:: with SMTP id 76mr9856396lfb.92.1570226332814;
 Fri, 04 Oct 2019 14:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191002122825.3948322-1-thierry.reding@gmail.com>
In-Reply-To: <20191002122825.3948322-1-thierry.reding@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Oct 2019 23:58:41 +0200
Message-ID: <CACRpkdYS+nH5jVixrJbxV4wqPgibp_JS+q=YCVwTMMND6ccwKQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: max77620: Use correct unit for debounce times
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Timo Alho <talho@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 2:28 PM Thierry Reding <thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
>
> The gpiod_set_debounce() function takes the debounce time in
> microseconds. Adjust the switch/case values in the MAX77620 GPIO to use
> the correct unit.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Patch applied for fixes.

Yours,
Linus Walleij
