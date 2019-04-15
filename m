Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1C5C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F6220818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SebjyULv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfDOTit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:38:49 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35544 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbfDOTis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:38:48 -0400
Received: by mail-lf1-f67.google.com with SMTP id j20so1146693lfh.2;
        Mon, 15 Apr 2019 12:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EaDr5bdVula1JK134B8bIfe9kL0l466qTIWym3Gxnn0=;
        b=SebjyULv5Li9KIHMGc+r+GWY9uvZdQOBYP1QV17Ytg6I7Mch6NW1v96X9DMPf6IBVJ
         IZTp6OKS9gO3cYTBlZb4xrOI1peGM176aRB0bdIHhktrKLGgu9tt/Mrkmlo2GyiN0qyA
         wmtshp+qwMDV8zkzwq7ZpBaGF1X6B/IK2mrcYfcI2hX7joYBGnhtgWA0jSFsj1YMD7tN
         lrsSb5HDQJQYcVXagcLbcs+C7Qm7Jx+8szGP3GF/UYdT1QR3VRdqiQSY641rZeIYRflH
         Mj60DzwbnXQNE3dtZaTvJSspUpqKiBDz80v4EtUlcCyXb/LiFF/eeBPFrXuKnRiP/AKh
         gYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EaDr5bdVula1JK134B8bIfe9kL0l466qTIWym3Gxnn0=;
        b=GLE5EzOCFn/yEDpna6gW0O4pv+gaQ2+7kGgDvHwJ3aitIc2O4QhlI+b0kFix/1iy+J
         1g45/A39TI8UqQdHQKIDeFySKKOTK4lIV+TSXZPO6dP/Nc/iGm2alxBxzlkGdu61lPhR
         VyBySTKyHXaetuSb7i7y22LHCnel1zwUagKxkDqoMopAkLkr3XZTRxfCWyRkJ2gT0E9F
         aBrr4owhLw0F9cBKloK+icq4GSM4csqw281uoz8WEzUUpo6PnREwuZoqfpVQ/yQcJI5J
         yNznbSW7MeC1m5sob5AYXqs+oF3ghcbnPkJ0gRwh1fTFoCwUN1mrjPyG61FLgVRyYVca
         pm2Q==
X-Gm-Message-State: APjAAAXzmEq3wmPx45XVNewc4R3UIwWi50a0oIL/q/lnuotPfySs8ID2
        kZNfSuIta1IffwwcrfTTZTHyhJRe
X-Google-Smtp-Source: APXvYqwEWOCOBzv83eCtRKAWoEeMMOXS1x0m1laXHrX4GLyZN4u2LHtAVkvq6OYYkA5VPOzmBvPtxg==
X-Received: by 2002:a19:a417:: with SMTP id q23mr4100140lfc.110.1555357126603;
        Mon, 15 Apr 2019 12:38:46 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id g24sm10289335lfb.49.2019.04.15.12.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 12:38:45 -0700 (PDT)
Subject: Re: [PATCH v1] ARM: tegra: cpuidle: Handle tick broadcasting within
 cpuidle core on Tegra20/30
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190224152114.6161-1-digetx@gmail.com>
Message-ID: <1351acef-d0aa-1a2b-eded-02d8fd99d0b0@gmail.com>
Date:   Mon, 15 Apr 2019 22:38:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190224152114.6161-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.02.2019 18:21, Dmitry Osipenko пишет:
> Tegra20/30 drivers do not handle the tick_broadcast_enter() error which
> potentially could happen when CPU timer isn't permitted to be stopped.
> Let's just move out the broadcasting to the CPUIDLE core by setting the
> respective flag in the Tegra20/30 drivers. This patch doesn't fix any
> problem because currently tick_broadcast_enter() could fail only on
> ARM64, so consider this change as a minor cleanup.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/mach-tegra/cpuidle-tegra20.c | 11 ++---------
>  arch/arm/mach-tegra/cpuidle-tegra30.c |  9 +--------
>  2 files changed, 3 insertions(+), 17 deletions(-)
Hello Jon and Thierry,

Could you please pick up this patch? Thanks in advance.
