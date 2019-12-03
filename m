Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448B0C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D85206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gejj9Eql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfLCSgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 13:36:31 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38891 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfLCSga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 13:36:30 -0500
Received: by mail-qk1-f195.google.com with SMTP id b8so4466071qkk.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 10:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iIghzkTJDXhOtS2BqafSdKFWhwqyAcUqruKZBs39zss=;
        b=gejj9Eql6fbFKy89IMDnfzf1/A/zmvL8yysZfMsRmFZ/d/ICp7UJHo0cJZpbOJgzW0
         D+Ggp1f8jM6/SSY2Mt2qHFgD3uCn6WiOZNSYJgEkSVK8IvcAJxVE7b2Y1PA1mAmgchpN
         XF3nha63iK4asZE3VgCInBY7jM2VtsH+Q4RRgqjG/6CzJuBdKVYIQSmjEVqi+3BvJIKs
         l0uAqYrJFp1+iYvhRxG/MbhrQ6n77OwZz08TEvacFqeudF2yM9w/WsE27CGt1Z6xfdnr
         kFHncAfOpClgkV/hgbRNxD3IeUSErvQIXVviirAgqMc96eHWBxRxrycqhTdMVaZMhhNS
         Yizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iIghzkTJDXhOtS2BqafSdKFWhwqyAcUqruKZBs39zss=;
        b=BlAZ7vJdnmQ5dOR1vDmXwRpIffmal1EVZp48ALEjNv7q3SHKNJ3V1AUb2OgABvildq
         2OzbijIyXORKZToB6UJ9nWevMm/OutngUf7iZ35iTgvrbEKz//kFJDnngTrqCkLihtJc
         BjtoglT4u3uujmfWHAwhbGePEkX9ecW/CjlY7Nq3wx84DQJ12NXbAkAcbLW0kbjzEx2R
         6aXsdKIdytGPuL7K1q9mVwM8NiyTxqnaPtPDG3YLxSPVgoTS/Tpcr+g/FXeJkxDhOCzV
         ZcS03EhiJjWRRRp3byaXprZvAAH2zOTYUJ6yrx2OwfiiOhr13E4PTkxUGHjRjsLxxTgq
         uQOw==
X-Gm-Message-State: APjAAAUwY4JVafjpoEe8ibY0gqYMU7vqNkXQwgPQwsYax+wATC3w7/cj
        8RGlcngqr6MrEFAGeOKED6g=
X-Google-Smtp-Source: APXvYqySIQ7G7lJXvdtqqNbGIVDLqv36K8SLQ/7D7kv+rAQKEwgcC6I8+vLhWVAgl7JJKFnwun5nLQ==
X-Received: by 2002:ae9:e30e:: with SMTP id v14mr6482602qkf.344.1575398189053;
        Tue, 03 Dec 2019 10:36:29 -0800 (PST)
Received: from quaco.ghostprotocols.net (187-26-220-133.3g.claro.net.br. [187.26.220.133])
        by smtp.gmail.com with ESMTPSA id y200sm2210531qkb.1.2019.12.03.10.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 10:36:27 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CA858405B6; Tue,  3 Dec 2019 15:36:23 -0300 (-03)
Date:   Tue, 3 Dec 2019 15:36:23 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/3] perf record: adapt NUMA awareness to machines
 with #CPUs > 1K
Message-ID: <20191203183623.GA3290@kernel.org>
References: <d1aead99-474a-46d3-36be-36dbb8e5581b@linux.intel.com>
 <20191203121745.GA14125@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203121745.GA14125@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 03, 2019 at 01:17:45PM +0100, Jiri Olsa escreveu:
