Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C2DC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 21:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05752086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 21:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUOFMUJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbfHOVmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 17:42:42 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44930 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbfHOVml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 17:42:41 -0400
Received: by mail-qt1-f194.google.com with SMTP id 44so3929450qtg.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 14:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pqnw68C8RNt8CVX8dl8gN5I3loi0jS1XviHSDg/bmq4=;
        b=HUOFMUJTlZDhVVYDQTGfRsJTGMXifpjbukBHf1Zyd8mkM9gqnivlbAQkJeAItRR+j8
         s+OdJCasetNj2tP7QHq/oZfkDiihoDJZr8qBWc5chr9pPtGJf+uZz96MOYDdthD9ILyX
         //sTgQwWTAaZCk9GBHH+/A168HSp7F09hbqKV09IvErz58808Np7XYLSlfqbmDbL2O84
         ORaRk8FkKALRgCZ9TCSEB9nqCl0tiaI3lM2f5P97kKf5aSayo3jDj0/XjsqnVgERqWGT
         k0Kda9kXCQ3yYUFD2+hKxJk9fYARxY9IKW584bJTdh+EvlUK2udKAvJQG2gtMXsKg6Zt
         PkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pqnw68C8RNt8CVX8dl8gN5I3loi0jS1XviHSDg/bmq4=;
        b=RmRjPZB0KauO4cB3po1gPsm/NC3x/lK9cGj8LKoVYRuJcA+pz7zysL7yYQuVenGB0w
         xht3b3EpIdbkh2mAn/Nwc+YMPy8v0m6xxGn1Zxw/t49jYgnjnJhno0Uk68Lb6NoGTb/K
         6wsMRNP23PEQwG4ljOJtyC6MSXmFpbRqBJzTKEpNmymep4taji6BLI3kdyP8XPvZVQ2g
         C26ggLsWmIwerY13NQxZFF4kcs09SiFEZLUM3uWcismVrxK1nBvJnTVV/mWLh7uRTnRh
         +pBp/kEq/hZGqW2dhoh1Q8vgWYE+FcW+4veiFjFpCj0snq4HBf4+vlEGI19LeypHRjld
         Mk8g==
X-Gm-Message-State: APjAAAV0ZXVuNJ1pY5EoENo7M2mKb16WaoYvnJvwivTkliq8jd91rWcf
        8rR5/6NAJRiC2979AvjOcPRw950G
X-Google-Smtp-Source: APXvYqxZs48dlQG+JiotkeYLCXJ0AymdOH7p6h2lbvCQDI2DDFmyPoZytKoV1pBR8sARa5BSpsXGiA==
X-Received: by 2002:ac8:525a:: with SMTP id y26mr5857174qtn.378.1565905360355;
        Thu, 15 Aug 2019 14:42:40 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.135.11.83])
        by smtp.gmail.com with ESMTPSA id v192sm2064270qka.74.2019.08.15.14.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 14:42:39 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 12B1A40858; Thu, 15 Aug 2019 18:42:36 -0300 (-03)
Date:   Thu, 15 Aug 2019 18:42:36 -0300
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     "Lubashev, Igor" <ilubashe@akamai.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
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
Subject: Re: [PATCH v3 3/4] perf: Use CAP_SYSLOG with kptr_restrict checks
Message-ID: <20190815214236.GA3929@kernel.org>
References: <cover.1565188228.git.ilubashe@akamai.com>
 <291d2cda6ee75b4cd4c9ce717c177db18bf03a31.1565188228.git.ilubashe@akamai.com>
 <CANLsYkxZE0CQJKQ-bFi=zFV5vTCbL2v76+x1fmCpqNruqWiFXg@mail.gmail.com>
 <20190814184814.GM9280@kernel.org>
 <20190814185213.GN9280@kernel.org>
 <23f7b8c7616a467c93ee2c77e8ffd3cf@usma1ex-dag1mb6.msg.corp.akamai.com>
 <CANLsYkxqBcJq8QJq+aLZXQas1VBg_wGh_p5WTUuRVFCYEQWiQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkxqBcJq8QJq+aLZXQas1VBg_wGh_p5WTUuRVFCYEQWiQw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 15, 2019 at 02:16:48PM -0600, Mathieu Poirier escreveu:
