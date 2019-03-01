Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE4BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2362083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389031AbfCAQTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:19:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfCAQTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:19:25 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 581413003061;
        Fri,  1 Mar 2019 16:19:25 +0000 (UTC)
Received: from treble (ovpn-122-204.rdu2.redhat.com [10.10.122.204])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DFDF19C58;
        Fri,  1 Mar 2019 16:19:22 +0000 (UTC)
Date:   Fri, 1 Mar 2019 10:19:21 -0600
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
Subject: Re: [PATCH 1/2] x86/unwind: handle NULL pointer calls better in
 frame unwinder
Message-ID: <20190301161921.sekhbyu3jeqvfz6k@treble>
References: <20190301031201.7416-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190301031201.7416-1-jannh@google.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 01 Mar 2019 16:19:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 04:12:00AM +0100, Jann Horn wrote:
> When the frame unwinder is invoked for an oops caused by a call to NULL,
> it currently skips the parent function because BP still points to the
> parent's stack frame; the (nonexistent) current function only has the first
> half of a stack frame, and BP doesn't point to it yet.
> 
> Add a special case for IP==0 that calculates a fake BP from SP, then uses
> the real BP for the next frame.
> 
> Note that this handles first_frame specially: We return information about
> the parent function as long as the saved IP is >=first_frame, even if the
> fake BP points below it.
> 
> With an artificially-added NULL call in prctl_set_seccomp(), before this
> patch, the trace is:
> 
> Call Trace:
>  ? prctl_set_seccomp+0x3a/0x50
>  __x64_sys_prctl+0x457/0x6f0
>  ? __ia32_sys_prctl+0x750/0x750
>  do_syscall_64+0x72/0x160
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> After this patch, the trace is:
> 
> Call Trace:
>  prctl_set_seccomp+0x3a/0x50
>  __x64_sys_prctl+0x457/0x6f0
>  ? __ia32_sys_prctl+0x750/0x750
>  do_syscall_64+0x72/0x160
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
