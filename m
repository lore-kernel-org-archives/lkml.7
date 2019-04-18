Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE19C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E377D21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mG0tYTmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389272AbfDROLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:11:32 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34046 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388495AbfDROLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:11:32 -0400
Received: by mail-ua1-f66.google.com with SMTP id c6so810498uan.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YmPgqTO/Ej1YV//EeHsX93xlvTquoKBPoI/41sJ9W2s=;
        b=mG0tYTmWwlCehrvbHFJO44406SoJzEWxnY7l/5J8jhSuzBDjJEiJVa4sNaA7OndfSj
         qJZ/Q6KJVcV8kfX9Sh2glwX5FGzLAGZ4fq3EeFIUdBwML2+hNyP2KiEU/r9DkimTl/F5
         ZEynTUoXtfL/BT69F+A2K2gDWMdWNZ7pmprJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YmPgqTO/Ej1YV//EeHsX93xlvTquoKBPoI/41sJ9W2s=;
        b=ss7+pEPBQmVSfA1Jklv2tnU04EgaarKdOOqecP2iDkkFU9tjfRITw5WHQqQ3HFAgVU
         lZjhsm38NXXgTPV3+sZOSZUuNyy9r+ik1EFxq7qtnla5L98SxSstessGCIpRwuPOztVr
         g33tj3/gq5JXKbSLvLUD1306Df5i/yV/7WW4H/tySY+3srzTdBj4oSPAOZ9FpsrQghrp
         hd5v3J4nrWAaQLvGl/GCdDGG/hgvjsDbYwxXveIcq00cZFdewCXlLAOOIeE3imDyDw41
         zJgqH4zN5YgyT73QAe3QaV6gWKNlMfZuwFlZjLXGr+WpHPjPaatlWPakRtSPP60h6mJM
         XbeA==
X-Gm-Message-State: APjAAAWTOTyfM43UtGSwWHIsIUn2nUmUjy2TlaG9aOt0KWMfcjbG2OWV
        zO87L+XaMh2hc4zQ4NIcajcc/NwN998=
X-Google-Smtp-Source: APXvYqxAF7QWPOoOobx8wmCDXXsEcMYRTBvLTPUZtsDD6RzT4iPwjjZ1vQ8gTHOq2Cr/jJEHlz5agQ==
X-Received: by 2002:ab0:2653:: with SMTP id q19mr7054738uao.76.1555596690166;
        Thu, 18 Apr 2019 07:11:30 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id e198sm483990vsc.3.2019.04.18.07.11.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 07:11:28 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id d5so797757uan.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 07:11:27 -0700 (PDT)
X-Received: by 2002:a9f:3fce:: with SMTP id m14mr50781446uaj.96.1555596686834;
 Thu, 18 Apr 2019 07:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <1462963502-11636-1-git-send-email-hecmargi@upv.es>
 <CAGXu5jLZ-DgTfokLTqUHOUphO4C1FwHgYDLTA1oB9HBHnH-a1Q@mail.gmail.com> <alpine.DEB.2.21.1904181015270.3174@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904181015270.3174@nanos.tec.linutronix.de>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Apr 2019 09:11:15 -0500
X-Gmail-Original-Message-ID: <CAGXu5jK+-eVzhxTB418b1BCqFw5oVpdDhmCqE2Gn2_rFTf2E1A@mail.gmail.com>
Message-ID: <CAGXu5jK+-eVzhxTB418b1BCqFw5oVpdDhmCqE2Gn2_rFTf2E1A@mail.gmail.com>
Subject: Re: [PATCH] x86_64: Disabling read-implies-exec when the stack is executable
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Hector Marco-Gisbert <hecmargi@upv.es>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Huaitong Han <huaitong.han@intel.com>,
        Ismael Ripoll Ripoll <iripoll@upv.es>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 3:17 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, 18 Apr 2019, Kees Cook wrote:
> > On Wed, May 11, 2016 at 5:45 AM Hector Marco-Gisbert <hecmargi@upv.es> wrote:
> > *thread necromancy*
> >
> > I'd still like to see this get landed. READ_IMPLIES_EXEC is way too
> > powerful (it impacts, for example, mmap() regions of device driver
> > memory, forcing drivers to not be able to disallow VM_EXEC[1]).
> >
> > The only case it could break is on an AMD K8 (Athlon only, I assume?),
> > which seems unlikely to have a modern kernel run on it. If there is
> > still concern, then we could just test against the NX CPU feature:
> >
> > diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> > index 69c0f892e310..367cd36259a4 100644
> > --- a/arch/x86/include/asm/elf.h
> > +++ b/arch/x86/include/asm/elf.h
> > @@ -280,10 +280,12 @@ extern u32 elf_hwcap2;
> >
> >  /*
> >   * An executable for which elf_read_implies_exec() returns TRUE will
> > - * have the READ_IMPLIES_EXEC personality flag set automatically.
> > + * have the READ_IMPLIES_EXEC personality flag set automatically when
> > + * a CPU did not support NX or is using a 32-bit memory layout.
> >   */
> > -#define elf_read_implies_exec(ex, executable_stack)    \
> > -       (executable_stack != EXSTACK_DISABLE_X)
> > +#define elf_read_implies_exec(ex, executable_stack)            \
> > +       (mmap_is_ia32() || !(__supported_pte_mask & _PAGE_NX) ? \
>
> What's special about ia32? All what matters is whether PAGE_NX is supported
> or not. That has nothing to do with 32/64bit unless I'm missing something
> (as usual).

I think the reasoning was that older toolchains from ia32 wouldn't
provide any permissions marking at all, and this was a signal that it
might need executable heaps as well as stack. So, since ia32 gained NX
along the way, lacking the gnu-stack marking was a reasonable
indicator that the ELF needed this crazy setting to effectively
disable NX for the ELF.

But yes, just looking at the NX feature should cover this.

One thing I'd also like to adjust is the logic about the gnu-stack
existing and requesting an executable stack should apply only to the
stack, and not trigger READ_IMPLIES_EXEC. i.e. if the ELF has
gnu-stack marking of any kind, it should never flag READ_IMPLIES_EXEC.
It would, of course, continue to control the stack perms.

And if this is wrong ... well, we'll find out how and we can more
correctly document this. So how about:

#define elf_read_implies_exec(ex, executable_stack)            \
       (!(__supported_pte_mask & _PAGE_NX) &&  \
        (executable_stack == EXSTACK_DEFAULT))


-- 
Kees Cook
