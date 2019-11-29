Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D56C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 15:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8369D2176D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 15:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rn0ViMAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfK2POl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 10:14:41 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46489 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfK2POl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 10:14:41 -0500
Received: by mail-qk1-f194.google.com with SMTP id f5so7437541qkm.13;
        Fri, 29 Nov 2019 07:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WQaLCjp+rrffDebUyBFTX+peQxA/xZc2IenMiVMYYg8=;
        b=Rn0ViMAKal7e6VRgEBnZZiu+8HL1xsOTR+BDzyAxdlmLFKmQAvQwC5yvJGAJvuh3KH
         MkGJ7go6hP8X697UrqOsQN9nr4pHCSgwqGN26O180rLcakntVMMun/uwBhkmSL7oIyRb
         TJ+FLJHndjB22hZSpzw5NtciCcrDNtfjTzbuic1+CgaAysnIZXOo7LEka4M7l9UW8v9e
         R60ePJLubmQR77fadSOUShN1CHDrRlh/VRjsGTqoJ985F6QISGHXvQdh9cDRKZnPIGnk
         4r77r+xGJAHZYp5Cj82iGHWZgZOgNfu7y1Uz5E15V6oHQPnQrlKx5n5aDq9OsTcqFEdw
         5C/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WQaLCjp+rrffDebUyBFTX+peQxA/xZc2IenMiVMYYg8=;
        b=PdtcS3ufpmWbaXIaOrfuv2Rx9GQ621qow6FbyzIpFiLvQWjqbUAVK7nFYPr8bRU0+P
         KD7jLbApVx25vVZbwhFQhEmIZL1UBsQuLrIwgfPdfKcjIhcK4SbZ9jr/n1tVkwRdPjOA
         cr13CHMG1i9hTFWR7Z9FN+o4IpTzl53TQZ91l6d+B+Bj+A2nI0aQp7aI+kX1qFdYjz6D
         3CiqZyIf57AWUIQHbxOKssCpq2hIz68Qfl3IVvALVbMQV1hN3iuXoUQ6Frq6KzEF6cQY
         hUE8eR1sXn0WEQEVUK1D6DbYcFz7Vh/d36X219+o7viS1ui7WNNsHt1dBW3CoZilVqIT
         X5rw==
X-Gm-Message-State: APjAAAUzNczFLKXyoLBGabqb+o7eLPG67rdIcAlZGr9Jhj79U1cynNdF
        EndKIvr7nSS+MmITkEdXltc=
X-Google-Smtp-Source: APXvYqwSwB6I3QLIJrBh1ZDUBezpz85TC8yWUqM9WyN/DuOY2tuRUcxrvmDJb0ibxcZIEDnVG3v6YA==
X-Received: by 2002:a37:95c5:: with SMTP id x188mr16316707qkd.124.1575040479849;
        Fri, 29 Nov 2019 07:14:39 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id t38sm1063279qta.78.2019.11.29.07.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 07:14:38 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 724D5405B6; Fri, 29 Nov 2019 12:14:36 -0300 (-03)
Date:   Fri, 29 Nov 2019 12:14:36 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ivan Babrou <ivan@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: perf is unable to read dward from go programs
Message-ID: <20191129151436.GB26963@kernel.org>
References: <CABWYdi2jvPUq128XDv_VbY=vFknFyJHbUR=0_K9WuA0mFTkPvg@mail.gmail.com>
 <CABWYdi3k9QvFOEd_hFG16LVE=BiokO4hWp50nZcxYwbWfxeE3g@mail.gmail.com>
 <20191129134929.GA26903@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129134929.GA26903@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 29, 2019 at 02:49:29PM +0100, Jiri Olsa escreveu:
