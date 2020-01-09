Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91144C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A34C2077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578556535;
	bh=IjCmLbvqdo3xSXqaqUZPVySbsYQO3pxXHuqF5EytvJk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JqQf55DC1bsrq67QmzUP7/MJ5CvO75zoX9Me5Wh72+I7eL5yNeDEGvoJBIBKy+gLB
	 9YgkGTqJQ/lKFqmdlBUXmEkcQXmfZEFhlWyqZKrWeLUJ6CZnpnR6shvUohznvJdJxN
	 fcwLgDs1zoATHSSgD4juDKj8HNT3rb9Rcy3C9uzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgAIHze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 02:55:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46714 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgAIHze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 02:55:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so6190606wrl.13;
        Wed, 08 Jan 2020 23:55:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RHXfR00D9x10M+a38QH4C3WYscmRe8nqh31YYkY4Uuk=;
        b=SLOBR5fiGyw/pjLNSzbKAECZBNUnrlm0s69LFY8PyYRqcVOb86Ku0r0ccPUoUxHkVK
         SdUvS3amS7dCj0eaxbGS6bBTucCuIG9CnkyBUq20lY/vKEfeab59EJP6oJgYjkYNJyUx
         uK/Ey1xHvVzvhCH5/i54iNaWGauQq/+sYr7cCs/YX4jygPBzRk7WeDRsP2FqBqV4EY1W
         52W7hKjz2VxpvI1PcC8dSWnfrF7lwPv8ulf9hoLcx/hUUYc23SbCvYyiQ23hqFx8aCc0
         +xO/ObfsDalvLbT2pkJqyja9Iq6SyxnIllj4n58D1YZFX7pBmz2DaikkSXGjtgec4EZ0
         e1zg==
X-Gm-Message-State: APjAAAU23PK87YkIQg6H9nxWH3jMEmNKPI2Nf8xEQgcAb7eiB+oYosJI
        uvXOn6dGkSGRbcAY2Bxh3wEBGkuQ22w+LDPEtaI=
X-Google-Smtp-Source: APXvYqyzTcLoiHvDSM0IvKq6j8EEneu+thKS5ynO1fGnk8bQ0+pGHoJZ1L5atbVXLs7LHEZA1pJCJSb4XoZjsEjN1LA=
X-Received: by 2002:adf:e2cf:: with SMTP id d15mr9232900wrj.225.1578556532209;
 Wed, 08 Jan 2020 23:55:32 -0800 (PST)
MIME-Version: 1.0
References: <20200107133501.327117-1-namhyung@kernel.org> <20200107133501.327117-9-namhyung@kernel.org>
 <20200108222458.GF12995@krava>
In-Reply-To: <20200108222458.GF12995@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 9 Jan 2020 16:55:21 +0900
Message-ID: <CAM9d7ch7t9GDu=emb9MYdTSB8hPb0adAy1iOdjyXSXVXTpGBFg@mail.gmail.com>
Subject: Re: [PATCH 8/9] perf top: Add --all-cgroups option
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 7:25 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jan 07, 2020 at 10:35:00PM +0900, Namhyung Kim wrote:
> > The --all-cgroups option is to enable cgroup profiling support.  It
> > tells kernel to record CGROUP events in the ring buffer so that perf
> > report can identify task/cgroup association later.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/Documentation/perf-top.txt | 4 ++++
> >  tools/perf/builtin-top.c              | 9 +++++++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
> > index 5596129a71cf..c75507f50071 100644
> > --- a/tools/perf/Documentation/perf-top.txt
> > +++ b/tools/perf/Documentation/perf-top.txt
> > @@ -266,6 +266,10 @@ Default is to monitor all CPUS.
> >       Record events of type PERF_RECORD_NAMESPACES and display it with the
> >       'cgroup_id' sort key.
> >
> > +--cgroup::
> > +     Record events of type PERF_RECORD_CGROUP and display it with the
> > +     'cgroup' sort key.
>
> should be '--all-cgroups' ?

Oops, you're right.

>
> anyway, we dont have '--cgroups', why not use just this?

I chose it for consistency since perf record has '--cgroup' option.

Thanks
Namhyung
