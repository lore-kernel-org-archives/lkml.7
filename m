Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053E3C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2618216FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUQVg5Ps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfGIHYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:24:42 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33872 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfGIHYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:24:42 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so41109878iot.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 00:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uMm8/j9yRMRH4iQPqFsUmwQgdLXGN0EeOqXIdi11IUA=;
        b=dUQVg5PsEBC8sNS6Ko5mv4/t4K3hCsAqHkcyJqYwSeI54TV9HIhBglh0iGBRbuEIuu
         5M75SqaCIZpE4ARE6teF2Xeymege0iPEJUz1ETqQ//XenEbHajapvmxrImOwcNg7OfLC
         PN0wXbJY75I8aGJdzcUVDud0y4Vsb/YMiqjZOTss7bWQ1CpSMxUcFOzXiOvDsCU7tb2h
         lAbni/hhSzXZ988Z5uxonG9nSwpg+roUyxFSvq+bkm2T6MIuCGyROxokpyR2qggdj5F5
         D1ASMOALGfggeW+UrhKQg9l24tUGduKleQsdSiwiFC3WyECJpAOMAr4usJpl7fQ7gTvF
         3Kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMm8/j9yRMRH4iQPqFsUmwQgdLXGN0EeOqXIdi11IUA=;
        b=SAYoH7IvnpffxeUEI3Rk+BEtvblO0mCyQQNiXbNwTeSGyvnhMXA9zlDOv6U+8m6x2I
         VBWrWjt13Z6CMaOWFD1y6p8LSD6DaMjrP+5wq9iB7rDGLNQHt/U8Vp6o2mEmmAxbcxsj
         /MXDKBENpMYFFGxgW3+OnTLfdpFjbvmsOilIOfY8A6jyFvK7xdZWctFRNmxD1GUYq20x
         /z2CEulQsWDOrlhXOQfZqSRh38jNYvLpaGVEJdMBMyEEVswil59rS7f+Bf8wuRIsdTz2
         hNi7i3UChfbr3MOBTQrBQmTJHtzWUCe/8vqQ1miqg/noPXePLvdajC/BaJR0T08FgZvC
         nzPA==
X-Gm-Message-State: APjAAAVlpdR56CNGSpqJk+0hmA401EwYoU4oXCR9lFtSGnLiTMM8oEa0
        aOO/ikdEoqs+dy3Um8ah+dBBu4VTaJCF1nyWiQ==
X-Google-Smtp-Source: APXvYqxZ1TMWNH+36GLrWQQsmnuqHh3EOslMTVV+pbK9EYv2MWK4YLlVK93ISUt77XpQ21YB0euUCe9VBw5T41iKQzU=
X-Received: by 2002:a5e:d60a:: with SMTP id w10mr25150800iom.78.1562657081578;
 Tue, 09 Jul 2019 00:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <1562300143-11671-1-git-send-email-kernelfans@gmail.com>
 <1562300143-11671-2-git-send-email-kernelfans@gmail.com> <alpine.DEB.2.21.1907072133310.3648@nanos.tec.linutronix.de>
 <CAFgQCTvwS+yEkAmCJnsCfnr0JS01OFtBnDg4cr41_GqU79A4Gg@mail.gmail.com>
 <alpine.DEB.2.21.1907081125300.3648@nanos.tec.linutronix.de>
 <CAFgQCTvAOeerLHQvgvFXy_kLs=H=CuUFjYE+UAN+vhPCG+s=pQ@mail.gmail.com> <alpine.DEB.2.21.1907090810490.1961@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907090810490.1961@nanos.tec.linutronix.de>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 9 Jul 2019 15:24:30 +0800
Message-ID: <CAFgQCTui7D6_FQ_v_ijj6k_=+TQzQ3PaGvzxd6p+XEGjQ2S6jw@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/numa: instance all parsed numa node
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Qian Cai <cai@lca.pw>,
        Barret Rhoden <brho@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 2:12 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, 9 Jul 2019, Pingfan Liu wrote:
> > On Mon, Jul 8, 2019 at 5:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > It can and it does.
> > >
> > > That's the whole point why we bring up all CPUs in the 'nosmt' case and
> > > shut the siblings down again after setting CR4.MCE. Actually that's in fact
> > > a 'let's hope no MCE hits before that happened' approach, but that's all we
> > > can do.
> > >
> > > If we don't do that then the MCE broadcast can hit a CPU which has some
> > > firmware initialized state. The result can be a full system lockup, triple
> > > fault etc.
> > >
> > > So when the MCE hits a CPU which is still in the crashed kernel lala state,
> > > then all hell breaks lose.
> > Thank you for the comprehensive explain. With your guide, now, I have
> > a full understanding of the issue.
> >
> > But when I tried to add something to enable CR4.MCE in
> > crash_nmi_callback(), I realized that it is undo-able in some case (if
> > crashed, we will not ask an offline smt cpu to online), also it is
> > needless. "kexec -l/-p" takes the advantage of the cpu state in the
> > first kernel, where all logical cpu has CR4.MCE=1.
> >
> > So kexec is exempt from this bug if the first kernel already do it.
>
> No. If the MCE broadcast is handled by a CPU which is stuck in the old
> kernel stop loop, then it will execute on the old kernel and eventually run
> into the memory corruption which crashed the old one.
>
Yes, you are right. Stuck cpu may execute the old do_machine_check()
code. But I just found out that we have
do_machine_check()->__mc_check_crashing_cpu() to against this case.

And I think the MCE issue with nr_cpus is not closely related with
this series, can
be a separated issue. I had question whether Andy will take it, if
not, I am glad to do it.

Thanks and regards,
  Pingfan
