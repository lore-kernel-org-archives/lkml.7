Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A40EC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18262133F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="dQu9VJgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfE0Kpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 06:45:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38360 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfE0Kpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 06:45:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id b76so9377044pfb.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 03:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aE2uyZ37ZTI8bLLwug7sYYZgqvxeNTU6PhXTmRA7gLg=;
        b=dQu9VJgdBq7ZkSxnXd6Vnw51QDGw13b6nH0fHvlJf3Rl6cRbyT8Xqfyu7bDEJFWESa
         cHCLs/VwkcJluIRiY7IjbjeJxhkIGMdG8LMKC2tP0xErcmbqWsaCrjees9Sd33cXBpz8
         vP4hJSvZRwBnhjHOx85hMczgGxEefDY5j9gN9f3ud7mMIVtLi02fjUmrKx8L766ahCgU
         EFSme7aD96SMkFThjGlM+XqSAxDAZnBxlrPqgzuTv6hzNA4tEeaNGoc1zYQzHdNTw3s+
         0XAhJBcSCJ1pcDsaZADdOhkMdNXLOcknyCtAlfbWUmUmxDRE+5NA1UDMJ14R/HTCuFwJ
         0qwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aE2uyZ37ZTI8bLLwug7sYYZgqvxeNTU6PhXTmRA7gLg=;
        b=SAgAKOnQKaLcKIwuI64Qje+sihoLBwiBm/dpsJECtdZPfgejhAkU/HbeJX0Os/qKHI
         tXWbE/V2clndffKIcJmEN2ontteYvzQbs0sEhWtfpVNwYdw/8G4b1LDb5GGOYx5SyaOq
         xN+ytVTUWsN4KsRpoBzGDL6TKoXdQpg5cez+mVNjlKNaFwV7G/9Z8MmAGE+s/0eAu4f5
         xa7ugvtuDCvnVlXGUYALuWaHzVqgMwSWi6c5pxQHC/SCL+9Bg95SYLRNlSJvePLZNfnn
         XLvkPnUICK7yS2d8GcrhlKkEeeComVZw+/h2thbKTw0VQBTBAgi/eWDYl/0Z13fSIKW0
         oT9w==
X-Gm-Message-State: APjAAAWbIgAaQkoU1AcXNphjPFGmBQ3u72POltifOqMkV+zU+IY9Cagm
        Yg7UAmzGqFdManmpS4PlXd0ryDSl1w47DQ==
X-Google-Smtp-Source: APXvYqxTnrwU1eKgSc9iQ0ApboFyS1UaBX+5oO/GHfL453T0/+RmxCYvvW89PUAefXa1VP6IaLpVvw==
X-Received: by 2002:a17:90a:d803:: with SMTP id a3mr30625374pjv.48.1558953940763;
        Mon, 27 May 2019 03:45:40 -0700 (PDT)
Received: from brauner.io ([208.54.39.129])
        by smtp.gmail.com with ESMTPSA id x7sm11077579pfm.82.2019.05.27.03.45.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 27 May 2019 03:45:40 -0700 (PDT)
Date:   Mon, 27 May 2019 12:45:30 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH 2/2] arch: wire-up clone6() syscall on x86
Message-ID: <20190527104528.cao7wamuj4vduh3u@brauner.io>
References: <20190526102612.6970-1-christian@brauner.io>
 <20190526102612.6970-2-christian@brauner.io>
 <CAK8P3a1Ltsna_rtKxhMU7X0t=UOXDA75tKpph6s=OZ4itJe7VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a1Ltsna_rtKxhMU7X0t=UOXDA75tKpph6s=OZ4itJe7VQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 12:02:37PM +0200, Arnd Bergmann wrote:
> On Sun, May 26, 2019 at 12:27 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > Wire up the clone6() call on x86.
> >
> > This patch only wires up clone6() on x86. Some of the arches look like they
> > need special assembly massaging and it is probably smarter if the
> > appropriate arch maintainers would do the actual wiring.
> 
> Why do some architectures need special cases here? I'd prefer to have
> new system calls always get defined in a way that avoids this, and
> have a common entry point for everyone.
> 
> Looking at the m68k sys_clone comment in
> arch/m68k/kernel/process.c, it seems that this was done as an
> optimization to deal with an inferior ABI. Similar code is present
> in h8300, ia64, nios2, and sparc. If all of them just do this to
> shave off a few cycles from the system call entry, I really
> couldn't care less.

I'm happy to wire all arches up at the same time in the next revision. I
just wasn't sure why some of them were assemblying the living hell out
of clone; especially ia64. I really didn't want to bother touching all
of this just for an initial RFC.

Christian
