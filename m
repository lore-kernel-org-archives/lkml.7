Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433D4FA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 01:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106A42166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 01:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573089098;
	bh=A3IuF9cZ30dT7CLYfgSYH8DNDwM08zBgkl7nEior09g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=daxKJE9ATStpXTaCn+BTHjj5B4sBiWymzoMmXW27GTkzYMdL6bBoPV2+JX56JhITV
	 1p0sCKiqTKElA5K0boOJIZ9Eoe6sCFER6Za7WlV/GzLFJRuOGgO3F2YKzv86XLdjkz
	 OHWjKZblaMqroCCsgMAeh65I6PtKxt9u25xTPnMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732902AbfKGBLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 20:11:36 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37563 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKGBLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 20:11:36 -0500
Received: by mail-lj1-f195.google.com with SMTP id l20so316682lje.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 17:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYzJNbIs0O9a8dPgX0R29N35kZPtuAANCvpSCPAwGWc=;
        b=gIByO5nFUKaSU/PpIZE6gMaLdyUfcKBOsp22xIL7XQAtKXEsAu84aBWKAefFC7n3Cx
         4oJTqrxjc+3i7v8IuyG2wJAIOUl+AAQ/9qA8e7kGRh9fmgpAL8vhTDTxQ7LbYIb7VaKE
         e50qm4JqsB6MFzM+IqvPwzndOuDKYHHc18Gnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYzJNbIs0O9a8dPgX0R29N35kZPtuAANCvpSCPAwGWc=;
        b=qPZKFfHUg2vKKtnjTTM5G3gJ5bbtclgosDe/07E/NLj9NtUAqhMvuBUZ4Z691sZmOz
         v0WzHXxpK0crXGlSxO+tLvFIy5LWIghChBBPB7XWFUnLWaAZPoxOMj9KGFrHLXsW+vcT
         MFw2uMjcCYI9JikwltoGB7KhKc/D6ExtnLpF9HMIkLWygP9gKSU4gECp6lBYndhBxOiT
         rl2NKngfASLxxX+b/EZv/mTbs7/l8j6XJ21uuLtaphzkYu0+bRHfVDsEZqyh5BzGFWu/
         xUogXzpZUb4qJ1xBd1oqRWRQhhB6D/jKrqI20sDN7TIbVTEpaPX/2v7haDDDRTzropx+
         Y+yw==
X-Gm-Message-State: APjAAAVrP9qvPq4Tct8PzQJvfgCbCEEqFRu9U/gxJb0v1+/6YYuqgsKc
        zK8HW3B2wVGpom7o95z++rxsO+pxWSo=
X-Google-Smtp-Source: APXvYqzqUiUFCRKWVRpL4qjH8x3Y4lt0obOO0Xfk3XE1FQt+f4PMElmjI+SjJk0rQCeFZtnoqGXWXg==
X-Received: by 2002:a2e:6c03:: with SMTP id h3mr250721ljc.86.1573089093854;
        Wed, 06 Nov 2019 17:11:33 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id f25sm215188lfm.26.2019.11.06.17.11.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 17:11:32 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id v8so309376ljh.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 17:11:32 -0800 (PST)
X-Received: by 2002:a2e:8809:: with SMTP id x9mr249100ljh.82.1573089091962;
 Wed, 06 Nov 2019 17:11:31 -0800 (PST)
MIME-Version: 1.0
References: <20191106193459.581614484@linutronix.de> <20191106202806.241007755@linutronix.de>
In-Reply-To: <20191106202806.241007755@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Nov 2019 17:11:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjXcS--G3Wd8ZGEOdCNRAWPaUneyN1ryShQL-_yi1kvOA@mail.gmail.com>
Message-ID: <CAHk-=wjXcS--G3Wd8ZGEOdCNRAWPaUneyN1ryShQL-_yi1kvOA@mail.gmail.com>
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage further
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 12:57 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Calculate both the position of the first zero bit and the last zero bit to
> limit the range which needs to be copied. This does not solve the problem
> when the previous tasked had only byte 0 cleared and the next one has only
> byte 65535 cleared, but trying to solve that would be too complex and
> heavyweight for the context switch path. As the ioperm() usage is very rare
> the case which is optimized is the single task/process which uses ioperm().

Hmm.

I may read this patch wrong, but from what I can tell, if we really
have just one process with an io bitmap, we're doing unnecessary
copies.

If we really have just one process that has an iobitmap, I think we
could just keep the bitmap of that process entirely unchanged. Then,
when we switch away from it, we set the io_bitmap_base to an invalid
base outside the TSS segment, and when we switch back, we set it back
to the valid one. No actual bitmap copies at all.

So I think that rather than the "begin/end offset" games, we should
perhaps have a "what was the last process that used the IO bitmap for
this TSS" pointer (and, I think, some sequence counter, so that when
the process updates its bitmap, it invalidates that case)?

 Of course, you can do *nboth*, but if we really think that the common
case is "one special process", then I think the begin/end offset is
useless, but a "last bitmap process" would be very useful.

Am I missing something?

               Linus
