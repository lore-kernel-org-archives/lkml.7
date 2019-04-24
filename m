Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFC3C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B1A218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="K8zy4zjc";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="YZoskjhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731376AbfDXOiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:38:08 -0400
Received: from mail136-22.atl41.mandrillapp.com ([198.2.136.22]:53091 "EHLO
        mail136-22.atl41.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730798AbfDXOiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:38:01 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Apr 2019 10:37:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=vN8sG6gk3XYhRhFWGpe37q4WZovlAZslkTb1g4haQ1M=;
 b=K8zy4zjcPjnJI/pN1OBy3j8Py0++/BW/dxf0mQZLP60ppGtIM5MNtHxOtp7GgDHKPEgV1X0Lcm+2
   SH/SgpQKKSaNRwop0turT+2qqSi0JfKDp1jzPFHcZ1QBDfc1iWXdDSeaGEi1BdT06QHChKJiDgx1
   1xS7dWd8Ot/iCP8dflA=
Received: from pmta04.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail136-22.atl41.mandrillapp.com id ho1qce1sb1kj for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 14:22:56 +0000 (envelope-from <bounce-md_31050260.5cc07140.v1-5e5e2e6804124e9e99ac88cf47e2e07f@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1556115776; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=vN8sG6gk3XYhRhFWGpe37q4WZovlAZslkTb1g4haQ1M=; 
 b=YZoskjhKkBlHzC8v6G+zZa1UT+dp6JybAbE5MesVbWPaK6FfG/qRyMT3Tx3UMBohe0hO92
 ORTkVMzZCI6fX9gfnR10L/o7uTQ8tZlNw1TYtcjecnHH3HpNBGNRuh6KCIBnb3a194X2vzI9
 pWQYUfCk+8S3b0/SBs4I45UHQqrkY=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [RESEND4, PATCH 1/2] fuse: retrieve: cap requested size to negotiated max_write
Received: from [87.98.221.171] by mandrillapp.com id 5e5e2e6804124e9e99ac88cf47e2e07f; Wed, 24 Apr 2019 14:22:56 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jakob Unterwurzacher <jakobunt@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        stable <stable@vger.kernel.org>
Message-Id: <20190424142249.GA28070@deco.navytux.spb.ru>
References: <cover.1553680185.git.kirr@nexedi.com> <12f7d0d98555ee0d174d04bb47644f65c07f035a.1553680185.git.kirr@nexedi.com> <CAJfpegv0NvcsD9gh3aN+ngzsLqbNWUc73ZPN1qHox_14eN9Pqg@mail.gmail.com> <20190424115620.GA2723@deco.navytux.spb.ru> <CAJfpegsiWuykUsfg=sO8sKo5h86U65q10=e=wYKXTQEHW8DFkw@mail.gmail.com> <20190424123107.GA32024@deco.navytux.spb.ru> <CAJfpegupwNbVPenZdMX8F2Z3vKSJdfAsXuiF4YA+nbnj2Kp=sw@mail.gmail.com>
In-Reply-To: <CAJfpegupwNbVPenZdMX8F2Z3vKSJdfAsXuiF4YA+nbnj2Kp=sw@mail.gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.5e5e2e6804124e9e99ac88cf47e2e07f
X-Mandrill-User: md_31050260
Date:   Wed, 24 Apr 2019 14:22:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 03:19:11PM +0200, Miklos Szeredi wrote:
> On Wed, Apr 24, 2019 at 2:31 PM Kirill Smelkov <kirr@nexedi.com> wrote:
> 
> > Thanks. Does it mean that the patch is ok? Do I need to rework
> > something?
> 
> Pushed to #for-next with all the rest.  Made some changes to the
> patches, so please verify.

Thanks a lot. I've verified all changes and it is indeed better to amend
something:

- FOPEN_STREAM:

    --- b/include/uapi/linux/fuse.h
    +++ b/include/uapi/linux/fuse.h
    @@ -232,7 +232,7 @@
      * FOPEN_KEEP_CACHE: don't invalidate the data cache on open
      * FOPEN_NONSEEKABLE: the file is not seekable
      * FOPEN_CACHE_DIR: allow caching this directory
    - * FOPEN_STREAM: the file is stream-like
    + * FOPEN_STREAM: the file is stream-like (no file position at all)
      */
     #define FOPEN_DIRECT_IO                (1 << 0)
     #define FOPEN_KEEP_CACHE       (1 << 1)

I agree, it is better this way (no amendment needed here).


- FUSE_PRECISE_INVAL_DATA:

    --- b/include/uapi/linux/fuse.h
    +++ b/include/uapi/linux/fuse.h
    @@ -266,7 +266,7 @@
      * FUSE_MAX_PAGES: init_out.max_pages contains the max number of req p=
ages
      * FUSE_CACHE_SYMLINKS: cache READLINK responses
      * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
    - * FUSE_PRECISE_INVAL_DATA: filesystem is fully responsible for data c=
ache invalidation
    + * FUSE_PRECISE_INVAL_DATA: filesystem is fully responsible for invali=
dation
      */
     #define FUSE_ASYNC_READ                (1 << 0)
     #define FUSE_POSIX_LOCKS       (1 << 1)

the "data cache" in "for data cache invalidation" has particular meaning
and semantic: the filesystem promises to explicitly invalidate data of
the file, but it does not promise to explicitly invalidate attributes. I
understand it is a long line, and I myself tried to remove extra words,
but "data cache" here is semantically needed, so I left it. The
particular behaviour of FUSE_PRECISE_INVAL_DATA also covers only data
cache invalidations. For example file attributes, if not explicitly
invalidated by filesystem, are still invalidated by kernel by its
heuristic and due to negotiated attributes timeout, which is not
"precise".

If it is "precise invalidation for everything: data and attributes" we
should probably rename it to FUSE_PRECISE_INVAL and change the patch to
also cover attributes and not invalidate them automatically. However I
suggest to keep two things separate - data and attributes and not to
change the patch. By the way, description for "auto" invalidation mode is

=09FUSE_AUTO_INVAL_DATA: automatically invalidate cached pages

which tells both from mode name and from its description that it is
about data.

uapi/linux/fuse.h is often used by userspace people as a document to
understand FUSE protocol (at least I used it this way). I thus suggest
to restore "data cache" since it makes semantic difference.

Your amendment for FOPEN_STREAM in uapi/linux/fuse.h (see above) also
suggests that it is better to be more explicit in that file.

    --- b/fs/fuse/inode.c
    +++ b/fs/fuse/inode.c
    @@ -913,13 +913,8 @@
                                    fc->dont_mask =3D 1;
                            if (arg->flags & FUSE_AUTO_INVAL_DATA)
                                    fc->auto_inval_data =3D 1;
    -                       if (arg->flags & FUSE_PRECISE_INVAL_DATA)
    +                       else if (arg->flags & FUSE_PRECISE_INVAL_DATA)
                                    fc->precise_inval_data =3D 1;
    -                       if (fc->auto_inval_data && fc->precise_inval_da=
ta) {
    -                               pr_warn("filesystem requested both auto=
 and "
    -                                       "precise cache control - using =
auto\n");
    -                               fc->precise_inval_data =3D 0;
    -                       }
                            if (arg->flags & FUSE_DO_READDIRPLUS) {
                                    fc->do_readdirplus =3D 1;
                                    if (arg->flags & FUSE_READDIRPLUS_AUTO)

Even though it is ok for me personally (I could be careful and use only
FUSE_PRECISE_INVAL_DATA) I still think usage of both "auto" and "precise"
invalidation modes deserves a warning. It is only at filesystem init time. =
What
is the reason not to print it?

- "fuse: retrieve: cap requested size to negotiated max_write"

     Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
     Cc: Han-Wen Nienhuys <hanwen@google.com>
     Cc: Jakob Unterwurzacher <jakobunt@gmail.com>
    -Cc: <stable@vger.kernel.org> # v2.6.36+

what is the reason not to include this patch into stable series?


- "fuse: require /dev/fuse reads to have enough buffer capacity"

    --- b/fs/fuse/dev.c
    +++ b/fs/fuse/dev.c
    @@ -1324,7 +1324,7 @@
             * to indicate that it is not following FUSE server/client cont=
ract.
             * Don't dequeue / abort any request.
             */
    -       if (nbytes < (fc->conn_init ? 4096 + fc->max_write : FUSE_MIN_R=
EAD_BUFFER))
    +       if (nbytes < max_t(size_t, FUSE_MIN_READ_BUFFER, 4096 + fc->max=
_write))
                    return -EINVAL;

ok, this seems to be correct, since fc, including fc->max_write, is
initialized as all zeros by fuse_conn_init (no amendment needed here).


> > I see. Probably it is not "quoted-printable" as
> >
> >         Content-Type: text/plain; charset=3Dutf-8
> >         Content-Transfer-Encoding: 8bit
> 
> Well, google converts it to quoted-printable then:
> 
> Content-Type: text/plain; charset=3Dutf-8
> Content-Transfer-Encoding: quoted-printable

I see.

> > suggests and it is maybe due to UTF-8 characters (I used "=C2=B7" sever=
al
> > times in patch description).
> 
> Please refrain from gratuitous use of non-ascii.   That middle-dot is
> written as "*" in C (fixed the patch description).

Ok, I will try not to use unicode for my kernel fuse bits.

Thanks, again, a lot for merging the patches.

Kirill

