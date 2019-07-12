Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF83C742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0732084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uky+NvlQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfGLHyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 03:54:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36579 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfGLHym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 03:54:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so3869580wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 00:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cdSZWK8qKwd5W63S3RZDijkSdQQAmStjw/2ryXw2d6E=;
        b=Uky+NvlQbBcddHsFAQL2EE3x3aklddkT8WRHQZe+qSCpHFipsWeOQRluRPJ80Mn1jq
         3xVHbsZ0GJTyLBGUaFq4MdhtyIrCwJcKqpzNJtFiaWn15j+lR1CJl8hhfDGWVjs0ci/A
         MD/0rmxymRr2xUi2jQXuyvERUSXW9Ywvk/w6sBQXJHo5B0jfZp0R0fpnjWnPZ6qshtM0
         AdoF2TXruU/CkWFVHEEu6FfyUwUYzW44L9gw6A7EWwVJl11LWo+rO0jlSt1u2i+CHHYs
         Vv0A7vE+WoaS9gKCtQaJGHz8zoI0WTmKbcu1sZfsU9mn+oNolNdVBt0LzQ3Fw2WYmZDu
         r24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cdSZWK8qKwd5W63S3RZDijkSdQQAmStjw/2ryXw2d6E=;
        b=GEREffdyxs0dpFlpHgwVqJMABycIpRV53+MK+Thr6ULxhzsfkaTQqg0C8XD4uddCCL
         j3n1gK3bXnaABkcrmpaR40l4wENJiEjQ7Kfz6Y8bX2VrhIomv2Gm1wYhn5IaaZ/LD4CM
         Z8iBbio/WNorjvPM7CFZylhT3Qf7oEuFKkCwwrNLVwoiDPwCPeOgEG/F9G8NHlAE6guD
         a1vdFAnzXsOCJe2Ujjt3kUjqyKnUPzxlZcXZQqrysh3MduE0xbsP1Tbhl06ESiX1IMnm
         KEr++6DTSBbOfzdWNe32HDFLXgx6VxA8vk3Shy1R02m/WeLlvOBkapwpPKNzVnNx0kTl
         4T5A==
X-Gm-Message-State: APjAAAVLkRrFnPOIEZ1AQFIP9ZDBFtFcfYtUpQWOx/qI7F+dNgSKZnkH
        i4EbhgTLYn84OdPu8dkU5yc=
X-Google-Smtp-Source: APXvYqxVYttLFK58vrQ4Lz5Ag7m6xPi3EX8BUOzTW9L7w9JmHxd7OKQmujv3Gm1M0hiaKAjyzTkByg==
X-Received: by 2002:a1c:9c8a:: with SMTP id f132mr8352800wme.29.1562918080238;
        Fri, 12 Jul 2019 00:54:40 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id o20sm18560550wrh.8.2019.07.12.00.54.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 00:54:39 -0700 (PDT)
Date:   Fri, 12 Jul 2019 00:54:38 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] waitqueue: fix clang -Wuninitialized warnings
Message-ID: <20190712075438.GA88904@archlinux-threadripper>
References: <20190703081119.209976-1-arnd@arndb.de>
 <20190711174949.dc74310efd1fd3c8bd4ea276@linux-foundation.org>
 <CAK8P3a2ZRw9B=X76yL-bRzC+01z6VaHDzPAhQQw7V9MXtkp+Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2ZRw9B=X76yL-bRzC+01z6VaHDzPAhQQw7V9MXtkp+Jg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 09:45:06AM +0200, Arnd Bergmann wrote:
> On Fri, Jul 12, 2019 at 2:49 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Wed,  3 Jul 2019 10:10:55 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > <scratches head>
> >
> > Surely clang is being extraordinarily dumb here?
> >
> > DECLARE_WAIT_QUEUE_HEAD_ONSTACK() is effectively doing
> >
> >         struct wait_queue_head name = ({ __init_waitqueue_head(&name) ; name; })
> >
> > which is perfectly legitimate!  clang has no business assuming that
> > __init_waitqueue_head() will do any reads from the pointer which it was
> > passed, nor can clang assume that __init_waitqueue_head() leaves any of
> > *name uninitialized.
> >
> > Does it also warn if code does this?
> >
> >         struct wait_queue_head name;
> >         __init_waitqueue_head(&name);
> >         name = name;
> >
> > which is equivalent, isn't it?
> 
> No, it does not warn for this.
> 
> I've tried a few more variants here: https://godbolt.org/z/ykSX0r
> 
> What I think is going on here is a result of clang and gcc fundamentally
> treating -Wuninitialized warnings differently. gcc tries to make the warnings
> as helpful as possible, but given the NP-complete nature of this problem
> it won't always get it right, and it traditionally allowed this syntax as a
> workaround.
> 
> int f(void)
> {
>     int i = i; // tell gcc not to warn
>     return i;
> }
> 
> clang apparently implements the warnings in a way that is as
> completely predictable (and won't warn in cases that it
> doesn't completely understand), but decided as a result that the
> gcc 'int i = i' syntax is bogus and it always warns about a variable
> used in its own declaration that is later referenced, without looking
> at whether the declaration does initialize it or not.
> 
> > The proposed solution is, effectively, to open-code
> > __init_waitqueue_head() at each DECLARE_WAIT_QUEUE_HEAD_ONSTACK()
> > callsite.  That's pretty unpleasant and calls for an explanatory
> > comment at the __WAIT_QUEUE_HEAD_INIT_ONSTACK() definition site as well
> > as a cautionary comment at the __init_waitqueue_head() definition so we
> > can keep the two versions in sync as code evolves.
> 
> Yes, makes sense.
> 
> > Hopefully clang will soon be hit with the cluebat (yes?) and this
> > change becomes obsolete in the quite short term.  Surely 6-12 months
> > from now nobody will be using the uncluebatted version of clang on
> > contemporary kernel sources so we get to remove this nastiness again.
> > Which makes me wonder whether we should merge it at all.
> 
> Would it make you feel better to keep the current code but have an alternative
> version guarded with e.g. "#if defined(__clang__ && (__clang_major__ <= 9)"?
> 
> While it is probably a good idea to fix clang here, this is one of the last
> issues that causes a significant difference between gcc and clang in build
> testing with kernelci:
> https://kernelci.org/build/next/branch/master/kernel/next-20190709/
> I'm trying to get all the warnings fixed there so we can spot build-time
> regressions more easily.
> 
>       Arnd

I'm just spitballing here since I am about to go to sleep but could we
do something like you did for bee20031772a ("disable -Wattribute-alias
warning for SYSCALL_DEFINEx()") and disable the warning in
DECLARE_WAIT_QUEUE_HEAD_ONSTACK only since we know it is not going to
be a problem? That way, if/when Clang is fixed, we can just have the
warning be disabled for older versions?

Cheers,
Nathan
