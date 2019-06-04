Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73EFC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7849223B41
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmNPKYI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfFDOMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:12:25 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33701 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfFDOMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:12:25 -0400
Received: by mail-qk1-f194.google.com with SMTP id r6so2913702qkc.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 07:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LbDjk+CvjqnOpOZq/owJIOd/cs1uUyqvR8yTCc20Lws=;
        b=PmNPKYI0naiSGLMrEoJC3digUXIEGsaCbuzKcbErtgcB0sPHq1b5ILlaYE49kF/fG5
         vJ0dZXX6fmyKmCnjoe17nmJAp5vXkW34KWVjt7NZOHLMT6uLAjnoLnBZhT87TNhUez0S
         U0B2mVrMFEpCcaWuTwDJ7fARJrrNqsereeN1Nk/hgzmn5qWkoLxcOSWsiNaoRPGFvfbs
         ggPm1fuWuKic70jkpzcJRBLsW15WU1TSOOlDZmYYgwSK7guI6ZSJvaH/1xXVCT2OZjoj
         HQfAZLLhOpS4sBdOVYQXZI+QhuzU1qY+cnGHYSCRWZ38A42AvT2znA+XVHKxdSVCSk0i
         ZX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LbDjk+CvjqnOpOZq/owJIOd/cs1uUyqvR8yTCc20Lws=;
        b=tOlUVrcWFVdAzOndRXIAYpk+GbaEaB4URfkczOkTLBAvKp4Cvi36vnmgH/vXgR9QWp
         Wl11eEP2CMLj/5jZRoemkJDmQ/IJfB6ISMMeCakpFcKyGRGOb4v+c/ibfGBYk+IiDUgs
         wjeZMSzWE+BCvSx5UOn9LelFv2m8h5pcIUITzfkhNuI9sYrp3bVPJ6L2cNIUTOsgaxtF
         7BCxnBqNHEiYGsJFFlpGGrrKFltJEJbgRfOamGl5KH6XW7Qp1+fHbqZuN+kSlL75FLR0
         NzTBZXIHi+9VmpdOlWA+AOKppGCrMs77xQw9Q2hDs8IAt6r0++/u77PU3Ja/5XgrCRnL
         RNhg==
X-Gm-Message-State: APjAAAWZWGJ2IlAFqVxmXULPnQrTEqeura22CUrK/wsup6MY/gb7GB7H
        RoFdyAn/9P97fkLQweu7LTY=
X-Google-Smtp-Source: APXvYqz53n4RZyjg1WtMY6NUpaKrreYOTNnuvBbcezJYzK9Xx1vtdu0ztmQuy9JV3td4nEb9CNXbhA==
X-Received: by 2002:a37:5c8:: with SMTP id 191mr16010086qkf.188.1559657543466;
        Tue, 04 Jun 2019 07:12:23 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id f9sm11027927qkb.97.2019.06.04.07.12.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 07:12:22 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3A49E41149; Tue,  4 Jun 2019 11:12:20 -0300 (-03)
Date:   Tue, 4 Jun 2019 11:12:20 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] perf record: collect user registers set jointly with
 dwarf stacks
Message-ID: <20190604141220.GG24504@kernel.org>
References: <e7fd37b1-af22-0d94-a0dc-5895e803bbfe@linux.intel.com>
 <20190530194111.GA6540@kernel.org>
 <3dc0c67e-9ea3-b9f5-1aa2-e87603b29c37@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dc0c67e-9ea3-b9f5-1aa2-e87603b29c37@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 31, 2019 at 09:27:38AM +0300, Alexey Budankov escreveu:
