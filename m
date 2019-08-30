Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0091BC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B102341B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567182112;
	bh=7BdUC9WpZ2wY/aGVxEI02YTEJzco3jSHoMke3mSodZc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lMPzV7RuZ+NXTeMjHBRYMHTpJgmyJqf+eR039U3XOR3U5UFcYvEuByHn+IOah/t/U
	 Tg2JgHZpTgAJSmfAbIQ77cci232aFKE/WvJB8eNoNXU1mc8L0N9xROVuerGcvdr43c
	 NkhK4MWwE6F5LudTGeH71A4Beh6skcufeIgPaL3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfH3QVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:21:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35069 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbfH3QVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:21:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id l14so7030492lje.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RvJUWzwbWtDmNfFQPDYtgd/VNd2rt9lHRibndGJEDe0=;
        b=FBYvMKEjQ5sSOW9ZgPodQd+BPDSjMhYQvOJAseRwiwhf9FwP3UC43tsYloFXNii+na
         Lz3/FkQuzQFH17j9WrzdMHgvnYnwKX+YDkPnlTlkvOfiUDptQubG6jlibQE2kI0gEQlX
         2WNRV8a0AozFaDMEhf0NzVdPBaHQpM2DDVYTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RvJUWzwbWtDmNfFQPDYtgd/VNd2rt9lHRibndGJEDe0=;
        b=F1asdqgB6G1MvxSVMQd9ezKArgpZN//nLhocREhbX5sd5IhQc7m1+Xc5Wjc42r4AOQ
         EWd7XKx3Ia7rgxEYWlQH1UUWvdeHrDHEMeUcwNzStZ07vr30Szd4G6tijuuKV26l3po2
         lbkBqnglHyDsn8heK7WUQivmM43FP3wcgVH26VBvCkcA6qYpc0lPMxWd8NR0/dplTu/t
         tEogpfhBctH4NaNGpGG5RAopyoHszq+vSJHqNzFzvAapYhipmKzwubaP5+K3U5iJ603m
         oHxjf3lCWZtk3xR4ol37i99fuwBCxfpPOUUE/KWb1A36hCu6ycKJAfdkyTQurvmya/Ar
         108Q==
X-Gm-Message-State: APjAAAUauJJasFUucbx7cYMqOa9f1ISCZ8vb/30qD/lqqVo7oD8Bt6Hr
        iL9c32o+TxwXGOtscC5hdOp5BSdvKd8=
X-Google-Smtp-Source: APXvYqwIRFQcCP6iiPpYU+ERSlcui/1CbSp4YLv5f5ROjZVq30QItkeOWKt9IoFBWHKkHcrabUUYNg==
X-Received: by 2002:a2e:1518:: with SMTP id s24mr8416921ljd.205.1567182108992;
        Fri, 30 Aug 2019 09:21:48 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id r8sm980958lfc.39.2019.08.30.09.21.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2019 09:21:47 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id j16so846191ljg.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:21:47 -0700 (PDT)
X-Received: by 2002:a05:651c:1104:: with SMTP id d4mr1719479ljo.90.1567182107201;
 Fri, 30 Aug 2019 09:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190830140805.GD13294@shell.armlinux.org.uk> <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
 <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com> <20190830160957.GC2634@redhat.com>
In-Reply-To: <20190830160957.GC2634@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Aug 2019 09:21:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
Message-ID: <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
Subject: Re: [BUG] Use of probe_kernel_address() in task_rcu_dereference()
 without checking return value
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 9:10 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
>
> Yes, please see
>
>         [PATCH 2/3] introduce probe_slab_address()
>         https://lore.kernel.org/lkml/20141027195425.GC11736@redhat.com/
>
> I sent 5 years ago ;) Do you think
>
>         /*
>          * Same as probe_kernel_address(), but @addr must be the valid pointer
>          * to a slab object, potentially freed/reused/unmapped.
>          */
>         #ifdef CONFIG_DEBUG_PAGEALLOC
>         #define probe_slab_address(addr, retval)        \
>                 probe_kernel_address(addr, retval)
>         #else
>         #define probe_slab_address(addr, retval)        \
>                 ({                                                      \
>                         (retval) = *(typeof(retval) *)(addr);           \
>                         0;                                              \
>                 })
>         #endif
>
> can work?

Ugh. I would much rather handle the general case, because honestly,
tracing has had a lot of issues with our hacky "probe_kernel_read()"
stuff that bases itself on user addresses.

It's also one of the few remaining users of "set_fs()" in core code,
and we really should try to get rid of those.

So your code would work for this particular case, but not for other
cases that can trap simply because the pointer isn't reliable (tracing
being the main case for that - but if the source of the pointer itself
might have been free'd, you would also have that situation).

So I'd really prefer to have something a bit fancier. On most
architectures, doing a good exception fixup for kernel addresses is
really not that hard.

On x86, for example, we actually have *exactly* that. The
"__get_user_asm()" macro is basically it. It purely does a load
instruction from an unchecked address.

(It's a really odd syntax, but you could remove the __chk_user_ptr()
from the __get_user_size() macro, and now you'd have basically a "any
regular size kernel access with exception handlng").

But yes, your hack is I guess optimal for this particular case where
you simply can depend on "we know the pointer was valid, we just don't
know if it was freed".

Hmm. Don't we RCU-free the task struct? Because then we don't even
need to care about CONFIG_DEBUG_PAGEALLOC. We can just always access
the pointer as long as we have the RCU read lock. We do that in other
cases.

                    Linus
