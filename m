Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59947C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF1321670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556641174;
	bh=M8Uv2tpF8r6eErhAVRc5hwywZ9Vv9g2lG/lzbMaJVPs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1cIIztlygc6eyZODfZaudXlpo/5KKRzdydFP0vhxqkUBavfcY4DrntV+Nf9z6/9TM
	 +V8HPZun0ISYHDWPPgp/7m5QZxlttSooOEz7L6F0X1JFsOksTWmMRNu3i7P+z161nG
	 1Md+RilQo6VjyNbmBWILnEhzo4PWxODrNdZ//ZdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfD3QTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:19:32 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36840 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfD3QTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:19:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id u17so11360072lfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 09:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0mkWPXxdneoX6ZtNfTUi9Tvo+w8cp5wN8Xc0PEQw60=;
        b=EbjP++XKgHxEkneKGZLizrtbM/P7rph4iLyi00CwA3AQOQ0XrmvNGA7c0yA2ueK8Uz
         mygblbiGSrjljLAhCMoYE5sU13o9Bt+rMjweu0Grl3dyGako9+M+H/dusOy0YkCu4M0r
         3R5BK1XDGR+K6UwjSp6+/jpIH7TevLCGc14QE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0mkWPXxdneoX6ZtNfTUi9Tvo+w8cp5wN8Xc0PEQw60=;
        b=kKO64+hiTqueQTTUq2/jI3ZUdfRCifbfkOk5LOyx94MgwdnWxPpVAYZstM02FTF/Tz
         y+dUo4FY0rGT150MFwqDJWFXEcB7AmyHCkDGUs9/GZOfa8g1Ux6rmv0mQFfN6jn6WI5U
         F9TymNuPnOU8cXrp4JICDS/1WlVFdTQM0QWkvdbr9GPvrUAp6wUfnQGmOrmwOVNMFgmz
         2Q8M37OxiJWNtCSte/fSCxQszxEF09q/PIGGOFKtgykB4fFsAlHranbXbEO3V/6q9hHZ
         +dQc5QUc5uD7400XwMzm/XUu3drU9OPvo4veh6AG1PW8pK0hsc0AQTnjvNGZm3lWnpZo
         GNDw==
X-Gm-Message-State: APjAAAUBFc8jFQV2GOiUtXRvqr4Koi2p/wt+gwuMCBVxOwebcKwISJku
        DWcp5iWPm5l8wYkKZDznCEjKL7w8Wug=
X-Google-Smtp-Source: APXvYqy1njdKyxTlxcww3h1Uf0a9bH7Pwp1Gqu0SbjEjuYInMUMB+p/G8jiqReeklzwQdB6bSPMcvQ==
X-Received: by 2002:a19:f24c:: with SMTP id d12mr36292500lfk.163.1556641169781;
        Tue, 30 Apr 2019 09:19:29 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id p19sm8014395lfc.48.2019.04.30.09.19.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 09:19:27 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id h21so13323955ljk.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 09:19:26 -0700 (PDT)
X-Received: by 2002:a2e:5dd2:: with SMTP id v79mr37367875lje.22.1556641166346;
 Tue, 30 Apr 2019 09:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190414201436.19502-1-christian@brauner.io> <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin> <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
 <20190420071406.GA22257@ip-172-31-15-78> <CAG48ez0gG4bd-t1wdR2p6-N2FjWbCqm_+ZThKfF7yKnD=KLqAQ@mail.gmail.com>
 <CAG48ez15bf1EJB0XTJsGFpvf8r5pj9+rv1axKVr13H1NW7ARZw@mail.gmail.com>
 <CAHk-=wi_N81mKYFz33ycoWiL7_tGbZBMJOsAs16inYzSza+OEw@mail.gmail.com>
 <CAG48ez1CV54c1xZ9s26ym=9avkihiNi=ppW-CWA1-qrCpYdc1A@mail.gmail.com>
 <CAHk-=wg73au-kvOwWpPDY+rXrz8O5gwrcPiw1FZx-Qr2PqpRFg@mail.gmail.com> <87r29jaoov.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87r29jaoov.fsf@oldenburg2.str.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Apr 2019 09:19:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiM8VQ_Ny6Y=fTqE9Aq1LuDdU5bKfnXPyYXU1bi7GtU4w@mail.gmail.com>
Message-ID: <CAHk-=wiM8VQ_Ny6Y=fTqE9Aq1LuDdU5bKfnXPyYXU1bi7GtU4w@mail.gmail.com>
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add CLONE_PIDFD]
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Jann Horn <jannh@google.com>, Kevin Easton <kevin@guarana.org>,
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

On Tue, Apr 30, 2019 at 1:21 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> > (In fact, if I recall correctly, the _reason_ we have an explicit
> > 'vfork()' entry point rather than using clone() with magic parameters
> > was that the lack of arguments meant that you didn't have to
> > save/restore any registers in user space, which made the whole stack
> > issue simpler. But it's been two decades, so my memory is bitrotting).
>
> That's an interesting point.  Using a callback-style interface avoids
> that because you never need to restore the registers in the new
> subprocess.  It's still appropriate to use an assembler implementation,
> I think, because it will be more obviously correct.

I agree that a callback interface would have been a whole lot more
obvious and less prone to subtle problems.

But if you want vfork() because the programs you want to build use it,
that's the interface you need..

Of course, if you *don't* need the exact vfork() semantics, clone
itself actually very much supports a callback model with s separate
stack. You can basically do this:

 - allocate new stack for the child
 - in trivial asm wrapper, do:
    - push the callback address on the child stack
    - clone(CLONE_VFORK|CLONE_VM|CLONE_SIGCHLD, chld_stack, NULL, NULL,NULL)
    - "ret"
 - free new stack

where the "ret" in the child will just go to the callback, while the
parent (eventually) just returns from the trivial wrapper and frees
the new stack (which by definition is no longer used, since the child
has exited or execve'd.

So you can most definitely create a "vfork_with_child_callback()" with
clone, and it would arguably be a much superior interface to vfork()
anyway (maybe you'd like to pass in some arguments to the callback too
- add more stack setup for the child as needed), but it wouldn't be
the right solution for programs that just want to use the standard BSD
vfork() model.

> vfork is also more benign from a memory accounting perspective.  In some
> environments, it's not possible to call fork from a large process
> because the accounting assumes (conservatively) that the new process
> will dirty a lot of its private memory.

Indeed.

                 Linus
