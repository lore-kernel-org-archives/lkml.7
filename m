Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF90FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 03:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8435C22CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 03:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Ybp1a8Vu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfH2Db7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 23:31:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44175 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfH2Db7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 23:31:59 -0400
Received: by mail-io1-f66.google.com with SMTP id j4so3915823iog.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 20:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B23iPa66D7URMvvUFe3gpmMeFfyLo1kqn9vSUt4f+f8=;
        b=Ybp1a8VunoVjZCvuid2Eup5bQav1rc25fFWRK06QHz3i33O2S2fVy8uMX6FMwBPJkb
         yER0061k6laFWEIe1qX5nZCl78zI/ljtjFEjmJ3i5j8cst3pbsxMYimc1VwpcmkhDOrm
         bX+afp1jR7gO6ZDEsDBafi6ycuZfQyBxQR/MOOQv/mtIRiUH6YNzEiCqC0j2LG8zOOKN
         CklERWIMTG0pYraGDlZ/2jS9Jqda+G51I/Bv3ftHgrr8ztEJUEENSjc4pWZiQSKcwVf/
         1qTi/7SryB1UVcuQHLi5j8deEHiDKDV03cAZro4zVyEWkV77Lnvj0rPu5PJnDObWw9Ng
         6nmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B23iPa66D7URMvvUFe3gpmMeFfyLo1kqn9vSUt4f+f8=;
        b=SNJ++ZzfN/ZO2DJqpJbbOSUFNX3MlxtxUzIxW1A1LntiiQ8f2p4Dai2EwN5e+cJb/T
         KIntKYoI/NPqPNROYsTork+95JhGZsadACcRxz/B2fbHN9Fhe+QnctoHWNO2mnvHEqG2
         7iwuj20cbzRm+ERQ8chlfpfXJoka/RBgUriCv9hP6NThTx/KK38at/g4JvBs0E5qd+Og
         7LpKekGYcdeapGwE5z+LJj3Ep1v8U03AcmgedwYed9DTHYPZvqnlEjICyL7Yt4S0H0i/
         zUVH2QLlD6Rxyb7LQwKD/9bjIhwBY2X051Bme/gxGnZg03B+odTGTX6/0wN0r0aAGiFp
         iO0A==
X-Gm-Message-State: APjAAAXjknnZrFNqeSr88ha99fLzYjvztrnoEj1HtTRMNsz2t1Qw8nsn
        EmvRZoBuZbUvVT2/pc+xHNxYA4AWQXjnEE+vmSFABg==
X-Google-Smtp-Source: APXvYqwD3PhqzXGXFUlsVIX+XC4mOAcPePjIWM4fSB6vsF34yxpU5nB277d0sXQfPTy9gmoBZOFnw6fSlsuWtEw/kmQ=
X-Received: by 2002:a6b:f803:: with SMTP id o3mr8481612ioh.187.1567049518377;
 Wed, 28 Aug 2019 20:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190826193638.6638-1-echron@arista.com> <1566909632.5576.14.camel@lca.pw>
 <CAM3twVQEMGWMQEC0dduri0JWt3gH6F2YsSqOmk55VQz+CZDVKg@mail.gmail.com>
 <79FC3DA1-47F0-4FFC-A92B-9A7EBCE3F15F@lca.pw> <CAM3twVSdxJaEpmWXu2m_F1MxFMB58C6=LWWCDYNn5yT3Ns+0sQ@mail.gmail.com>
 <2A1D8FFC-9E9E-4D86-9A0E-28F8263CC508@lca.pw> <CAM3twVR5TVuuZSLM2qRJYnkCEKVZmA3XDNREaB+wdKH2Ne9vVA@mail.gmail.com>
 <20190828070845.GC7386@dhcp22.suse.cz> <2e816b05-7b5b-4bc0-8d38-8415daea920d@i-love.sakura.ne.jp>
 <CAM3twVRbhGL8pj0oa9NOu4pO2FWx3tTu928pW0g5CiE-K-meYw@mail.gmail.com>
In-Reply-To: <CAM3twVRbhGL8pj0oa9NOu4pO2FWx3tTu928pW0g5CiE-K-meYw@mail.gmail.com>
From:   Edward Chron <echron@arista.com>
Date:   Wed, 28 Aug 2019 20:31:46 -0700
Message-ID: <CAM3twVTueyGFv9YAH29xj1NAXfQUK56NBr9iucbkWUQ-bB7z6g@mail.gmail.com>
Subject: Re: [PATCH 00/10] OOM Debug print selection and additional information
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 1:04 PM Edward Chron <echron@arista.com> wrote:
>
> On Wed, Aug 28, 2019 at 3:12 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > On 2019/08/28 16:08, Michal Hocko wrote:
> > > On Tue 27-08-19 19:47:22, Edward Chron wrote:
> > >> For production systems installing and updating EBPF scripts may someday
> > >> be very common, but I wonder how data center managers feel about it now?
> > >> Developers are very excited about it and it is a very powerful tool but can I
> > >> get permission to add or replace an existing EBPF on production systems?
> > >
> > > I am not sure I understand. There must be somebody trusted to take care
> > > of systems, right?
> > >
> >
> > Speak of my cases, those who take care of their systems are not developers.
> > And they afraid changing code that runs in kernel mode. They unlikely give
> > permission to install SystemTap/eBPF scripts. As a result, in many cases,
> > the root cause cannot be identified.
>
> +1. Exactly. The only thing we could think of Tetsuo is if Linux OOM Reporting
> uses a an eBPF script then systems have to load them to get any kind of
> meaningful report. Frankly, if using eBPF is the route to go than essentially
> the whole OOM reporting should go there. We can adjust as we need and
> have precedent for wanting to load the script. That's the best we could come
> up with.
>
> >
> > Moreover, we are talking about OOM situations, where we can't expect userspace
> > processes to work properly. We need to dump information we want, without
> > counting on userspace processes, before sending SIGKILL.
>
> +1. We've tried and as you point out and for best results the kernel
> has to provide
>  the state.
>
> Again a full system dump would be wonderful, but taking a full dump for
> every OOM event on production systems? I am not nearly a good enough salesman
> to sell that one. So we need an alternate mechanism.
>
> If we can't agree on some sort of extensible, configurable approach then put
> the standard OOM Report in eBPF and make it mandatory to load it so we can
> justify having to do that. Linux should load it automatically.
> We'll just make a few changes and additions as needed.
>
> Sounds like a plan that we could live with.
> Would be interested if this works for others as well.

One further comment. In talking with my colleagues here who know eBPF
much better
than I do, it may not be possible to implement something this
complicated with eBPF.

If that is in the fact the case, then we'd have to try and hook the
OOM Reporting code
with tracepoints similar to kprobes only we want to do more than add counters
we want to change the flow to skip small output entries that aren't
worth printing.
If this isn't feasible with eBPF, then some derivative or our approach
or enhancing
the OOM output code directly seem like the best options. Will have to
investigate
this further.
