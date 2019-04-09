Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534B6C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F4F2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfDIPnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:43:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:53896 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726372AbfDIPnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:43:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 24626AF67;
        Tue,  9 Apr 2019 15:43:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4829D1E429B; Tue,  9 Apr 2019 17:43:03 +0200 (CEST)
Date:   Tue, 9 Apr 2019 17:43:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/sync.c: sync_file_range(2) may use WB_SYNC_ALL
 writeback
Message-ID: <20190409154303.GB1426@quack2.suse.cz>
References: <20190409114922.30095-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409114922.30095-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09-04-19 14:49:22, Amir Goldstein wrote:
> Commit 23d0127096cb ("fs/sync.c: make sync_file_range(2) use WB_SYNC_NONE
> writeback") claims that sync_file_range(2) syscall was "created for
> userspace to be able to issue background writeout and so waiting for
> in-flight IO is undesirable there" and changes the writeback (back) to
> WB_SYNC_NONE.
> 
> This claim is only partially true. Is is true for users that use the flag
> SYNC_FILE_RANGE_WRITE by itself, as does PostgreSQL, the user that was
> the reason for changing to WB_SYNC_NONE writeback.
> 
> However, that claim is not true for users that use that flag combination
> SYNC_FILE_RANGE_{WAIT_BEFORE|WRITE|_WAIT_AFTER}.  Those users explicitly
> requested to wait for in-flight IO as well as to writeback of dirty
> pages.  sync_file_range(2) man page describes this flag combintaion as
> "write-for-data-integrity operation", although some may argue against
> this definition.
> 
> Re-brand that flag combination as SYNC_FILE_RANGE_WRITE_AND_WAIT and use
> the helper filemap_write_and_wait_range(), that uses WB_SYNC_ALL
> writeback, to perform the range sync request.
> 
> One intended use case for this API is creating a dependency between
> a new file's content and its link into the namepsace without requiring
> journal commit and flushing of disk volatile caches:
> 
>   fd = open(".", O_TMPFILE | O_RDWR);
>   write(fd, newdata, count);
>   sync_file_range(fd, SYNC_FILE_RANGE_WRITE_AND_WAIT, 0, 0);
>   linkat(AT_EMPTY_PATH, fd, AT_FDCWD, newfile);
> 
> For many local filesystems, ext4 and xfs included, the sequence above
> will guaranty that after crash, either 'newfile' exists with 'newdata'
> content or 'newfile' does not exists.  For some applications, this
> guaranty is strong enough and the effects of sync_file_range(2), even
> with WB_SYNC_ALL, are far less intrusive to other writers in the system
> than the effects of fdatasync(2).

I agree that this paragraph is true but I don't want any userspace program
rely on this. We've been through this when ext3 got converted to ext4 and
it has caused a lot of complaints. Ext3 had provided rather strong data vs
metadata ordering due to the way journalling was implemented. Then ext4
came, implemented delayed allocation and somewhat changed how journalling
works and suddently userspace programmers were caught by surprise their code
working by luck stopped working. And they were complaining that when their
code worked without fsync(2) before, it should work after it as well. So it
took a lot of explaining that their applications are broken and Ted has
also implemented some workarounds to make at least the most common mistakes
silently fixed by the kernel most of the time.

So I'm against providing 90% data integrity guarantees because there'll be
many people who'll think they can get away with it and then complain when
they won't once our implementation changes.

Rather I'd modify the manpage to not say that SYNC_FILE_RANGE_WAIT_BEFORE
| SYNC_FILE_RANGE_WRITE | SYNC_FILE_RANGE_WAIT_AFTER is a
write-for-data-integrity.
								Honza

> 
> Fixes: 23d0127096cb ("fs/sync.c: make sync_file_range(2) use WB_SYNC_NONE")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Hi folks,
> 
> I was debating with myself whether I should change behavior of
> sync_file_range(2) do to what documentation says it does and flag names
> suggest that they do or to introduce a new flag for the old/new
> behavior.
> 
> At the moment, myself won with restoring old behavior without a new
> flag, but with re-branding of existing flags. I do not see how there
> could be users relying on existing behavior (TM).
> 
> An argument in favor of new flag is that with existing flags,
> application doesn't know if kernel provides the guaranty or not.
> 
> An argument is favor of existing flags is to not further complicate the
> man page, that is complicated enough as it is.
> With this patch in upstream and stable kernels, the only thing I would add to
> man page is:
> 
>   SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE|SYNC_FILE_RANGE_WAIT_AFTER
> + (or SYNC_FILE_RANGE_WRITE_AND_WAIT)
>    This is a write-for-data-integrity operation that will ensure that all pages
>    in the specified range which were dirty when sync_file_range() was called are
> -  committed to disk.
> +  written to disk.  It should be noted that disk caches are not flushed by this
> +  call, so there are no guarantees here that the data will be available on disk
> +  after a crash.
> 
> Thought?
> 
> Amir.
> 
> 
>  fs/sync.c               | 25 ++++++++++++++++++-------
>  include/uapi/linux/fs.h |  3 +++
>  2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/sync.c b/fs/sync.c
> index b54e0541ad89..5cf6fdbae4de 100644
> --- a/fs/sync.c
> +++ b/fs/sync.c
> @@ -18,8 +18,8 @@
>  #include <linux/backing-dev.h>
>  #include "internal.h"
>  
> -#define VALID_FLAGS (SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE| \
> -			SYNC_FILE_RANGE_WAIT_AFTER)
> +#define VALID_FLAGS (SYNC_FILE_RANGE_WRITE | SYNC_FILE_RANGE_WRITE_AND_WAIT | \
> +		     SYNC_FILE_RANGE_WAIT_BEFORE | SYNC_FILE_RANGE_WAIT_AFTER)
>  
>  /*
>   * Do the filesystem syncing work. For simple filesystems
> @@ -235,9 +235,9 @@ SYSCALL_DEFINE1(fdatasync, unsigned int, fd)
>  }
>  
>  /*
> - * sys_sync_file_range() permits finely controlled syncing over a segment of
> + * ksys_sync_file_range() permits finely controlled syncing over a segment of
>   * a file in the range offset .. (offset+nbytes-1) inclusive.  If nbytes is
> - * zero then sys_sync_file_range() will operate from offset out to EOF.
> + * zero then ksys_sync_file_range() will operate from offset out to EOF.
>   *
>   * The flag bits are:
>   *
> @@ -254,7 +254,7 @@ SYSCALL_DEFINE1(fdatasync, unsigned int, fd)
>   * Useful combinations of the flag bits are:
>   *
>   * SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE: ensures that all pages
> - * in the range which were dirty on entry to sys_sync_file_range() are placed
> + * in the range which were dirty on entry to ksys_sync_file_range() are placed
>   * under writeout.  This is a start-write-for-data-integrity operation.
>   *
>   * SYNC_FILE_RANGE_WRITE: start writeout of all dirty pages in the range which
> @@ -266,10 +266,13 @@ SYSCALL_DEFINE1(fdatasync, unsigned int, fd)
>   * earlier SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE operation to wait
>   * for that operation to complete and to return the result.
>   *
> - * SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE|SYNC_FILE_RANGE_WAIT_AFTER:
> + * SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE|SYNC_FILE_RANGE_WAIT_AFTER
> + * (a.k.a. SYNC_FILE_RANGE_WRITE_AND_WAIT):
>   * a traditional sync() operation.  This is a write-for-data-integrity operation
>   * which will ensure that all pages in the range which were dirty on entry to
> - * sys_sync_file_range() are committed to disk.
> + * ksys_sync_file_range() are written to disk.  It should be noted that disk
> + * caches are not flushed by this call, so there are no guarantees here that the
> + * data will be available on disk after a crash.
>   *
>   *
>   * SYNC_FILE_RANGE_WAIT_BEFORE and SYNC_FILE_RANGE_WAIT_AFTER will detect any
> @@ -338,6 +341,14 @@ int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
>  
>  	mapping = f.file->f_mapping;
>  	ret = 0;
> +	if ((flags & SYNC_FILE_RANGE_WRITE_AND_WAIT) ==
> +		     SYNC_FILE_RANGE_WRITE_AND_WAIT) {
> +		/* Unlike SYNC_FILE_RANGE_WRITE alone uses WB_SYNC_ALL */
> +		ret = filemap_write_and_wait_range(mapping, offset, endbyte);
> +		if (ret < 0)
> +			goto out_put;
> +	}
> +
>  	if (flags & SYNC_FILE_RANGE_WAIT_BEFORE) {
>  		ret = file_fdatawait_range(f.file, offset, endbyte);
>  		if (ret < 0)
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 121e82ce296b..59c71fa8c553 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -320,6 +320,9 @@ struct fscrypt_key {
>  #define SYNC_FILE_RANGE_WAIT_BEFORE	1
>  #define SYNC_FILE_RANGE_WRITE		2
>  #define SYNC_FILE_RANGE_WAIT_AFTER	4
> +#define SYNC_FILE_RANGE_WRITE_AND_WAIT	(SYNC_FILE_RANGE_WRITE | \
> +					 SYNC_FILE_RANGE_WAIT_BEFORE | \
> +					 SYNC_FILE_RANGE_WAIT_AFTER)
>  
>  /*
>   * Flags for preadv2/pwritev2:
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
