Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CFFC31E49
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 02:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C752085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 02:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTvM1OeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfFQCvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 22:51:41 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34819 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbfFQCvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 22:51:41 -0400
Received: by mail-lf1-f66.google.com with SMTP id a25so5337862lfg.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 19:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NP+H5g/b+Wzp5HDVodVIMObUSQnlwY7qTP5h/jM808A=;
        b=KTvM1OeFzJ0IQh2AZPn/iaoJKK/BFA/gSPbnw+dpHa1ZDMMLF9E9PlJJKgTOHsrYnm
         pIssE8Xpuasa+fx6cgM/Y0TvyOrngvWp3bWFBxOabommOPRLhwGBuW74QSXG+QhV03q8
         H8OYGyItfYW27WbCks04vsdNnmYH0JdmUb24CHg79pVqWDbRMfiLryki6Pbp1kmVyXqS
         gXzv+5l456YuyrUevO71mCqfFPa+VeD+Uo+3FvGWWaYtFlaIeCqOXNo6fjseLpUTYOUU
         hgE0rTuiAlcUZhnqY98BqbI1HTY6m878x4DpPIOCsOKRdJc4zvi2aBud23QAJmSGbsGH
         S3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NP+H5g/b+Wzp5HDVodVIMObUSQnlwY7qTP5h/jM808A=;
        b=FgLGj9HYDV081FZ+ABCuCx2vIAc92EZySL/TV2+SBFMsdPZ4atfav0VSD8Q0MHy78n
         HtA7jJC5DxaoaxZYO18t1edhkf35vK8fldDDb/ynGFtVqAWl9XJYE1hLRYGPcLxMTrsN
         79LCxn6cg3T6pE5MFLNkdAmy+IUSnI4dXDrrnEZZUJlowVRRD+eEtUgdeLYY4RQCMo+g
         nTeq0RdOw3aeNVcuVpV5YNPuT06FfrlJBc2oN7y3UugFMbSC86V2iUlfOdklnhen0ZpJ
         IdhtqUVfbhZ55ggmGBKYFYy4m3VMVRPw74wYVgW6LiMMJe8fACYucJF5w6rN0RPUXKvU
         wD/g==
X-Gm-Message-State: APjAAAUhDEgKPt/J/L1KXXLeL5CoLhZFPH0VPv/PSo0DXZan0L+XNRGO
        h+XQJNvOrYrAsJrdldb5WWzLKLHR7LKUdzZGUnU=
X-Google-Smtp-Source: APXvYqwqK5ONwlk02w74B7A40VrZYsHrYlrGyfM8oL8nn/x1ErvZmHIli0U18nqg0dfABCYJv4vnXvdbqQUjlsfLmyU=
X-Received: by 2002:ac2:5636:: with SMTP id b22mr24697722lff.2.1560739898713;
 Sun, 16 Jun 2019 19:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com>
 <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com> <20190531210816.GA24027@sinkpad>
 <20190606152637.GA5703@sinkpad> <20190612163345.GB26997@sinkpad>
 <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com> <20190613032246.GA17752@sinkpad>
In-Reply-To: <20190613032246.GA17752@sinkpad>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Mon, 17 Jun 2019 10:51:27 +0800
Message-ID: <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Julien Desfossez <jdesfossez@digitalocean.com>
Cc:     Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 11:22 AM Julien Desfossez
<jdesfossez@digitalocean.com> wrote:
>
> On 12-Jun-2019 05:03:08 PM, Subhra Mazumdar wrote:
> >
> > On 6/12/19 9:33 AM, Julien Desfossez wrote:
> > >After reading more traces and trying to understand why only untagged
> > >tasks are starving when there are cpu-intensive tasks running on the
> > >same set of CPUs, we noticed a difference in behavior in =E2=80=98pick=
_task=E2=80=99. In
> > >the case where =E2=80=98core_cookie=E2=80=99 is 0, we are supposed to =
only prefer the
> > >tagged task if it=E2=80=99s priority is higher, but when the prioritie=
s are
> > >equal we prefer it as well which causes the starving. =E2=80=98pick_ta=
sk=E2=80=99 is
> > >biased toward selecting its first parameter in case of equality which =
in
> > >this case was the =E2=80=98class_pick=E2=80=99 instead of =E2=80=98max=
=E2=80=99. Reversing the order of
> > >the parameter solves this issue and matches the expected behavior.
> > >
> > >So we can get rid of this vruntime_boost concept.
> > >
> > >We have tested the fix below and it seems to work well with
> > >tagged/untagged tasks.
> > >
> > My 2 DB instance runs with this patch are better with CORESCHED_STALL_F=
IX
> > than NO_CORESCHED_STALL_FIX in terms of performance, std deviation and
> > idleness. May be enable it by default?
>
> Yes if the fix is approved, we will just remove the option and it will
> always be enabled.
>

sysbench --report-interval option unveiled something.

benchmark setup
-------------------------
two cgroups, cpuset.cpus =3D 1, 53(one core, two siblings)
sysbench cpu mode, one thread in cgroup1
sysbench memory mode, one thread in cgroup2

no core scheduling
--------------------------
cpu throughput eps: 405.8, std: 0.14%
mem bandwidth MB/s: 5785.7, std: 0.11%

cgroup1 enable core scheduling(cpu mode)
cgroup2 disable core scheduling(memory mode)
-----------------------------------------------------------------
cpu throughput eps: 8.7, std: 519.2%
mem bandwidth MB/s: 6263.2, std: 9.3%

cgroup1 disable core scheduling(cpu mode)
cgroup2 enable core scheduling(memory mode)
-----------------------------------------------------------------
cpu throughput eps: 468.0 , std: 8.7%
mem bandwidth MB/S: 311.6 , std: 169.1%

cgroup1 enable core scheduling(cpu mode)
cgroup2 enable core scheduling(memory mode)
----------------------------------------------------------------
cpu throughput eps: 76.4 , std: 168.0%
mem bandwidth MB/S: 5388.3 , std: 30.9%

The result looks still unfair, and particularly, the variance is too high,
----sysbench cpu log ----
----snip----
[ 10s ] thds: 1 eps: 296.00 lat (ms,95%): 2.03
[ 11s ] thds: 1 eps: 0.00 lat (ms,95%): 1170.65
[ 12s ] thds: 1 eps: 1.00 lat (ms,95%): 0.00
[ 13s ] thds: 1 eps: 0.00 lat (ms,95%): 0.00
[ 14s ] thds: 1 eps: 295.91 lat (ms,95%): 2.03
[ 15s ] thds: 1 eps: 1.00 lat (ms,95%): 170.48
[ 16s ] thds: 1 eps: 0.00 lat (ms,95%): 2009.23
[ 17s ] thds: 1 eps: 1.00 lat (ms,95%): 995.51
[ 18s ] thds: 1 eps: 296.00 lat (ms,95%): 2.03
[ 19s ] thds: 1 eps: 1.00 lat (ms,95%): 170.48
[ 20s ] thds: 1 eps: 0.00 lat (ms,95%): 2009.23
----snip----

Thanks,
-Aubrey
