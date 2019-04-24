Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731B8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E68218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="IXlIGc/W";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="kQUjEdbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfDXMLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:11:33 -0400
Received: from mail136-22.atl41.mandrillapp.com ([198.2.136.22]:29908 "EHLO
        mail136-22.atl41.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727172AbfDXMLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:11:32 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Apr 2019 08:11:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=hiUbytr/SBl9nWOAUaewKGipJi9riB2gnuiSAmSYE3U=;
 b=IXlIGc/WqweZqiL06fF0RCWx+ZDnSvIxhlZVyNCB2s3Ko5qNBD4DyaEtSObuwK1gKNApWcanmmGl
   1+vIzhJXhyKOQvN1tKkt8K6B2ynMiB3T1PuTndgewX5dX3esHgUeRLk6aqsUIyjq+qxV1GCdDRFe
   fg3TIR0HunQjTHm+/2U=
Received: from pmta04.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail136-22.atl41.mandrillapp.com id ho19781sb1kd for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 11:56:29 +0000 (envelope-from <bounce-md_31050260.5cc04eed.v1-8fecc606eca5468f8b88739de64aed02@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1556106989; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=hiUbytr/SBl9nWOAUaewKGipJi9riB2gnuiSAmSYE3U=; 
 b=kQUjEdbGx0RbGDO7zPJb3opL+KAAPe+UdG6KI7ugtNm5+YN5tmwoA2SRC6fBfFOGOJ0oSD
 NxHK0bEcdk/5LL1paqcDVtKAaHdP+4p2CCGOxrsudLacLaduL/W7pIUA7d4GGvjXdOkP2Gz8
 LyedtL9Sd3ciyL2jH2ewqTxiJ6TiA=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [RESEND4, PATCH 1/2] fuse: retrieve: cap requested size to negotiated max_write
Received: from [87.98.221.171] by mandrillapp.com id 8fecc606eca5468f8b88739de64aed02; Wed, 24 Apr 2019 11:56:29 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jakob Unterwurzacher <jakobunt@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        stable <stable@vger.kernel.org>
Message-Id: <20190424115620.GA2723@deco.navytux.spb.ru>
References: <cover.1553680185.git.kirr@nexedi.com> <12f7d0d98555ee0d174d04bb47644f65c07f035a.1553680185.git.kirr@nexedi.com> <CAJfpegv0NvcsD9gh3aN+ngzsLqbNWUc73ZPN1qHox_14eN9Pqg@mail.gmail.com>
In-Reply-To: <CAJfpegv0NvcsD9gh3aN+ngzsLqbNWUc73ZPN1qHox_14eN9Pqg@mail.gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.8fecc606eca5468f8b88739de64aed02
X-Mandrill-User: md_31050260
Date:   Wed, 24 Apr 2019 11:56:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 12:44:50PM +0200, Miklos Szeredi wrote:
> On Wed, Mar 27, 2019 at 11:15 AM Kirill Smelkov <kirr@nexedi.com> wrote:
> >
> > FUSE filesystem server and kernel client negotiate during initializatio=
n
> > phase, what should be the maximum write size the client will ever issue=
.
> > Correspondingly the filesystem server then queues sys_read calls to rea=
d
> > requests with buffer capacity large enough to carry request header
> > + that max_write bytes. A filesystem server is free to set its max_writ=
e
> > in anywhere in the range between [1=C2=B7page, fc->max_pages=C2=B7page]=
. In
> > particular go-fuse[2] sets max_write by default as 64K, wheres default
> > fc->max_pages corresponds to 128K. Libfuse also allows users to
> > configure max_write, but by default presets it to possible maximum.
> >
> > If max_write is < fc->max_pages=C2=B7page, and in NOTIFY_RETRIEVE handl=
er we
> > allow to retrieve more than max_write bytes, corresponding prepared
> > NOTIFY_REPLY will be thrown away by fuse_dev_do_read, because the
> > filesystem server, in full correspondence with server/client contract,
> > will be only queuing sys_read with ~max_write buffer capacity, and
> > fuse_dev_do_read throws away requests that cannot fit into server
> > request buffer. In turn the filesystem server could get stuck waiting
> > indefinitely for NOTIFY_REPLY since NOTIFY_RETRIEVE handler returned OK
> > which is understood by clients as that NOTIFY_REPLY was queued and will
> > be sent back.
> >
> > -> Cap requested size to negotiate max_write to avoid the problem.
> > This aligns with the way NOTIFY_RETRIEVE handler works, which already
> > unconditionally caps requested retrieve size to fuse_conn->max_pages.
> > This way it should not hurt NOTIFY_RETRIEVE semantic if we return less
> > data than was originally requested.
> >
> > Please see [1] for context where the problem of stuck filesystem was hi=
t
> > for real, how the situation was traced and for more involving patch tha=
t
> > did not make it into the tree.
> >
> > [1] https://marc.info/?l=3Dlinux-fsdevel&m=3D155057023600853&w=3D2
> > [2] https://github.com/hanwen/go-fuse
> >
> > Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
> > Cc: Han-Wen Nienhuys <hanwen@google.com>
> > Cc: Jakob Unterwurzacher <jakobunt@gmail.com>
> > Cc: <stable@vger.kernel.org> # v2.6.36+
> > ---
> >  fs/fuse/dev.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 8a63e52785e9..38e94bc43053 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -1749,7 +1749,7 @@ static int fuse_retrieve(struct fuse_conn *fc, st=
ruct inode *inode,
> >         offset =3D outarg->offset & ~PAGE_MASK;
> >         file_size =3D i_size_read(inode);
> >
> > -       num =3D outarg->size;
> > +       num =3D min(outarg->size, fc->max_write);
> 
> This is wrong: the max_size limited num is overwritten if constrained
> by file size.

I assume you are meaning this:

=09--- a/fs/fuse/dev.c
=09+++ b/fs/fuse/dev.c
=09@@ -1745,15 +1745,15 @@ static int fuse_retrieve(struct fuse_conn *fc, s=
truct inode *inode,
=09        unsigned int offset;
=09        size_t total_len =3D 0;
=09        unsigned int num_pages;
=09 
=09        offset =3D outarg->offset & ~PAGE_MASK;
=09        file_size =3D i_size_read(inode);
=09 
=09-       num =3D outarg->size;
=09+       num =3D min(outarg->size, fc->max_write);
=09        if (outarg->offset > file_size)
=09                num =3D 0;
=09        else if (outarg->offset + num > file_size)
=09                num =3D file_size - outarg->offset;=09=09<-- THIS
=09 
=09        num_pages =3D (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
=09        num_pages =3D min(num_pages, fc->max_pages);

and then in this case (offset + num > file_size) num overwrite

=09num =3D file_size - offset

can make num only smaller, right? And then the patch is not wrong because t=
here
is no other num overwriting in this function except when num is being furth=
er
decremented in loop that prepares pages to retrieve.

Or am I missing something?  Would it be more clear to cap num to
max_write after all calculations?  But then - if we are not sure that
file_size check can only lower num - we have a problem: we are no longer
sure that num is <=3D outarg->size.


> Also the patch is whitespace damaged.

I've tried to do the following in my mutt on "RESEND4, PATCH 1/2"
message:

=09|(cd ~/src/linux/linux && git am -)

and the patch applied successfully. So could you please clarify what
"whitespace damaged" means?

Attaching the patch once again just in case.

Kirill

---- 8< ----
From 000a5a6c91992f2a361a846cd050444964920f85 Mon Sep 17 00:00:00 2001
From: Kirill Smelkov <kirr@nexedi.com>
Date: Wed, 27 Mar 2019 13:00:56 +0300
Subject: [PATCH] fuse: retrieve: cap requested size to negotiated max_write
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

FUSE filesystem server and kernel client negotiate during initialization
phase, what should be the maximum write size the client will ever issue.
Correspondingly the filesystem server then queues sys_read calls to read
requests with buffer capacity large enough to carry request header
+ that max_write bytes. A filesystem server is free to set its max_write
in anywhere in the range between [1=C2=B7page, fc->max_pages=C2=B7page]. In
particular go-fuse[2] sets max_write by default as 64K, wheres default
fc->max_pages corresponds to 128K. Libfuse also allows users to
configure max_write, but by default presets it to possible maximum.

If max_write is < fc->max_pages=C2=B7page, and in NOTIFY_RETRIEVE handler w=
e
allow to retrieve more than max_write bytes, corresponding prepared
NOTIFY_REPLY will be thrown away by fuse_dev_do_read, because the
filesystem server, in full correspondence with server/client contract,
will be only queuing sys_read with ~max_write buffer capacity, and
fuse_dev_do_read throws away requests that cannot fit into server
request buffer. In turn the filesystem server could get stuck waiting
indefinitely for NOTIFY_REPLY since NOTIFY_RETRIEVE handler returned OK
which is understood by clients as that NOTIFY_REPLY was queued and will
be sent back.

-> Cap requested size to negotiate max_write to avoid the problem.
This aligns with the way NOTIFY_RETRIEVE handler works, which already
unconditionally caps requested retrieve size to fuse_conn->max_pages.
This way it should not hurt NOTIFY_RETRIEVE semantic if we return less
data than was originally requested.

Please see [1] for context where the problem of stuck filesystem was hit
for real, how the situation was traced and for more involving patch that
did not make it into the tree.

[1] https://marc.info/?l=3Dlinux-fsdevel&m=3D155057023600853&w=3D2
[2] https://github.com/hanwen/go-fuse

Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
Cc: Han-Wen Nienhuys <hanwen@google.com>
Cc: Jakob Unterwurzacher <jakobunt@gmail.com>
Cc: <stable@vger.kernel.org> # v2.6.36+
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9971a35cf1ef..1e2efd873201 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1749,7 +1749,7 @@ static int fuse_retrieve(struct fuse_conn *fc, struct=
 inode *inode,
 =09offset =3D outarg->offset & ~PAGE_MASK;
 =09file_size =3D i_size_read(inode);
 
-=09num =3D outarg->size;
+=09num =3D min(outarg->size, fc->max_write);
 =09if (outarg->offset > file_size)
 =09=09num =3D 0;
 =09else if (outarg->offset + num > file_size)
-- 
2.21.0.765.geec228f530

