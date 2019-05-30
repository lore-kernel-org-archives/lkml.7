Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF432C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA4B25A13
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9Bzcez5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfE3OFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:05:22 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:38372 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfE3OFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:05:22 -0400
Received: by mail-oi1-f173.google.com with SMTP id 18so4228502oij.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 07:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yfJhpIBmP3V4Tl4EX4Jelv6NLwOKkheXMCrhBu7VOTA=;
        b=E9Bzcez5oSqTtC7TKP5JPoELL7dyh8FUmPIOPzDW8RV3k5XvIAC6rM31/cespOXyGb
         hXa/8bLhBWz1AyEo75KfwJqvjVhPQrFDFTv0SsGTv2EDEcjYYQF2p9UQiKsz1geRQdul
         /TGKLyRIa82C0QQYCg6LjbxqnmnGsA4ngxpCMyZKYJashrE3KQAPYgDco/hHhu7lg7Eo
         +KEebgNnogx3zjh9b+DAzaYaqJ/toha57F3CmU0ZhlSsXC+MLPvYcADNTRxjH5W5y3be
         NKVRmLUaehdG8mmCmt5zePATsfWjGX1e/yitfjFpoPlYEjPFbSXdynrjoNggUTXgBxyW
         mjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yfJhpIBmP3V4Tl4EX4Jelv6NLwOKkheXMCrhBu7VOTA=;
        b=nTFj1PpvDq/Bun5GaIi1wWjSwUGh/tVqHWDQWLehb2ZAk/7j5SCFtS+MyLXmJKeY/R
         Rbq50oeydFx6KhB24a16SaDvVuZUhIT3NPr7WgIvsFgGL9pj2dWzngmGJSMDN6BkvUgz
         sHjCCGcHSuG6aOAQI3tMxFq2xVf32eLDv/zohulG2icjNICfcf+Ju5QHkrmjgrAvXHV3
         LO5LHH6/3SJo6yLOp+mBTdRdKamoA53YMAmUVdyL/Rl7da64UKjBTl8aRFBTiWlV69JX
         VAfCgAiEhWjwff7QwSYBVtNX8oThy3b0iUOQ69CyEyEsHlX0jAf3Ys923TWIc8UTEPQa
         uB5g==
X-Gm-Message-State: APjAAAVCijk1DsmLKlgTWr6vgxSVojnRiwlwa1tqYaZNADuZTB4Ffqlz
        8McoRQTUHsJtiUFF/u8misakMRhL9hdo7g==
X-Google-Smtp-Source: APXvYqwmvR5hxpjuV+RiVqLPUL3Gx2r1d/6z/vzZcYn2Ai2TwWjNMS5d95KkUrbqBq2Pf4c35+WgPA==
X-Received: by 2002:aca:1c0c:: with SMTP id c12mr2438865oic.7.1559225121406;
        Thu, 30 May 2019 07:05:21 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li808-42.members.linode.com. [104.237.132.42])
        by smtp.gmail.com with ESMTPSA id j8sm979339otl.54.2019.05.30.07.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 07:05:20 -0700 (PDT)
Date:   Thu, 30 May 2019 22:05:10 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
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
Message-ID: <20190530140510.GD5927@leoy-ThinkPad-X240s>
References: <20190508132010.14512-1-jolsa@kernel.org>
 <20190530105439.GA5927@leoy-ThinkPad-X240s>
 <20190530120709.GA3669@krava>
 <20190530125709.GB5927@leoy-ThinkPad-X240s>
 <20190530133645.GC21962@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530133645.GC21962@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Thu, May 30, 2019 at 10:36:45AM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> One other way of testing this:
> 
> I used perf trace's use of BPF, using:
> 
> [root@quaco ~]# cat ~/.perfconfig
> [llvm]
> 	dump-obj = true
> 	clang-opt = -g
> [trace]
> 	add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c
> 	show_zeros = yes
> 	show_duration = no
> 	no_inherit = yes
> 	show_timestamp = no
> 	show_arg_names = no
> 	args_alignment = 40
> 	show_prefix = yes
> 
> For arm64 this needs fixing, tools/perf/examples/bpf/augmented_raw_syscalls.c
> (its in the kernel sources) is still hard coded for x86_64 syscall numbers :-\

Thanks a lot for sharing this, I will test with this method and let you
and Jiri know the result in tomorrow.

[...]

Thanks,
Leo Yan
