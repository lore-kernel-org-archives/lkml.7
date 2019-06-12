Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41784C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE9521773
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="qcJSquud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfFLTjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:39:06 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37254 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfFLTjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:39:05 -0400
Received: by mail-ot1-f66.google.com with SMTP id s20so2277602otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V1aXbLm2XL+BepW2uBo1s2vdmZhrMu6a14z0RbbtF8Y=;
        b=qcJSquudemsKFEajVtPQXtdzVykjJFvERu1WsQL2yRPQw4DTftC0IGNLeFOxRTfsx7
         hZwVOYf7FLiivzC0IoARki1mBZz+Eiy47UX/b4+OfOMNZNYP0cUymYaINAy27i9c64RP
         fCFijGpqoWoO2+qbyDUABTEumIlys0IJjxgwmpp+oASxvBn3KSxm2MLA0ZbMr0AtoJVp
         q+Ij+3pKAoRyYc7yobSoTIiww21H5hfWlyKorfgaLiIebfrRhm3uqbPk6FNvBsCD2E+b
         zN09bGYm1KJ7uC/Ct1J9TxqXNQO/Puu1I+1eHeL9jJafzNOzuVJIXFMiBHSUxFTwKavX
         lVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V1aXbLm2XL+BepW2uBo1s2vdmZhrMu6a14z0RbbtF8Y=;
        b=XdnAP+QRrr+7YDpK5QvJEkaTAH59EOpQOAqperfkXX2KDjxJA8Pmngcsg6iWMtZYJ4
         BYqa7xrj5JImXjVB1uNboc6neY5T7VDloTfk4tLP0tJfy6gYIt0tlQUGrN2fjXJ1VAYG
         t/w8eOJwqyo8AawZMMdkwU6Vz6m4DYxS79dW0stmp+w9chvfGzJwc26IjOAq/CnAFQUX
         rtqBBvBaXykGPyZOE+3SagqzMVsMRoSu2VXDro12zBnEyDtcb9bTeyDfuyt2uhUuHLap
         L4dpC3I2SWvwWcVHXmWRLB27J4nXGO3dmfK7hzrBs675EZovXyldIuxwv9xDg7OfUmtR
         zzvA==
X-Gm-Message-State: APjAAAWw4wAbjBonvgNdLe9k8O2igMTsF0B2NQEB53qXXTJe+4Stegjk
        Zl0zs4gb6ihGFIeXWhXhxCk4bEGGs6tvlSKCRIFJSZVd
X-Google-Smtp-Source: APXvYqzh0qJjO8WXwzyiCt81xF7us6l+7SdOHJxXRhI8LwROXNh/TEz/D85MnJvSavOkYjfQBO3yc0+AR/rgwhtgbHU=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr6590343otf.126.1560368345122;
 Wed, 12 Jun 2019 12:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <1560366952-10660-1-git-send-email-cai@lca.pw> <CAPcyv4hn0Vz24s5EWKr39roXORtBTevZf7dDutH+jwapgV3oSw@mail.gmail.com>
In-Reply-To: <CAPcyv4hn0Vz24s5EWKr39roXORtBTevZf7dDutH+jwapgV3oSw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 12 Jun 2019 12:38:54 -0700
Message-ID: <CAPcyv4iuNYXmF0-EMP8GF5aiPsWF+pOFMYKCnr509WoAQ0VNUA@mail.gmail.com>
Subject: Re: [PATCH -next] mm/hotplug: skip bad PFNs from pfn_to_online_page()
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 12:37 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Jun 12, 2019 at 12:16 PM Qian Cai <cai@lca.pw> wrote:
> >
> > The linux-next commit "mm/sparsemem: Add helpers track active portions
> > of a section at boot" [1] causes a crash below when the first kmemleak
> > scan kthread kicks in. This is because kmemleak_scan() calls
> > pfn_to_online_page(() which calls pfn_valid_within() instead of
> > pfn_valid() on x86 due to CONFIG_HOLES_IN_ZONE=n.
> >
> > The commit [1] did add an additional check of pfn_section_valid() in
> > pfn_valid(), but forgot to add it in the above code path.
> >
> > page:ffffea0002748000 is uninitialized and poisoned
> > raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> > raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> > page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> > ------------[ cut here ]------------
> > kernel BUG at include/linux/mm.h:1084!
> > invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
> > CPU: 5 PID: 332 Comm: kmemleak Not tainted 5.2.0-rc4-next-20190612+ #6
> > Hardware name: Lenovo ThinkSystem SR530 -[7X07RCZ000]-/-[7X07RCZ000]-,
> > BIOS -[TEE113T-1.00]- 07/07/2017
> > RIP: 0010:kmemleak_scan+0x6df/0xad0
> > Call Trace:
> >  kmemleak_scan_thread+0x9f/0xc7
> >  kthread+0x1d2/0x1f0
> >  ret_from_fork+0x35/0x4
> >
> > [1] https://patchwork.kernel.org/patch/10977957/
> >
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >  include/linux/memory_hotplug.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> > index 0b8a5e5ef2da..f02be86077e3 100644
> > --- a/include/linux/memory_hotplug.h
> > +++ b/include/linux/memory_hotplug.h
> > @@ -28,6 +28,7 @@
> >         unsigned long ___nr = pfn_to_section_nr(___pfn);           \
> >                                                                    \
> >         if (___nr < NR_MEM_SECTIONS && online_section_nr(___nr) && \
> > +           pfn_section_valid(__nr_to_section(___nr), pfn) &&      \
> >             pfn_valid_within(___pfn))                              \
> >                 ___page = pfn_to_page(___pfn);                     \
> >         ___page;                                                   \
>
> Looks ok to me:
>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
>
> ...but why is pfn_to_online_page() a multi-line macro instead of a
> static inline like all the helper routines it invokes?

I do need to send out a refreshed version of the sub-section patchset,
so I'll fold this in and give you a Reported-by credit.
