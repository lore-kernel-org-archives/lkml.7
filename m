Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB8EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E652072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAm+XItX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfLQIYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 03:24:53 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:44532 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfLQIYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 03:24:52 -0500
Received: by mail-pj1-f66.google.com with SMTP id w5so4234490pjh.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 00:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oeT07/QwoKqTaqY/Bi4yvvkin+Xy8ImWNOXn4R8EJaw=;
        b=NAm+XItXgM1TQWT93ycGUKURg/INuZRS9zKT/FnFjkSXX7wp6msqp8Lhl4c/4zZiEV
         QqXG5F9xvoiHh5adQLwPalP/THL5bRR0IOvBKWparGGi9PJeoXYdzIJUhwzNdlELeGKE
         gpHfRxGh8HNagLpnIpsi7sfnCtT+0HO1kIRtyecHFL/utfLk5zGbYbOZCWhD1Eu6dKzq
         mN7++LrGMVWXBNeg8duaY3hLKVfxOcG97L2vK5lJCQ/LRX+djmgwSwjhb174qe/u9Mwu
         Lv5BkR8atKf8+H/TIwhtvUOOL+FzBwaiesUwyB8OlfErcl0EXDZDN6hNTEmvV4r5HNwr
         2S0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oeT07/QwoKqTaqY/Bi4yvvkin+Xy8ImWNOXn4R8EJaw=;
        b=ActWHDxz/jlq34w8qB8JpstI79W7LaTujNLFzt2FnsgtdeST1gbUSOVvpgjaBnON9L
         dCs/5n3lROPAGbjjvfJsL4eS3oGhZKBSlRO5Pf82HK6w4JhGa267ZcjbrSFfPJtmUgW/
         4cLsvFSB/skPtqFsxoPKKWdqxeYu5miO93zgNekQIMlldaR1epx6e5XmVJP8rSNDVaQ2
         LJy+bltkH7u+fA6HBngswlKkiZ8eex6nFBTLlTzaUMkZ+UUXkl/8uzNiMNBkidLuVj02
         3H1Y/6J7RJ1i2MkktHSCwYMxpGHtzuL4pNQxP53CQGmvTCSeHnssiocH7gvXGqHetwoX
         i86g==
X-Gm-Message-State: APjAAAVG9ezuouYGkZu8YUg7lzKsxx9g7iYyjLkypNsDVbm0GDhB+Fiv
        eosi+ECtLiIKlK/mIDcitAY=
X-Google-Smtp-Source: APXvYqyW7gXqj6pbkuwrWwBznN80lOfeuq4pUhBgBj3exxsN1LtJNO519DhStu01L5HrRHOjEVGsBA==
X-Received: by 2002:a17:902:9f98:: with SMTP id g24mr21638765plq.325.1576571091870;
        Tue, 17 Dec 2019 00:24:51 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id h128sm27593041pfe.172.2019.12.17.00.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 00:24:50 -0800 (PST)
Date:   Tue, 17 Dec 2019 17:24:49 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kconfig: Add kernel config option for fuzz testing.
Message-ID: <20191217082449.GC54407@google.com>
References: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20191217051234.GA54407@google.com>
 <CACT4Y+ZV_syKQt6hDwf3WH5-LpFo==rsVsQY7+YCMfpUCtzj_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZV_syKQt6hDwf3WH5-LpFo==rsVsQY7+YCMfpUCtzj_A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (19/12/17 08:54), Dmitry Vyukov wrote:
> On Tue, Dec 17, 2019 at 6:12 AM Sergey Senozhatsky
> <sergey.senozhatsky.work@gmail.com> wrote:
> >
> > On (19/12/16 18:59), Tetsuo Handa wrote:
> >
> > Can you fuzz test with `ignore_loglevel'?
> 
> We can set ignore_loglevel in syzbot configs, but won't it then print
> everything including verbose debug output?

What would be the most active source of debug output?

dev_dbg(), which is dev_printk(KERN_DEBUG), can be compiled out, if I'm
not mistaken. It probably depends on CONFIG_DEBUG or something similar,
unlike dev_printk(), which depends on CONFIG_PRINTK. It seems that we have
significantly more dev_dbg() users, than direct dev_printk(KERN_DEBUG).

Does fuzz tester hit pr_debug() often? File systems? Some of them
have ways to compile out debugging output as well. E.g. jbd_debug,
_debug, ext4_debug, and so on.

	-ss
