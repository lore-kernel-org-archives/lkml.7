Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E206CC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 03:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A979520645
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 03:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EoCTxM5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDOD4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 23:56:09 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37635 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfDOD4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 23:56:09 -0400
Received: by mail-ua1-f66.google.com with SMTP id l17so5058167uar.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 20:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jyV5kTkay74pM8dbfwJjaag1cWzx8r525eT9xb4ekM8=;
        b=EoCTxM5L0BsAdeu1wLMyWdiXYcURtphU6nH8o2Ez/Qukwh6N9aHi4+sNnazKGkfiHN
         Ra81/Vf2+GKGPSxaVmPN15g/f1M7FkCM+5PO5TESa3y0HKr6UWvCdNT3aPR8JPIH2tVH
         hDSy5XhmrLKx1iMsHLfviCkhAHO0PISyoo2HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jyV5kTkay74pM8dbfwJjaag1cWzx8r525eT9xb4ekM8=;
        b=c71UVZkwm6ADCiA6m20+QKqLvs+X3R7SXGJO3pSj0yYBW2r5bnxa8D8H2qkaTyhUX9
         Whv2lpk/WfIYLdcU1nXsnPPuNopur7OxHNij2RAW/ZmxCpoM8pnYKPstGI/YqdZiv56F
         xung6LMgLysVyqm19kNkJbSvoAlvRVVHbYtUxLMwob5CV06rpBZBU9Stmy7ZF/lf8KoH
         mjc7/SqJ5dZK+utqzEENFXXczQJ2pQg4fjwVrCR4ajMrLA4p8eAwdQSMwkGFK2OrF5a7
         Hzo+kUc1HyTGTb6Sg6fRdd4JolSzJPR7h9LggIkVosmtjBGstzOzBjRUOxqadndk2s10
         TtXw==
X-Gm-Message-State: APjAAAXyGAZFNbQjThiSXe9QTILZyjvNwz5YBILKo9EwXb6PWAfPixLu
        hU1Mo+9Z0lfqDakluRE/jO12LLu9xcI=
X-Google-Smtp-Source: APXvYqybHBMvpBTaSuHr5+nmxVl2Hw9/A0th8n4yd7DMEpmPBZmJhog5lLD4mhDilhH/UmpE+hYZtQ==
X-Received: by 2002:ab0:7656:: with SMTP id s22mr36583548uaq.70.1555300567784;
        Sun, 14 Apr 2019 20:56:07 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id l9sm8316619uae.1.2019.04.14.20.56.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 20:56:07 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id g187so8662303vsc.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 20:56:06 -0700 (PDT)
X-Received: by 2002:a67:76c7:: with SMTP id r190mr8444700vsc.196.1555300566426;
 Sun, 14 Apr 2019 20:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190413224438.10802-1-okaya@kernel.org>
In-Reply-To: <20190413224438.10802-1-okaya@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 14 Apr 2019 20:55:55 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLRnq1WeDtMSwE_qnve_O9+GiZd4m=N=_1rBidwRwmeJg@mail.gmail.com>
Message-ID: <CAGXu5jLRnq1WeDtMSwE_qnve_O9+GiZd4m=N=_1rBidwRwmeJg@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] init: Do not select DEBUG_KERNEL by default
To:     Sinan Kaya <okaya@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 3:44 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> CONFIG_DEBUG_KERNEL has been designed to just enable Kconfig options.
> Kernel code generatoin should not depend on CONFIG_DEBUG_KERNEL.
>
> Proposed alternative plan: let's add a new symbol, something like
> DEBUG_MISC ("Miscellaneous debug code that should be under a more
> specific debug option but isn't"), make it depend on DEBUG_KERNEL and be
> "default DEBUG_KERNEL" but allow itself to be turned off, and then
> mechanically change the small handful of "#ifdef CONFIG_DEBUG_KERNEL" to
> "#ifdef CONFIG_DEBUG_MISC".

Thanks! This looks good to me. For the series:

Reviewed-by: Kees Cook <keescook@chromium.org>

Andrew, can you take these from lkml, or should the series get resent
directly to you? I think you might be the best to carry this?

Thanks!

-Kees

>
> Diff from v4:
> - collect reviewed-by
> - collect acked-by
> - fix nit on 1/5
>
> Sinan Kaya (5):
>   init: Introduce DEBUG_MISC option
>   powerpc: Replace CONFIG_DEBUG_KERNEL with CONFIG_DEBUG_MISC
>   mips: Replace CONFIG_DEBUG_KERNEL with CONFIG_DEBUG_MISC
>   xtensa: Replace CONFIG_DEBUG_KERNEL with CONFIG_DEBUG_MISC
>   net: Replace CONFIG_DEBUG_KERNEL with CONFIG_DEBUG_MISC
>
>  arch/mips/kernel/setup.c           | 2 +-
>  arch/powerpc/kernel/sysfs.c        | 8 ++++----
>  arch/xtensa/include/asm/irqflags.h | 2 +-
>  arch/xtensa/kernel/smp.c           | 2 +-
>  lib/Kconfig.debug                  | 9 +++++++++
>  net/netfilter/core.c               | 2 +-
>  6 files changed, 17 insertions(+), 8 deletions(-)
>
> --
> 2.21.0
>


-- 
Kees Cook