> On Wed, 14 Aug 2019 at 14:02, Lubashev, Igor <ilubashe@akamai.com> wrote:
> >
> > > On Wed, August 14, 2019 at 2:52 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > > Em Wed, Aug 14, 2019 at 03:48:14PM -0300, Arnaldo Carvalho de Melo
> > > escreveu:
> > > > Em Wed, Aug 14, 2019 at 12:04:33PM -0600, Mathieu Poirier escreveu:
> > > > > # echo 0 > /proc/sys/kernel/kptr_restrict # ./tools/perf/perf record
> > > > > -e instructions:k uname
> > > > > perf: Segmentation fault
> > > > > Obtained 10 stack frames.
> > > > > ./tools/perf/perf(sighandler_dump_stack+0x44) [0x55af9e5da5d4]
> > > > > /lib/x86_64-linux-gnu/libc.so.6(+0x3ef20) [0x7fd31efb6f20]
> > > > > ./tools/perf/perf(perf_event__synthesize_kernel_mmap+0xa7)
> > > > > [0x55af9e590337]
> > > > > ./tools/perf/perf(+0x1cf5be) [0x55af9e50c5be]
> > > > > ./tools/perf/perf(cmd_record+0x1022) [0x55af9e50dff2]
> > > > > ./tools/perf/perf(+0x23f98d) [0x55af9e57c98d]
> > > > > ./tools/perf/perf(+0x23fc9e) [0x55af9e57cc9e]
> > > > > ./tools/perf/perf(main+0x369) [0x55af9e4f6bc9]
> > > > > /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe7)
> > > > > [0x7fd31ef99b97]
> > > > > ./tools/perf/perf(_start+0x2a) [0x55af9e4f704a] Segmentation fault
> > > > >
> > > > > I can reproduce this on both x86 and ARM64.
> > > >
> > > > I don't see this with these two csets removed:
> > > >
> > > > 7ff5b5911144 perf symbols: Use CAP_SYSLOG with kptr_restrict checks
> > > > d7604b66102e perf tools: Use CAP_SYS_ADMIN with perf_event_paranoid
> > > > checks
> > > >
> > > > Which were the ones I guessed were related to the problem you
> > > > reported, so they are out of my ongoing perf/core pull request to
> > > > Ingo/Thomas, now trying with these applied and your instructions...
> > >
> > > Can't repro:
> > >
> > > [root@quaco ~]# cat /proc/sys/kernel/kptr_restrict
> > > 0
> > > [root@quaco ~]# perf record -e instructions:k uname Linux [ perf record:
> > > Woken up 1 times to write data ] [ perf record: Captured and wrote 0.024 MB
> > > perf.data (1 samples) ] [root@quaco ~]# echo 1 >
> > > /proc/sys/kernel/kptr_restrict [root@quaco ~]# perf record -e instructions:k
> > > uname Linux [ perf record: Woken up 1 times to write data ] [ perf record:
> > > Captured and wrote 0.024 MB perf.data (1 samples) ] [root@quaco ~]# echo
> > > 0 > /proc/sys/kernel/kptr_restrict [root@quaco ~]# perf record -e
> > > instructions:k uname Linux [ perf record: Woken up 1 times to write data ] [
> > > perf record: Captured and wrote 0.024 MB perf.data (1 samples) ]
> > > [root@quaco ~]#
> > >
> > > [acme@quaco perf]$ git log --oneline --author Lubashev tools/
> > > 7ff5b5911144 (HEAD -> perf/cap, acme.korg/tmp.perf/cap,
> > > acme.korg/perf/cap) perf symbols: Use CAP_SYSLOG with kptr_restrict
> > > checks d7604b66102e perf tools: Use CAP_SYS_ADMIN with
> > > perf_event_paranoid checks c766f3df635d perf ftrace: Use CAP_SYS_ADMIN
> > > instead of euid==0 c22e150e3afa perf tools: Add helpers to use capabilities if
> > > present
> > > 74d5f3d06f70 tools build: Add capability-related feature detection perf
> > > version 5.3.rc4.g7ff5b5911144 [acme@quaco perf]$
> >
> > I got an ARM64 cloud VM, but I cannot reproduce.
> > # cat /proc/sys/kernel/kptr_restrict
> > 0
> >
> > Perf trace works fine (does not die):
> > # ./perf trace -a
> >
> > Here is my setup:
> > Repo: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> > Branch: tmp.perf/cap
> > Commit: 7ff5b5911 "perf symbols: Use CAP_SYSLOG with kptr_restrict checks"
> > gcc --version: gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
> > uname -a: Linux arm-4-par-1 4.9.93-mainline-rev1 #1 SMP Tue Apr 10 09:54:46 UTC 2018 aarch64 aarch64 aarch64 GNU/Linux
> > lsb_release -a: Ubuntu 18.04.3 LTS
> >
> > Auto-detecting system features:
> > ...                         dwarf: [ on  ]
> > ...            dwarf_getlocations: [ on  ]
> > ...                         glibc: [ on  ]
> > ...                          gtk2: [ on  ]
> > ...                      libaudit: [ on  ]
> > ...                        libbfd: [ on  ]
> > ...                        libcap: [ on  ]
> > ...                        libelf: [ on  ]
> > ...                       libnuma: [ on  ]
> > ...        numa_num_possible_cpus: [ on  ]
> > ...                       libperl: [ on  ]
> > ...                     libpython: [ on  ]
> > ...                     libcrypto: [ on  ]
> > ...                     libunwind: [ on  ]
> > ...            libdw-dwarf-unwind: [ on  ]
> > ...                          zlib: [ on  ]
> > ...                          lzma: [ on  ]
> > ...                     get_cpuid: [ OFF ]
> > ...                           bpf: [ on  ]
> > ...                        libaio: [ on  ]
> > ...                       libzstd: [ on  ]
> > ...        disassembler-four-args: [ on  ]
> >
> > I also could not reproduce on x86:
> > lsb_release -a: Ubuntu 18.04.1 LTS
> > gcc --version: gcc (Ubuntu 7.4.0-1ubuntu1~18.04aka10.0.0) 7.4.0
> > uname -r: 4.4.0-154-generic
> 
> I isolated the problem to libcap-dev - if it is not installed a
> segmentation fault will occur.  Since this set is about using
> capabilities it is obvious that not having it on a system should fail
> a trace session, but it should not crash it.

