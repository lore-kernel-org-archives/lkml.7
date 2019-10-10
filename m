Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D70AC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B40B208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D2C+FZX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733115AbfJJIUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:20:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35365 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733165AbfJJIUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:20:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id w6so3695334lfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 01:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ol/xSQirMGaGYb6xGSjJ9GILZQp+6i24E3WZW4pKt2A=;
        b=D2C+FZX4c2nGmhWbkxLBwqJA6cWO0B7Lbf7rhfVjpQpHR6H0kQeQTz8j9rX7lmPNRj
         /dRN9gEEeK5zyPoYAdKFPvd5TByyZr5pk6A2SRF0cu3EopX5Kq4fp8b0dT4gC4PUa89y
         IWl0N5077uEDgKGCdBGpONI0GQ78hEwsAjolR3GK60SpFISmBKxvpPy5L7SgHg7qNDhb
         bUYYUNKHteoxcH5T62YbKb37EqsMf5fZQwngaqKe8Ke1CEVfdrU8AY6o+wxhmwjE7Isu
         McSHzOGpmdcmZPU7iVMYNipdKbXpDrnQyCdAu6Z+NAdrM7N3lz41L0utgQmdVEhrdgvA
         LOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ol/xSQirMGaGYb6xGSjJ9GILZQp+6i24E3WZW4pKt2A=;
        b=r8GAs8U9P5bD5wWrjZAudwGgo2oSU/tPuVltX94OF97ZfnlnCEI5/Vh0DCaNAdSbHL
         QqqpCxnzDA7o2XNaxo6j5aFWVFKX88fcPnZtl242W7fIvqS7YEdk8PFc3gPm0776WuCG
         ApJp5VxEE1Q6XdtDsqfmSd7RV955xklCdXdl1CA8sQjPD0v+nUSOX1PqRzFO4g+nNrNz
         eG4KNGGSAuTXKaSiUKamTNWiDD2letQYAvTF+4KrqOHVN8jemwv6FO84yn9fjDiC5cZW
         0zCiGrqH7jx/4OLEGjxZ2S1Y21OJ6MJQjfHizajEH371xE2eVv4bcQyxidGWRjk6wPSp
         dc8w==
X-Gm-Message-State: APjAAAXADGhjvQsg84KL1R2qGLs4fPqVJHTQXdwNFJgJWTBNhvyeK0wp
        /oJFh7hhMat4yt8CMIzOaPzpNpQPmicVUqpfCku+Mw==
X-Google-Smtp-Source: APXvYqyt6+qXlrwNYl3HTQ3R8b7wi43StjIa5ouyCl9jtKksCXV2yhG231e20xiS+/0LFDNUXe9T4bfFt2R8hgpWJbc=
X-Received: by 2002:ac2:5629:: with SMTP id b9mr5526107lff.32.1570695630035;
 Thu, 10 Oct 2019 01:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <20191008143258.GC8431@pauld.bos.csb> <CAKfTPtBsFoWOMP=+JHgtKV3S8o3Ha7RKgWcE+g1qaeqvP3xHVw@mail.gmail.com>
 <20191009193301.GC25192@pauld.bos.csb>
In-Reply-To: <20191009193301.GC25192@pauld.bos.csb>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 10 Oct 2019 10:20:18 +0200
Message-ID: <CAKfTPtBurpi+6Bvaobz3f=mZ5J145atJWnZ1z=csevrPZKsiWQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] sched/fair: rework the CFS load balance
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2019 at 21:33, Phil Auld <pauld@redhat.com> wrote:
>
> On Tue, Oct 08, 2019 at 05:53:11PM +0200 Vincent Guittot wrote:
> > Hi Phil,
> >
>
> ...
>
> > While preparing v4, I have noticed that I have probably oversimplified
> > the end of find_idlest_group() in patch "sched/fair: optimize
> > find_idlest_group" when it compares local vs the idlest other group.
> > Especially, there were a NUMA specific test that I removed in v3 and
> > re added in v4.
> >
> > Then, I'm also preparing a full rework that find_idlest_group() which
> > will behave more closely to load_balance; I mean : collect statistics,
> > classify group then selects the idlest
> >
>
> Okay, I'll watch for V4 and restest. It really seems to be limited to
> the 8-node system. None of the other systems are showing this.

Thanks for the information. This system might generate statistics at
boundaries between 2 behaviors and task placement misbehave

