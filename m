Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61153C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 02:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4B121655
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 02:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556590595;
	bh=Ndx+WuPdrDMbMy4Z3gpBHdDJQeIxtMJ+YluR8AP20MM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=j+CtONjeumtJUg9Jw58YDA0707ZdIVSIjbj9ruo+JdQTugW5qhgW2p87TmUKVnhh0
	 pZNnampfdW0DZ9I6WafXS9UT0up+H1XDMhMVKJXeXtZshv4fzqht2zXcAV2hXYhBY4
	 YvTQb6Rm7ens+vAP2axDkMlvr+0nwPu/j2aSlyaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfD3CQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 22:16:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46880 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbfD3CQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 22:16:33 -0400
Received: by mail-lf1-f65.google.com with SMTP id k18so9406346lfj.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 19:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7K80baoGD98i/ki0iA1SM4BuBVnujumewB88uhrGPE=;
        b=agEwzL5uVGX3m7CSaELzs/03mfCALUUKzAl+yfarpEfu3aAmqoEpsz3pM4cUroNLl/
         6bneaBMEu0Mu4GZZEgEZtYPC7Go4RCUjhq5pyTbn8KeNhVXtO4bI8l39EoVfErZQk0aR
         6Hh69Nwv8qf3nijb9WYOsKX2+TAZsGITw3iDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7K80baoGD98i/ki0iA1SM4BuBVnujumewB88uhrGPE=;
        b=naNORDYcDQUeK9KWIp9MhuCrOIn0L97tOy3eWz4WyIhrdGkJcY+NvSsZx+MSyVEzp0
         2KHx9Ih4z2nTLiG20iY9LLzxKuXpvfDB6CLfKjzDOXidj9WtzuUunzxkAfnmARDA4Ws4
         ESSqjZ2RqYyS/XEFdzftDwQCiY9jmj64d6M1DEXHZ17/TA+jGfP7rTR4M0qkeYha5bRb
         mKL1cOowCrEcJ8al+tJ1XaoZuOcDbNq0qWXSJCUD8+9dNhNUcecJsY6giIEgyA2WC96d
         QjRb0tSdr12arPofRGEBrDjYNmqXNeVhNfB+QKrOIIgtJXtor+dViSAhuKjlCXqW9Nzi
         Eo1w==
X-Gm-Message-State: APjAAAVAdYSVj+XYfkWSKeOJ1XQzo+8rlnku7wOFgJQ6g2u0vxqEG3Gv
        +S7TFt3mEgiap4bIq2eDNh5P1f5peOg=
X-Google-Smtp-Source: APXvYqyf790zA3xCfJCcihgIzox3pVr5WgVRRdMr6PcDgjAy81KzzcvxxFfx8Vdo+ciD5kQkpzXCXg==
X-Received: by 2002:a19:7d04:: with SMTP id y4mr16620107lfc.153.1556590590621;
        Mon, 29 Apr 2019 19:16:30 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id f22sm1938059lja.48.2019.04.29.19.16.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 19:16:27 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id t1so1125076lje.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 19:16:27 -0700 (PDT)
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr31073909ljj.79.1556590587148;
 Mon, 29 Apr 2019 19:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190414201436.19502-1-christian@brauner.io> <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin> <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
 <20190420071406.GA22257@ip-172-31-15-78> <CAG48ez0gG4bd-t1wdR2p6-N2FjWbCqm_+ZThKfF7yKnD=KLqAQ@mail.gmail.com>
 <CAG48ez15bf1EJB0XTJsGFpvf8r5pj9+rv1axKVr13H1NW7ARZw@mail.gmail.com>
 <CAHk-=wi_N81mKYFz33ycoWiL7_tGbZBMJOsAs16inYzSza+OEw@mail.gmail.com> <CAG48ez1CV54c1xZ9s26ym=9avkihiNi=ppW-CWA1-qrCpYdc1A@mail.gmail.com>
In-Reply-To: <CAG48ez1CV54c1xZ9s26ym=9avkihiNi=ppW-CWA1-qrCpYdc1A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 19:16:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg73au-kvOwWpPDY+rXrz8O5gwrcPiw1FZx-Qr2PqpRFg@mail.gmail.com>
Message-ID: <CAHk-=wg73au-kvOwWpPDY+rXrz8O5gwrcPiw1FZx-Qr2PqpRFg@mail.gmail.com>
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add CLONE_PIDFD]
To:     Jann Horn <jannh@google.com>
Cc:     Kevin Easton <kevin@guarana.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 5:39 PM Jann Horn <jannh@google.com> wrote:
>
> ... uuuh, whoops. Turns out I don't know what I'm talking about.

Well, apparently there's some odd libc issue accoprding to Florian, so
there *might* be something to it.

> Nevermind. For some reason I thought vfork() was just
> CLONE_VFORK|SIGCHLD, but now I see I got that completely wrong.

Well, inside the kernel, that's actually *very* close to what vfork() is:

  SYSCALL_DEFINE0(vfork)
  {
        return _do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, 0,
                        0, NULL, NULL, 0);
  }

but that's just an internal implementation detail. It's a real vfork()
and should act as the traditional BSD "share everything" without any
address space copying. The CLONE_VFORK flag is what does the "wait for
child to exit or execve" magic.

Note that vfork() is "exciting" for the compiler in much the same way
"setjmp/longjmp()" is, because of the shared stack use in the child
and the parent. It is *very* easy to get this wrong and cause massive
and subtle memory corruption issues because the parent returns to
something that has been messed up by the child.

That may be why some libc might end up just using "fork()", because it
ends up avoiding bugs in user space.
(In fact, if I recall correctly, the _reason_ we have an explicit
'vfork()' entry point rather than using clone() with magic parameters
was that the lack of arguments meant that you didn't have to
save/restore any registers in user space, which made the whole stack
issue simpler. But it's been two decades, so my memory is bitrotting).

Also, particularly if you have a big address space, vfork()+execve()
can be quite a bit faster than fork()+execve(). Linux fork() is pretty
efficient, but if you have gigabytes of VM space to copy, it's going
to take time even if you do it fairly well.

               Linus
