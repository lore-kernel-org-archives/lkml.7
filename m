Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53C7C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C163D2087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FA9r/2CC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389502AbfIDSHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:07:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35269 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389066AbfIDSHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:07:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id g7so22308921wrx.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 11:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pNxF1eREpDVfAwH6P4Jz2ZR6a4tSQss5fAPg9xipcU=;
        b=FA9r/2CC69zrS4nHuU7/ZJsIVHzlYShr6fmJ9cEc28SsCM0dUkvafTdZzwpdBAt2UJ
         jgxR/dmssZ0xRcjzo8HoyhLmr8+B211eJV67GRxLPu86Kh08UJ1M1p+lCItWU9YBYMaP
         APb5itG0fZ19ZkUDqEPz9SJpJu/LnXye6hZ5ZtVEqo8WP/O4eoRmU/L14TfW3+/K1Iaw
         JTJFif5NJ9zgEIzRwPA2gZGm20IFW/hWZHk4qoXyXrYt3I5F4HQvmvCA10jlLa8lk3Vp
         2MEc68xp6S66OT+1IObXV0L3CeWimjP7T92glaYZ4xeielSt4PxHZK5WPz9JnXCHmnLB
         bDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pNxF1eREpDVfAwH6P4Jz2ZR6a4tSQss5fAPg9xipcU=;
        b=oDsbi08iNejWDrNUyVWbiO4JQaTj4cekjFIfkAnqQONqAPmlTROmwudvqMuHUuRzTJ
         KYy/2ZcvaBeJQfdn8mguM/DZ04a5iNZmoiSJDmgIqSliC8vz3QSnZ8lovaUatb5FOLp4
         UjVfrJCIXbJecStKeb85Sbrg4NfLAUCrVHU21+mqxc+HiuG2o0kkgYRpLqALVgx8CCAj
         FNcOp187n51Wt89PVM7UYA8gXllXmS55tMMqU9W1GvxEfvyRvOkQgmhGGtdJ0ZE5Fxi8
         Nw2TG+m13uWza0FOvFXakzk+KXjz7XCNHCRs6YGZtZU6Oai+zE4ooxux4L9I3zQgcvc8
         T2tg==
X-Gm-Message-State: APjAAAWmnKbjXgvULAlOtreY5ABhFC/8WjQ6NwKBcWt7PXAcZ95QbpDS
        9KLWFKK1FCx31CG2zJwk96vPHfI7wXMTe9m3sV4hzA==
X-Google-Smtp-Source: APXvYqw1PiXtVVva1gwnaGI3eyRH6HOU+Beb+APJ8gT0kJZ5PRbpcdwK3VG10lRtE7999s45H+XmUEwn8pdTuluQXVU=
X-Received: by 2002:a5d:6703:: with SMTP id o3mr10511544wru.335.1567620453261;
 Wed, 04 Sep 2019 11:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190904180045.138513-1-irogers@google.com>
In-Reply-To: <20190904180045.138513-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 4 Sep 2019 11:07:21 -0700
Message-ID: <CAP-5=fXdZudoPWGASVVB0YKAok9hTBKAY43h7prSX7=1PPoR3w@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Fix include paths in ui
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies, this was an accidental resend of a patch that's already
merged fa37bab6d7154658d8a35920513f9396587754cc.

Ian

On Wed, Sep 4, 2019 at 11:01 AM Ian Rogers <irogers@google.com> wrote:
>
> These paths point to the wrong location but still work because they
> get picked up by a -I flag that happens to direct to the correct
> file. Fix paths to point to the correct location without -I flags.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/ui/browser.c      | 9 +++++----
>  tools/perf/ui/tui/progress.c | 2 +-
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
> index f80c51d53565..d227d74b28f8 100644
> --- a/tools/perf/ui/browser.c
> +++ b/tools/perf/ui/browser.c
> @@ -1,7 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include "../string2.h"
> -#include "../config.h"
> -#include "../../perf.h"
> +#include "../util/util.h"
> +#include "../util/string2.h"
> +#include "../util/config.h"
> +#include "../perf.h"
>  #include "libslang.h"
>  #include "ui.h"
>  #include "util.h"
> @@ -14,7 +15,7 @@
>  #include "browser.h"
>  #include "helpline.h"
>  #include "keysyms.h"
> -#include "../color.h"
> +#include "../util/color.h"
>  #include <linux/ctype.h>
>  #include <linux/zalloc.h>
>
> diff --git a/tools/perf/ui/tui/progress.c b/tools/perf/ui/tui/progress.c
> index bc134b82829d..5a24dd3ce4db 100644
> --- a/tools/perf/ui/tui/progress.c
> +++ b/tools/perf/ui/tui/progress.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/kernel.h>
> -#include "../cache.h"
> +#include "../../util/cache.h"
>  #include "../progress.h"
>  #include "../libslang.h"
>  #include "../ui.h"
> --
> 2.22.0.770.g0f2c4a37fd-goog
>
