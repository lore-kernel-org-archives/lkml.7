Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81334C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52031208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="shmyzcS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfFMR5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:57:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44716 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfFMR5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 13:57:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so11365914pgp.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 10:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gvi3tZQZW8BsXnnoPHE7/tSt7BU9a4p0zFemEkayFyo=;
        b=shmyzcS6AFgiPB1nhEgk44jVk3eNLX1aARrmVE8OENnn2AdYUATUUhHlTAhUlHPT9N
         s/lHWDBDWqG4wkty37QJKxMJY52HNh/VqxdWLatdAJkMTa5UXOQq+auk8MDb7WfnJCph
         RBXBQWvtS7TP620qbvH8dboY1HcoiUfCaCD+/nUf8Ijak9HJH6ZWun3rBMGPqCcELBC8
         M0fOH0xqHHYJr7B02BEhWAiBxpKe/6j0jFEbw7an0lPa+hzJkp/1OS/zfYeqEbh+9FwZ
         PIg2SuPJvG3phhWpWqjU/l5NBjp1DblJiz7SC876wWMcun+HYZBUMC/D0Tevtq1r2hnn
         532w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gvi3tZQZW8BsXnnoPHE7/tSt7BU9a4p0zFemEkayFyo=;
        b=oYyZfVn9ofbohfTDMcb43sqQWj2mkuTa530yiGX/J6ZhiNVypXLPx1wYtE1up1QDcs
         G0qxqJ92xAi1OqDF1SZmm0WskYDMD0/W9VU/ehiKv66c6lTX7qDzYuwH/S2Qr6nMB8CR
         /9Zk60cqTYmazafWmvkh3NiycBQGbdlAj5EDR1j4sTvMDyN7ZCFUZ5iGydy2Ios4xzex
         MYJh+4hP0nWjo7VIHyX6/yxSku6Pif4HF7XL84vkCvlS09cCNBFau4X6izKFggoNDkyn
         ZOQsnVdPBreYCc8k0PFD213/T7SaYEVPSm1M2fkdZm+/F+0hT5di4W3G9A39cATr5pa1
         6hdw==
X-Gm-Message-State: APjAAAXYQX0ANmkw0lVGMG/JwJr6ACAF9G6Ce4knbCsU6knT0mw7yhVg
        SoOSrenm6fT4WL0YAeur+v9yaooLHXZ/Kd863XXVxA==
X-Google-Smtp-Source: APXvYqxAYGf2nyn7RvafyLmEaNLIwVZn1BvKVF8YLkER24Z2GCAQ/6zg6iVCPlW+tmtllrOtZf/RVm96bknxr8csHtM=
X-Received: by 2002:a63:1d5c:: with SMTP id d28mr31397596pgm.10.1560448635576;
 Thu, 13 Jun 2019 10:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190613172746.216819-1-nhuck@google.com>
In-Reply-To: <20190613172746.216819-1-nhuck@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 13 Jun 2019 10:57:04 -0700
Message-ID: <CAKwvOdn930hhHcnCA9arJ5=9SsT-6BfFC_1punmUZX2xWM-Hnw@mail.gmail.com>
Subject: Re: [PATCH] memory: tegra: Fix -Wunused-const-variable
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 10:28 AM 'Nathan Huckleberry' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> The only usage of this variable is from within an ifdef.
> It seems logical to move the variable into the ifdef as well.

Thanks for the patch, I agree but have the same thoughts as in:
https://lkml.org/lkml/2019/6/13/1438

> +#ifdef CONFIG_ARCH_TEGRA_124_SOC
>  static const unsigned long tegra124_mc_emem_regs[] = {
>         MC_EMEM_ARB_CFG,
>         MC_EMEM_ARB_OUTSTANDING_REQ,
> @@ -54,6 +55,7 @@ static const unsigned long tegra124_mc_emem_regs[] = {
>         MC_EMEM_ARB_MISC1,
>         MC_EMEM_ARB_RING1_THROTTLE
>  };
> +#endif
-- 
Thanks,
~Nick Desaulniers
