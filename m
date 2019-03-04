Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C8AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 01:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4D520842
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 01:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551662082;
	bh=WmG2vDs4W7ldGTeO49usENFjA0p/aA1IquPcsQmap5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=B/ndnH0z6d5PexzV7WE4c+vGgdgx5HRTeQYNJlZppVMJdKQ4zfrjLGDX1STGql46H
	 dh+9qEb8gpX3ZY2oyR8UGHO2Y3h7o3okGZ4m79MnjgIXKsihyQUm6Jw6rVYv3DJzAE
	 LhrQXrLcxQm+rfXsFn/NKM4pRJ10+736VV0++/rQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfCDBOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 20:14:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbfCDBOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 20:14:39 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 499E320818;
        Mon,  4 Mar 2019 01:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551662078;
        bh=WmG2vDs4W7ldGTeO49usENFjA0p/aA1IquPcsQmap5Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VrbxoqnlBLBMILFERyb78JaG5RdzhBdqwwglycB7YKFnQKLhNLUqwnpyrVF/WpFWX
         yXCodO9fHwo1g6eWvlWg/ryW6SFIfHqPNzmPPLX80VW23si4214QEdS2DE/AOYpwz7
         yLNyVJVcVNYr6cZUFobtIwXrkhKDv2IeGLT7RhJ0=
Date:   Mon, 4 Mar 2019 10:14:34 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com, lkp@01.org
Subject: Re: [uaccess] 780464aed0:
 WARNING:at_arch/x86/include/asm/uaccess.h:#strnlen_user/0x
Message-Id: <20190304101434.8429ffffb17813c0e7930130@kernel.org>
In-Reply-To: <CAHk-=wij8VLupHh1U-fFhFBjin9Fch3mG2_2=aL9h1L+WBvm2g@mail.gmail.com>
References: <155136980507.2968.15165201054223875356.stgit@devbox>
        <20190303173954.kliegojbuigqi5tn@inn2.lkp.intel.com>
        <CAHk-=wij8VLupHh1U-fFhFBjin9Fch3mG2_2=aL9h1L+WBvm2g@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Mar 2019 11:53:58 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, Mar 3, 2019 at 9:40 AM kernel test robot <lkp@intel.com> wrote:
> >
> > commit: 780464aed08ad00aa6d5f81ac8bef2e714dc8b06 ("[PATCH v5 2/6] uaccess: Use user_access_ok() in user_access_begin()")
> 
> Hmm. Not an upstream commit ID, so this is presumably a backport.
> 
> Ok, let's see what it is using the web link:
> 
> > url: https://github.com/0day-ci/linux/commits/Masami-Hiramatsu/tracing-probes-uaccess-Add-support-user-space-access/20190303-203749
> 
> Yeah, that just gives a github 404 error.
> 
> I'm _assuming_ it's the WARN_ON_IN_IRQ() in the access_ok().

I think it comes from WARN_ON_ONCE(!segment_eq(get_fs(), USER_DS)) in 
user_access_ok(). The call trace shows that strndup_user might be called
from kernel daemon context.

[    4.003505] Call Trace:
[    4.003505]  strndup_user+0x14/0x60
[    4.003505]  ksys_mount+0x30/0xd0
[    4.003505]  ? handle_create+0x1f0/0x1f0
[    4.003505]  devtmpfsd+0x9c/0x190

I guess devtmpfsd has not set USER_DS. Hmm, in that case, how ksys_*()
parameters should be treated? Those APIs will take __user pointers, but
actually, in-kernel callers call ksys_*() with non __user variables.

For example,

static int devtmpfsd(void *p)
{
        char options[] = "mode=0755";
        int *err = p;
        *err = ksys_unshare(CLONE_NEWNS);
        if (*err)
                goto out;
        *err = ksys_mount("devtmpfs", "/", "devtmpfs", MS_SILENT, options);
        if (*err)
...

__force __user casting doesn't help, because these parameters are in kernel
memory, not in user memory. I think if we forcibly set USER_DS, it should
fail on some arch.

Peter, I think we can remove that WARN_ON_ONCE() from user_access_ok(),
since user_access_begin() is not only actually start accessing user, but it
also accessing kernel memory.

> Which doesn't much make sense either (why wouldn't it happen in
> mainline)? But without a useful web link to see what is actually being
> tested, I guess it's not something I can even look at...


Yeah, we need working web link on the report...

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
