Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01DDC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A2220449
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nSiWl/kI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfE3M5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 08:57:21 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36543 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfE3M5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 08:57:20 -0400
Received: by mail-oi1-f196.google.com with SMTP id y124so4856406oiy.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UNjWY+PuXXLD9djainG36BOp70Jg0SoWhfBTnPpP4Fo=;
        b=nSiWl/kIj0X2NViDnc3n0V6qmyRQf4jLT9Bz+meqHcrY9MA6tOrXQn1fU/Vv8EtNSA
         FkBGu/MNlOAvdDguJ7ScluNpzr5avLrSBkF1CJH2x+krcM3I7PcgadHEFmnSDi6lEA6r
         jEncRs0NzyM7eceFXmZg8lTXD1w41hxnnuXU8Ic09ZNgm76NrjS1o9JIHZzkwoijXZpT
         1zb79/vWFJFPjq7viuduxGxD4JH+Q99cyNwL1cRjE+4c8nXV/MhfIRnS2ntRycTT4Q7Y
         yiqfAB+575eBUg7gBCg3h5KNHSwRu0itqxS9EFpIKUREdjRsLaMUrybchAxzkXQMFqm5
         xgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UNjWY+PuXXLD9djainG36BOp70Jg0SoWhfBTnPpP4Fo=;
        b=rpvDR1tnX+CFYDdO+foESV8xyi3Ie1nTaJ72cGJKgxVZ1pii0hu9MeiyCsNqUCIib/
         zltNoYtIFuDV6ekQjIdDYqUVgM5djI8ou/rPh8BwEXw2WAhxgtNpeqbaNboOmIESTpvw
         SvJa625xFMaTcwPAZwvcskQfWsEGzpkngZi8LlzoUJ0PMQyAumMguEkcOM0UIksj4SWj
         65qyHnzas7Aejp1FyXIUGHHKth/u2vPnQ1NjP4bU0809i+j/0nm8mh1b7fE+BANxLjUW
         qkLEHRp+pgci0uvO3tWMJ9Ae9G25bK+E1Yd47/r1dw/jQ799rHULU+aHFY9D7afVWAAZ
         LjWA==
X-Gm-Message-State: APjAAAUlWrSNq5F64IH6/SE0u8pa1PvB5RcVpJ0W9igBsdxX3E7F5mX5
        I4iZJWFvJgQLoT9vLknv3cLA7A==
X-Google-Smtp-Source: APXvYqyAYf3UezUipJ0hyDlkwW0W6w27n7EfeRwmIFCwUI4+55XxxqLE9pIWffypAIguUg37Vh5DMQ==
X-Received: by 2002:aca:ec53:: with SMTP id k80mr6847oih.123.1559221039962;
        Thu, 30 May 2019 05:57:19 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li808-42.members.linode.com. [104.237.132.42])
        by smtp.gmail.com with ESMTPSA id p64sm954653oif.8.2019.05.30.05.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 05:57:19 -0700 (PDT)
Date:   Thu, 30 May 2019 20:57:09 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCHv3 00/12] perf tools: Display eBPF code in intel_pt trace
Message-ID: <20190530125709.GB5927@leoy-ThinkPad-X240s>
References: <20190508132010.14512-1-jolsa@kernel.org>
 <20190530105439.GA5927@leoy-ThinkPad-X240s>
 <20190530120709.GA3669@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530120709.GA3669@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Thu, May 30, 2019 at 02:07:10PM +0200, Jiri Olsa wrote:
> On Thu, May 30, 2019 at 06:54:39PM +0800, Leo Yan wrote:
> > Hi Jiri,
> > 
> > On Wed, May 08, 2019 at 03:19:58PM +0200, Jiri Olsa wrote:
> > > hi,
> > > this patchset adds dso support to read and display
> > > bpf code in intel_pt trace output. I had to change
> > > some of the kernel maps processing code, so hopefully
> > > I did not break too many things ;-)
> > > 
> > > It's now possible to see bpf code flow via:
> > > 
> > >   # perf-with-kcore record pt -e intel_pt//ku -- sleep 1
> > >   # perf-with-kcore script pt --insn-trace --xed
> > 
> > This is very interesting work for me!
> > 
> > I want to verify this feature with Arm CoreSight trace, I have one
> > question so that I have more direction for the tesing:
> > 
> > What's the bpf program you are suing for the testing?  e.g. some
> > testing program under the kernel's folder $kernel/samples/bpf?
> > Or you uses perf command to launch bpf program?
> 
> for this I was using tools/testing/selftests/bpf/test_verifier
> 
> I isolated some tests and ran the perf on top of them, like:
> 
>   # perf-with-kcore record pt -e intel_pt//ku -- ./test_verifier ...

Thanks a lot for sharing the info and quick responsing.

I tried to use the program $kernel/samples/bpf/sampleip to verify this
patch set, but seems eBPF dso is not contained properly; below is my
detailed steps:

    # In the first tty
    # cd $kernel/samples/bpf/
    # ./sampleip -F 200 20  => sample ip with 200Hz for 20s

    # In the second tty
    # perf-with-kcore record arm_test -e cs_etm/@20070000.etr/uk -- sleep 1

If I output DSO info with report command it give below info, which
doesn't contain any info for eBPF DSO?

    # perf-with-kcore report arm_test -F,dso

    # Samples: 6M of event 'branches:ku'
    # Event count (approx.): 6340896
    #
    # Shared Object     
    # ..................
    #
      [kernel.kallsyms] 
      ld-2.28.so        
      libc-2.28.so      
      libpthread-2.28.so
      perf              
      sleep             
      [unknown]         

> I had to add some small sleep before the test_verifier exit,
> so the perf bpf thread could catch up and download the program
> details before test_verifier exited.

This seems to me for a 'real' eBPF program, do we also need extra sleep
so that perf bpf can save dso properly?


BTW, I have another question: to display eBPF code, except this feature
can be used by hardware tracing (e.g. intel_pt), it also can be used
by other PMU events and timer events, right?

Thanks,
Leo Yan
