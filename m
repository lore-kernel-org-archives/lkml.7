Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAA9C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF4F206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573664290;
	bh=GGY3G0+6mpa4tHVngh8c0Sn1vF+30kVZm15H32Wqrn0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ULcoN9f+ky+xG/Sv4zRM8qoPYYfCTLDDQBuTjlbb+HzbN0bXSMu/xqhh01hGSFYRv
	 0T5tEbFGlNuq5DIiKOMW5ne2CvBtHTMjZOyRBvORG0Vsr0sccV73Pvdwby/yAvlgVL
	 SsR542iQgQ8Gn5+kGllCZyKMxEydEjeUTM1KsWAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfKMQ6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:58:10 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:46847 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfKMQ6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:58:10 -0500
Received: by mail-lf1-f54.google.com with SMTP id o65so2516902lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 08:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZYEg/h4QSDcgUnlMwh4w5+X6tHq85c+NTIUoiTVyRk=;
        b=U7ravdDyiBjUVP8ErfMB91io1YhXvWHGVKa77PMeGvwn8vFpkMlRNnDUtYyuCdHy/V
         eXLqYfmp5YyTims+8tWu7mnnzxTheo9yQBk18/JI9FYSjBx2+5iIJS2FdZCXQkrg9sy+
         PAqMgVt9H/TKePAImEEkVIthOmiQ0+tOoY2sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZYEg/h4QSDcgUnlMwh4w5+X6tHq85c+NTIUoiTVyRk=;
        b=pakgHHV0v8neE5Lrdi4uadCmJWWTBv73LTKJ+J6Jzjl/YEodWEBLdhSOjutjT19AOa
         vTWZkFkHM4o8hTk4v2hUiJhtXlyklwEAC+84nyh3Wvs8s/+IZAAOCsDp0nvAxaNlFNpg
         u5U3hTyNUJEVYH4UdD9t3IxHO4ScIb/196UHb5Vzhv29GHQ5H0pcSrJt2Ka2MgDZ8w95
         rzHQP4ynnZjtWDgDtanxto3IWrtH4Uf+WoDRK4gcTVC6GY/7RRTGi2kQr2k+oTaMV6Nf
         mmwvmx+bHnrDeJM4rHVytdiLWPhj0qFWs8awtfLXnZosAwEeHd6HwvvQxpPSN5Dowcu0
         Olmw==
X-Gm-Message-State: APjAAAXc05jYiAsuHim/wsVsBLU8PQxY6ncyP754cF8VMAifaATcKhd0
        cqN+zjy7FaIf2mpkYM+0Yr92XIn5uGk=
X-Google-Smtp-Source: APXvYqwRt+JjYUVcmaPHvFF8ZC/0NtIeiNIyhCdideAFZLaRdCywZYcADdEnDPL559+CgEjwdCs6uA==
X-Received: by 2002:ac2:5236:: with SMTP id i22mr3479770lfl.19.1573664287433;
        Wed, 13 Nov 2019 08:58:07 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id z19sm1153773ljk.66.2019.11.13.08.58.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 08:58:06 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id r7so3411753ljg.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 08:58:05 -0800 (PST)
X-Received: by 2002:a2e:8919:: with SMTP id d25mr3368745lji.97.1573664285540;
 Wed, 13 Nov 2019 08:58:05 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgnjMEvqHnu_iJcbr_kdFyBQLhYojwv5T7p9F+CHxA9pg@mail.gmail.com>
 <Pine.LNX.4.44L0.1911121639540.1567-100000@iolanthe.rowland.org>
 <CANn89iKjWH86kChzPiVtCgVpt3GookwGk2x1YCTMeBSPpKU+Ww@mail.gmail.com>
 <20191112224441.2kxmt727qy4l4ncb@ast-mbp.dhcp.thefacebook.com>
 <CANn89iKLy-5rnGmVt-nzf6as4MvXgZzSH+BSReXZKpSTjhoWAw@mail.gmail.com>
 <CAHk-=wj_rFOPF9Sw_-h-6J93tP9qO_UOEvd-e02z9+DEDs2kLQ@mail.gmail.com> <CANpmjNNkbWoqckyPfhq52W4WfJWR2=rt8WXzs+WXEZzv9xxL0g@mail.gmail.com>
In-Reply-To: <CANpmjNNkbWoqckyPfhq52W4WfJWR2=rt8WXzs+WXEZzv9xxL0g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Nov 2019 08:57:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg5CkOEF8DTez1Qu0XTEFw_oHhxN98bDnFqbY7HL5AB2g@mail.gmail.com>
Message-ID: <CAHk-=wg5CkOEF8DTez1Qu0XTEFw_oHhxN98bDnFqbY7HL5AB2g@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Marco Elver <elver@google.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 7:00 AM Marco Elver <elver@google.com> wrote:
>
> Just to summarize the options we've had so far:
> 1. Add a comment, and let the tool parse it somehow.
> 2. Add attribute to variables.
> 3. Add some new macro to use with expressions, which doesn't do
> anything if the tool is disabled. E.g. "racy__(counter++)",
> "lossy__(counter++);" or any suitable name.

I guess I could live with "data_race(x)" or something simple like
that, assuming we really can just surround a whole expression with it,
and we don't have to make a hundred different versions for the
different cases ("racy plain assignment" vs "racy statistics update"
vs "racy u64 addition" etc etc).

I just want the source code to be very legible, which is one of the
problems with the ugly READ_ONCE() conversions.

Part of that "legible source code" implies no crazy double
underscores. But a plain "data_race(x)" might not look too bad, and
would be easy to grep for, and doesn't seem to exist in the current
kernel as anything else.

One question is if it would be a statement expression or an actual
expression. I think the expression would read much better, IOW you
could do

    val = data_race(p->field);

instead of having to write it as

    data_race(val = p->field);

to really point out the race. But at the same time, maybe you need to
surround several statements, ie

    // intentionally racy xchg because we don't care and it generates
better code
    data_race(a = p->field; p->field = b);

which all would work fine with a non-instrumented macro something like this:

    #define data_race(x) ({ x; })

which would hopefully give the proper syntax rules.

But that might be very very inconvenient for KCSAN, depending on how
you annotate the thing.

So I _suspect_ that what you actually want is to do it as a statement,
not as an expression. What's the actual underlying syntax for "ignore
this code for thread safety checking"?

                    Linus
