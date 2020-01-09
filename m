Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6A6C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF1F206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhXODvu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbgAIToo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:44:44 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32940 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbgAITon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:44:43 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so8587835lji.0;
        Thu, 09 Jan 2020 11:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sGqr1GBrT5VOU5JASIzkXUlOA3XLGCSf9edT/JCGYyQ=;
        b=OhXODvu22z+cEO5MPHcWEP9kSdV/VmqOZ7QlGueoUiLaTikO6KIcF6snzDxchHFAoK
         ZGyOW3owzyK69OtKsMQecV0LF6CFVC2x6WiDhs+K/IZR+bFCwhgOjCKqQb+Q3kXLxYMM
         i3hokEn7OH3/QFxzhDgUIWFqt2CXGteCJZT3el9Rj1byc9TjXDfTIWNqHjYD27GGHHYb
         snRg6FeetXahBLyzUxcGyE8fWaY/r0GgEkkp9LsZRswhT8DXfGxu4EHGnzmeXzmeAR0H
         O2x8rs6R9a07RfTz1Gd3CgeaaX7N4j5SnP1yUVEDu/dixFDqXR3PySYOsb6hUOeDW+L9
         n7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sGqr1GBrT5VOU5JASIzkXUlOA3XLGCSf9edT/JCGYyQ=;
        b=H8bIRrq7zMXDA3iKpk5X6LYoH8jLxtjTrhXnYJrQuZcaW97rderB25VfmKd9B38Trf
         Sq49YCgj6YDjoqFJgv0YUK0cY4Kwcd1dQVUQc9/M/pgCfayNuO02STZidJ+2SKpESwbG
         g8fCA4mieawp6RN+0CkTukKEH9tYlQpDG9okkbuQ00qu4wSyYN1OnVFCXtio2Nbj5nFF
         O0c4KM+y6/a3XhTgPAwxHUlFgyv2wnNuRPsa6I01xaSp5rejjca6erFVauC8YEZkxXMm
         sQorEzxzvbV/Hz/ElOOSulwc1PE/ixXr2yh1F8DiQyjw+swyYIwfCsrz0s4adzZJ7DBt
         ejvQ==
X-Gm-Message-State: APjAAAXAleTq4S+BOP/5M80LXm3XXM5BHdvPtAedWLyy6mtqaTAfchmA
        GKaseFaioMl4mhjw7AZ5yj4p0fZo
X-Google-Smtp-Source: APXvYqz507UlqH1/Ko36CShlEC+F7562Fd9Pnkc7YGg8mlcSx1BnPkDA5yF91GNdzUoEzrG5HFo6VQ==
X-Received: by 2002:a2e:8698:: with SMTP id l24mr7801290lji.94.1578599081124;
        Thu, 09 Jan 2020 11:44:41 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id z13sm3494629ljh.21.2020.01.09.11.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 11:44:40 -0800 (PST)
Subject: Re: [PATCH v7 00/21] Move PMC clocks into Tegra PMC driver
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4e9fab30-14b5-bf1f-dc91-fd57ef614503@gmail.com>
Date:   Thu, 9 Jan 2020 22:44:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.01.2020 07:24, Sowjanya Komatineni пишет:
> This patch series moves Tegra PMC clocks from clock driver to pmc driver
> along with the device trees changes and audio driver which uses one of
> the pmc clock for audio mclk.
> 
> Tegra PMC has clk_out_1, clk_out_2, clk_out_3 and blink controls which
> are currently registered by Tegra clock driver using clk_regiser_mux and
> clk_register_gate which performs direct Tegra PMC register access.
> 
> When Tegra PMC is in secure mode, any access from non-secure world will
> not go through.
> 
> This patch series adds these Tegra PMC clocks and blink controls to Tegra
> PMC driver with PMC as clock provider and removes them from Tegra clock
> driver.
> 
> PMC clock clk_out_1 is dedicated for audio mclk from Tegra30 thru Tegra210
> and clock driver does inital parent configuration for it and enables them.
> But this clock should be taken care by audio driver as there is no need
> to have this clock pre enabled.
> 
> So, this series also includes patch that updates ASoC driver to take
> care of parent configuration for mclk if device tree don't specify
> initial parent configuration using assigned-clock-parents and controls
> audio mclk enable/disable during ASoC machine startup and shutdown.
> 
> DTs are also updated to use clk_out_1 as audio mclk rather than extern1.
> 
> This series also includes a patch for mclk fallback to extern1 when
> retrieving mclk fails to have this backward compatible of new DT with
> old kernels.

Suspend-resume doesn't work anymore, reverting this series helps. I
don't have any other information yet, please take a look.
