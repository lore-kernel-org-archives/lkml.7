Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BA5C74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 04:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5BA21530
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 04:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562818313;
	bh=1d8dAC60LzDPiVvA1D6bKHzeotgyr3lMgRRyxoQwW+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LVIr7784kdXixeimCV6W7hiV6VHfPBqnuZWy6rLG9gpbsD+3r/SYHMTWD6utMMQq0
	 VAv+Qn4YYHlUdRIufwVmCcm9ao2PtU0qKMAEcXXPYd1E0SVsf/ffWGzE+BlSy8NY5d
	 sdJMvyoM6JQR8ylL/jSDHzQYjUAVpD3BhrnutN4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfGKEK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 00:10:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38820 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfGKEK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 00:10:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id r9so4278688ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 21:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=es3onYrqLbpa7Sg/jHlny3UgofAk0AnWsFMN4Hpiw40=;
        b=cylJm6dVQKhOUgs7KIfMEf+l/0xCFn7M4HkOnMV5YehwokYf4o/DcNgerXxok/p0PA
         f+Bsy7JLNvmc8jNeoObUhT7Npo7EhCVRNJoo+/Wd1axwaFiKpjPBQzcfKvpfOka2q786
         MK+pdglCk6uEpoHUq3ooeJ3tXLxXaekEJyk+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=es3onYrqLbpa7Sg/jHlny3UgofAk0AnWsFMN4Hpiw40=;
        b=TvSC+PBzOkIQjgkP3MycjwE+lncNFjEcwv2mGw5ZvE0bCLfyjm4G2hewK8AOVGnpcc
         ZvYtYObKdtSXv7uX2ay7x+4Vey/lEu/JYNJZeAMu5EG5y8y6kNA86F363bT79ZX6iNeF
         QZjub9GpGljVx27oIKQ3Wo85VvDTE7zw40xJH5HhxtVmQdFlAGNlj0k88iSsuH9nIZLd
         50vG34biHcF0uTckp2QgIXzqMCT2K8z8URQV9dJVIFvyvcaeb0f3zSiPRF+AbO/h9d2a
         RV4rb48m58NnFZHQIHu1T8LsL7Z736rdMWIm5jkLnzBriFWktANGDno+BwtJ5fM30kZP
         mbpw==
X-Gm-Message-State: APjAAAULpg81wGnjRuxFGcx4DDdLNv15RPvyJAd3j8YRBd6oegos7tH1
        aMqf0OFXzsGE621mO9ciXUZ6/xIQq74=
X-Google-Smtp-Source: APXvYqzdeTTTQg19JDlfV7xRTP2ET3B7SV+3a+H5dQq41I5jf76YBfOsvgtNjav9OajwoLFmMI1YCg==
X-Received: by 2002:a2e:800c:: with SMTP id j12mr571332ljg.22.1562818226835;
        Wed, 10 Jul 2019 21:10:26 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id v17sm854674ljg.36.2019.07.10.21.10.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 21:10:26 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id c19so3056793lfm.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 21:10:25 -0700 (PDT)
X-Received: by 2002:a19:641a:: with SMTP id y26mr563262lfb.29.1562818225520;
 Wed, 10 Jul 2019 21:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190711023501.963-1-devel@etsukata.com>
In-Reply-To: <20190711023501.963-1-devel@etsukata.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Jul 2019 21:10:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgd68CAFKXYKHojqEWu17Hrsk2UmMVcN3SQFuXnNMnc+w@mail.gmail.com>
Message-ID: <CAHk-=wgd68CAFKXYKHojqEWu17Hrsk2UmMVcN3SQFuXnNMnc+w@mail.gmail.com>
Subject: Re: [PATCH] x86/stacktrace: Fix infinite loop in arch_stack_walk_user()
To:     Eiichi Tsukata <devel@etsukata.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 7:35 PM Eiichi Tsukata <devel@etsukata.com> wrote:
>
> Once we find a lack of return address, there is no need to continue
> loop, so let's break out.

Looks good to me, feel free to add

  Acked-by: Linus Torvalds <torvalds@linux-foundation.org>

and I'll assume this comes through the x86 -tip tree..

         Linus
