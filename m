Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55F8C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 17:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC1E2054F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 17:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556474369;
	bh=JNUjRdh880vN7p/G1PgxVQ6Y4hHPeo8k4TC+EN1AVSU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O955MPiiB0hXz1MzQnqe0JYgaPPXpIaEucU0hPfVR+fin289D6FU1t5eZ3ssFQKge
	 QMOQCKO13kThZ9auVFci726qlNkCSqyVhXk5aEXBwgJUHeE8lFfXAURVDgf61zB/Ou
	 A9AHw/dn6bprtv+sV/BJyM61R6gPuoC2gvhdXWVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfD1R72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 13:59:28 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:34996 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfD1R71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 13:59:27 -0400
Received: by mail-lj1-f180.google.com with SMTP id z26so7327944ljj.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 10:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N4e0yPH0Vgnf1AYEoix3pVha6totByaAuqubrLlTrYo=;
        b=CxCo+64mtOlFPXZ6njuM9Nw/uILb41oA0aj0ZF5IX4XwOfE0l6S/MdlJnUjWD9FrYz
         oGk4osW2Qv2m/NsQ05JBrthfsd5+T11tG62SdQFHSs8ORkFtKFbN5b54Bt+u8yqZywQ4
         H61gtF3uK3ZuSYEIw/VzZ9ArJmTj1wmuhh+LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N4e0yPH0Vgnf1AYEoix3pVha6totByaAuqubrLlTrYo=;
        b=taiJUKIgO6LKBbY9aK5XGXATuLIGR4ZtajxjBWelRoDijKTHHETvV3k10d27246k6R
         Nxo+bZbjyU94IinIYKWrmSHyULjyp+96BZbP7S1lqnqZGIzzUmEXI/HQrGXAZIf2iQn6
         b/11wjWBSvR/fSk+IcanydjORXVKyeYtFSOVTNZux6uNPTVvk2C7QpEFCE8u0tFALOTZ
         Kgz+ifoi7y2XKeXCot/Ai36ErjN9OsSJOD1l8Z3UGU3F/uTRv9brbZanPB4ircxmXXxe
         3/njFfQ4WZa6ToQ9ivUGQR8/4lTaHgbLMhlm0xGJAFJ4cjMGRddH0NxycSZFU8bjm8lt
         UwlQ==
X-Gm-Message-State: APjAAAUgRf9SmUdnS0vsZ2jGF/34iQLp4BV6BnTb06ow8B/rna4oenNP
        VOHPo8cq+4s3KSqyHllGVSkMTYuKNS4=
X-Google-Smtp-Source: APXvYqzyakl6/88dAy9sT5DJAYxYCceYQCySX9GHoOizcpuhwU7v8AUFM5hYYxpJ8l65h3fXFUhu3Q==
X-Received: by 2002:a2e:968c:: with SMTP id q12mr18696499lji.36.1556474364871;
        Sun, 28 Apr 2019 10:59:24 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id h29sm2467540ljb.49.2019.04.28.10.59.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 10:59:23 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id h21so7258687ljk.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 10:59:22 -0700 (PDT)
X-Received: by 2002:a2e:5dd2:: with SMTP id v79mr31231427lje.22.1556474362610;
 Sun, 28 Apr 2019 10:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190428155755.14267-1-longman@redhat.com> <20190428155755.14267-2-longman@redhat.com>
 <CAHk-=wgCrtM7fPd=qmmg6UUDRcw9iq7a7_ypOHH3740xgv6wkQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgCrtM7fPd=qmmg6UUDRcw9iq7a7_ypOHH3740xgv6wkQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Apr 2019 10:59:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgGN9KKCW8dii=nXwKQdu2N5AOMrVdS5qJvZAPOTvwHjA@mail.gmail.com>
Message-ID: <CAHk-=wgGN9KKCW8dii=nXwKQdu2N5AOMrVdS5qJvZAPOTvwHjA@mail.gmail.com>
Subject: Re: [PATCH-tip v6 01/20] locking/rwsem: Prevent decrement of reader
 count before increment
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 10:41 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It's the *first* loop that you could play games with, because you hold
> the lock, and the list is stable during that loop. So the *first* loop
> could just walk the list, and then do one list splitting operation
> instead of doing that "list_move_tail()" thing for each entry.

.. having looked at that, I would suggest against it.

I _think_ this short and sweet code snippet might just work fine for
the first loop:

        list_for_each_entry(waiter, &sem->wait_list, list) {
                if (waiter->type == RWSEM_WAITING_FOR_WRITE)
                        break;
                woken++;
        }
        list_cut_before(&wlist, &sem->wait_list, waiter);

and if it *does* work it would be both smaller and more efficient. But
it looks a bit too subtle to my taste. Somebody would need to go
through that with a fine comb, and double-check that it gets the
"whole list" case right, for example.

So the "phase 1" loop could be perhaps simplified to the above cute things.

But the "phase 2" loop absolutely has to be changed to use
list_for_each_entry_safe().

               Linus
