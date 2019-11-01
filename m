Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB16CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4081F21734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572636319;
	bh=m3f9F38m5vqjc2xonynn9KjryMszWAzyWjRQ0GiQRDg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ppBcOhVkrRUHLwyMcmRqhHXVgjiz0GDlTTL7VcVxU0I9oWlzyX07bqi9UYNLVQAI0
	 yaUoS2RtbkOalff2uyK0X5bzh4Qs6g4KkQkx6nll37zFHKWdmzPf2qaetQVR+HaV13
	 YT+gSPZXgKUC3jMKq9TagGd/kTiDY9/gtoeTSac8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfKATZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 15:25:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34651 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbfKATZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 15:25:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id 139so11352546ljf.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 12:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YYxjqcv/PYLPJKobOoHtNXOrj3psbjFOHnMYal58y3I=;
        b=c+Gs+TI8cuAjd4kd2hWlKLPAsPgXseDnrsUcVlBiA4ySvAjVj2n7unbZVDl4mRhd8k
         QGeff69FovwuouMkPqWploEvqGg2xz0OwyPfdogz9QpK6BaN9Ka9RJgzEVo5nEiWZyg/
         /eJ1qfcbNdodLUDZDnlwBOGgeV6KiV/t48RJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YYxjqcv/PYLPJKobOoHtNXOrj3psbjFOHnMYal58y3I=;
        b=BLNglSjbsFiM3R4wenviX9ZWVFl8BSc1rtPBoJo3h3J+E6l5tM8PLTlG4+Zql4sP1m
         G5XyHzwr8HeDlt2MPYx0PVdKi6xzpgyM6NX0aLQa6aWEflayYa8kE6XqyGHHPCIP0ukQ
         qxl6E3K7C8TBPGuUfFQ5990uQG24zL5Riy7pRnK2LSX8kdpxJ+gCp7pIu0prgRPblWru
         SIr88q4IfKanhMr1eaG6rtjodpdJicwTQYNn72y1X/gz65gHUk7Bmyd+KHY6TAqgz4++
         B9y0lHVz/PNdmCRLSldbXObRvFhhahRoDhXc/liUian0RnyG0QLkXao6dk6eLqN3CDmP
         RjLw==
X-Gm-Message-State: APjAAAWgOoplitu6MahpSpnwJwQq6RmEo4F8tgKiRNj9HtcQuG+YuDcH
        zpyuFV7BymPPeKza1PNViv2bsjKJNdI=
X-Google-Smtp-Source: APXvYqz6d9kEaQAA2HWIKR0eIagBuyW2BQ18QDFKsF/xG1Kt8biHlD7ssyMt3Fk6R+VQ/7a3SK38fg==
X-Received: by 2002:a2e:63c9:: with SMTP id s70mr9420643lje.73.1572636313342;
        Fri, 01 Nov 2019 12:25:13 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id v21sm2857506lfe.68.2019.11.01.12.25.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2019 12:25:11 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id t5so11346340ljk.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 12:25:11 -0700 (PDT)
X-Received: by 2002:a05:651c:154:: with SMTP id c20mr9282919ljd.1.1572636310860;
 Fri, 01 Nov 2019 12:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
In-Reply-To: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Nov 2019 12:24:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjqx4j2vqg-tAwthNP1gcAcj1x4B7sq6Npbi8QJTUMd-A@mail.gmail.com>
Message-ID: <CAHk-=wjqx4j2vqg-tAwthNP1gcAcj1x4B7sq6Npbi8QJTUMd-A@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] pipe: Notification queue preparation [ver #3]
To:     David Howells <dhowells@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 10:34 AM David Howells <dhowells@redhat.com> wrote:
>  (1) It removes the nr_exclusive argument from __wake_up_sync_key() as this
>      is always 1.  This prepares for step 2.
>
>  (2) Adds wake_up_interruptible_sync_poll_locked() so that poll can be
>      woken up from a function that's holding the poll waitqueue spinlock.

Side note: we have a couple of cases where I don't think we should use
the "sync" version at all.

Both pipe_read() and pipe_write() have that

        if (do_wakeup) {
                wake_up_interruptible_sync_poll(&pipe->wait, ...

code at the end, outside the loop. But those two wake-ups aren't
actually synchronous.

A sync wake is supposedly something where the waker is just about to
go to sleep, telling the scheduler that "don't bother trying to pick
another cpu, this process is going to sleep and you can stay here".

I'm not sure how much this matters, but it does strike me that it's
wrong. We're not going to sleep at all in that case - this is not the
"I filled the whole buffer, so I'm going to sleep" case (or the "I've
read all the data, I'm waiting for more".

It's entirely possible that we always wake pipe wakeups to be sync
just because it's a common pattern (and a common benchmark), but this
series made me look at it again. Particularly since David has
benchmarks that don't seem to show a lot of fluctuation with his
changes - I wonder how much the sync logic buys us (or hurts us)?

               Linus
