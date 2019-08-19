Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2899BC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F7420874
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfHSISI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 04:18:08 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:51141 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726366AbfHSISH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 04:18:07 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07575988|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.0307753-0.00242969-0.966795;FP=0|0|0|0|0|0|0|0;HT=e02c03302;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.FEWH.Ih_1566202681;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.FEWH.Ih_1566202681)
          by smtp.aliyun-inc.com(10.147.40.233);
          Mon, 19 Aug 2019 16:18:01 +0800
Date:   Mon, 19 Aug 2019 16:18:01 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH V3 0/3] riscv: Add perf callchain support
Message-ID: <20190819081758.GA15999@vmh-VirtualBox>
References: <cover.1558081981.git.han_mao@c-sky.com>
 <alpine.DEB.2.21.9999.1908161008450.18249@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1908161008450.18249@viisi.sifive.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Paul,
On Fri, Aug 16, 2019 at 10:14:01AM -0700, Paul Walmsley wrote:
> Hello Mao Han,
> 
> On Fri, 17 May 2019, Mao Han wrote:
> 
> > This patch set add perf callchain(FP/DWARF) support for RISC-V.
> > It comes from the csky version callchain support with some
> > slight modifications. The patchset base on Linux 5.1.
> > 
> > CC: Palmer Dabbelt <palmer@sifive.com>
> > CC: linux-riscv <linux-riscv@lists.infradead.org>
> > CC: Christoph Hellwig <hch@lst.de>
> > CC: Guo Ren <guoren@kernel.org>
> 
> I tried these patches on v5.3-rc4, both on the HiFive Unleashed board 
> with a Debian-based rootfs and QEMU rv64 with a Fedora-based rootfs.  For 
> QEMU, I used defconfig, and for the HiFive Unleashed, I added a few more 
> Kconfig directives; and on both, I enabled CONFIG_PERF_EVENTS.  I built 
> the perf tools from the kernel tree.
> 
> Upon running "/root/bin/perf record -e cpu-clock --call-graph fp 
> /bin/ls", I see the backtraces below.  The first is on the HiFive 
> Unleashed, the second is on QEMU.  
> 
> Could you take a look and tell me if you see similar issues?  And if not, 
> could you please walk me through your process for testing these patches on 
> rv64, so I can reproduce it here?
>

I'v tried the command line above and got similar issues with probability.
unwind_frame_kernel can not stop unwind when fp is a quite large
value(like 0x70aac93ff0eff584) which can pass the simple stack check.
        if (kstack_end((void *)frame->fp))
                return -EPERM;
        if (frame->fp & 0x3 || frame->fp < TASK_SIZE)
                return -EPERM;
handle_exception from arch/riscv/kernel/entry.S will use s0(fp) as temp
register. The context for this frame is unpredictable. We may add more
strict check in unwind_frame_kernel or keep s0 always 0 in handle_exception
to fix this issue.

Breakpoint 1, unwind_frame_kernel (frame=0xffffffe0000057a0 <rcu_init+118>)
    at arch/riscv/kernel/perf_callchain.c:14
14      {
1: /x *frame = {fp = 0xffffffe000005ee0, ra = 0xffffffe000124c90}
(gdb)
Continuing.

Breakpoint 1, unwind_frame_kernel (frame=0xffffffe0000057a0 <rcu_init+118>)
    at arch/riscv/kernel/perf_callchain.c:14
14      {
1: /x *frame = {fp = 0xffffffe000124c74, ra = 0xffffffe000036cba}
(gdb)
Continuing.

Breakpoint 1, unwind_frame_kernel (frame=0xffffffe0000057a0 <rcu_init+118>)
    at arch/riscv/kernel/perf_callchain.c:14
14      {
1: /x *frame = {fp = 0x70aac57ff0eff584, ra = 0x8082614d64ea740a}
(gdb)

Some time perf record can output perf.data correct. something like:
# perf record -e cpu-clock --call-graph fp ls

perf.data
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.012 MB perf.data (102 samples) ]
# 
# perf report
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 102  of event 'cpu-clock'
# Event count (approx.): 25500000
#
# Children      Self  Command  Shared Object      Symbol                           
# ........  ........  .......  .................  .................................
#
    30.39%     0.00%  ls       [kernel.kallsyms]  [k] ret_from_exception
            |
            ---ret_from_exception
               |          
               |--16.67%--do_page_fault
               |          handle_mm_fault
               |          __handle_mm_fault
               |          |          
               |          |--9.80%--filemap_map_pages
               |          |          |          
               |          |          |--3.92%--alloc_set_pte
               |          |          |          page_add_file_rmap
               |          |          |          
               |          |           --3.92%--filemap_map_pages
               |          |          
               |           --0.98%--__do_fault
               |          
               |--8.82%--schedule
               |          __sched_text_start
               |          finish_task_switch
               |          
                --4.90%--__kprobes_text_start
                          irq_exit
                          irq_exit

    28.43%     0.00%  ls       [kernel.kallsyms]  [k] ret_from_syscall
            |
            ---ret_from_syscall
               |          
               |--15.69%--__se_sys_execve
               |          __do_execve_file
               |          search_binary_handler.part.7

I previous tested these patch with a program(callchain_test.c) mostly
running in userspace, so I didn't got this issues.

Thanks,
Mao Han

--zhXaljGHf11kAtnf
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="callchain_test.c"

#include <stdio.h>

void test_4(void)
{
  volatile int i, j;

  for(i = 0; i < 10000000; i++) 
    j=i; 
}

void test_3(void)
{
  volatile int i, j;
  test_4();
  for(i = 0; i < 3000; i++)
    j=i;
}

void test_2(void)
{
  volatile int i, j;
  test_3();
  for(i = 0; i < 3000; i++)
    j=i;
}

void test_1(void)
{
  volatile int i, j;
  test_2();
  for(i = 0; i < 3000; i++)
    j=i;

}

int main(void)
{
  test_1();
  return 0;
}

--zhXaljGHf11kAtnf--
