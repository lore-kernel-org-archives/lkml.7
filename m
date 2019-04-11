Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B136C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD7C2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="qCi5CdLB";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="WiTfNwqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfDKMx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:53:26 -0400
Received: from mail128-134.atl41.mandrillapp.com ([198.2.128.134]:48460 "EHLO
        mail128-134.atl41.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbfDKMx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:53:26 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Apr 2019 08:53:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=0MpfVU5z2GAdErOUQodQX9Oxj8MY/HPjGK/EhTrwnHs=;
 b=qCi5CdLBzno7RZav+8dCMfeaf1vqH8plySmfjyt0lwi5rsoW2dNg9hihwAnLRS0fU5d7M9J/MPDC
   bd/LUGXdCnZRdKGeuzvkVLMxnQMEFqkB5gcKrIIEqNcDMjkNzd5bSUqfPBcg3eFtk2nlDAVjXqZx
   18VS0pwC9HHYXKxiN5I=
Received: from pmta01.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail128-134.atl41.mandrillapp.com id hlssc61mquk9 for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 12:38:23 +0000 (envelope-from <bounce-md_31050260.5caf353e.v1-2935624d919c4c52900d3c4635ddde72@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1554986302; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=0MpfVU5z2GAdErOUQodQX9Oxj8MY/HPjGK/EhTrwnHs=; 
 b=WiTfNwqNZbhieN44HBaKmMUfu8tqk7PNV/sPKWG8x6+rPvBjKWB9Lt0/KO/ukDCOdmGdg/
 sMWP1Y3g/H7JW6WzliTWjSRLCXPYooU3dVlarrbqAMwtrB4aBIeR58jV0NwrMpZQuUgNfYDq
 YI1JNtoC/kmvGzYfkhMtK3CALJdAk=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH 1/3] fs: stream_open - opener for stream-like files so that read and write can run simultaneously without deadlock
Received: from [87.98.221.171] by mandrillapp.com id 2935624d919c4c52900d3c4635ddde72; Thu, 11 Apr 2019 12:38:22 +0000
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Message-Id: <20190411123816.GA18309@deco.navytux.spb.ru>
References: <c44fcf87d4c9d417b6cdced787091300fd45a3e4.1553637461.git.kirr@nexedi.com> <4c4651e2-167e-bfcc-7b3e-cda118f98a69@rasmusvillemoes.dk> <20190409203807.GA13855@deco.navytux.spb.ru> <d8c23d05-8810-13a2-cc50-7a47ff35e90b@rasmusvillemoes.dk>
In-Reply-To: <d8c23d05-8810-13a2-cc50-7a47ff35e90b@rasmusvillemoes.dk>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.2935624d919c4c52900d3c4635ddde72
X-Mandrill-User: md_31050260
Date:   Thu, 11 Apr 2019 12:38:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Linus, +Al, +linux-fsdevel, +linux-kernel

On Tue, Apr 09, 2019 at 11:50:23PM +0200, Rasmus Villemoes wrote:
> On 09/04/2019 22.38, Kirill Smelkov wrote:
> > On Tue, Apr 09, 2019 at 09:43:37AM +0200, Rasmus Villemoes wrote:
> >> On 26/03/2019 23.20, Kirill Smelkov wrote:
> >>
> >>> 2. Add stream_open() to kernel to open stream-like non-seekable file descriptors.
> >>>    Read and write on such file descriptors would never use nor change ppos. And
> >>>    with that property on stream-like files read and write will be running without
> >>>    taking f_pos lock - i.e. read and write could be running simultaneously.
> >>>
> >>
> >>> diff --git a/fs/read_write.c b/fs/read_write.c
> >>> index d83003d856a0..91cb375f9840 100644
> >>> --- a/fs/read_write.c
> >>> +++ b/fs/read_write.c
> >>> @@ -560,12 +560,13 @@ ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_
> >>>  
> >>>  static inline loff_t file_pos_read(struct file *file)
> >>>  {
> >>> -	return file->f_pos;
> >>> +	return file->f_mode & FMODE_STREAM ? 0 : file->f_pos;
> >>>  }
> >>>  
> >>>  static inline void file_pos_write(struct file *file, loff_t pos)
> >>>  {
> >>> -	file->f_pos = pos;
> >>> +	if ((file->f_mode & FMODE_STREAM) == 0)
> >>> +		file->f_pos = pos;
> >>>  }
> >>
> >> Perhaps leave file_pos_read alone (to avoid the conditional load), and
> >> do WARN_ON_ONCE((file->f_mode & FMODE_STREAM) && pos != 0) or maybe !=
> >> file->f_pos in _write to catch wrongly converted drivers - once the dust
> >> has settled and patches backported to -stable, that WARN_ON_ONCE can
> >> also be removed.
> >>
> >> Or, a more brutal way to detect .read or .write callbacks that do use
> >> ppos despite FMODE_STREAM is to lift the FMODE_STREAM handling to the
> >> callers of file_pos_{read,write} and pass on (file->f_mode &
> >> FMODE_STREAM) ? NULL : &pos instead of &pos. That would also just add
> >> one instead of two conditionals to the read/write paths.
> > 
> > Good idea to pass NULL as ppos into FMODE_STREAM users as this will show
> > as oops if a driver is wrongly converted and uses the position. Do you mean
> > something like this:
> > 
> 
> Not that invasive. I was more thinking of reverting the
> file_pos_read/write to their original state, then do this one-liner once
> per caller of those
> 
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -575,7 +575,7 @@ ssize_t ksys_read(unsigned int fd, char __user *buf,
> size_t count)
> 
>         if (f.file) {
>                 loff_t pos = file_pos_read(f.file);
> -               ret = vfs_read(f.file, buf, count, &pos);
> +               ret = vfs_read(f.file, buf, count, (file->f_mode & FMODE_STREAM) ? NULL : &pos);
>                 if (ret >= 0)
>                         file_pos_write(f.file, pos);
>                 fdput_pos(f);
> 
> The idea being to minimize the number of extra branches introduced in
> the read and write syscalls due to the FMODE_STREAM. So the above
> catches wrongly done conversions (or backports - perhaps an earlier
> version of some ->read callback did use ppos...) in a rather blunt way.

I checked generated x86_64 assembly and from the point of view of adding
minimum extra branches this is indeed the best version - no branches are
added at all as `(file->f_mode & FMODE_STREAM) ? NULL : &pos` is
translated to cmov instruction.

However file->f_pos writing is still there and it will bug under race
detector, e.g. under KTSAN because read and write can be running
simultaneously. Maybe it is not only race bug, but also a bit of
slowdown as read and write code paths write to the same memory thus
needing inter-cpu synchronization if read and write handlers are on
different cpus. However for this I'm not sure.

> The alternative was to revert file_pos_read() to just return file->f_pos
> as it used to, and just do
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 177ccc3d405a..97180d61a918 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -565,6 +565,7 @@ static inline loff_t file_pos_read(struct file *file)
> 
>  static inline void file_pos_write(struct file *file, loff_t pos)
>  {
> +       WARN_ON_ONCE((file->f_mode & FMODE_STREAM) && pos != 0);
>         file->f_pos = pos;
>  }
> 
> which is, essentially, also just one more branch (at least for all the
> ordinary, non-STREAM, files); this has the advantage of not oopsing, and
> just means that ->f_pos gets updated racily until somebody reacts to the
> WARN.

I prefer we pass NULL for ppos to FOPEN_STREAM files, because above
WARN, even if it triggers, will not tell which file implementation is
guilty - it will show the stack trace only till generic VFS code, if I
understand correctly.

> In either case, the current code papers over bugs introduced by
> conversion/backporting and has more branches.

Yes, thanks for brining this up. It is indeed better that we pass NULL
into converted drivers to catch correctness. Please see below for
updated patch and branches analysis.

> > but I wonder why we are discussing in private?
> 
> Well, the cc list looked too big for some mostly micro-optimzation
> comments, and I couldn't figure out a proper subset to trim it to. But
> if you think the sanity-checking (either variant) is worth it before the
> mass-conversion starts, I'm happy to take the discussion back to lkml.

Added relevant (I think) people and lists to Cc.

I was going to propose attached patch, but it turned out that if we
start to pass ppos=NULL, we also have to update at least new_sync_read,
new_sync_write, do_iter_writev_writev, rw_verify_area etc - functions
that can be called from under vfs_read/vfs_write/..., at least this way:

diff --git a/fs/read_write.c b/fs/read_write.c
index 4bdd1731859c..80724e9791bd 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -371,7 +371,7 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
        inode = file_inode(file);
        if (unlikely((ssize_t) count < 0))
                return retval;
-       pos = *ppos;
+       pos = (ppos ? *ppos : 0);
        if (unlikely(pos < 0)) {
                if (!unsigned_offsets(file))
                        return retval;
@@ -400,12 +400,13 @@ static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, lo
        ssize_t ret;

        init_sync_kiocb(&kiocb, filp);
-       kiocb.ki_pos = *ppos;
+       kiocb.ki_pos = (ppos ? *ppos : 0);
        iov_iter_init(&iter, READ, &iov, 1, len);

        ret = call_read_iter(filp, &kiocb, &iter);
        BUG_ON(ret == -EIOCBQUEUED);
-       *ppos = kiocb.ki_pos;
+       if (ppos)
+               *ppos = kiocb.ki_pos;
        return ret;
 }

@@ -468,12 +469,12 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
        ssize_t ret;

        init_sync_kiocb(&kiocb, filp);
-       kiocb.ki_pos = *ppos;
+       kiocb.ki_pos = (ppos ? *ppos : 0);
        iov_iter_init(&iter, WRITE, &iov, 1, len);

        ret = call_write_iter(filp, &kiocb, &iter);
        BUG_ON(ret == -EIOCBQUEUED);
-       if (ret > 0)
+       if (ret > 0 && ppos)
                *ppos = kiocb.ki_pos;
        return ret;
 }
@@ -666,14 +667,15 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
        ret = kiocb_set_rw_flags(&kiocb, flags);
        if (ret)
                return ret;
-       kiocb.ki_pos = *ppos;
+       kiocb.ki_pos = (ppos ? *ppos : 0);

        if (type == READ)
                ret = call_read_iter(filp, &kiocb, iter);
        else
                ret = call_write_iter(filp, &kiocb, iter);
        BUG_ON(ret == -EIOCBQUEUED);
-       *ppos = kiocb.ki_pos;
+       if (ppos)
+               *ppos = kiocb.ki_pos;
        return ret;
 }

