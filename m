Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262BCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA896218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FzQPq3kY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbfCUQoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:44:19 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53162 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbfCUQoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:44:19 -0400
Received: by mail-it1-f195.google.com with SMTP id g17so5305262ita.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9lH5D7aKN2LtSqPJKNXSlVsrAN0oXPZA5VkWCRZhkq8=;
        b=FzQPq3kY5oh6oDWUmeefAbpdC1W3cRRXUu5KPfdVQ4LovZeGXHqRp9kQhVuuFhrJqD
         w0ZhbS2p62UFVh9KaCeAQ8L1lg9qGXyhH1Xrfzg9K4rLmcJfOv12UDZyoM5KkkkFbAIB
         heKItZa/Qq5aEZiK2n4WEr3aVTrQrOVBiThxcG7dSdrded67mWrFXBZEXia+RNOaj1dm
         hkColXXv+HphIamf6mWlLWk4Etman5GwDMViW4PDYia4NFcqt9r8Zx05kEzwkMwjo7U7
         s1WFRMUwpwjwQO02YU/dPD1vsvmVoX2DEkcTYk1DsxYXeQuu7rcRtuk97/cKCrfh6wN/
         YWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9lH5D7aKN2LtSqPJKNXSlVsrAN0oXPZA5VkWCRZhkq8=;
        b=l9WIqYMq2EhUlumD0uWvoAZ9rLTI1VgS26FIPPmnhNpeOz5/Xbhkmzlpl7/zMvbcvg
         Cv7J4IYIrCsnSeTJHBAKn2i+mxSj2r/329FDqmxQCZlgxLZwQg0HOXlYBY/qc/A12Wsz
         kPz68mSY7FopkhZFbctgvxPTHm1w5IdnUn8W3/Z+gizugKo9WYiHTW48vwx7+TzI3rrp
         +/vJTtDsoomrTtk/hEX2//wlN8lOIUvD/C0/6+57ngEMPUKmmePkMNxCX77tUUIZWhby
         bKTdMUK21qPegZetRQLTG18BDOeJ4hChbRek7KFcvcOqfkzYExovF6vDWb22ikcyEIXl
         x/PA==
X-Gm-Message-State: APjAAAVPY9T7RdVdBiM4vcIFqSKRgchXRmYA7u/RT2sl0uZHi8mGJS25
        aAilPzxT3luDWDyAqHhUq3BdzK/dOrpkZI0757oRDQ==
X-Google-Smtp-Source: APXvYqwqPBWlctE1wCiV2uyEPYj0bd8DGdcjeXAm6zNclfgviX3PVWFcqwN4zft4Jo98pmwO6fKMARkwqVhOUorRHjM=
X-Received: by 2002:a02:bb06:: with SMTP id y6mr3537881jan.98.1553186658067;
 Thu, 21 Mar 2019 09:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190321023122.21332-1-yuehaibing@huawei.com> <20190321023122.21332-3-yuehaibing@huawei.com>
In-Reply-To: <20190321023122.21332-3-yuehaibing@huawei.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 21 Mar 2019 10:44:07 -0600
Message-ID: <CANLsYkw8FdtpqAK_o_3-ysCH9jnachKE0twuust1CznxcmoPKA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf cs-etm: return errcode in cs_etm__process_auxtrace_info()
To:     Yue Haibing <yuehaibing@huawei.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 at 20:32, Yue Haibing <yuehaibing@huawei.com> wrote:
>
> From: YueHaibing <yuehaibing@huawei.com>
>
> 'err' is set in err path, but it's not returned to callers.
> Don't always return -EINVAL, return err.
>
> Fixes: cd8bfd8c973e ("perf tools: Add processing of coresight metadata")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  tools/perf/util/cs-etm.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index fd7f1da..2cc773a 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1965,8 +1965,10 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>         session->auxtrace = &etm->auxtrace;
>
>         etm->unknown_thread = thread__new(999999999, 999999999);
> -       if (!etm->unknown_thread)
> +       if (!etm->unknown_thread) {
> +               err = -ENOMEM;
>                 goto err_free_queues;
> +       }
>
>         /*
>          * Initialize list node so that at thread__zput() we can avoid
> @@ -1978,8 +1980,10 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>         if (err)
>                 goto err_delete_thread;
>
> -       if (thread__init_map_groups(etm->unknown_thread, etm->machine))
> +       if (thread__init_map_groups(etm->unknown_thread, etm->machine)) {
> +               err = -ENOMEM;
>                 goto err_delete_thread;
> +       }
>
>         if (dump_trace) {
>                 cs_etm__print_auxtrace_info(auxtrace_info->priv, num_cpu);
> @@ -2023,5 +2027,5 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  err_free_hdr:
>         zfree(&hdr);
>
> -       return -EINVAL;
> +       return err;
>  }
> --
> 2.7.0

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Same here Arnaldo, please consider.

>
>
