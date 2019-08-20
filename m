Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8AFC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9052087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zzjHaxYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfHTQ5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 12:57:50 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36198 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTQ5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:57:49 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so13650363iom.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 09:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D0t6hhmj5HXr4BwVb3RXfvNKmBibA5PyZM61NA5ggTQ=;
        b=zzjHaxYXu6tv3tEom1ZL2A4QUu02yb1d61q6+DFveEC/f2ZHnr2qkxa4jSQmzTLWTF
         QXu0suldYGEMLm8Q9bPH0Tr7ZLkIxUARUmRuytW42BsJKa8a6e8NnUEqskwei6Z400RV
         9nKSNpxVPZXe8iyOdtYc9CxVB0KndjsO8gM6bR8dasuBo653cg/17MUSJPU8cXGj5NiK
         K2yb6EyoXMvSQlhojEGrBFLWHAB2wOjrFmFl0ZvV3mzqVqZmxDzkSztGxInW63QCNfvS
         s/sn9nKEWvtJ/sYqzo12JSAn0D2FwtvW0dOoMBE4PEizyzZvVHZwlD6Ai700WJmAeuSl
         76nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D0t6hhmj5HXr4BwVb3RXfvNKmBibA5PyZM61NA5ggTQ=;
        b=gH1fByY/Izc5q2OHFc/84hfpS76CuXggrmDaSRGqqmFiEYbWtsq/4IAK3UfVtAQ76g
         vxs2hLQMIjm/dU8e0ULoiYE/2sIOYrtzdV62yeebyRvvk5YwfgJYnTxGu5OYyNKSPfXm
         6aWB5qkNCnpa5plwS+dHwgthqZEveUMFtxxCQte6gLw8P7M/NSmheH/6gnQHUzkB5Sut
         Ff0TZHFpnxvvW8Og2BbAS2ftVwCV0X6y2eS/oSe86IUo9BJl58owTfNZq1wQemaCW0me
         7x/8hxVXw2EWXKdgyEs3FmSsSCKWaCxDdxLbNce+7PMl1X1ALjuHAGna69GLTSrE2oUK
         YBiw==
X-Gm-Message-State: APjAAAU08okkkQQIwWULWRZBTdArgWZrWXf8FrVz3PuDVqkAPqV8reuN
        pmb99gllnuMDAXBPG8yHmb2Beyn9TPbdMiFoBu+zTAI/
X-Google-Smtp-Source: APXvYqzmhdJ1D01cGahk4N28OXcRts6T03QlJvBW0fyFoA44MzuOf8WcsQ86bnMOzaWGgTdV0rZa1jKsKiQls2mnGqI=
X-Received: by 2002:a6b:720e:: with SMTP id n14mr34402390ioc.139.1566320268561;
 Tue, 20 Aug 2019 09:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1565188228.git.ilubashe@akamai.com> <291d2cda6ee75b4cd4c9ce717c177db18bf03a31.1565188228.git.ilubashe@akamai.com>
 <CANLsYkxZE0CQJKQ-bFi=zFV5vTCbL2v76+x1fmCpqNruqWiFXg@mail.gmail.com>
 <20190814184814.GM9280@kernel.org> <20190814185213.GN9280@kernel.org>
 <23f7b8c7616a467c93ee2c77e8ffd3cf@usma1ex-dag1mb6.msg.corp.akamai.com>
 <CANLsYkxqBcJq8QJq+aLZXQas1VBg_wGh_p5WTUuRVFCYEQWiQw@mail.gmail.com>
 <20190815214236.GA3929@kernel.org> <CANLsYkyPkcJWmBZzyjGj3vJRgEtuaun7HQjN1=5wcOyTPnfhmQ@mail.gmail.com>
 <3f70f6be3a464ca5b4cf563433933245@usma1ex-dag1mb6.msg.corp.akamai.com>
