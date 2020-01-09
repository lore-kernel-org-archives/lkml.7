Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805BCC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 23:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54BCF2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 23:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578612996;
	bh=DnL8Ly/LygZ6d0AbvckQYojNF/EYaPqPBuw/KO5HXrU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=C+XQVJNXPihVM1E344mAjLcklT/wv2M7EGl9LpQx+XzTRfcW+oDC7MQjeINwyic4g
	 U74j7lfQ82e15xHf/7nS1vqYMw9GCvC44x2NgRaLsJP97zLan4iZQwNAtK2pvIHzTR
	 iOIcuH2rzHBJXQEoOjYg+C7W/ZiQ92w1zwyIqmxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgAIXgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 18:36:35 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34706 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgAIXgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 18:36:35 -0500
Received: by mail-lj1-f193.google.com with SMTP id z22so182853ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 15:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7cxh9JzYgfLEYpSRugGbgPEiMf2GtUPcs7IzFV2N1Vs=;
        b=C37Juki7Lamw1te5hiIssO4V+b4sUkmGmgc8ZoZ+oIv356CJDBJW6RrqpbhIjSLj2B
         926UXuFD8HK4wO3/kam3YHqxYdPl4dXd38h8UJY/UU6X3LVjIQJEiUmq1FB1t6LtIXHS
         PEgjFnPwrA+8KZsQa2xyfmrYzvTotqkwqCb0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7cxh9JzYgfLEYpSRugGbgPEiMf2GtUPcs7IzFV2N1Vs=;
        b=CcJ0T2I/EZ0Z9wbAp7HkIT2vwyIkmLvJ16OSL+r9qdLNkfgt8hqnob61DdsG9nHG7M
         Qh/qaEvrKcH68xOB2uHciQLCBdBOtGqVbRqi3YzD3rIMc+2eVTMA8xwhD2MGvSj9kxRU
         Z52vT8L40FiK9YdFqIeLpLsMG76yA3juEz9T48hV2cRubkXp/mRIfhT5rO0Tbeupo5kJ
         81VwMVmGsZvFdiM/ZMztlfvxmgglVkOzLkhAPg9oL/PYxiJrGt6Ow4Ux6C6nr+OL3kor
         2VqPvnwU1GzetOxJgGjyJZG+PEaeVgxeDtCWl95zfqV1JiomownaMWIbbK26Ar2Tfwkr
         dweA==
X-Gm-Message-State: APjAAAXZ+AfLk8/DlHwqeXEtYJREQ8SWwaRG32QVzHh2m+h0ZTYapIt2
        vPU4CdKlu7gVbwXasL3tvqoEfiTroN4=
X-Google-Smtp-Source: APXvYqy3+FZovVXEMGW9czgYseKJJ1pI362pm4W3XxMSbrfjalZ0/wJdnLGLvn8vOvxm8ucQgv6l0w==
X-Received: by 2002:a2e:a408:: with SMTP id p8mr331630ljn.145.1578612992283;
        Thu, 09 Jan 2020 15:36:32 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id y10sm53335ljm.93.2020.01.09.15.36.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 15:36:30 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id n25so88230lfl.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 15:36:30 -0800 (PST)
X-Received: by 2002:a05:6512:1dd:: with SMTP id f29mr196452lfp.106.1578612989927;
 Thu, 09 Jan 2020 15:36:29 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2001091519080.31058@cbobk.fhfr.pm>
 <CAHk-=wj+zyWsZGhiCiopkrnu1_bkNE1Ax+82sP4Donsv9pUZuw@mail.gmail.com>
 <nycvar.YFH.7.76.2001092032430.31058@cbobk.fhfr.pm> <nycvar.YFH.7.76.2001092137460.31058@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2001092137460.31058@cbobk.fhfr.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jan 2020 15:36:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh_-q=MPtYmcb4gUHtQ2M96BVrzoDo3pauU-Ps9Q5uPtg@mail.gmail.com>
Message-ID: <CAHk-=wh_-q=MPtYmcb4gUHtQ2M96BVrzoDo3pauU-Ps9Q5uPtg@mail.gmail.com>
Subject: Re: [GIT PULL] HID fixes
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 12:38 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> From: Jiri Kosina <jkosina@suse.cz>
> Subject: [PATCH] HID: hidraw, uhid: Always report EPOLLOUT

This looks fine, and certainly fixes the immediate problem.

However, this part could still be maybe be improved on:

>  static __poll_t hidraw_poll(struct file *file, poll_table *wait)
>  {
>         struct hidraw_list *list = file->private_data;
> +       __poll_t mask = EPOLLOUT | EPOLLWRNORM; /* hidraw is always writable */
>
>         poll_wait(file, &list->hidraw->wait, wait);
>         if (list->head != list->tail)
> -               return EPOLLIN | EPOLLRDNORM;
> +               mask |= EPOLLIN | EPOLLRDNORM;
>         if (!list->hidraw->exist)
>                 return EPOLLERR | EPOLLHUP;
> -       return EPOLLOUT | EPOLLWRNORM;
> +       return mask;
>  }

Notice the error condition.

I didn't actually _check_ what happens for errors, but *usually* error
conditions mean that

 (a) if there is data to be read, that is done before the error anyway

 (b) that even if there isn't data, the thing is "readable" and
"writable" in the sense that the op will return immediately (with an
error)

 (c) and most importantly - people may not be actually waiting for
EPOLLERR / EPOLLHUP at all.

Now, for "select()" we actually always turn EPOLLERR into "it's
readable _and_ writable". So if a user program uses "select()" to poll
for something, it will see it as being ready for IO in the error
condition.

But if somebody actually uses poll(), and asks for "let me know when
it is either readable or writable", look at what  happens above if
there is a pending error.

You'll basically tell the user that it's neither readable nor
writable, even if you otherwise would have set "EPOLLIN" in the mask.

So at a minimum, please do

          if (!list->hidraw->exist)
                  mask |= EPOLLERR | EPOLLHUP;

but quite possibly it may be a good idea to consider error conditions
to also mean EPOLLIN | EPOLLOUT, since _presumably_ that error will
also cause read/write to return immediately.

But again, I didn't actually verify that last part.

The exact semantics of EPOLLERR and EPOLLHUP really aren't 100% clear.
Should they set EPOLLIN and EPOLLOUT too - there may not be any data,
but at least a read or write won't block? Maybe? So that last
suggestion is questionable, but doing the "mask |=" part really is
unquestionably a better idea, since at least you don't want an error
to _hide_ existing data that is readable.

Now, good source code presumably notices EPOLLERR and handles it. So
it _shouldn't_ matter what the kernel does if an error occurs. I
haven't checked what people _actually_ do, tnough. I worry sometimes
that user space just looks at EPOLLIN sees it not being set, and gets
stuck in a busy loop polling in case of errors.

And since errors presumably don't actually happen much in real life,
it might not get a lot of coverage.

                 Linus
