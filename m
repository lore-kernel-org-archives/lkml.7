Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA61C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACAF2175B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yfVQaPFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfCUQnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:43:06 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51957 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbfCUQnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:43:06 -0400
Received: by mail-it1-f193.google.com with SMTP id e24so5318514itl.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZGpuOYr+X9Wo0oZzVrzhGOYq5+l3CM2yF4AQGAFJlA4=;
        b=yfVQaPFDErnVM9vhnLJyx8CQxK+vxFi12IPDiEwbUkHLWW+FPB02hqraG7x7y9U9Ju
         DKpFmAFrJrCPMlj78Yp6Qh2r1piE2Ps2D5uHMKEzqwSKqpw6cPe2uT4nqoYCQRIbS61M
         EggqtpySDWUHnE9BGDYnnKmWcq60j+uUBdoGlqtorvzP4nKx+oW/BsNtTNsI0HbgnQss
         Z0j6l7Wt7rOdp7fzojZ2MteT/5Ct/jks24q2sa+pLW8od4p0FR2nuZB9KJ736VJ4ZO06
         B3b910TYzPnDGgeW42xIxv/GZGidj6MzKB0N6hjxkGxOOJA7AwlJkEreU1iKMQHfju8+
         wuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZGpuOYr+X9Wo0oZzVrzhGOYq5+l3CM2yF4AQGAFJlA4=;
        b=ZZuFzBY5u2aedoZe0V5Iwyfd32lC+heV3CYDOH9iDQuWCI0FB4Xuk6jt08lloDlgik
         /P+B7IC91NbgzqR8J1zjj8M7i0ZGMH41lzFlzLd/WAGqwtMkJLTNtUx6QyHNtTgEFVkt
         2p93rmeFcHK9QWmeToUAsFxy1V7Ogjxmqg41+VNmvclhVyWrsHMYybdhu823M3h/nj1/
         Cm8tR7boeDJm0eXMeXTBAHulzXH/uGX/u7oya/xy87LctqHCpfmDkMNAosMhHqjDx+eW
         oRCFblrlszHnJ302oN6/N06lIZQA7PvtA469sgRVHQ+rp+bKEydmXzWbf/8ungI2c+n5
         F6Gg==
X-Gm-Message-State: APjAAAX7sGOvC/tJBTGl+VoLPyez4/+DIN1JwkyJoaFJ7wBzEET7RFTc
        BOjDBqZxgUIeC0yb4hACn39j3oEkq9DrQsswcbrlZc78
X-Google-Smtp-Source: APXvYqwAqwdyMpUHYgAATzt7MNQA21jHIkWQazSy22dv4pxAxYGWoSYU7y8wwGcC5L5BN5JKlNV8Z9p1gAtpXX77OoU=
X-Received: by 2002:a24:5208:: with SMTP id d8mr331018itb.137.1553186584929;
 Thu, 21 Mar 2019 09:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190321023122.21332-1-yuehaibing@huawei.com> <20190321023122.21332-2-yuehaibing@huawei.com>
In-Reply-To: <20190321023122.21332-2-yuehaibing@huawei.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 21 Mar 2019 10:42:54 -0600
Message-ID: <CANLsYkwj5zujkFKNCFtFJQT4+E=7MxU=M10UWijoXYDGQCbdtA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf cs-etm: Remove errnoeous ERR_PTR() usage in cs_etm__process_auxtrace_info
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

On Wed, 20 Mar 2019 at 20:31, Yue Haibing <yuehaibing@huawei.com> wrote:
>
> From: YueHaibing <yuehaibing@huawei.com>
>
> intlist__findnew() doesn't uses ERR_PTR() as a return mechanism
> so its callers shouldn't try to extract the error using PTR_ERR(
> ret) from intlist__findnew(), make cs_etm__process_auxtrace_info
> return -ENOMEM instead.
>
> Fixes: cd8bfd8c973e ("perf tools: Add processing of coresight metadata")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  tools/perf/util/cs-etm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 1108049..fd7f1da 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1908,7 +1908,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>
>                 /* Something went wrong, no need to continue */
>                 if (!inode) {
> -                       err = PTR_ERR(inode);
> +                       err = -ENOMEM;
>                         goto err_free_metadata;
>                 }
>
> --
> 2.7.0

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Arnaldo, please consider adding to your tally.

>
>