> On 30.05.2019 22:41, Arnaldo Carvalho de Melo wrote:
> > Em Thu, May 30, 2019 at 10:03:36PM +0300, Alexey Budankov escreveu:
> >> When dwarf stacks are collected jointly with user specified register
> >> set using --user-regs option like below the full register context is
> >> captured on a sample:
> >>
> >>   $ perf record -g --call-graph dwarf,1024 --user-regs=IP,SP,BP -- stack_test2.g.O3
> >>
> >>   188143843893585 0x6b48 [0x4f8]: PERF_RECORD_SAMPLE(IP, 0x4002): 23828/23828: 0x401236 period: 1363819 addr: 0x7ffedbdd51ac
> >>   ... FP chain: nr:0
> >>   ... user regs: mask 0xff0fff ABI 64-bit
> >>   .... AX    0x53b
> >>   .... BX    0x7ffedbdd3cc0
> >>   .... CX    0xffffffff
> >>   .... DX    0x33d3a
> >>   .... SI    0x7f09b74c38d0
> >>   .... DI    0x0
> >>   .... BP    0x401260
> >>   .... SP    0x7ffedbdd3cc0
> >>   .... IP    0x401236
> >>   .... FLAGS 0x20a
> >>   .... CS    0x33
> >>   .... SS    0x2b
> >>   .... R8    0x7f09b74c3800
> >>   .... R9    0x7f09b74c2da0
> >>   .... R10   0xfffffffffffff3ce
> >>   .... R11   0x246
> >>   .... R12   0x401070
> >>   .... R13   0x7ffedbdd5db0
> >>   .... R14   0x0
> >>   .... R15   0x0
> >>   ... ustack: size 1024, offset 0xe0
> >>    . data_src: 0x5080021
> >>    ... thread: stack_test2.g.O:23828
> >>    ...... dso: /root/abudanko/stacks/stack_test2.g.O3
> >>
> >> After applying the change suggested in the patch the sample data contain
> >> only user specified register values. IP and SP registers (DWARF_MINIMAL_REGS)
> >> are collected anyways regardless of the --user-regs value provided from
> >> the command line:
> > 
> > Applied, changed the subject and description to:
> > 
> > perf record: Allow mixing --user-regs with --call-graph=dwarf
> > 
> > When DWARF stacks were requested and at the same time that the user
> > specifies a register set using the --user-regs option the full register
> > context was being captured on samples:
> > 
> >   $ perf record -g --call-graph dwarf,1024 --user-regs=IP,SP,BP -- stack_test2.g.O3
> > 
> >   188143843893585 0x6b48 [0x4f8]: PERF_RECORD_SAMPLE(IP, 0x4002): 23828/23828: 0x401236 period: 1363819 addr: 0x7ffedbdd51ac
> >   ... FP chain: nr:0
> >   ... user regs: mask 0xff0fff ABI 64-bit
> >   .... AX    0x53b
> >   .... BX    0x7ffedbdd3cc0
> >   .... CX    0xffffffff
> >   .... DX    0x33d3a
> >   .... SI    0x7f09b74c38d0
> >   .... DI    0x0
> >   .... BP    0x401260
> >   .... SP    0x7ffedbdd3cc0
> >   .... IP    0x401236
> >   .... FLAGS 0x20a
> >   .... CS    0x33
> >   .... SS    0x2b
> >   .... R8    0x7f09b74c3800
> >   .... R9    0x7f09b74c2da0
> >   .... R10   0xfffffffffffff3ce
> >   .... R11   0x246
> >   .... R12   0x401070
> >   .... R13   0x7ffedbdd5db0
> >   .... R14   0x0
> >   .... R15   0x0
> >   ... ustack: size 1024, offset 0xe0
> >    . data_src: 0x5080021
> >    ... thread: stack_test2.g.O:23828
> >    ...... dso: /root/abudanko/stacks/stack_test2.g.O3
> > 
> > I.e. the --user-regs=IP,SP,BP was being ignored, being overridden by the
> > needs of --call-graph=dwarf.
> > 
> > After applying the change in this patch the sample data contains the
> > user specified register, but making sure that at least the minimal set
> > of register needed for DWARF unwinding (DWARF_MINIMAL_REGS) is
> > requested.
> > 
> > The user is warned that DWARF unwinding may not work if extra registers
> > end up being needed.
> > 
> >   -g call-graph dwarf,K                         full_regs
> >   --user-regs=user_regs                         user_regs
> >   -g call-graph dwarf,K --user-regs=user_regs   user_regs + DWARF_MINIMAL_REGS
> > <REST remains the same>
> > 
> 
> Sounds better. Thanks!
> 
> ~Alexey

Now cross building to a few arches is failing, so far:

