Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF9CC352AB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070A12245D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ea8zW5Q5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfIZUfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 16:35:47 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37930 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbfIZUfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 16:35:47 -0400
Received: by mail-lf1-f65.google.com with SMTP id u28so203476lfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 13:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HerxThVT8ujE/Jr00Db0eehYsUrZnjs2sS0fus5u+5Y=;
        b=ea8zW5Q5pLPNlbbjEYHy5MA0Qt+9ppilVVkjIiA0KBMOa0uONSOd8J9Z2/yLcmZMpH
         Q/bZ02u0UKVHIRxfGCdwcoI3LUy+CxUEtCguH3PMzYRl/5ufSQO3CwqxokO5/y6jHAWU
         46Cj6qKsKCx2JexISICIbz5jXjn5QZlULVLBf5g4CE1j+IO/kpUwATJZ4qNkCqeAcpGH
         X1jaksbz0YohhVK/UTqDziXBXMiO2dyCRjFxmVKKvWiOnoTpoJHwMmVHJnlszehZye8Z
         CeJrOG7gI9CDuUhK4JJ4gZYCUcv9VkeLTdC+spzb52TkEMNJsO/YNB3wjPbkkVLnGyDw
         5unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HerxThVT8ujE/Jr00Db0eehYsUrZnjs2sS0fus5u+5Y=;
        b=C8EcEqHBTtiFR3ANP9nUnEYeSGvj8F5MlVyTDeKcwCDOvHMdDKSDKmIk0Kv2Qh3gOR
         y/w4dCgxzawH/Z1NrhO+qwyByMJNSPDHmspdvzakJ8w/hbBZMoEDNWfjqesPbJTtIMPT
         Xftw4XurLmMaOGkvJt4l82G7AkGSrzlm4NlDJqxEVAnbS5xy7+D1m13xKt4zReLfHeOe
         fkL3Vo/Phb1z8wEazevi79NIbbVNH3AmOgKyiTOfz4VT87p0tAAhX2K3PzNkp3ACt1jK
         oxI9+CuAKJz7l8ik+yB4zlVs6HQIsC/+XrZC+0FJk6hbIu+4jTH+uB5U1MHVMBo9Jeyn
         8UGw==
X-Gm-Message-State: APjAAAWNEdGs6yxudt7sIWAKV7C+4pewMePEZn1VKRmAtObY6Wh6OIap
        nszm4AS/seb56cRA2GM6ukHX6GAmTQSY3WqVnbAJTA==
X-Google-Smtp-Source: APXvYqxXovBWlN+vNe0WzjIx277ysSM4BAoh51kVziOHnD4dxzIrO+9uo50emy7bGVsFc/jHSFW9KUHw0RZnI6/p41o=
X-Received: by 2002:a19:f247:: with SMTP id d7mr251060lfk.191.1569530143446;
 Thu, 26 Sep 2019 13:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYu0hkS+NdwX38DNTygV1A7eebvjZvWvFUTfL=f3_4m=Dw@mail.gmail.com>
 <20190926173648.GA31477@kernel.org>
In-Reply-To: <20190926173648.GA31477@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 27 Sep 2019 02:05:32 +0530
Message-ID: <CA+G9fYt4fzmiFCsZXP+OC1joB=w5nkgn_MR++Yu61yWDWrh1yg@mail.gmail.com>
Subject: Re: perf build failed on linux -next on i386 build
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2019 at 23:06, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Sep 26, 2019 at 10:59:41PM +0530, Naresh Kamboju escreveu:
> > perf build failed on linux -next on i386 build
> >
> > build error:
> > perf-in.o: In function `libunwind__x86_reg_id':
> > tools/perf/util/libunwind/../../arch/x86/util/unwind-libunwind.c:109:
> > undefined reference to `pr_err'
> > tools/perf/util/libunwind/../../arch/x86/util/unwind-libunwind.c:109:
> > undefined reference to `pr_err'
>
> Can you try with the following patch?

Thanks for the patch.
After applying this below patch build completes.


>
>
> diff --git a/tools/perf/arch/x86/util/unwind-libunwind.c b/tools/perf/arch/x86/util/unwind-libunwind.c
> index 05920e3edf7a..47357973b55b 100644
> --- a/tools/perf/arch/x86/util/unwind-libunwind.c
> +++ b/tools/perf/arch/x86/util/unwind-libunwind.c
> @@ -1,11 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
>
>  #include <errno.h>
> +#include "../../util/debug.h"
>  #ifndef REMOTE_UNWIND_LIBUNWIND
>  #include <libunwind.h>
>  #include "perf_regs.h"
>  #include "../../util/unwind.h"
> -#include "../../util/debug.h"
>  #endif
>
>  #ifdef HAVE_ARCH_X86_64_SUPPORT

- Naresh
