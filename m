Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFB5C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2725C20878
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCGdRr58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfDZCS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 22:18:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34942 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfDZCS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 22:18:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id z26so1468396ljj.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 19:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6gkFpbTusHg+1SZjh8+azBb3XS+APJ2PQ3Ib6xoheF4=;
        b=sCGdRr58OLE+EXpHMLiiVzl3T6ow8R8JJ7ULCs5UqMSgQXP0GmlkR6+jUGyVnCytEU
         JE7si/KoPe5XXJFFz88OyeqLpynaFNnqZ//DEjrYdjz6WrjtvhDhu/FO/ZK5Aqvhj8vY
         ILgK+4JuLA7BdFbCr3nksKK3pmPMP5nm27hxfjd+WWbRnZCjKONp49m+3gdi+8FWBeWl
         NsjOaLkW+tezDzTqINge97jVGdiUDXKnBRnUImjeeTRSBbfpRQfFPpIgz0cOl6lucS1a
         WUS2GVNVaUpCTjXXtNmdpO0Ckok4vOMqdZCbSEdzU4svoGcMHrkZRY2g5m9EtCzCKgV0
         7vNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6gkFpbTusHg+1SZjh8+azBb3XS+APJ2PQ3Ib6xoheF4=;
        b=sTKhyl7yZ36KZsEYXD1BzlIBh/hC+6GLcbt2H6f1Un90WxOBFjqsohggMici1LZmpK
         4DRnniKaEhhYnQiQh8/jMeraZh0NoA6tOe8e0YzQjkDTX8zV9IDt2XuQ2bup6qJRvZhm
         XZOKT7sazIhyvvj8BaiEFoSDu5JYr0/FmadezKkECnj/MQXelyRhkfEleVf24+M6A/tx
         k/AeCD1b2IjnLPv0fU2ZXY5T+qvxH59AIlNSw285JP83au6ppPfurQrM2ZrGR/Bc7lZI
         kXmG8kIamL2+XMfmGMcrLoqugX5l/JbIXxoK2eDSVPfc1f1e5hTXp/JPxN0Cj83AI02O
         0KzA==
X-Gm-Message-State: APjAAAUvBqycRx5epgfSrRqKyj/IT6WZN0C/rdIg8LLXJ21Ptg/c9W4B
        v22gM3DZoLuQ2QJJHoKd1uZUdGXR96K4+IfqfMY=
X-Google-Smtp-Source: APXvYqyVUsXIXf1QReuNWjh27ZkmwQf3aP+TUKbRf5Ycx1zmTKV7tKaQZcKG75VA4zbsyWMgXnwuJSo6gpgoZI6uF/U=
X-Received: by 2002:a2e:2b16:: with SMTP id q22mr23423701lje.20.1556245104660;
 Thu, 25 Apr 2019 19:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
 <20190424140013.GA14594@sinkpad> <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
 <20190425095508.GA8387@gmail.com>
In-Reply-To: <20190425095508.GA8387@gmail.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Fri, 26 Apr 2019 10:18:13 +0800
Message-ID: <CAERHkruMnwsD0iE1rQQGR3Zv1G+xbOBPODcgXz1fPn0kNRHsxA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 5:55 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Aubrey Li <aubrey.intel@gmail.com> wrote:
>
> > On Wed, Apr 24, 2019 at 10:00 PM Julien Desfossez
> > <jdesfossez@digitalocean.com> wrote:
> > >
> > > On 24-Apr-2019 09:13:10 PM, Aubrey Li wrote:
> > > > On Wed, Apr 24, 2019 at 12:18 AM Vineeth Remanan Pillai
> > > > <vpillai@digitalocean.com> wrote:
> > > > >
> > > > > Second iteration of the core-scheduling feature.
> > > > >
> > > > > This version fixes apparent bugs and performance issues in v1. This
> > > > > doesn't fully address the issue of core sharing between processes
> > > > > with different tags. Core sharing still happens 1% to 5% of the time
> > > > > based on the nature of workload and timing of the runnable processes.
> > > > >
> > > > > Changes in v2
> > > > > -------------
> > > > > - rebased on mainline commit: 6d906f99817951e2257d577656899da02bb33105
> > > >
> > > > Thanks to post v2, based on this version, here is my benchmarks result.
> > > >
> > > > Environment setup
> > > > --------------------------
> > > > Skylake server, 2 numa nodes, 104 CPUs (HT on)
> > > > cgroup1 workload, sysbench (CPU intensive non AVX workload)
> > > > cgroup2 workload, gemmbench (AVX512 workload)
> > > >
> > > > Case 1: task number < CPU num
> > > > --------------------------------------------
> > > > 36 sysbench threads in cgroup1
> > > > 36 gemmbench threads in cgroup2
> > > >
> > > > core sched off:
> > > > - sysbench 95th percentile latency(ms): avg = 4.952, stddev = 0.55342
> > > > core sched on:
> > > > - sysbench 95th percentile latency(ms): avg = 3.549, stddev = 0.04449
> > > >
> > > > Due to core cookie matching, sysbench tasks won't be affect by AVX512
> > > > tasks, latency has ~28% improvement!!!
> > > >
> > > > Case 2: task number > CPU number
> > > > -------------------------------------------------
> > > > 72 sysbench threads in cgroup1
> > > > 72 gemmbench threads in cgroup2
> > > >
> > > > core sched off:
> > > > - sysbench 95th percentile latency(ms): avg = 11.914, stddev = 3.259
> > > > core sched on:
> > > > - sysbench 95th percentile latency(ms): avg = 13.289, stddev = 4.863
> > > >
> > > > So not only power, now security and performance is a pair of contradictions.
> > > > Due to core cookie not matching and forced idle introduced, latency has ~12%
> > > > regression.
> > > >
> > > > Any comments?
> > >
> > > Would it be possible to post the results with HT off as well ?
> >
> > What's the point here to turn HT off? The latency is sensitive to the
> > relationship
> > between the task number and CPU number. Usually less CPU number, more run
> > queue wait time, and worse result.
>
> HT-off numbers are mandatory: turning HT off is by far the simplest way
> to solve the security bugs in these CPUs.
>
> Any core-scheduling solution *must* perform better than HT-off for all
> relevant workloads, otherwise what's the point?
>
Got it, I'll measure HT-off cases soon.

Thanks,
-Aubrey
