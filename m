Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5406CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267872071E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574833589;
	bh=oQiJiVUECmkuTnAwoFBoV84O+kVtT61Ej5+OnFy1dCE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rICHe6BfOPqMDRZSIUvXIP1yeaiQkrUWgXT4BP0TX2gms3tz0zLgQyZK5wVc9ORIl
	 /YcaVswGOG3OAbB7XZhs/DreksjSErod3Yg9qPoV+Y8Bx1GqY50p7WVCMEJHauwdlR
	 OmIKXdqyPBQ/5FAOSB02RW9oSL92LSnzqwaegy0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfK0Fq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 00:46:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:51864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbfK0Fq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 00:46:28 -0500
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C5A42084B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 05:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574833587;
        bh=oQiJiVUECmkuTnAwoFBoV84O+kVtT61Ej5+OnFy1dCE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AdSr0gQG7P2SKzLEN+rfnH5OX5yxQl7ZNqSPcZS0qv8blSgjhoGKGytjWliG9hG0I
         BKYSfGjRJswjxMs4hf/tLG52dDMGYwUHYBgZmow+Gboo5alx+gBtvDl0e0e8xVsA2x
         4yEC3W2XJmRYDRgpPYN9NpIoG3KwZfE9TrVMY+1E=
Received: by mail-wm1-f47.google.com with SMTP id g206so5681873wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 21:46:27 -0800 (PST)
X-Gm-Message-State: APjAAAV4KLN/f5LyNe5R+hSNjtFsaQaGBL5pPCivLQ51ywRz4fntqZK6
        CzdUr2U3v/5XK3+9OMcDBtD6upOaPXMzfPARDCQe4w==
X-Google-Smtp-Source: APXvYqyM9npE6Emj9WttvPSjgS/uP+e5K5P03ZPlpmJO5JKOu26gYD0LNTCqKbWK4OL/jluqTLBCW1Dql5ojcnXhcvU=
X-Received: by 2002:a1c:1f8d:: with SMTP id f135mr2394132wmf.79.1574833585808;
 Tue, 26 Nov 2019 21:46:25 -0800 (PST)
MIME-Version: 1.0
References: <20191126110659.GA14042@redhat.com> <20191126110758.GA14051@redhat.com>
 <CAHk-=whrhuNg_53wc3pBVToH-AUwKDbC5P_cb7=8bYfn=BYCJA@mail.gmail.com>
In-Reply-To: <CAHk-=whrhuNg_53wc3pBVToH-AUwKDbC5P_cb7=8bYfn=BYCJA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 26 Nov 2019 21:46:14 -0800
X-Gmail-Original-Message-ID: <CALCETrWTjUJQVXmbhnAfpg=J1kV8XZnWrjR7Yt+a1Dd2GSTr5A@mail.gmail.com>
Message-ID: <CALCETrWTjUJQVXmbhnAfpg=J1kV8XZnWrjR7Yt+a1Dd2GSTr5A@mail.gmail.com>
Subject: Re: [PATCH] ptrace/x86: introduce TS_COMPAT_RESTART to fix get_nr_restart_syscall()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Tue, Nov 26, 2019 at 8:04 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Nov 26, 2019 at 3:08 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Alternatively we could add ->compat_restart into struct restart_block,
> > logically this is the same thing.
>
> That sounds like the better model to me. That's what the restart_block
> is about: it's supposed to contain the restart information.
>
> I'd much rather see the system call number added into the restart
> block (or just the "compat bit" - but we have that X32 case too, so
> why not put it all there). And then the get_nr_restart_syscall() hack
> goes away and is just "set state from the restart block".
>
> How painful would that be? I guess right now we always just set all
> the restart_block info manually in all the restart cases, and that
> could make it a bit painful to add this kind of architecture-specific
> flag, but it _sounds_ conceptually like the right thing to do.

How about we rename restart_block::fn to __fn, add fields
restart_syscall_nr and restart_syscall_arch, and do:

long restart_block_activate(long (*fn)(struct restart_block *))
{
  current->restart_block.__fn = fn;
  arch_restart_block_activate();
  return -ERESTART_RESTARTBLOCK;
  current->restart_block.syscall_nr
}

IMO the ideal solution would be to add a new syscall nr to restart a
syscall and make it the same on all architectures.  This has
unfortunate interactions with seccomp, though.

--Andy
