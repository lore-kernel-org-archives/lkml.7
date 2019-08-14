Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162CBC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45B821851
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oA7C+rGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfHNSsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:48:54 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37494 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbfHNSsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:48:51 -0400
Received: by mail-qk1-f193.google.com with SMTP id s14so12984774qkm.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+sR6B4cibYHHnwu3bpvdAPRMk/urhyGa01jZXxbES1Q=;
        b=oA7C+rGeWO+kai4F3ga/FeOri9pLYQdfPJV5xq2YcO2RXXCUonn/3Hc76IpdWEqePw
         CttxZrCTuMhAmfsTM8k38lY0DZICnt7imjxuWevt/GKhIFiplYs1xERZaVCHbu75WHmQ
         f3wPKrGSiDUceJBtU7Ggeb6kX8laV44lmleMkmKrIdA+wKFBhwjyCyhadmQTX9xPpFNR
         LJxXPtFJbTVLY7qcbW2hBqd9r/+3ZMz4csGfW7n9kJTwaC4V/EF9Dnxhn/NmGLWBU+a4
         CrsBDaENLHwHiFH5V3ieghKsjDGC9B3dBrD9RbHFZ85vMTPIIclViLdzpGVf4g24mbtE
         xb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+sR6B4cibYHHnwu3bpvdAPRMk/urhyGa01jZXxbES1Q=;
        b=curU6MAZCmHhzL6HutKSZ7AQ/ccGAflbQLTVOd7kPdLfO6DbO8TW5rosz4vqb1mujA
         rPW2Cmm2GfC70a0H76OzP3+L0iD982Lx/EKde0dkxhajd6Sn81ycka+JxcgH8cOr0ffW
         7enxGVA3bcRqkphNdncdarElhMOd5tmO5gNQUokI68Gl0OycFwEEH0yhQCzfM3DKpUGP
         9auyrAzvSOm6+7PizL8KcVoGjVPQalTCM4iEKwCNXQ+H/J04rDJcxuupk2BCoN1dNfgu
         sNbK2QAKanowOCjqjaEM2h9tPjqeXXDREs1b1Cutu6iAkMJfSEdVGGP0mB93fwSkMlBp
         k3fg==
X-Gm-Message-State: APjAAAXQoWqad/+1yoKQCbtT90Bz+oqfcElz5xh1HogxMrilA27KXSVJ
        Gmq4TM6QcJAFowKritNtwG4=
X-Google-Smtp-Source: APXvYqz9t+C5VxkFmBvtszjVLG9Pd0REDNluFsmwiUKRXEQHcaBqmDeECAKjQdJUt+PDNOrUuBMMpw==
X-Received: by 2002:a05:620a:693:: with SMTP id f19mr855962qkh.189.1565808530358;
        Wed, 14 Aug 2019 11:48:50 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.212.110])
        by smtp.gmail.com with ESMTPSA id d12sm304687qkk.39.2019.08.14.11.48.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:48:50 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6029B40857; Wed, 14 Aug 2019 15:48:14 -0300 (-03)
Date:   Wed, 14 Aug 2019 15:48:14 -0300
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Igor Lubashev <ilubashe@akamai.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH v3 3/4] perf: Use CAP_SYSLOG with kptr_restrict checks
Message-ID: <20190814184814.GM9280@kernel.org>
References: <cover.1565188228.git.ilubashe@akamai.com>
 <291d2cda6ee75b4cd4c9ce717c177db18bf03a31.1565188228.git.ilubashe@akamai.com>
 <CANLsYkxZE0CQJKQ-bFi=zFV5vTCbL2v76+x1fmCpqNruqWiFXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkxZE0CQJKQ-bFi=zFV5vTCbL2v76+x1fmCpqNruqWiFXg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 14, 2019 at 12:04:33PM -0600, Mathieu Poirier escreveu:
> On Wed, 7 Aug 2019 at 08:44, Igor Lubashev <ilubashe@akamai.com> wrote:
> >
> > Kernel is using CAP_SYSLOG capability instead of uid==0 and euid==0 when
> > checking kptr_restrict. Make perf do the same.
> >
> > Also, the kernel is a more restrictive than "no restrictions" in case of
> > kptr_restrict==0, so add the same logic to perf.
> >
> > Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
> > ---
> >  tools/perf/util/symbol.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 173f3378aaa0..046271103499 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -4,6 +4,7 @@
> >  #include <stdlib.h>
> >  #include <stdio.h>
> >  #include <string.h>
> > +#include <linux/capability.h>
> >  #include <linux/kernel.h>
> >  #include <linux/mman.h>
> >  #include <linux/time64.h>
> > @@ -15,8 +16,10 @@
> >  #include <inttypes.h>
> >  #include "annotate.h"
> >  #include "build-id.h"
> > +#include "cap.h"
> >  #include "util.h"
> >  #include "debug.h"
> > +#include "event.h"
> >  #include "machine.h"
> >  #include "map.h"
> >  #include "symbol.h"
> > @@ -890,7 +893,11 @@ bool symbol__restricted_filename(const char *filename,
> >  {
> >         bool restricted = false;
> >
> > -       if (symbol_conf.kptr_restrict) {
> > +       /* Per kernel/kallsyms.c:
> > +        * we also restrict when perf_event_paranoid > 1 w/o CAP_SYSLOG
> > +        */
> > +       if (symbol_conf.kptr_restrict ||
> > +           (perf_event_paranoid() > 1 && !perf_cap__capable(CAP_SYSLOG))) {
> >                 char *r = realpath(filename, NULL);
> >
> 
> # echo 0 > /proc/sys/kernel/kptr_restrict
> # ./tools/perf/perf record -e instructions:k uname
> perf: Segmentation fault
> Obtained 10 stack frames.
> ./tools/perf/perf(sighandler_dump_stack+0x44) [0x55af9e5da5d4]
> /lib/x86_64-linux-gnu/libc.so.6(+0x3ef20) [0x7fd31efb6f20]
> ./tools/perf/perf(perf_event__synthesize_kernel_mmap+0xa7) [0x55af9e590337]
> ./tools/perf/perf(+0x1cf5be) [0x55af9e50c5be]
> ./tools/perf/perf(cmd_record+0x1022) [0x55af9e50dff2]
> ./tools/perf/perf(+0x23f98d) [0x55af9e57c98d]
> ./tools/perf/perf(+0x23fc9e) [0x55af9e57cc9e]
> ./tools/perf/perf(main+0x369) [0x55af9e4f6bc9]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe7) [0x7fd31ef99b97]
> ./tools/perf/perf(_start+0x2a) [0x55af9e4f704a]
> Segmentation fault
> 
> I can reproduce this on both x86 and ARM64.

I don't see this with these two csets removed:

7ff5b5911144 perf symbols: Use CAP_SYSLOG with kptr_restrict checks
d7604b66102e perf tools: Use CAP_SYS_ADMIN with perf_event_paranoid checks

Which were the ones I guessed were related to the problem you reported,
so they are out of my ongoing perf/core pull request to Ingo/Thomas, now
trying with these applied and your instructions...

- Arnaldo
