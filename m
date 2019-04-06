Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F923C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 14:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6ED20B1F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 14:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554559307;
	bh=Qugy+65Xr98HUt0l2CC0BvERrlJmUfNVGq1lBHgSZho=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XCM03zk9CQFDPkI8R/pgw7kglYfNihcigU09UJhzODRzYvEO19kUrYWppv/BpgRjH
	 OMJ8SxtrpJkjwUkLlxaEyyBn4v8jEYTvTVgYL3iKqhWD9If1AiZjrQ3Mr9W09gUYXE
	 zhazqAQDR9BiySlJOZ/SHRWiAJVIyA+RJRtYB7e0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfDFOBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 10:01:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbfDFOBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 10:01:46 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF2152173C
        for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2019 14:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554559304;
        bh=Qugy+65Xr98HUt0l2CC0BvERrlJmUfNVGq1lBHgSZho=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DIo1BrQtXOvKyfihtLdA/N6dNJs0LGl76qFFpbmd1lY+7pCLB0uTfRlOWELzN5KnS
         IjyCK9uzobdBdj6tM7B3AmavD/YmpEFlj2VJdwlcd+O4fsxSMp+JJpKqAFLIZTl1/I
         J3rKelgzpjfpCfVp1+Qba8ip2Qwt3JHXI+9b0Ink=
Received: by mail-wm1-f48.google.com with SMTP id y197so10026356wmd.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 07:01:44 -0700 (PDT)
X-Gm-Message-State: APjAAAWyXYaQcrusCphl2I621RA1GdBy0oz3GkrtsKsv4obly2B0ZmrI
        VT9V5d8luH+o5YxslNmTJAKGadWGG5pDRmWS0180vg==
X-Google-Smtp-Source: APXvYqzoiBlHIR0dAW/8mRX4PUPHm7owoNMi+ygDv6adGkqnE+jsuU0EIoJaKVWEwZCqCYndJcO0VaVmSi2JcjXqKZo=
X-Received: by 2002:a1c:4102:: with SMTP id o2mr11074198wma.91.1554559303207;
 Sat, 06 Apr 2019 07:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <5ca84952.hpEqUp6kap0tafzR%lkp@intel.com> <CALCETrX_ys9dJZOkN7QBjWz9Y1iukQDaJaASPAkGtWvwNkOESw@mail.gmail.com>
In-Reply-To: <CALCETrX_ys9dJZOkN7QBjWz9Y1iukQDaJaASPAkGtWvwNkOESw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 6 Apr 2019 07:01:31 -0700
X-Gmail-Original-Message-ID: <CALCETrWBNTy7u7oXgBXRKXBSM86x7TzM9tqKjMuQ_VNvDaOqzw@mail.gmail.com>
Message-ID: <CALCETrWBNTy7u7oXgBXRKXBSM86x7TzM9tqKjMuQ_VNvDaOqzw@mail.gmail.com>
Subject: Re: 8b275b3754 ("x86/irq/64: Remap the IRQ stack with guard pages"):
 BUG: unable to handle kernel paging request at ffffb659000a1000
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 6, 2019 at 6:54 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Fri, Apr 5, 2019 at 11:38 PM kernel test robot <lkp@intel.com> wrote:
> >
> > Greetings,
> >
> > 0day kernel testing robot got the below dmesg and the first bad commit is
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/stackguards
> >
> > commit 8b275b3754465d502d393f8ae8dd355b7067e73f
> > Author:     Andy Lutomirski <luto@kernel.org>
> > AuthorDate: Fri Jul 13 19:01:23 2018 -0700
> > Commit:     Thomas Gleixner <tglx@linutronix.de>
> > CommitDate: Fri Apr 5 17:04:10 2019 +0200
> >
> >     x86/irq/64: Remap the IRQ stack with guard pages
> >
> >     The IRQ stack lives in percpu space, so an IRQ handler that overflows it
> >     will overwrite other data structures.
> >
> >     Use vmap() to remap the IRQ stack so that it will have the usual guard
> >     pages that vmap/vmalloc allocations have. With this the kernel will panic
> >     immediately on an IRQ stack overflow.
> >
> >     [ tglx: Move the map code to a proper place and invoke it only when a CPU
> >             is about to be brought online. No point in installing the map at
> >             early boot for all possible CPUs. Fail the CPU bringup if the vmap
> >             fails as done for all other preparatory stages in cpu hotplug. ]
> >
> >     Signed-off-by: Andy Lutomirski <luto@kernel.org>
> >     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> I haven't spotted the actual bug yet, but the faulting instruction is:
>
>   2a:    65 8b 35 09 ca 75 63     mov    %gs:*0x6375ca09(%rip),%esi
>     # 0x6375ca3a        <-- trapping instruction
>

Gah, -ETOOLITTLESLEEP.   This is a bit strange:

   e:    4c 8d 74 24 08           lea    0x8(%rsp),%r14
...
  26:    49 83 c6 08              add    $0x8,%r14
  2a:*    4d 8b 7e f8              mov    -0x8(%r14),%r15        <--
trapping instruction

Which is an access to the stack above RSP by a few bytes.  But that
can't be an overflow, since it's *above* RSP.  Is something possibly
screwy with the mapping?

I might have a chance to debug this for real this evening.  Right now
I'm about to try to wrangle a sick kid through an airport.