It shouldn't crash on x86_64:

root@quaco ~]# sysctl kernel.kptr_restrict
kernel.kptr_restrict = 0
[root@quaco ~]# perf record -e instructions:k uname
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.023 MB perf.data (5 samples) ]
[root@quaco ~]# ldd ~/bin/perf | grep libcap
[root@quaco ~]# perf -v
perf version 5.3.rc4.g329ca330bf8b
[root@quaco ~]#
[acme@quaco perf]$ git log --oneline -4
329ca330bf8b (HEAD -> perf/cap) perf symbols: Use CAP_SYSLOG with kptr_restrict checks
f7b9999387af perf tools: Use CAP_SYS_ADMIN with perf_event_paranoid checks
4d0489cf1c47 (acme.korg/tmp.perf/script-switch-on-off, perf/core) perf report: Add --switch-on/--switch-off events
2f53ae347f59 perf top: Add --switch-on/--switch-off events
[acme@quaco perf]$
 
> If libcap-dev is not installed function symbol__restricted_filename()
> will return true, which in turn will prevent symbol_name to be set in
> machine__get_running_kernel_start().  That prevents function
> map__set_kallsyms_ref_reloc_sym() from being called in
> machine__create_kernel_maps(), resulting in kmap->ref_reloc_sym being
> NULL in _perf_event__synthesize_kernel_mmap() and a segmentation
> fault.

Can you please try with my perf/cap branch? Perhaps you're using Igor's
original set of patches? I made changes to the fallback, he was making
it return false while I made it fallback to geteuid() == 0, as was
before his patches.

- Arnaldo
 
> I am not sure how this can be fixed.  I counted a total of 19
> instances where kmap->ref_reloc_sym->XYZ is called, only 2 of wich
> care to check if kmap->ref_reloc_sym is valid before proceeding.  As
> such I must hope that in the 17 other cases, kmap->ref_reloc_sym is
> guaranteed to be valid.  If I am correct then all we need is to check
> for a valid pointer in _perf_event__synthesize_kernel_mmap().
> Otherwise it will be a little harder.
> 
> Mathieu

-- 

- Arnaldo
