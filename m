Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85DCC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AB5208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mtz4idoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbfFGTdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 15:33:53 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55623 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbfFGTdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 15:33:53 -0400
Received: by mail-it1-f196.google.com with SMTP id i21so4433125ita.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 12:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T9Tj5ZjKU2Dvst13bY90aPbdIlkQERL+pEiQI7+DM/c=;
        b=mtz4idoEP9NXZfE9sJM8pP6vJNipA8lG0eo3b6vZE463N7ghaR4SPIbPO4df8si5+5
         3fkLPdcJgpbXp9SselTVLUujvNG11FWbCNvXzrK7OnCrJ3j4/XE6sHeNe8+aazuwc+hb
         g+DFf8m8/ddOHtgs7V63N3LBFT5CmEiKAqPaIGt7DI+XWQy5X+3GH5H0EYpD/WL9ES5O
         R85konXlva+litJbCpGnuCpnddqpWjrR6UJ4zhNUnu54+AWFGly1aQ5KbHDDX2XtB28b
         wpNtHXBqoNPapFl/4KEWxDZufDgKDyyfLmIMXEfX0Btx+yzpICT/UgAbdPuXd6hZdtgz
         Dq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T9Tj5ZjKU2Dvst13bY90aPbdIlkQERL+pEiQI7+DM/c=;
        b=IFGBB2ZA7/2ZcdBhT6mSKOWO9ivLQl7O7aUM7soS+3GkDtjFliHwHmCx3ZXPPst+RX
         HGi+Vi0w1oVZrQwqy4EFt2YUpagKSUN3gAicCVpqIpZAMd6u+ceV7Hk5wpvNAR+KTnoZ
         +Tli6ZKRd0gOa2jr627cFFDTlszCu+PVnf/odS4FPhturUBKWBXuHSb8rZcN8vCcLI5z
         eAadzTtsBazpicUNz9txz4rUJqn1Z4NaWFoOkPNxEQWxehjvijaVvf7gaOv5ZLNSalOB
         PcJLt2rtiz85/n65tK7OWLIf0bY8o5D8j21qLEkKmm2driC1IUoXAVRysBUm6Uu55XAT
         vM9w==
X-Gm-Message-State: APjAAAWAylEbY2YexbNUp8FduyqUmBbjZUIl+FSgxmPUmaAmQjCw6xBc
        z7kaAlz+Q8rARMIzU0uA/gpc/12Gc5/HpHJ8H8GURA==
X-Google-Smtp-Source: APXvYqyIzt+gS3ConXIodeeRJIgcUDgjzZUqKKTsCWXlpXgPJnTVfaLQpACElYgwvkNg6VfdHTgVBjvO2IaFejVJzgU=
X-Received: by 2002:a24:14f:: with SMTP id 76mr5248389itk.115.1559936031969;
 Fri, 07 Jun 2019 12:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190524173508.29044-1-mathieu.poirier@linaro.org>
 <20190524173508.29044-2-mathieu.poirier@linaro.org> <68c1c548-33cd-31e8-100d-7ffad008c7b2@arm.com>
 <20190607182047.GK21245@kernel.org>
In-Reply-To: <20190607182047.GK21245@kernel.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 7 Jun 2019 13:33:41 -0600
Message-ID: <CANLsYkykW=rf_c6-ci=fV05u7TP9M3rrEUSdUn-bKw1PHvfoZQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] perf tools: Configure contextID tracing in
 CPU-wide mode
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jun 2019 at 12:20, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Fri, Jun 07, 2019 at 10:21:36AM +0100, Suzuki K Poulose escreveu:
> > Hi Mathieu,
> >
> > On 24/05/2019 18:34, Mathieu Poirier wrote:
> > > When operating in CPU-wide mode being notified of contextID changes is
> > > required so that the decoding mechanic is aware of the process context
> > > switch.
> > >
> > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >
> >
> > > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >
> > I am sorry but, I don't remember reviewing this patch in the previous
> > postings. But here we go.
>
> Can I keep it as is? I addressed one of your concerns below, please
> check.
>
> - Arnaldo
>
> > > +++ b/tools/perf/util/cs-etm.h
> > > @@ -103,6 +103,18 @@ struct intlist *traceid_list;
> > >   #define KiB(x) ((x) * 1024)
> > >   #define MiB(x) ((x) * 1024 * 1024)
> > > +/*
> > > + * Create a contiguous bitmask starting at bit position @l and ending at
> > > + * position @h. For example
> > > + * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
> > > + *
> > > + * Carbon copy of implementation found in $KERNEL/include/linux/bitops.h
> > > + */
> > > +#define GENMASK(h, l) \
> > > +   (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
> > > +
> >
> > minor nit: Could this be placed in a more generic header file for the other
> > parts of the perf tool to consume ?
> >
>
> Yeah, since we have:
>
> Good catch, we have it already:
>
> [acme@quaco perf]$ tail tools/include/linux/bits.h
>  * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
>  */
> #define GENMASK(h, l) \
>         (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
>
> #define GENMASK_ULL(h, l) \
>         (((~0ULL) - (1ULL << (l)) + 1) & \
>          (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
>
> #endif  /* __LINUX_BITS_H */
> [acme@quaco perf]$
> [acme@quaco perf]$
>
> So I'm adding this to the pile with a Suggested-by: Suzuki, ok?
>
> commit 3217a621248824fbff8563d8447fdafe69c5316d
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Fri Jun 7 15:14:27 2019 -0300
>
>     perf cs-etm: Remove duplicate GENMASK() define, use linux/bits.h instead
>
>     Suzuki noticed that this should be more useful in a generic header, and
>     after looking I noticed we have it already in our copy of
>     include/linux/bits.h in tools/include, so just use it, test built on
>     x86-64 and ubuntu 19.04 with:
>
>       perfbuilder@46646c9e848e:/$ aarch64-linux-gnu-gcc --version |& head -1
>       aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0
>       perfbuilder@46646c9e848e:/$
>
>     Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>     Link: https://lkml.kernel.org/r/68c1c548-33cd-31e8-100d-7ffad008c7b2@arm.com
>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     Cc: Jiri Olsa <jolsa@redhat.com>
>     Cc: Leo Yan <leo.yan@linaro.org>
>     Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: coresight@lists.linaro.org
>     Cc: linux-arm-kernel@lists.infradead.org,
>     Link: https://lkml.kernel.org/n/tip-69pd3mqvxdlh2shddsc7yhyv@git.kernel.org
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index 33b57e748c3d..bc848fd095f4 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -9,6 +9,7 @@
>
>  #include "util/event.h"
>  #include "util/session.h"
> +#include <linux/bits.h>
>
>  /* Versionning header in case things need tro change in the future.  That way
>   * decoding of old snapshot is still possible.
> @@ -161,16 +162,6 @@ struct cs_etm_packet_queue {
>
>  #define CS_ETM_INVAL_ADDR 0xdeadbeefdeadbeefUL
>
> -/*
> - * Create a contiguous bitmask starting at bit position @l and ending at
> - * position @h. For example
> - * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
> - *
> - * Carbon copy of implementation found in $KERNEL/include/linux/bitops.h
> - */
> -#define GENMASK(h, l) \
> -       (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
> -

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  #define BMVAL(val, lsb, msb)   ((val & GENMASK(msb, lsb)) >> lsb)
>
>  #define CS_ETM_HEADER_SIZE (CS_HEADER_VERSION_0_MAX * sizeof(u64))
