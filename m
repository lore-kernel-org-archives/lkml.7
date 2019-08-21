Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16786C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BAC2332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566352375;
	bh=Fk4BuAJQ/UfY9FS0/yq7nmtZd1hFBjcyaLZT6Qsj3rQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kyL64bHvrg+07g5hrwFKGKTLmEytaWqaG0+RpLj+Z8Jnd81hSp5nAdAQIce6HrD4O
	 yVh1R9tl6eNV+eDR9wLtrx+VL+VWoInKOXCyQ7fKhCwQ64M3Zcran7kFYbaeD1bgVm
	 Y4xS3MTL7AhpO7+9VfeCkEwm8k/PFPRaj8OLaRpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfHUBwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 21:52:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfHUBwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 21:52:55 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFADC22DD3;
        Wed, 21 Aug 2019 01:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566352374;
        bh=Fk4BuAJQ/UfY9FS0/yq7nmtZd1hFBjcyaLZT6Qsj3rQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k4TG6qwivdIYF+iiueoI0OgTmUJAFVF88b4Py7H64RPYZqf4RhvPKeCawLZ2wpM1r
         mMb3j5D0cEZm0+cLYXJ8ZcxeoV2G6H3MiJ5foTHnoGmWyIRNDTdujFYW/2KQsb9v0+
         O5CPI4WDm44Zd1wOt/HIKUhDpSEy/rbt0NfRv/cs=
Date:   Wed, 21 Aug 2019 10:52:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] kprobes/x86: use instruction_pointer and
 instruction_pointer_set
Message-Id: <20190821105247.f0236d2c04b2c0c4d4e1847e@kernel.org>
In-Reply-To: <20190820165152.20275268@xhacker.debian>
References: <20190820113928.1971900c@xhacker.debian>
        <20190820114109.4624d56b@xhacker.debian>
        <alpine.DEB.2.21.1908201050370.2223@nanos.tec.linutronix.de>
        <20190820165152.20275268@xhacker.debian>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On Tue, 20 Aug 2019 09:02:59 +0000
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> Hi Thomas,
> 
> On Tue, 20 Aug 2019 10:53:58 +0200 (CEST) Thomas Gleixner wrote:
> 
> > 
> > 
> > On Tue, 20 Aug 2019, Jisheng Zhang wrote:
> > 
> > > This is to make the x86 kprobe_ftrace_handler() more common so that
> > > the code could be reused in future.  
> > 
> > While I agree with the change in general, I can't find anything which
> > reuses that code. So the change log is pretty useless and I have no idea
> > how this is related to the rest of the series.
> 
> In v1, this code is moved from x86 to common kprobes.c [1]
> But I agree with Masami, consolidation could be done when arm64 kprobes
> on ftrace is stable.

We'll revisit to consolidate the code after we got 3rd or 4th clones.

> 
> In v2, actually, the arm64 version's kprobe_ftrace_handler() is the same
> as x86's, the only difference is comment, e.g
> 
> /* Kprobe handler expects regs->ip = ip + 1 as breakpoint hit */
> 
> while in arm64
> 
> /* Kprobe handler expects regs->pc = ip + 1 as breakpoint hit */

As Peter pointed, on arm64, is that really 1 or 4 bytes?
This part is heavily depends on the processor software-breakpoint
implementation.

> 
> 
> W/ above, any suggestion about the suitable change log?

I think you just need to keep the first half of the description.
Since this patch itself is not related to the series, could you update
the description and resend it as a single cleanup patch out of the series?

Thank you!

> 
> Thanks
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2019-August/674417.html


-- 
Masami Hiramatsu <mhiramat@kernel.org>
