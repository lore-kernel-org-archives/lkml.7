Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2246C282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5B32084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4Ael67D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfDISCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:02:07 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45562 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDISCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 14:02:07 -0400
Received: by mail-yw1-f67.google.com with SMTP id j128so6558594ywg.12;
        Tue, 09 Apr 2019 11:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CetC4bPL89t4b8HHpCZEhndKXiMXUJJAyMa3lofK2og=;
        b=U4Ael67DCdshqmVuxf5Tk1yywoIMq4+TYM7p79sLFMiIJQAxWwgpHEjwqLpznIwiqi
         FRgp++o/beWE2BZUH3UAUuERqsiJkyj9V0XzJ+0XHCCZ/vKUTEhGbFEVCssTnyyWc2zP
         5ox7fzhiv9m4bKJOa5C9C5rDmdnPaGyyAjNc9phru+yJe4S4/MMQwbC7jvSObIHCWMbC
         oB1lFi3o+PjJXSpzZbuayurHcwlIqQbKDSNd2FKOTXNnAhMdAUJPsDM8SD6B6TWCNwpE
         wde5YtwS0bEapvb5xKxrQyoj3hm/A284hD5kTnISfY8bhNXMfjtIdVsIuNYY84bjMC8w
         2EHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CetC4bPL89t4b8HHpCZEhndKXiMXUJJAyMa3lofK2og=;
        b=eYsZ1Mf+ys+i1RGMwIhmTdy5dzMwTFuL2utHNP0o7bx8ERr/ncx37gSDO6YKhISK6a
         D5PPoJ6OPvCKXxtZmz4F1uUp2s8nTQ3DX+ZstFjGm0NpBKCw2r6KHjnrC7UDPl+fotMZ
         OJ+RpD0VUIG5u5heCeS0HFAUmTYuEbdEbEs75scTaczduXIIMOGGII3r0WGkRj4bktXL
         eLFRFiRQf9sZ06KDQeqSTWKWPGoTwwAVdXi/O9rkNboDNw3iUMozlRlxh47t75bS3fc0
         lefw3ybk8cIuiOwdCmCaUl9Edr4jWl/a3HEyn4BfYz8eV/6iA9y4FBQrH26AI/k/XmFZ
         giJg==
X-Gm-Message-State: APjAAAWCdIDlALOn5tlgNt31Ep6xDJ741E+QpnUbF+xRoasB/gxwfsxZ
        vXYd1lRwH0v5Aa/YsjCqgvW/hJKZfYLIaVmERog=
X-Google-Smtp-Source: APXvYqzHQITTr12IJiNgIcgkeoNb7NoHye39GS6SQqimiaP8wf9ImwXJjEOzjVwnHvGRm2jIjXNc0WvNmnHiw3Ie8gk=
X-Received: by 2002:a81:2f88:: with SMTP id v130mr30029453ywv.7.1554832925501;
 Tue, 09 Apr 2019 11:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190409114922.30095-1-amir73il@gmail.com> <20190409154303.GB1426@quack2.suse.cz>
