Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B503FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A91D2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389126AbfCAQ0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:26:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:19092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728449AbfCAQ0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:26:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5AE7430EBE9A;
        Fri,  1 Mar 2019 16:24:23 +0000 (UTC)
Received: from treble (ovpn-122-204.rdu2.redhat.com [10.10.122.204])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E48165D9C5;
        Fri,  1 Mar 2019 16:24:19 +0000 (UTC)
Date:   Fri, 1 Mar 2019 10:24:18 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/unwind: add hardcoded ORC entry for NULL
Message-ID: <20190301162418.sbhth5tycd6znxin@treble>
References: <20190301031201.7416-1-jannh@google.com>
 <20190301031201.7416-2-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190301031201.7416-2-jannh@google.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 01 Mar 2019 16:24:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 04:12:01AM +0100, Jann Horn wrote:
> When the ORC unwinder is invoked for an oops caused by IP==0,
> it currently has no idea what to do because there is no debug information
> for the stack frame of NULL.
> 
> But if RIP is NULL, it is very likely that the last successfully executed
> instruction was an indirect CALL/JMP, and it is possible to unwind out in
> the same way as for the first instruction of a normal function. Hardcode
> a corresponding ORC entry.
> 
> 
> With an artificially-added NULL call in prctl_set_seccomp(), before this
> patch, the trace is:
> 
> Call Trace:
>  ? __x64_sys_prctl+0x402/0x680
>  ? __ia32_sys_prctl+0x6e0/0x6e0
>  ? __do_page_fault+0x457/0x620
>  ? do_syscall_64+0x6d/0x160
>  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> After this patch, the trace looks like this:
> 
> Call Trace:
>  __x64_sys_prctl+0x402/0x680
>  ? __ia32_sys_prctl+0x6e0/0x6e0
>  ? __do_page_fault+0x457/0x620
>  do_syscall_64+0x6d/0x160
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> prctl_set_seccomp() still doesn't show up in the trace because for some
> reason, tail call optimization is only disabled in builds that use the
> frame pointer unwinder.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Thanks for the patches!

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

> Is there a reason why the top-level Makefile only sets
> -fno-optimize-sibling-calls if CONFIG_FRAME_POINTER is set?
> I suspect that this is just a historical thing, because reliable
> unwinding didn't work without frame pointers until ORC came along.
> I'm not quite sure how best to express "don't do tail optimization if
> either frame pointers are used or ORC is used" in a Makefile, and
> whether we want an indirection through Kconfig for that, so I'm not
> doing anything about it in this series.
> Can someone send a patch to deal with it properly?

Why would sibling calls be a problem for ORC?  Once a function does a
sibling call, it has effectively returned and shouldn't show up on the
stack trace anyway.

-- 
Josh
