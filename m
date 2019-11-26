Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C12C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2002071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="YgVNqyN4";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="DWFA5Ia9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfKZKPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 05:15:22 -0500
Received: from mail187-16.suw11.mandrillapp.com ([198.2.187.16]:42022 "EHLO
        mail187-16.suw11.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727388AbfKZKPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 05:15:22 -0500
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Nov 2019 05:15:21 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=mqzlyKykmpv5Iq5zfQK/GYgxax6QSycqOmjhHdZR9Rg=;
 b=YgVNqyN4m6yRCFOuhC3OQCjK+9Sqd3Ni4orjJofIqNBgPXQFvO9L51m3pmgTfm0yaQ7FozUlN/ZF
   fbzLDamZfqN2aRCbT21DTwfQHTIomDzH5qhlOuooT+vZqqQ+u+AfNJUDhdyyPMXCOstaXtKJcaC7
   7goOjFFYEswGOwi6kaY=
Received: from pmta01.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail187-16.suw11.mandrillapp.com id hrjtji174i4h for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 10:00:20 +0000 (envelope-from <bounce-md_31050260.5ddcf7b4.v1-ea7ed32e943f45b58e80e7c553ee0419@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1574762420; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=mqzlyKykmpv5Iq5zfQK/GYgxax6QSycqOmjhHdZR9Rg=; 
 b=DWFA5Ia94m/kn/9k/ddFNhjQuSTnTFeHMPhozcbn5izKrImfFMBqscQLJVztox2sCmSx+b
 lHfdliLn5jE7gXlIhxwpz0XHSOqRGNbeseaN07VbFLpdbB1a1OvtGduKdehJtXmdp1W1kCCT
 L3QbY2OaAD8qjlnWZtp0cARmvy6wo=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: Commit 0be0ee71 ("fs: properly and reliably lock f_pos in fdget_pos()") breaking userspace
Received: from [87.98.221.171] by mandrillapp.com id ea7ed32e943f45b58e80e7c553ee0419; Tue, 26 Nov 2019 10:00:20 +0000
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kenneth R. Crudup" <kenny@panix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <20191126100010.GA15941@deco.navytux.spb.ru>
References: <alpine.DEB.2.21.1911251322160.2408@hp-x360n> <CAHk-=wj_nbDN3piDJBEteUrjyrZCTA+CCk15NfV=5D2xFfGJGw@mail.gmail.com> <CAHk-=whn2Dp44tjUpLo9ogs=p-v-Vn7c2Xdo4p+2V=d1hTaiuA@mail.gmail.com> <CAHk-=wj3YSFT+C3n=7CTsB-8U0NUpTpT3xEH866H4-1qbQGw7Q@mail.gmail.com> <CAHk-=whYSnvfZNN1_Nr-S5C+a8-SkSMZO4Rf3NDAO046+rTNXQ@mail.gmail.com>
In-Reply-To: <CAHk-=whYSnvfZNN1_Nr-S5C+a8-SkSMZO4Rf3NDAO046+rTNXQ@mail.gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.ea7ed32e943f45b58e80e7c553ee0419
X-Mandrill-User: md_31050260
Date:   Tue, 26 Nov 2019 10:00:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 07:39:34PM -0800, Linus Torvalds wrote:
> On Mon, Nov 25, 2019 at 7:21 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Of course, this may fix the f_pos locking issue, but replace it with a
> > "oops, the character device driver tried to look at *pos anyway", and
> > that will give you a nice OOPS instead.
> 
> Confirmed. At least the x86 firmware update code uses
> "simple_read_from_buffer()", which does use the file position, but
> doesn't actually allow llseek().
> 
> So no, "it's a character device no llseek" does not mean that it acts
> as a pure streaming device with no file position, and we'd actually
> have to mark individual drivers (either by adding 'stream_open()' in
> their open routines, or adding the extra field to 'struct
> file_operations' that I mentioned).
> 
> I think I'll have to revert that trial commit. I'll give it another
> day in case somebody has a better idea, but it looks like it's too
> early to do that nice cleanup as things are now.
> 
>               Linus

Linus, thanks for heads up and for pushing FMODE_STREAM conversion
forward.

I still believe the most practical approach to do it is via automation -
via extending and teaching stream_open.cocci to find other places that
actually don't use ppos / ki->ki_pos at all and at least warn that
stream_open() should be used for that file. Else it will be a lot of
pain.

Of course we can manually convert the core cases like pipes and sockets.
But those things are easy to do. On the other hand by manually
converting them, we lesser the extent to where the automation is applied
and tested, and that leaves us with just many small corner cases that
will be left in potentially racy/deadlocked state until someone actually
hit that problem and cares to debug it to understand what is going on.
Those will be many different places and so likely many different people,
and since debugging concurrency issues is not easy, it will likely last for
many years. Of course things like KCSAN helps a lot, but, if I
understand correctly, they do not provide full coverage for the whole
kernel, especially they are likely not providing coverage for leaf
kernel bits in drivers.

Of course, I might be missing something, and there is a way to e.g.
combine automation+pain approaches. Then that would be good to make
combined progress.

I still keep in mind extending stream_open.cocci myself, but for now I
cannot delve into it before finishing my transactional filesystem...

Kirill


P.S. even though I was put into cc there, somehow I did not received any
notification email for commits d8e464ecc17b (vfs: mark pipes and sockets as
stream-like file descriptors) and 0be0ee71816b (vfs: properly and
reliably lock f_pos in fdget_pos()).


P.P.S completely untested, but looks sane:

---- 8< ----
From 634e1af8775aa27799b4879fdb527e4a3b8b31ef Mon Sep 17 00:00:00 2001
From: Kirill Smelkov <kirr@nexedi.com>
Date: Tue, 26 Nov 2019 12:40:56 +0300
Subject: [PATCH] socket: No need to check for ki_pos != 0 anymore

Commit d8e464ecc17b (vfs: mark pipes and sockets as stream-like file
descriptors) converted sockets to use stream_open() which forbids llseek
and sets FMODE_STREAM for which VFS ksys_read/ksys_write routines make
sure not to change file->f_pos at all and always pass either ppos=NULL,
or ki->ki_pos=0 to fops->read/write, because there is no file position
for stream-like files.

Drop unnecessary checks.

Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 net/socket.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 17bc1eee198a..d8c583c755ae 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -959,9 +959,6 @@ static ssize_t sock_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (file->f_flags & O_NONBLOCK)
 		msg.msg_flags = MSG_DONTWAIT;
 
-	if (iocb->ki_pos != 0)
-		return -ESPIPE;
-
 	if (!iov_iter_count(to))	/* Match SYS5 behaviour */
 		return 0;
 
@@ -978,9 +975,6 @@ static ssize_t sock_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			     .msg_iocb = iocb};
 	ssize_t res;
 
-	if (iocb->ki_pos != 0)
-		return -ESPIPE;
-
 	if (file->f_flags & O_NONBLOCK)
 		msg.msg_flags = MSG_DONTWAIT;
 
-- 
2.20.1
