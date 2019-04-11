Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A8EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8F520818
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfDKKQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:16:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:49790 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726104AbfDKKQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:16:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 13B8FAFBE;
        Thu, 11 Apr 2019 10:16:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AAA011E429B; Thu, 11 Apr 2019 12:16:39 +0200 (CEST)
Date:   Thu, 11 Apr 2019 12:16:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/sync.c: sync_file_range(2) may use WB_SYNC_ALL
 writeback
Message-ID: <20190411101639.GB1119@quack2.suse.cz>
References: <20190409114922.30095-1-amir73il@gmail.com>
 <20190409154303.GB1426@quack2.suse.cz>
 <CAOQ4uxi7X_Ge14Ek_BR=es8mLYbkM3vMOJE5+_Doon1OD5p0yA@mail.gmail.com>
 <20190410091012.GH1426@quack2.suse.cz>
 <CAOQ4uxiOR5cTi8O+Lzq1=YNDRgZF=FbT2-rbqtP937=dmOp1WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiOR5cTi8O+Lzq1=YNDRgZF=FbT2-rbqtP937=dmOp1WA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10-04-19 13:42:23, Amir Goldstein wrote:
> On Wed, Apr 10, 2019 at 12:10 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 09-04-19 21:01:54, Amir Goldstein wrote:
> > > On Tue, Apr 9, 2019 at 6:43 PM Jan Kara <jack@suse.cz> wrote:
> > > > On Tue 09-04-19 14:49:22, Amir Goldstein wrote:
> > > > > Commit 23d0127096cb ("fs/sync.c: make sync_file_range(2) use WB_SYNC_NONE
> > > > > writeback") claims that sync_file_range(2) syscall was "created for
> > > > > userspace to be able to issue background writeout and so waiting for
> > > > > in-flight IO is undesirable there" and changes the writeback (back) to
> > > > > WB_SYNC_NONE.
> > > > >
> > > > > This claim is only partially true. Is is true for users that use the flag
> > > > > SYNC_FILE_RANGE_WRITE by itself, as does PostgreSQL, the user that was
> > > > > the reason for changing to WB_SYNC_NONE writeback.
> > > > >
> > > > > However, that claim is not true for users that use that flag combination
> > > > > SYNC_FILE_RANGE_{WAIT_BEFORE|WRITE|_WAIT_AFTER}.  Those users explicitly
> > > > > requested to wait for in-flight IO as well as to writeback of dirty
> > > > > pages.  sync_file_range(2) man page describes this flag combintaion as
> > > > > "write-for-data-integrity operation", although some may argue against
> > > > > this definition.
> > > > >
> > > > > Re-brand that flag combination as SYNC_FILE_RANGE_WRITE_AND_WAIT and use
> > > > > the helper filemap_write_and_wait_range(), that uses WB_SYNC_ALL
> > > > > writeback, to perform the range sync request.
> > > > >
> > > > > One intended use case for this API is creating a dependency between
> > > > > a new file's content and its link into the namepsace without requiring
> > > > > journal commit and flushing of disk volatile caches:
> > > > >
> > > > >   fd = open(".", O_TMPFILE | O_RDWR);
> > > > >   write(fd, newdata, count);
> > > > >   sync_file_range(fd, SYNC_FILE_RANGE_WRITE_AND_WAIT, 0, 0);
> > > > >   linkat(AT_EMPTY_PATH, fd, AT_FDCWD, newfile);
> > > > >
> > > > > For many local filesystems, ext4 and xfs included, the sequence above
> > > > > will guaranty that after crash, either 'newfile' exists with 'newdata'
> > > > > content or 'newfile' does not exists.  For some applications, this
> > > > > guaranty is strong enough and the effects of sync_file_range(2), even
> > > > > with WB_SYNC_ALL, are far less intrusive to other writers in the system
> > > > > than the effects of fdatasync(2).
> > > >
> > > > I agree that this paragraph is true but I don't want any userspace program
> > > > rely on this. We've been through this when ext3 got converted to ext4 and
> > > > it has caused a lot of complaints. Ext3 had provided rather strong data vs
> > > > metadata ordering due to the way journalling was implemented. Then ext4
> > > > came, implemented delayed allocation and somewhat changed how journalling
> > > > works and suddently userspace programmers were caught by surprise their code
> > > > working by luck stopped working. And they were complaining that when their
> > > > code worked without fsync(2) before, it should work after it as well. So it
> > > > took a lot of explaining that their applications are broken and Ted has
> > > > also implemented some workarounds to make at least the most common mistakes
> > > > silently fixed by the kernel most of the time.
> > > >
> > > > So I'm against providing 90% data integrity guarantees because there'll be
> > > > many people who'll think they can get away with it and then complain when
> > > > they won't once our implementation changes.
> > > >
> > > > Rather I'd modify the manpage to not say that SYNC_FILE_RANGE_WAIT_BEFORE
> > > > | SYNC_FILE_RANGE_WRITE | SYNC_FILE_RANGE_WAIT_AFTER is a
> > > > write-for-data-integrity.
> > >
> > > OK. I do agree that manpage is misleading and that the language describing
> > > this flag combination should be toned down. I do not object to adding more
> > > and more disclaimers about this API not being a data integrity API.
> >
> > I don't think we need more disclaimers, I'd just reword that
> > "write-for-data-integrity" bit.
> >
> > > But the requirement I have is a real life workload and fdatasync(2) is not at
> > > all a viable option when application is creating many files per second.
> > >
> > > I need to export the functionality of data writeback to userspace.
> > > Objecting to expose this functionality via the interface that has been
> > > documented to expose it for years and used to expose it in the
> > > past (until the Fixes commit) is a bit weird IMO, even though I do
> > > completely relate to your concern.
> > >
> > > I don't mind removing the "intended use case" part of commit message
> > > if that helps reducing the chance that people misunderstand
> > > the guaranties of the API.
> > >
> > > Another thing I could do is introduce a new flag for sync_file_range()
> > > that will really mean what I want it to mean (all data will be written back
> > > and all related inode metadata changes will be committed to journal
> > > before the next inode metadata change is committed). For the sake of
> > > argument let's call it SYNC_FILE_RANGE_DATA_DEPENDENCY.
> >
> > So there are two parts to your requirements:
> >
> > 1) Data writeback for all file pages has been submitted (+ completed).
> > 2) What happens with related metadata.
> >
> > sync_file_range() is fine for 1) although I agree that WB_SYNC_NONE mode
> > can still end up skipping some pages due to unrelated writeback / lock
> > contention so having sync_file_range() mode doing WB_SYNC_ALL writeback
> > makes some sense to me.
> >
> 
> OK. does it make enough sense for you to ACK my patch if the
> commit message was toned down to:
> 
> Commit 23d0127096cb ("fs/sync.c: make sync_file_range(2) use WB_SYNC_NONE
> writeback") claims that sync_file_range(2) syscall was "created for
> userspace to be able to issue background writeout and so waiting for
> in-flight IO is undesirable there" and changes the writeback (back) to
> WB_SYNC_NONE.
> 
> This claim is only partially true. It is true for users that use the flag
> SYNC_FILE_RANGE_WRITE by itself, as does PostgreSQL, the user that was
> the reason for changing to WB_SYNC_NONE writeback.
> 
> However, that claim is not true for users that use that flag combination
> SYNC_FILE_RANGE_{WAIT_BEFORE|WRITE|_WAIT_AFTER}.
> Those users explicitly requested to wait for in-flight IO as well as to
> writeback of dirty pages.
> 
> Re-brand that flag combination as SYNC_FILE_RANGE_WRITE_AND_WAIT
> and use the helper filemap_write_and_wait_range(), that uses WB_SYNC_ALL
> writeback, to perform the range sync request.
> 
> Fixes: 23d0127096cb ("fs/sync.c: make sync_file_range(2) use WB_SYNC_NONE")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Yes, I'd be fine with that.

> > What happens with 2) is pretty much up to the filesystem. You are speaking
> > about the journal but that is very much a filesystem specific detail.
> > What if the filesystem doesn't have journal at all? E.g. ext2? We cannot
> > really expose a generic API that silently fails to work based on fs
> > internal details.
> >
> > I guess I fail to see what kind of guarantees from the fs you're looking
> > for? When you speak about journal, I guess you're looking for some kind of
> > ordering but it's hard to be sure about exact requirements. So can you
> > please spell those out? Once we know requirements, we can speak about the
> > API.
> >
> 
> The requirement is quite easy to explain with an example, less easy to
> generalize. I illustrated the requirement with the example:
> O_TMPFILE;write();DATA_BARRIER;linkat()
>
> The requirement of the DATA_BARRIER operation is that if the effects
> of linkat() are observed after crash, then the effects of write() must also
> be observed after crash.

