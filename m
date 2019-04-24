Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433EEC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067B821773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="PD/RlD2l";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="ZEnYug7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbfDXNBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:01:18 -0400
Received: from mail133-30.atl131.mandrillapp.com ([198.2.133.30]:32732 "EHLO
        mail133-30.atl131.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728842AbfDXNBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:01:17 -0400
X-Greylist: delayed 1802 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Apr 2019 09:01:16 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=meBFEY5ggbjVcToDIenTK6mDefScwokuA5qfAcGfUUY=;
 b=PD/RlD2ljQ/xV95Ckx0J8gMLpRYg4Hh8h2rJ1lVgEpyM6pWSA1dIGiDHMaBvFkhhY/AqwQrrMtYp
   IWHR5DzjPBukq22JifMU2VMrkEVzWJzjtwrPJZMkN41hMUFBo1LUlaDWBZ3Nl9KbPz1+vgCWEyy/
   gZc2RmYwbKXlsMmKre8=
Received: from pmta02.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail133-30.atl131.mandrillapp.com id ho1f1o1sar8q for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 12:31:14 +0000 (envelope-from <bounce-md_31050260.5cc05712.v1-86baa58cb2be4fbcb1652ad452d7ce99@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1556109074; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=meBFEY5ggbjVcToDIenTK6mDefScwokuA5qfAcGfUUY=; 
 b=ZEnYug7tD8j6bE4lkDHlw4/mfENzgqhNcvU21JG/WfHn7rMBIBE23USgPMw+ynvREm9IrA
 Nmlh3jrwrCPi/j6zde+uKzO2WV3m2BFTNn8tC5IXrOfhzms8ae4OPCAZZNgUlQy8mx3LSbEW
 8Ri1oSG4S0HxVr+/4BZCQFU0z7gYQ=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [RESEND4, PATCH 1/2] fuse: retrieve: cap requested size to negotiated max_write
Received: from [87.98.221.171] by mandrillapp.com id 86baa58cb2be4fbcb1652ad452d7ce99; Wed, 24 Apr 2019 12:31:14 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jakob Unterwurzacher <jakobunt@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        stable <stable@vger.kernel.org>
Message-Id: <20190424123107.GA32024@deco.navytux.spb.ru>
References: <cover.1553680185.git.kirr@nexedi.com> <12f7d0d98555ee0d174d04bb47644f65c07f035a.1553680185.git.kirr@nexedi.com> <CAJfpegv0NvcsD9gh3aN+ngzsLqbNWUc73ZPN1qHox_14eN9Pqg@mail.gmail.com> <20190424115620.GA2723@deco.navytux.spb.ru> <CAJfpegsiWuykUsfg=sO8sKo5h86U65q10=e=wYKXTQEHW8DFkw@mail.gmail.com>
In-Reply-To: <CAJfpegsiWuykUsfg=sO8sKo5h86U65q10=e=wYKXTQEHW8DFkw@mail.gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.86baa58cb2be4fbcb1652ad452d7ce99
X-Mandrill-User: md_31050260
Date:   Wed, 24 Apr 2019 12:31:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 02:17:27PM +0200, Miklos Szeredi wrote:
> On Wed, Apr 24, 2019 at 1:56 PM Kirill Smelkov <kirr@nexedi.com> wrote:
> 
> > I assume you are meaning this:
> >
> >         --- a/fs/fuse/dev.c
> >         +++ b/fs/fuse/dev.c
> >         @@ -1745,15 +1745,15 @@ static int fuse_retrieve(struct fuse_co=
nn *fc, struct inode *inode,
> >                 unsigned int offset;
> >                 size_t total_len =3D 0;
> >                 unsigned int num_pages;
> >
> >                 offset =3D outarg->offset & ~PAGE_MASK;
> >                 file_size =3D i_size_read(inode);
> >
> >         -       num =3D outarg->size;
> >         +       num =3D min(outarg->size, fc->max_write);
> >                 if (outarg->offset > file_size)
> >                         num =3D 0;
> >                 else if (outarg->offset + num > file_size)
> >                         num =3D file_size - outarg->offset;            =
   <-- THIS
> >
> >                 num_pages =3D (num + offset + PAGE_SIZE - 1) >> PAGE_SH=
IFT;
> >                 num_pages =3D min(num_pages, fc->max_pages);
> >
> > and then in this case (offset + num > file_size) num overwrite
> >
> >         num =3D file_size - offset
> >
> > can make num only smaller, right? And then the patch is not wrong becau=
se there
> > is no other num overwriting in this function except when num is being f=
urther
> > decremented in loop that prepares pages to retrieve.
> 
> You're right, of course.

Thanks. Does it mean that the patch is ok? Do I need to rework
something?


> > > Also the patch is whitespace damaged.
> >
> > I've tried to do the following in my mutt on "RESEND4, PATCH 1/2"
> > message:
> >
> >         |(cd ~/src/linux/linux && git am -)
> >
> > and the patch applied successfully. So could you please clarify what
> > "whitespace damaged" means?
> 
> Hmm, apparently this (and only this) message is "quoted-printable"
> encoded.  git-am seems to handle it fine, but my script doesn't.
> Anyway, I'll do it manually.

I see. Probably it is not "quoted-printable" as

=09Content-Type: text/plain; charset=3Dutf-8
=09Content-Transfer-Encoding: 8bit

suggests and it is maybe due to UTF-8 characters (I used "=C2=B7" several
times in patch description). Anyway if it helps you can pull the patch
from here

=09https://lab.nexedi.com/kirr/linux.git=09y/fuse-retrieve-cap-max_write
=09
and then cherry-pick it (git cherry-pick fd482f96537a) to where needed.

Thanks again for feedback,

Kirill

