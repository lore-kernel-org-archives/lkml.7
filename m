Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E365C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1CA2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qw6yTc7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbfC2Nj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:39:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38582 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbfC2Nj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:39:56 -0400
Received: from zn.tnic (p200300EC2F148A00C1243160B4274091.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:c124:3160:b427:4091])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6203A1EC023E;
        Fri, 29 Mar 2019 14:39:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553866794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8UJGxHgNWNlb/b97npVUdXIBVRMk24J4crSpgBzNlDk=;
        b=qw6yTc7bKo/HLFRG5k8fQO2PiVFy5Mfc8bSkYhd4ySmhiu0NNSxLrdZOBQwIJDih9MQC5a
        gtWQ4BBW+65lhl228C1+j9Y3hq+bSDbZg6J00/GUz6U9UL4Mf4qpb2Sph/bSRCBcy2EWYy
        r9fjAVrq3ocji8h+lB2wkr5HZnw2gzc=
Date:   Fri, 29 Mar 2019 14:39:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Qiaowei Ren <qiaowei.ren@intel.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH 2/2] x86: fix __user annotations
Message-ID: <20190329133956.GE21152@zn.tnic>
References: <20190328212321.92463-1-jannh@google.com>
 <20190328212321.92463-2-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190328212321.92463-2-jannh@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 10:23:21PM +0100, Jann Horn wrote:
> Fix __user annotations in various places across the x86 tree:
> 
>  - cast to wrong pointer type in __user_atomic_cmpxchg_inatomic()
>  - generic_load_microcode() deals with a pointer that can be either a
>    kernel pointer or a user pointer; change the code to pass it around as
>    a __user pointer, and add explicit casts to convert between __user and
>    __kernel
>  - save_xstate_epilog() has missing __user in explicit casts
>  - setup_sigcontext() and x32_setup_rt_frame() rely on the cast performed
>    by put_user_ex() on its first argument, but sparse requires __force for
>    casting __user pointers to unsigned long
>  - xen_hvm_config() has missing __user
> 
> This patch removes all sparse warnings about the asn:1 address space
> (__user) in arch/x86/ for my kernel config.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> This patch requires the previous one, "[PATCH 1/2] kernel.h: use
> parentheses around argument in u64_to_user_ptr()", otherwise
> xen_hvm_config() breaks. Can we take both together through the x86 tree,
> or does the first one have to go through akpm's tree?

I don't see why not, unless akpm has objections.

However,

>  arch/x86/include/asm/uaccess.h        |  3 +--
>  arch/x86/include/asm/uaccess_64.h     |  2 +-

This chunk is being discussed here already:

https://lkml.kernel.org/r/20190228185027.2480-1-ben.dooks@codethink.co.uk

and I'd like to take Ben's v2 when Ben adds Linus' explanation.

Then, it would be probably easier if you could split that patch into:

>  arch/x86/kernel/cpu/microcode/intel.c | 20 ++++++++++++--------

microcode

>  arch/x86/kernel/fpu/signal.c          |  6 +++---
>  arch/x86/kernel/signal.c              |  4 ++--

fpu patch

>  arch/x86/kvm/x86.c                    |  8 ++++----

kvm patch

which would make review/merging/etc considerably easier.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
