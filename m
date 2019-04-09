Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9F9C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6CB2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfDIIY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:24:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33408 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfDIIY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:24:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6973AA78;
        Tue,  9 Apr 2019 01:24:55 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E286C3F557;
        Tue,  9 Apr 2019 01:24:53 -0700 (PDT)
Date:   Tue, 9 Apr 2019 09:24:51 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     rostedt@goodmis.org, peterz@infradead.org
Cc:     dietmar.eggemann@arm.com, quentin.perret@arm.com,
        bristot@redhat.com, juri.lelli@redhat.com, williams@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: Tracehooks in scheduler
Message-ID: <20190409082450.mkcobfbmohhxqk6k@e107158-lin.cambridge.arm.com>
References: <20190407175235.5c2livciovwgq7mm@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190407175235.5c2livciovwgq7mm@e107158-lin.cambridge.arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ LKML)

Apologies forgot to CC the list.

On 04/07/19 18:52, Qais Yousef wrote:
> Hi Steve, Peter
> 
> I know the topic has sprung up in the past but I couldn't find anything that
> points into any conclusion.
> 
> As far as I understand new TRACE_EVENTS() in the scheduler (and probably other
> subsystems) isn't desirable as it intorduces a sort of ABI that can be painful
> to maintain.
> 
> But for us to be able to test various aspect of EAS, we rely on some events
> that track load_avg, util_avg and some other metrics in the scheduler.
> Example of such patches that are in android and we maintain out of tree can be
> found here:
> 
> https://android.googlesource.com/kernel/common/+/42903694913697da88a4ac627a92bbfdf44f0a2e
> https://android.googlesource.com/kernel/common/+/6dfaed989ea4ca223f0913dfc11cdafd9664fc1c
> 
> Dietmar and Quentin pointed me to a discussion you guys had with Daniel Bristot
> in the last LPC when he had a similar need. So it is something that could
> benefit other users as well.
> 
> What is the best way forward to be able to add tracehooks into the scheduler
> and any other subsystem for that matters?
> 
> We tried using DECLARE_TRACE() to create a tracepoint which doesn't export
> anything in /sys/kernel/debug/tracing/events and hoped that we can use eBPF or
> a kernel module to attach to this tracepoint and access the args to inject our
> own trace_printks() but this didn't work. The glue logic necessary to attach
> to this tracepoint in a similar manner to how RAW_TRACEPOINT() in eBPF works
> isn't there AFAICT.
> 
> I can post the full example if the above doesn't make sense. I am still
> familiarizing myself with the different aspects of this code as well. There
> might be support for what we want but I failed to figure out the magic
> combination to get it to work.
> 
> If I got this glue logic done, would this be an acceptable solution? If not, do
> you have any suggestions on how to progress?
> 
> Thanks
> 
> --
> Qais Yousef
