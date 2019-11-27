Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5D9C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 04:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21255207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 04:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574827471;
	bh=WrHVImCShCE7ibbXaLwhnf0BKiDWobWzq4KI8FNv7kU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1TjRxG0GbPTRZE2USugc/tSLfKgo6qO+adUUAcDtjc7cq6gJxqqv6ATtvDdSpYp4w
	 R29UAFuVUq3rzWsuQvtWbMQ804gENgj5Y1SXfN62WoLNh4KFpEfKhncO0u8WhbdFXn
	 EN9e7ePYaI5vYRVk2sYNSydd9NXuvx5j/YdcUWNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfK0EEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 23:04:30 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37045 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfK0EE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 23:04:29 -0500
Received: by mail-lj1-f196.google.com with SMTP id d5so22781097ljl.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 20:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rd62a4+kKdVGM6mxx4wZ7hE246doAaPmYNs4HO65uTc=;
        b=f2lBh8HSNpUVoEVI7YAMjgFbAjJ4qgZOSy1I+ycg6K4sEyb1f6UqlcqcJgY8LlrEaY
         C2cwcHjQqk6W16tM9JIvKKArAVS8TolUZdFdX844nnJq42jJOxmEslFLvYYxAZQNOz/J
         FtVpsiY8U/lssN472Ro2p7e2XrppLWv+x8l9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rd62a4+kKdVGM6mxx4wZ7hE246doAaPmYNs4HO65uTc=;
        b=P7yVcvTWdOf38la/IHvZAEiiIEWgqPJBdqgh1EOTjCRqTo2yGuHzAcOigRN+wV0XAV
         AHzCXijspnp1Z7lkNdVOh9ZPfULBPE7gg/M9LaPU9VoYXEvs+2jaWvN3hcDBMkuI+BJU
         hwDz5Iwiyy+5DcOtOqEpAvAxeSU8SspprkZzzO96FcuwQWjKWV41YXQCWZehjeuVqoAH
         8k2j+6eXffvCavOK3bEQkoV921omk81S1jECV1qtcLK4m+bsWjmuuqO9b0Svq1pTuPCN
         1OiO/1Bcne06ZyFvkTMJqCFAx3LBpK5YU5b8AMMROkIGxfz5f3oUHJGASAaW8AsAdz5U
         FNNg==
X-Gm-Message-State: APjAAAVG9nEqEVjDz/P7E537BSJuuzebxZ0isgxbS524al/mKZD932P8
        PVRTIDDlvliFjjYTi1pWUlLixmsw4Sw=
X-Google-Smtp-Source: APXvYqyzl8WlAcFlu/5+4YfbBBVgMv6ImzWnMkh/qWJrxkhmtxOuECqhFsWiy64HXlgclzao1318iQ==
X-Received: by 2002:a2e:85d5:: with SMTP id h21mr28752855ljj.243.1574827466467;
        Tue, 26 Nov 2019 20:04:26 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id f11sm1634693lfa.9.2019.11.26.20.04.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2019 20:04:25 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id f16so15943785lfm.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 20:04:24 -0800 (PST)
X-Received: by 2002:a19:4bd4:: with SMTP id y203mr24700097lfa.61.1574827464261;
 Tue, 26 Nov 2019 20:04:24 -0800 (PST)
MIME-Version: 1.0
References: <20191126110659.GA14042@redhat.com> <20191126110758.GA14051@redhat.com>
In-Reply-To: <20191126110758.GA14051@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Nov 2019 20:04:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=whrhuNg_53wc3pBVToH-AUwKDbC5P_cb7=8bYfn=BYCJA@mail.gmail.com>
Message-ID: <CAHk-=whrhuNg_53wc3pBVToH-AUwKDbC5P_cb7=8bYfn=BYCJA@mail.gmail.com>
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

On Tue, Nov 26, 2019 at 3:08 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> Alternatively we could add ->compat_restart into struct restart_block,
> logically this is the same thing.

That sounds like the better model to me. That's what the restart_block
is about: it's supposed to contain the restart information.

I'd much rather see the system call number added into the restart
block (or just the "compat bit" - but we have that X32 case too, so
why not put it all there). And then the get_nr_restart_syscall() hack
goes away and is just "set state from the restart block".

How painful would that be? I guess right now we always just set all
the restart_block info manually in all the restart cases, and that
could make it a bit painful to add this kind of architecture-specific
flag, but it _sounds_ conceptually like the right thing to do.

I definitely don't love the "magic sticky bit in thread status" field model.

             Linus
