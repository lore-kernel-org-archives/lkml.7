Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97AFC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9107C2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZKpjAQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfHSQvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:51:25 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40459 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbfHSQvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:51:25 -0400
Received: by mail-io1-f65.google.com with SMTP id t6so5764525ios.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 09:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=azVJnvWnS4iAifUctENzXhTQHJYaXzLyjFRbYXJ3Y50=;
        b=LZKpjAQj2QbA2t3Oya83T0tkOuZepDBwNBcQ1E9gNnRT5/RFMFtxywYg2gkGk5Q+TQ
         S+GoMGajFBqn+OADKQIsTCE/t6B6x6aOUpwgeG70xCWKK6r6DWhiCDXnDtNBxuyAMpol
         V1rPHeWk5pZ0XO8As+HpZB3J4oT477oJGWlBtKan88A+clNVpVZKE+SZqOEo2RwUBWD1
         3AXbtUIksfCEZxAivt6sApyqgvWnDFPRkWmo/t5Tm27TRBqAcXSbrBr5SCRxfhhh/+ey
         HzVwbAA4gmauUK5UDCznOS4WecJLIF64CeVR9s/c6BqXNfBWGDp+/AZt8QUfxI9ZZnmU
         sjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=azVJnvWnS4iAifUctENzXhTQHJYaXzLyjFRbYXJ3Y50=;
        b=Rq1/tqWVu4TPqn7Hv+YBe2eJfeH/U8puomq8R5GlS2QJk3FMXKXbHeHKxDn1UTMtUn
         qmLGqFW/OTDt305AFEU5s+ZSKA+9BIKqyyVMRcHOxfooAhzmgKHrur4r9J0tvmMo5Z4R
         D5gah8BP3V/gHungo1ADDKzf8LV+0cDdK94shZlP/UfMAeV8U736B8wwf1UKm9HN+ax4
         4papmTuKA4RoS1a8toW1bWjDqt1e8qRptuLq2Y5XlM0SBaAJ4POOfsetQgFIxfJiLqHA
         JvYBnE9H6tzqEcxA1AgOPVcL7BeFaxptOv9ZgOF2tQlNTyi9PM8qZ9sSt+DJz1KjGa7r
         lrxg==
X-Gm-Message-State: APjAAAUlNlw+3c7nODch4tkMBBoAe0LNb0OqF+xg3KooM9V817TQpzdL
        8OrD8EQCreaLD0WRpnIXwZ/vL5VIh8r1YqF/MRytRQ==
X-Google-Smtp-Source: APXvYqxtIVGdDh3ome6VlYhi07zz97u81mbec/a2Y4n2Ba2kI7pqQRHzsTdukltSjeg/Rn7BxrkIemsz/9off5xHrWI=
X-Received: by 2002:a02:6914:: with SMTP id e20mr27123117jac.83.1566233484138;
 Mon, 19 Aug 2019 09:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1565188228.git.ilubashe@akamai.com> <291d2cda6ee75b4cd4c9ce717c177db18bf03a31.1565188228.git.ilubashe@akamai.com>
 <CANLsYkxZE0CQJKQ-bFi=zFV5vTCbL2v76+x1fmCpqNruqWiFXg@mail.gmail.com>
 <20190814184814.GM9280@kernel.org> <20190814185213.GN9280@kernel.org>
 <23f7b8c7616a467c93ee2c77e8ffd3cf@usma1ex-dag1mb6.msg.corp.akamai.com>
 <CANLsYkxqBcJq8QJq+aLZXQas1VBg_wGh_p5WTUuRVFCYEQWiQw@mail.gmail.com> <20190815214236.GA3929@kernel.org>
In-Reply-To: <20190815214236.GA3929@kernel.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 19 Aug 2019 10:51:12 -0600
Message-ID: <CANLsYkyPkcJWmBZzyjGj3vJRgEtuaun7HQjN1=5wcOyTPnfhmQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] perf: Use CAP_SYSLOG with kptr_restrict checks
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     "Lubashev, Igor" <ilubashe@akamai.com>,
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

