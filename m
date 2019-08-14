Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4290AC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDEC2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8WaEs0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbfHNSEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:04:46 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39011 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfHNSEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:04:45 -0400
Received: by mail-ot1-f66.google.com with SMTP id b1so40299otp.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fre2yC1vMIg/Ij78+LtkTPs0yDzqDgWHdQaFD72Ay5k=;
        b=c8WaEs0gX1vkjN0sz8yITmdD0epqeCGI9JTG8KM5bgB0UgZPBGAMS/52zXuwINa7PF
         Zq55ouRXA2at27mYggoXxEu5betH2SU1k8k86RQ5YEvyOi+ySgd8d0YF40JIloaUl7pg
         r0waHNmZr+006um7SjxpIaCgr/kFWl/U1c/DN+zFuN5y0XolPOgD+lI8Z6u5zf8PDI2g
         c4m3QFEvVOOgC5lexEG/lhhdZMNTcyi+qee4NOhsuzfhma3iiAO3yfiTUCJVsvOQlTtk
         ZxSMFtmK7Wza50DHp7orALP+H66VUKsJ9/ekXlx0Y7rhuTg1T3T8PQpKIsel6/ScaPgF
         0mHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fre2yC1vMIg/Ij78+LtkTPs0yDzqDgWHdQaFD72Ay5k=;
        b=hUqVyMPcU/NWXgHod0WID0L2RE6VHjrErfTXwOIytsPtVGf73+KOX+V2LLUQcWvL0i
         ihIIybe3VoIa+uvV5mg8f6wgEqnDT6z0I4Cv4nyYup65XnKo64i7BhTa/YV+UJEQ6DYn
         YZcp7HgiE8hxUFsxWN4hJqD+dPRKvwCeE8pcX9fk0sca2UDeKVOAXHYah5d2Qvv+Dg7r
         CaRAnTgeewom8JIv3jeZ2E+S1mGoVQE7poY7U08Tc37AZra5YoUwFmimRvfNlLYoUJ/D
         Mwy2ftXIQUmo4vbDlXQtXOAsRw6DxLoA0TpF4JfjKdaiFsEJa3Lr87PnErnjCNyx0J9H
         AyOQ==
X-Gm-Message-State: APjAAAUc3aTqhkNMf+7l8WABgu7l+R39cnVbt1v22bESmdq4ysSgzk6/
        jF3D1MdSLxFe/4pBRhGW/mPragSuLd6AbffvBus6fw==
X-Google-Smtp-Source: APXvYqyF6QAjCvLdwmaPHuxijiZA4sSwGBMmI5G/Jyqgb3QpoKsmhl6M6l6c5naR8I/d5DEBmigS5GeVcoPQVqAXfRc=
X-Received: by 2002:a6b:720e:: with SMTP id n14mr1241464ioc.139.1565805884486;
 Wed, 14 Aug 2019 11:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1565188228.git.ilubashe@akamai.com> <291d2cda6ee75b4cd4c9ce717c177db18bf03a31.1565188228.git.ilubashe@akamai.com>
In-Reply-To: <291d2cda6ee75b4cd4c9ce717c177db18bf03a31.1565188228.git.ilubashe@akamai.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 14 Aug 2019 12:04:33 -0600
Message-ID: <CANLsYkxZE0CQJKQ-bFi=zFV5vTCbL2v76+x1fmCpqNruqWiFXg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] perf: Use CAP_SYSLOG with kptr_restrict checks
To:     Igor Lubashev <ilubashe@akamai.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2019 at 08:44, Igor Lubashev <ilubashe@akamai.com> wrote:
>
> Kernel is using CAP_SYSLOG capability instead of uid==0 and euid==0 when
> checking kptr_restrict. Make perf do the same.
>
> Also, the kernel is a more restrictive than "no restrictions" in case of
> kptr_restrict==0, so add the same logic to perf.
>
> Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
> ---
>  tools/perf/util/symbol.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 173f3378aaa0..046271103499 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -4,6 +4,7 @@
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <string.h>
> +#include <linux/capability.h>
>  #include <linux/kernel.h>
>  #include <linux/mman.h>
>  #include <linux/time64.h>
> @@ -15,8 +16,10 @@
>  #include <inttypes.h>
>  #include "annotate.h"
>  #include "build-id.h"
> +#include "cap.h"
>  #include "util.h"
>  #include "debug.h"
> +#include "event.h"
>  #include "machine.h"
>  #include "map.h"
>  #include "symbol.h"
> @@ -890,7 +893,11 @@ bool symbol__restricted_filename(const char *filename,
>  {
>         bool restricted = false;
>
> -       if (symbol_conf.kptr_restrict) {
> +       /* Per kernel/kallsyms.c:
> +        * we also restrict when perf_event_paranoid > 1 w/o CAP_SYSLOG
> +        */
> +       if (symbol_conf.kptr_restrict ||
> +           (perf_event_paranoid() > 1 && !perf_cap__capable(CAP_SYSLOG))) {
>                 char *r = realpath(filename, NULL);
>

# echo 0 > /proc/sys/kernel/kptr_restrict
# ./tools/perf/perf record -e instructions:k uname
perf: Segmentation fault
Obtained 10 stack frames.
./tools/perf/perf(sighandler_dump_stack+0x44) [0x55af9e5da5d4]
/lib/x86_64-linux-gnu/libc.so.6(+0x3ef20) [0x7fd31efb6f20]
./tools/perf/perf(perf_event__synthesize_kernel_mmap+0xa7) [0x55af9e590337]
./tools/perf/perf(+0x1cf5be) [0x55af9e50c5be]
./tools/perf/perf(cmd_record+0x1022) [0x55af9e50dff2]
./tools/perf/perf(+0x23f98d) [0x55af9e57c98d]
./tools/perf/perf(+0x23fc9e) [0x55af9e57cc9e]
./tools/perf/perf(main+0x369) [0x55af9e4f6bc9]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe7) [0x7fd31ef99b97]
./tools/perf/perf(_start+0x2a) [0x55af9e4f704a]
Segmentation fault

I can reproduce this on both x86 and ARM64.

>                 if (r != NULL) {
> @@ -2190,9 +2197,9 @@ static bool symbol__read_kptr_restrict(void)
>                 char line[8];
>
>                 if (fgets(line, sizeof(line), fp) != NULL)
> -                       value = ((geteuid() != 0) || (getuid() != 0)) ?
> -                                       (atoi(line) != 0) :
> -                                       (atoi(line) == 2);
> +                       value = perf_cap__capable(CAP_SYSLOG) ?
> +                                       (atoi(line) >= 2) :
> +                                       (atoi(line) != 0);
>
>                 fclose(fp);
>         }
> --
> 2.7.4
>
