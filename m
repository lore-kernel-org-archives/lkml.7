Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4BCC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2CD20674
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574701553;
	bh=Rch53xtBqI4lMn/D7GkCc3fpE/XXCB9ERM4kzHfJzJc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=I/cxFl6V9lt849r9Jxn87yAg2M0yQUdtVP7pVpIVmt0642NspLvyZ+Pk8uGKv3JHB
	 WIGF4uC8FmwOlv8Psux6I0T5zRfmpa31TV5XYQ/cr87l7XmI2vp51kJH8zYh6eD56v
	 tKVPs7BCme7pRgH4Ru8As04P/8oQd5VDTmLEEhTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfKYRFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 12:05:51 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38952 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbfKYRFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 12:05:50 -0500
Received: by mail-lj1-f194.google.com with SMTP id e10so7611222ljj.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 09:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IP1wfK3f8gL3K5of14NSdEE7VLJRLmDh9Mjfd6jLIUg=;
        b=di9eo39CEUbDhJQGDGRbvoBzSIsf4IsJ2vpQB30wyKTQ4oZuoI8I8FAMQktMgORFFP
         8fBVLWpCUhdrhl0hj+dykFizgaSzPbdXAW3q2epeOP6k+UZ1g4c/aPYroPhY+MX/X+vS
         wBXrAbq1U0ohLCJc7HXm2ySYQ4bv4evW0kCik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IP1wfK3f8gL3K5of14NSdEE7VLJRLmDh9Mjfd6jLIUg=;
        b=risU7y1eb1kfQUTJ76OeyuXzMGXZGOXrNQSu+gvt5VcUEUVFEs42oZyNrYC8BllSUT
         M0aEO0BIt8mgSFscbpUkUwg4GIWknXU416vqkZ91c0td1ZFgCOfWD2i1AeGdJFVTEHVm
         1brQBjyx6CxS9bQ+m/3kSjQmHkaV/5vZL7WGzi5asBP5Y8IXbIl6ofYViucDJkERwOtz
         wOzoGrFJDt52yT+06SbgYRsoQvWurVcRGTSn1vTroKZcMyWKVttQWKAwrM9XGzwpeR58
         h+i4FiYdMXDj3o1SxDMk522m7Waoip6cRb7Vp8/PSCO+StUZ+iHeEXk9FWDCnJElwPkN
         uROQ==
X-Gm-Message-State: APjAAAUXxgLlrQJ8ENOfkzi+i0ncRa6dl7uoWgUn1JK86UpUy/Fp0tVJ
        JM33yOm81D7WRSO9J09TWD468glPuT8=
X-Google-Smtp-Source: APXvYqzhI8NE5lnXhFgXeppFi8vxDUBh3UWrLvLlrdUyKoC43URJ9grXtIGEyCHBFkO7E1vJPRkvtQ==
X-Received: by 2002:a05:651c:326:: with SMTP id b6mr23031746ljp.119.1574701547666;
        Mon, 25 Nov 2019 09:05:47 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id u12sm4362194lje.1.2019.11.25.09.05.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 09:05:46 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id 203so11595584lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 09:05:45 -0800 (PST)
X-Received: by 2002:ac2:5a08:: with SMTP id q8mr21390671lfn.106.1574701545622;
 Mon, 25 Nov 2019 09:05:45 -0800 (PST)
MIME-Version: 1.0
References: <157225677483.3442.4227193290486305330.stgit@buzz>
 <20191028124222.ld6u3dhhujfqcn7w@box> <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
 <20191028125702.xdfbs7rqhm3wer5t@box> <ac83fee6-9bcd-8c66-3596-2c0fbe6bcf96@yandex-team.ru>
 <CAHk-=who0HS=NT8U7vFDT7er_CD7+ZreRJMxjYrRXs5G6dbpyw@mail.gmail.com>
 <f0140b13-cca2-af9e-eb4b-82eda134eb8f@redhat.com> <CAHk-=wh4SKRxKQf5LawRMSijtjRVQevaFioBK+tOZAVPt7ek0Q@mail.gmail.com>
 <640bbe51-706b-8d9f-4abc-5f184de6a701@redhat.com> <CAHpGcM+o2OwXdrj+A2_OqRg6YokfauFNiBJF-BQp0dJFvq_BrQ@mail.gmail.com>
 <22f04f02-86e4-b379-81c8-08c002a648f0@redhat.com>
In-Reply-To: <22f04f02-86e4-b379-81c8-08c002a648f0@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Nov 2019 09:05:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=whRuPkm7zFUiGe_BXkLvEdShZGngkb=uRufgU65ogCxfg@mail.gmail.com>
Message-ID: <CAHk-=whRuPkm7zFUiGe_BXkLvEdShZGngkb=uRufgU65ogCxfg@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <sfrench@samba.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 2:53 AM Steven Whitehouse <swhiteho@redhat.com> wrote:
>
> Linus, is that roughly what you were thinking of?

So the concept looks ok, but I don't really like the new flags as they
seem to be gfs2-specific rather than generic.

That said, I don't _gate_ them either, since they aren't in any
critical code sequence, and it's not like they do anything really odd.

I still think the whole gfs2 approach is broken. You're magically ok
with using stale data from the cache just because it's cached, even if
another client might have truncated the file or something.

So you're ok with saying "the file used to be X bytes in size, so
we'll just give you this data because we trust that the X is correct".

But you're not ok to say "oh, the file used to be X bytes in size, but
we don't want to give you a short read because it might not be correct
any more".

See the disconnect? You trust the size in one situation, but not in another one.

I also don't really see that you *need* the new flag at all. Since
you're doing to do a speculative read and then a real read anyway, and
since the only thing that you seem to care about is the file size
(because the *data* you will trust if it is cached), then why don't
you just use the *existing* generic read, and *IFF* you get a
truncated return value, then you go and double-check that the file
hasn't changed in size?

See what I'm saying? I think gfs2 is being very inconsistent in when
it trusts the file size, and I don't see that you even need the new
behavior that patch gives, because you might as well just use the
existing code (just move the i_size check earlier, and then teach gfs2
to double-check the "I didn't get as much as I expected" case).

                 Linus