[perfbuilder@quaco ~]$ cat /tmp/dm.log/summary
 alpine:3.4: Ok
 alpine:3.5: Ok
 alpine:3.6: Ok
 alpine:3.7: Ok
 alpine:3.8: Ok
 alpine:3.9: Ok
 alpine:edge: Ok
 amazonlinux:1: Ok
 amazonlinux:2: Ok
 android-ndk:r12b-arm: Ok
 android-ndk:r15c-arm: Ok
 centos:5: Ok
 centos:6: Ok
 centos:7: Ok
 clearlinux:latest: Ok
 debian:8: Ok
 debian:9: Ok
 debian:experimental: Ok
 debian:experimental-x-arm64: Ok
 debian:experimental-x-mips: FAIL
 debian:experimental-x-mips64: FAIL
 debian:experimental-x-mipsel: FAIL
 fedora:20: Ok
 fedora:22: Ok
 fedora:23: Ok
 fedora:24: Ok
 fedora:24-x-ARC-uClibc: FAIL
 fedora:25: Ok
 fedora:26: Ok
 fedora:27: Ok
[perfbuilder@quaco ~]$

For instance:

[perfbuilder@quaco ~]$ cat /tmp/dm.log/debian\:experimental-x-mips64
<SNIP>
  CC       /tmp/build/perf/tests/pmu.o
util/evsel.c: In function '__perf_evsel__config_callchain':
util/evsel.c:672:38: error: 'PERF_REG_IP' undeclared (first use in this function); did you mean 'PERF_REGS_MAX'?
 #define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
                                      ^~~~~~~~~~~
util/evsel.c:708:31: note: in expansion of macro 'DWARF_MINIMAL_REGS'
     attr->sample_regs_user |= DWARF_MINIMAL_REGS;
                               ^~~~~~~~~~~~~~~~~~
util/evsel.c:672:38: note: each undeclared identifier is reported only once for each function it appears in
 #define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
                                      ^~~~~~~~~~~
util/evsel.c:708:31: note: in expansion of macro 'DWARF_MINIMAL_REGS'
     attr->sample_regs_user |= DWARF_MINIMAL_REGS;
                               ^~~~~~~~~~~~~~~~~~
util/evsel.c:672:62: error: 'PERF_REG_SP' undeclared (first use in this function); did you mean 'PERF_MEM_S'?
 #define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
                                                              ^~~~~~~~~~~
util/evsel.c:708:31: note: in expansion of macro 'DWARF_MINIMAL_REGS'
     attr->sample_regs_user |= DWARF_MINIMAL_REGS;
                               ^~~~~~~~~~~~~~~~~~
  LD       /tmp/build/perf/bench/perf-in.o
  CC       /tmp/build/perf/tests/hists_common.o
mv: cannot stat '/tmp/build/perf/util/.evsel.o.tmp': No such file or directory
make[4]: *** [/git/linux/tools/build/Makefile.build:97: /tmp/build/perf/util/evsel.o] Error 1
make[4]: *** Waiting for unfinished jobs....
<SNIP>



[perfbuilder@quaco ~]$ cat /tmp/dm.log/fedora\:24-x-ARC-uClibc

<SNIP>
  CC       /tmp/build/perf/tests/mmap-basic.o
  CC       /tmp/build/perf/ui/hist.o
util/evsel.c: In function '__perf_evsel__config_callchain':
util/evsel.c:672:38: error: 'PERF_REG_IP' undeclared (first use in this function); did you mean 'PERF_MEM_S'?
 #define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
                                      ^
util/evsel.c:708:31: note: in expansion of macro 'DWARF_MINIMAL_REGS'
     attr->sample_regs_user |= DWARF_MINIMAL_REGS;
                               ^~~~~~~~~~~~~~~~~~
util/evsel.c:672:38: note: each undeclared identifier is reported only once for each function it appears in
 #define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
                                      ^
util/evsel.c:708:31: note: in expansion of macro 'DWARF_MINIMAL_REGS'
     attr->sample_regs_user |= DWARF_MINIMAL_REGS;
                               ^~~~~~~~~~~~~~~~~~
util/evsel.c:672:62: error: 'PERF_REG_SP' undeclared (first use in this function); did you mean 'PERF_REG_IP'?
 #define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
                                                              ^
util/evsel.c:708:31: note: in expansion of macro 'DWARF_MINIMAL_REGS'
     attr->sample_regs_user |= DWARF_MINIMAL_REGS;
                               ^~~~~~~~~~~~~~~~~~
  MKDIR    /tmp/build/perf/ui/stdio/
mv: cannot stat '/tmp/build/perf/util/.evsel.o.tmp': No such file or directory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/util/evsel.o' failed
make[4]: *** [/tmp/build/perf/util/evsel.o] Error 1

