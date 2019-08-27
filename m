Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F782C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE382173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KFgGwNZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfH1Rgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:36:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41800 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfH1Rge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:36:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so96141pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 10:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y7AaO08GNeBs1I9FpBRTfd4SN2SpcypvdLrR4vqi9sI=;
        b=KFgGwNZ7C9KzlJgrEoNn5Qccz43atu/G2HDVJ/8zRILoH/d4hSZ7kEC7mIaT4Tspt3
         PMbyS1u6tK/7R6dTIU8xUzFoNnyOTmHn4pd9rLlw/eLTA4iPD8tSRZoHKi4AmMLF3Qqj
         3p2aWfOGqOY4e910NMMC3GWYP4rVP3Usdsy0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y7AaO08GNeBs1I9FpBRTfd4SN2SpcypvdLrR4vqi9sI=;
        b=js5nRBnzrPEGu7WZ8pBrx4ZnXBSxJbIcdgRwojac5E1pkj8x4NO715rhAUrrp5uWdf
         gtZlPMH+6OgTWFpC8ejLCJl8Pm2u4hbCAGBnRPBXlOQv9WpXPdhCkwhCGT33wJguF4YV
         5q8GPY760m7nXYK3el6hLvLG++uptO9YqVjdjHpsByWgwlnIMYlSKXqW5AXaYBMrXoXl
         IYefiRk6Ww/nRMyAI4GCBBpdRZt2gbxkorvVVuYQHIBtM+KzYXQjbfYIrwPGN8ccovln
         g42hrg95nOOQbgsvua1gLvrhsb06zIM1MV1+rcfXFUs+geR9hCj/sDGO3LlnFpdg5Mia
         Kgzg==
X-Gm-Message-State: APjAAAVPviHEfa/kwBEhCwzYyXDEkzrQETSvxIoFe2VqWFP4WmILnt0l
        ZOqdZ607pUSnnZ96urTIgWcpgA==
X-Google-Smtp-Source: APXvYqwdSIUzbK+ujzl7lTqIrYLOBarMQnxoWqQZbPnCgRqhdxwopQiTozDRkFpmIqW7qRmrruCeTA==
X-Received: by 2002:a63:4846:: with SMTP id x6mr4515289pgk.332.1567013793432;
        Wed, 28 Aug 2019 10:36:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a23sm3234684pfo.80.2019.08.28.10.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 10:36:29 -0700 (PDT)
Date:   Tue, 27 Aug 2019 10:51:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH v2 0/6] Rework REFCOUNT_FULL using atomic_fetch_*
 operations
Message-ID: <201908271051.5B9C9F25@keescook>
References: <20190827163204.29903-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827163204.29903-1-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 05:31:58PM +0100, Will Deacon wrote:
> Hi all,
> 
> This is version two of the patches I previously posted here:
> 
>   https://lkml.kernel.org/r/20190802101000.12958-1-will@kernel.org
> 
> Changes since v1 include:
> 
>   * Avoid duplicate WARNs when incrementing from zero
>   * Some crude lktdm perf results to motivate the change:
> 
>     # perf stat -r 3 -B -- echo {ATOMIC,REFCOUNT}_TIMING >/sys/kernel/debug/provoke-crash/DIRECT
> 
>     # arm64
>     ATOMIC_TIMING:					46.50451 +- 0.00134 seconds time elapsed  ( +-  0.00% )
>     REFCOUNT_TIMING (REFCOUNT_FULL, mainline):		77.57522 +- 0.00982 seconds time elapsed  ( +-  0.01% )
>     REFCOUNT_TIMING (REFCOUNT_FULL, this series):	48.7181 +- 0.0256 seconds time elapsed  ( +-  0.05% )
> 
>     # x86
>     ATOMIC_TIMING:					31.6225 +- 0.0776 seconds time elapsed  ( +-  0.25% )
>     REFCOUNT_TIMING (!REFCOUNT_FULL, mainline/x86 asm): 31.6689 +- 0.0901 seconds time elapsed  ( +-  0.28% )
>     REFCOUNT_TIMING (REFCOUNT_FULL, mainline):		53.203 +- 0.138 seconds time elapsed  ( +-  0.26% )
>     REFCOUNT_TIMING (REFCOUNT_FULL, this series):	31.7408 +- 0.0486 seconds time elapsed  ( +-  0.15% )

Nice improvements! :) Please consider the series:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Cheers,
> 
> Will
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Elena Reshetova <elena.reshetova@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Jan Glauber <jglauber@marvell.com>
> 
> --->8
> 
> Will Deacon (6):
>   lib/refcount: Define constants for saturation and max refcount values
>   lib/refcount: Ensure integer operands are treated as signed
>   lib/refcount: Remove unused refcount_*_checked() variants
>   lib/refcount: Move bulk of REFCOUNT_FULL implementation into header
>   lib/refcount: Improve performance of generic REFCOUNT_FULL code
>   lib/refcount: Consolidate REFCOUNT_{MAX,SATURATED} definitions
> 
>  drivers/misc/lkdtm/refcount.c |   8 --
>  include/linux/refcount.h      | 236 +++++++++++++++++++++++++++++++++++++----
>  lib/refcount.c                | 237 +-----------------------------------------
>  3 files changed, 218 insertions(+), 263 deletions(-)
> 
> -- 
> 2.11.0
> 

-- 
Kees Cook
