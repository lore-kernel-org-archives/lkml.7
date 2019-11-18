Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D7AC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC83222EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAGhZIxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKRWLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 17:11:09 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42817 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRWLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 17:11:09 -0500
Received: by mail-qt1-f194.google.com with SMTP id t20so22114269qtn.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 14:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Za0RwvpiIvIixtB76KeG/0IaSTHPzUE2wScOJpLd3FE=;
        b=jAGhZIxbMoCUeIXZSxOL9jcbhRlIStlyA6HUrUjG7RB9kF0BL0Xcb4zA0Eb7yII1Vn
         QOA4JaOlI80+0dYOMM0USIqE9v8WLN3aGeuMsFZZwQRzyiOtzeUx+9zQmHJqTPdvP7z5
         VT2ycasYUiHiNC8wAmR8weQ8xQgm8dDTKjgIUAkOqaELMHWmBmHMn5r6+sKexmSlNTyK
         5oxi8VIpOEs3QavHODgZBpZoD097Q9r+3juy/AAbGAaDtLoJfYP8ffqMFIlRDPnvKrQ0
         5VYfP3p6Q2aKiTUvcucsxeyjqKahgvuvkI6R2OzPNAxVHjocSonRekeIt5yjqaRze4AU
         VzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Za0RwvpiIvIixtB76KeG/0IaSTHPzUE2wScOJpLd3FE=;
        b=focM0kLxIU6aK1DnpB2RjwH0UeoBuf9qK3Ly5wPAn8VIHFwpYjcRd5Z6EVOH2LAmns
         dmfw3+2f7gZpvUjdVkIu7Js6PbaWfsi/8wiyzxLOT60WOmLY15f+5ncyyQbO/WnH9MCZ
         /7Yo16IMpTtq8Os+xrFFSsqDaekb9l4YTiIL4Y+1owyh6SEmjjGMfbpCgX5Z7xPjnSUK
         FehIMS3BgtKmITKW+r07aOouGdQhkOw6EyUPqiTqFV9Xwjja5gjCxmqEVytTkNAZnr5e
         iEHBOWI+1Mtf4q53bAifR7zSwobg7VKDRnJ4EZjn5T38w1DNg7YKSaLzW4uFjtBkf939
         WM3Q==
X-Gm-Message-State: APjAAAUl7Dfcest2E1R98P4nsTzQmR/gpTe59lkAg4uSH81StQ8/r9a6
        awGpCOCLiPH2ZKZUm0fwfAE=
X-Google-Smtp-Source: APXvYqyCFiZhoZ96NtuwegCa67RfQAQCotAEt1wcmioNo5AlJ3EaEgkNbyn89/sA8MSMb3SbnsYwIQ==
X-Received: by 2002:ac8:16a3:: with SMTP id r32mr29468832qtj.12.1574115067772;
        Mon, 18 Nov 2019 14:11:07 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id x21sm3731830qkf.56.2019.11.18.14.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 14:11:07 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D8CA840D3E; Mon, 18 Nov 2019 19:11:04 -0300 (-03)
Date:   Mon, 18 Nov 2019 19:11:04 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3 0/7] perf/probe: Support multiprobe and immediates
 with fixes
Message-ID: <20191118221104.GF20465@kernel.org>
References: <157406469983.24476.13195800716161845227.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157406469983.24476.13195800716161845227.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 18, 2019 at 05:11:40PM +0900, Masami Hiramatsu escreveu:
> Hi Arnaldo,
> 
> This is the 3rd version of the multiprobe support on perf probe
> including some fixes about "representive lines"
> 
> The previous thread is here:
> 
> https://lkml.kernel.org/r/157314406866.4063.16995747442215702109.stgit@devnote2
> 
> On the previous thread, we discussed some issues about incorrect line
> information shown by perf probe. I finally fixed those by introducing
> an idea of "representive line" -- a line which has a unique address
> (no other lines shares the same address) or a line which has the least
> line number among lines sharing same address. Now perf probe only shows
> such representive lines can be probed([1/7][3/7]), and if user tries to
> probe other non representive lines, it shows which line user should
> probe ([2/7]). The rest of patches in the series are same as v2 (except
> for [4/7], example output is updated)
> 
> This can be applied on top of perf/core.

Thanks, applied everything, only the two last patches I didn't test, the
kernel in this machine doesn't have the features it needs, we can fix
things if some problem lurks there.

- Arnaldo
 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (7):
>       perf probe: Show correct statement line number by perf probe -l
>       perf probe: Verify given line is a representive line
>       perf probe: Do not show non representive lines by perf-probe -L
>       perf probe: Generate event name with line number
>       perf probe: Support multiprobe event
>       perf probe: Support DW_AT_const_value constant value
>       perf probe: Trace a magic number if variable is not found
> 
> 
>  tools/perf/util/dwarf-aux.c    |   62 ++++++++++++++++++++-
>  tools/perf/util/probe-event.c  |   19 ++++++-
>  tools/perf/util/probe-event.h  |    3 +
>  tools/perf/util/probe-file.c   |   14 +++++
>  tools/perf/util/probe-file.h   |    2 +
>  tools/perf/util/probe-finder.c |  116 +++++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/probe-finder.h |    1 
>  7 files changed, 206 insertions(+), 11 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

-- 

- Arnaldo