> On Wed, Nov 27, 2019 at 01:15:20PM -0800, Ivan Babrou wrote:
> > There were no response in linux-perf-users@, so I think it's fair to
> > ask maintainers.
> > 
> > On Fri, Nov 8, 2019 at 3:53 PM Ivan Babrou <ivan@cloudflare.com> wrote:
> > >
> > > I have a simple piece of code that burns CPU for 1s:
> > >
> > > * https://gist.github.com/bobrik/cf022ff6950d09032fa13a984e2272ed
> > >
> > > I can build it just fine: go build -o /tmp/burn burn.go
> > >
> > > And I can see correct stacks if I record with fp:
> > >
> > > perf record -e cpu-clock -g -F 99 /tmp/burn
> > >
> > > But if I record with gwarf:
> > >
> > > perf record -e cpu-clock -g -F 99 --call-graph dwarf /tmp/burn
> > >
> > > Then stacks are lost with the following complaints during "perf script":
> > >
> > > BFD: Dwarf Error: found dwarf version '376', this reader only handles
> > > version 2, 3 and 4 information.
> > > BFD: Dwarf Error: found dwarf version '31863', this reader only
> > > handles version 2, 3 and 4 information.
> > > BFD: Dwarf Error: found dwarf version '65271', this reader only
> > > handles version 2, 3 and 4 information.
> > > BFD: Dwarf Error: found dwarf version '289', this reader only handles
> > > version 2, 3 and 4 information.
> 
> hi,
> the binary generated by go has compressed debug info (on my setup)
> and libunwind (default dwarf unwinder) does not seem to support that
> 
> but when I compile perf with libdw unwind support:
> 
>   $ make DEBUG=1 VF=1 NO_LIBUNWIND=1
> 
> I'm getting proper backtraces (below), maybe it's time to change
> the default dwarf unwinder ;-)

we have some 'perf test' entries testing the unwinding routines, can you
please check if those pass when switching to libdw's unwinder?

- Arnaldo
 
> thanks,
> jirka
> 
> 
> ---
>     51.63%  ex       ex                [.] crypto/sha512.blockAVX2
>             |
>             ---crypto/sha512.blockAVX2
>                |          
>                 --51.48%--crypto/sha512.block
>                           crypto/sha512.(*digest).Write
>                           crypto/sha512.(*digest).checkSum
>                           crypto/sha512.(*digest).Sum
>                           main.burn
>                           main.main
>                           runtime.main
>                           runtime.goexit
> 
>     11.55%  ex       ex                [.] runtime.mallocgc
>             |
>             ---runtime.mallocgc
>                |          
>                |--7.45%--runtime.newobject
>                |          |          
>                |           --7.45%--main.burn
>                |                     main.main
>                |                     runtime.main
>                |                     runtime.goexit
>                |          
>                 --3.40%--runtime.growslice
>                           crypto/sha512.(*digest).Sum
>                           main.burn
>                           main.main
>                           runtime.main
>                           runtime.goexit
> 
>      3.69%  ex       ex                [.] crypto/sha512.(*digest).Write
>             |
>             ---crypto/sha512.(*digest).Write
>                |          
>                |--2.91%--crypto/sha512.(*digest).checkSum
>                |          crypto/sha512.(*digest).Sum
>                |          main.burn
>                |          main.main
>                |          runtime.main
>                |          runtime.goexit
>                |          
>                 --0.57%--main.burn
>                           main.main
>                           runtime.main
>                           runtime.goexit
> 
>      3.44%  ex       ex                [.] runtime.memclrNoHeapPointers
>             |
>             ---runtime.memclrNoHeapPointers
>                |          
>                 --2.92%--runtime.(*mheap).alloc
>                           runtime.(*mcentral).grow
>                           runtime.(*mcentral).cacheSpan
>                           runtime.(*mcache).refill
>                           runtime.(*mcache).nextFree
>                           runtime.mallocgc
>                           |          
>                           |--2.27%--runtime.newobject
>                           |          main.burn
>                           |          main.main
>                           |          runtime.main
>                           |          runtime.goexit
>                           |          
>                            --0.64%--runtime.growslice
>                                      crypto/sha512.(*digest).Sum
>                                      main.burn
>                                      main.main
>                                      runtime.main
>                                      runtime.goexit
> ...

-- 

- Arnaldo
