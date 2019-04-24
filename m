Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEABFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4D2218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="g4VoSO8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfDXOAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:00:24 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33931 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfDXOAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:00:24 -0400
Received: by mail-qt1-f194.google.com with SMTP id j6so1104940qtq.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 07:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KqWzI5RBqkSYwXqu3BP17kOVTF1TJARwl4vmT894iMM=;
        b=g4VoSO8dKH5SOcZMEaI/VIQ/BJ7wniQFvIu62iQg3UBOmFb2bSugt/L/NF5/pOE6tu
         GvZMct11fLDysOQEK+av1dMlw27d7BYCQvCr6rmx3gkXGsR/dDfUTnyDMA954RZQofEu
         6RxPk8Rj101BZ2s8OJMkbVbHIervuZ/nMs7Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KqWzI5RBqkSYwXqu3BP17kOVTF1TJARwl4vmT894iMM=;
        b=RdIsoGqBrr6U/mCsDfv58EoRdh5d9VluH/bA3IjYgkiGhLcz1maWHLZSceVDcRFBcP
         Gvk1cinjKunlpLdxXhU2Dy5GW1nPVueJGBlbNhWHTIeknY69FI9QUQRgkMAW+rV6L4di
         pZ8MsO19x4or4TRXMpNwpT2KCQuiPaYSSi2uPCkpKm/porEHn3fvKFVADEa6ZV3PfpVU
         Nj0708EqfhmypV/G6Tim0yewMnSSuADM+z+qWKDGC7LhC/Ra1cpOEySigs+s4rbDdLwM
         YZvrkfLuZrm8Xfo4lL+uK7ty4rVXPWUUb8hABs8NqJLQKN3Sccz7BbyvnH+hmarRxTi8
         vE1Q==
X-Gm-Message-State: APjAAAWwd+TGb2KpozgC878MB4virfnEJKgZO9Zf4Lsn5ry8CKkP2yb9
        TmXexUunSAIasspCELfKLomTQQ==
X-Google-Smtp-Source: APXvYqyMoIp8TJ3Ibdj1jSg0TRyDfu3EUUiNkJy16fYH6qpaxniAT5xbXhzlk2Gv+vCedZq17aqaoA==
X-Received: by 2002:ac8:72da:: with SMTP id o26mr10222861qtp.138.1556114423054;
        Wed, 24 Apr 2019 07:00:23 -0700 (PDT)
Received: from sinkpad (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id z3sm2527228qkc.76.2019.04.24.07.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 07:00:22 -0700 (PDT)
Date:   Wed, 24 Apr 2019 10:00:13 -0400
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
Message-ID: <20190424140013.GA14594@sinkpad>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-Apr-2019 09:13:10 PM, Aubrey Li wrote:
> On Wed, Apr 24, 2019 at 12:18 AM Vineeth Remanan Pillai
> <vpillai@digitalocean.com> wrote:
> >
> > Second iteration of the core-scheduling feature.
> >
> > This version fixes apparent bugs and performance issues in v1. This
> > doesn't fully address the issue of core sharing between processes
> > with different tags. Core sharing still happens 1% to 5% of the time
> > based on the nature of workload and timing of the runnable processes.
> >
> > Changes in v2
> > -------------
> > - rebased on mainline commit: 6d906f99817951e2257d577656899da02bb33105
> 
> Thanks to post v2, based on this version, here is my benchmarks result.
> 
> Environment setup
> --------------------------
> Skylake server, 2 numa nodes, 104 CPUs (HT on)
> cgroup1 workload, sysbench (CPU intensive non AVX workload)
> cgroup2 workload, gemmbench (AVX512 workload)
> 
> Case 1: task number < CPU num
> --------------------------------------------
> 36 sysbench threads in cgroup1
> 36 gemmbench threads in cgroup2
> 
> core sched off:
> - sysbench 95th percentile latency(ms): avg = 4.952, stddev = 0.55342
> core sched on:
> - sysbench 95th percentile latency(ms): avg = 3.549, stddev = 0.04449
> 
> Due to core cookie matching, sysbench tasks won't be affect by AVX512
> tasks, latency has ~28% improvement!!!
> 
> Case 2: task number > CPU number
> -------------------------------------------------
> 72 sysbench threads in cgroup1
> 72 gemmbench threads in cgroup2
> 
> core sched off:
> - sysbench 95th percentile latency(ms): avg = 11.914, stddev = 3.259
> core sched on:
> - sysbench 95th percentile latency(ms): avg = 13.289, stddev = 4.863
> 
> So not only power, now security and performance is a pair of contradictions.
> Due to core cookie not matching and forced idle introduced, latency has ~12%
> regression.
> 
> Any comments?

Would it be possible to post the results with HT off as well ?

Thanks,

Julien
