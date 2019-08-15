Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E04C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC932086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SO6Tvy4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbfHOURB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 16:17:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35606 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfHOURB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:17:01 -0400
Received: by mail-io1-f68.google.com with SMTP id i22so1727778ioh.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 13:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RzfaHuwhDPX68hBxarqniibN5HOn+nFygAl5ItvTjGo=;
        b=SO6Tvy4CDBkNn+chm2JQTQxZWZsAQJe7GproB/4MNL+bM9UY8ZBWMJzJKsyTh4Z6KI
         WR1fKoTpa3rsg3cDPBvn/tcvA7/zfMKgpu1++tXzyhlaqijlzIOX5vchXei0Zk51sRSS
         IV1O1Lm2uEmv7c7hg5VIwMpvC1btPtU6RDEuftJND0uEHbRbs+EUqzxyHdLhltNWa7sn
         92LvT5dVeU8mQDW3o+TPipx2NH5TRX3OLca71i956lUH6JKOd7USj0DvJM9+nxvOWABv
         kc2pomYHtXHuFFzrXuFWZWfLmeILmvY/kjGfUaUsDNPWDXkUaYT/dRUKvr2H8Kkwf85A
         nf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RzfaHuwhDPX68hBxarqniibN5HOn+nFygAl5ItvTjGo=;
        b=M8w5I0l/D9BS7+9Msaru9pGMKaGybs4Sxk5k6+icb7qH9sVUxxy8RrlF2E2U06/3kM
         vKJcSCCqXXenfLevC9o1ibT2YVru3DLtZLL0/2Ijf+BvpvPh2A5HfrqmVLh2f1xoYXeY
         juJKa36NvsbT93TmfY5XmbuFghylJDR7jZzTNz7LAaeoaFoTBbK+rdhJyq5He2GKor2j
         OBYuuOx2ZL4OXQKNs0MPeKgTz19c110hAIMqbbLkPsiyA8A4ORwZ0a71kqbjSEY86BEP
         LiMhY+OkiL3NuzgoduGWYPfjefMR3N/0Jx+5AW6v7eLn/OcPlxZdBHaO+Yiw/CRkg537
         bJmA==
X-Gm-Message-State: APjAAAWs7XllFwylJUUQJgC37O5zRZPaTVzFWqlByLyDfg00VVcFpuMC
        MZ0cSy3YgBsiraztne7oPMR7YpqKbtaRQfhDgHOtUw==
X-Google-Smtp-Source: APXvYqxeQrXgCvtXAIKSRlNVokN3zDssxy0pudwbzeKJzc03KH/+EFkQ4pr9nG+ubvO0IBnaLvhbl1LtDi9pEmvOJJ8=
X-Received: by 2002:a05:6638:517:: with SMTP id i23mr505221jar.71.1565900219755;
 Thu, 15 Aug 2019 13:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1565188228.git.ilubashe@akamai.com> <291d2cda6ee75b4cd4c9ce717c177db18bf03a31.1565188228.git.ilubashe@akamai.com>
 <CANLsYkxZE0CQJKQ-bFi=zFV5vTCbL2v76+x1fmCpqNruqWiFXg@mail.gmail.com>
 <20190814184814.GM9280@kernel.org> <20190814185213.GN9280@kernel.org> <23f7b8c7616a467c93ee2c77e8ffd3cf@usma1ex-dag1mb6.msg.corp.akamai.com>
In-Reply-To: <23f7b8c7616a467c93ee2c77e8ffd3cf@usma1ex-dag1mb6.msg.corp.akamai.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 15 Aug 2019 14:16:48 -0600
Message-ID: <CANLsYkxqBcJq8QJq+aLZXQas1VBg_wGh_p5WTUuRVFCYEQWiQw@mail.gmail.com>
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