OK, understood and I agree this makes sense to ask for... And you're not
the only one. Application programmers often *assume* that if they do
write(file_new), rename(file_new, file), they will either see old or new
file contents after a crash. They are wrong but ext4 has heuristics to
detect such behavior and at least initiate writeback on rename to make time
window when data loss can happen smaller. Because there was lot of
controversy around this when users were transitioning from ext3 (where this
worked) to ext4. If there was API with decent performance to achieve this,
I guess at least some applications would start using it.
 
> At this point one may say that fdatasync(2) meets the requirements
> of a DATA_BARRIER operation, so I need to introduce a non-requirement.
> The non-requirement is that DATA_BARRIER operation does not need
> to be a DATA_INTEGRITY operation, meaning that after crash, there
> is no requirement to be able to find or access the written data.

Well, I guess your other real requirement is good performance ;) How that's
achieved is internal to the filesystem.

> Now it should be clear to filesystem developers why the DATA_BARRIER
> requirement is easier to meet with far less performance penalty than
> fdatasync(2) on xfs and ext4.

Well, it won't be free either but yes, you can save a transaction commit
/ disk cache flush compared to fdatasync(2).

> Here is a clumsy attempt to generalize the guaranty of such operation,
> without referring to internal fs implementation details:
> "Make sure that all file data hits persistent storage before the next
>  file metadata change hits persistent storage".
> 
> Does that make sense to you?
> Is the requirement clear?
> 
> How does this sound for an API:
> sync_file_range(fd, SYNC_FILE_RANGE_WRITE_DATA_BARRIER, 0, 0);
> 
> which individual filesystems could support or EOPNOTSUPP
> via the ->fsync() file_operation?

Yes, this sounds workable to me but there are also other options - e.g.
somehow pass the information to linkat() / rename() / whatever that the
ordering is required. This might be easier for some filesystems to
implement. So it might be good to make a short session at LSF/MM about this
so that developers of other filesystems can say what interface they would
be able to implement...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