In-Reply-To: <3f70f6be3a464ca5b4cf563433933245@usma1ex-dag1mb6.msg.corp.akamai.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 20 Aug 2019 10:57:37 -0600
Message-ID: <CANLsYkwAE=t7nENhxqM1h2CER_78z0LokqtSBWmAa1MxuMcAmw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] perf: Use CAP_SYSLOG with kptr_restrict checks
To:     "Lubashev, Igor" <ilubashe@akamai.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        James Morris <jmorris@namei.org>, Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 at 16:22, Lubashev, Igor <ilubashe@akamai.com> wrote:
>
> On Mon, August 19, 2019 at 12:51 PM Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> > On Thu, 15 Aug 2019 at 15:42, Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Thu, Aug 15, 2019 at 02:16:48PM -0600, Mathieu Poirier escreveu:
> > > > On Wed, 14 Aug 2019 at 14:02, Lubashev, Igor <ilubashe@akamai.com>
> > wrote:
> > > > >
> > > > > > On Wed, August 14, 2019 at 2:52 PM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > > > > > Em Wed, Aug 14, 2019 at 03:48:14PM -0300, Arnaldo Carvalho de
> > > > > > Melo
> > > > > > escreveu:
> > > > > > > Em Wed, Aug 14, 2019 at 12:04:33PM -0600, Mathieu Poirier
> > escreveu:
> > > > > > > > # echo 0 > /proc/sys/kernel/kptr_restrict #
> > > > > > > > ./tools/perf/perf record -e instructions:k uname
> > > > > > > > perf: Segmentation fault
> > > > > > > > Obtained 10 stack frames.
> > > > > > > > ./tools/perf/perf(sighandler_dump_stack+0x44)
> > > > > > > > [0x55af9e5da5d4]
> > > > > > > > /lib/x86_64-linux-gnu/libc.so.6(+0x3ef20) [0x7fd31efb6f20]
> > > > > > > > ./tools/perf/perf(perf_event__synthesize_kernel_mmap+0xa7)
> > > > > > > > [0x55af9e590337]
> > > > > > > > ./tools/perf/perf(+0x1cf5be) [0x55af9e50c5be]
> > > > > > > > ./tools/perf/perf(cmd_record+0x1022) [0x55af9e50dff2]
> > > > > > > > ./tools/perf/perf(+0x23f98d) [0x55af9e57c98d]
> > > > > > > > ./tools/perf/perf(+0x23fc9e) [0x55af9e57cc9e]
> > > > > > > > ./tools/perf/perf(main+0x369) [0x55af9e4f6bc9]
> > > > > > > > /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe7)
> > > > > > > > [0x7fd31ef99b97]
> > > > > > > > ./tools/perf/perf(_start+0x2a) [0x55af9e4f704a] Segmentation
> > > > > > > > fault
> > > > > > > >
> > > > > > > > I can reproduce this on both x86 and ARM64.
> > > > > > >
> > > > > > > I don't see this with these two csets removed:
> > > > > > >
> > > > > > > 7ff5b5911144 perf symbols: Use CAP_SYSLOG with kptr_restrict
> > > > > > > checks d7604b66102e perf tools: Use CAP_SYS_ADMIN with
> > > > > > > perf_event_paranoid checks
> > > > > > >
> > > > > > > Which were the ones I guessed were related to the problem you
> > > > > > > reported, so they are out of my ongoing perf/core pull request
> > > > > > > to Ingo/Thomas, now trying with these applied and your
> > instructions...
> > > > > >
> > > > > > Can't repro:
> > > > > >
> > > > > > [root@quaco ~]# cat /proc/sys/kernel/kptr_restrict
> > > > > > 0
> > > > > > [root@quaco ~]# perf record -e instructions:k uname Linux [ perf
> > record:
> > > > > > Woken up 1 times to write data ] [ perf record: Captured and
> > > > > > wrote 0.024 MB perf.data (1 samples) ] [root@quaco ~]# echo 1 >
> > > > > > /proc/sys/kernel/kptr_restrict [root@quaco ~]# perf record -e
> > > > > > instructions:k uname Linux [ perf record: Woken up 1 times to write
> > data ] [ perf record:
> > > > > > Captured and wrote 0.024 MB perf.data (1 samples) ] [root@quaco
> > > > > > ~]# echo
> > > > > > 0 > /proc/sys/kernel/kptr_restrict [root@quaco ~]# perf record
> > > > > > -e instructions:k uname Linux [ perf record: Woken up 1 times to
> > > > > > write data ] [ perf record: Captured and wrote 0.024 MB
> > > > > > perf.data (1 samples) ] [root@quaco ~]#
> > > > > >
> > > > > > [acme@quaco perf]$ git log --oneline --author Lubashev tools/
> > > > > > 7ff5b5911144 (HEAD -> perf/cap, acme.korg/tmp.perf/cap,
> > > > > > acme.korg/perf/cap) perf symbols: Use CAP_SYSLOG with
> > > > > > kptr_restrict checks d7604b66102e perf tools: Use CAP_SYS_ADMIN
> > > > > > with perf_event_paranoid checks c766f3df635d perf ftrace: Use
> > > > > > CAP_SYS_ADMIN instead of euid==0 c22e150e3afa perf tools: Add
> > > > > > helpers to use capabilities if present
> > > > > > 74d5f3d06f70 tools build: Add capability-related feature
> > > > > > detection perf version 5.3.rc4.g7ff5b5911144 [acme@quaco perf]$
> > > > >
> > > > > I got an ARM64 cloud VM, but I cannot reproduce.
> > > > > # cat /proc/sys/kernel/kptr_restrict
> > > > > 0
> > > > >
> > > > > Perf trace works fine (does not die):
> > > > > # ./perf trace -a
> > > > >
> > > > > Here is my setup:
> > > > > Repo: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> > > > > Branch: tmp.perf/cap
> > > > > Commit: 7ff5b5911 "perf symbols: Use CAP_SYSLOG with kptr_restrict
> > checks"
> > > > > gcc --version: gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
> > > > > uname -a: Linux arm-4-par-1 4.9.93-mainline-rev1 #1 SMP Tue Apr 10
> > > > > 09:54:46 UTC 2018 aarch64 aarch64 aarch64 GNU/Linux lsb_release
> > > > > -a: Ubuntu 18.04.3 LTS
> > > > >
> > > > > Auto-detecting system features:
> > > > > ...                         dwarf: [ on  ]
> > > > > ...            dwarf_getlocations: [ on  ]
> > > > > ...                         glibc: [ on  ]
> > > > > ...                          gtk2: [ on  ]
> > > > > ...                      libaudit: [ on  ]
> > > > > ...                        libbfd: [ on  ]
> > > > > ...                        libcap: [ on  ]
> > > > > ...                        libelf: [ on  ]
> > > > > ...                       libnuma: [ on  ]
> > > > > ...        numa_num_possible_cpus: [ on  ]
> > > > > ...                       libperl: [ on  ]
> > > > > ...                     libpython: [ on  ]
> > > > > ...                     libcrypto: [ on  ]
> > > > > ...                     libunwind: [ on  ]
> > > > > ...            libdw-dwarf-unwind: [ on  ]
> > > > > ...                          zlib: [ on  ]
> > > > > ...                          lzma: [ on  ]
> > > > > ...                     get_cpuid: [ OFF ]
> > > > > ...                           bpf: [ on  ]
> > > > > ...                        libaio: [ on  ]
> > > > > ...                       libzstd: [ on  ]
> > > > > ...        disassembler-four-args: [ on  ]
> > > > >
> > > > > I also could not reproduce on x86:
> > > > > lsb_release -a: Ubuntu 18.04.1 LTS gcc --version: gcc (Ubuntu
> > > > > 7.4.0-1ubuntu1~18.04aka10.0.0) 7.4.0 uname -r: 4.4.0-154-generic
> > > >
> > > > I isolated the problem to libcap-dev - if it is not installed a
> > > > segmentation fault will occur.  Since this set is about using
> > > > capabilities it is obvious that not having it on a system should
> > > > fail a trace session, but it should not crash it.
> > >
> > > It shouldn't crash on x86_64:
> > >
> > > root@quaco ~]# sysctl kernel.kptr_restrict kernel.kptr_restrict = 0
> > > [root@quaco ~]# perf record -e instructions:k uname Linux [ perf
> > > record: Woken up 1 times to write data ] [ perf record: Captured and
> > > wrote 0.023 MB perf.data (5 samples) ] [root@quaco ~]# ldd ~/bin/perf
> > > | grep libcap [root@quaco ~]# perf -v perf version
> > > 5.3.rc4.g329ca330bf8b [root@quaco ~]# [acme@quaco perf]$ git log
> > > --oneline -4 329ca330bf8b (HEAD -> perf/cap) perf symbols: Use
> > > CAP_SYSLOG with kptr_restrict checks f7b9999387af perf tools: Use
> > > CAP_SYS_ADMIN with perf_event_paranoid checks
> > > 4d0489cf1c47 (acme.korg/tmp.perf/script-switch-on-off, perf/core) perf
> > > report: Add --switch-on/--switch-off events
> > > 2f53ae347f59 perf top: Add --switch-on/--switch-off events [acme@quaco
> > > perf]$
> > >
> > > > If libcap-dev is not installed function
> > > > symbol__restricted_filename() will return true, which in turn will
> > > > prevent symbol_name to be set in
> > > > machine__get_running_kernel_start().  That prevents function
> > > > map__set_kallsyms_ref_reloc_sym() from being called in
> > > > machine__create_kernel_maps(), resulting in kmap->ref_reloc_sym
> > > > being NULL in _perf_event__synthesize_kernel_mmap() and a
> > > > segmentation fault.
> > >
> > > Can you please try with my perf/cap branch? Perhaps you're using
> > > Igor's original set of patches? I made changes to the fallback, he was
> > > making it return false while I made it fallback to geteuid() == 0, as
> > > was before his patches.
> >
> > Things are working properly on your perf/cap branch.  I tested with on both
> > x86 and ARM.
>
> Mathieu, you are probably testing with euid==0.

Very true

> If you were to test with euid!=0 but with CAP_SYSLOG and no libcap (and kptr_restrict=0, perf_event_paranoid=2), you would likely hit the bug that you identified in __perf_event__synthesize_kermel_mmap().
>
> See https://lkml.kernel.org/lkml/930a59730c0d495f8c5acf4f99048e8d@usma1ex-dag1mb6.msg.corp.akamai.com for the fix (Option 1 only or Options 1+2).
>
> Arnaldo, once we decide what the right fix is, I am happy to post the update (options 1, 1+2) as a patch series.

CC me on the next patchset and I'll be happy to test it.

>
> - Igor
>
>
> > > > I am not sure how this can be fixed.  I counted a total of 19
> > > > instances where kmap->ref_reloc_sym->XYZ is called, only 2 of wich
> > > > care to check if kmap->ref_reloc_sym is valid before proceeding.  As
> > > > such I must hope that in the 17 other cases, kmap->ref_reloc_sym is
> > > > guaranteed to be valid.  If I am correct then all we need is to
> > > > check for a valid pointer in _perf_event__synthesize_kernel_mmap().
> > > > Otherwise it will be a little harder.
> > > >
> > > > Mathieu
>
