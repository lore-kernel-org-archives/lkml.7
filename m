Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9918C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C542075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hcAKm41f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfCDP6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:58:33 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36957 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfCDP6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:58:32 -0500
Received: by mail-ot1-f65.google.com with SMTP id b3so4613126otp.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 07:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WFkkJapunlmZCHLXIcxK+tOreY89xhwJ363NUDGG4v8=;
        b=hcAKm41fnSYaNFLo74+0hYAuXrxnyKbSwIm/sX3diGe/GUZ5N+9jFmP+1hef0Yb0de
         88pFYY0sekSTGBXcK22Nn9/HX58rhYqiIhActbpq7sjd0UrSP+rw5mAcdj37L5gcNji+
         iS+HkPgrjexj/WM6SglWTqy/wucjBfKY6YCurdeLNe3J6LEseCJ96zvXBIe+SefSRPro
         yoUqQuflV9qNVHn/ps+NE0BM5B/Q3rw1AoFelf4q3EP4kbz+046jfzu31Kp9ighpQqiL
         HOg33uu09I3vqOus7AhN826PulqUKVvh6jP57RvV9vsfsC3dx36YVJ4QDu81zI8dVdNG
         Y8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFkkJapunlmZCHLXIcxK+tOreY89xhwJ363NUDGG4v8=;
        b=NHKVBb8efLyhgJV0x0nsaPYgECmRuEMrVZjn5/XBYPPJL/puFE/HXGVFHBaOOLBHuC
         BsYL9+NMp+CfCFcG8cP/O9g7TafboQ/6YCchiiHkBIgER8Ny13bJwPBXAHnsSYoe4i5P
         V2Hepr/9vGSQlCEEuxJxG14PnIaCtG2+JWc787WwdVv0S/pB40MtuIieSmFpjaxaWLEK
         bkyWnIypMgAFNDqYQycUT2ujsoih04ttQrNywAueLGyVH757nNTv2yI38C07LvWY2ytv
         LPGw1dmCn3dAH6mYh1zBi6MHFuQmykltr2A51hf17K0HTQjsKxU4A0+O5485u7l+crv1
         8Gow==
X-Gm-Message-State: APjAAAW9MxqMGrdTMUVD/67ML0dnhs/J0Nk0Y6VJIPN5hAAJgTN0z9Cu
        wHdykxK8RIfAbONQzKKDtdi8EwB4tf0B6mQIN/VKgQ==
X-Google-Smtp-Source: APXvYqz620+knOD3u6zhIMHXU47ZaqoCrjDjwhmHpUpf6GeGeJ1RaJ5SJDrYEIJfEFtCVDLR09uLsXqOmTwB1ODgWks=
X-Received: by 2002:a9d:ec7:: with SMTP id 65mr12266891otj.230.1551715111487;
 Mon, 04 Mar 2019 07:58:31 -0800 (PST)
MIME-Version: 1.0
References: <155136980507.2968.15165201054223875356.stgit@devbox>
 <20190303173954.kliegojbuigqi5tn@inn2.lkp.intel.com> <CAHk-=wij8VLupHh1U-fFhFBjin9Fch3mG2_2=aL9h1L+WBvm2g@mail.gmail.com>
 <20190304101434.8429ffffb17813c0e7930130@kernel.org> <CAHk-=whYMvevgF4yh7uhQug=Wt1A1Eg7abyM=RCi=bQiqiMBvQ@mail.gmail.com>
 <20190304180610.2d4f6f08d9ad89d6abae3597@kernel.org> <20190305001609.10f950fd4f8089e1ae07c9f1@kernel.org>
In-Reply-To: <20190305001609.10f950fd4f8089e1ae07c9f1@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 4 Mar 2019 16:58:05 +0100
Message-ID: <CAG48ez2a_dcLFpuEL3M-_KbTEmLq6dn+bXtGmL2MhQrYuj6tLA@mail.gmail.com>
Subject: Re: [uaccess] 780464aed0: WARNING:at_arch/x86/include/asm/uaccess.h:#strnlen_user/0x
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com, lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 4:16 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hello,
>
> On Mon, 4 Mar 2019 18:06:10 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> > On Sun, 3 Mar 2019 18:37:59 -0800
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > > On Sun, Mar 3, 2019 at 5:14 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > >
> > > > I think it comes from WARN_ON_ONCE(!segment_eq(get_fs(), USER_DS)) in
> > > > user_access_ok(). The call trace shows that strndup_user might be called
> > > > from kernel daemon context.
> > >
> > > Ahh, yes.
> > >
> > > We've had this before. We've gotten rid of the actual "use system
> > > calls", but we still have some of the init sequence in particular just
> > > calling the wrappers instead.
> >
> > Are those safe if we are in init sequence?
> >
> > >
> > > And yes, ksys_mount() takes __user pointers.
> > >
> > > It would be a lot better to use "do_mount()", which is the interface
> > > that takes actual "char *" pointers.
> >
> > Unfortunately, it still takes a __user pointer.
> >
> > long do_mount(const char *dev_name, const char __user *dir_name,
> >                 const char *type_page, unsigned long flags, void *data_page)
> >
> > So what we need is
> >
> > long do_mount(const char *dev_name, struct path *dir_path,
> >                 const char *type_page, unsigned long flags, void *data_page)
> >
> > or introduce kern_do_mount()?
>
> Would this work?
>
> ( BTW, what is this code for? It seems totally insane termination.
>   at least this should be done in copy_mount_options().
>         if (data_page)
>                 ((char *)data_page)[PAGE_SIZE - 1] = 0;
> )
>
> =======
> devtmpfs: Avoid passing kernel memory to __user parameter
>
> From: Masami Hiramatsu <mhiramat@kernel.org>
>
> Since ksys_mount(), ksys_chdir() and ksys_chroot() takes
> __user parameters, devtmpfsd must not pass the kernel memory
> to them. On some arch, it is not possible to pass th kernel
> memory to them, since the memory address spaces can be
> different.

strncpy_from_user() also uses user_access_begin(), and that thing's
used from all the VFS syscalls via getname(). And those are used all
over the place in init/ - for example:
init/do_mounts.c uses ksys_open() and ksys_chroot()
init/do_mounts_initrd.c uses ksys_open(), ksys_chdir(), ksys_mount(),
ksys_mkdir() and ksys_unlink()
init/do_mounts_md.c uses ksys_open()
and so on.
(identify_ramdisk_image() even uses ksys_lseek() and ksys_read()
instead of just using kernel_read()...)
