Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2519FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950E620673
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V8oNGLl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbfKHR4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:56:03 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:39185 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfKHR4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:56:02 -0500
Received: by mail-io1-f45.google.com with SMTP id k1so7295854ioj.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 09:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MIOSuIKsUyxB2M4djsqhXbm2T/JzMnIFwkmpg6fA+Ms=;
        b=V8oNGLl6qjTwrqheJvYzesqyiTnVno/IaIKZP7pJ0WT49dXpmErqA83AXZMdzOh2SG
         Je/FJRqdTlTebSps9vRJEZZnhUyn6Fj2UBX5ciMlsYJKfUxgPInxODDuST1cz+4KMYNH
         SuNHQQsWbmzYnw3dfuGcLU/7NjZxthkcmPq5okSnoxlVARkA/OdPsgIZoXLnMAOlMt7S
         zTdXwAgGiSxiPRc2XWy0p5rvSHw2pg+QxEvL49oKQfyV/NZQn634FIvPKmy17CH6ObwM
         7wbxbM4eY+lazZepLnUuSJ+f5XQM2rzBJYrjP0t2GzSa+cDpnD9udXUOflC/ynZOoMuK
         aKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIOSuIKsUyxB2M4djsqhXbm2T/JzMnIFwkmpg6fA+Ms=;
        b=eaWsj4GDrdcOUbrD+2QcwJBR6Y4bxG5AMO8VDfVDJSpKq0bhP+6q2wy0GmMhWAM6gg
         MLvRCZTV5RjysTzBG54NmUdNkXn2JW7dIeUshV4RkQJ7KbkP0i+WOdkWO5bddgx0i9KF
         cIJRbN87MdHY/TmVXaMJ1omkkpRRy1HQ4qvyfvpOMrI7NQVMD9PGZn+yhSc9v9JeLS2l
         4Ml4SxbuxcJ/TAZFhES/LLMpHceJA1wJYJlgtATxGJgp23uoys79AykG40sJBgjXZ+M8
         g2W0uBbnpeS4OrYI5X6SjRvEBcJmt0rxBPjKPiD9kxmEW0I8R7CtKB0smKEYMgSbEuq8
         Fwxw==
X-Gm-Message-State: APjAAAWlHNY0VGIucjGCxauiJVwF129Yi6v0q2Rf/i9+3Bwfz4AAhYvK
        uYMLsEKJqsCfM4MqBvuZBn+RPv/Hy4Sgy8KMSjnh2w==
X-Google-Smtp-Source: APXvYqw5kzvzbfFmFDbCNHG+gzaOMReqKjx6GVYSfTWVORZ0fuGL3qIL3c2gzxQ4/m2ex05aMkaCgR5t4+n0/KB6Phs=
X-Received: by 2002:a5d:8953:: with SMTP id b19mr12142211iot.168.1573235761783;
 Fri, 08 Nov 2019 09:56:01 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
 <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
 <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com> <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com>
In-Reply-To: <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 8 Nov 2019 09:55:50 -0800
Message-ID: <CANn89i+RrngUr11_iOYDuqDvAZnPfG3ieJR025M78uhiwEPuvQ@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        Marco Elver <elver@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 9:53 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Nov 8, 2019 at 9:39 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>
> > I'd hope that there is some way to mark the cases we know about where
> > we just have a flag. I'm not sure what KCSAN uses right now - is it
> > just the "volatile" that makes KCSAN ignore it, or are there other
> > ways to do it?
>
> I dunno, Marco will comment on this.
>
> I personally like WRITE_ONCE() since it adds zero overhead on generated code,
> and is the facto accessor we used for many years (before KCSAN was conceived)
>

BTW, I would love an efficient ADD_ONCE(variable, value)

Using WRITE_ONCE(variable, variable + value) is not good, since it can
not use the
optimized instructions operating directly on memory.
