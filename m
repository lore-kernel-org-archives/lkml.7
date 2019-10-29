Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD12CA9EC0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 00:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA36208C0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 00:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaVpg6FS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfJ2AOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 20:14:45 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43105 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfJ2AOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 20:14:44 -0400
Received: by mail-lf1-f66.google.com with SMTP id j5so2785597lfh.10;
        Mon, 28 Oct 2019 17:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UFMQyeREbIhNw2UlO6boKdt0XM6Hubpz5AN2zO6kCSQ=;
        b=kaVpg6FSMQmUKuEYzfp9hbRT+MbmN5UyUCWyR6pc8md78jsz3H6exoUVmvNFXiimtl
         tgSsLB2cWVSBhR+ltypbhu+BwwFBK0fZkRF09V9EMENbe0r99tD+9LxXksf+UAmYpB2W
         xkAsaVKyYODhEaWco6sfn8NvWNr6ZL88rOWu+SbKwxzTIutBD08KaNnIaExIZsqZ1LPg
         rVpr5IG+bqQ9ud7/tUMX4Iy96hCLCj27fcpBeDIrFKzS/hz8idh9AvhwfogisJRHWtIP
         o8S8x1y171wS3xg+3ChQRmisVkKIpT5BuhYHUyXkAE4uXn5jrvq0Ak6YDVRdXJ+bS5PU
         caAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UFMQyeREbIhNw2UlO6boKdt0XM6Hubpz5AN2zO6kCSQ=;
        b=pG8KfCK5lsFQgg45aNmue4msod2Av8oxTY9Y/xqtZ3uGhL6n4lZ/07R9N3peGwdacb
         +IjlnJr0Ez6iOyiGu4LeEejsBs7W/0nDZG4uTZH0uBBum9EqkRvuYaYFTtIur3c4u9w6
         l0JKycZ0QEMkH/F6XdkKcVDptDqJodb89pFKMNx953hF/1IIMYU9+zdusPIoq08bCwFS
         syHQM25U92Ka3k8RNZ7o6hS4VaWbmOGSUBOWjJAp7qLBLnK7jRPcZznvCh4Oh4AuahKr
         wUgQgxRGvV7QbbERc71mjkri8Ky1D7IrJcfDymK5BO5b9fE3dG2h2Xb4u6mbSatWYQOF
         B6RA==
X-Gm-Message-State: APjAAAU3nxOcxnu+B59CnbTWQ4CdKOlmd5NI9MQ+4s4X8GKediRCGP7R
        ihCZb8XVFB0ExxpBqBvp6dzmNeOj
X-Google-Smtp-Source: APXvYqynzUDY0+BrCv0M1s9muL3D7+9GUzVVGdzybb+0m8lx8tsaQzV3Jl3wmzegt2vTQAeWat22yQ==
X-Received: by 2002:a19:c192:: with SMTP id r140mr306480lff.48.1572308082290;
        Mon, 28 Oct 2019 17:14:42 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id o11sm5368230lfl.48.2019.10.28.17.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2019 17:14:41 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] clk: tegra: divider: Add missing check for
 enable-bit on rate's recalculation
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190723025245.27754-1-digetx@gmail.com>
 <20191028142753.GC27141@pdeschrijver-desktop.Nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <62c375bd-09ae-e09f-6ca2-c1395eebc5fa@gmail.com>
Date:   Tue, 29 Oct 2019 03:14:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191028142753.GC27141@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

28.10.2019 17:27, Peter De Schrijver пишет:
> On Tue, Jul 23, 2019 at 05:52:44AM +0300, Dmitry Osipenko wrote:
>> Unset "enable" bit means that divider is in bypass mode, hence it doesn't
>> have any effect in that case. Please note that there are no known bugs
>> caused by the missing check.
>>
> 
> Technically this is not quite true, but for the purposes of CCF you can
> treat it that way. This bits defines if the value in the lower 16 bits
> of the divider register is used to configure the divider or if the
> contents of the UART DLM/DLL registers is used. So the divider isn't
> actually bypassed, it's just configured differently.
> In practice this bit is only set when the divider is non-zero when doing
> set rate. So the extra test isn't strictly needed as long as the sw
> running before the kernel also ensures the bit is only set when the
> divider is non-zero.
> 
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>

Thank you for the clarification. I hope that bootloader doesn't enable
the divider because it looks like standard 8250 driver won't be ready
for that. But serial-tegra driver seems should be good.
