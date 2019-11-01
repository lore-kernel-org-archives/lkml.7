Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F33CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8390208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVE3wNr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbfKADVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 23:21:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40308 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfKADVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 23:21:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id w9so7846740wmm.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 20:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfOsgaRkn3NOEwzErdQ68wVfpHSfbPimdlfU+q2GrO4=;
        b=UVE3wNr3OWzJkNn+4Ud2CGjFeMY31fHdKyasZtVdlJm81o2q0SLBm9bg1H5AQouRvl
         UisWWh6P7ifd4uuQyQSuzWMaF8B/lAamUz8cw40NI0oIY4QvKPvYeoO4fx6dr6JB5iGu
         Ydy2kBnsMysyaf/+KwNbvvYUdhdbNl4xK0jBBKRAAKHqk8zGCaxLfall/r435v2pcgIf
         8MwHsrhVxaTIfTu8TdRXOxWIqrGwzkCY9nxrYkR7I0oDmwoLVZco1qmgm7HQO6JabrLZ
         EuyFiGtG53I+ANvUP1IezXouLWf7Uo27vsf49uk6WfUYHDTV1iJy5XYQJ8UJojElamGt
         sP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfOsgaRkn3NOEwzErdQ68wVfpHSfbPimdlfU+q2GrO4=;
        b=JpNg0k8CkMFBq31L4dTaXs8mmi0AaXpvwvH+3ObupQ7A1tJIjG+Bj0hPaHsFLDifnZ
         GdzaZLdfJQEKKILArbSr3jhQFgpw85h7gNPEQQ6hj27Ph3Ws4+zRmV8eXmu9wyl4bdlt
         2flpmhyPVw1qrq4yCqaRu4sFeCpQEsY+yPIxlN2HGnsiLCTuxl0gxSvMBDjwprWAyg1A
         cGbsSbPCnLlcyFGIZk03TZmzA6L/dwEem8LDJnTP3JyX7FjSTSJipVM5G8Aev7ljiRhh
         FL5oNi6BFOWnRAixYu5SoQ/+w+h9EcVny67ZcwYEOyC0+i3IydyiqYiB/0QOP3U8wSgf
         THQQ==
X-Gm-Message-State: APjAAAUM6A23GGl1Wub2enBpSgjPreKUgPTZpGBfC9ZLyB4LeicViAs5
        //pL0V4AKvdXpFZBaEqbUTrhkyiCqasosR6nNnQ=
X-Google-Smtp-Source: APXvYqyw0ULne0yEgiDcyYOPlPP9HITRfKVWNQxmUTEa9bu3WPIkYH3kgti0dq+11nb3wtilDhzte6N8Quy3q00U8/0=
X-Received: by 2002:a1c:6641:: with SMTP id a62mr7983126wmc.54.1572578508171;
 Thu, 31 Oct 2019 20:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <1571884773-23990-1-git-send-email-chunyan.zhang@unisoc.com> <1571888070-24425-1-git-send-email-chunyan.zhang@unisoc.com>
In-Reply-To: <1571888070-24425-1-git-send-email-chunyan.zhang@unisoc.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 1 Nov 2019 11:21:11 +0800
Message-ID: <CAAfSe-tQ2VB-OQ5-z6b6=KqiC4iaNCfAFouZ1Lo=-4O9pGbKkA@mail.gmail.com>
Subject: Re: [PATCH] tracing: use kvcalloc for tgid_map array allocation
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yuming Han <yuming.han@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gentle ping

On Thu, 24 Oct 2019 at 11:34, Chunyan Zhang <chunyan.zhang@unisoc.com> wrote:
>
>
> From: Yuming Han <yuming.han@unisoc.com>
>
> Fail to allocate memory for tgid_map, because it requires order-6 page.
> detail as:
>
> c3 sh: page allocation failure: order:6,
>    mode:0x140c0c0(GFP_KERNEL), nodemask=(null)
> c3 sh cpuset=/ mems_allowed=0
> c3 CPU: 3 PID: 5632 Comm: sh Tainted: G        W  O    4.14.133+ #10
> c3 Hardware name: Generic DT based system
> c3 Backtrace:
> c3 [<c010bdbc>] (dump_backtrace) from [<c010c08c>](show_stack+0x18/0x1c)
> c3 [<c010c074>] (show_stack) from [<c0993c54>](dump_stack+0x84/0xa4)
> c3 [<c0993bd0>] (dump_stack) from [<c0229858>](warn_alloc+0xc4/0x19c)
> c3 [<c0229798>] (warn_alloc) from [<c022a6e4>](__alloc_pages_nodemask+0xd18/0xf28)
> c3 [<c02299cc>] (__alloc_pages_nodemask) from [<c0248344>](kmalloc_order+0x20/0x38)
> c3 [<c0248324>] (kmalloc_order) from [<c0248380>](kmalloc_order_trace+0x24/0x108)
> c3 [<c024835c>] (kmalloc_order_trace) from [<c01e6078>](set_tracer_flag+0xb0/0x158)
> c3 [<c01e5fc8>] (set_tracer_flag) from [<c01e6404>](trace_options_core_write+0x7c/0xcc)
> c3 [<c01e6388>] (trace_options_core_write) from [<c0278b1c>](__vfs_write+0x40/0x14c)
> c3 [<c0278adc>] (__vfs_write) from [<c0278e10>](vfs_write+0xc4/0x198)
> c3 [<c0278d4c>] (vfs_write) from [<c027906c>](SyS_write+0x6c/0xd0)
> c3 [<c0279000>] (SyS_write) from [<c01079a0>](ret_fast_syscall+0x0/0x54)
>
> Switch to use kvcalloc to avoid unexpected allocation failures.
>
> Signed-off-by: Yuming Han <yuming.han@unisoc.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 6a0ee9178365..2fa72419bbd7 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4609,7 +4609,7 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
>
>         if (mask == TRACE_ITER_RECORD_TGID) {
>                 if (!tgid_map)
> -                       tgid_map = kcalloc(PID_MAX_DEFAULT + 1,
> +                       tgid_map = kvcalloc(PID_MAX_DEFAULT + 1,
>                                            sizeof(*tgid_map),
>                                            GFP_KERNEL);
>                 if (!tgid_map) {
> --
> 2.20.1
>
>
