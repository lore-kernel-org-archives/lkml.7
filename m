Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3031CC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF953206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wuKIVixV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfJHPx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:53:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39455 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfJHPxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:53:25 -0400
Received: by mail-lf1-f68.google.com with SMTP id 72so12345341lfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 08:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CnPALD2P2OG5Wxk8/qFS/n+PKNYdF70fCNBH+YiXxpU=;
        b=wuKIVixVRzKtrNoImcZwhII7k9ynQzzQusbTNKRP+Z4M5zXzluRyl6XShzNr33XFfX
         5fJ1OB+LHpxLsspsmrIzdIGjS9Yeom/4mw8YCUAd/cW6CRMaHeeHLit/dYC7n+FSAT3r
         OyzUmg+tTwIMvd7b8jQzhGFpXx1heHHhZBv94VfgZ1q89jW9n7/D50y2vJZ5vp03GNAd
         yZ8tfeWnY8dBoLGAcSUbYXQwBslVQYs1aZc9qfKNIItotVNdf0dsQbsGGpw08UddEc4J
         7WVqWB57hKTgk4av9t2RJJoUw50kFh8bxLNOVVJvt+ieiwgsQJV7umMK5dVJIiJQidCl
         OFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CnPALD2P2OG5Wxk8/qFS/n+PKNYdF70fCNBH+YiXxpU=;
        b=gYFuw8sVnT94sjLjv/ybWcVgqnjdPM+gE3XGAAkWKuCWX3Rr+/X9aEnZq596nYnrlE
         ENowqUoHaYtNY1wLmuSmd5bufCs1XHaal+MDfIsTB8jqZvqjS0aYHetiCf49qCa8MqO9
         8DBndRRibXcjaaIC9ApPysMLWTbYndumfHxydlXf1CGEL4geaxUM3pzKhTEhY+/IitD/
         BeOaYEKtL8jJWF/0vZotQCR6J8Kc3+uuudGmIRIpjXI9iSkcEElpzRnugpvCNgzCcZcG
         yCjYrHUs8uIlobBYLUDwcfS+WZwh0dnnHwzhrRGuv4q/A2sgXLCoJcXzMZZbJHwtErbd
         n3KA==
X-Gm-Message-State: APjAAAWMUKYa5qGMiq4nvbmX5obwfObCzBC0KaA1zcGXnyKWAfCirVTn
        I4waW1wiohjOqszYSTDTH0T4SiAA0fyCSzI0273UyQ==
X-Google-Smtp-Source: APXvYqxalS6Hxx3VGRpIsFkqqhRg8hSqPsy9h/lHFDHa9jOcp1kSsP3DtlRIZO7L11N+mPgI5IslmWjiS4eWs+0SB50=
X-Received: by 2002:ac2:5bde:: with SMTP id u30mr19439345lfn.59.1570550002506;
 Tue, 08 Oct 2019 08:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org> <20191008143258.GC8431@pauld.bos.csb>
In-Reply-To: <20191008143258.GC8431@pauld.bos.csb>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 8 Oct 2019 17:53:11 +0200
Message-ID: <CAKfTPtBsFoWOMP=+JHgtKV3S8o3Ha7RKgWcE+g1qaeqvP3xHVw@mail.gmail.com>
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

Hi Phil,

On Tue, 8 Oct 2019 at 16:33, Phil Auld <pauld@redhat.com> wrote:
>
> Hi Vincent,
>
> On Thu, Sep 19, 2019 at 09:33:31AM +0200 Vincent Guittot wrote:
> > Several wrong task placement have been raised with the current load
> > balance algorithm but their fixes are not always straight forward and
> > end up with using biased values to force migrations. A cleanup and rewo=
rk
> > of the load balance will help to handle such UCs and enable to fine gra=
in
> > the behavior of the scheduler for other cases.
> >

[...]

