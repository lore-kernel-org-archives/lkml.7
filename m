Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE950C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C583206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfC0Q6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:58:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:54138 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727172AbfC0Q6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:58:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 71665ADAF;
        Wed, 27 Mar 2019 16:58:30 +0000 (UTC)
Subject: Re: [PATCH 1/3] fs: stream_open - opener for stream-like files so
 that read and write can run simultaneously without deadlock
To:     Kirill Smelkov <kirr@nexedi.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yongzhi Pan <panyongzhi@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Vrabel <david.vrabel@citrix.com>,
        Miklos Szeredi <miklos@szeredi.hu>, Tejun Heo <tj@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Nikolaus Rath <Nikolaus@rath.org>,
        Han-Wen Nienhuys <hanwen@google.com>
References: <c44fcf87d4c9d417b6cdced787091300fd45a3e4.1553637461.git.kirr@nexedi.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <785400d1-fa97-58f4-1f0d-79dc0f853c92@suse.com>
Date:   Wed, 27 Mar 2019 17:58:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <c44fcf87d4c9d417b6cdced787091300fd45a3e4.1553637461.git.kirr@nexedi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2019 23:20, Kirill Smelkov wrote:
> Commit 9c225f2655 (vfs: atomic f_pos accesses as per POSIX) added locking for
> file.f_pos access and in particular made concurrent read and write not possible
> - now both those functions take f_pos lock for the whole run, and so if e.g. a
> read is blocked waiting for data, write will deadlock waiting for that read to
> complete. This caused regression for stream-like files where previously read
> and write could run simultaneously, but after that patch could not do so
> anymore. See e.g. 581d21a2d0 (xenbus: fix deadlock on writes to /proc/xen/xenbus)
> which fixes such regression for particular case of /proc/xen/xenbus.
> 
> The patch that added f_pos lock in 2014 (see https://lkml.org/lkml/2014/2/17/324
> for background discussion) did so to guarantee POSIX thread safety for
> read/write/lseek and added the locking to file descriptors of all regular
> files. In 2014 that thread-safety problem was not new as it was already discussed
> earlier in 2006: https://lwn.net/Articles/180387. However even though 2006'th
> version of Linus's patch (https://lwn.net/Articles/180396) was adding f_pos
> locking "only for files that are marked seekable with FMODE_LSEEK (thus avoiding
> the stream-like objects like pipes and sockets)", 2014'th version - the one that
> actually made it into the tree as 9c225f2655 - is doing so irregardless of whether
> a file is seekable or not. The reason that it did so is, probably, that there are
> many files that are marked non-seekable, but e.g. their read implementation
> actually depends on knowing current position to correctly handle the read. Some
> examples:
> 
> 	kernel/power/user.c		snapshot_read
> 	fs/debugfs/file.c		u32_array_read
> 	fs/fuse/control.c		fuse_conn_waiting_read + ...
> 	drivers/hwmon/asus_atk0110.c	atk_debugfs_ggrp_read
> 	arch/s390/hypfs/inode.c		hypfs_read_iter
> 	...
> 
> In despite that, many nonseekable_open users implement read and write with pure
> stream semantics - they don't depend on passed ppos at all. And for those cases
> where read could wait for something inside, it creates a situation similar to
> xenbus - the write could be never made to go until read is done, and read is
> waiting for some, potentially external, event, for potentially unbounded time
> -> deadlock. Besides xenbus, there are 14 such places in the kernel that I've
> found with semantic patch (see below):
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
> In addition to the cases above another regression caused by f_pos locking is
> that now FUSE filesystems that implement open with FOPEN_NONSEEKABLE flag, can
> no longer implement bidirectional stream-like files - for the same reason
> as above e.g. read can deadlock write locking on file.f_pos in the kernel.
> FUSE's FOPEN_NONSEEKABLE was added in 2008 in a7c1b990f7 (fuse: implement
> nonseekable open) to support OSSPD (https://github.com/libfuse/osspd;
> https://lwn.net/Articles/308445). OSSPD implements /dev/dsp in userspace with
> FOPEN_NONSEEKABLE flag, with corresponding read and write routines not
> depending on current position at all, and with both read and write being
> potentially blocking operations:
> 
> 	https://github.com/libfuse/osspd/blob/14a9cff0/osspd.c#L1406
> 	https://github.com/libfuse/osspd/blob/14a9cff0/osspd.c#L1438-L1477
> 	https://github.com/libfuse/osspd/blob/14a9cff0/osspd.c#L1479-L1510
> 
> Corresponding libfuse example/test also describes FOPEN_NONSEEKABLE as
> "somewhat pipe-like files ..." with read handler not using offset. However
> that test implements only read without write and cannot exercise the deadlock
> scenario:
> 
> 	https://github.com/libfuse/libfuse/blob/fuse-3.4.2-3-ga1bff7d/example/poll.c#L124-L131
> 	https://github.com/libfuse/libfuse/blob/fuse-3.4.2-3-ga1bff7d/example/poll.c#L146-L163
> 	https://github.com/libfuse/libfuse/blob/fuse-3.4.2-3-ga1bff7d/example/poll.c#L209-L216
> 
> I've actually hit the read vs write deadlock for real while implementing my
> FUSE filesystem where there is /head/watch file, for which open creates
> separate bidirectional socket-like stream in between filesystem and its user
> with both read and write being later performed simultaneously. And there it is
> semantically not easy to split the stream into two separate read-only and
> write-only channels:
> 
> 	https://lab.nexedi.com/kirr/wendelin.core/blob/f13aa600/wcfs/wcfs.go#L88-169
> 
> Let's fix this regression. The plan is:
> 
> 1. We can't change nonseekable_open to include &~FMODE_ATOMIC_POS - doing so would
>    break many in-kernel nonseekable_open users which actually use ppos in
>    read/write handlers.
> 
> 2. Add stream_open() to kernel to open stream-like non-seekable file descriptors.
>    Read and write on such file descriptors would never use nor change ppos. And
>    with that property on stream-like files read and write will be running without
>    taking f_pos lock - i.e. read and write could be running simultaneously.
> 
> 3. With semantic patch search and convert to stream_open all in-kernel
>    nonseekable_open users for which read and write actually do not depend on ppos and
>    where there is no other methods in file_operations which assume @offset access.
> 
> 4. Add FOPEN_STREAM to fs/fuse/ and open in-kernel file-descriptors via steam_open
>    if that bit is present in filesystem open reply.
> 
>    It was tempting to change fs/fuse/ open handler to use stream_open instead of
>    nonseekable_open on just FOPEN_NONSEEKABLE flags, but grepping through Debian
>    codesearch shows users of FOPEN_NONSEEKABLE, and in particular GVFS which actually
>    uses offset in its read and write handlers
> 
> 	https://codesearch.debian.net/search?q=-%3Enonseekable+%3D
> 	https://gitlab.gnome.org/GNOME/gvfs/blob/1.40.0-6-gcbc54396/client/gvfsfusedaemon.c#L1080
> 	https://gitlab.gnome.org/GNOME/gvfs/blob/1.40.0-6-gcbc54396/client/gvfsfusedaemon.c#L1247-1346
> 	https://gitlab.gnome.org/GNOME/gvfs/blob/1.40.0-6-gcbc54396/client/gvfsfusedaemon.c#L1399-1481
> 
>    so if we would do such a change it will break a real user.
> 
> 5. Add stream_open and FOPEN_STREAM handling to stable kernels starting from
>    v3.14+ (the kernel where 9c225f2655 first appeared). This will allow to patch
>    OSSPD and other FUSE filesystems that provide stream-like files to return
>    FOPEN_STREAM | FOPEN_NONSEEKABLE in open handler and this way avoid the deadlock on
>    all kernel versions. This should work because fs/fuse/ ignores unknown open
>    flags returned from a filesystem and so passing FOPEN_STREAM to a kernel that
>    is not aware of this flag cannot hurt. In turn the kernel that is not aware of
>    FOPEN_STREAM will be < v3.14 where just FOPEN_NONSEEKABLE is sufficient to
>    implement streams without read vs write deadlock.
> 
> This patch: adds stream_open, converts /proc/xen/xenbus to it and adds semantic
> patch to automatically locate in-kernel places that are either required to be
> converted due to read vs write deadlock, or that are just safe to be converted
> because read and write do not use ppos and there are no other funky methods in
> file_operations.
> 
> Followup patches are:
> 
> - apply the result of semantic patch;
> - add FOPEN_STREAM to fs/fuse.
> 
> Regarding semantic patch I've verified each generated change manually - that it is
> correct to convert - and each other nonseekable_open instance left - that it is
> either not correct to convert there, or that it is not converted due to current
> stream_open.cocci limitations. The script also does not convert files that should
> be valid to convert, but that currently have .llseek = noop_llseek or
> generic_file_llseek for unknown reason despite file being opened with
> nonseekable_open (e.g. drivers/input/mousedev.c)
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

For the Xen changes: Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
