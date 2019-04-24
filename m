Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DB5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6260D20652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="hBy+/XgG";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="ANT6Iuyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388740AbfDXSKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:10:09 -0400
Received: from mail133-30.atl131.mandrillapp.com ([198.2.133.30]:37211 "EHLO
        mail133-30.atl131.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388108AbfDXSKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=02qKTqdOtA4Z41FRFPr/vQwJc4+ocExFqDxvLSC1V3I=;
 b=hBy+/XgGl9OPdchJqvKszqmYAdbps2EGc7JX3gbNj2mTMaBzJWgO37aSb17UlbmhNkWmn6Zh4mU1
   Igs+PSr27CZHxLRKY1/hdv80UnYUILjTdpo1h+VnherKb7HHEGxQOs+Dli3NaTBYdUDl/H/sFRJb
   iRqB1gHrIvHwMVhGSEw=
Received: from pmta02.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail133-30.atl131.mandrillapp.com id ho2j7q1sar81 for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 18:10:03 +0000 (envelope-from <bounce-md_31050260.5cc0a67a.v1-a99bf3401b104c8aad25811c1c3664ff@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1556129402; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=02qKTqdOtA4Z41FRFPr/vQwJc4+ocExFqDxvLSC1V3I=; 
 b=ANT6IuyhpS1AHjRaFL1t+JrszP6SruyrFpn/jycgP0rehHOjPqgfZTjRz4menycWIOpzhB
 sQ5qmnMgWLwDoz0PyoucSMYv3vqKxu3scky1B9oAMqmVzzRXXi6700Awag1RTHvTjtRS/wRC
 KbU/5Agof2E0jyxiuD0hsr41Wk3vM=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [RESEND4, PATCH 1/2] fuse: retrieve: cap requested size to negotiated max_write
Received: from [87.98.221.171] by mandrillapp.com id a99bf3401b104c8aad25811c1c3664ff; Wed, 24 Apr 2019 18:10:02 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jakob Unterwurzacher <jakobunt@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        stable <stable@vger.kernel.org>
Message-Id: <20190424180958.GA3798@deco.navytux.spb.ru>
References: <cover.1553680185.git.kirr@nexedi.com> <12f7d0d98555ee0d174d04bb47644f65c07f035a.1553680185.git.kirr@nexedi.com> <CAJfpegv0NvcsD9gh3aN+ngzsLqbNWUc73ZPN1qHox_14eN9Pqg@mail.gmail.com> <20190424115620.GA2723@deco.navytux.spb.ru> <CAJfpegsiWuykUsfg=sO8sKo5h86U65q10=e=wYKXTQEHW8DFkw@mail.gmail.com> <20190424123107.GA32024@deco.navytux.spb.ru> <CAJfpegupwNbVPenZdMX8F2Z3vKSJdfAsXuiF4YA+nbnj2Kp=sw@mail.gmail.com> <20190424142249.GA28070@deco.navytux.spb.ru> <CAJfpegtX6p+j+kRuudZ=yVM9Tgj7x4mBaiGuDoDCrZoRvBOt9Q@mail.gmail.com>
In-Reply-To: <CAJfpegtX6p+j+kRuudZ=yVM9Tgj7x4mBaiGuDoDCrZoRvBOt9Q@mail.gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.a99bf3401b104c8aad25811c1c3664ff
X-Mandrill-User: md_31050260
Date:   Wed, 24 Apr 2019 18:10:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 05:02:42PM +0200, Miklos Szeredi wrote:
> On Wed, Apr 24, 2019 at 4:22 PM Kirill Smelkov <kirr@nexedi.com> wrote:
> > - FUSE_PRECISE_INVAL_DATA:
> >
> >     --- b/include/uapi/linux/fuse.h
> >     +++ b/include/uapi/linux/fuse.h
> >     @@ -266,7 +266,7 @@
> >       * FUSE_MAX_PAGES: init_out.max_pages contains the max number of req pages
> >       * FUSE_CACHE_SYMLINKS: cache READLINK responses
> >       * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
> >     - * FUSE_PRECISE_INVAL_DATA: filesystem is fully responsible for data cache invalidation
> >     + * FUSE_PRECISE_INVAL_DATA: filesystem is fully responsible for invalidation
> >       */
> >      #define FUSE_ASYNC_READ                (1 << 0)
> >      #define FUSE_POSIX_LOCKS       (1 << 1)
> >
> > the "data cache" in "for data cache invalidation" has particular meaning
> > and semantic: the filesystem promises to explicitly invalidate data of
> 
> Right; better name: FUSE_EXPLICIT_INVAL_DATA.  Will push fixed version.

	- * FUSE_PRECISE_INVAL_DATA: filesystem is fully responsible for invalidation
	+ * FUSE_EXPLICIT_INVAL_DATA: only invalidate cached pages on explicit request

	...

	        /** Filesystem is fully reponsible for page cache invalidation. */
	-       unsigned precise_inval_data:1;
	+       unsigned explicit_inval_data:1;

Ok, let it be this way.


> > Your amendment for FOPEN_STREAM in uapi/linux/fuse.h (see above) also
> > suggests that it is better to be more explicit in that file.
> >
> >     --- b/fs/fuse/inode.c
> >     +++ b/fs/fuse/inode.c
> >     @@ -913,13 +913,8 @@
> >                                     fc->dont_mask = 1;
> >                             if (arg->flags & FUSE_AUTO_INVAL_DATA)
> >                                     fc->auto_inval_data = 1;
> >     -                       if (arg->flags & FUSE_PRECISE_INVAL_DATA)
> >     +                       else if (arg->flags & FUSE_PRECISE_INVAL_DATA)
> >                                     fc->precise_inval_data = 1;
> >     -                       if (fc->auto_inval_data && fc->precise_inval_data) {
> >     -                               pr_warn("filesystem requested both auto and "
> >     -                                       "precise cache control - using auto\n");
> >     -                               fc->precise_inval_data = 0;
> >     -                       }
> >                             if (arg->flags & FUSE_DO_READDIRPLUS) {
> >                                     fc->do_readdirplus = 1;
> >                                     if (arg->flags & FUSE_READDIRPLUS_AUTO)
> >
> > Even though it is ok for me personally (I could be careful and use only
> > FUSE_PRECISE_INVAL_DATA) I still think usage of both "auto" and "precise"
> > invalidation modes deserves a warning. It is only at filesystem init time. What
> > is the reason not to print it?
> 
> The warning makes no sense.  It should either be failure or silent override.

Ok.


> > - "fuse: retrieve: cap requested size to negotiated max_write"
> >
> >      Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
> >      Cc: Han-Wen Nienhuys <hanwen@google.com>
> >      Cc: Jakob Unterwurzacher <jakobunt@gmail.com>
> >     -Cc: <stable@vger.kernel.org> # v2.6.36+
> >
> > what is the reason not to include this patch into stable series?
> 
> This doens't fix any bugs out there, but there is a slight chance of
> regression (so it might possibly have to be reverted in the future) so
> it absolutely makes no sense to backport it to stable.

Ok.


Thanks again for tossing the patches,

Kirill
