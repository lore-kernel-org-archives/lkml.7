Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3E7C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5494120896
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560452934;
	bh=M5fVHuz7GM200rX+um5CG9lWSJ5LN83V9cleMiqSr0w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lmF+qJz4YV6qFNnjeaR09P57a2Bt+unfMdXqXZmP5hFrQZxwXViTJv9Jkwo7EzeU2
	 GFtYYNIp6LEIKVndJSsUtnutUHpTHvJxksAdJi6O/oOCIY1sUvp4zE4wwBYaQol5qZ
	 AxJVCDdpIBIzb7YSmz/A5tg/U8SpQOxE0X/stOco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbfFMTIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 15:08:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfFMTIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 15:08:52 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 379E421721
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 19:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560452931;
        bh=M5fVHuz7GM200rX+um5CG9lWSJ5LN83V9cleMiqSr0w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0mQsma9LhbSOHNzZVajdIzZemifGcr2vm+eoDvWHCFOu5QioUwGz0anWuVUWjWkCm
         nJ2OatAf+pOKXIw9oXDAR6BG5giv/GHzyV1s4G6AnzAxmMFcbuDj45BtghRwzKjtDj
         iUxkLEHdfoknLzxjSezsgwAGu+bJbg1lOdbn+e8w=
Received: by mail-wm1-f41.google.com with SMTP id c6so11263658wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 12:08:51 -0700 (PDT)
X-Gm-Message-State: APjAAAUMxjSJlPNp9tdLhsABndNStWWN8spttcBSRF9QzAVjKyCEg5cm
        +DJOa+h28WP8U50cmD9LocKVdYhsXsa86ChGd+wpMA==
X-Google-Smtp-Source: APXvYqztejRGvq27Iw+y0cfs1NyXH8Lm8jD6LvUHm3icGIgaUgnfnhaK9ERONLPuzbZ61xdPyrlnbiBZJeMMJtqJK0w=
X-Received: by 2002:a1c:6242:: with SMTP id w63mr5199746wmb.161.1560452929712;
 Thu, 13 Jun 2019 12:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560198181.git.luto@kernel.org> <131caabf9d127db1a077525f978e1f1f74f9088f.1560198181.git.luto@kernel.org>
 <201906101342.B8A938BB@keescook>
In-Reply-To: <201906101342.B8A938BB@keescook>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 13 Jun 2019 12:08:38 -0700
X-Gmail-Original-Message-ID: <CALCETrXJA2ws=M_RBge1+nVGkDR0qX-jdFypYxuE3yDiikt46w@mail.gmail.com>
Message-ID: <CALCETrXJA2ws=M_RBge1+nVGkDR0qX-jdFypYxuE3yDiikt46w@mail.gmail.com>
Subject: Re: [PATCH 2/5] x86/vsyscall: Add a new vsyscall=xonly mode
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 1:43 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jun 10, 2019 at 01:25:28PM -0700, Andy Lutomirski wrote:
> > With vsyscall emulation on, we still expose a readable vsyscall page
> > that contains syscall instructions that validly implement the
> > vsyscalls.  We need this because certain dynamic binary
> > instrumentation tools attempt to read the call targets of call
> > instructions in the instrumented code.  If the instrumented code
> > uses vsyscalls, then the vsyscal page needs to contain readable
> > code.
> >
> > Unfortunately, leaving readable memory at a deterministic address
> > can be used to help various ASLR bypasses, so we gain some hardening
> > value if we disallow vsyscall reads.
> >
> > Given how rarely the vsyscall page needs to be readable, add a
> > mechanism to make the vsyscall page be execute only.
>
> Should the commit log mention that the VVAR portion goes away under
> xonly? (Since it's not executable.)

No, because vsyscall VVAR is long gone no matter what.  Even the old
vsyscall=native didn't have it.
