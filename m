Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B31C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 04:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0869A2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 04:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPuG1E35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391812AbfIZEiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 00:38:06 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35905 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbfIZEiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 00:38:05 -0400
Received: by mail-io1-f68.google.com with SMTP id b136so3034294iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 21:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9sRAyjsHaXznk/whN2C+BXH4RuFtDZdSG5+S735+JJM=;
        b=SPuG1E35Hn7AfnFw8iEbKYWQBrQjDAHEwyKsicP+UUHH//fku50xWbOkmON4EvyMXI
         uuFDaE8PuWBPUUirm2v7YBASMNw41M1wwKxInrxZPKQzT3TNbxkNgFx9ymeYdhhlldDb
         E2n4QoR+0vadcqGxnXPk0/yQy5Gtkt7c8FktDG5uofn1MgWhTjvl+OSf9T6EpZfR0WIY
         Elg5+VDByhCijeDo1lUQn4L1wdPnNECxWCQrZoPH4sXP2c8tUlZ1AYvtFWEDTV53L+qv
         g34dJUxAWSJ6oBzvY/zXlBoYsZAb4nTBLL7XAti8HF1FRZA2vdS2J39+bfu5zD68t1YF
         X0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9sRAyjsHaXznk/whN2C+BXH4RuFtDZdSG5+S735+JJM=;
        b=i3VyYmDlnVy115VASgsX1X1pu8u7kaR6dzUkxINDWIkZqMfErhMDiGACBfo5/Czqhb
         Q4t2s8Ir0j37iJ/Aszi8Z/VTvVWb8NlXlTbdnJkckNi5wEK3Y7wjoCsJcVeiE20N8ZYs
         mGAOprZUKw3cNZ/1tVb9Eh48eT5DV0lZGNdmZJm+cw0axHVgI+pZWgLAPgklZKzKViV/
         9sE/Yj72rr2QD3PpaNCtR8/YGnBYrskOAlhe2CHrn9v48SinuPo1qtPDMzRjga7kdN7o
         uxEaLHKAv8W8AFi8nj7ls7gLd5um2xzAZmq36elgrbEH9gBK3xj+4DqB1EheTgrEC73d
         oEKw==
X-Gm-Message-State: APjAAAWOnETEEPMkke7u0s2LtGF118brXQpDRlOil+viya8c7PfcAiN2
        5p3IjJXpJj4pN4d1jvOZetsLn7+2+nEBZfTfBSU=
X-Google-Smtp-Source: APXvYqxYrrby9K9CuvLt+zGBeIinH/stC9TWA+D1xNwNWg6RyCYsjHxh7cV21Jdy4HvEd/N11UFmHi+62RwaPFoJur4=
X-Received: by 2002:a5e:d817:: with SMTP id l23mr1693125iok.142.1569472684945;
 Wed, 25 Sep 2019 21:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <1568817522-8754-1-git-send-email-laoar.shao@gmail.com>
 <1568817522-8754-2-git-send-email-laoar.shao@gmail.com> <456c8216-a9f4-6821-e688-744e93df826f@suse.de>
 <49489979-0bf1-881c-ebd5-87d0892a7da4@suse.de>
In-Reply-To: <49489979-0bf1-881c-ebd5-87d0892a7da4@suse.de>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 26 Sep 2019 12:37:28 +0800
Message-ID: <CALOAHbBQxCvx2pR1VpsarxQF0RNpPFJ8i85CDSEjFXk0F-+K3w@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf script python: integrate page reclaim analyze script
To:     Tony Jones <tonyj@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, acme@kernel.org,
        namhyung@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        jolsa@redhat.com, mingo@redhat.com, Linux MM <linux-mm@kvack.org>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 11:36 AM Tony Jones <tonyj@suse.de> wrote:
>
> On 9/25/19 6:56 PM, Tony Jones wrote:
> > On 9/18/19 7:38 AM, Yafang Shao wrote:
> >> A new perf script page-reclaim is introduced in this patch. This new s=
cript
> >> is used to report the page reclaim details. The possible usage of this
> >> script is as bellow,
> >> - identify latency spike caused by direct reclaim
> >> - whehter the latency spike is relevant with pageout
> >> - why is page reclaim requested, i.e. whether it is because of memory
> >>   fragmentation
> >> - page reclaim efficiency
> >> etc
> >> In the future we may also enhance it to analyze the memcg reclaim.
> >>
> >> Bellow is how to use this script,
> >>     # Record, one of the following
> >>     $ perf record -e 'vmscan:mm_vmscan_*' ./workload
> >>     $ perf script record page-reclaim
> >>
> >>     # Report
> >>     $ perf script report page-reclaim
> >>
> >>     # Report per process latency
> >>     $ perf script report page-reclaim -- -p
> >
> >
> > I tested it with global-dhp__pagereclaim-performance from mmtests and g=
ot what appears to be reasonable results and the output looks correct and u=
seful.  However I'm not a vm expert so I can't comment further.  Hopefully =
someone on linux-mm can give more specific feedback.
> >
> > There is one issue with Python3,  see below.  I didn't test with Python=
2.
>
> Ok, I guess this wasn't actually tested with Python3 as itervalues() is P=
ython2 only.   Any scripts need to work with both Python2.6+ and Python3.
>
> # perf script -i /tmp/perf.out -s page-reclaim.py -- -p
> ...
>
> Traceback (most recent call last):
>   File "page-reclaim.py", line 305, in trace_end
>     i.display_proc(),
>   File "page-reclaim.py", line 268, in display_proc
>     print_proc_latency(sorted(self.stat.stats['latency'].itervalues(),
> AttributeError: 'dict' object has no attribute 'itervalues'
> Fatal Python error: problem in Python trace event handler
>
> Use a try/except to handle this.
>

Hi  Tony,

Thanks for your review.
I only verified it with python2.
I will improve it to make it work with both python2.6+ and python3.

Thanks
Yafang