> On Tue, Dec 03, 2019 at 02:41:29PM +0300, Alexey Budankov wrote:
> > 
> > Current implementation of cpu_set_t type by glibc has internal cpu
> > mask size limitation of no more than 1024 CPUs. This limitation confines
> > NUMA awareness of Perf tool in record mode, thru --affinity option,
> > to the first 1024 CPUs on machines with larger amount of CPUs.
> > 
> > This patch set enables Perf tool to overcome 1024 CPUs limitation by
> > using a dedicated struct mmap_cpu_mask type and applying tool's bitmap
> > API operations to manipulate affinity masks of the tool's thread and
> > the mmaped data buffers.
> > 
> > tools bitmap API has been extended with bitmap_free() function and
> > bitmap_equal() operation whose implementation is derived from the
> > kernel one.
> > 
> > ---
> > Changes in v5:
> > - avoided allocation of mmap affinity masks in case of 
> >   rec->opts.affinity == PERF_AFFINITY_SYS
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Applied to my local perf/core branch, going thru tests.

- Arnaldo
 
> thanks,
> jirka
> 
> > Changes in v4:
> > - renamed perf_mmap__print_cpu_mask() to mmap_cpu_mask__scnprintf()
> > - avoided checking mask bits for NULL prior calling bitmask_free()
> > - avoided thread affinity mask allocation for case of 
> >   rec->opts.affinity == PERF_AFFINITY_SYS
> > Changes in v3:
> > - implemented perf_mmap__print_cpu_mask() function
> > - use perf_mmap__print_cpu_mask() to log thread and mmap cpus masks
> >   when verbose level is equal to 2
> > Changes in v2:
> > - implemented bitmap_free() for symmetry with bitmap_alloc()
> > - capitalized MMAP_CPU_MASK_BYTES() macro
> > - returned -1 from perf_mmap__setup_affinity_mask()
> > - implemented releasing of masks using bitmap_free()
> > - moved debug printing under -vv option
> > 
> > ---
> > Alexey Budankov (3):
> >   tools bitmap: implement bitmap_equal() operation at bitmap API
> >   perf mmap: declare type for cpu mask of arbitrary length
> >   perf record: adapt affinity to machines with #CPUs > 1K
> > 
> >  tools/include/linux/bitmap.h | 30 +++++++++++++++++++++++++++
> >  tools/lib/bitmap.c           | 15 ++++++++++++++
> >  tools/perf/builtin-record.c  | 28 +++++++++++++++++++------
> >  tools/perf/util/mmap.c       | 40 ++++++++++++++++++++++++++++++------
> >  tools/perf/util/mmap.h       | 13 +++++++++++-
> >  5 files changed, 113 insertions(+), 13 deletions(-)
> > 
> > ---
> > Validation:
> > 
> > # tools/perf/perf record -vv -- ls
> > Using CPUID GenuineIntel-6-5E-3
> > intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
> > nr_cblocks: 0
> > affinity: SYS
> > mmap flush: 1
> > comp level: 0
> > ------------------------------------------------------------
> > perf_event_attr:
> >   size                             120
> >   { sample_period, sample_freq }   4000
> >   sample_type                      IP|TID|TIME|PERIOD
> >   read_format                      ID
> >   disabled                         1
> >   inherit                          1
> >   mmap                             1
> >   comm                             1
> >   freq                             1
> >   enable_on_exec                   1
> >   task                             1
> >   precise_ip                       3
> >   sample_id_all                    1
> >   exclude_guest                    1
> >   mmap2                            1
> >   comm_exec                        1
> >   ksymbol                          1
> >   bpf_event                        1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid 23718  cpu 0  group_fd -1  flags 0x8 = 4
> > sys_perf_event_open: pid 23718  cpu 1  group_fd -1  flags 0x8 = 5
> > sys_perf_event_open: pid 23718  cpu 2  group_fd -1  flags 0x8 = 6
> > sys_perf_event_open: pid 23718  cpu 3  group_fd -1  flags 0x8 = 9
> > sys_perf_event_open: pid 23718  cpu 4  group_fd -1  flags 0x8 = 10
> > sys_perf_event_open: pid 23718  cpu 5  group_fd -1  flags 0x8 = 11
> > sys_perf_event_open: pid 23718  cpu 6  group_fd -1  flags 0x8 = 12
> > sys_perf_event_open: pid 23718  cpu 7  group_fd -1  flags 0x8 = 13
> > mmap size 528384B
> > 0x7f3e06e060b8: mmap mask[8]: 
> > 0x7f3e06e16180: mmap mask[8]: 
> > 0x7f3e06e26248: mmap mask[8]: 
> > 0x7f3e06e36310: mmap mask[8]: 
> > 0x7f3e06e463d8: mmap mask[8]: 
> > 0x7f3e06e564a0: mmap mask[8]: 
> > 0x7f3e06e66568: mmap mask[8]: 
> > 0x7f3e06e76630: mmap mask[8]: 
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             1
> >   size                             120
> >   config                           0x9
> >   watermark                        1
> >   sample_id_all                    1
> >   bpf_event                        1
> >   { wakeup_events, wakeup_watermark } 1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 14
> > sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 15
> > sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 16
> > sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 17
> > sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 18
> > sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 19
> > sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 20
> > sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 21
> > mmap size 528384B
> > 0x7f3e0697d0b8: mmap mask[8]: 
> > 0x7f3e0698d180: mmap mask[8]: 
> > 0x7f3e0699d248: mmap mask[8]: 
> > 0x7f3e069ad310: mmap mask[8]: 
> > 0x7f3e069bd3d8: mmap mask[8]: 
> > 0x7f3e069cd4a0: mmap mask[8]: 
> > 0x7f3e069dd568: mmap mask[8]: 
> > 0x7f3e069ed630: mmap mask[8]: 
> > Synthesizing TSC conversion information
> > arch			      copy     Documentation  init     kernel	 MAINTAINERS	  modules.builtin.modinfo  perf.data	  scripts   System.map	vmlinux
> > block			      COPYING  drivers	      ipc      lbuild	 Makefile	  modules.order		   perf.data.old  security  tools	vmlinux.o
> > certs			      CREDITS  fs	      Kbuild   lib	 mm		  Module.symvers	   README	  sound     usr
> > config-5.2.7-100.fc29.x86_64  crypto   include	      Kconfig  LICENSES  modules.builtin  net			   samples	  stdio     virt
> > [ perf record: Woken up 1 times to write data ]
> > Looking at the vmlinux_path (8 entries long)
> > Using vmlinux for symbols
> > [ perf record: Captured and wrote 0.013 MB perf.data (8 samples) ]
> > 
> > tools/perf/perf record -vv --affinity=cpu -- ls
> > thread mask[8]: empty
> > Using CPUID GenuineIntel-6-5E-3
> > intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
> > nr_cblocks: 0
> > affinity: CPU
> > mmap flush: 1
> > comp level: 0
> > ------------------------------------------------------------
> > perf_event_attr:
> >   size                             120
> >   { sample_period, sample_freq }   4000
> >   sample_type                      IP|TID|TIME|PERIOD
> >   read_format                      ID
> >   disabled                         1
> >   inherit                          1
> >   mmap                             1
> >   comm                             1
> >   freq                             1
> >   enable_on_exec                   1
> >   task                             1
> >   precise_ip                       3
> >   sample_id_all                    1
> >   exclude_guest                    1
> >   mmap2                            1
> >   comm_exec                        1
> >   ksymbol                          1
> >   bpf_event                        1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid 23713  cpu 0  group_fd -1  flags 0x8 = 4
> > sys_perf_event_open: pid 23713  cpu 1  group_fd -1  flags 0x8 = 5
> > sys_perf_event_open: pid 23713  cpu 2  group_fd -1  flags 0x8 = 6
> > sys_perf_event_open: pid 23713  cpu 3  group_fd -1  flags 0x8 = 9
> > sys_perf_event_open: pid 23713  cpu 4  group_fd -1  flags 0x8 = 10
> > sys_perf_event_open: pid 23713  cpu 5  group_fd -1  flags 0x8 = 11
> > sys_perf_event_open: pid 23713  cpu 6  group_fd -1  flags 0x8 = 12
> > sys_perf_event_open: pid 23713  cpu 7  group_fd -1  flags 0x8 = 13
> > mmap size 528384B
> > 0x7f3e005bc0b8: mmap mask[8]: 0
> > 0x7f3e005cc180: mmap mask[8]: 1
> > 0x7f3e005dc248: mmap mask[8]: 2
> > 0x7f3e005ec310: mmap mask[8]: 3
> > 0x7f3e005fc3d8: mmap mask[8]: 4
> > 0x7f3e0060c4a0: mmap mask[8]: 5
> > 0x7f3e0061c568: mmap mask[8]: 6
> > 0x7f3e0062c630: mmap mask[8]: 7
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             1
> >   size                             120
> >   config                           0x9
> >   watermark                        1
> >   sample_id_all                    1
> >   bpf_event                        1
> >   { wakeup_events, wakeup_watermark } 1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 14
> > sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 15
> > sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 16
> > sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 17
> > sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 18
> > sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 19
> > sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 20
> > sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 21
> > mmap size 528384B
> > 0x7f3e001330b8: mmap mask[8]: 
> > 0x7f3e00143180: mmap mask[8]: 
> > 0x7f3e00153248: mmap mask[8]: 
> > 0x7f3e00163310: mmap mask[8]: 
> > 0x7f3e001733d8: mmap mask[8]: 
> > 0x7f3e001834a0: mmap mask[8]: 
> > 0x7f3e00193568: mmap mask[8]: 
> > 0x7f3e001a3630: mmap mask[8]: 
> > Synthesizing TSC conversion information
> > 0x9c9ff0: thread mask[8]: 0
> > 0x9c9ff0: thread mask[8]: 1
> > 0x9c9ff0: thread mask[8]: 2
> > 0x9c9ff0: thread mask[8]: 3
> > 0x9c9ff0: thread mask[8]: 4
> > arch			      copy     Documentation  init     kernel	 MAINTAINERS	  modules.builtin.modinfo  perf.data	  scripts   System.map	vmlinux
> > block			      COPYING  drivers	      ipc      lbuild	 Makefile	  modules.order		   perf.data.old  security  tools	vmlinux.o
> > certs			      CREDITS  fs	      Kbuild   lib	 mm		  Module.symvers	   README	  sound     usr
> > config-5.2.7-100.fc29.x86_64  crypto   include	      Kconfig  LICENSES  modules.builtin  net			   samples	  stdio     virt
> > 0x9c9ff0: thread mask[8]: 5
> > 0x9c9ff0: thread mask[8]: 6
> > 0x9c9ff0: thread mask[8]: 7
> > 0x9c9ff0: thread mask[8]: 0
> > 0x9c9ff0: thread mask[8]: 1
> > 0x9c9ff0: thread mask[8]: 2
> > 0x9c9ff0: thread mask[8]: 3
> > 0x9c9ff0: thread mask[8]: 4
> > 0x9c9ff0: thread mask[8]: 5
> > 0x9c9ff0: thread mask[8]: 6
> > 0x9c9ff0: thread mask[8]: 7
> > [ perf record: Woken up 0 times to write data ]
> > 0x9c9ff0: thread mask[8]: 0
> > 0x9c9ff0: thread mask[8]: 1
> > 0x9c9ff0: thread mask[8]: 2
> > 0x9c9ff0: thread mask[8]: 3
> > 0x9c9ff0: thread mask[8]: 4
> > 0x9c9ff0: thread mask[8]: 5
> > 0x9c9ff0: thread mask[8]: 6
> > 0x9c9ff0: thread mask[8]: 7
> > Looking at the vmlinux_path (8 entries long)
> > Using vmlinux for symbols
> > ...
> > [ perf record: Captured and wrote 0.013 MB perf.data (10 samples) ]
> > 

-- 

- Arnaldo
