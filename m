Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3E5C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5477720449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEEJtvfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfDSShS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:37:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41783 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfDSShQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:37:16 -0400
Received: by mail-lj1-f194.google.com with SMTP id k8so5323751lja.8;
        Fri, 19 Apr 2019 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/oAnR9QFJmiluH9HCMbLbrR6ySx9u8WG7unplYByvro=;
        b=EEEJtvfIxuPgnMw/lFamOp6jLXKjzalKUkSm9JR7U0lCZEjg5SIl/XxaYOcokCfpEX
         e/hbYD0OH6bBZ2PVAG+obSCTc+/pgBelx7e+vC2Eb6lGFkkfGhB9srAZo4QqAF7mX8BM
         dFWZ2Io4csz4LdIh/NkCL3oLGAZ07/mfin9jel7yAgL4l25jZDrPyzH1Ayminoa5916b
         7wB+3nJmxYMwZ7LUpJ++SF+09LlmASUpQJB0uZy/YxxDjpdK82HDU+T1SpVajwTpDjTk
         NFFElnpmfNFu0SSxgiT9sDVsBo7rD819x8O0J1LFbZbz7yQ2Xhc0bRNlGSwkaclHGuoS
         pOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/oAnR9QFJmiluH9HCMbLbrR6ySx9u8WG7unplYByvro=;
        b=TmRQbOjYenWWE9imWpQ3fwpkkHRVm1fDMIhE7/kMDZ9nhxzBQPfGevo32r2+GIhO2K
         V1HlEnoPLvee2cMDCkyfPPdTUzylDLs4/mLN3ejCEMQj1eE9T9y0XUSXcGHrTvVlaETJ
         cBVD23oDDsWKW8RB0EnadH1ggz47DsAX0zikG3Viw33fcIFT1VmBm+JycYo862pFYFtk
         xrmbHvLbIInavzfk2gNNaVp2ZhpB3TaJkzTe//FxOQwSDUP1uf9yucTOoAtcEQOg8HVo
         rypKh+urGbAg4tXz9ucyHQY8Yd8pIBzYKEmw1PTobm4vFs0nSpXC0/SYCXIZBIOpo/Ko
         zF0A==
X-Gm-Message-State: APjAAAXBKCwEA7XKe75ddhPzKUjh/bDQJ+MnFcSJc54RsFYOH+TyIirn
        YzBt8m4+u4Y7xA+iE/59FQNg018g
X-Google-Smtp-Source: APXvYqwYQyC2BkECVlIeFIPPbp04x5/d3vMInVaqcHC/SFJfNsJ3PzdA1B2Su9SvbI8HCf4uGGS5YA==
X-Received: by 2002:a2e:90c9:: with SMTP id o9mr2161824ljg.102.1555674716048;
        Fri, 19 Apr 2019 04:51:56 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id a2sm1106488lfi.13.2019.04.19.04.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 04:51:55 -0700 (PDT)
Subject: Re: [PATCH v1 0/2] clk: Tegra124 PLLM fixes
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190411214835.19947-1-digetx@gmail.com>
Message-ID: <46c12545-0e9e-93bf-2ccc-4577f4eb223e@gmail.com>
Date:   Fri, 19 Apr 2019 14:50:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411214835.19947-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.04.2019 0:48, Dmitry Osipenko пишет:
> Hello, here are two trivial patches that are correcting PLLM on Tegra124.
> First fixes system lockup due to a bad hardware configuration, second
> removes usage of a non-existent register bit.
> 
> Dmitry Osipenko (2):
>   clk: tegra: Fix PLLM programming on Tegra124+ when PMC overrides
>     divider
>   clk: tegra124: Remove lock-enable bit from PLLM
> 
>  drivers/clk/tegra/clk-pll.c      | 4 ++--
>  drivers/clk/tegra/clk-tegra124.c | 3 +--
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 

Hello Peter,

The patches in this series are trivial and fixing the longstanding bug on Tegra124. Could you please take a look and and ACK the series if it looks good to you?
