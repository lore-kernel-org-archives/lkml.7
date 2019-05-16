Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B66C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E652D20848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfEPKq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 06:46:26 -0400
Received: from foss.arm.com ([217.140.101.70]:41402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfEPKqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:46:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AE9519BF;
        Thu, 16 May 2019 03:46:25 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EA4F3F703;
        Thu, 16 May 2019 03:46:24 -0700 (PDT)
Date:   Thu, 16 May 2019 11:46:19 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: vdso: Explicitly add build-id option
Message-ID: <20190516104619.GA29705@fuggles.cambridge.arm.com>
References: <20190515194824.5641-1-labbott@redhat.com>
 <CAK7LNASZnRrSsZSrnw41kintGfmpyj3iz-Vjduk7w3k9iSih-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASZnRrSsZSrnw41kintGfmpyj3iz-Vjduk7w3k9iSih-w@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 01:58:56PM +0900, Masahiro Yamada wrote:
> On Thu, May 16, 2019 at 4:51 AM Laura Abbott <labbott@redhat.com> wrote:
> >
> > Commit 691efbedc60d ("arm64: vdso: use $(LD) instead of $(CC) to
> > link VDSO") switched to using LD explicitly. The --build-id option
> > needs to be passed explicitly, similar to x86. Add this option.
> >
> > Fixes: 691efbedc60d ("arm64: vdso: use $(LD) instead of $(CC) to link VDSO")
> > Signed-off-by: Laura Abbott <labbott@redhat.com>
> > ---
> >  arch/arm64/kernel/vdso/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> > index 744b9dbaba03..ca209103cd06 100644
> > --- a/arch/arm64/kernel/vdso/Makefile
> > +++ b/arch/arm64/kernel/vdso/Makefile
> > @@ -13,6 +13,7 @@ targets := $(obj-vdso) vdso.so vdso.so.dbg
> >  obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
> >
> >  ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 \
> > +               $(call ld-option, --build-id) \
> >                 $(call ld-option, --hash-style=sysv) -n -T
> >
> >  # Disable gcov profiling for VDSO code
> 
> 
> I missed that. Sorry.
> 
> You can add  --build-id without $(call ld-option,...)
> because it is supported by our minimal version of toolchain.
> 
> See commit log of 1e0221374e for example.

Ok, so I'm ok folding in the diff below on top?

Will

--->8

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index ca209103cd06..fa230ff09aa1 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -12,9 +12,8 @@ obj-vdso := gettimeofday.o note.o sigreturn.o
 targets := $(obj-vdso) vdso.so vdso.so.dbg
 obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 
-ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 \
-		$(call ld-option, --build-id) \
-		$(call ld-option, --hash-style=sysv) -n -T
+ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv \
+		--build-id -n -T
 
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