>
>
> > What is the behavior of lu.C Thread ? are they waking up a lot  ?and
> > could trigger the slow wake path ?
>
> Yes, probably a fair bit of waking. It's an interative equation solving
> code. It's fairly CPU intensive but requires communication for dependent
> calculations.  That's part of why having them mis-balanced causes such a
> large slow down. I think at times everyone else waits for the slow guys.
>
>
> >
> > >
> > > The initial fixes I made for this issue did not exhibit this behavior=
. They
> > > would have had other issues dealing with overload cases though. In th=
is case
> > > however there are only 154 or 158 threads on 160 CPUs so not overload=
ed.
> > >
> > > I'll try to get my hands on this system and poke into it. I just want=
ed to get
> > > your thoughts and let you know where we are.
> >
> > Thanks for testing
> >
>
> Sure!
>
>
> Thanks,
> Phil
>
>
>
>
> > Vincent
> >
> > >
> > >
> > >
> > > Thanks,
> > > Phil
> > >
> > >
> > > System details:
> > >
> > > Architecture:        x86_64
> > > CPU op-mode(s):      32-bit, 64-bit
> > > Byte Order:          Little Endian
> > > CPU(s):              160
> > > On-line CPU(s) list: 0-159
> > > Thread(s) per core:  2
> > > Core(s) per socket:  10
> > > Socket(s):           8
> > > NUMA node(s):        8
> > > Vendor ID:           GenuineIntel
> > > CPU family:          6
> > > Model:               47
> > > Model name:          Intel(R) Xeon(R) CPU E7- 4870  @ 2.40GHz
> > > Stepping:            2
> > > CPU MHz:             1063.934
> > > BogoMIPS:            4787.73
> > > Virtualization:      VT-x
> > > L1d cache:           32K
> > > L1i cache:           32K
> > > L2 cache:            256K
> > > L3 cache:            30720K
> > > NUMA node0 CPU(s):   0-9,80-89
> > > NUMA node1 CPU(s):   10-19,90-99
> > > NUMA node2 CPU(s):   20-29,100-109
> > > NUMA node3 CPU(s):   30-39,110-119
> > > NUMA node4 CPU(s):   40-49,120-129
> > > NUMA node5 CPU(s):   50-59,130-139
> > > NUMA node6 CPU(s):   60-69,140-149
> > > NUMA node7 CPU(s):   70-79,150-159
> > > Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl =
xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl =
vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf=
_lm epb pti tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
> > >
> > > $ numactl --hardware
> > > available: 8 nodes (0-7)
> > > node 0 cpus: 0 1 2 3 4 5 6 7 8 9 80 81 82 83 84 85 86 87 88 89
> > > node 0 size: 64177 MB
> > > node 0 free: 60866 MB
> > > node 1 cpus: 10 11 12 13 14 15 16 17 18 19 90 91 92 93 94 95 96 97 98=
 99
> > > node 1 size: 64507 MB
> > > node 1 free: 61167 MB
> > > node 2 cpus: 20 21 22 23 24 25 26 27 28 29 100 101 102 103 104 105 10=
6 107 108
> > > 109
> > > node 2 size: 64507 MB
> > > node 2 free: 61250 MB
> > > node 3 cpus: 30 31 32 33 34 35 36 37 38 39 110 111 112 113 114 115 11=
6 117 118
> > > 119
> > > node 3 size: 64507 MB
> > > node 3 free: 61327 MB
> > > node 4 cpus: 40 41 42 43 44 45 46 47 48 49 120 121 122 123 124 125 12=
6 127 128
> > > 129
> > > node 4 size: 64507 MB
> > > node 4 free: 60993 MB
> > > node 5 cpus: 50 51 52 53 54 55 56 57 58 59 130 131 132 133 134 135 13=
6 137 138
> > > 139
> > > node 5 size: 64507 MB
> > > node 5 free: 60892 MB
> > > node 6 cpus: 60 61 62 63 64 65 66 67 68 69 140 141 142 143 144 145 14=
6 147 148
> > > 149
> > > node 6 size: 64507 MB
> > > node 6 free: 61139 MB
> > > node 7 cpus: 70 71 72 73 74 75 76 77 78 79 150 151 152 153 154 155 15=
6 157 158
> > > 159
> > > node 7 size: 64480 MB
> > > node 7 free: 61188 MB
> > > node distances:
> > > node   0   1   2   3   4   5   6   7
> > >  0:  10  12  17  17  19  19  19  19
> > >  1:  12  10  17  17  19  19  19  19
> > >  2:  17  17  10  12  19  19  19  19
> > >  3:  17  17  12  10  19  19  19  19
> > >  4:  19  19  19  19  10  12  17  17
> > >  5:  19  19  19  19  12  10  17  17
> > >  6:  19  19  19  19  17  17  10  12
> > >  7:  19  19  19  19  17  17  12  10
> > >
> > >
> > >
> > > --
>
> --
