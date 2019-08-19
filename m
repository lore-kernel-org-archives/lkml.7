Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C530AC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5F520851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfHSMx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 08:53:29 -0400
Received: from foss.arm.com ([217.140.110.172]:53728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfHSMx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 08:53:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60A9A28;
        Mon, 19 Aug 2019 05:53:28 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 791583F246;
        Mon, 19 Aug 2019 05:53:26 -0700 (PDT)
Date:   Mon, 19 Aug 2019 13:53:21 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] arm64: KPROBES_ON_FTRACE
Message-ID: <20190819125321.GA9927@lakrids.cambridge.arm.com>
References: <20190819192422.5ed79702@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819192422.5ed79702@xhacker.debian>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 19, 2019 at 11:35:27AM +0000, Jisheng Zhang wrote:
> Implement KPROBES_ON_FTRACE for arm64.

It would be very helpful if the cover letter could explain what
KPROBES_ON_FTRACE is, and why it is wanted.

It's not clear to me whether this is enabling new functionality for
kprobes via ftrace, or whether this is an optimization for kprobes using
ftrace under the hood.

Thanks,
Mark.

> 
> Applied after FTRACE_WITH_REGS:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2019-August/674404.html
> 
> Jisheng Zhang (4):
>   kprobes: adjust kprobe addr for KPROBES_ON_FTRACE
>   kprobes/x86: use instruction_pointer and instruction_pointer_set
>   kprobes: move kprobe_ftrace_handler() from x86 and make it weak
>   arm64: implement KPROBES_ON_FTRACE
> 
>  arch/arm64/Kconfig                |  1 +
>  arch/arm64/kernel/probes/Makefile |  1 +
>  arch/arm64/kernel/probes/ftrace.c | 16 +++++++++++
>  arch/x86/kernel/kprobes/ftrace.c  | 43 ----------------------------
>  kernel/kprobes.c                  | 47 +++++++++++++++++++++++++++++++
>  5 files changed, 65 insertions(+), 43 deletions(-)
>  create mode 100644 arch/arm64/kernel/probes/ftrace.c
> 
> -- 
> 2.23.0.rc1
> 
