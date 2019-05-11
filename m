Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F8EC04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 07:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EA42173B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 07:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4i14I1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfEKHeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 03:34:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41493 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbfEKHeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 03:34:12 -0400
Received: by mail-lf1-f67.google.com with SMTP id d8so5656130lfb.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 00:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VYMNsonIo+IG9TrIXaQigopY1a/f6K0/11Iv0zcUuKI=;
        b=e4i14I1vgkAIJM6sGEreuc10IEhhFcUlYduA5b7nXVvztvv9rDkYiuE1762jZEWr3t
         bbx/HrOVdcfrShnhTCTflrJKf6BS9bmSXTKGXv4AY/dcswKOj6npf1YxdTxPrTCvT8lu
         k57aWMZLjoq2Ir8xV5XJbyDLHJ6lxDsNtNy8CCfA6DXlOS3r2sAiihSCPNcQ4tuuEsJu
         2cZGMBU+19IMaGfrnU2kgFPUrgkvBL2OMsxGM82mtj9geRStVCsFJiU2IGC2zpazgQ5o
         4aGmWJRFSO+L1MJqYX0d2M7VQvXdgvOrPEw7t3nVrsvep9RJbGIqP3RYSc2Wz6qL4hwn
         PWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VYMNsonIo+IG9TrIXaQigopY1a/f6K0/11Iv0zcUuKI=;
        b=rHhQRMj9sdRTReTqtGkQ68wxg84a9Uw6UauQfVNGvjiHcU2wyFqHhsG+nQ9r3Awnsf
         1GMM/523txJ5hYzUaiUOYo/ctNi0zU2hMxxfzzckiGcZs1LRsBMkvtXTFWgNmeyRlYIO
         doNO1RLMJ79nZHciWDkbQ+WiWkCHSZtbpPEyBYt1jaGiYFQbJdSh+38dVo7QRfmhBbr1
         kYZBdMcRxMjwboSwoAjvn5Pru1S5UuQDCLcZ1NntkGsJ8+3TvbmPUQBctl8PXeuQat3p
         bAqPr6We4bUCjhWkdWzF0eoJySfpQVJKZu3iadyqCa4Jq/j0JIoqu7F74xdU5gbL8fIo
         NS1g==
X-Gm-Message-State: APjAAAWzuYvWnQh5wRm2p7j4EdHGrmC2jVb6tScKt0q3X2Xs+hXcpDx1
        p5ykofMpcoMFFq1qOjJ5RTq+xy1K1nhsydQFgvw=
X-Google-Smtp-Source: APXvYqwIEZj28vylIgR4DLMiLlma/7z4DYfLQelqTbZqO4thIGahdVBkqNkJf3HjWD/mqVEbPHrMr0xG+tywt/JjAY0=
X-Received: by 2002:ac2:4109:: with SMTP id b9mr7738780lfi.90.1557560049788;
 Sat, 11 May 2019 00:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <1554557789-9474-1-git-send-email-jrdr.linux@gmail.com>
 <e7de2c3d-01cf-52fb-f00a-2c4321009d08@codeaurora.org> <CAFqt6zaX5LT79o7exTxVQhLiSwBRFqtqmaJNwuE+hqs3j-XZdA@mail.gmail.com>
In-Reply-To: <CAFqt6zaX5LT79o7exTxVQhLiSwBRFqtqmaJNwuE+hqs3j-XZdA@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 11 May 2019 13:03:58 +0530
Message-ID: <CAFqt6zadoST-a-i8MC0yGvbF=SCpAsuD-scq2tYvNeiLHDHQgg@mail.gmail.com>
Subject: Re: [PATCH] perf: Remove duplicate headers
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, acme@kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        namhyung@kernel.org, ak@linux.intel.com,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 5:27 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Sun, Apr 7, 2019 at 12:20 AM Mukesh Ojha <mojha@codeaurora.org> wrote:
> >
> >
> > On 4/6/2019 7:06 PM, Souptick Joarder wrote:
> > > Removed duplicate headers which are included twice.
> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
>
> If no further comment, can we get this patch in queue for 5.2 ?

Can we get this in queue for 5.2 ?

>
> >
> > Cheers,
> > -Mukesh
> >
> > > ---
> > >   tools/perf/util/data.c                 | 1 -
> > >   tools/perf/util/get_current_dir_name.c | 1 -
> > >   tools/perf/util/stat-display.c         | 1 -
> > >   3 files changed, 3 deletions(-)
> > >
> > > diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> > > index 6a64f71..509a41e 100644
> > > --- a/tools/perf/util/data.c
> > > +++ b/tools/perf/util/data.c
> > > @@ -8,7 +8,6 @@
> > >   #include <unistd.h>
> > >   #include <string.h>
> > >   #include <asm/bug.h>
> > > -#include <sys/types.h>
> > >   #include <dirent.h>
> > >
> > >   #include "data.h"
> > > diff --git a/tools/perf/util/get_current_dir_name.c b/tools/perf/util/get_current_dir_name.c
> > > index 267aa60..ebb80cd 100644
> > > --- a/tools/perf/util/get_current_dir_name.c
> > > +++ b/tools/perf/util/get_current_dir_name.c
> > > @@ -5,7 +5,6 @@
> > >   #include "util.h"
> > >   #include <unistd.h>
> > >   #include <stdlib.h>
> > > -#include <stdlib.h>
> > >
> > >   /* Android's 'bionic' library, for one, doesn't have this */
> > >
> > > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > > index 6d043c7..7b3a16c 100644
> > > --- a/tools/perf/util/stat-display.c
> > > +++ b/tools/perf/util/stat-display.c
> > > @@ -12,7 +12,6 @@
> > >   #include "string2.h"
> > >   #include "sane_ctype.h"
> > >   #include "cgroup.h"
> > > -#include <math.h>
> > >   #include <api/fs/fs.h>
> > >
> > >   #define CNTR_NOT_SUPPORTED  "<not supported>"
