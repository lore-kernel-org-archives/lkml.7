Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3976C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928D120863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551690377;
	bh=JJvivajtjja0EDGoey38hjXrjmXuoDlx4g1FbbwUiVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=olRfVciakhuFFemM/f4DbkbHAh6qZAYp53fJ2GeoaN20cjwbmpX4+KE4Vt9DmbguL
	 aIxXrTgPBpSh6q3wlwvhHC276PFEb9qj2uBw1pmTCmkfhcbmnrcSCutCRsFL1cE3hW
	 GBmquIJrBgS/eaUgO/SyLw/0/XuSawP7gsTzu2EY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfCDJGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:06:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:44260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfCDJGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 04:06:15 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13D1A20836;
        Mon,  4 Mar 2019 09:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551690374;
        bh=JJvivajtjja0EDGoey38hjXrjmXuoDlx4g1FbbwUiVE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PD6FntkMDi+/lbtFT4d01gAq/xYG+AprVLrYlp+R2AYYd5GXtrQIKWBsyDcjmONKf
         gzxay9TfWvfao4o3sGZDCtHsqebCXM0UJxwp19wc/cE4vd5V/wP4fMRpOxDNHXGY6b
         CibLC6Q3g9L0ArjcQObOjHXjhhhFWjFgziAlEGz0=
Date:   Mon, 4 Mar 2019 18:06:10 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>,
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
Message-Id: <20190304180610.2d4f6f08d9ad89d6abae3597@kernel.org>
In-Reply-To: <CAHk-=whYMvevgF4yh7uhQug=Wt1A1Eg7abyM=RCi=bQiqiMBvQ@mail.gmail.com>
References: <155136980507.2968.15165201054223875356.stgit@devbox>
        <20190303173954.kliegojbuigqi5tn@inn2.lkp.intel.com>
        <CAHk-=wij8VLupHh1U-fFhFBjin9Fch3mG2_2=aL9h1L+WBvm2g@mail.gmail.com>
        <20190304101434.8429ffffb17813c0e7930130@kernel.org>
        <CAHk-=whYMvevgF4yh7uhQug=Wt1A1Eg7abyM=RCi=bQiqiMBvQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Mar 2019 18:37:59 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, Mar 3, 2019 at 5:14 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > I think it comes from WARN_ON_ONCE(!segment_eq(get_fs(), USER_DS)) in
> > user_access_ok(). The call trace shows that strndup_user might be called
> > from kernel daemon context.
> 
> Ahh, yes.
> 
> We've had this before. We've gotten rid of the actual "use system
> calls", but we still have some of the init sequence in particular just
> calling the wrappers instead.

Are those safe if we are in init sequence?

> 
> And yes, ksys_mount() takes __user pointers.
> 
> It would be a lot better to use "do_mount()", which is the interface
> that takes actual "char *" pointers.

Unfortunately, it still takes a __user pointer.

long do_mount(const char *dev_name, const char __user *dir_name,
                const char *type_page, unsigned long flags, void *data_page)

So what we need is

long do_mount(const char *dev_name, struct path *dir_path,
                const char *type_page, unsigned long flags, void *data_page)

or introduce kern_do_mount()?

Since devtmpfsd calls ksys_chdir() and ksys_chroot(), we need to replace
those too. Fortunately, it seems that the last part which we have to fix.

Thank you,

> 
>                     Linus


-- 
Masami Hiramatsu <mhiramat@kernel.org>