On Thu, 15 Aug 2019 at 15:42, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Aug 15, 2019 at 02:16:48PM -0600, Mathieu Poirier escreveu:
> > On Wed, 14 Aug 2019 at 14:02, Lubashev, Igor <ilubashe@akamai.com> wrote:
> > >
> > > > On Wed, August 14, 2019 at 2:52 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > > > Em Wed, Aug 14, 2019 at 03:48:14PM -0300, Arnaldo Carvalho de Melo
> > > > escreveu:
> > > > > Em Wed, Aug 14, 2019 at 12:04:33PM -0600, Mathieu Poirier escreveu:
> > > > > > # echo 0 > /proc/sys/kernel/kptr_restrict # ./tools/perf/perf record
> > > > > > -e instructions:k uname
> > > > > > perf: Segmentation fault
> > > > > > Obtained 10 stack frames.
> > > > > > ./tools/perf/perf(sighandler_dump_stack+0x44) [0x55af9e5da5d4]
> > > > > > /lib/x86_64-linux-gnu/libc.so.6(+0x3ef20) [0x7fd31efb6f20]
> > > > > > ./tools/perf/perf(perf_event__synthesize_kernel_mmap+0xa7)
> > > > > > [0x55af9e590337]
> > > > > > ./tools/perf/perf(+0x1cf5be) [0x55af9e50c5be]
> > > > > > ./tools/perf/perf(cmd_record+0x1022) [0x55af9e50dff2]
> > > > > > ./tools/perf/perf(+0x23f98d) [0x55af9e57c98d]
> > > > > > ./tools/perf/perf(+0x23fc9e) [0x55af9e57cc9e]
> > > > > > ./tools/perf/perf(main+0x369) [0x55af9e4f6bc9]
> > > > > > /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe7)
> > > > > > [0x7fd31ef99b97]
> > > > > > ./tools/perf/perf(_start+0x2a) [0x55af9e4f704a] Segmentation fault
> > > > > >
> > > > > > I can reproduce this on both x86 and ARM64.
> > > > >
> > > > > I don't see this with these two csets removed:
> > > > >
> > > > > 7ff5b5911144 perf symbols: Use CAP_SYSLOG with kptr_restrict checks
> > > > > d7604b66102e perf tools: Use CAP_SYS_ADMIN with perf_event_paranoid
> > > > > checks
> > > > >
> > > > > Which were the ones I guessed were related to the problem you
> > > > > reported, so they are out of my ongoing perf/core pull request to
> > > > > Ingo/Thomas, now trying with these applied and your instructions...
> > > >
> > > > Can't repro:
> > > >
> > > > [root@quaco ~]# cat /proc/sys/kernel/kptr_restrict
> > > > 0
> > > > [root@quaco ~]# perf record -e instructions:k uname Linux [ perf record:
> > > > Woken up 1 times to write data ] [ perf record: Captured and wrote 0.024 MB
> > > > perf.data (1 samples) ] [root@quaco ~]# echo 1 >
> > > > /proc/sys/kernel/kptr_restrict [root@quaco ~]# perf record -e instructions:k
> > > > uname Linux [ perf record: Woken up 1 times to write data ] [ perf record:
> > > > Captured and wrote 0.024 MB perf.data (1 samples) ] [root@quaco ~]# echo
> > > > 0 > /proc/sys/kernel/kptr_restrict [root@quaco ~]# perf record -e
> > > > instructions:k uname Linux [ perf record: Woken up 1 times to write data ] [
> > > > perf record: Captured and wrote 0.024 MB perf.data (1 samples) ]
> > > > [root@quaco ~]#
> > > >
> > > > [acme@quaco perf]$ git log --oneline --author Lubashev tools/
> > > > 7ff5b5911144 (HEAD -> perf/cap, acme.korg/tmp.perf/cap,
> > > > acme.korg/perf/cap) perf symbols: Use CAP_SYSLOG with kptr_restrict
> > > > checks d7604b66102e perf tools: Use CAP_SYS_ADMIN with
> > > > perf_event_paranoid checks c766f3df635d perf ftrace: Use CAP_SYS_ADMIN
> > > > instead of euid==0 c22e150e3afa perf tools: Add helpers to use capabilities if
> > > > present
> > > > 74d5f3d06f70 tools build: Add capability-related feature detection perf
> > > > version 5.3.rc4.g7ff5b5911144 [acme@quaco perf]$
> > >
> > > I got an ARM64 cloud VM, but I cannot reproduce.
> > > # cat /proc/sys/kernel/kptr_restrict
> > > 0
> > >
> > > Perf trace works fine (does not die):
> > > # ./perf trace -a
> > >
> > > Here is my setup:
> > > Repo: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> > > Branch: tmp.perf/cap
> > > Commit: 7ff5b5911 "perf symbols: Use CAP_SYSLOG with kptr_restrict checks"
> > > gcc --version: gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
> > > uname -a: Linux arm-4-par-1 4.9.93-mainline-rev1 #1 SMP Tue Apr 10 09:54:46 UTC 2018 aarch64 aarch64 aarch64 GNU/Linux
> > > lsb_release -a: Ubuntu 18.04.3 LTS
> > >
> > > Auto-detecting system features:
> > > ...                         dwarf: [ on  ]
> > > ...            dwarf_getlocations: [ on  ]
> > > ...                         glibc: [ on  ]
> > > ...                          gtk2: [ on  ]
> > > ...                      libaudit: [ on  ]
> > > ...                        libbfd: [ on  ]
> > > ...                        libcap: [ on  ]
> > > ...                        libelf: [ on  ]
> > > ...                       libnuma: [ on  ]
> > > ...        numa_num_possible_cpus: [ on  ]
> > > ...                       libperl: [ on  ]
> > > ...                     libpython: [ on  ]
> > > ...                     libcrypto: [ on  ]
> > > ...                     libunwind: [ on  ]
> > > ...            libdw-dwarf-unwind: [ on  ]
> > > ...                          zlib: [ on  ]
> > > ...                          lzma: [ on  ]
> > > ...                     get_cpuid: [ OFF ]
> > > ...                           bpf: [ on  ]
> > > ...                        libaio: [ on  ]
> > > ...                       libzstd: [ on  ]
> > > ...        disassembler-four-args: [ on  ]
> > >
> > > I also could not reproduce on x86:
> > > lsb_release -a: Ubuntu 18.04.1 LTS
> > > gcc --version: gcc (Ubuntu 7.4.0-1ubuntu1~18.04aka10.0.0) 7.4.0
> > > uname -r: 4.4.0-154-generic
> >
> > I isolated the problem to libcap-dev - if it is not installed a
> > segmentation fault will occur.  Since this set is about using
> > capabilities it is obvious that not having it on a system should fail
> > a trace session, but it should not crash it.
>
> It shouldn't crash on x86_64:
>
> root@quaco ~]# sysctl kernel.kptr_restrict
> kernel.kptr_restrict = 0
> [root@quaco ~]# perf record -e instructions:k uname
> Linux
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.023 MB perf.data (5 samples) ]
> [root@quaco ~]# ldd ~/bin/perf | grep libcap
> [root@quaco ~]# perf -v
> perf version 5.3.rc4.g329ca330bf8b
> [root@quaco ~]#
> [acme@quaco perf]$ git log --oneline -4
> 329ca330bf8b (HEAD -> perf/cap) perf symbols: Use CAP_SYSLOG with kptr_restrict checks
> f7b9999387af perf tools: Use CAP_SYS_ADMIN with perf_event_paranoid checks
> 4d0489cf1c47 (acme.korg/tmp.perf/script-switch-on-off, perf/core) perf report: Add --switch-on/--switch-off events
> 2f53ae347f59 perf top: Add --switch-on/--switch-off events
> [acme@quaco perf]$
>
> > If libcap-dev is not installed function symbol__restricted_filename()
> > will return true, which in turn will prevent symbol_name to be set in
> > machine__get_running_kernel_start().  That prevents function
> > map__set_kallsyms_ref_reloc_sym() from being called in
> > machine__create_kernel_maps(), resulting in kmap->ref_reloc_sym being
> > NULL in _perf_event__synthesize_kernel_mmap() and a segmentation
> > fault.
>
> Can you please try with my perf/cap branch? Perhaps you're using Igor's
> original set of patches? I made changes to the fallback, he was making
> it return false while I made it fallback to geteuid() == 0, as was
> before his patches.

Things are working properly on your perf/cap branch.  I tested with on
both x86 and ARM.

Mathieu

>
> - Arnaldo
>
> > I am not sure how this can be fixed.  I counted a total of 19
> > instances where kmap->ref_reloc_sym->XYZ is called, only 2 of wich
> > care to check if kmap->ref_reloc_sym is valid before proceeding.  As
> > such I must hope that in the 17 other cases, kmap->ref_reloc_sym is
> > guaranteed to be valid.  If I am correct then all we need is to check
> > for a valid pointer in _perf_event__synthesize_kernel_mmap().
> > Otherwise it will be a little harder.
> >
> > Mathieu
>
> --
>
> - Arnaldo
