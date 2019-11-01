Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D5BCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAE2208CB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572642089;
	bh=Jgu5Ebg/xpMDfnkweFvMYNO9g3JFkijUoidy6Ecoa9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HZbIwzekFIRXLtREA7p43bfa3invgQz5U2C2BQ/VP1baXyxJNqu8kqD1qf09uTUL/
	 1BBmY7VpVYGT1qRZmBwg5u7fJE8Ae2yuD43mVSdUi/hvjHPNyxh1gjz1HPGPwUqhGF
	 Dh2G8bxYEgkv6alBEM3uF2fulPlCyKasPSdBFPWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfKAVB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 17:01:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41436 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfKAVB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 17:01:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id p4so10825462wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 14:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qbClGcXdoxY6qMtiBZX2IGjtdGfcrdwxoiUlPe9rg4w=;
        b=gjPxP1VVcXfK0XuoGCgbkNlZxkHVwnM1G66yMkWVE6YPTOnVDLeM7WUVpBaEY0Veem
         vi4R52eJRBCbMN7R8yUKToQ859i7CZWmTaqtX3Ej8wpBbFEHt0oMl39VM3zcJ+II8Ajx
         VbB2xeNG8VI5QfD9NsQiWPb0UX+zr51qdlk/W8ii1L2zdZ9fRLcVxwy2asJTbFn74z71
         FppfvIzv2JManSsP3ALgrjAPtep+4RZTubqxB5CIcCcFQdx/DgxZk5AxWeIhPksgTqiA
         MihULf7nbkRScc9nk3B4PnWTqOrNjcpWdPp29yJAfc1i6EcGswD0vDsilYCSxt0pyuce
         vIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qbClGcXdoxY6qMtiBZX2IGjtdGfcrdwxoiUlPe9rg4w=;
        b=eK48EkbOYG4eBYLuhpjiL0vB8kvXjyWhs+tneQxKgdDKgIzB0bfTK/0xqDHMcVVu86
         OqfAxp6d59hNCbdcX1k/6r8pyGO8pskVXbHCY1G/H5homF2tGl+Egx/flopYGzFc/5ib
         fGSqwni1hodKqxuqKHGOIox9w47sjZO7oObE+BsAtb4NsS9UJ0qQbQilvjKBDbMvfCBh
         cJOF55wZ13BZNi1eYwdOc9Zs8LLY7pfA84LPTVJEX75ZN55yXH2dQ5CBcwGccmH7BcCX
         22Y3LBUXMjgt/c/eQ4G0j+j2ovO2lgLoyrhnjDo+1rdeeawpPGPa9v2TTkNbUKnxe/oA
         ipsw==
X-Gm-Message-State: APjAAAXK4TX6hAaQ3QQQQ27hDV0oXjjTo7T9LMkMryCPV3iACGViXWfG
        G2PxCYiqUmZOS24S9I5A6Y8=
X-Google-Smtp-Source: APXvYqyCuGfUKaSNW0G7eE2y4z5IeHo6z7ggbNPql4jJaV8hMG+AnnmVpNBI/1AGp9NF0zCFetRGPQ==
X-Received: by 2002:a5d:4589:: with SMTP id p9mr11711861wrq.397.1572642085220;
        Fri, 01 Nov 2019 14:01:25 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id l18sm9825295wrn.48.2019.11.01.14.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 14:01:24 -0700 (PDT)
Date:   Fri, 1 Nov 2019 22:01:17 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] perf fixes
Message-ID: <20191101210117.GA52887@gmail.com>
References: <20191101174840.GA81963@gmail.com>
 <CAHk-=wi_VHc=Q2JsPbVmCgpKekNJwnbBiYrmvnSSW8aiAkg7nQ@mail.gmail.com>
 <20191101203048.GA6622@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101203048.GA6622@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> This actually works fine in practice. I just tried out a brand new kernel 
> with really old perf tooling in the v3.19 kernel, from 4.5 years ago:
> 
>   $ git checkout v3.19
>   $ cd tools/perf/
>   $ make install WERROR=0
> 
>   $ perf version
>   perf version 3.19.gbfa76d49
> 
>   $ perf top
> 
> This ancient version of 'perf top', 'perf record', 'perf report' works 
> just fine on the new kernel, despite passing in a smaller 'attr':
> 
>   [  558.408907] perf kABI size: 112
>   [  558.412855] perf uABI size: 104
> 
> when running new tooling on a new kernel the two sizes match:
> 
> [  331.598089] perf kABI size: 112
> [  331.602050] perf uABI size: 112
> 
> and everything works as usual.

Out of morbid curiosity I also tried out the v3.2 version of perf 
tooling, which is now more than 7.5 years old, and 'perf record' + 'perf 
report' is working fine on the latest kernel too:


  $ perf version
  perf version 3.2.dirty

  $ perf record ~/hackbench 20
  Time: 0.082
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.828 MB perf.data (~36166 samples) ]

  $ perf report --stdio
  ...
  # Overhead    Command      Shared Object                                      Symbol
  # ........  .........  .................  ..........................................
  #
     6.99%  hackbench  [kernel.kallsyms]  [k] queued_spin_lock_slowpath
     6.22%  hackbench  [kernel.kallsyms]  [k] entry_SYSENTER_compat
     4.06%  hackbench  [kernel.kallsyms]  [k] sysret32_from_system_call
     3.56%  hackbench  [kernel.kallsyms]  [k] do_fast_syscall_32
     3.40%  hackbench  [kernel.kallsyms]  [k] unix_stream_read_generic
     3.32%  hackbench  [kernel.kallsyms]  [k] _raw_spin_lock
     3.13%  hackbench  [kernel.kallsyms]  [k] __slab_free


It works despite 'perf record' using an ancient, 72 bytes long 'struct perf_attr' 
ABI:

  [ 3013.531125] perf kABI size: 112
  [ 3013.535097] perf uABI size: 72

If I'm reading the logs right then the perf ABI went through around ~15 
iterations in the v3.2..v5.4 timeframe that extended struct 
perf_event_attr - but binary compatibility was maintained with ancient 
tooling.

This is also useful for tooling bisectability: tooling should work on new 
and old kernels as well, even if a bisection point moves across ABI 
extension boundaries.

Thanks,

	Ingo