On Wed, 14 Aug 2019 at 14:02, Lubashev, Igor <ilubashe@akamai.com> wrote:
>
> > On Wed, August 14, 2019 at 2:52 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > Em Wed, Aug 14, 2019 at 03:48:14PM -0300, Arnaldo Carvalho de Melo
> > escreveu:
> > > Em Wed, Aug 14, 2019 at 12:04:33PM -0600, Mathieu Poirier escreveu:
> > > > # echo 0 > /proc/sys/kernel/kptr_restrict # ./tools/perf/perf record
> > > > -e instructions:k uname
> > > > perf: Segmentation fault
> > > > Obtained 10 stack frames.
> > > > ./tools/perf/perf(sighandler_dump_stack+0x44) [0x55af9e5da5d4]
> > > > /lib/x86_64-linux-gnu/libc.so.6(+0x3ef20) [0x7fd31efb6f20]
> > > > ./tools/perf/perf(perf_event__synthesize_kernel_mmap+0xa7)
> > > > [0x55af9e590337]
> > > > ./tools/perf/perf(+0x1cf5be) [0x55af9e50c5be]
> > > > ./tools/perf/perf(cmd_record+0x1022) [0x55af9e50dff2]
> > > > ./tools/perf/perf(+0x23f98d) [0x55af9e57c98d]
> > > > ./tools/perf/perf(+0x23fc9e) [0x55af9e57cc9e]
> > > > ./tools/perf/perf(main+0x369) [0x55af9e4f6bc9]
> > > > /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe7)
> > > > [0x7fd31ef99b97]
> > > > ./tools/perf/perf(_start+0x2a) [0x55af9e4f704a] Segmentation fault
> > > >
> > > > I can reproduce this on both x86 and ARM64.
> > >
> > > I don't see this with these two csets removed:
> > >
> > > 7ff5b5911144 perf symbols: Use CAP_SYSLOG with kptr_restrict checks
> > > d7604b66102e perf tools: Use CAP_SYS_ADMIN with perf_event_paranoid
> > > checks
> > >
> > > Which were the ones I guessed were related to the problem you
> > > reported, so they are out of my ongoing perf/core pull request to
> > > Ingo/Thomas, now trying with these applied and your instructions...
> >
> > Can't repro:
> >
> > [root@quaco ~]# cat /proc/sys/kernel/kptr_restrict
> > 0
> > [root@quaco ~]# perf record -e instructions:k uname Linux [ perf record:
> > Woken up 1 times to write data ] [ perf record: Captured and wrote 0.024 MB
> > perf.data (1 samples) ] [root@quaco ~]# echo 1 >
> > /proc/sys/kernel/kptr_restrict [root@quaco ~]# perf record -e instructions:k
> > uname Linux [ perf record: Woken up 1 times to write data ] [ perf record:
> > Captured and wrote 0.024 MB perf.data (1 samples) ] [root@quaco ~]# echo
> > 0 > /proc/sys/kernel/kptr_restrict [root@quaco ~]# perf record -e
> > instructions:k uname Linux [ perf record: Woken up 1 times to write data ] [
> > perf record: Captured and wrote 0.024 MB perf.data (1 samples) ]
> > [root@quaco ~]#
> >
> > [acme@quaco perf]$ git log --oneline --author Lubashev tools/
> > 7ff5b5911144 (HEAD -> perf/cap, acme.korg/tmp.perf/cap,
> > acme.korg/perf/cap) perf symbols: Use CAP_SYSLOG with kptr_restrict
> > checks d7604b66102e perf tools: Use CAP_SYS_ADMIN with
> > perf_event_paranoid checks c766f3df635d perf ftrace: Use CAP_SYS_ADMIN
> > instead of euid==0 c22e150e3afa perf tools: Add helpers to use capabilities if
> > present
> > 74d5f3d06f70 tools build: Add capability-related feature detection perf
> > version 5.3.rc4.g7ff5b5911144 [acme@quaco perf]$
>
> I got an ARM64 cloud VM, but I cannot reproduce.
> # cat /proc/sys/kernel/kptr_restrict
> 0
>
> Perf trace works fine (does not die):
> # ./perf trace -a
>
> Here is my setup:
> Repo: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> Branch: tmp.perf/cap
> Commit: 7ff5b5911 "perf symbols: Use CAP_SYSLOG with kptr_restrict checks"
> gcc --version: gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
> uname -a: Linux arm-4-par-1 4.9.93-mainline-rev1 #1 SMP Tue Apr 10 09:54:46 UTC 2018 aarch64 aarch64 aarch64 GNU/Linux
> lsb_release -a: Ubuntu 18.04.3 LTS
>
> Auto-detecting system features:
> ...                         dwarf: [ on  ]
> ...            dwarf_getlocations: [ on  ]
> ...                         glibc: [ on  ]
> ...                          gtk2: [ on  ]
> ...                      libaudit: [ on  ]
> ...                        libbfd: [ on  ]
> ...                        libcap: [ on  ]
> ...                        libelf: [ on  ]
> ...                       libnuma: [ on  ]
> ...        numa_num_possible_cpus: [ on  ]
> ...                       libperl: [ on  ]
> ...                     libpython: [ on  ]
> ...                     libcrypto: [ on  ]
> ...                     libunwind: [ on  ]
> ...            libdw-dwarf-unwind: [ on  ]
> ...                          zlib: [ on  ]
> ...                          lzma: [ on  ]
> ...                     get_cpuid: [ OFF ]
> ...                           bpf: [ on  ]
> ...                        libaio: [ on  ]
> ...                       libzstd: [ on  ]
> ...        disassembler-four-args: [ on  ]
>
> I also could not reproduce on x86:
> lsb_release -a: Ubuntu 18.04.1 LTS
> gcc --version: gcc (Ubuntu 7.4.0-1ubuntu1~18.04aka10.0.0) 7.4.0
> uname -r: 4.4.0-154-generic

I isolated the problem to libcap-dev - if it is not installed a
segmentation fault will occur.  Since this set is about using
capabilities it is obvious that not having it on a system should fail
a trace session, but it should not crash it.

If libcap-dev is not installed function symbol__restricted_filename()
will return true, which in turn will prevent symbol_name to be set in
machine__get_running_kernel_start().  That prevents function
map__set_kallsyms_ref_reloc_sym() from being called in
machine__create_kernel_maps(), resulting in kmap->ref_reloc_sym being
NULL in _perf_event__synthesize_kernel_mmap() and a segmentation
fault.

I am not sure how this can be fixed.  I counted a total of 19
instances where kmap->ref_reloc_sym->XYZ is called, only 2 of wich
care to check if kmap->ref_reloc_sym is valid before proceeding.  As
such I must hope that in the 17 other cases, kmap->ref_reloc_sym is
guaranteed to be valid.  If I am correct then all we need is to check
for a valid pointer in _perf_event__synthesize_kernel_mmap().
Otherwise it will be a little harder.

Mathieu
