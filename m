Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7AAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E5820657
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfCLQTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:19:46 -0400
Received: from foss.arm.com ([217.140.101.70]:44912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbfCLQTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:19:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF36480D;
        Tue, 12 Mar 2019 09:19:45 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE1D43F59C;
        Tue, 12 Mar 2019 09:19:43 -0700 (PDT)
Date:   Tue, 12 Mar 2019 16:19:41 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [RFC][PATCH] Export supported trace features in debugfs
Message-ID: <20190312161941.6vlxp3qvad5oy4fs@e107158-lin.cambridge.arm.com>
References: <20190312110437.5977-1-qais.yousef@arm.com>
 <20190312152703.dulqcnhkknklxihq@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190312152703.dulqcnhkknklxihq@ast-mbp>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/19 08:27, Alexei Starovoitov wrote:
> On Tue, Mar 12, 2019 at 11:07:14AM +0000, Qais Yousef wrote:
> > eBPF tools like bcc-tools have hard time figuring out when features like
> > raw_tracepoint are supported in the kernel on which we are running. At
> > the moment a fragile mechanism of matching bpf_find_raw_tracepoint()
> > function in /proc/kallsyms is used to find out whether raw tracepoints
> > can be used or not. But when this function was renamed recently to
> > bpf_get_raw_tracepoint() the tool started to fail to use raw
> > tracepoints.
> > 
> > To help in providing a more reliable way to detect features like
> > RAW_TRACEPOINT, add a new file in trace debugfs to export the supported
> > features.
> > 
> > $cat /sys/kernel/debug/tracing/supported_features
> > RAW_TRACEPOINT
> > EXAMPLE_FEATURE_1
> > EXAMPLE_FEATURE_2
> > 
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> 
> this type of attempts have been made in the past and we always rejected them.
> Please use 'bpftool' instead that detects numerous bpf related features including raw_tp.
> # bpftool feature probe|grep raw_tracepoint
> eBPF program_type raw_tracepoint is available
> 

I see. I should have looked harder. I'll have a look at what bpftool does then.

Thanks

--
Qais Yousef
