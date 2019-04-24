Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C4EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A052C21901
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556123704;
	bh=s9iirqYk3EVlAOt+bosdyrvEnq13isuThg2cUK45RC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BQI7B++LO7SEIdPoi3alyWU2OQp7WDMb3HOcxptntqPPLe9N6XNfoxAXQDoad6MjG
	 Co7eXf/fXf1urwzDUCtpimiZ2tQrDX3AgPFSxHWx3utkYGjpANSI6R121Ku8JCC4mQ
	 TVLE4XaXBaUGXRspZrR/M0MFG9eB6+uEAt42+MM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732597AbfDXQfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:35:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbfDXQfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:35:03 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCCDB21900;
        Wed, 24 Apr 2019 16:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556123701;
        bh=s9iirqYk3EVlAOt+bosdyrvEnq13isuThg2cUK45RC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EssesR3kjYp/PTDeF2KqywY8NFrOaFodTnhyhB09koZCu9IOqK+kJnxwNZb0vkvoC
         CAdpDty532w8UdjpRSMERBchYWiNW2eAuPrImcHUx95ut9CXoCrYo1XsL9aNgWwvt6
         5y8/GuPvUrTY8YoT84DBV1Wz6vJzLXxHzGp16dhM=
Date:   Wed, 24 Apr 2019 18:34:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kirill Smelkov <kirr@nexedi.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yongzhi Pan <panyongzhi@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Vrabel <david.vrabel@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>, Tejun Heo <tj@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Nikolaus Rath <Nikolaus@rath.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 49/52] fs: stream_open - opener for
 stream-like files so that read and write can run simultaneously without
 deadlock
Message-ID: <20190424163459.GC21413@kroah.com>
References: <20190424143911.28890-1-sashal@kernel.org>
 <20190424143911.28890-49-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424143911.28890-49-sashal@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 10:39:07AM -0400, Sasha Levin wrote:
