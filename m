Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBA3C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D7220821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AexG369C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfDPLxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:53:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46346 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfDPLxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:53:18 -0400
Received: by mail-lj1-f194.google.com with SMTP id h21so18779834ljk.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 04:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KKzZteUoYnB5M237F7sqY6QAfVxuQBuI8uPlIgH6EB8=;
        b=AexG369CRYdQCmr2MCGtQwtEEQx51bM9f4Xn4DgQRM6+k/mRU1AjaTjYJlC5pU6XIA
         frIIKaCU7cSQRr+L4f7mAM4/jS5wRKX/xp8V26G9NJltRlQnVqRK9hNfEZfBdnOIUe/t
         o1ktJVGtaAlPj9yNa0YIXAGHpnh1VJgHrY6+sce+U3rFbRzUhYKNVjiSEia3p7234jbL
         tX4KjthMsFuJ6qd8XBWP/uqjFPhpt3D0f3ndge416XVhG1aH8ln3OKfWjuI1668QchcW
         DgGzGVcF6z6ixg6sjob/m5ryRjvMXkbHcWGeXgmzNWgrWSRXx1aS9fUTWoxIpHplghAP
         eqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKzZteUoYnB5M237F7sqY6QAfVxuQBuI8uPlIgH6EB8=;
        b=BpQ4vWLc2wOOa6TLvVy8NJMNdQM/y4YHq/h9ff7MR7bPd5GyBiLEn61vth5yZdB0cU
         zyZScVnOsOLI8ZNfCBcFVcuo7iU25+QqsAISVTPVkITRYRCCrLTlNteD2D4/zw61VENv
         GS6gsHnuRNb9FNHLFypO6gC2N49/Qs7beAX7nritdw4txyJ+cH7IlJ+S9wrzUJoFBuHG
         eDMAdjdUcTcbfsky+ZPDUp8FQyOuvBBwlhvXw7NqnIktFHp9p23M1jHnrYKZyZJ30PEM
         udYcvhI/bqtlJrqDx641vxSYIzsiIkGmE3WvEFc0+DcP7xRqhN79JSM/kvIwf14k+yx2
         McHg==
X-Gm-Message-State: APjAAAWxkCSFI+jaTdb6Qf2bURw8W686n+Csdvw0W/dCB6MagEScbic3
        XeRsms8q3MrfrlUTcGBqTIhxANk7V98ApjaVuCY=
X-Google-Smtp-Source: APXvYqxge93svZowgv91Dkpb96fUdPqdxOnDktjzjMVWKb6/20Z1ct2f2WwVtHQRhs/0falbb/y90TlxkcqW/bbrWKo=
X-Received: by 2002:a2e:99c5:: with SMTP id l5mr15298405ljj.55.1555415596572;
 Tue, 16 Apr 2019 04:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <1554557789-9474-1-git-send-email-jrdr.linux@gmail.com> <e7de2c3d-01cf-52fb-f00a-2c4321009d08@codeaurora.org>
In-Reply-To: <e7de2c3d-01cf-52fb-f00a-2c4321009d08@codeaurora.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 16 Apr 2019 17:27:53 +0530
Message-ID: <CAFqt6zaX5LT79o7exTxVQhLiSwBRFqtqmaJNwuE+hqs3j-XZdA@mail.gmail.com>
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

On Sun, Apr 7, 2019 at 12:20 AM Mukesh Ojha <mojha@codeaurora.org> wrote:
>
>
> On 4/6/2019 7:06 PM, Souptick Joarder wrote:
> > Removed duplicate headers which are included twice.
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

If no further comment, can we get this patch in queue for 5.2 ?

>
> Cheers,
> -Mukesh
>
> > ---
> >   tools/perf/util/data.c                 | 1 -
> >   tools/perf/util/get_current_dir_name.c | 1 -
> >   tools/perf/util/stat-display.c         | 1 -
> >   3 files changed, 3 deletions(-)
> >
> > diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> > index 6a64f71..509a41e 100644
> > --- a/tools/perf/util/data.c
> > +++ b/tools/perf/util/data.c
> > @@ -8,7 +8,6 @@
> >   #include <unistd.h>
> >   #include <string.h>
> >   #include <asm/bug.h>
> > -#include <sys/types.h>
> >   #include <dirent.h>
> >
> >   #include "data.h"
> > diff --git a/tools/perf/util/get_current_dir_name.c b/tools/perf/util/get_current_dir_name.c
> > index 267aa60..ebb80cd 100644
> > --- a/tools/perf/util/get_current_dir_name.c
> > +++ b/tools/perf/util/get_current_dir_name.c
> > @@ -5,7 +5,6 @@
> >   #include "util.h"
> >   #include <unistd.h>
> >   #include <stdlib.h>
> > -#include <stdlib.h>
> >
> >   /* Android's 'bionic' library, for one, doesn't have this */
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index 6d043c7..7b3a16c 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -12,7 +12,6 @@
> >   #include "string2.h"
> >   #include "sane_ctype.h"
> >   #include "cgroup.h"
> > -#include <math.h>
> >   #include <api/fs/fs.h>
> >
> >   #define CNTR_NOT_SUPPORTED  "<not supported>"
