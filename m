Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F47C46499
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 00:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88398218A4
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 00:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="hmawQpkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfGFA71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 20:59:27 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:43521 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfGFA71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 20:59:27 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x660xLCW011087;
        Sat, 6 Jul 2019 09:59:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x660xLCW011087
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562374762;
        bh=EeZy6/p1xFhPkT8b/ANqMRnyDdlUActKvI7Kj7ETqYA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hmawQpkSR79H3xWUqP6Zu/Hpsiphaumev5mfOqhVgr7ATQnS3YjQanTOYuFW3S4Ha
         YV0a5fWt4jtYhp1bv6Skq59fVy8glhQ3gXSyMiII2RPrSXxS3pNbfaKLnQXpHOZJvR
         O/CauaC0XKy1aREiSnm8lWIkhvIBkmzOXoT0K1UnqZ9+yeHn0v1rKvU3DTSGaQX334
         thlVvvsVKFEz9YjK4nYxTL3KZW9T4OODtM8cBIwjEXDKbOR+Hn36n29Tv9jwwK/r/I
         TlpkhegoPw680vpQ2O8mMx09PbY5/eYHsiTLLHBkYflSMt0J86D1k588aVmblqI/ug
         T/Ec9z3yPIVdQ==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id u3so4794613vsh.6;
        Fri, 05 Jul 2019 17:59:22 -0700 (PDT)
X-Gm-Message-State: APjAAAUR8zO/ifxRmFm1ytwyc9uTfh5pdCWnlL3tHhHhFINjwsb14L2t
        wTY7ofhrNsiXty5Vx8XDmqL0H4at3JCtpJbNTJs=
X-Google-Smtp-Source: APXvYqyxenVC7SaKdwciyiNNZrv4ISN6acClFMSfaNgT8TvBBYOWwdaUwuDEpgNiFcYp1+EOUqkdtYanWi5ZdN/oDcc=
X-Received: by 2002:a67:fc45:: with SMTP id p5mr3872043vsq.179.1562374760874;
 Fri, 05 Jul 2019 17:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190705183104.6fb50bd0@canb.auug.org.au> <MWHPR21MB07845807FA6F9C772D08C8B5D7F40@MWHPR21MB0784.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB07845807FA6F9C772D08C8B5D7F40@MWHPR21MB0784.namprd21.prod.outlook.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 6 Jul 2019 09:58:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNARCyOZFAtiXbH1OCbC8o0eHNzY9m6_Z_XoF7ZUyCZGb4w@mail.gmail.com>
Message-ID: <CAK7LNARCyOZFAtiXbH1OCbC8o0eHNzY9m6_Z_XoF7ZUyCZGb4w@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the kbuild tree
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Sat, Jul 6, 2019 at 9:05 AM Michael Kelley <mikelley@microsoft.com> wrote:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>  Sent: Friday, July 5, 2019 1:31 AM
> >
> > After merging the kbuild tree, today's linux-next build (powerpc
> > allyesconfig) failed like this:
> >
> > In file included from <command-line>:
> > include/clocksource/hyperv_timer.h:18:10: fatal error: asm/mshyperv.h: No such file or
> > directory
> >  #include <asm/mshyperv.h>
> >           ^~~~~~~~~~~~~~~~
> >
> > Caused by commit
> >
> >   34085aeb5816 ("kbuild: compile-test kernel headers to ensure they are self-contained")
> >
> > interacting with commit
> >
> >   dd2cb348613b ("clocksource/drivers: Continue making Hyper-V clocksource ISA agnostic")
> >
> > from the tip tree.
> >
>
> Thomas -- let's remove my two clocksource patches from your 'tip' tree.  I'll need
> a little time to fully understand the self-contained header requirements and restructure
> hyperv_timer.h to avoid this problem.

I do not think you have to drop your patches.

Since <asm/mshyperv.h> only exists in x86,
guarding it by CONFIG_X86 is OK.
So, I think Stephen's patch is OK as-is.

Perhaps, Kbuild is imposing too much burden,
but I'd like to try it and see how it goes.


-- 
Best Regards
Masahiro Yamada
