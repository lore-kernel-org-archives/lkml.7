Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB9BC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFCD24680
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576842627;
	bh=l79UIGYbHOBYEn3HqZvYxJ6FEzXMrthpQ2Vv5pmhKcs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FnUMKqBNrWRo06Xe26p8YP0lF3J+KEWurRg0WiX36VNnT1A70ZOMykqUFFYsw3B4n
	 FuQLNSpyI/nZ5vk+d4nhN+4TTcxFq4qMfTSlj/XcmrNuwiER88H/qYkpvWuO8bytG9
	 Py2A1tgYYFc1ukrAs4Y9i0u6nQ+nD8dZO9LIyDa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfLTLu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 06:50:26 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50734 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfLTLu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 06:50:26 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so8644653wmb.0;
        Fri, 20 Dec 2019 03:50:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=92LR36gpXm7ShzZDTdNYLttXLvXwqcN2ee2IcjUQJyM=;
        b=IZT26ZKzg2Hr/KkZq+JBi3j/FhPzJmuT3AT0OVXNXqb/9kJ+/wpwGjXMBO6agqFIeq
         U9l6xf/tZg4r+rIDGij16sMWamhM2iXd80L3CDn4pm63R0WrGwAj7J0uulUSM7q46UX+
         LKWN3ZzHZSRRLPNU+ulw5TozWEEak3WrYFNx0dG2b/6VQo52D9bi+Hnixbk07Q488EMK
         FQHdkMiMwOLib5IDMhBcBI6r+htGC8ZpOHqTTa3GrvbQ04Gyus185F2CBRpIMOvOlxLr
         G5GZMEnFBsMfeQ57Zi2HPHfLws4YD139ZgUSE3NouSJyBJIwr3i3Dk8aBQa28LUOWXdF
         n0XA==
X-Gm-Message-State: APjAAAUolbl8LL4yiyhalZ/8GN5QPTBX0B0wQS5FaOjchFsCSwVraz6U
        qTMKnyxelsnce+45dEzTPSi9YbZh6PGzu0/AWiA=
X-Google-Smtp-Source: APXvYqwXu1RfMIH+/STpMCSROBDwUgoaYLin0OfVf0BNvlcLdLyv3fHSJKrnIC8EAi6bGEyaoNW4gsJn9qZelX+b0xg=
X-Received: by 2002:a1c:7205:: with SMTP id n5mr16460206wmc.9.1576842624244;
 Fri, 20 Dec 2019 03:50:24 -0800 (PST)
MIME-Version: 1.0
References: <20191220043253.3278951-1-namhyung@kernel.org> <20191220043253.3278951-2-namhyung@kernel.org>
 <20191220093335.GC2844@hirez.programming.kicks-ass.net>
In-Reply-To: <20191220093335.GC2844@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 20 Dec 2019 20:50:12 +0900
Message-ID: <CAM9d7cgdHSTf9fLJeHVoinLdkii+-hXXmy7+kbzaj1zVFa53Uw@mail.gmail.com>
Subject: Re: [PATCH 1/9] perf/core: Add PERF_RECORD_CGROUP event
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 6:33 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > index 377d794d3105..7bae2d3380a6 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -377,7 +377,8 @@ struct perf_event_attr {
> >                               ksymbol        :  1, /* include ksymbol events */
> >                               bpf_event      :  1, /* include bpf events */
> >                               aux_output     :  1, /* generate AUX records instead of events */
> > -                             __reserved_1   : 32;
> > +                             cgroup         :  1, /* include cgroup events */
> > +                             __reserved_1   : 31;
> >
> >       union {
> >               __u32           wakeup_events;    /* wakeup every n events */
> > @@ -1006,6 +1007,17 @@ enum perf_event_type {
> >        */
> >       PERF_RECORD_BPF_EVENT                   = 18,
> >
> > +     /*
> > +      * struct {
> > +      *      struct perf_event_header        header;
> > +      *      u64                             id;
> > +      *      u64                             path_len;
>
> You can leave out path_len (also u64 for a length field is silly).

Right, will remove.

Thanks
Namhyung


>
> > +      *      char                            path[];
> > +      *      struct sample_id                sample_id;
> > +      * };
> > +      */
> > +     PERF_RECORD_CGROUP                      = 19,
