Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7672C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E2D2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573238455;
	bh=DV9Qe4nXXIWFVcx17wXeja01w4d5CbFbfNPKSF3fpmE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=W/oDQG8MyxI/DJYQkEoaLluHnOyQBL7xia1RyEGREm+knSYJwwf2/l0Tg5jGwgx0l
	 KpneGV2yUevy4o1xKx+TBTRQ0Aci4FeJfqh3FHnOU0AsreH7vNkfZC0Rkcxj4DqLNp
	 ayQdCZdcuwtBJKGPB3yVCX3J6Inq+wgf/zmBQTxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbfKHSky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:40:54 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46226 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfKHSkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:40:53 -0500
Received: by mail-lf1-f68.google.com with SMTP id o65so1529613lff.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 10:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nK0Zw7DLkFj9Fi972X4waBUlozfHM/3V2eGjeSiAYSA=;
        b=NHeFmexs7Yz1xxa1LiwHuBGwXB+UPoBzyW8Ms19u2B7AJ+X1/cPn7PIRLnUcjY65zc
         I1BM+BlXfL0H3tx4/zcFNIsihVYs0aG27mlRkRGJ6/azjW5Y6ie2SRZYkeLY9kmCSSKE
         r/TQA/vggkYBJM0F9kfKGYF9kggQPVl/LeW+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nK0Zw7DLkFj9Fi972X4waBUlozfHM/3V2eGjeSiAYSA=;
        b=QUy6/eaLdJFyPSYdaXH8N+ZBb8yH5HiTR6Vd87cXiAZUnDTo9G6nN+ZOByEXY+7WXk
         iIx5JvvDnY8TDtlx4iyPxgOQx25nXgbHknZDU40o08kuTYvRQQ/eMqTlVPvc+zVlKFbh
         6VRjTNHTnQXoTdicAWidOyL7HfkI8vIdODpEBc1vK2aVIVCXK1MSDgFnl6VeHTTrA+eV
         G8O8Of5VdCBy/BIs3uJ9AwmDl4ORZIiR0TtrUe53aWLwcymk3ixCb/BjT6A+WTsgw3TK
         HBzI4xHbkOU2krYiPusfFMFYy/nQkflKXhEH6Zy4Vul5IpGjKG84bd82JEbGSY3H8/Tn
         PldQ==
X-Gm-Message-State: APjAAAV9WXAE444JgF2AAl4tf7Olgi2PsSHkd6ajB8SrCIhtOayKrWWI
        mCMn/YdopchmiTbpxMhRUtmzhntGsdo=
X-Google-Smtp-Source: APXvYqxB53eqyfJQyu6smeJ5NzpY3Frmi72I8FchDiJgAZpvT93KMt3CrnZqiarQv/kH1uFZXmfLEQ==
X-Received: by 2002:ac2:51dd:: with SMTP id u29mr7715343lfm.135.1573238451671;
        Fri, 08 Nov 2019 10:40:51 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id r9sm3517856ljm.7.2019.11.08.10.40.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 10:40:48 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id e9so7219265ljp.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 10:40:48 -0800 (PST)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr7922518ljp.133.1573238447956;
 Fri, 08 Nov 2019 10:40:47 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
 <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
 <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com>
 <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com>
 <CAHk-=wiZdSoweA-W_8iwLy6KLsd-DaZM0gN9_+f-aT4KL64U0g@mail.gmail.com> <CANpmjNOuRp0gdekQeodXm8O_yiXm7mA8WZsXZNmFfJYMs93x8w@mail.gmail.com>
In-Reply-To: <CANpmjNOuRp0gdekQeodXm8O_yiXm7mA8WZsXZNmFfJYMs93x8w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Nov 2019 10:40:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjodfXqd9=iW=ziFrfY7xqopgO3Ko_HrAUp-kUQHHyyqg@mail.gmail.com>
Message-ID: <CAHk-=wjodfXqd9=iW=ziFrfY7xqopgO3Ko_HrAUp-kUQHHyyqg@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Marco Elver <elver@google.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 10:16 AM Marco Elver <elver@google.com> wrote:
>
> KCSAN does not use volatile to distinguish accesses. Right now
> READ_ONCE, WRITE_ONCE, atomic bitops, atomic_t (+ some arch specific
> primitives) are treated as marked atomic operations.

Ok, so we'd have to do this in terms of ATOMIC_WRITE().

One alternative might be KCSAN enhancement, where you notice the
following pattern:

 - a field is initialized before the data structure gets exposed (I
presume KCSAN already must understand about this issue -
initializations are different and not atomic)

 - while the field is live, there are operations that write the same
(let's call it "idempotent") value to the field under certain
circumstances

 - at release time, after all the reference counts are gone, the field
is read for whether that situation happened. I'm assuming KCSAN
already understands about this case too?

So it would only be the "idempotent writes" thing that would be
something KCSAN would have to realize do not involve a race - because
it simply doesn't matter if two writes of the same value race against
each other.

But I guess we could also just do

   #define WRITE_IDEMPOTENT(x,y) WRITE_ONCE(x,y)

and use that in the kernel to annotate these things. And if we have
that kind of annotation, we could then possibly change it to

  #define WRITE_IDEMPOTENT(x,y) \
       if READ_ONCE(x)!=y WRITE_ONCE(x,y)

if we have numbers that that actually helps (that macro written to be
intentionally invalid C - it obviously needs statement protection and
protection against evaluating the arguments multiple times etc).

                Linus
