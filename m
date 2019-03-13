Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D03C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BA120651
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmbRvoln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfCMPcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:32:15 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46697 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfCMPcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:32:14 -0400
Received: by mail-ed1-f68.google.com with SMTP id n17so1882379edt.13;
        Wed, 13 Mar 2019 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tPjSieS9N7Htn4thMkvSJHNcvBAxRvs2RxTfwm4JqWQ=;
        b=mmbRvolnfsQc+sT5nkEuxvgC0skD1C7xtwcfHxMTU5wB/ufxgfV5kOVcdqTkTwv9rX
         /t+w0BVQAAo14CI/5YbbceZijdvUZzXbAcpinZvLTsjQiprqNan/vUoMou9+myoC3lKU
         e155B7j01K8eYgltGfB5omx9vMTxweJ7x9E+b5BNoCyfH/GLWOotBcQ/EStmUFO0XIP6
         Tnbn6pjzuO3I8j8HyIhjQ9nH35I//o7YXXYfPAyDYLHlrcFdKHrEewhyot9E3o5KXTrS
         bzhbIjsFLg6OhYB7hvzLZN2qJVnqSTNYXfXhC/lZ/zdZexnsL0K6/Uwrj6EbAc/hLknO
         rTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tPjSieS9N7Htn4thMkvSJHNcvBAxRvs2RxTfwm4JqWQ=;
        b=gask5WgJGs6SKO3iMoilxtE8v956JAMEwwyYPGCCME+w9HPkGdyLOPi+pIGDesIjDZ
         RWfMBPMqZ/H3SjHRTyNJRDDSBVpJ4JZ+Uvka3tAudsxggAtgxy7hgprLEkV8M0m6qrUO
         QVhA78GNKiBvDrt38faLQPOCcyp7Rtz0Rg/0CisCMgs5FyOqysbIqpSFSSYcGi5t7EKo
         mtEqbR/0zdGLVt4s9O8AUKmEJsXeW8eki9CnTcfgEO3kU1K5Ipor0RlkpJfVkosmoerw
         rNK+hXi2WnRXU50bYGMTB3GpZg4ujWut1Hn5ZmyWc1e0NtJjjRPciiV5IB8PHBcdpmUy
         Dz/w==
X-Gm-Message-State: APjAAAVIqc187sOVd3Lw+vqx5oxI2Nokeo0+xtbgAyBHFwFlCykoR3I5
        lEbDkEDUmwoqMtqAWuJV+7g=
X-Google-Smtp-Source: APXvYqykbRGBQZCWQLHLS0ZtNnLbO9kBJb2NagpDhSVg16TVqXrmfWdjYstE39hXSnPTG0c3uFpznQ==
X-Received: by 2002:aa7:ccce:: with SMTP id y14mr8384798edt.160.1552491132325;
        Wed, 13 Mar 2019 08:32:12 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id cd11sm494406ejb.61.2019.03.13.08.32.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 13 Mar 2019 08:32:11 -0700 (PDT)
Date:   Wed, 13 Mar 2019 08:32:09 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        James Y Knight <jyknight@google.com>,
        clang-built-linux@googlegroups.com,
        "# 3.4.x" <stable@vger.kernel.org>
Subject: Re: [PATCH] Makefile: Add '-fno-builtin-bcmp' to CLANG_FLAGS
Message-ID: <20190313153209.GA14098@archlinux-ryzen>
References: <20190312215203.27643-1-natechancellor@gmail.com>
 <80fb5b7f-42f9-4fd1-00cf-bfa7965ff8f7@rasmusvillemoes.dk>
 <20190313134447.GA19066@archlinux-ryzen>
 <CAK8P3a344k=MDAX-d21U4+H+mv7Vcd9YhAN4NPEJm1CXv76tkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a344k=MDAX-d21U4+H+mv7Vcd9YhAN4NPEJm1CXv76tkw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 02:48:49PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 13, 2019 at 2:44 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> > On Wed, Mar 13, 2019 at 09:13:11AM +0100, Rasmus Villemoes wrote:
> > > Wouldn't it be better to just define bcmp as an alias for memcmp? They
> > > seem to have compatible prototypes, and then somebody might someday sit
> > > down and implement some word-at-a-time version of bcmp making use of the
> > > weaker guarantees about the return value to gain some performance. But I
> > > suppose that can also be done later.
> >
> > Thank you much for the review, I didn't even realize this was possible :)
> >
> > I'd certainly like to explore it as that is what glibc does. How would
> > you suggest going about it here?
> 
> I suggested a possible implementation (likely contains bugs) and
> an alias for architectures that require strict alignment, see
> https://bugs.llvm.org/show_bug.cgi?id=41035#c11
> 
> We could start out with just the alias.
> 
>        Arnd

So I've been messing around with this for a bit (forgive me, I'm still
learning all of the intricacies around here) and this is what I came up
with for when __ARCH_HAVE_MEMCMP is unset (not particularly difficult
obviously). I can compile, link, and boot an x86 in QEMU.

However, I am not sure how to handle memcmp definitions that are written
in assembly like arm64, as the alias attribute only works when the alias
is defined in the same translation unit. Thoughts?

Cheers,
Nathan

========================================

diff --git a/lib/string.c b/lib/string.c
index 38e4ca08e757..69a9daca9179 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -864,6 +864,9 @@ __visible int memcmp(const void *cs, const void *ct, size_t count)
        return res;
 }
 EXPORT_SYMBOL(memcmp);
+
+int bcmp(const void *cs, const void *ct, size_t count) __weak __alias(memcmp);
+EXPORT_SYMBOL(bcmp);
 #endif
 
 #ifndef __HAVE_ARCH_MEMSCAN
