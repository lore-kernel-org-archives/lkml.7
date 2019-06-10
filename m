Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF38C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72715207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOywKse2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389092AbfFJTOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 15:14:22 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34893 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387674AbfFJTOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:14:22 -0400
Received: by mail-qt1-f196.google.com with SMTP id d23so11738590qto.2;
        Mon, 10 Jun 2019 12:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=be0Xj1JYK2edd9oqPBSOW2c3ig9z486wANl85cyO95U=;
        b=eOywKse2dwN/5KnWsPKPCnJ6WhR07i1AERazMm8MdwGf7KIsC1yMXlHv4Vx8K6bqmA
         LpItp00/7oVu6tx/4XeKBgG6WEdmWX2QwLt0icOgaKC/L8i1GvH7kWzRmIXHlMl0/3FY
         6M7B1ynHxgeJRXXIL16SHMU8KO9oa1IR7BXSIm1AD/gY9LCOyRPOKgHdMGkQ2zDK1Ixg
         mDqzPdfO6O1xMoB879xYHCz0wycr1HX6nlLO2bE4xlyW0c3Ts66tUKpQqT5+7wgVwOBa
         1qxCnmLQziSxp7DNWC6o5A+xkRgYayBqrh35DlL74BOvKanzMWKAKYPa4Gj0VZazPprq
         c58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=be0Xj1JYK2edd9oqPBSOW2c3ig9z486wANl85cyO95U=;
        b=CS4FROQr9+N4Kpj5Vpo6Gf0VAikJJYdXhwPgNU6JHWXBZC1hhEITEkZCXHr9Jf1m8B
         dmXhXUWKqqICWoayNRxG7v5hggDebcOK/m0ksdXi/xkbrOoLaR7miGdn16yzPrLtRcqH
         64AfI71YTuDkE3yUWZrWw5rgi4J3WN92MfLQeNfd4mZDu1ViPwq/tDTI31p3NCaMbKNa
         kKEKhvSlXCtSJJIuPd3mn5ZJxvI/P6vif9Wx+pTcL/9/uy20qIJpd50dDF9mqPb47qg8
         3en4aH2rV/qw9Ruax3+KsF/eRrCh39x1BdwAR3uFFCI1C3o3HmQ+FQJlBMkbNBekOqFr
         aE0A==
X-Gm-Message-State: APjAAAVW3MkBl46GFKBq/puhMxZ5Q4+zV31lpsgVXbiPQ1mZPHhCa7NG
        9xdW9E5hMbafM/qZi3Yn2Ac=
X-Google-Smtp-Source: APXvYqyiTp8T8Fk9PoH37we6nrN4VKEJPsicooYGky0U3e9JzlOyZ3enwTDka0g2x+oL8xh34VqkZw==
X-Received: by 2002:a0c:b5ad:: with SMTP id g45mr58742667qve.231.1560194061058;
        Mon, 10 Jun 2019 12:14:21 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id e63sm5226033qkd.57.2019.06.10.12.14.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 12:14:19 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 25CB741149; Mon, 10 Jun 2019 16:14:17 -0300 (-03)
Date:   Mon, 10 Jun 2019 16:14:17 -0300
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: Linux 4.19 and GCC 9
Message-ID: <20190610191417.GW21245@kernel.org>
References: <20190517073813.GB2589@hirez.programming.kicks-ass.net>
 <CANiq72nUPoNHWM-dJuFc3=4D2=8XMuvO0PgGPjviOv+EhrAWUw@mail.gmail.com>
 <20190517085126.GA3249@kroah.com>
 <CANiq72muyjE3XPjmtQgJpGaqWR=YBi6KVNT3qe-EMXP7x+q_rQ@mail.gmail.com>
 <20190517152200.GI8945@kernel.org>
 <CABWYdi2Xsp4AUhV1GwphTd4-nN2zCZMmg5y7WheNc67KrdVBfw@mail.gmail.com>
 <4FE2D490-F379-4CAE-9784-9BF81B7FE258@kernel.org>
 <CABWYdi2XXPYuavF0p=JOEY999M4z3_rk-8xsi3N=do=d7k09ig@mail.gmail.com>
 <20190610151407.GS21245@kernel.org>
 <20190610152542.GA4132@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610152542.GA4132@kroah.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 10, 2019 at 05:25:42PM +0200, Greg KH escreveu:
> On Mon, Jun 10, 2019 at 12:14:07PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Jun 10, 2019 at 12:21:51AM -0700, Ivan Babrou escreveu:
> > > Looks like 4.19.49 received some patches for GCC 9+, but unfortunately
> > > perf still doesn't want to compile:
> > > 
> > > [07:15:32]In file included from /usr/include/string.h:635,
> > > [07:15:32] from util/debug.h:7,
> > > [07:15:32] from builtin-help.c:15:
> > > [07:15:32]In function 'strncpy',
> > > [07:15:32] inlined from 'add_man_viewer' at builtin-help.c:192:2,
> > > [07:15:32] inlined from 'perf_help_config' at builtin-help.c:284:3:
> > > [07:15:32]/usr/include/x86_64-linux-gnu/bits/string3.h:126:10: error:
> > > '__builtin_strncpy' output truncated before terminating nul copying as
> > > many bytes from a string as its length [-Werror=stringop-truncation]
> > > [07:15:32] 126 | return __builtin___strncpy_chk (__dest, __src, __len,
> > > __bos (__dest));
> > > [07:15:32] | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > [07:15:32]builtin-help.c: In function 'perf_help_config':
> > > [07:15:32]builtin-help.c:187:15: note: length computed here
> > > [07:15:32] 187 | size_t len = strlen(name);
> > > [07:15:32] | ^~~~~~~~~~~~
> > > [07:15:32]cc1: all warnings being treated as errors
> > 
> > The patch below should've taken care of that, and it has a Fixes: tag,
> > i.e. the stable scripts should've noticed that, and it was noticed with
> > gcc 8.2.
> 
> No, stable scripts do not always pick up the "Fixes:" tag, they are only

Humm, I thought it picked those, or is it that AUTOSEL thing? Ok, I'll
add stable@ when I add Fixes: then.

> guaranteed to pick up the "cc: stable@" tag.  Sometimes we catch the
> fixes ones too, but not always by far.
> 
> Anyway, I'll queue this patch up after this next round of kernels are
> released, thanks!
> 
> greg k-h

-- 

- Arnaldo
