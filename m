Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD31C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1831220663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551734944;
	bh=aT4eV2iIIAuoEA7eLKFPqAktEkdmOCJ6ljfD4/mIZfo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Eei/7SHZktftSqTOkoAZYmp/jhpW9Ah+u6ZO7Eggy7XfVPkSFmv9fA3r02yKemi5V
	 1+dhXOQAh8R1ZEvZ0QiOVmzRGpb6JCVqgXWOfj3aI5XrvZQh00e6Hct+kMVd8zxFgC
	 gawt8vslDJydwkD5eoneCGPoLbOVu1+S1m0Nhpzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfCDV3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:29:02 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38000 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDV3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 16:29:02 -0500
Received: by mail-lf1-f66.google.com with SMTP id t2so1011lff.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 13:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6W8fi6x2xvp39dtPfH1Y2BnfJ9tl1gCu1Fj/ixxTE5A=;
        b=IN1XS9uV1bJQTaqLS10Lh2ZQ8Ke1Th56IoLNOTarMv2W/AsOQLRDHDcwlySvF5P8M1
         Cn0er1PauxDWjju6mm86pKfX4nZnehfKvnXZfdc/bbQ+NUiDB/s7hiJo/iHCgGWrXmJ5
         qZeAyAKDtexiCHoXzCiSUV/HkvMEQwHE5TFJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6W8fi6x2xvp39dtPfH1Y2BnfJ9tl1gCu1Fj/ixxTE5A=;
        b=IugtZnb7z1qLgkOaO0JjC0vkRhOqjRK7HfQSbp0aAOCGrLjxFy89XmDkMGC2u4OvnL
         ETDnCGdu3Yv1JNpPTGZ+Dd5YuKifpL9Oq/PPiQwl8uKKkpVm+4Ykn7n31JVuy2WlTyt+
         BtVba0Yg2RyeO7DcaZVou7ewcB88niI9Dt0ydlddXs25rRMAOd246vcZ0FxsSEOyYZ4O
         QL579pFh5KgC2ohhORrXYcAYX2BzI4v5JeXwrCgCdNGmOySZDpWc/g4WeUETmzVK7p/l
         qmJ02WREXZyse199gnaKn3lQXo13C02iWsJTj8eGwSv3JFBRJvaPGFScoSQDaZI4djxS
         R8xw==
X-Gm-Message-State: APjAAAVL2M0VZILud7rd72RIOW5VOlVIEv6GmiJxiQXjOQW5tIsdnNse
        ZID/OvTX7zM6JZs/XasKbNH3svxVUjw=
X-Google-Smtp-Source: APXvYqwFEqSqgO8ywr3Lpw3kXIEIdLJU4juZj8FhvOlOrTw8kh8xlK+gkgkFMtEUcYmZ0zMTpYMq3g==
X-Received: by 2002:ac2:4292:: with SMTP id m18mr448002lfh.60.1551734939513;
        Mon, 04 Mar 2019 13:28:59 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id m16sm1717221lfg.49.2019.03.04.13.28.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 13:28:59 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id v10so5650927lji.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 13:28:59 -0800 (PST)
X-Received: by 2002:a2e:8585:: with SMTP id b5mr11647885lji.125.1551734580418;
 Mon, 04 Mar 2019 13:23:00 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f39c7b05832e0219@google.com> <20190303135502.GP2217@ZenIV.linux.org.uk>
 <20190303151846.GQ2217@ZenIV.linux.org.uk> <CAHk-=wiQ2YNB+2FT+jbdcC6qfYqvS2kLLAZbmPE_7sLfUPwFJg@mail.gmail.com>
 <20190303203011.GR2217@ZenIV.linux.org.uk> <CAHk-=widuz9QBY-Xhpc1YHf=EV1uRGyOv-v-BNSa1zW-nCCC6Q@mail.gmail.com>
 <20190304023618.GS2217@ZenIV.linux.org.uk>
In-Reply-To: <20190304023618.GS2217@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Mar 2019 13:22:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wghRmdYKRAwakeHmjcpbLt9fJAHyU2x8s_NZONhz6RTOw@mail.gmail.com>
Message-ID: <CAHk-=wghRmdYKRAwakeHmjcpbLt9fJAHyU2x8s_NZONhz6RTOw@mail.gmail.com>
Subject: Re: [PATCH] aio: prevent the final fput() in the middle of vfs_poll()
 (Re: KASAN: use-after-free Read in unix_dgram_poll)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jason Baron <jbaron@akamai.com>, kgraul@linux.ibm.com,
        ktkhai@virtuozzo.com, kyeongdon.kim@lge.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 3, 2019 at 6:36 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> OK, having dug through the archives, the reasons were not strong.
> So that part is OK...

I've committed the patch.

However, I didn't actually do the separate and independent cleanups:


> > @@ -1060,6 +1071,8 @@ static inline void iocb_put(struct aio_kiocb *iocb)
> >  {
> >       if (refcount_read(&iocb->ki_refcnt) == 0 ||
> >           refcount_dec_and_test(&iocb->ki_refcnt)) {
> > +             if (iocb->ki_filp)
> > +                     fput(iocb->ki_filp);
> >               percpu_ref_put(&iocb->ki_ctx->reqs);
> >               kmem_cache_free(kiocb_cachep, iocb);
> >       }
>
> That reminds me - refcount_t here is rather ridiculous; what we
> have is
>         * everything other than aio_poll: ki_refcnt is 0 all along
>         * aio_poll: originally 0, then set to 2, then two iocb_put()
> are done (either both synchronous to aio_poll(), or one sync and one
> async).
>
> That's not a refcount at all.  It's a flag, set only for aio_poll ones.
> And that test in iocb_put() is "if flag is set, clear it and bugger off".
>
> What's worse, AFAICS the callers in aio_poll() are buggered (see below)

Ok. Suggestions?


> > -     if (unlikely(apt.error)) {
> > -             fput(req->file);
> > +     if (unlikely(apt.error))
> >               return apt.error;
> > -     }
> >
> >       if (mask)
> >               aio_poll_complete(aiocb, mask);
>
> Looking at that thing...  How does it manage to avoid leaks
> when we try to use it on e.g. /dev/tty, which has
>         poll_wait(file, &tty->read_wait, wait);
>         poll_wait(file, &tty->write_wait, wait);
> in n_tty_poll()?

I don't think that's he only case that uses multiple poll entries.
It's now the poll() machinery is designed to be used, after all.
Although maybe everybody ends up using just a single wait-queue..

> AFAICS, we'll succeed adding it to the first queue, then have
> aio_poll_queue_proc() fail and set apt.error to -EINVAL.

Yeah, that's bogus, but documented. I guess nobody really expects to
use aio_poll on anything but a socket or something?

But your refcount leak looks valid. Hmm.

So yes, that whole ki_refcnt looks a bit odd and pointless. And
apparently buggy too.

> Comments?

Can we just

 (a) remove ki_refcnt entirely

 (b) remove the "iocb_put(aiocb);"

from aio_poll()?

Every actual successful io submission should end in aio_complete(), or
we free the aio iocb in the "out_put_req" error case. There's no point
in doing the refcount as you pointed out, and it seems to be actively
buggy.

Anyway, all of this (and your suggestion to just remove
"aio_poll_complete()" and just use "aio_complete()") is independent of
the file refcounting part, I feel. Which is why I just committed that
patch as-is (84c4e1f89fef "aio: simplify - and fix - fget/fput for
io_submit()").

                   Linus
