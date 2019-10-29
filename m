Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1DACA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F249921721
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572368638;
	bh=Eia+GZH44EeGJ54mGoLfGXl2InVxm6ZE3joewBlbUhk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kTDJulb/OehfRiECoPr0p9EnWS+YEnXkZoaI/Vc7XWjSUIjuN5FRNCTcfTULWPbM/
	 Cg1kAzYXUWlKp6X7WO/MwacHJgJ6154mZTtJODnwpqp+dUm4BIjXTH22a8xYDw794N
	 GvlHnZd4Wh7PVeEzR8FDBh2zTg0uBCvYx7XwQxdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390728AbfJ2RD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 13:03:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbfJ2RD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 13:03:56 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5469C218AC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 17:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572368635;
        bh=Eia+GZH44EeGJ54mGoLfGXl2InVxm6ZE3joewBlbUhk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lPu1XwPS59/pvfiPwEUwru3NeqNzPFZyXHJBiv4zBAG0aCoMUEOwDTS9nostwp+Ay
         HL+ByC7tsYHuABMhQn6+RU47q10e1cBxgUkoeStmIdCsxrBt9HV8X8S/efUOg/+n6m
         oyv1MrV2wbNqTXNyqfE5OlNetLJUfC6dDcl+MnGY=
Received: by mail-wm1-f47.google.com with SMTP id c22so3223897wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 10:03:55 -0700 (PDT)
X-Gm-Message-State: APjAAAXbk365/9J7+kb3MrTQLzfvEYCrVW21cJtW4bOmgN+FEeEDBra2
        fZb7uHn34bOfs0NU2tUtwI4l7XnpsJshyQvBw2YdWA==
X-Google-Smtp-Source: APXvYqzJWcbs84/PwCmd/nkZZ5hCGiu24QSMYOGvyu5VK5EpkxoEblrXGkFf/eAJ13JTrsKkAiwZMmn6nzysJ9Qwh0s=
X-Received: by 2002:a1c:1fca:: with SMTP id f193mr4715301wmf.173.1572368633735;
 Tue, 29 Oct 2019 10:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <1572171452-7958-1-git-send-email-rppt@kernel.org> <2236FBA76BA1254E88B949DDB74E612BA4EEC0CE@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4EEC0CE@IRSMSX102.ger.corp.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 29 Oct 2019 10:03:42 -0700
X-Gmail-Original-Message-ID: <CALCETrWN9kc+10tf7YoBp9ixqkO_KZ=b1E_cFBr_Uogxhu68PQ@mail.gmail.com>
Message-ID: <CALCETrWN9kc+10tf7YoBp9ixqkO_KZ=b1E_cFBr_Uogxhu68PQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user mappings
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Alan Cox <alan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 4:25 AM Reshetova, Elena
<elena.reshetova@intel.com> wrote:
>
> > The patch below aims to allow applications to create mappins that have
> > pages visible only to the owning process. Such mappings could be used to
> > store secrets so that these secrets are not visible neither to other
> > processes nor to the kernel.
>
> Hi Mike,
>
> I have actually been looking into the closely related problem for the past
> couple of weeks (on and off). What is common here is the need for userspace
> to indicate to kernel that some pages contain secrets. And then there are
> actually a number of things that kernel can do to try to protect these secrets
> better. Unmap from direct map is one of them. Another thing is to map such
> pages as non-cached, which can help us to prevent or considerably restrict
> speculation on such pages. The initial proof of concept for marking pages as
> "UNCACHED" that I got from Dave Hansen was actually based on mlock2()
> and a new flag for it for this purpose. Since then I have been thinking on what
> interface suits the use case better and actually selected going with new madvise()
> flag instead because of all possible implications for fragmentation and performance.

Doing all of this with MAP_SECRET seems bad to me.  If user code wants
UC memory, it should ask for UC memory -- having the kernel involved
in the decision to use UC memory is a bad idea, because the
performance impact of using UC memory where user code wasn't expecting
it wil be so bad that the system might as well not work at all.  (For
kicks, I once added a sysctl to turn off caching in CR0.  I enabled it
in gnome-shell.  The system slowed down to such an extent that I was
unable to enter the three or so keystrokes to turn it back off.)

EXCLUSIVE makes sense.  Saying "don't ptrace this" makes sense.  UC
makes sense.  But having one flag to rule them all does not make sense
to me.
