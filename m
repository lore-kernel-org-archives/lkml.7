Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322D2C32793
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 03:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A572133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 03:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732664AbfJADSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 23:18:42 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:1980 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732587AbfJADSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 23:18:42 -0400
X-UUID: 271dd87e884843da8df7176d4f5ca353-20191001
X-UUID: 271dd87e884843da8df7176d4f5ca353-20191001
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1212956700; Tue, 01 Oct 2019 11:18:37 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkexhb01.mediatek.inc (172.21.101.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 1 Oct 2019 11:18:35 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 1 Oct 2019 11:18:35 +0800
Message-ID: <1569899916.17361.36.camel@mtksdccf07>
Subject: Re: [PATCH] kasan: fix the missing underflow in memmove and memcpy
 with CONFIG_KASAN_GENERIC=y
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 1 Oct 2019 11:18:36 +0800
In-Reply-To: <CACT4Y+b3NPemYwJJsD_oC0vde5Ybz1qDNWb=cFu2HpOTMrGSnQ@mail.gmail.com>
References: <20190927034338.15813-1-walter-zh.wu@mediatek.com>
         <CACT4Y+Zxz+R=qQxSMoipXoLjRqyApD3O0eYpK0nyrfGHE4NNPw@mail.gmail.com>
         <1569594142.9045.24.camel@mtksdccf07>
         <CACT4Y+YuAxhKtL7ho7jpVAPkjG-JcGyczMXmw8qae2iaZjTh_w@mail.gmail.com>
         <1569818173.17361.19.camel@mtksdccf07>
         <a3a5e118-e6da-8d6d-5073-931653fa2808@free.fr>
         <1569897400.17361.27.camel@mtksdccf07>
         <CACT4Y+b3NPemYwJJsD_oC0vde5Ybz1qDNWb=cFu2HpOTMrGSnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-01 at 05:01 +0200, Dmitry Vyukov wrote:
> On Tue, Oct 1, 2019 at 4:36 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> >
> > On Mon, 2019-09-30 at 10:57 +0200, Marc Gonzalez wrote:
> > > On 30/09/2019 06:36, Walter Wu wrote:
> > >
> > > >  bool check_memory_region(unsigned long addr, size_t size, bool write,
> > > >                                 unsigned long ret_ip)
> > > >  {
> > > > +       if (long(size) < 0) {
> > > > +               kasan_report_invalid_size(src, dest, len, _RET_IP_);
> > > > +               return false;
> > > > +       }
> > > > +
> > > >         return check_memory_region_inline(addr, size, write, ret_ip);
> > > >  }
> > >
> > > Is it expected that memcpy/memmove may sometimes (incorrectly) be passed
> > > a negative value? (It would indeed turn up as a "large" size_t)
> > >
> > > IMO, casting to long is suspicious.
> > >
> > > There seem to be some two implicit assumptions.
> > >
> > > 1) size >= ULONG_MAX/2 is invalid input
> > > 2) casting a size >= ULONG_MAX/2 to long yields a negative value
> > >
> > > 1) seems reasonable because we can't copy more than half of memory to
> > > the other half of memory. I suppose the constraint could be even tighter,
> > > but it's not clear where to draw the line, especially when considering
> > > 32b vs 64b arches.
> > >
> > > 2) is implementation-defined, and gcc works "as expected" (clang too
> > > probably) https://gcc.gnu.org/onlinedocs/gcc/Integers-implementation.html
> > >
> > > A comment might be warranted to explain the rationale.
> > > Regards.
> >
> > Thanks for your suggestion.
> > Yes, It is passed a negative value issue in memcpy/memmove/memset.
> > Our current idea should be assumption 1 and only consider 64b arch,
> > because KASAN only supports 64b. In fact, we really can't use so much
> > memory in 64b arch. so assumption 1 make sense.
> 
> Note there are arm KASAN patches floating around, so we should not
> make assumptions about 64-bit arch.
I think arm KASAN patch doesn't merge in mainline, because virtual
memory of shadow memory is so bigger, the kernel virtual memory only has
1GB or 2GB in 32-bit arch, it is hard to solve the issue. it may need
some trade-off.

> 
> But there seems to be a number of such casts already:
> 
It seems that everyone is the same assumption.

> $ find -name "*.c" -exec egrep "\(long\).* < 0" {} \; -print
>     } else if ((long) delta < 0) {
> ./kernel/time/timer.c
>     if ((long)state < 0)
> ./drivers/thermal/thermal_sysfs.c
>     if ((long)delay < 0)
> ./drivers/infiniband/core/addr.c
>     if ((long)tmo < 0)
> ./drivers/net/wireless/st/cw1200/pm.c
>     if (pos < 0 || (long) pos != pos || (ssize_t) count < 0)
> ./sound/core/info.c
>         if ((long)hwrpb->sys_type < 0) {
> ./arch/alpha/kernel/setup.c
>     if ((long)m->driver_data < 0)
> ./arch/x86/kernel/apic/apic.c
>             if ((long) size < 0L)
>     if ((long)addr < 0L) {
> ./arch/sparc/mm/init_64.c
>     if ((long)lpid < 0)
> ./arch/powerpc/kvm/book3s_hv.c
>             if ((long)regs->regs[insn.mm_i_format.rs] < 0)
>             if ((long)regs->regs[insn.i_format.rs] < 0) {
>             if ((long)regs->regs[insn.i_format.rs] < 0) {
> ./arch/mips/kernel/branch.c
>             if ((long)arch->gprs[insn.i_format.rs] < 0)
>             if ((long)arch->gprs[insn.i_format.rs] < 0)
> ./arch/mips/kvm/emulate.c
>             if ((long)regs->regs[insn.i_format.rs] < 0)
> ./arch/mips/math-emu/cp1emu.c
>         if ((int32_t)(long)prom_vec < 0) {
> ./arch/mips/sibyte/common/cfe.c
>     if (msgsz > ns->msg_ctlmax || (long) msgsz < 0 || msqid < 0)
>     if (msqid < 0 || (long) bufsz < 0)
> ./ipc/msg.c
>     if ((long)x < 0)
> ./mm/page-writeback.c
>     if ((long)(next - val) < 0) {
> ./mm/memcontrol.c


