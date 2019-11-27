Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C73C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BEF2073F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yw5W/UMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfK0Q3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:29:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51940 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726909AbfK0Q3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 11:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574872190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rcyN5dGoMhhF+8wU9SDW3LRuwC7oWgcs+VV9XVwODaY=;
        b=Yw5W/UMqNqUmrbAFYputbQRJ7zaP481weijO0JcJ/Vp7E1rJYG9aqHuBFUD8e1KMof2w0b
        LEuuj1POtDd6ojKawlO9UBRMpFNxMzWZ0o9re2Yw8p9FdZIXMr2s7Tp8+zwgrk00clQJqh
        v9ufNFvboWhfzf2pbaK7eaUoJkGdwSY=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-mVhujEwSPeG9LurHXTTbiQ-1; Wed, 27 Nov 2019 11:29:48 -0500
Received: by mail-ot1-f71.google.com with SMTP id m7so12122325otr.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 08:29:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kIu1VyYGNbaIKqeZUoUtiDvput7821e7oFhQavConxk=;
        b=Otg/tie63r25BU5ZqGYHt5KqO0+4Z5S21AiBB2B3zKUDY43+OAvRA4E9t/CnWQI+Ee
         KIgJaxX0c6rHcD994vKw7sfcFlMDj/AwhI4Mrr79fF2JaMwBzGnpablh8el6YPxfoxR3
         /5e/nJPnvNx67QbyxVMn9Fr7ktx3HN8J9owTCNLSI0dmhm82JsPtGdgHPkqMxivt6pZr
         RQ2PjrwWoagp6FaO0pb0eisVUgX/AFok7WOVRvQzJQJRlcmLFgR2YaWru1s+DfUeAkGO
         ZlzjHJFP1StCi/3xj81cmTwLGBZaYJm/B91gp85nl4NaSbK3Qfnp0mht4BuYscHaHeOq
         lEkQ==
X-Gm-Message-State: APjAAAVjWI2a9LBcmwbm4uTqWzrijsg+/5gvtB3SuAhhurUCBrXj3uQ+
        bn5z3xM+WsUJCOF1YU1BW2CXnErxCYxSyf0CsJPW4MQUD3cofE+95Pv24pSA5Q3s0hPXEvbTp5E
        rwwj1YVLxftA2BuDCXSqKAgGIf4ByLe+syEMVzE9O
X-Received: by 2002:aca:d14:: with SMTP id 20mr4877848oin.178.1574872187662;
        Wed, 27 Nov 2019 08:29:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqw3yLKNT7wsw1AqyVf2knKKoyFNMFDOQF5O+7hYYWvVBZw57Km8zJVbATfvGULvCZMZmqbPRh8opF4b2Zj5pdE=
X-Received: by 2002:aca:d14:: with SMTP id 20mr4877821oin.178.1574872187328;
 Wed, 27 Nov 2019 08:29:47 -0800 (PST)
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
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 27 Nov 2019 17:29:36 +0100
Message-ID: <CAHc6FU4Mx_=qMYOBc0VYdn-paFXKVffq=k72LCJgTWONv9chng@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
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
        Bob Peterson <rpeterso@redhat.com>
X-MC-Unique: mVhujEwSPeG9LurHXTTbiQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 4:42 PM Steven Whitehouse <swhiteho@redhat.com> wro=
te:
> Hi,
>
> On 25/11/2019 17:05, Linus Torvalds wrote:
> > On Mon, Nov 25, 2019 at 2:53 AM Steven Whitehouse <swhiteho@redhat.com>=
 wrote:
> >> Linus, is that roughly what you were thinking of?
> > So the concept looks ok, but I don't really like the new flags as they
> > seem to be gfs2-specific rather than generic.
> >
> > That said, I don't _gate_ them either, since they aren't in any
> > critical code sequence, and it's not like they do anything really odd.
> >
> > I still think the whole gfs2 approach is broken. You're magically ok
> > with using stale data from the cache just because it's cached, even if
> > another client might have truncated the file or something.
>
> If another node tries to truncate the file, that will require an
> exclusive glock, and in turn that means the all the other nodes will
> have to drop their glock(s) shared or exclusive. That process
> invalidates the page cache on those nodes, such that any further
> requests on those nodes will find the cache empty and have to call into
> the filesystem.
>
> If a page is truncated on another node, then when the local node gives
> up its glock, after any copying (e.g. for read) has completed then the
> truncate will take place. The local node will then have to reread any
> data relating to new pages or return an error in case the next page to
> be read has vanished due to the truncate. It is a pretty small window,
> and the advantage is that in cases where the page is in cache, we can
> directly use the cached page without having to call into the filesystem
> at all. So it is page atomic in that sense.
>
> The overall aim here is to avoid taking (potentially slow) cluster locks
> when at all possible, yet at the same time deliver close to local fs
> semantics whenever we can. You can think of GFS2's glock concept (at
> least as far as the inodes we are discussing here) as providing a
> combination of (page) cache control and cluster (dlm) locking.
>
> >
> > So you're ok with saying "the file used to be X bytes in size, so
> > we'll just give you this data because we trust that the X is correct".
> >
> > But you're not ok to say "oh, the file used to be X bytes in size, but
> > we don't want to give you a short read because it might not be correct
> > any more".
> >
> > See the disconnect? You trust the size in one situation, but not in ano=
ther one.
>
> Well we are not trusting the size at all... the original algorithm
> worked entirely off "is this page in cache and uptodate?" and for
> exactly the reason that we know the size in the inode might be out of
> date, if we are not currently holding a glock in either shared or
> exclusive mode. We also know that if there is a page in cache and
> uptodate then we must be holding the glock too.
>
>
> >
> > I also don't really see that you *need* the new flag at all. Since
> > you're doing to do a speculative read and then a real read anyway, and
> > since the only thing that you seem to care about is the file size
> > (because the *data* you will trust if it is cached), then why don't
> > you just use the *existing* generic read, and *IFF* you get a
> > truncated return value, then you go and double-check that the file
> > hasn't changed in size?
> >
> > See what I'm saying? I think gfs2 is being very inconsistent in when
> > it trusts the file size, and I don't see that you even need the new
> > behavior that patch gives, because you might as well just use the
> > existing code (just move the i_size check earlier, and then teach gfs2
> > to double-check the "I didn't get as much as I expected" case).

We can identify short reads, but we won't get information about
readahead back from generic_file_read_iter or filemap_fault. We could
try to work around this with filesystem specific flags for ->readpage
and ->readpages, but that would break down with multiple concurrent
readers in addition to being a real mess. I'm currently out of better
ideas that avoid duplicating the generic code.

> >                   Linus
>
> I'll leave the finer details to Andreas here, since it is his patch, and
> hopefully we can figure out a good path forward. We are perhaps also a
> bit reluctant to go off and (nearly) duplicate code that is already in
> the core vfs library functions, since that often leads to things getting
> out of sync (our implementation of ->writepages is one case where that
> happened in the past) and missing important bug fixes/features in some
> cases. Hopefully though we can iterate on this a bit and come up with
> something which will resolve all the issues,
>
> Steve.

Thanks,
Andreas