There is no notion of NULL ppos in kiocb, and I'm not familiar with that
subsystem, so it would be good to first get feedback before deciding on
how/where to move on.

Linus, anyone, comments?

Thanks beforehand,
Kirill

---- 8< ----
From facf84dfc75bf314c5f19160551750001d2d513b Mon Sep 17 00:00:00 2001
From: Kirill Smelkov <kirr@nexedi.com>
Date: Thu, 11 Apr 2019 13:07:03 +0300
Subject: [BUGGY PATCH] fs: pass ppos=NULL to .read()/.write() of FMODE_STREAM files

( The patch is buggy - it will fail at NULL pointer dereference in e.g.
  rw_verify_area )

This amends commit 10dce8af3422 ("fs: stream_open - opener for
stream-like files so that read and write can run simultaneously without
deadlock") in how position is passed into .read()/.write() handler for
stream-like files:

Rasmus noticed that we currently pass 0 as position and ignore any position
change if that is done by a file implementation. This papers over bugs if ppos
is used in files that declare themselves as being stream-like as such bugs will
go unnoticed. Even if a file implementation is correctly converted into using
stream_open, its read/write later could be changed to use ppos and even though
that won't be working correctly, that bug might go unnoticed without someone
doing wrong behaviour analysis. It is thus better to pass ppos=NULL into
read/write for stream-like files as that don't give any chance for ppos usage
bugs because it will oops if ppos is ever used inside .read() or .write().

Rasmus also made the point that FMODE_STREAM patch added 2 branches into
ksys_read/ksys_write path which is too much unnecessary overhead and
could be reduces.

Let's rework the code to pass ppos=NULL and have less branches.

The first approach could be to revert file_pos_read and file_pos_write
into their pre-FMODE_STREAM version and just do

	--- a/fs/read_write.c
	+++ b/fs/read_write.c
	@@ -575,7 +575,7 @@ ssize_t ksys_read(unsigned int fd, char __user *buf,
	size_t count)

	        if (f.file) {
	                loff_t pos = file_pos_read(f.file);
	-               ret = vfs_read(f.file, buf, count, &pos);
	+               ret = vfs_read(f.file, buf, count, (file->f_mode & FMODE_STREAM) ? NULL : &pos);
	                if (ret >= 0)
	                        file_pos_write(f.file, pos);
	                fdput_pos(f);

this adds no branches at all as `(file->f_mode & FMODE_STREAM) ? NULL : &pos)`
translates to single cmov instruction on x86_64:

        if (f.file) {
    18e5:       48 89 c3                mov    %rax,%rbx
    18e8:       48 83 e3 fc             and    $0xfffffffffffffffc,%rbx
    18ec:       74 79                   je     1967 <ksys_read+0xa7>
    18ee:       48 89 c5                mov    %rax,%rbp
                loff_t pos = f.file->f_pos;
    18f1:       48 8b 43 68             mov    0x68(%rbx),%rax
                ret = vfs_read(f.file, buf, count, (f.file->f_mode & FMODE_STREAM) ? NULL : &pos);
    18f5:       48 89 e1                mov    %rsp,%rcx
    18f8:       f6 43 46 20             testb  $0x20,0x46(%rbx)
    18fc:       4c 89 e6                mov    %r12,%rsi
    18ff:       4c 89 ea                mov    %r13,%rdx
    1902:       48 89 df                mov    %rbx,%rdi
                loff_t pos = f.file->f_pos;
    1905:       48 89 04 24             mov    %rax,(%rsp)
                ret = vfs_read(f.file, buf, count, (f.file->f_mode & FMODE_STREAM) ? NULL : &pos);
    1909:       b8 00 00 00 00          mov    $0x0,%eax
    190e:       48 0f 45 c8             cmovne %rax,%rcx		<-- NOTE
    1912:       e8 00 00 00 00          callq  1917 <ksys_read+0x57>
                        1913: R_X86_64_PLT32    vfs_read-0x4

However this leaves on unconditional write into file->f_pos after
vfs_read call, and even though it should not be affecting semantic, it
will bug under race detector (e.g. KTSAN) and probably it might add some
inter-CPU overhead if read and write handlers are running on different
cores.

If we instead move `file->f_mode & FMODE_STREAM` checking into vfs
functions that actually dispatch IO and care to load/store file->f_fpos
only for non-stream files, even though it is 3 branches if looking at C
source, gcc generates only 1 more branch compared to how it was
pre-FMODE_STREAM. For example consider updated ksys_read:

	 ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count)
	 {
	 	struct fd f = fdget_pos(fd);
	 	ssize_t ret = -EBADF;

	 	if (f.file) {
	-		loff_t pos = file_pos_read(f.file);
	-		ret = vfs_read(f.file, buf, count, &pos);
	-		if (ret >= 0)
	-			file_pos_write(f.file, pos);
	+		loff_t pos, *ppos = f.file->f_mode & FMODE_STREAM ? NULL : &pos;
	+		if (ppos)
	+			pos = f.file->f_pos;
	+		ret = vfs_read(f.file, buf, count, ppos);
	+		if (ret >= 0 && ppos)
	+			f.file->f_pos = pos;
	 		fdput_pos(f);
	 	}
	 	return ret;

The code that gcc generates here is essentially as if the source was:

	if (f.file->f_mode & FMODE_STREAM) {
		ret = vfs_read(f.file, buf, count, NULL);
	} else {
		loff_t pos = f.file->f_pos;
		ret = vfs_read(f.file, buf, count, ppos);
		if (ret >= 0)
			f.file->f_pos = pos;
	}
	fdput_pos(f);

i.e. it branches only once after checking file->f_mode and then has two
distinct codepaths each with its own vfs_read call:

        if (f.file) {
    18e5:       48 89 c5                mov    %rax,%rbp
    18e8:       48 83 e5 fc             and    $0xfffffffffffffffc,%rbp
    18ec:       0f 84 89 00 00 00       je     197b <ksys_read+0xbb>
    18f2:       48 89 c3                mov    %rax,%rbx
                loff_t pos, *ppos = (f.file->f_mode & FMODE_STREAM) ? NULL : &pos;
    18f5:       f6 45 46 20             testb  $0x20,0x46(%rbp)
    18f9:       74 3b                   je     1936 <ksys_read+0x76>	<-- branch pos/no-pos
                ret = vfs_read(f.file, buf, count, ppos);
    18fb:       4c 89 e6                mov    %r12,%rsi		<-- start of IO without pos
    18fe:       31 c9                   xor    %ecx,%ecx
    1900:       4c 89 ea                mov    %r13,%rdx
    1903:       48 89 ef                mov    %rbp,%rdi
    1906:       e8 00 00 00 00          callq  190b <ksys_read+0x4b>
                        1907: R_X86_64_PLT32    vfs_read-0x4		<-- vfs_read(..., ppos=NULL)
    190b:       49 89 c4                mov    %rax,%r12
        if (f.flags & FDPUT_POS_UNLOCK)
    190e:       f6 c3 02                test   $0x2,%bl
    1911:       75 51                   jne    1964 <ksys_read+0xa4>
        if (fd.flags & FDPUT_FPUT)
    1913:       83 e3 01                and    $0x1,%ebx
    1916:       75 59                   jne    1971 <ksys_read+0xb1>
}
    1918:       48 8b 4c 24 08          mov    0x8(%rsp),%rcx
    191d:       65 48 33 0c 25 28 00    xor    %gs:0x28,%rcx
    1924:       00 00
    1926:       4c 89 e0                mov    %r12,%rax
    1929:       75 59                   jne    1984 <ksys_read+0xc4>
    192b:       48 83 c4 10             add    $0x10,%rsp
    192f:       5b                      pop    %rbx
    1930:       5d                      pop    %rbp
    1931:       41 5c                   pop    %r12
    1933:       41 5d                   pop    %r13
    1935:       c3                      retq
                        pos = f.file->f_pos;
    1936:       48 8b 45 68             mov    0x68(%rbp),%rax		<-- start of IO with pos
                ret = vfs_read(f.file, buf, count, ppos);
    193a:       4c 89 e6                mov    %r12,%rsi
    193d:       48 89 e1                mov    %rsp,%rcx
    1940:       4c 89 ea                mov    %r13,%rdx
    1943:       48 89 ef                mov    %rbp,%rdi
                        pos = f.file->f_pos;
    1946:       48 89 04 24             mov    %rax,(%rsp)
                ret = vfs_read(f.file, buf, count, ppos);
    194a:       e8 00 00 00 00          callq  194f <ksys_read+0x8f>
                        194b: R_X86_64_PLT32    vfs_read-0x4		<-- vfs_read(..., ppos=&pos)
    194f:       49 89 c4                mov    %rax,%r12
                if (ret >= 0 && ppos)
    1952:       48 85 c0                test   %rax,%rax
    1955:       78 b7                   js     190e <ksys_read+0x4e>
                        f.file->f_pos = pos;
    1957:       48 8b 04 24             mov    (%rsp),%rax
    195b:       48 89 45 68             mov    %rax,0x68(%rbp)
        if (f.flags & FDPUT_POS_UNLOCK)
    ...

If adding one branch to handle FMODE_STREAM is acceptable, this approach should
be ok. Not duplicating vfs_read calls at C level is better as C-level code is
more clear without such duplication, and gcc cares to optimize the function
properly to have only 1 branch depending on file->f_mode.

If even 1 extra branch is unacceptable, we should indeed go with the first
option described in this patch but be prepared for race-detector bug reports
and probably some inter-CPU overhead.

Overall I would suggest to use simpler approach presented by hereby patch unless
1-extra jump could be shown to cause noticeable slowdowns in practice.

Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 fs/open.c       |  5 +++--
 fs/read_write.c | 51 +++++++++++++++++++++++--------------------------
 2 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index a00350018a47..9c7d724a6f67 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1219,8 +1219,9 @@ EXPORT_SYMBOL(nonseekable_open);
 /*
  * stream_open is used by subsystems that want stream-like file descriptors.
  * Such file descriptors are not seekable and don't have notion of position
- * (file.f_pos is always 0). Contrary to file descriptors of other regular
- * files, .read() and .write() can run simultaneously.
+ * (file.f_pos is always 0 and ppos passed to .read()/.write() is always NULL).
+ * Contrary to file descriptors of other regular files, .read() and .write()
+ * can run simultaneously.
  *
  * stream_open never fails and is marked to return int so that it could be
  * directly used as file_operations.open .
diff --git a/fs/read_write.c b/fs/read_write.c
index 61b43ad7608e..21d350df8109 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -558,27 +558,18 @@ ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_
 	return ret;
 }
 
-static inline loff_t file_pos_read(struct file *file)
-{
-	return file->f_mode & FMODE_STREAM ? 0 : file->f_pos;
-}
-
-static inline void file_pos_write(struct file *file, loff_t pos)
-{
-	if ((file->f_mode & FMODE_STREAM) == 0)
-		file->f_pos = pos;
-}
-
 ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count)
 {
 	struct fd f = fdget_pos(fd);
 	ssize_t ret = -EBADF;
 
 	if (f.file) {
-		loff_t pos = file_pos_read(f.file);
-		ret = vfs_read(f.file, buf, count, &pos);
-		if (ret >= 0)
-			file_pos_write(f.file, pos);
+		loff_t pos, *ppos = f.file->f_mode & FMODE_STREAM ? NULL : &pos;
+		if (ppos)
+			pos = f.file->f_pos;
+		ret = vfs_read(f.file, buf, count, ppos);
+		if (ret >= 0 && ppos)
+			f.file->f_pos = pos;
 		fdput_pos(f);
 	}
 	return ret;
@@ -595,10 +586,12 @@ ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count)
 	ssize_t ret = -EBADF;
 
 	if (f.file) {
-		loff_t pos = file_pos_read(f.file);
-		ret = vfs_write(f.file, buf, count, &pos);
-		if (ret >= 0)
-			file_pos_write(f.file, pos);
+		loff_t pos, *ppos = f.file->f_mode & FMODE_STREAM ? NULL : &pos;
+		if (ppos)
+			pos = f.file->f_pos;
+		ret = vfs_write(f.file, buf, count, ppos);
+		if (ret >= 0 && ppos)
+			f.file->f_pos = pos;
 		fdput_pos(f);
 	}
 
@@ -1013,10 +1006,12 @@ static ssize_t do_readv(unsigned long fd, const struct iovec __user *vec,
 	ssize_t ret = -EBADF;
 
 	if (f.file) {
-		loff_t pos = file_pos_read(f.file);
-		ret = vfs_readv(f.file, vec, vlen, &pos, flags);
-		if (ret >= 0)
-			file_pos_write(f.file, pos);
+		loff_t pos, *ppos = f.file->f_mode & FMODE_STREAM ? NULL : &pos;
+		if (ppos)
+			pos = f.file->f_pos;
+		ret = vfs_readv(f.file, vec, vlen, ppos, flags);
+		if (ret >= 0 && ppos)
+			f.file->f_pos = pos;
 		fdput_pos(f);
 	}
 
@@ -1033,10 +1028,12 @@ static ssize_t do_writev(unsigned long fd, const struct iovec __user *vec,
 	ssize_t ret = -EBADF;
 
 	if (f.file) {
-		loff_t pos = file_pos_read(f.file);
-		ret = vfs_writev(f.file, vec, vlen, &pos, flags);
-		if (ret >= 0)
-			file_pos_write(f.file, pos);
+		loff_t pos, *ppos = f.file->f_mode & FMODE_STREAM ? NULL : &pos;
+		if (ppos)
+			pos = f.file->f_pos;
+		ret = vfs_writev(f.file, vec, vlen, ppos, flags);
+		if (ret >= 0 && ppos)
+			f.file->f_pos = pos;
 		fdput_pos(f);
 	}
 
-- 
2.21.0.392.gf8f6787159
