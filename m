Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B4CC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BAE24508
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfE3MHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 08:07:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbfE3MHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 08:07:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A62730C1AFE;
        Thu, 30 May 2019 12:07:16 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id B6CC064026;
        Thu, 30 May 2019 12:07:10 +0000 (UTC)
Date:   Thu, 30 May 2019 14:07:10 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
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
Message-ID: <20190530120709.GA3669@krava>
References: <20190508132010.14512-1-jolsa@kernel.org>
 <20190530105439.GA5927@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530105439.GA5927@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 30 May 2019 12:07:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 06:54:39PM +0800, Leo Yan wrote:
> Hi Jiri,
> 
> On Wed, May 08, 2019 at 03:19:58PM +0200, Jiri Olsa wrote:
> > hi,
> > this patchset adds dso support to read and display
> > bpf code in intel_pt trace output. I had to change
> > some of the kernel maps processing code, so hopefully
> > I did not break too many things ;-)
> > 
> > It's now possible to see bpf code flow via:
> > 
> >   # perf-with-kcore record pt -e intel_pt//ku -- sleep 1
> >   # perf-with-kcore script pt --insn-trace --xed
> 
> This is very interesting work for me!
> 
> I want to verify this feature with Arm CoreSight trace, I have one
> question so that I have more direction for the tesing:
> 
> What's the bpf program you are suing for the testing?  e.g. some
> testing program under the kernel's folder $kernel/samples/bpf?
> Or you uses perf command to launch bpf program?

for this I was using tools/testing/selftests/bpf/test_verifier

I isolated some tests and ran the perf on top of them, like:

  # perf-with-kcore record pt -e intel_pt//ku -- ./test_verifier ...

I had to add some small sleep before the test_verifier exit,
so the perf bpf thread could catch up and download the program
details before test_verifier exited.

jirka

> 
> [...]
> 
> Thanks
> Leo Yan
