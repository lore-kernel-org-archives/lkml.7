Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87682C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 23:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AFE206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 23:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbfEVXLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 19:11:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbfEVXLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 19:11:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 14AEA3084294;
        Wed, 22 May 2019 23:11:49 +0000 (UTC)
Received: from treble (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 202731001284;
        Wed, 22 May 2019 23:11:47 +0000 (UTC)
Date:   Wed, 22 May 2019 18:11:46 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <Raphael.Gault@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Julien Thierry <Julien.Thierry@arm.com>
Subject: Re: [RFC V2 00/16] objtool: Add support for Arm64
Message-ID: <20190522231146.vw43gkah2npeouj3@treble>
References: <20190516103655.5509-1-raphael.gault@arm.com>
 <20190516142917.nuhh6dmfiufxqzls@treble>
 <26692833-0e5b-cfe0-0ffd-c2c2f0815935@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26692833-0e5b-cfe0-0ffd-c2c2f0815935@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 22 May 2019 23:11:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 12:50:57PM +0000, Raphael Gault wrote:
> Hi Josh,
> 
> Thanks for offering your help and sorry for the late answer.
> 
> My understanding is that a table of offsets is built by GCC, those
> offsets being scaled by 4 before adding them to the base label.
> I believe the offsets are stored in the .rodata section. To find the
> size of that table, it is needed to find a comparison, which can be
> optimized out apprently. In that case the end of the array can be found
> by locating labels pointing to data behind it (which is not 100% safe).
> 
> On 5/16/19 3:29 PM, Josh Poimboeuf wrote:
> > On Thu, May 16, 2019 at 11:36:39AM +0100, Raphael Gault wrote:
> >> Noteworthy points:
> >> * I still haven't figured out how to detect switch-tables on arm64. I
> >> have a better understanding of them but still haven't implemented checks
> >> as it doesn't look trivial at all.
> >
> > Switch tables were tricky to get right on x86.  If you share an example
> > (or even just a .o file) I can take a look.  Hopefully they're somewhat
> > similar to x86 switch tables.  Otherwise we may want to consider a
> > different approach (for example maybe a GCC plugin could help annotate
> > them).
> >
> 
> The case which made me realize the issue is the one of
> arch/arm64/kernel/module.o:apply_relocate_add:
> 
> ```
> What seems to happen in the case of module.o is:
>   334:   90000015        adrp    x21, 0 <do_reloc>
> which retrieves the location of an offset in the rodata section, and a
> bit later we do some extra computation with it in order to compute the
> jump destination:
>   3e0:   78625aa0        ldrh    w0, [x21, w2, uxtw #1]
>   3e4:   10000061        adr     x1, 3f0 <apply_relocate_add+0xf8>
>   3e8:   8b20a820        add     x0, x1, w0, sxth #2
>   3ec:   d61f0000        br      x0
> ```
> 
> Please keep in mind that the actual offsets might vary.
> 
> I'm happy to provide more details about what I have identified if you
> want me to.

Thanks.  I'll try to take a deeper look.

Were these patches based on tip/master?  There were some minor conflicts
in arch/arm64/Kconfig and arch/arm64/kernel/Makefile.

I'm also getting a build failure on arm64:

  make[4]: *** No rule to make target '/root/linux/tools/objtool/arch/arm64/arch_special.o', needed by '/root/linux/tools/objtool/arch/arm64/objtool-in.o'.  Stop

It looks like arch/arm64/Build and arch/x86/Build are trying to build
from arch_special.c which doesn't exist.

-- 
Josh
