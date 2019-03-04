Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFC2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2962920823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551725985;
	bh=PdVpKqa6zG3t65OiMq5t1VjuY/IwFGviASrU1YkZ7f8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UlfYpHsKw8QtnJSXDP/CtOib3ZnOX7BmXI00YjzzjW+hLW295Ks2CYpir2IUn/XIo
	 fI/bpqydc4uzkoYxhhbX8usjdgPQIxwQxCyG8wm3gpEEUJioOvWNDZP+mmkVG4yRqh
	 t9291KEknKYxAWzX8awkk/Jk/cYgfE6UDJQ5doMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfCDS7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:59:43 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43025 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfCDS7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:59:43 -0500
Received: by mail-lj1-f193.google.com with SMTP id z20so5271334ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 10:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yE+A6Ro1kbWYGtoM40CkVF6mD9YIFegD3mYZ1fKQXaQ=;
        b=XX8J49GV8ukp8qE8rp37ZNhRUawnBauPGx0Q3S9bhAoU33nufkTS5kPZTAhduDdyyC
         RC3G8mlsS0KuoJvgsI2YE48ldtNPGOWPMrbfZ+8fUeiaQbnQw+ArVzuJ4RFiWjd/ZQiX
         j399kZIC0bDHWbo4AnF2Kgu6FBuRoScCWaojg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yE+A6Ro1kbWYGtoM40CkVF6mD9YIFegD3mYZ1fKQXaQ=;
        b=KsOKzUYfMzK7UPxS8GHXpia8/rUB1vIhtuF2isjbrS2QkKkuCYyt2zVGItXORJ5xov
         F+FVp+14yCiuRB8bBghnF30PNhhCEqyMHtu7XlXVoPseKAOhNe+V9Z7IwJDp9y/hmVsZ
         oztlZillxQzatk+GP4N2wenQUddluHU4QFVeeOudn6mZeMxtIEx8xdJf6BOhygMAkyMw
         MukPExnZXu2J1rNUAisXzjs6Z9FCqfJ3nhrwUsVUYSivr6g1jPE7chAsRfgqC/OiG5uY
         LeOz5sfqIuz1yZDkh/AX3qo5nG1TyjsLRSdMpbVhGhdJCdKcSXWUfngQFa18BxTNZLD9
         sGgg==
X-Gm-Message-State: APjAAAXoXgRc7SPHQMxYrpwIuO8jIFevqEAtrlOiC2ViCHIOE8XHHwXt
        xq9zL2g32eoVwfjYBvi+GOk+8E5+Uyw=
X-Google-Smtp-Source: APXvYqzn8OWGLP4Ee3RHok8J/+I/xhXpO9/CszUy9m6aLkHkOm+/cq8bK6aOiW1Ue64WKqAcEu6oyg==
X-Received: by 2002:a2e:968d:: with SMTP id q13mr11613413lji.189.1551725980204;
        Mon, 04 Mar 2019 10:59:40 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id m16sm1662293lfg.49.2019.03.04.10.59.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 10:59:39 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id p73so3689049lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 10:59:38 -0800 (PST)
X-Received: by 2002:a19:3f44:: with SMTP id m65mr10702163lfa.136.1551725978177;
 Mon, 04 Mar 2019 10:59:38 -0800 (PST)
MIME-Version: 1.0
References: <155136980507.2968.15165201054223875356.stgit@devbox>
 <20190303173954.kliegojbuigqi5tn@inn2.lkp.intel.com> <CAHk-=wij8VLupHh1U-fFhFBjin9Fch3mG2_2=aL9h1L+WBvm2g@mail.gmail.com>
 <20190304101434.8429ffffb17813c0e7930130@kernel.org> <CAHk-=whYMvevgF4yh7uhQug=Wt1A1Eg7abyM=RCi=bQiqiMBvQ@mail.gmail.com>
 <20190304180610.2d4f6f08d9ad89d6abae3597@kernel.org>
In-Reply-To: <20190304180610.2d4f6f08d9ad89d6abae3597@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Mar 2019 10:59:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiQM84VsAiw92UWyQZTQxr+F032Gm5BiFBXk7tC+LQohQ@mail.gmail.com>
Message-ID: <CAHk-=wiQM84VsAiw92UWyQZTQxr+F032Gm5BiFBXk7tC+LQohQ@mail.gmail.com>
Subject: Re: [uaccess] 780464aed0: WARNING:at_arch/x86/include/asm/uaccess.h:#strnlen_user/0x
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 1:06 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Sun, 3 Mar 2019 18:37:59 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > We've had this before. We've gotten rid of the actual "use system
> > calls", but we still have some of the init sequence in particular just
> > calling the wrappers instead.
>
> Are those safe if we are in init sequence?

Yes, they are, it runs with set_fs(KERNEL_DS).

But the patches made that now complain about copying from non-user
space, even though it's fine.

Basically, "strncpy_from_user()" shouldn't use "user_access_ok()",
since it actually can take a kernel address (with set_fs()).

Your "unsafe" version for tracing that actually sets "set_fs(USER_DS)"
is thje only thing that should use that helper.

> > And yes, ksys_mount() takes __user pointers.
> >
> > It would be a lot better to use "do_mount()", which is the interface
> > that takes actual "char *" pointers.
>
> Unfortunately, it still takes a __user pointer.

Ahh, yes, the name remains in user space.

Besides, I'm sure you'd just hit other cases instead where people use
set_fs() and copy strings.

> So what we need is
>
> long do_mount(const char *dev_name, struct path *dir_path,
>                 const char *type_page, unsigned long flags, void *data_page)
>
> or introduce kern_do_mount()?

It's actually fairly painful. Particularly because of that "void *data_page".

Your second email with "Would this work?" helper function _wopuldn't_
work correctly, exactly because you passed in a regular string to the
data page.

Also, I don't want to see code that replaces the unconditional "copy
path from user space" with a conditional "do we have path in kernel
space".

So together with the whole "uyou'll hit other peoblems anyway", I
don't think this is a good approach.

I think you simply need to have a separate "unsafe_strncpy()"
function, and not change the existing "strncpy_from_user()".

                Linus