> >
>
> We've been testing v3 and for the most part everything looks good. The
> group imbalance issues are fixed on all of our test systems except one.
>
> The one is an 8-node intel system with 160 cpus. I'll put the system
> details at the end.
>
> This shows the average number of benchmark threads running on each node
> through the run. That is, not including the 2 stress jobs. The end
> results are a 4x slow down in the cgroup case versus not. The 152 and
> 156 are the number of LU threads in the run. In all cases there are 2
> stress CPU threads running either in their own cgroups (GROUP) or
> everything is in one cgroup (NORMAL).  The normal case is pretty well
> balanced with only a few >=3D 20 and those that are are only a little
> over. In the GROUP cases things are not so good. There are some > 30
> for example, and others < 10.
>
>
> lu.C.x_152_GROUP_1   17.52  16.86  17.90  18.52  20.00  19.00  22.00  20.=
19
> lu.C.x_152_GROUP_2   15.70  15.04  15.65  15.72  23.30  28.98  20.09  17.=
52
> lu.C.x_152_GROUP_3   27.72  32.79  22.89  22.62  11.01  12.90  12.14  9.9=
3
> lu.C.x_152_GROUP_4   18.13  18.87  18.40  17.87  18.80  19.93  20.40  19.=
60
> lu.C.x_152_GROUP_5   24.14  26.46  20.92  21.43  14.70  16.05  15.14  13.=
16
> lu.C.x_152_NORMAL_1  21.03  22.43  20.27  19.97  18.37  18.80  16.27  14.=
87
> lu.C.x_152_NORMAL_2  19.24  18.29  18.41  17.41  19.71  19.00  20.29  19.=
65
> lu.C.x_152_NORMAL_3  19.43  20.00  19.05  20.24  18.76  17.38  18.52  18.=
62
> lu.C.x_152_NORMAL_4  17.19  18.25  17.81  18.69  20.44  19.75  20.12  19.=
75
> lu.C.x_152_NORMAL_5  19.25  19.56  19.12  19.56  19.38  19.38  18.12  17.=
62
>
> lu.C.x_156_GROUP_1   18.62  19.31  18.38  18.77  19.88  21.35  19.35  20.=
35
> lu.C.x_156_GROUP_2   15.58  12.72  14.96  14.83  20.59  19.35  29.75  28.=
22
> lu.C.x_156_GROUP_3   20.05  18.74  19.63  18.32  20.26  20.89  19.53  18.=
58
> lu.C.x_156_GROUP_4   14.77  11.42  13.01  10.09  27.05  33.52  23.16  22.=
98
> lu.C.x_156_GROUP_5   14.94  11.45  12.77  10.52  28.01  33.88  22.37  22.=
05
> lu.C.x_156_NORMAL_1  20.00  20.58  18.47  18.68  19.47  19.74  19.42  19.=
63
> lu.C.x_156_NORMAL_2  18.52  18.48  18.83  18.43  20.57  20.48  20.61  20.=
09
> lu.C.x_156_NORMAL_3  20.27  20.00  20.05  21.18  19.55  19.00  18.59  17.=
36
> lu.C.x_156_NORMAL_4  19.65  19.60  20.25  20.75  19.35  20.10  19.00  17.=
30
> lu.C.x_156_NORMAL_5  19.79  19.67  20.62  22.42  18.42  18.00  17.67  19.=
42
>
>
> From what I can see this was better but not perfect in v1.  It was closer=
 and
> so the end results (LU reported times and op/s) were close enough. But lo=
oking
> closer at it there are still some issues. (NORMAL is comparable to above)
>
>
> lu.C.x_152_GROUP_1   18.08  18.17  19.58  19.29  19.25  17.50  21.46  18.=
67
> lu.C.x_152_GROUP_2   17.12  17.48  17.88  17.62  19.57  17.31  23.00  22.=
02
> lu.C.x_152_GROUP_3   17.82  17.97  18.12  18.18  24.55  22.18  16.97  16.=
21
> lu.C.x_152_GROUP_4   18.47  19.08  18.50  18.66  21.45  25.00  15.47  15.=
37
> lu.C.x_152_GROUP_5   20.46  20.71  27.38  24.75  17.06  16.65  12.81  12.=
19
>
> lu.C.x_156_GROUP_1   18.70  18.80  20.25  19.50  20.45  20.30  19.55  18.=
45
> lu.C.x_156_GROUP_2   19.29  19.90  17.71  18.10  20.76  21.57  19.81  18.=
86
> lu.C.x_156_GROUP_3   25.09  29.19  21.83  21.33  18.67  18.57  11.03  10.=
29
> lu.C.x_156_GROUP_4   18.60  19.10  19.20  18.70  20.30  20.00  19.70  20.=
40
> lu.C.x_156_GROUP_5   18.58  18.9   18.63  18.16  17.32  19.37  23.92  21.=
08
>
> There is high variance so it may not be anything specific between v1 and =
v3 here.

