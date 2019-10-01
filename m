Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82745C32792
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 03:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4762087F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 03:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j8TZ3XWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbfJADCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 23:02:12 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37849 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfJADCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 23:02:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id u184so9834826qkd.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 20:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NhU6yRd8rVi5W+b69famc3Wf+MRe5kZVRUYy3CZ04Qw=;
        b=j8TZ3XWt0rI+swgMAWG81IXe5bl3Mhp5Chfya22s00LvC2Qmaf21KWfpEq8VJ/MA8u
         iNhpL1/brVJ+WU5XJYYZLVgDbmD5roZeLEVCh3uhhAIB6Q7ldaHczGUfocR60s6gObys
         m1er4eyRCMglLPOygxeOlI4qFX7IKY66zuJwxiELQ/W3LoyKgzhnVXdJGqoQVZMXVAUC
         9KZuZ4rvVUmmQRBfr7LB1410few7nJXjYhZZqwfeEapnyqWRbKVK0cWhG6As5U6voF8R
         WYq499oUGxyH2Wy8JFjNthb89vV4tpHC/CAcFD2ijFpq6FcNQRn521nsK+FRvOmPctmD
         uTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NhU6yRd8rVi5W+b69famc3Wf+MRe5kZVRUYy3CZ04Qw=;
        b=TUzrI58uqSvB7vkwP13gmsQpjuoVE5G2v5TPzatl1U4LB1GljnnTL774KoaaS+242A
         q2OlEj7aRC1wOKn1YjKwKdVD0yUBXxOFDPvmPk3MTj/gGojjmMHGpjiisiOL1ZVLjJin
         bzEKMsgo5iFUqQKp0htF75U5m6vS/PkK/jsbxS4pVyfeFqlP7k8Bst/TmJigXLsstXZy
         42mYu1NRUx67meiNKIDNJiftm+TxlQjPZIl+DQbgItoITbP3/ayiaj1q51EwVGGgwItE
         p/FDaiwhTMMnZ6682LKsxwQOdoNPrPk8Jf6rX5Sxw7UaO1k3voCV8IxjFTpJLJ1K1Ws6
         Yn7g==
X-Gm-Message-State: APjAAAX19UNzNlt5Xl/C2+0Xe7gTNbWTtZ4kJUZ9gCdXIMHaxVp7X6YF
        CI0JsWaMdvW7e44HefNuir5iojHlMysq2Rnce02DgQ==
X-Google-Smtp-Source: APXvYqyuGC+X6DqxkXQJnINPoHMvpwc54U1WbIB3aUskUWBOJyL6MJ7/tA34rkq9cIbagHqaomA+H0vqIGNs+aOtpFY=
X-Received: by 2002:a37:d84:: with SMTP id 126mr3460614qkn.407.1569898930461;
 Mon, 30 Sep 2019 20:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190927034338.15813-1-walter-zh.wu@mediatek.com>
 <CACT4Y+Zxz+R=qQxSMoipXoLjRqyApD3O0eYpK0nyrfGHE4NNPw@mail.gmail.com>
 <1569594142.9045.24.camel@mtksdccf07> <CACT4Y+YuAxhKtL7ho7jpVAPkjG-JcGyczMXmw8qae2iaZjTh_w@mail.gmail.com>
 <1569818173.17361.19.camel@mtksdccf07> <a3a5e118-e6da-8d6d-5073-931653fa2808@free.fr>
 <1569897400.17361.27.camel@mtksdccf07>
In-Reply-To: <1569897400.17361.27.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 1 Oct 2019 05:01:58 +0200
Message-ID: <CACT4Y+b3NPemYwJJsD_oC0vde5Ybz1qDNWb=cFu2HpOTMrGSnQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix the missing underflow in memmove and memcpy
 with CONFIG_KASAN_GENERIC=y
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 4:36 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> On Mon, 2019-09-30 at 10:57 +0200, Marc Gonzalez wrote:
> > On 30/09/2019 06:36, Walter Wu wrote:
> >
> > >  bool check_memory_region(unsigned long addr, size_t size, bool write,
> > >                                 unsigned long ret_ip)
> > >  {
> > > +       if (long(size) < 0) {
> > > +               kasan_report_invalid_size(src, dest, len, _RET_IP_);
> > > +               return false;
> > > +       }
> > > +
> > >         return check_memory_region_inline(addr, size, write, ret_ip);
> > >  }
> >
> > Is it expected that memcpy/memmove may sometimes (incorrectly) be passed
> > a negative value? (It would indeed turn up as a "large" size_t)
> >
> > IMO, casting to long is suspicious.
> >
> > There seem to be some two implicit assumptions.
> >
> > 1) size >= ULONG_MAX/2 is invalid input
> > 2) casting a size >= ULONG_MAX/2 to long yields a negative value
> >
> > 1) seems reasonable because we can't copy more than half of memory to
> > the other half of memory. I suppose the constraint could be even tighter,
> > but it's not clear where to draw the line, especially when considering
> > 32b vs 64b arches.
> >
> > 2) is implementation-defined, and gcc works "as expected" (clang too
> > probably) https://gcc.gnu.org/onlinedocs/gcc/Integers-implementation.html
> >
> > A comment might be warranted to explain the rationale.
> > Regards.
>
> Thanks for your suggestion.
> Yes, It is passed a negative value issue in memcpy/memmove/memset.
> Our current idea should be assumption 1 and only consider 64b arch,
> because KASAN only supports 64b. In fact, we really can't use so much
> memory in 64b arch. so assumption 1 make sense.

Note there are arm KASAN patches floating around, so we should not
make assumptions about 64-bit arch.

But there seems to be a number of such casts already:

$ find -name "*.c" -exec egrep "\(long\).* < 0" {} \; -print
    } else if ((long) delta < 0) {
./kernel/time/timer.c
    if ((long)state < 0)
./drivers/thermal/thermal_sysfs.c
    if ((long)delay < 0)
./drivers/infiniband/core/addr.c
    if ((long)tmo < 0)
./drivers/net/wireless/st/cw1200/pm.c
    if (pos < 0 || (long) pos != pos || (ssize_t) count < 0)
./sound/core/info.c
        if ((long)hwrpb->sys_type < 0) {
./arch/alpha/kernel/setup.c
    if ((long)m->driver_data < 0)
./arch/x86/kernel/apic/apic.c
            if ((long) size < 0L)
    if ((long)addr < 0L) {
./arch/sparc/mm/init_64.c
    if ((long)lpid < 0)
./arch/powerpc/kvm/book3s_hv.c
            if ((long)regs->regs[insn.mm_i_format.rs] < 0)
            if ((long)regs->regs[insn.i_format.rs] < 0) {
            if ((long)regs->regs[insn.i_format.rs] < 0) {
./arch/mips/kernel/branch.c
            if ((long)arch->gprs[insn.i_format.rs] < 0)
            if ((long)arch->gprs[insn.i_format.rs] < 0)
./arch/mips/kvm/emulate.c
            if ((long)regs->regs[insn.i_format.rs] < 0)
./arch/mips/math-emu/cp1emu.c
        if ((int32_t)(long)prom_vec < 0) {
./arch/mips/sibyte/common/cfe.c
    if (msgsz > ns->msg_ctlmax || (long) msgsz < 0 || msqid < 0)
    if (msqid < 0 || (long) bufsz < 0)
./ipc/msg.c
    if ((long)x < 0)
./mm/page-writeback.c
    if ((long)(next - val) < 0) {
./mm/memcontrol.c
