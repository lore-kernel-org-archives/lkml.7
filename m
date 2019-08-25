Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C425CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 16:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985B3206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 16:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566752090;
	bh=OLrcB5EKqj5esxICVrSM5vPmzFQgaYDykmO1uXWFuJ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=etvRayP52Y9bTrOBnWlOcaivlu+FDi7JhMg0tZ0Y8A+sMjn4WSbDJIxtxRuDkZOPb
	 M/at/XyRhWOw3M9GeTCX8dswUq664Ut5nVCZc+LczJPx912H38lZmCBpOfCasLwwuV
	 X+pRDanScHdNRGMOqaLLdxt2XnRfwtEbjmllzfp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfHYQyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 12:54:49 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43098 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbfHYQyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 12:54:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id h15so12944660ljg.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 09:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K9mfikaog5m9TlHzz1OZ2c3SIZ9rUEgQtLLv9odABp8=;
        b=VGT4mVx7ItxAcdQWNUhm9blPz85WO9/WEYkXQogbJQtI93gPLRyxAFh34xnSS8dqz8
         /uK7jPyMK45qlXiFDO5XMQgnAXAzG4YiXCVQsW9Q99wSoqMNtRcC724q3GEbKHH4L/Lq
         VJjQ2aIlfUnf714tl1JJvhr2lVM8vxb82bLx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K9mfikaog5m9TlHzz1OZ2c3SIZ9rUEgQtLLv9odABp8=;
        b=OFpucjpom/RArG0g/EEw8bXoznzJgD1giwpMNKWR4ENMLPP5H1XPRxYrOhn31U7+6Q
         wavN3wQIsXgiiox2NEFKMpXq+XzurpQl7Kj7PvNhYbcdaQzJUr4HY3welgbd5Lp02smo
         0K1oYrzgWAP/fRRjg+Ik/r+pFffejHx3HOYukq319PIpM7TG4EYncY4bUiKsqstuwROw
         E6PAweT+IQLprh+oybE4Okk9WJ8lXWTXC3jQgQt7Z6WvTQ4dt7Q0rUqdiFnF/xEtnqSF
         szGGktQ6G6w4HdVgI8yjA/Ul0Yt5Aa/u2EJVtXRJ4Tq5LeKCWe0SI2NODbmKaOKWnl+B
         fBxw==
X-Gm-Message-State: APjAAAUOe09sdP5GfLA2MpWWGmrYugJVF3NcvYZMtxrZ80xWtasLtf9e
        KyeDXVfqoELovnOGrus4N5X1JTHX9KE=
X-Google-Smtp-Source: APXvYqxa0MuCQZpRGD3n0U7+0WyLVg3xgxdcYoYP2Ff8n7izIc9iofe+39Jh7HAwK+ZWf+sfdRTqGw==
X-Received: by 2002:a2e:8606:: with SMTP id a6mr8408989lji.173.1566752086568;
        Sun, 25 Aug 2019 09:54:46 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id z3sm1635895lji.4.2019.08.25.09.54.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2019 09:54:45 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id x3so10512405lfn.6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 09:54:44 -0700 (PDT)
X-Received: by 2002:ac2:428d:: with SMTP id m13mr8313355lfh.52.1566752084491;
 Sun, 25 Aug 2019 09:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <1566338811-4464-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHk-=wjFsF6zmcDaBdpYEvCWiq=x7_NuQWEm=OinZ9TuQd4ZZQ@mail.gmail.com>
 <20190823091636.GA10064@gmail.com> <CAHk-=wj=HcHWjrrNRmZ_hxEdBBrvUnPNFCw37EAu8_qJn71saQ@mail.gmail.com>
 <20190824161432.GA25950@gmail.com> <CAHk-=whFQNkqPJ5zA1xAyvgtCPLN2C4xeJ181rU3k6bG+2zugg@mail.gmail.com>
 <20190824202224.GA5286@gmail.com> <ab9ccf3c-6b87-652e-b305-41f2c2d1b2ae@i-love.sakura.ne.jp>
In-Reply-To: <ab9ccf3c-6b87-652e-b305-41f2c2d1b2ae@i-love.sakura.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Aug 2019 09:54:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgR=moYe2Jx8wobx9Vzxj55DGPwU9VEjZ+7gUrVYySMzQ@mail.gmail.com>
Message-ID: <CAHk-=wgR=moYe2Jx8wobx9Vzxj55DGPwU9VEjZ+7gUrVYySMzQ@mail.gmail.com>
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2019 at 10:50 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> @@ -142,7 +144,7 @@ static ssize_t read_mem(struct file *file, char __user *buf,
>                 sz = size_inside_page(p, count);
>                 cond_resched();
>                 err = -EINTR;
> -               if (fatal_signal_pending(current))
> +               if (signal_pending(current))
>                         goto failed;
>
>                 err = -EPERM;

So from a "likelihood of breaking" standpoint, I'd really like to make
sure that the "signal_pending()" checks come at the *end* of the loop.

That way, if somebody is doing a 4-byte read from MMIO, he'll never see -EINTR.

I'm specifically thinking of tools like user-space 'lspci' etc, which
I wouldn't be surprised could happen.

Also, just in case things break, I do agree with Ingo that this should
be split up into several patches.

             Linus
