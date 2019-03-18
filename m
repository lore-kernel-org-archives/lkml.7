Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CD3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467C520989
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mDxXT3Ay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfCRROC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:14:02 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51586 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfCRROC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:14:02 -0400
Received: by mail-it1-f193.google.com with SMTP id e24so21654721itl.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vtbqI9Oi9C2e5wO78ukPgP6uXURdmxn9AwEn+5H8OhU=;
        b=mDxXT3AyP4cv0kiZgi1zY3n1NYVKhzOGzIY5OZ1JnTRunscN7unvpjWgq2sfsdyyyC
         6bSpbQs6+va0gOdyqZTdCfrxfw9zD70LkhV6p4By6jY12WBUydmfpTedFbv98LBeCZ1R
         mEMv5bAEHs3QyyfLISicK7eVevMECw6qRWivCBuEJ6p8Nbg8OKpRMx7iJ3VDPf9nK/6z
         KTBPEefpmedPGTHh6HjT/WZnWQ8ToKfGNrhp7LF5qsBX8u3oSidzw6/sEmWLmm/SFKeg
         SJO7zvTKJsXNbMgIuRFPyHY8nce2ZvYFAfE057faM/z8WUFKZV/ifCYbGSxNp9+LZ79b
         Hr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vtbqI9Oi9C2e5wO78ukPgP6uXURdmxn9AwEn+5H8OhU=;
        b=PP0nSgXMyBcI3dwxLOI32jY7kxnnXmne68igeFZWChKxzBVqWlcxDl6PLT/Rqa22zJ
         V380JfTVIIHJxVK4CilRnBDZoLuCpzb91yw4t8UcL6fnCd/RwtK02O9xGXHoArGoUSew
         eotQgi9Ee53MQlC5kJ651989ZUfaHNe5PdtHyqFBHNHztKnSWRIohfOxjuax6U+J2Var
         S76OwcMgJCYlaxAo2YfENunCTLCgBMeZiRRp0FACfmyPOcIOy5iLlePJJF679tb3eKrY
         acyHm1belxuGDzQKgWE4N41dnGkApNSWSpgy7+Yg5fuIdFcxPI0CO2r0EWN4rS+8rmap
         z6+A==
X-Gm-Message-State: APjAAAXxuRROS4ltijrT2IPM5htw6ahR2brHC1OFQnYJpRCEYyzpPiBr
        E1TwvVrKzwgefGVdHUIRlm0KOUTGbwzGJlgFyrqxZw==
X-Google-Smtp-Source: APXvYqz3eWJeMg/I+vdS3OjXkFjp6uXuTSzn8v0rTveBRoBx/De2h9cdPy4QOhdnv3x+Qv7Oev7EAuDj1lD5MeyRxxg=
X-Received: by 2002:a24:118e:: with SMTP id 136mr10107516itf.175.1552929241221;
 Mon, 18 Mar 2019 10:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190315022649.17848-1-yuehaibing@huawei.com>
In-Reply-To: <20190315022649.17848-1-yuehaibing@huawei.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 18 Mar 2019 11:13:50 -0600
Message-ID: <CANLsYkzQhV-0+LBDFT+2op0tLi_sZjoMoWYYr+DsJoeB9tXZBg@mail.gmail.com>
Subject: Re: [PATCH] perf tools: return errcode in cs_etm__process_auxtrace_info
To:     Yue Haibing <yuehaibing@huawei.com>
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

Good day Yue,

On Thu, 14 Mar 2019 at 20:28, Yue Haibing <yuehaibing@huawei.com> wrote:
>
> From: YueHaibing <yuehaibing@huawei.com>
>
> 'err' is set in err path, but it's not returned to callers.
> Also fix a pass zero to PTR_ERR issue.
>
> Fixes: cd8bfd8c973e ("perf tools: Add processing of coresight metadata")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  tools/perf/util/cs-etm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 1108049..111f33c 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1908,7 +1908,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>
>                 /* Something went wrong, no need to continue */
>                 if (!inode) {
> -                       err = PTR_ERR(inode);
> +                       err = -ENOMEM;

Good catch.

>                         goto err_free_metadata;
>                 }
>
> @@ -2023,5 +2023,5 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  err_free_hdr:
>         zfree(&hdr);
>
> -       return -EINVAL;
> +       return err;

If we do that we need to set 'err' to an error code here [1] and here
[2].  Do you think you could fix this and roll another version of your
patch?

[1]. https://elixir.bootlin.com/linux/v5.1-rc1/source/tools/perf/util/cs-etm.c#L1967
[2]. https://elixir.bootlin.com/linux/v5.1-rc1/source/tools/perf/util/cs-etm.c#L1981
>  }
> --
> 2.7.0
>
>
