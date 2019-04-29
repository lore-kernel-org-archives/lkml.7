Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E1EC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0BF20449
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfD2Ikd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:40:33 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:34164 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727517AbfD2Ikd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:40:33 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07727315|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.115371-0.00976564-0.874864;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16367;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.ERaYIfo_1556527229;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.ERaYIfo_1556527229)
          by smtp.aliyun-inc.com(10.147.41.178);
          Mon, 29 Apr 2019 16:40:29 +0800
Date:   Mon, 29 Apr 2019 16:39:40 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, guoren@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] riscv: Add perf callchain support
Message-ID: <20190429083940.GA22718@vmh-VirtualBox>
References: <195185ea63240ed396026505d96d1f6449963482.1554961908.git.han_mao@c-sky.com>
 <mhng-dd1d2b4c-122f-48d8-ac56-1c6bff93f236@palmer-si-x1e>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-dd1d2b4c-122f-48d8-ac56-1c6bff93f236@palmer-si-x1e>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 02:11:00PM -0700, Palmer Dabbelt wrote:
> On Thu, 11 Apr 2019 00:53:48 PDT (-0700), han_mao@c-sky.com wrote:
> >+	if (!kstack_end((void *)frame->fp) &&
> >+	    !((unsigned long)frame->fp & 0x3) &&
> >+	    ((unsigned long)frame->fp >= TASK_SIZE)) {
> >+		frame->ra = ((struct stackframe *)frame->fp - 1)->ra;
> >+		frame->fp = ((struct stackframe *)frame->fp - 1)->fp;
> 
> It looks like this depends on having a frame pointer?  In that case, shouldn't
> we add some Kconfig logic to make CONFIG_PERF_EVENTS select
> -fno-omit-frame-pointer?  Frame pointers aren't enabled by default on RISC-V
> and therefor are unlikely to exist at all.
>

Yes, frame pointer is required for kernel backtrace, -fno-omit-frame-pointer
should be added if frame pointer is not enabled by default on RISC-V.
When I testing the callchain support with buildroot chunk
git://git.busybox.net/buildroot
cbf1d861fadb491eee6e3686019d8f67d7f4ad85
both kernel and user program have fp without adding any extra option,
so I thought frame pointer was enabled by default.

ffffffe0000009ee <kernel_init_freeable>:
ffffffe0000009ee:       711d                    addi    sp,sp,-96
ffffffe0000009f0:       ec86                    sd      ra,88(sp)
ffffffe0000009f2:       e8a2                    sd      s0,80(sp)
ffffffe0000009f4:       e4a6                    sd      s1,72(sp)

void test_3(void)
{
   10498:       fe010113                addi    sp,sp,-32
   1049c:       00113c23                sd      ra,24(sp)
   104a0:       00813823                sd      s0,16(sp)
   104a4:       02010413                addi    s0,sp,32

> >+		/* make sure CONFIG_FUNCTION_GRAPH_TRACER is turned on */
> 
> Should that also be mandated by a Kconfig?
>

Yes, it is required for ftrace_graph_ret_addr support.
It's already default for ARCH_RV64I in Kconfig.
 
> >+/*
> >+ * This will be called when the target is in user mode
> >+ * This function will only be called when we use
> >+ * "PERF_SAMPLE_CALLCHAIN" in
> >+ * kernel/events/core.c:perf_prepare_sample()
> >+ *
> >+ * How to trigger perf_callchain_[user/kernel] :
> >+ * $ perf record -e cpu-clock --call-graph fp ./program
> >+ * $ perf report --call-graph
> >+ *
> >+ * On RISC-V platform, the program being sampled and the C library
> >+ * need to be compiled with * -mbacktrace, otherwise the user
> 
> What is "-mbacktrace"?  I don't remember that ever being a RISC-V GCC option,
> and my compiler doesn't undersand it.  It understands "-fbacktrace" but that
> doesn't produce a frame pointer.
>

It's a csky specific option, I forget to modify the comment.
So it should be -fno-omit-frame-pointer here.

Thanks,
Mao Han
