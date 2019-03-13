Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41381C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DF02171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552486090;
	bh=imk3xSw8yfYpSKH2t9ZsLeN0n2ESyIOvOVc5Pvc+UMg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uMD/isV+p8ljeSoB8WtWC+HKMBT6ML/GcWxVYpuPJY3rnrqTYJxK3lVg5GbS+u9xS
	 dv+4Hbnv/+u4adApzd76wAKjuPEBdW1JIDTkMvIkFymy4UTt3rFWuEeog0sKF9OX4D
	 9yGV7HiW933YLs4BaHZew2KLEwbscBIMSSedV6+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfCMOII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:08:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39027 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfCMOII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:08:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id t124so2006807wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 07:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lf4iw+fHxQN4uW3tskF8bX9OWRoysdr2ffr4rWZepwA=;
        b=YTy2eYVdhCORXsgsa861DLtvwOW9C0P6VVbcJcdfUx9SZlvc47thjSFf28GzwhOuJy
         WDZ3Wag70nQ8auXQaACksA3HyNl9oadiSz5Nnnn1lIlT9yrO2YPUMZR+LxcUy4yzmUUl
         EjEonsXdgymY4B5TpQ3KsCpz8s8fB6i9Jx/PW4itPhc5Vtpeei1MlKR3nBpbK0+dF8Cg
         +hQqr9H1kyZ3wI0etFivFudLIyHaYXSQSkqCExiJijcPte5zdPljNxq6fCAh5LXnrWw6
         lLSiCVWnJpmQ7GaTfmUeb6RSi16Gkv/W5sR6LOGXqpGziGnWaqaSBST+kV7yPuKxOV6A
         c4dQ==
X-Gm-Message-State: APjAAAVNT2FSkxlu0n/Ajl7EZnUgb3aoExYLUl6TEGLDCSelOiLgE2f+
        /naYi1bdxIkN9w95jU6jMEPhP7eOmdlkBFiN0gI=
X-Google-Smtp-Source: APXvYqythr3Jl8gIEyVzmTOV3EJYTwq8yd9RT5Kj/hdPBX0m/Ncpngwy3Pl2juF+7qUIJ3NSVu7HzgxKAkpDLQP0r4s=
X-Received: by 2002:a1c:9e97:: with SMTP id h145mr2384512wme.147.1552486085784;
 Wed, 13 Mar 2019 07:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190310153026.8661-1-jolsa@kernel.org> <20190310153026.8661-4-jolsa@kernel.org>
In-Reply-To: <20190310153026.8661-4-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 13 Mar 2019 23:07:54 +0900
Message-ID: <CAM9d7cjuWS8mTzBrMrN09CYCXUVLB6vfw1DD=BdZAL0kvgyfxg@mail.gmail.com>
Subject: Re: [PATCH 3/5] perf record: Add --dir option to store data in directory
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jirka,

On Mon, Mar 11, 2019 at 12:30 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding --dir option to store data in directory. It's next
> step for multiple threads in record. It's now possible to
> make directory data via --dir option, like:
>
>   $ perf record --dir perf bench sched messaging
>   $ ls -l perf.data
>   total 344
>   -rw-------. 1 jolsa jolsa 43864 Jan 20 22:26 data.0
>   -rw-------. 1 jolsa jolsa 30464 Jan 20 22:26 data.1
>   -rw-------. 1 jolsa jolsa 53816 Jan 20 22:26 data.2
>   -rw-------. 1 jolsa jolsa 30368 Jan 20 22:26 data.3
>   -rw-------. 1 jolsa jolsa 40088 Jan 20 22:26 data.4
>   -rw-------. 1 jolsa jolsa 42592 Jan 20 22:26 data.5
>   -rw-------. 1 jolsa jolsa 56136 Jan 20 22:26 data.6
>   -rw-------. 1 jolsa jolsa 25992 Jan 20 22:26 data.7
>   -rw-------. 1 jolsa jolsa  8832 Jan 20 22:26 header
>
> There's a data file created for every cpu and it's storing
> data for those cpu maps.
>
> It's possible to transform directory data into standard
> perf.data file via following inject command:
>
>   $ perf inject -o perf.data.file -i perf.data
>
> The --dir option enabled DIR_FORMAT feature to be stored
> in header file to indicate the directory layout.
>
> Don't allow to use --dir with --aio yet. It needs
> to be investigated first.
>
> Link: http://lkml.kernel.org/n/tip-0kjm8wpglzu2tm18tpagfm4d@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

[SNIP]
> @@ -1983,6 +2040,8 @@ static struct option __record_options[] = {
>         OPT_CALLBACK(0, "affinity", &record.opts, "node|cpu",
>                      "Set affinity mask of trace reading thread to NUMA node cpu mask or cpu of processed mmap buffer",
>                      record__parse_affinity),
> +       OPT_BOOLEAN(0, "dir", &record.data.is_dir,
> +                   "Store data into directory perf.data"),
>         OPT_END()
>  };
>
> @@ -2134,6 +2193,17 @@ int cmd_record(int argc, const char **argv)
>                 goto out;
>         }
>
> +       if (perf_data__is_dir(&rec->data)) {
> +               if (!rec->opts.sample_time) {
> +                       pr_err("Sample timestamp is required for indexing\n");

s/indexing/directory output/ ?

Thanks
Namhyung


> +                       goto out;
> +               }
> +               if (record__aio_enabled(rec)) {
> +                       pr_err("Cannot use both --dir and --aio yet.\n");
> +                       goto out;
> +               }
> +       }
> +
>         if (rec->opts.target.tid && !rec->opts.no_inherit_set)
>                 rec->opts.no_inherit = true;
