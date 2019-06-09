Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD8DC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 13:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFAB212F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 13:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ruJtE3xG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfFINTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 09:19:03 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40755 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbfFINTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 09:19:02 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so7689201qtn.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 06:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=etxGqIHWh7lXIY7Ft8zi2MkE7mqUIZh/y1UeJH95Z4A=;
        b=ruJtE3xGr+tnyKqfapDlRISInN2rP94g72KXr4/dpWyEtp7AE/rbD4oub9hFcH4Puw
         IUmn8M5EFNnDes8SLB3zECCLoNhHdqDjLLhCsQg9yQav0ZuuPU13WD73pvQDZtgSB+wX
         TZ+TgwC3mf78ZkilCO+V6SzAgwqei+ob1AS4wZ/YsRV1QAbVjqFhR+87SHtj7CfkmjYo
         jDOMN82gYNmnTgXqbl4tBNNkrdSMrx0vDqcXIsdf3lYFhp+gHNHiBoIy9aovH9srteaf
         HHqXjNbxTCq61Id3ecFwmpTAzn3E1OdEPml+V3Ug8qR09V1oIqdlAywJ0W3r9/SnfRlZ
         g24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=etxGqIHWh7lXIY7Ft8zi2MkE7mqUIZh/y1UeJH95Z4A=;
        b=PiXFyWucFt5uFyvjEHL/QceXYfokwYbNzCwZqWjDndsmettpdKeHlcar/VQVxIPAGK
         7YAMT28O+Ghvt4pVyh9H5W9NM6CkB2zi7Jvc+GW1JKZwY7MuxNhTBVZ2tmxtW5IvDojA
         YPUuNXtHe8U60A0t4Z4lt9MzXeSo2uau1LMVHVQFWGvC2ZenIviInh9vlbyuiey6e33p
         NTWX7Wmre23PiT+/dmUEIdRugUeqKVQ/ibuiPrVg6p+ojRV7VsrFggwW0s8zTcA1cPPg
         9XmUmfBoqis4f4JqworsWzHIN8uAoAd00GeLe58T8739AObXoViWSB/uaVCAgQy+1nbm
         zbGg==
X-Gm-Message-State: APjAAAVD09RAWGZvjgX48TLhazecz/d6AFeZeXrONPxmSq+m9Elia2rT
        a993H3q1UJhGA94wqM/rmSL8og==
X-Google-Smtp-Source: APXvYqy1L8DH3xHracVgoI5HWVB9bV7DzOm+SWwRyVa2hn74Yz+jgsPa9pMJnVAg22aimidyOekenQ==
X-Received: by 2002:a0c:d003:: with SMTP id u3mr40252953qvg.112.1560086341257;
        Sun, 09 Jun 2019 06:19:01 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id y8sm4397406qth.22.2019.06.09.06.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Jun 2019 06:19:00 -0700 (PDT)
Date:   Sun, 9 Jun 2019 21:18:49 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2 3/4] perf augmented_raw_syscalls: Support arm64 raw
 syscalls
Message-ID: <20190609131849.GB6357@leoy-ThinkPad-X240s>
References: <20190606094845.4800-1-leo.yan@linaro.org>
 <20190606094845.4800-4-leo.yan@linaro.org>
 <20190606133838.GC30166@kernel.org>
 <20190606141231.GC5970@leoy-ThinkPad-X240s>
 <20190606144412.GC21245@kernel.org>
 <20190607095831.GG5970@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607095831.GG5970@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 05:58:31PM +0800, Leo Yan wrote:
> Hi Arnaldo,
> 
> On Thu, Jun 06, 2019 at 11:44:12AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Jun 06, 2019 at 10:12:31PM +0800, Leo Yan escreveu:
> > > Hi Arnaldo,
> > > 
> > > On Thu, Jun 06, 2019 at 10:38:38AM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Em Thu, Jun 06, 2019 at 05:48:44PM +0800, Leo Yan escreveu:
> > > > > This patch adds support for arm64 raw syscall numbers so that we can use
> > > > > it on arm64 platform.
> > > > > 
> > > > > After applied this patch, we need to specify macro -D__aarch64__ or
> > > > > -D__x86_64__ in compilation option so Clang can use the corresponding
> > > > > syscall numbers for arm64 or x86_64 respectively, other architectures
> > > > > will report failure when compilation.
> > > > 
> > > > So, please check what I have in my perf/core branch, I've completely
> > > > removed arch specific stuff from augmented_raw_syscalls.c.
> > > > 
> > > > What is done now is use a map to specify what to copy, that same map
> > > > that is used to state which syscalls should be traced.
> > > > 
> > > > It uses that tools/perf/arch/arm64/entry/syscalls/mksyscalltbl to figure
> > > > out the mapping of syscall names to ids, just like is done for x86_64
> > > > and other arches, falling back to audit-libs when that syscalltbl thing
> > > > is not present.
> > > 
> > > Actually I have noticed mksyscalltbl has been enabled for arm64, and
> > > had to say your approach is much better :)
> > > 
> > > Thanks for the info and I will try your patch at my side.
> > 
> > That is excellent news! I'm eager to hear from you if this perf+BPF
> > integration experiment works for arm64.
> 
> I tested with the lastest perf/core branch which contains the patch:
> 'perf augmented_raw_syscalls: Tell which args are filenames and how
> many bytes to copy' and got the error as below:
> 
> # perf trace -e string -e /mnt/linux-kernel/linux-cs-dev/tools/perf/examples/bpf/augmented_raw_syscalls.c
> Error:  Invalid syscall access, chmod, chown, creat, futimesat, lchown, link, lstat, mkdir, mknod, newfstatat, open, readlink, rename,
> rmdir, stat, statfs, symlink, truncate, unlink
> Hint:   try 'perf list syscalls:sys_enter_*'
> Hint:   and: 'man syscalls'
> 
> So seems mksyscalltbl has not included completely for syscalls, I
> use below command to generate syscalltbl_arm64[] array and it don't
> include related entries for access, chmod, chown, etc ...
> 
> You could refer the generated syscalltbl_arm64 in:
> http://paste.ubuntu.com/p/8Bj7Jkm2mP/

After digging into this issue on Arm64, below is summary info:

- arm64 uses the header include/uapi/linux/unistd.h to define system
  call numbers, in this header some system calls are not defined (I
  think the reason is these system calls are obsolete at the end) so the
  corresponding strings are missed in the array syscalltbl_native,
  for arm64 the array is defined in the file:
  tools/perf/arch/arm64/include/generated/asm/syscalls.c.

  On the other hand, the file tools/perf/trace/strace/groups/string
  stores the required system call strings, these system call strings
  are based on x86_64 platform but not for arm64, the strings mismatch
  with the system call defined in the array syscalltbl_native.  This
  is the reason why reports the fail: "Error:  Invalid syscall access,
  chmod, chown, creat, futimesat, lchown, link, lstat, mkdir, mknod,
  newfstatat, open, readlink, rename, rmdir, stat, statfs, symlink,
  truncate, unlink".

  I tried to manually remove these reported strings from
  tools/perf/trace/strace/groups/string, then 'perf trace' can work
  well.

  But I don't know what's a good way to proceed.  Seems to me, we can
  create a dedicated string file
  tools/perf/trace/strace/groups/uapi_string which can be used to
  match with system calls definitions in include/uapi/linux/unistd.h.
  If there have other more general methods, will be great.

- As a side topic, arm64 also supports aarch32 compat system call
  which are defined in header arch/arm64/include/asm/unistd32.h.

  For either aarch64 or aarch32 system call, both of them finally will
  invoke function el0_svc_common() to handle system call [1].  But so
  far we don't distinguish the system call numbers is for aarch64 or
  aarch32 and always consider it's aarch64 system call.

  I think we can set an extra bit (e.g. use the 16th bit in 32 bits
  signed int) to indicate it's a aarch32 compat system call, but not
  sure if this is general method or not.

  Maybe there have existed solution in other architectures for this,
  especially other platforms also should support 32 bits and 64 bits
  system calls along with the architecture evoluation, so want to
  inquiry firstly to avoid duplicate works.

Thanks a lot for suggestions!
Leo.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kernel/syscall.c#n93