In-Reply-To: <20190409154303.GB1426@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 9 Apr 2019 21:01:54 +0300
Message-ID: <CAOQ4uxi7X_Ge14Ek_BR=es8mLYbkM3vMOJE5+_Doon1OD5p0yA@mail.gmail.com>
Subject: Re: [PATCH] fs/sync.c: sync_file_range(2) may use WB_SYNC_ALL writeback
To:     Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 6:43 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 09-04-19 14:49:22, Amir Goldstein wrote:
> > Commit 23d0127096cb ("fs/sync.c: make sync_file_range(2) use WB_SYNC_NONE
> > writeback") claims that sync_file_range(2) syscall was "created for
> > userspace to be able to issue background writeout and so waiting for
> > in-flight IO is undesirable there" and changes the writeback (back) to
> > WB_SYNC_NONE.
> >
> > This claim is only partially true. Is is true for users that use the flag
> > SYNC_FILE_RANGE_WRITE by itself, as does PostgreSQL, the user that was
> > the reason for changing to WB_SYNC_NONE writeback.
> >
> > However, that claim is not true for users that use that flag combination
> > SYNC_FILE_RANGE_{WAIT_BEFORE|WRITE|_WAIT_AFTER}.  Those users explicitly
> > requested to wait for in-flight IO as well as to writeback of dirty
> > pages.  sync_file_range(2) man page describes this flag combintaion as
> > "write-for-data-integrity operation", although some may argue against
> > this definition.
> >
> > Re-brand that flag combination as SYNC_FILE_RANGE_WRITE_AND_WAIT and use
> > the helper filemap_write_and_wait_range(), that uses WB_SYNC_ALL
> > writeback, to perform the range sync request.
> >
> > One intended use case for this API is creating a dependency between
> > a new file's content and its link into the namepsace without requiring
> > journal commit and flushing of disk volatile caches:
> >
> >   fd = open(".", O_TMPFILE | O_RDWR);
> >   write(fd, newdata, count);
> >   sync_file_range(fd, SYNC_FILE_RANGE_WRITE_AND_WAIT, 0, 0);
> >   linkat(AT_EMPTY_PATH, fd, AT_FDCWD, newfile);
> >
> > For many local filesystems, ext4 and xfs included, the sequence above
> > will guaranty that after crash, either 'newfile' exists with 'newdata'
> > content or 'newfile' does not exists.  For some applications, this
> > guaranty is strong enough and the effects of sync_file_range(2), even
> > with WB_SYNC_ALL, are far less intrusive to other writers in the system
> > than the effects of fdatasync(2).
>
> I agree that this paragraph is true but I don't want any userspace program
> rely on this. We've been through this when ext3 got converted to ext4 and
> it has caused a lot of complaints. Ext3 had provided rather strong data vs
> metadata ordering due to the way journalling was implemented. Then ext4
> came, implemented delayed allocation and somewhat changed how journalling
> works and suddently userspace programmers were caught by surprise their code
> working by luck stopped working. And they were complaining that when their
> code worked without fsync(2) before, it should work after it as well. So it
> took a lot of explaining that their applications are broken and Ted has
> also implemented some workarounds to make at least the most common mistakes
> silently fixed by the kernel most of the time.
>
> So I'm against providing 90% data integrity guarantees because there'll be
> many people who'll think they can get away with it and then complain when
> they won't once our implementation changes.
>
> Rather I'd modify the manpage to not say that SYNC_FILE_RANGE_WAIT_BEFORE
> | SYNC_FILE_RANGE_WRITE | SYNC_FILE_RANGE_WAIT_AFTER is a
> write-for-data-integrity.

OK. I do agree that manpage is misleading and that the language describing
this flag combination should be toned down. I do not object to adding more
and more disclaimers about this API not being a data integrity API.

But the requirement I have is a real life workload and fdatasync(2) is not at
all a viable option when application is creating many files per second.

I need to export the functionality of data writeback to userspace.
Objecting to expose this functionality via the interface that has been
documented to expose it for years and used to expose it in the
past (until the Fixes commit) is a bit weird IMO, even though I do
completely relate to your concern.

I don't mind removing the "intended use case" part of commit message
if that helps reducing the chance that people misunderstand
the guaranties of the API.

Another thing I could do is introduce a new flag for sync_file_range()
that will really mean what I want it to mean (all data will be written back
and all related inode metadata changes will be committed to journal
before the next inode metadata change is committed). For the sake of
argument let's call it SYNC_FILE_RANGE_DATA_DEPENDENCY.

I could then extend the ->fsync() f_op 'datasync' argument to 'sync_flags'
and let sync_file_range() call the filesystem to request the data dependency.
By default, no filesystem will support the new flag, but xfs and ext4 could
implement flag support simply by calling filemap_write_and_wait_range().

This way, the contract between the application and filesystem is drawn in
a way that filesystem is still able to make writeback optimizations without
breaking the contract. For example, if ext4 changes in a way that
filemap_write_and_wait_range() no longer gives the data dependency
guaranty, or if ext4 is mounted with no journal, then ext4 could refuse
the data dependency request or it could implement it differently.

Does that sound any better? If so, any suggestion for a less horid name
for this new flag?

Thanks,
Amir.
