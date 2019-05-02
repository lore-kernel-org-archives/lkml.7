Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA34EC04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9DF2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YF+pGmGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfEBPlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:41:39 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45715 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbfEBPlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:41:37 -0400
Received: by mail-yw1-f65.google.com with SMTP id w18so1877816ywa.12;
        Thu, 02 May 2019 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K9IyyI8mKVGbRJcQqxKVgNuye7sb0n1WK2AwTwP2rRo=;
        b=YF+pGmGLoZp7+ghF4C8Q7N2Tss5P4o08wGmim0uom5K4SyIn8H4b+wfP2fnVx8VHWX
         RxPBseZN/p6DL46DfqZx5Sdlx18dmI4MwpmnaK2rD+Igqb7MxS6RAKw1wcBPWE6OMH9C
         8eUBjSFXjjv75GzJ4MYrZ453rGtl+cIaO7M9wrXuaBbfDY3kYwuplgObuulN0VSqWwt2
         RD8ZX+u9mq/a9/8CJpRfCVO0jdk6jxPz8bVZrnqqnhd2nEUQ8keM+rHg4HFAhS+rWLmA
         2A1fkK+RE3jSJeDFTigDWzFWqnY5wZz1tjUcQajsWt1MiEIzJkawmdGv9hgsbnma/wPG
         w/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K9IyyI8mKVGbRJcQqxKVgNuye7sb0n1WK2AwTwP2rRo=;
        b=R9m0/+3SymYBdMaeFwKTYLQVH+4B3aNTtzjJUUQZVUE6x/62a88rkup4DhsQRxyXQm
         R6FurN8+dlw28Ji5tDqxUAi40SuObi3HL+xGnHkdxcOxFvq5ZHLX6x4e2wxX7srfTM3a
         T/uJHVJ0rdJMgSN16m8ht9YJFZhdJdWINHR3h3dYzV/563dGlpDNy12+S0hc4OTFf6+I
         e3SsgqKzWAiHmD1NN/sGgfWOJqpjd8X/4I0v1jfQhRD+6Khu7RPjuzp4td0l2mmb2cdu
         KihZCUSxZTRoWD6/gDJSsYbKVXU8+yiNGOblw2zjvDH1rNpB8sUclKfnaSk001ZKtPjq
         utBw==
X-Gm-Message-State: APjAAAV8bwwfBkWA2LUB76iYDKjNQc+zHtK2rui3qGk58/t+I2oyyHiL
        ai2oTrFDBqVQTNto8JhK7aQ=
X-Google-Smtp-Source: APXvYqwiRgsTjsFuOVB3vmG5LJRaOnkGq/VQe3vEhQq3Y727DP0TTuOb1sBqT/sS0AMt8oyEAqIchQ==
X-Received: by 2002:a0d:fc85:: with SMTP id m127mr3712600ywf.346.1556811696112;
        Thu, 02 May 2019 08:41:36 -0700 (PDT)
Received: from quaco.ghostprotocols.net (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id c205sm13511824ywc.10.2019.05.02.08.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 08:41:35 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2D8B5403AD; Thu,  2 May 2019 11:41:34 -0400 (EDT)
Date:   Thu, 2 May 2019 11:41:34 -0400
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Subject: Re: perf tools build broken after v5.1-rc1
Message-ID: <20190502154134.GA23984@kernel.org>
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
 <20190422152027.GB11750@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A250584C@us01wembx1.internal.synopsys.com>
 <CAK8P3a2JrAApXDws+t=q8AnKFkHJZSox7gsgwW-xEJTfs_mdzw@mail.gmail.com>
 <20190501204115.GF21436@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A2506BF3@us01wembx1.internal.synopsys.com>
 <20190502143618.GH21436@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502143618.GH21436@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 02, 2019 at 10:36:18AM -0400, Arnaldo Carvalho de Melo escreveu:
> Em Wed, May 01, 2019 at 09:17:52PM +0000, Vineet Gupta escreveu:
> > On 5/1/19 1:41 PM, Arnaldo Carvalho de Melo wrote:
> > >> The 1a787fc5ba18ac7 commit copied over the changes for arm64, but
> > >> missed all the other architectures changed in c8ce48f06503 and the
> > >> related commits.
> > > Right, I have a patch copying the missing headers, and that fixed the
> > > build with the glibc-based toolchain, but then broke the uCLibc one :-\
>  
> > tools/perf/util/cloexec.c  #includes <sys/syscall.h> which for glibc includes
> > asm/unistd.h
>  
> > uClibc <sys/syscall.h> OTOH #include <bits/sysnum.h> containign#define __NR_*
> > (generated by parsing kernel's unistd). This header does the right thing by
> > chekcing for redefs, but in the end we still collide with newly added
> > tools/arc/arc/*/**/unistd.h which doesn't have conditional definitions. I'm sure
> > this is not an ARC problem, any uClibc build would be affected. Do you have a arm
> > uclibc toolchain to test ?
> 
> This solves it for fedora:29,
> arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install,
> arc_gnu_2019.03-rc1_prebuilt_uclibc_le_archs_linux_install and
> arc_gnu_2019.03-rc1_prebuilt_glibc_le_archs_linux_install.
> 
> Also ok with:
> 
>   make -C tools/perf build-test
> 
> Now build testing with the full set of containers.

So far, and the alpine ones use musl libc:

[perfbuilder@quaco ~]$ export PERF_TARBALL=http://192.168.124.1/perf/perf-5.1.0-rc6.tar.xz
[perfbuilder@quaco ~]$ time dm
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   6 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0
   7 alpine:edge                   : Ok   gcc (Alpine 8.3.0) 8.3.0
   8 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
   9 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  10 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  11 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  12 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  13 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36)
  14 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2
  15 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  16 debian:experimental           : Ok   gcc (Debian 8.3.0-6) 8.3.0
  17 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.3.0-4) 8.3.0
  18 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.3.0-4) 8.3.0
  19 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.3.0-2) 8.3.0
  20 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.3.0-4) 8.3.0
  21 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  22 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  23 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  24 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  25 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710


- Arnaldo
