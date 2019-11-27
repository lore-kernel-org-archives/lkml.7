Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6324C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848D02073F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574875326;
	bh=vD6J9P8TJYJWcO9nsGKwqev8ckF5iwlRjPjQTed/oig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cquTztP8okor7j6nL72JAmeSYpD9kkV2VvJuhE9rIxuESwKpqScdBw4vNT6GVvw9a
	 /UciUSqeshmqdsvBzYKumMSBnCBLx+1j3Ks5Bk3dS0zFuKSWnQ4bUwkn/kmj6OpCLy
	 SyWdD+guJOBJE7tB3XUBOkUTKU+VYInz/M0BlHuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfK0RWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:22:05 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42229 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfK0RWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:22:05 -0500
Received: by mail-lf1-f67.google.com with SMTP id y19so17785805lfl.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 09:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OG0kCK/PTuRhE0FsWS7wj1K9F3vBSU78DhujocScFeU=;
        b=P5mGSxx93jPkWHZmzujmhhyo2qndVm8yDOL1UpEMcDnDBIzi7DkAd89I06zi/X7EvD
         SN0MIRM3WqUuiWyFx31l4pVe23edeN0qZX3YGcA7dO8hQkm36NJbP8A0OwjyNcOv9oPI
         bHPqb94eIoqdzKjv/3oYPFlF5qp7O9yKUXpxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OG0kCK/PTuRhE0FsWS7wj1K9F3vBSU78DhujocScFeU=;
        b=hWx6boREFWMeKCMI7vj+DnvMqked+WPZMp/7UmO2VYE8BG+9CUezTgYVxnjQbjnyRI
         2rwEB66Zee7go6sZVwdrSMdjwxDenCp8/1RlJ90syIO+8Ny1fxYLSGglqsrWDtFcDHbf
         lxfvYSjAE3GkYXYDgEFOJu0KVkHeIrZ/bIRNvENSjksw/fMWSIeUfNGUBXiw7lyRiVWe
         v/MJj/Dl2WUDDYEAKTnhI4OQVaOy6T6kCUjpR8kf9vl1KSGzP90IEBDLFRb9WaaMdNC8
         p7SA/2azc3x2m9vfm2fUvsmuN0MrgjBGLickXtGrHSYqXHSDEFZVegxi1cw/K35yN3g0
         vYyw==
X-Gm-Message-State: APjAAAWF+ZIAv+cPq9xxLAT+Xu8lCgcCE4dunfcd67kEjXPU+3DhyQS+
        Iuxlee5xbwCeRGIAPw4G1Vk0+XrR984=
X-Google-Smtp-Source: APXvYqzKwK2xLtsFxbVZcCZ7W1GuzeS9tIOjrS9kHcENKtIuMdK7ci/2EonneHLIXIumVQIXB43umw==
X-Received: by 2002:a19:5f05:: with SMTP id t5mr6587377lfb.149.1574875322548;
        Wed, 27 Nov 2019 09:22:02 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id f3sm7469788lfl.58.2019.11.27.09.22.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 09:22:01 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id l14so17786742lfh.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 09:22:01 -0800 (PST)
X-Received: by 2002:ac2:5597:: with SMTP id v23mr26331499lfg.79.1574875320772;
 Wed, 27 Nov 2019 09:22:00 -0800 (PST)
MIME-Version: 1.0
References: <20191126110659.GA14042@redhat.com> <20191126110758.GA14051@redhat.com>
 <CAHk-=whrhuNg_53wc3pBVToH-AUwKDbC5P_cb7=8bYfn=BYCJA@mail.gmail.com> <20191127170234.GA26180@redhat.com>
In-Reply-To: <20191127170234.GA26180@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Nov 2019 09:21:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi9YO5M-LHuTuczQbK6hBrweCoZHVEsiTak6jGuoFt2Sw@mail.gmail.com>
Message-ID: <CAHk-=wi9YO5M-LHuTuczQbK6hBrweCoZHVEsiTak6jGuoFt2Sw@mail.gmail.com>
Subject: Re: [PATCH] ptrace/x86: introduce TS_COMPAT_RESTART to fix get_nr_restart_syscall()
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 9:02 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> OK, lets add the new restart_block.nr_restart_syscall field, then we need
>
>         void set_restart_block_fn(restart, fn)
>         {
>                 restart->nr_restart_syscall = arch_get_nr_restart_syscall()
>                 restart->fn = fn;
>         }

No, I'd suggest just adding an arch-specific "unsigned long" to the
restart data (and not force the naming to something like the system
call number - that's just an x86 detail), and then something like this
on x86:

   void arch_set_restart_data(restart)
   {
      restart->arch_data = x86_get_restart_syscall();
  }
  #define arch_set_restart_data arch_set_restart_data

and then we'd have in generic code something like

  #ifndef arch_set_restart_data
  #define arch_set_restart_data(block) do { } while (0)
  #endif

  int set_restart_fn(fn)
  {
     struct restart_block *restart = &current->restart_blockl
     arch_set_restart_data(restart);
     restart->fn = fn;
     return -ERESTART_RESTARTBLOCK;
   }

or something like that, and we'd just convert the existing (there
aren't that many)

    restart->fn = xyz
    return -ERESTART_RESTARTBLOCK;

cases into

    return set_restart_fn(fn);

and for bonus points, we probably should rename the "fn" field, but
that might be too much work.

It doesn't look *too* painful, because we just don't have all that
many restarting system calls

But the above is handwaving.

And yeah, I never understood why the compat and x32 cases should have
different system call numbers in the first place. The seccomp argument
is garbage, but probably historical stuff that we can no longer
change.

            Linus
