Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C8EC2D0C2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00FE21655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o10CEcaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgABT5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 14:57:25 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:36484 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgABT5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 14:57:24 -0500
Received: by mail-il1-f193.google.com with SMTP id b15so34968231iln.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 11:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R4iJSqevWdPyqOUmhE3mWH5fpeZvhvCfBp6cN45qRtI=;
        b=o10CEcaJsvbpjVX6UPZffvRUyKoYVDNats6yRm5uzS0NEeH88LH3Atvn6UTrlRLLz3
         /myAsYDWqGtiMWng3rJKHPAfoJNgcgAIpon3T8rORwGzebHvzsb0/PvEokm+hetSUK2w
         XoTgnxzI+c85ygnUrH1dIqa9LrDpiddlbTZupWUqzSAVm+55WwTsDXRW94wPoAN1ihn/
         /xYz9XGWmMSTDdis5QQcfV00JC+Is1ev9Q/1w5npKbLvGK2dbApMhHkiAZrUxOigf5WR
         qJTUkJErHoyjCXLofenxYlIHbRDJC5VM9uMfGpJc28o92pR76m37a5CmQiMvKPiDEMaK
         OXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R4iJSqevWdPyqOUmhE3mWH5fpeZvhvCfBp6cN45qRtI=;
        b=g7Qemtja8jBPwvL7G7p1EsPT5CzqNJJGzWFcHXwyOBE9ctJePW4CgwjaZwWjLPC4qe
         lJ/xkN5ZhfXXQgItWB4bjjivm4oV4yIWAfP+YpjzQQSpDuXMmyxpPoimLu8mWmszp1jU
         eRTjBaat3dZAMnoXvGe0WqANG8hdrGCk37wzKPFNdIkqYWjkdeCyRh0epB5cckML3Kki
         igB//VzEJ7mCSaaBt2mvgDKxQM1XXRnLBwFr6SCLczEhDurz5WPb31YusHJX9ZhLSmtP
         9z+2HuYh9ssJESwypkZLwB9EIoz7/jDdSRl80tn3EriWv+NIFGTFIcXJN3yrtauyKxXE
         QlLA==
X-Gm-Message-State: APjAAAWaJN92fYh87mqOW7VjfSQMXW2XoCMMgzWUVfGfjd0bHQShgtxd
        ReSffjZto6fxUEh+EK6Z0QGWaPDjrABf5lCbP7nqOQ==
X-Google-Smtp-Source: APXvYqybSlxSM8g3AGH9sbux2INMPOuflfSmt+mRtxlt8FjsryRwB8tnU1cF8H4UA1L5VIEsWtxiU0vFtmlzs2DAFn8=
X-Received: by 2002:a92:d642:: with SMTP id x2mr71408859ilp.169.1577995043289;
 Thu, 02 Jan 2020 11:57:23 -0800 (PST)
MIME-Version: 1.0
References: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20191216114636.GB1515069@kroah.com> <ce36371b-0ca6-5819-2604-65627ce58fc8@i-love.sakura.ne.jp>
 <20191216201834.GA785904@mit.edu> <46e8f6b3-46ac-6600-ba40-9545b7e44016@i-love.sakura.ne.jp>
 <CACT4Y+ZLaR=GR2nssb_buGC0ULNpQW6jvX0p8NAE-vReDY5fPA@mail.gmail.com> <CACT4Y+Y1NTsRmifm2QLCnGom_=TnOo5Nf4EzQ=7gCJLYzx9gKA@mail.gmail.com>
In-Reply-To: <CACT4Y+Y1NTsRmifm2QLCnGom_=TnOo5Nf4EzQ=7gCJLYzx9gKA@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 2 Jan 2020 11:57:12 -0800
Message-ID: <CACdnJut=Sp9fF7ysb+Giiky0QRfakczJyK2AH2puJPYWQQKhdQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Add kernel config option for fuzz testing.
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 12:53 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> +Matthew for a lockdown question
> We are considering [ab]using lockdown (you knew this will happen!) for
> fuzzing kernel. LOCKDOWN_DEBUGFS is a no-go for us and we may want a
> few other things that may be fuzzing-specific.
> The current inflexibility comes from the global ordering of levels:
>
> if (kernel_locked_down >= level)
> if (kernel_locked_down >= what) {
>
> Is it done for performance? Or for simplicity?

Simplicity. Based on discussion, we didn't want the lockdown LSM to
enable arbitrary combinations of lockdown primitives, both because
that would make it extremely difficult for userland developers and
because it would make it extremely easy for local admins to
accidentally configure policies that didn't achieve the desired
outcome. There's no inherent problem in adding new options, but really
right now they should fall into cases where they're protecting either
the integrity of the kernel or preventing leakage of confidential
information from the kernel.