> From: Kirill Smelkov <kirr@nexedi.com>
> 
> [ Upstream commit 10dce8af34226d90fa56746a934f8da5dcdba3df ]
> 
> Commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per POSIX") added
> locking for file.f_pos access and in particular made concurrent read and
> write not possible - now both those functions take f_pos lock for the
> whole run, and so if e.g. a read is blocked waiting for data, write will
> deadlock waiting for that read to complete.
> 
> This caused regression for stream-like files where previously read and
> write could run simultaneously, but after that patch could not do so
> anymore. See e.g. commit 581d21a2d02a ("xenbus: fix deadlock on writes
> to /proc/xen/xenbus") which fixes such regression for particular case of
> /proc/xen/xenbus.
> 
> The patch that added f_pos lock in 2014 did so to guarantee POSIX thread
> safety for read/write/lseek and added the locking to file descriptors of
> all regular files. In 2014 that thread-safety problem was not new as it
> was already discussed earlier in 2006.
> 
> However even though 2006'th version of Linus's patch was adding f_pos
> locking "only for files that are marked seekable with FMODE_LSEEK (thus
> avoiding the stream-like objects like pipes and sockets)", the 2014
> version - the one that actually made it into the tree as 9c225f2655e3 -
> is doing so irregardless of whether a file is seekable or not.
> 
> See
> 
>     https://lore.kernel.org/lkml/53022DB1.4070805@gmail.com/
>     https://lwn.net/Articles/180387
>     https://lwn.net/Articles/180396
> 
> for historic context.
> 
> The reason that it did so is, probably, that there are many files that
> are marked non-seekable, but e.g. their read implementation actually
> depends on knowing current position to correctly handle the read. Some
> examples:
> 
> 	kernel/power/user.c		snapshot_read
> 	fs/debugfs/file.c		u32_array_read
> 	fs/fuse/control.c		fuse_conn_waiting_read + ...
> 	drivers/hwmon/asus_atk0110.c	atk_debugfs_ggrp_read
> 	arch/s390/hypfs/inode.c		hypfs_read_iter
> 	...
> 
> Despite that, many nonseekable_open users implement read and write with
> pure stream semantics - they don't depend on passed ppos at all. And for
> those cases where read could wait for something inside, it creates a
> situation similar to xenbus - the write could be never made to go until
> read is done, and read is waiting for some, potentially external, event,
> for potentially unbounded time -> deadlock.
> 
> Besides xenbus, there are 14 such places in the kernel that I've found
> with semantic patch (see below):
> 
> 	drivers/xen/evtchn.c:667:8-24: ERROR: evtchn_fops: .read() can deadlock .write()
> 	drivers/isdn/capi/capi.c:963:8-24: ERROR: capi_fops: .read() can deadlock .write()
> 	drivers/input/evdev.c:527:1-17: ERROR: evdev_fops: .read() can deadlock .write()
> 	drivers/char/pcmcia/cm4000_cs.c:1685:7-23: ERROR: cm4000_fops: .read() can deadlock .write()
> 	net/rfkill/core.c:1146:8-24: ERROR: rfkill_fops: .read() can deadlock .write()
> 	drivers/s390/char/fs3270.c:488:1-17: ERROR: fs3270_fops: .read() can deadlock .write()
> 	drivers/usb/misc/ldusb.c:310:1-17: ERROR: ld_usb_fops: .read() can deadlock .write()
> 	drivers/hid/uhid.c:635:1-17: ERROR: uhid_fops: .read() can deadlock .write()
> 	net/batman-adv/icmp_socket.c:80:1-17: ERROR: batadv_fops: .read() can deadlock .write()
> 	drivers/media/rc/lirc_dev.c:198:1-17: ERROR: lirc_fops: .read() can deadlock .write()
> 	drivers/leds/uleds.c:77:1-17: ERROR: uleds_fops: .read() can deadlock .write()
> 	drivers/input/misc/uinput.c:400:1-17: ERROR: uinput_fops: .read() can deadlock .write()
> 	drivers/infiniband/core/user_mad.c:985:7-23: ERROR: umad_fops: .read() can deadlock .write()
> 	drivers/gnss/core.c:45:1-17: ERROR: gnss_fops: .read() can deadlock .write()
> 
> In addition to the cases above another regression caused by f_pos
> locking is that now FUSE filesystems that implement open with
> FOPEN_NONSEEKABLE flag, can no longer implement bidirectional
> stream-like files - for the same reason as above e.g. read can deadlock
> write locking on file.f_pos in the kernel.
> 
> FUSE's FOPEN_NONSEEKABLE was added in 2008 in a7c1b990f715 ("fuse:
> implement nonseekable open") to support OSSPD. OSSPD implements /dev/dsp
> in userspace with FOPEN_NONSEEKABLE flag, with corresponding read and
> write routines not depending on current position at all, and with both
> read and write being potentially blocking operations:
> 
> See
> 
>     https://github.com/libfuse/osspd
>     https://lwn.net/Articles/308445
> 
>     https://github.com/libfuse/osspd/blob/14a9cff0/osspd.c#L1406
>     https://github.com/libfuse/osspd/blob/14a9cff0/osspd.c#L1438-L1477
>     https://github.com/libfuse/osspd/blob/14a9cff0/osspd.c#L1479-L1510
> 
> Corresponding libfuse example/test also describes FOPEN_NONSEEKABLE as
> "somewhat pipe-like files ..." with read handler not using offset.
> However that test implements only read without write and cannot exercise
> the deadlock scenario:
> 
>     https://github.com/libfuse/libfuse/blob/fuse-3.4.2-3-ga1bff7d/example/poll.c#L124-L131
>     https://github.com/libfuse/libfuse/blob/fuse-3.4.2-3-ga1bff7d/example/poll.c#L146-L163
>     https://github.com/libfuse/libfuse/blob/fuse-3.4.2-3-ga1bff7d/example/poll.c#L209-L216
> 
> I've actually hit the read vs write deadlock for real while implementing
> my FUSE filesystem where there is /head/watch file, for which open
> creates separate bidirectional socket-like stream in between filesystem
> and its user with both read and write being later performed
> simultaneously. And there it is semantically not easy to split the
> stream into two separate read-only and write-only channels:
> 
>     https://lab.nexedi.com/kirr/wendelin.core/blob/f13aa600/wcfs/wcfs.go#L88-169
> 
> Let's fix this regression. The plan is:
> 
> 1. We can't change nonseekable_open to include &~FMODE_ATOMIC_POS -
>    doing so would break many in-kernel nonseekable_open users which
>    actually use ppos in read/write handlers.
> 
> 2. Add stream_open() to kernel to open stream-like non-seekable file
>    descriptors. Read and write on such file descriptors would never use
>    nor change ppos. And with that property on stream-like files read and
>    write will be running without taking f_pos lock - i.e. read and write
>    could be running simultaneously.
> 
> 3. With semantic patch search and convert to stream_open all in-kernel
>    nonseekable_open users for which read and write actually do not
>    depend on ppos and where there is no other methods in file_operations
>    which assume @offset access.
> 
> 4. Add FOPEN_STREAM to fs/fuse/ and open in-kernel file-descriptors via
>    steam_open if that bit is present in filesystem open reply.
> 
>    It was tempting to change fs/fuse/ open handler to use stream_open
>    instead of nonseekable_open on just FOPEN_NONSEEKABLE flags, but
>    grepping through Debian codesearch shows users of FOPEN_NONSEEKABLE,
>    and in particular GVFS which actually uses offset in its read and
>    write handlers
> 
> 	https://codesearch.debian.net/search?q=-%3Enonseekable+%3D
> 	https://gitlab.gnome.org/GNOME/gvfs/blob/1.40.0-6-gcbc54396/client/gvfsfusedaemon.c#L1080
> 	https://gitlab.gnome.org/GNOME/gvfs/blob/1.40.0-6-gcbc54396/client/gvfsfusedaemon.c#L1247-1346
> 	https://gitlab.gnome.org/GNOME/gvfs/blob/1.40.0-6-gcbc54396/client/gvfsfusedaemon.c#L1399-1481
> 
>    so if we would do such a change it will break a real user.
> 
> 5. Add stream_open and FOPEN_STREAM handling to stable kernels starting
>    from v3.14+ (the kernel where 9c225f2655 first appeared).
> 
>    This will allow to patch OSSPD and other FUSE filesystems that
>    provide stream-like files to return FOPEN_STREAM | FOPEN_NONSEEKABLE
>    in their open handler and this way avoid the deadlock on all kernel
>    versions. This should work because fs/fuse/ ignores unknown open
>    flags returned from a filesystem and so passing FOPEN_STREAM to a
>    kernel that is not aware of this flag cannot hurt. In turn the kernel
>    that is not aware of FOPEN_STREAM will be < v3.14 where just
>    FOPEN_NONSEEKABLE is sufficient to implement streams without read vs
>    write deadlock.
> 
> This patch adds stream_open, converts /proc/xen/xenbus to it and adds
> semantic patch to automatically locate in-kernel places that are either
> required to be converted due to read vs write deadlock, or that are just
> safe to be converted because read and write do not use ppos and there
> are no other funky methods in file_operations.
> 
> Regarding semantic patch I've verified each generated change manually -
> that it is correct to convert - and each other nonseekable_open instance
> left - that it is either not correct to convert there, or that it is not
> converted due to current stream_open.cocci limitations.
> 
> The script also does not convert files that should be valid to convert,
> but that currently have .llseek = noop_llseek or generic_file_llseek for
> unknown reason despite file being opened with nonseekable_open (e.g.
> drivers/input/mousedev.c)
> 
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: Yongzhi Pan <panyongzhi@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: David Vrabel <david.vrabel@citrix.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> Cc: Nikolaus Rath <Nikolaus@rath.org>
> Cc: Han-Wen Nienhuys <hanwen@google.com>
> Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/xen/xenbus/xenbus_dev_frontend.c |   4 +-
>  fs/open.c                                |  18 ++
>  fs/read_write.c                          |   5 +-
>  include/linux/fs.h                       |   4 +
>  scripts/coccinelle/api/stream_open.cocci | 363 +++++++++++++++++++++++
>  5 files changed, 389 insertions(+), 5 deletions(-)
>  create mode 100644 scripts/coccinelle/api/stream_open.cocci

Same comment as on the 5.0 patch, I think this should be dropped from
the autosel queue.

thanks,

greg k-h
