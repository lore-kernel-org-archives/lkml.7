Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37511C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0853820651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkGGTuuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfDWS10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:27:26 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34026 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWS1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:27:25 -0400
Received: by mail-lf1-f67.google.com with SMTP id h5so12510460lfm.1;
        Tue, 23 Apr 2019 11:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x/c8qjyOxIkm/JSbCzhEYnxraeTXJj8WF7bif1+1NC4=;
        b=GkGGTuufW9+oEh7TzGP5N9AevJqiaMBz6Fk2uxUnSzYD7V71BvA+UqdfTjFjLzW6aa
         V+BGejFAkmoxr7R9RnNzpQ9MsLxY6c7LGjiCKI453tMpIOLgfF+GjfLQiGXw1Kt5Rx7m
         CS5SsZi00k95J04eoGk6k6jI6tqTAwO4uWoWaVsFvf1MNYst9NEgN+nqX/wzZTEdD1uj
         56hVzAMpoDyoZCS+s7lvYevZERE2v0DOXAbUsNA9Y8DNY/JwOJuxy1ayC1bkoArrMSDl
         X0NgtzLKj2WLPyGoco+DwUx/YBLgN6zD9yXUiMmNb1Vg8K0+8lC/Fz/v5FJ8ySHP/8HH
         ivdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x/c8qjyOxIkm/JSbCzhEYnxraeTXJj8WF7bif1+1NC4=;
        b=edfGCmF3UcSTXVvsWlA/wAvmiN4KDilrJkeYrnnsCr+FDih+RbfMuH7O5B5Gk17TaM
         AawdwwkmPryc3akHW7f0xxXFGelothKDvn7nmt6ZDNBLykoah8NKXwPBslewpY3kcJDO
         QK1CgKu5CgCyN0RpyrZ/6ohoBMvh/cuKMXvOBAFbpOtVGHJ0zTYg0kJu7+mzGjHLCXfC
         FMPcw4WIO4ABH4+XGeZcsHXMIs/lQGCrEFGTXPMj+oHdHsbOj7kIxHcIpUGWXURQJuPx
         bJlFUWWKw1s7ncU6QQa/AikmmLBg6OkbAvzMceXvlcYHLgut4ePn2lTNJdRLd5vEA9VA
         BBeg==
X-Gm-Message-State: APjAAAXiFMA8zoFCqfLMTdP1TAEqaMMR2h3DU4A6q6AnqUdM7hi9/kHF
        2aBm3FtuS+D+BlDnWRPTmEGBzygO
X-Google-Smtp-Source: APXvYqyHGjCiqzZJJQNDs9A89LbNyu0Ku/bcO4kcp+1kV06HYC70fWK0LqVpMKXlD3z5gZIfT7j4Iw==
X-Received: by 2002:ac2:5487:: with SMTP id t7mr15740770lfk.41.1556044041716;
        Tue, 23 Apr 2019 11:27:21 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id s64sm3592945lje.49.2019.04.23.11.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 11:27:20 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] mfd: max77620: Support device-tree properly
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190422191350.27527-1-digetx@gmail.com>
 <20190422191350.27527-7-digetx@gmail.com>
Message-ID: <5813f448-590c-0f6a-ec22-d2b5fa36cf03@gmail.com>
Date:   Tue, 23 Apr 2019 21:27:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422191350.27527-7-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

22.04.2019 22:13, Dmitry Osipenko пишет:
> For some unknown reason the driver for Max77620 doesn't wire up the
> device-tree support properly and nothing in kernel creates I2C device
> for the driver (and never did), moreover device-tree files for NVIDIA
> Tegra210/186/194 boards already have nodes for Max77620. Hence add the
> missing of_match_table to make driver actually usable.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

I found out that I2C core actually parses the compatible value of the device-tree node for the driver-device matching and hence it's enough to have the id_table solely. I'll drop this patch in v3.
