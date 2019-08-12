Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFF4C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA4D206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L7tL6lnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfHLVm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:42:29 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39417 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfHLVm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:42:29 -0400
Received: by mail-ot1-f68.google.com with SMTP id r21so158790831otq.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 14:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gx6QSLesJel3EOn97a01WuWFWtw8sELpqZv3XHH4TkE=;
        b=L7tL6lnUwjerVWRjOf2iuk1/0vpIdnnLXUclicu9EOj4VQmxfw+195eNnnVP9D5A//
         s33XOs62eRI5nqcXjWFQ7zf64nTA66h/zrxAzyAdDspuxAMzibZe3qyVg5FhfifXwsCp
         d1faRADV2Hh1kbo/gA767R85R5ZSllgoT3i2cYwdPJDzTVQDFbgRsw4JWq6Cmuh5ecrL
         TPgnjcLkuOCnVuSfTw3+YqYAW+2pvCdj7LD9jEOqRpWrXF25XodfN1JsNeAby0bYpmJs
         yDqh2NyYAyvbvVOf3fQb9UZ6ZvC4ByheZUJwcFgaRyXh2XJcrBM7uJkg462XjZgeih92
         /Zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gx6QSLesJel3EOn97a01WuWFWtw8sELpqZv3XHH4TkE=;
        b=lUSdSBCXw59nVTKuTId+6uCyRlhEcNQlyvcH29EktU/ede5MVsGvuIowIUCHwlns24
         5gfsR955tgHL9HbnvuNIYtznFJTdTm2aCXDFvBJbLaWJHYErYUgXIzdNr7wAQhVsmsJx
         /Q3gY5jFNe559jvxCC7iRaRg6jc0+KXm5K2jVzlR0NTRWWV8OUJkSwuSy/UoOLK8HDnG
         tDvTRcpPri+5ubuH34PUwfnNi+vpqIan6wV6XFX8XVvcLy2Cvbt0y0MxFQ9Gp/yTu1qj
         UFsBzWO2k/q2+OzBztF0AiQiOnl5LJj5o15X4JHBeW4dl7vyqKeWeL/fLO+Zrby/b3Qj
         nYjQ==
X-Gm-Message-State: APjAAAWbElFN3tr6xzZ/rwhvJ2W9+PR68C7NgxHoJMuqbJ2tAl5oz86r
        +h8rDutjdtib1vRD4i1e3+ZzHNFz47YFemEKMldYCQ==
X-Google-Smtp-Source: APXvYqwt49xvwotsJKc/cNOaXDlphf+EqnjZvINoE5+CnGxbY/po6fhZWP8cqKRsjzvFc2n4GYl/GZplqFVFtSSXUEY=
X-Received: by 2002:a5d:9613:: with SMTP id w19mr6341798iol.140.1565646148509;
 Mon, 12 Aug 2019 14:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1565188228.git.ilubashe@akamai.com> <bd8763b72ed4d58d0b42d44fbc7eb474d32e53a3.1565188228.git.ilubashe@akamai.com>
 <20190812202251.GG9280@kernel.org> <20190812202706.GH9280@kernel.org> <20190812202947.GI9280@kernel.org>
In-Reply-To: <20190812202947.GI9280@kernel.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 12 Aug 2019 15:42:17 -0600
Message-ID: <CANLsYkwjdhzVMwrWboTTOw+P3NajtoswxfxhodK0DdeexFCR3w@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] perf: Use CAP_SYS_ADMIN instead of euid==0 with ftrace
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Igor Lubashev <ilubashe@akamai.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019 at 14:29, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Mon, Aug 12, 2019 at 05:27:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Aug 12, 2019 at 05:22:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Wed, Aug 07, 2019 at 10:44:17AM -0400, Igor Lubashev escreveu:
> > > > @@ -281,7 +283,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> > > >           .events = POLLIN,
> > > >   };
> > > >
> > > > - if (geteuid() != 0) {
> > > > + if (!perf_cap__capable(CAP_SYS_ADMIN)) {
> > > >           pr_err("ftrace only works for root!\n");
> > >
> > > I guess we should update the error message too?
> > >
> >
> > I.e. I applied this as a follow up patch:
> >
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 01a5bb58eb04..ba8b65c2f9dc 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -284,7 +284,12 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >       };
> >
> >       if (!perf_cap__capable(CAP_SYS_ADMIN)) {
> > -             pr_err("ftrace only works for root!\n");
> > +             pr_err("ftrace only works for %s!\n",
> > +#ifdef HAVE_LIBCAP_SUPPORT
> > +             "users with the SYS_ADMIN capability"
> > +#else
> > +             "root"
> > +#endif
>
>                 );
>
> :-)
>
> >               return -1;
> >       }
> >
>
> I've pushed the whole set to my tmp.perf/cap branch, please chec

Please hold on before moving further - I'm getting a segmentation
fault on ARM64 that I'm still trying to figure out.

>
> - Arnaldo
