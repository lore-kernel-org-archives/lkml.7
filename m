Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654E5C606C5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3E020644
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g4m7gvOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388923AbfGHRjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:39:00 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43169 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGHRjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:39:00 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so37095734ios.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zbi2cNv/TpuGlJ+YwPJTmlkeVMXSjEZ67mVfSwn9d+Y=;
        b=g4m7gvOwoL8Ba1jns6Vi7Q0m7sKlLgR0n7bYq20Z6JRByef52LeaAH9UNBZVxMyR2Y
         kSFxaR2KvLg7WW02N7GBW5BEgQMpFC/6tr94/kgULAkrwJDGfW5XMzq0pNpGNdX3mbHY
         jn3m7Vp1rWq9E/OmIRAm0gw9aNdNXR0H3WzctXiWac6JFF/2/D2UcDoaJ0BH+tSjoeBZ
         NlzonlxwJGzqmTc/QtIbrfDZpOzzfRItibON733/czW7HyXutsq79w32S2LzRDCr2boI
         Q8uyho1YPz5O5JkMA7+EMMlH7Ivkm+Poch85s58zIS41MTAaCL0zX4K8PmnKds9Wnjgz
         8Q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zbi2cNv/TpuGlJ+YwPJTmlkeVMXSjEZ67mVfSwn9d+Y=;
        b=CAIRwDCjRcWvbN8fQP2nRwxkSu5p+Z7T9KOYBXJslGa5yOBnu7gSsODDWaQi6uqfmW
         0JQ/rQfAuUTiHTh3zkposSyh6OGnHAYmSZ5iMBJfVpaCyqPJtfiwCnRyMFxGf3b33QaN
         K65i7FHUA7MsmA6bz4a3Wsu9JqyJ7YpbGiqIv6xMEZK3fGkHYkou1ApUuON7VCTwYdoe
         h5oCaecpIrT5XT94lJKS8IdX3IsP3RTXdcsEieJthSps3zw4O5vrDJD8exJ/SJBBcykd
         50Jd6yZsViqzxo/cXNRiZVvbbQ0gLOjdrf9GjfJBG6zVTIQvRkExxtVi6H2+X1Rh1hdg
         XlpA==
X-Gm-Message-State: APjAAAVg6qvmwiqUKhLVxbYJlBZYIhcg7FCVmPfNRPLk9iISSJR8CevW
        GRpqTNT+q6KVwY58IMCIHtbFWoKV3QWdoKmNEBVknw==
X-Google-Smtp-Source: APXvYqxPB5rd83qO7WjtBsChtu5/pgbFbGNDXikxw3NiTLQIaHzZaXtQcaTt7ebej7HCBTiHTBW7E6PNgxgW9KMJQZg=
X-Received: by 2002:a5d:9dc7:: with SMTP id 7mr20717541ioo.237.1562607539359;
 Mon, 08 Jul 2019 10:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190708143937.7722-1-leo.yan@linaro.org> <20190708143937.7722-5-leo.yan@linaro.org>
In-Reply-To: <20190708143937.7722-5-leo.yan@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 8 Jul 2019 11:38:48 -0600
Message-ID: <CANLsYkwHMfVf-FUQ+wBkDfq9GnCihimFAhd+ybCsxMAt8d3HcA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf cs-etm: Smatch: Fix potential NULL pointer dereference
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2019 at 08:40, Leo Yan <leo.yan@linaro.org> wrote:
>
> Based on the following report from Smatch, fix the potential
> NULL pointer dereference check.
>
>   tools/perf/util/cs-etm.c:2545
>   cs_etm__process_auxtrace_info() error: we previously assumed
>   'session->itrace_synth_opts' could be null (see line 2541)
>
> tools/perf/util/cs-etm.c
> 2541         if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
> 2542                 etm->synth_opts = *session->itrace_synth_opts;
> 2543         } else {
> 2544                 itrace_synth_opts__set_default(&etm->synth_opts,
> 2545                                 session->itrace_synth_opts->default_no_sample);
>                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^
> 2546                 etm->synth_opts.callchain = false;
> 2547         }
>
> 'session->itrace_synth_opts' is impossible to be a NULL pointer in
> cs_etm__process_auxtrace_info(), thus this patch removes the NULL
> test for 'session->itrace_synth_opts'.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index ad43a6e31827..ab578a06a790 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -2537,7 +2537,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>                 return 0;
>         }
>
> -       if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
> +       if (session->itrace_synth_opts->set) {
>                 etm->synth_opts = *session->itrace_synth_opts;
>         } else {
>                 itrace_synth_opts__set_default(&etm->synth_opts,

This is in accordance with what was previously discussed.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> --
> 2.17.1
>
