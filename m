Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D14C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86B9206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574875808;
	bh=KDeaSb4KUVFt973I+oMURqTaRIRD08y8+RVEMC6PoCA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=y0P0dgLnCsmjPMx2OFE5RW3B6BjWoo/VVT5ctxdCSCZnDBDz770JLPh6YrBGniqQY
	 xDIuueVywOqfRK7XJgOmjFxAKx+87+1aeYAhOdCDQsGtLCHQ+2JgQ8ArQ6HIPvQvEZ
	 +uJ2+vHQFIf74/d1w+etU3awfn1NuCXuwNpUJEGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfK0RaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:30:07 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32778 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfK0RaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:30:07 -0500
Received: by mail-lj1-f193.google.com with SMTP id t5so25408637ljk.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 09:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OHYvN6viznScLuFMhHh+plwLnzseinfGUfKYa/O5B9E=;
        b=d/o6EltX2tOPVh+pCIPqROyyLmufd3KKhy4ZzU5rMuRlVV5+ZhuGOopgQYX4213Ruf
         3geslrmCVOTUtkpnd80sPLQIxoMXA66iMjoQwR0w+MhfrWHNS9BTxZtIJ4r9oDphfitZ
         kSpLWposwiLF5+WA/vvyqLaAjNYels5rKVBPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OHYvN6viznScLuFMhHh+plwLnzseinfGUfKYa/O5B9E=;
        b=ddYUcA57aful/IMisC6wt5qTnMgM2FoFk36pLBpqU9w+TBQE7R0g2eBfZn7qOWdbPS
         a9m5Xx2gCj4hLeF1asEpN+f3c4zski7DDAlbZEXVRME3qQu9dMOOH8koy9RFQTGTdKxO
         3RPmJ34zBnE4J8toW91Fi4aA9YwCWxkBXw9vqUDQqGj7SIuSI5sWDr4Gb8ZiwCgLcy+w
         AnwZdgLwjmn//uk0MXuiytDqSN0pj6Ku5toxlmclC5kebwzg2ZVH2ngnq42+TnVm+zJM
         TFThJkKx9e91TkC4YxZp0IaX3iCxbpSkiMPzDC3V8LOpvrBWxnE2JLd2DPXJ8gknxSRZ
         GnuA==
X-Gm-Message-State: APjAAAVSFJHZaWnaTgzu7DCx5ns94pJl1Rg8K4by9g96GAUtqQ+lGQTv
        nRByC2QnPJDN43/9+XL6s1LcvrV8Hno=
X-Google-Smtp-Source: APXvYqxkcZ7s1cIHW4VJfm5LUXuToKQ53VMdXTwUv1uwqmXzWX8uArWVaXscGM7B/FOwmaGozdRwoQ==
X-Received: by 2002:a05:651c:c4:: with SMTP id 4mr2668896ljr.171.1574875804590;
        Wed, 27 Nov 2019 09:30:04 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id d17sm8504602lja.27.2019.11.27.09.30.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 09:30:01 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id n21so25342521ljg.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 09:30:01 -0800 (PST)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr17881292ljj.97.1574875800695;
 Wed, 27 Nov 2019 09:30:00 -0800 (PST)
MIME-Version: 1.0
References: <157225677483.3442.4227193290486305330.stgit@buzz>
 <20191028124222.ld6u3dhhujfqcn7w@box> <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
 <20191028125702.xdfbs7rqhm3wer5t@box> <ac83fee6-9bcd-8c66-3596-2c0fbe6bcf96@yandex-team.ru>
 <CAHk-=who0HS=NT8U7vFDT7er_CD7+ZreRJMxjYrRXs5G6dbpyw@mail.gmail.com>
 <f0140b13-cca2-af9e-eb4b-82eda134eb8f@redhat.com> <CAHk-=wh4SKRxKQf5LawRMSijtjRVQevaFioBK+tOZAVPt7ek0Q@mail.gmail.com>
 <640bbe51-706b-8d9f-4abc-5f184de6a701@redhat.com> <CAHpGcM+o2OwXdrj+A2_OqRg6YokfauFNiBJF-BQp0dJFvq_BrQ@mail.gmail.com>
 <22f04f02-86e4-b379-81c8-08c002a648f0@redhat.com> <CAHk-=whRuPkm7zFUiGe_BXkLvEdShZGngkb=uRufgU65ogCxfg@mail.gmail.com>
 <cdd48a4d-42a4-dd15-2701-e08e26fef17f@redhat.com>
In-Reply-To: <cdd48a4d-42a4-dd15-2701-e08e26fef17f@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Nov 2019 09:29:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh5yeAj47x5EAuec7NCgFyYV1VtB9A+nBq+bVP9HmeepQ@mail.gmail.com>
Message-ID: <CAHk-=wh5yeAj47x5EAuec7NCgFyYV1VtB9A+nBq+bVP9HmeepQ@mail.gmail.com>
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

On Wed, Nov 27, 2019 at 7:42 AM Steven Whitehouse <swhiteho@redhat.com> wrote:
>
> I'll leave the finer details to Andreas here, since it is his patch, and
> hopefully we can figure out a good path forward.

As mentioned, I don't _hate_ that patch (ok, I seem to have typoed it
and said that I don't "gate" it ;), so if that's what you guys really
want to do, I'm ok with it. But..

I do think you already get the data with the current case, from the
"short read" thing. So just changing the current generic read function
to check against the size first:

  --- a/mm/filemap.c
  +++ b/mm/filemap.c
  @@ -2021,9 +2021,9 @@ static ssize_t
generic_file_buffered_read(struct kiocb *iocb,
        unsigned int prev_offset;
        int error = 0;

  -     if (unlikely(*ppos >= inode->i_sb->s_maxbytes))
  +     if (unlikely(*ppos >= inode->i_size))
                return 0;
  -     iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
  +     iov_iter_truncate(iter, inode->i_size);

        index = *ppos >> PAGE_SHIFT;
        prev_index = ra->prev_pos >> PAGE_SHIFT;

and you're done. Nice and clean.

Then in gfs2 you just notice the short read, and check at that point.
Sure, you'll also cut read-ahead to the old size boundary, but does
anybody _seriously_ believe that read-ahead matters when you hit the
"some other node write more data, we're reading past the old end"
case? I don't think that's the case.

But I _can_ live with the patch that adds the extra "cached only" bit.
It just honestly feels pointless.

               Linus
