Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC25ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285A12168B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SloJf08G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfIKJIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:08:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37280 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfIKJIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:08:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id r195so2563248wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 02:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fVXJdEiyG3g7I0Ee9AcvktkAQsh4s+Etlf6fhn1BiQk=;
        b=SloJf08GFdByA5YtqiSMgVWUoDfKLosEALLv1z+JHxPfMHmzqQEPufdARHBVpooccQ
         PKa46XI6UoUWJ0FlKtMQMmqrGAi3Ahdh7o9BvXGcV3cAyUT6cjldNAt5XNWaSJ/V3zaN
         WsYE2nbdiPV18nUGV7BdAUREhqyvAbdiNJKGKcMr9vpGVX4RM89zF/7kSYnFpKil8o6g
         xUh73eh/yqXmbe7W/PCTK5wNZTTUMq5ygAIVemM23Odt5cTRXw2E2TKBq1V5dtQP462D
         9pWAQZQdm+7c2dOGYvb96qJpTkDthZTfJV5MnQ01O6TducJB4vSY63I9obEi7PMlvwxv
         ZQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVXJdEiyG3g7I0Ee9AcvktkAQsh4s+Etlf6fhn1BiQk=;
        b=sWiCLSziuxY0SNLUy3mY8lfD6vlTRoFLTU4XsSQBxRO0LUoSjsjQRYc1SOio/kxcz2
         4c0cO7K1JIakhSgaLtZUBOBvMDaw1p2K//Py+x5PjjInqJQh1TZswWGNc8QyjKjZMa8n
         JRm56VRCgNdSY+WFTSxl3VE5jNXFZpFgitCUnr9wKlX2kNVTtxOsAk+VJmCIhwEJQRY0
         UFCjImRPuBtE55fgtNzYJKcPhdNhL7l4aEzl9u1cqRQTBRModox7VF4ZpxGILkqXf9mr
         IuzVjupXHt1j5pWpbYrcMjlcvSc7ONEDCWymhXZsvbkFVe+OazajOvCuTcEf6puvJBLk
         Lgfw==
X-Gm-Message-State: APjAAAW1E5FiUjyogvZvi3ik1XCjpP5Y/N3z67jOAqN2b3bxub+XvcT4
        C8atIVjaM2YT4GLVpyNJODlniEFChLCLZ3OMokp7wQ==
X-Google-Smtp-Source: APXvYqxRP0NOtvDhWQscJB/M1Lhu0yxbUlcmMzQncopqZ5So0Oa9QNkSkEGdSsimlxZP8zxmTbUSKvG1ea/1pcfKyvA=
X-Received: by 2002:a1c:c90e:: with SMTP id f14mr2849955wmb.54.1568192924093;
 Wed, 11 Sep 2019 02:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190724224954.229540-1-nums@google.com> <20190724224954.229540-2-nums@google.com>
In-Reply-To: <20190724224954.229540-2-nums@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 11 Sep 2019 02:08:32 -0700
Message-ID: <CAP-5=fUf1BN634Ojkp-sPUV5iryzZ-qbv_UVS-GoNOgj-454dQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] Fix event.c misaligned address error
To:     Numfor Mbiziwo-Tiapo <nums@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>, mbd@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An idea here is that, if this breaks backward compatibility, we
introduce an aligned variant and work to deprecate the unaligned
variant. I will look into making a patch set.

Thanks,
Ian

On Wed, Jul 24, 2019 at 3:50 PM Numfor Mbiziwo-Tiapo <nums@google.com> wrote:
>
> The ubsan (undefined behavior sanitizer) build of perf throws an
> error when the synthesize "Synthesize cpu map" function from
> perf test is run.
>
> This can be reproduced by running (from the tip directory):
> make -C tools/perf USE_CLANG=1 EXTRA_CFLAGS="-fsanitize=undefined"
>
> (see cover letter for why perf may not build)
>
> then running: tools/perf/perf test 44 -v
>
> This bug occurs because the cpu_map_data__synthesize function in
> event.c calls synthesize_mask, casting the 'data' variable
> (of type cpu_map_data*) to a cpu_map_mask*. Since struct
> cpu_map_data is 2 byte aligned and struct cpu_map_mask is 8 byte
> aligned this causes memory alignment issues.
>
> This is fixed by adding 6 bytes of padding to the struct cpu_map_data,
> however, this will break compatibility between perf data files - a file
> written by an old perf wouldn't work with a perf with this patch due
> to event data alignment changing.
>
> Comments?
>
> Not-Quite-Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> ---
>  tools/perf/util/event.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index eb95f3384958..82eaf06c2604 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -433,6 +433,7 @@ struct cpu_map_mask {
>
>  struct cpu_map_data {
>         u16     type;
> +       u8 pad[6];
>         char    data[];
>  };
>
> --
> 2.22.0.657.g960e92d24f-goog
>
