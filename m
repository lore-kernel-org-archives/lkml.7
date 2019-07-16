Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6C0C76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 05:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADF32173E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 05:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MxOixC4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfGPFAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 01:00:34 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:58743 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfGPFAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 01:00:33 -0400
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x6G50Sjd002379;
        Tue, 16 Jul 2019 14:00:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x6G50Sjd002379
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563253230;
        bh=FPGAGm8ESlaP4ztyHEngsuJk8vAGn0UUpSZ7pP90xF4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MxOixC4EJW207dx9+ev/BxpkmmNyG0UfllLJ3WAMV8KqU4mBHpw7r+qcd9Q63ldxs
         rlHmjqjlxggei5abnX3rnpiQH+uAhr6pOO2K2mj3w64lJ6/PooWANy1GUaKEJqnRXh
         fKGpc+MrZISbc93qq/IEbKJn5im3U197nY+8cAEBB/MjCrw+bURnsi5281tbbdUe1A
         VOLBuSw2m9nsRI5Mq2LUE8WLsdI8tjhBGJ+t8BrVeZy16oCsoBO0ZCC34dJFjh0ltU
         9tJL9NxDO0j3nhncrrvsrgSWRVV8la/hGcEIjeFvuJ+oH6X/nI5IR+QC2NLE9GYpqk
         Gvram8jCKv++A==
X-Nifty-SrcIP: [209.85.221.171]
Received: by mail-vk1-f171.google.com with SMTP id m17so3925083vkl.2;
        Mon, 15 Jul 2019 22:00:28 -0700 (PDT)
X-Gm-Message-State: APjAAAWQ8f0fFAiPleNpxHB+pK8JnZ9ot7QF4WhvGOFTBguqPaE2R8Kk
        WahTvNwqgDaE4FKaabNweEGestSeFFhqAmA3aqA=
X-Google-Smtp-Source: APXvYqwhI6A4AGx+YbJO1T+XUz24WZMm5wmOj6YH1tsONEqhJesi8+5zwcvdIlMbW4BzLhtU2nMdNzxrKYrfA4HekDk=
X-Received: by 2002:a1f:ac1:: with SMTP id 184mr11722686vkk.0.1563253227758;
 Mon, 15 Jul 2019 22:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190716143121.3027ef58@canb.auug.org.au>
In-Reply-To: <20190716143121.3027ef58@canb.auug.org.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 16 Jul 2019 13:59:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNASwwOo13p+GgVZ7txiNH4fpb7himmsDHHoQnfnraPZxHw@mail.gmail.com>
Message-ID: <CAK7LNASwwOo13p+GgVZ7txiNH4fpb7himmsDHHoQnfnraPZxHw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the kbuild tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Jul 16, 2019 at 1:31 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the kbuild tree, today's linux-next build (x86_64
> allnoconfig) failed like this:
>
> make[1]: *** No rule to make target 'modules.order', needed by 'autoksyms_recursive'.  Stop.
>
> Starting with commit
>
>   656c0ac3cb4b ("kbuild: modpost: read modules.order instead of $(MODVERDIR)/*.mod")
>
> i.e. after reverting just:
>
> 25a55e249bc0 Revert "kbuild: create *.mod with full directory path and remove MODVERDIR"
> 15657d9eceb6 Revert "kbuild: remove the first line of *.mod files"
> 8c21f4122839 Revert "kbuild: remove 'prepare1' target"
> 35bc41d44d2d Revert "kbuild: split out *.mod out of {single,multi}-used-m rules"
>
> I get
>
> cat: modules.order: No such file or directory
>
> near the end of the allnoconfig build (but it does not fail).
>
> and when I remove 25a55e249bc0 i.e. stop reverting
>
>   0539f970a842 ("kbuild: create *.mod with full directory path and remove MODVERDIR")
>
> the build fails.
>
> So, for today I have reverted these 4 commits:
>
>   56dce8121e97 ("kbuild: split out *.mod out of {single,multi}-used-m rules")
>   fbe0b5eb7890 ("kbuild: remove 'prepare1' target")
>   008fa222d268 ("kbuild: remove the first line of *.mod files")
>   0539f970a842 ("kbuild: create *.mod with full directory path and remove MODVERDIR")
>


Ugh, sorry for the breakage.


For the build error, I will fix it as follows for tomorrow's linux-next:

diff --git a/Makefile b/Makefile
index bfb08cc647f8..5f3daca90862 100644
--- a/Makefile
+++ b/Makefile
@@ -1028,8 +1028,8 @@ vmlinux-deps := $(KBUILD_LDS)
$(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS)

 # Recurse until adjust_autoksyms.sh is satisfied
 PHONY += autoksyms_recursive
-autoksyms_recursive: $(vmlinux-deps) modules.order
 ifdef CONFIG_TRIM_UNUSED_KSYMS
+autoksyms_recursive: $(vmlinux-deps) modules.order
        $(Q)$(CONFIG_SHELL) $(srctree)/scripts/adjust_autoksyms.sh \
          "$(MAKE) -f $(srctree)/Makefile vmlinux"
 endif



For the warning, I will fix it as follows for tomorrow's linux-next:

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 3e229d4f4d72..6b19c1a4eae5 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -64,7 +64,9 @@ modulesymfile := $(firstword $(KBUILD_EXTMOD))/Module.symvers
 modorder := $(if $(KBUILD_EXTMOD),$(KBUILD_EXTMOD)/)modules.order

 # Step 1), find all modules listed in modules.order
+ifdef CONFIG_MODULES
 modules := $(sort $(shell cat $(modorder)))
+endif

 # Stop after building .o files if NOFINAL is set. Makes compile tests quicker
 _modpost: $(if $(KBUILD_MODPOST_NOFINAL), $(modules:.ko:.o),$(modules))


Thanks!

-- 
Best Regards
Masahiro Yamada
