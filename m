Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684C6C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429D420851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="om8CHXpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfFMS2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:28:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41410 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfFMS2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:28:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so11834513pff.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 11:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FemmaFQaRuutEOaISPpOpqicA0l7Z+VaG2En8NxAbN8=;
        b=om8CHXpui7NO/n4e0fAe/88mp2X04gjpzNTg0RhpC2P/3kC8OznZOg5t8HOFo+axq+
         9EtdPAdhP1fwLKFOlb0ozVWzxlbTlMttuMpAm7drb9bLM7LmR4Ui8RCsYJDzuYTkHaut
         oqMpurM7cd4UOxLlZ54GCkYlRHaCerc1SIOKXfte06yeQ1BpmnuUtNPMsLHbpz0j8oiG
         GV7YDiYts/dIVzk5ezT75fSCFLQ9cYVzhOTBXA6kjQW8d5h9uSjg28VaKaRWmMZtwOFw
         k5pGcFw3I2uOwmmrklCaIv+kLeXKcvkhfdBPOxmUulvSnPf11EOZC6Vn21Vlk+mKY0ST
         xafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FemmaFQaRuutEOaISPpOpqicA0l7Z+VaG2En8NxAbN8=;
        b=sibnITR2RYwWSZFAzK8O3tb9TDbck2oYMCvuATTg5/2o7xdQ37K6/1bJffyTuVvhjP
         BdxU1Fp1eP2SDHf6cxTS7HcL9RUSR+Hhy8nmp6aPnDRkkQvyviVbkNXnWJ8IsXQ3ExCf
         c97VeQ/rxzn/Cxf4Gjhn8AuN1jaedamArsmVJhuE7xUYsZANKyzK7fvhsnSmt5s/mPZV
         kVHzgyariehPwebSddsxuLF4EWDqGWU1uk+WZ23+f8om7mF6gDawPtbZ1ai5K58drZho
         YxkpLNSlzvJ8TcFYAehvdMpZitlmD/WJeD5guqDGeGUgo1E3SEBJQQZwzV5LEka0VwuG
         Syng==
X-Gm-Message-State: APjAAAX3Un9jBge8S1vZwiuisVU4++as5A38ANRiblnWCetVl9qsA7lw
        9Y+IVCawEPf+jKUUhQaw/vk6YmKyaSCO78tuaJ3jbA==
X-Google-Smtp-Source: APXvYqzEyXLM+Bi9kJiuud+sdXFaTtb19Ij33j9D+8uEzxfp4dA+FBSnDMPfcYwuWtzPB/pWhm7FVISawXRV/tfZlU8=
X-Received: by 2002:a62:2ec4:: with SMTP id u187mr93063583pfu.84.1560450488136;
 Thu, 13 Jun 2019 11:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdn930hhHcnCA9arJ5=9SsT-6BfFC_1punmUZX2xWM-Hnw@mail.gmail.com>
 <20190613182610.238801-1-nhuck@google.com>
In-Reply-To: <20190613182610.238801-1-nhuck@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 13 Jun 2019 11:27:57 -0700
Message-ID: <CAKwvOdnDw4X4odqiwqWze78BjOn04zatnU9WgOcv9Jw3RXLaPA@mail.gmail.com>
Subject: Re: [PATCH v2] memory: tegra: Fix -Wunused-const-variable
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 11:26 AM 'Nathan Huckleberry' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> Changes from v1 -> v2:
> * Moved definition of tegra124_mc_emem_regs into existing ifdef

Thanks for sending the v2, LGTM.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> --- a/drivers/memory/tegra/tegra124.c
> +++ b/drivers/memory/tegra/tegra124.c
> @@ -33,28 +33,6 @@
>  #define MC_EMEM_ARB_MISC1                      0xdc
>  #define MC_EMEM_ARB_RING1_THROTTLE             0xe0
>
> -static const unsigned long tegra124_mc_emem_regs[] = {
> -       MC_EMEM_ARB_CFG,
> -       MC_EMEM_ARB_OUTSTANDING_REQ,
> -       MC_EMEM_ARB_TIMING_RCD,
> -       MC_EMEM_ARB_TIMING_RP,
> -       MC_EMEM_ARB_TIMING_RC,
> -       MC_EMEM_ARB_TIMING_RAS,
> -       MC_EMEM_ARB_TIMING_FAW,
> -       MC_EMEM_ARB_TIMING_RRD,
> -       MC_EMEM_ARB_TIMING_RAP2PRE,
> -       MC_EMEM_ARB_TIMING_WAP2PRE,
> -       MC_EMEM_ARB_TIMING_R2R,
> -       MC_EMEM_ARB_TIMING_W2W,
> -       MC_EMEM_ARB_TIMING_R2W,
> -       MC_EMEM_ARB_TIMING_W2R,
> -       MC_EMEM_ARB_DA_TURNS,
> -       MC_EMEM_ARB_DA_COVERS,
> -       MC_EMEM_ARB_MISC0,
> -       MC_EMEM_ARB_MISC1,
> -       MC_EMEM_ARB_RING1_THROTTLE
> -};
> -
>  static const struct tegra_mc_client tegra124_mc_clients[] = {
>         {
>                 .id = 0x00,
> @@ -1049,6 +1027,28 @@ static const struct tegra_mc_reset tegra124_mc_resets[] = {
>  };
>
>  #ifdef CONFIG_ARCH_TEGRA_124_SOC
> +static const unsigned long tegra124_mc_emem_regs[] = {
> +       MC_EMEM_ARB_CFG,
> +       MC_EMEM_ARB_OUTSTANDING_REQ,
> +       MC_EMEM_ARB_TIMING_RCD,
> +       MC_EMEM_ARB_TIMING_RP,
> +       MC_EMEM_ARB_TIMING_RC,
> +       MC_EMEM_ARB_TIMING_RAS,
> +       MC_EMEM_ARB_TIMING_FAW,
> +       MC_EMEM_ARB_TIMING_RRD,
> +       MC_EMEM_ARB_TIMING_RAP2PRE,
> +       MC_EMEM_ARB_TIMING_WAP2PRE,
> +       MC_EMEM_ARB_TIMING_R2R,
> +       MC_EMEM_ARB_TIMING_W2W,
> +       MC_EMEM_ARB_TIMING_R2W,
> +       MC_EMEM_ARB_TIMING_W2R,
> +       MC_EMEM_ARB_DA_TURNS,
> +       MC_EMEM_ARB_DA_COVERS,
> +       MC_EMEM_ARB_MISC0,
> +       MC_EMEM_ARB_MISC1,
> +       MC_EMEM_ARB_RING1_THROTTLE
> +};
> +

-- 
Thanks,
~Nick Desaulniers
