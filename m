Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7BEC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A692073F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oM5zxwWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKUMHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 07:07:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40512 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfKUMHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 07:07:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id 4so770759wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 04:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7mYFFCf+Z8nXytmTMuBZdPdUGhhj9kPEmros5X8MpI8=;
        b=oM5zxwWj71aKIK5gCiqEg+Xfgz/PgCFK35D6Tf7BaiVD9qsk4r29bvVMeiKyDwuiZa
         RUjplmH7Qag3ZB7ejbg//qBuodF/HGAHEzs6LpMUn4oRs6UtJSK9a3aGNFuVfbqAcCEo
         uAGfWXRH1XHvAWZ2pprlEs5whnjdpwqPwud/6fflCdfnpBiJJJEh5lNigfjXvsuhpLaD
         sDw4jcg6m6ibTEMBcnqoLufTobjrnwy+UOP3p4ajmvuAv8rFsn5wXjGX7dhuStr+nPgy
         Ky92E4k/8Qj1pdpE3gdiaV+IVoKWI5LGjk2O0EWg8HFcg2ALYbwRwiimbjXTIXO1/wsT
         32sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7mYFFCf+Z8nXytmTMuBZdPdUGhhj9kPEmros5X8MpI8=;
        b=hz0zs7/31yYSzFmvTqBxQe4/A+xs3Bsa0ryCfSi97dfWu0pBKjiakQSQ9We0KbqDho
         WLHENHnYPin4cUUmUTrmfQ8SHcSlvBBoFF4BKQulDgbz/eatWlllPpmAc/OJrXwszPDM
         wgO9eIQHGAE3VVQOxBRIiTQVu5jYWs8Y6XzUwBlLpweAMeOpCO8PJEUKE4c3ZAvu3KRi
         QIUiwIWfh5p3HwTNeEwRBvDQEH9bNGtYURx7vJNC5qtjfts1ZrVNE6Ug+nXTEDYsU/vw
         mCdzJ1CaJcb9ssu4t+PIGnHiJ/nntWOw9uzlU1zlbtMUR/HLnzToNk4cKJb1DYklQqzs
         5qMA==
X-Gm-Message-State: APjAAAWSZjDuv04sh4m//iw+gV9bRwQB90gcGNt5R/3hv6h3D0BIYI55
        LGGanN/iTUTPjwWyYCXJW36bP7zPqmxJwi3jkbSV6w==
X-Google-Smtp-Source: APXvYqy6hGQ0wJNUCAKu1MGiGHRqX9gJyFiRnZfGuHAvB39GJT5pxL0cV3J7ESw6KZzJ2qr/Xk/7ExxM/1+otTXGMm4=
X-Received: by 2002:adf:f20d:: with SMTP id p13mr9663729wro.325.1574338064211;
 Thu, 21 Nov 2019 04:07:44 -0800 (PST)
MIME-Version: 1.0
References: <20191121115902.2551-1-will@kernel.org>
In-Reply-To: <20191121115902.2551-1-will@kernel.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 21 Nov 2019 13:07:32 +0100
Message-ID: <CAKv+Gu_w1uE=9on8xU7z5uvkXE2xvPKsOqxUv2W_FkEi=TmJhw@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 00/10] Rework REFCOUNT_FULL using atomic_fetch_* operations
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Hanjun Guo <guohanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 at 12:59, Will Deacon <will@kernel.org> wrote:
>
> Hi everybody,
>
> This is a resend of version four of the patches I posted here:
>
>   v4: https://lore.kernel.org/lkml/20191030143035.19440-1-will@kernel.org
>
> Previous versions can be found at:
>
>   v1: https://lkml.kernel.org/r/20190802101000.12958-1-will@kernel.org
>   v2: https://lkml.kernel.org/r/20190827163204.29903-1-will@kernel.org
>   v3: https://lkml.kernel.org/r/20191007154703.5574-1-will@kernel.org
>
> I didn't receive any feedback last time around, other than some positive
> noises from Kees, so please consider this for inclusion in mainline.
>

For the series,

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>


> Cc: Kees Cook <keescook@chromium.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Elena Reshetova <elena.reshetova@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
>
> --->8
>
> Will Deacon (10):
>   lib/refcount: Define constants for saturation and max refcount values
>   lib/refcount: Ensure integer operands are treated as signed
>   lib/refcount: Remove unused refcount_*_checked() variants
>   lib/refcount: Move bulk of REFCOUNT_FULL implementation into header
>   lib/refcount: Improve performance of generic REFCOUNT_FULL code
>   lib/refcount: Move saturation warnings out of line
>   lib/refcount: Consolidate REFCOUNT_{MAX,SATURATED} definitions
>   refcount: Consolidate implementations of refcount_t
>   lib/refcount: Remove unused 'refcount_error_report()' function
>   drivers/lkdtm: Remove references to CONFIG_REFCOUNT_FULL
>
>  arch/Kconfig                       |  21 ---
>  arch/arm/Kconfig                   |   1 -
>  arch/arm64/Kconfig                 |   1 -
>  arch/s390/configs/debug_defconfig  |   1 -
>  arch/x86/Kconfig                   |   1 -
>  arch/x86/include/asm/asm.h         |   6 -
>  arch/x86/include/asm/refcount.h    | 126 --------------
>  arch/x86/mm/extable.c              |  49 ------
>  drivers/gpu/drm/i915/Kconfig.debug |   1 -
>  drivers/misc/lkdtm/refcount.c      |  11 +-
>  include/linux/kernel.h             |   7 -
>  include/linux/refcount.h           | 269 ++++++++++++++++++++++++-----
>  kernel/panic.c                     |  11 --
>  lib/refcount.c                     | 255 +++------------------------
>  14 files changed, 257 insertions(+), 503 deletions(-)
>  delete mode 100644 arch/x86/include/asm/refcount.h
>
> --
> 2.24.0.432.g9d3f5f5b63-goog
>