While preparing v4, I have noticed that I have probably oversimplified
the end of find_idlest_group() in patch "sched/fair: optimize
find_idlest_group" when it compares local vs the idlest other group.
Especially, there were a NUMA specific test that I removed in v3 and
re added in v4.

Then, I'm also preparing a full rework that find_idlest_group() which
will behave more closely to load_balance; I mean : collect statistics,
classify group then selects the idlest

What is the behavior of lu.C Thread ? are they waking up a lot  ?and
could trigger the slow wake path ?

>
> The initial fixes I made for this issue did not exhibit this behavior. Th=
ey
> would have had other issues dealing with overload cases though. In this c=
ase
> however there are only 154 or 158 threads on 160 CPUs so not overloaded.
>
> I'll try to get my hands on this system and poke into it. I just wanted t=
o get
> your thoughts and let you know where we are.

Thanks for testing

Vincent

>
>
>
> Thanks,
> Phil
>
>
> System details:
>
> Architecture:        x86_64
> CPU op-mode(s):      32-bit, 64-bit
> Byte Order:          Little Endian
> CPU(s):              160
> On-line CPU(s) list: 0-159
> Thread(s) per core:  2
> Core(s) per socket:  10
> Socket(s):           8
> NUMA node(s):        8
> Vendor ID:           GenuineIntel
> CPU family:          6
> Model:               47
> Model name:          Intel(R) Xeon(R) CPU E7- 4870  @ 2.40GHz
> Stepping:            2
> CPU MHz:             1063.934
> BogoMIPS:            4787.73
> Virtualization:      VT-x
> L1d cache:           32K
> L1i cache:           32K
> L2 cache:            256K
> L3 cache:            30720K
> NUMA node0 CPU(s):   0-9,80-89
> NUMA node1 CPU(s):   10-19,90-99
> NUMA node2 CPU(s):   20-29,100-109
> NUMA node3 CPU(s):   30-39,110-119
> NUMA node4 CPU(s):   40-49,120-129
> NUMA node5 CPU(s):   50-59,130-139
> NUMA node6 CPU(s):   60-69,140-149
> NUMA node7 CPU(s):   70-79,150-159
> Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge=
 mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall=
 nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtop=
ology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx =
smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm =
epb pti tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
>
> $ numactl --hardware
> available: 8 nodes (0-7)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 80 81 82 83 84 85 86 87 88 89
> node 0 size: 64177 MB
> node 0 free: 60866 MB
> node 1 cpus: 10 11 12 13 14 15 16 17 18 19 90 91 92 93 94 95 96 97 98 99
> node 1 size: 64507 MB
> node 1 free: 61167 MB
> node 2 cpus: 20 21 22 23 24 25 26 27 28 29 100 101 102 103 104 105 106 10=
7 108
> 109
> node 2 size: 64507 MB
> node 2 free: 61250 MB
> node 3 cpus: 30 31 32 33 34 35 36 37 38 39 110 111 112 113 114 115 116 11=
7 118
> 119
> node 3 size: 64507 MB
> node 3 free: 61327 MB
> node 4 cpus: 40 41 42 43 44 45 46 47 48 49 120 121 122 123 124 125 126 12=
7 128
> 129
> node 4 size: 64507 MB
> node 4 free: 60993 MB
> node 5 cpus: 50 51 52 53 54 55 56 57 58 59 130 131 132 133 134 135 136 13=
7 138
> 139
> node 5 size: 64507 MB
> node 5 free: 60892 MB
> node 6 cpus: 60 61 62 63 64 65 66 67 68 69 140 141 142 143 144 145 146 14=
7 148
> 149
> node 6 size: 64507 MB
> node 6 free: 61139 MB
> node 7 cpus: 70 71 72 73 74 75 76 77 78 79 150 151 152 153 154 155 156 15=
7 158
> 159
> node 7 size: 64480 MB
> node 7 free: 61188 MB
> node distances:
> node   0   1   2   3   4   5   6   7
>  0:  10  12  17  17  19  19  19  19
>  1:  12  10  17  17  19  19  19  19
>  2:  17  17  10  12  19  19  19  19
>  3:  17  17  12  10  19  19  19  19
>  4:  19  19  19  19  10  12  17  17
>  5:  19  19  19  19  12  10  17  17
>  6:  19  19  19  19  17  17  10  12
>  7:  19  19  19  19  17  17  12  10
>
>
>
> --
