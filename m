Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5CBC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 14:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616EB2189D
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 14:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6PwknY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfHROEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 10:04:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43543 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfHROEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 10:04:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3so5372860pgb.10
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 07:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pPU6BL3O8y0CcD4U4GDbFQvhTODvqmfC8YYOoQmMctY=;
        b=j6PwknY11koFhKKprvKJo8T+w/tkv8aMDcEqW72UPprD0tFUK5aWuvivrAhdRywSz0
         vnr8APwHia1kbBYLweM+bYPoBB4nb1B3WCx4EFJzi6Xurp15nHBpiIdEVlmGlWX3MJW3
         Vz2tAPvm+KUdHYnS89tiI4IxAPEKK9YjInJY+Nip4kicbS0GPxH4zdfB0EB9Xw2TMegk
         OfuzewohCCElNZ0AyQBKx7oK/vhZyGmCTUbYh946b1nRj/1BKwIibQ0pCaYhSa1lR/dI
         MojJHZYFoV6E1zbYP097ZTo6niyr2jkxHCb9gQ8cL//3VHS6IPW34/Zmcq2DWPfa6bZk
         EiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pPU6BL3O8y0CcD4U4GDbFQvhTODvqmfC8YYOoQmMctY=;
        b=XY5T4Ruyl+ycOa5awlZ0iHYbMc8VkzCmvi4/Y0RdgI4VbvM+V2WZpM1aJdiZaD9HQf
         3nVCkZOJr5VukLbZh008PJC055qlijGyHKYkYpXVVfQOKL5sH9yvcxc+aCxwBVb/optI
         PlmbZJPIb+VcqXstL8BGSJDFfae0QK2eOVE5VVP4GVpj428CMd5VSyHsr24u11XbOLRt
         EUKfUVY6GlieGz6SUVcMjigy7FnheMlv5ko3RMm9XX45ccIDb5iytdx24Yp4YdcAxj+g
         eBrgOy7qWb4K/CjDod/UXbWyWuQ0xy4HlnUzBs9thmepeNbolrCiE+pauktP2k1qbwSd
         Jpzw==
X-Gm-Message-State: APjAAAVc+U7DkgonAsMxU77pFIWRg5uMDa06krSPAKPgg1AV4p68pcUz
        ocim+34no9NYSgu7iAy6p30=
X-Google-Smtp-Source: APXvYqxGBCMbM5DGVhWamH7zXhTLksoPDhtVCW6VO3A9Y5+hN0n/SQfxJQlFNMILSGatyxWn76AtSw==
X-Received: by 2002:a62:35c6:: with SMTP id c189mr19805255pfa.96.1566137078834;
        Sun, 18 Aug 2019 07:04:38 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v14sm12365894pfm.164.2019.08.18.07.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2019 07:04:37 -0700 (PDT)
Date:   Sun, 18 Aug 2019 07:04:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 28/79] libperf: Add perf_cpu_map struct
Message-ID: <20190818140436.GA21854@roeck-us.net>
References: <20190721112506.12306-1-jolsa@kernel.org>
 <20190721112506.12306-29-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721112506.12306-29-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 01:24:15PM +0200, Jiri Olsa wrote:
> Adding perf_cpu_map struct into libperf.
> 
> It's added as a declaration into into:
>   include/perf/cpumap.h
> which will be included by users.
> 
> The perf_cpu_map struct definition is added into:
>   include/internal/cpumap.h
> 
> which is not to be included by users, but shared
> within perf and libperf.
> 
> We tried the total separation of the perf_cpu_map struct
> in libperf, but it lead to complications and much bigger
> changes in perf code, so we decided to share the declaration.
> 
> Link: http://lkml.kernel.org/n/tip-vhtr6a8apr7vkh2tou0r8896@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Hi,

this patch causes out-of-tree builds (make O=<destdir>) to fail.

In file included from tools/include/asm/atomic.h:6:0,
                 from include/linux/atomic.h:5,
		 from tools/include/linux/refcount.h:41,
		 from cpumap.c:4: tools/include/asm/../../arch/x86/include/asm/atomic.h:11:10:
fatal error: asm/cmpxchg.h: No such file or directory

Bisect log attached.

Guenter

---
# bad: [0c3d3d648b3ed72b920a89bc4fd125e9b7aa5f23] Add linux-next specific files for 20190816
# good: [d45331b00ddb179e291766617259261c112db872] Linux 5.3-rc4
git bisect start 'HEAD' 'v5.3-rc4'
# good: [4e6eaeb715ab76095f7ea03fa5926c7aa541361e] Merge remote-tracking branch 'crypto/master'
git bisect good 4e6eaeb715ab76095f7ea03fa5926c7aa541361e
# good: [ef1c67aa73f33a29e3df672998056f18cb51468d] Merge remote-tracking branch 'sound-asoc/for-next'
git bisect good ef1c67aa73f33a29e3df672998056f18cb51468d
# bad: [f414a0d92534d55591e3c295f37f8db40d08659a] Merge remote-tracking branch 'char-misc/char-misc-next'
git bisect bad f414a0d92534d55591e3c295f37f8db40d08659a
# bad: [07f45358f90398b3bc44914a863317285a5dac55] Merge remote-tracking branch 'tip/auto-latest'
git bisect bad 07f45358f90398b3bc44914a863317285a5dac55
# good: [b8c9806513153eb258f565b2f359958a94c93816] Merge remote-tracking branch 'watchdog/master'
git bisect good b8c9806513153eb258f565b2f359958a94c93816
# bad: [7b9063c0c1c0b54db5eca8e4c36a926ee6234280] Merge branch 'sched/core'
git bisect bad 7b9063c0c1c0b54db5eca8e4c36a926ee6234280
# bad: [03617c22e31f32cbf0e4797e216db898fb898d90] libperf: Add threads to struct perf_evlist
git bisect bad 03617c22e31f32cbf0e4797e216db898fb898d90
# good: [5972d1e07bd95c7458e2d7f484391d69008affc7] perf evsel: Rename perf_evsel__open() to evsel__open()
git bisect good 5972d1e07bd95c7458e2d7f484391d69008affc7
# bad: [285a30c36d1e18e7e2afa24dae50ba5596be45e7] libperf: Add perf_evlist and perf_evsel structs
git bisect bad 285a30c36d1e18e7e2afa24dae50ba5596be45e7
# good: [47f9bccc79cb067103ad5e9790e0d01c94839429] libperf: Add build version support
git bisect good 47f9bccc79cb067103ad5e9790e0d01c94839429
# bad: [397721e06e52d017cfdd403f63284ed0995d4caf] libperf: Add perf_cpu_map__dummy_new() function
git bisect bad 397721e06e52d017cfdd403f63284ed0995d4caf
# good: [5b7f445d684fc287a2101e29d42d1fee19ae14ff] libperf: Add perf/core.h header
git bisect good 5b7f445d684fc287a2101e29d42d1fee19ae14ff
# bad: [959b83c769389b24d64759f60e64c4c62620ff02] libperf: Add perf_cpu_map struct
git bisect bad 959b83c769389b24d64759f60e64c4c62620ff02
# good: [a1556f8479ed58b8d5a33aef54578bad0165c7e7] libperf: Add debug output support
git bisect good a1556f8479ed58b8d5a33aef54578bad0165c7e7
# first bad commit: [959b83c769389b24d64759f60e64c4c62620ff02] libperf: Add perf_cpu_map struct
