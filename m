Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30371C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF7220844
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfHSK4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:56:24 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:49220 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbfHSK4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:56:24 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07440019|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.340673-0.0196074-0.63972;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03303;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.FEaxY0q_1566212179;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.FEaxY0q_1566212179)
          by smtp.aliyun-inc.com(10.147.44.129);
          Mon, 19 Aug 2019 18:56:19 +0800
Date:   Mon, 19 Aug 2019 18:56:19 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH V3 0/3] riscv: Add perf callchain support
Message-ID: <20190819105618.GA6377@vmh-VirtualBox>
References: <cover.1558081981.git.han_mao@c-sky.com>
 <alpine.DEB.2.21.9999.1908161008450.18249@viisi.sifive.com>
 <20190819081758.GA15999@vmh-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819081758.GA15999@vmh-VirtualBox>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 04:18:01PM +0800, Mao Han wrote:
> Hi Paul,
> On Fri, Aug 16, 2019 at 10:14:01AM -0700, Paul Walmsley wrote:
> > Hello Mao Han,
> > 
> > On Fri, 17 May 2019, Mao Han wrote:
> > 
> > > This patch set add perf callchain(FP/DWARF) support for RISC-V.
> > > It comes from the csky version callchain support with some
> > > slight modifications. The patchset base on Linux 5.1.
> > > 
> > > CC: Palmer Dabbelt <palmer@sifive.com>
> > > CC: linux-riscv <linux-riscv@lists.infradead.org>
> > > CC: Christoph Hellwig <hch@lst.de>
> > > CC: Guo Ren <guoren@kernel.org>
> > 
> > I tried these patches on v5.3-rc4, both on the HiFive Unleashed board 
> > with a Debian-based rootfs and QEMU rv64 with a Fedora-based rootfs.  For 
> > QEMU, I used defconfig, and for the HiFive Unleashed, I added a few more 
> > Kconfig directives; and on both, I enabled CONFIG_PERF_EVENTS.  I built 
> > the perf tools from the kernel tree.
> > 
> > Upon running "/root/bin/perf record -e cpu-clock --call-graph fp 
> > /bin/ls", I see the backtraces below.  The first is on the HiFive 
> > Unleashed, the second is on QEMU.  
> > 
> > Could you take a look and tell me if you see similar issues?  And if not, 
> > could you please walk me through your process for testing these patches on 
> > rv64, so I can reproduce it here?
> >
> 
> I'v tried the command line above and got similar issues with probability.
> unwind_frame_kernel can not stop unwind when fp is a quite large
> value(like 0x70aac93ff0eff584) which can pass the simple stack check.
>         if (kstack_end((void *)frame->fp))
>                 return -EPERM;
>         if (frame->fp & 0x3 || frame->fp < TASK_SIZE)
>                 return -EPERM;
> handle_exception from arch/riscv/kernel/entry.S will use s0(fp) as temp
> register. The context for this frame is unpredictable. We may add more
> strict check in unwind_frame_kernel or keep s0 always 0 in handle_exception
> to fix this issue.
> 

perf record -e cpu-clock --call-graph fp /bin/ls seems can work stably
with this change applied.
diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
index 8b57903..dd27c67 100644
--- a/arch/riscv/kernel/perf_callchain.c
+++ b/arch/riscv/kernel/perf_callchain.c
@@ -16,6 +16,8 @@ static int unwind_frame_kernel(struct stackframe *frame)
                return -EPERM;
        if (frame->fp & 0x3 || frame->fp < TASK_SIZE)
                return -EPERM;
+        if (frame->fp < CONFIG_PAGE_OFFSET)
+                return -EPERM;
 
        *frame = *((struct stackframe *)frame->fp - 1);
        if (__kernel_text_address(frame->ra)) {


PS: I got some compile error while compiling glibc 2.30 with linux
v5.3-rc4 header. vfork.S include linux/sched.h(./include/uapi/linux/sched.h)
which has a struct clone_args inside, added by
7f192e3cd316ba58c88dfa26796cf77789dd9872.

