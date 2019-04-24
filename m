Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D56CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4E6218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="JftZDjdy";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="MXRWUBUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbfDXIxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:53:08 -0400
Received: from mail136-22.atl41.mandrillapp.com ([198.2.136.22]:22857 "EHLO
        mail136-22.atl41.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727546AbfDXIxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=1IRMmbYJGbRUUy9AkY1TlFVx40THUGy/XUgpLXz3izk=;
 b=JftZDjdyWHDDtTIXzvGE1c4ySv30fuSpxtUk7VW2vpPsA5hU4fMIKnEumeftMz3s2A0LULyevURL
   V1lErdak256LWq2DPUnUi5Vs+r+UqmRet+93zH++zeTM84oK78oZCHa1gmZkAd4Tz/m+puxsj/2I
   hPERgc9lHztqtopGilU=
Received: from pmta04.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail136-22.atl41.mandrillapp.com id ho0hv41sb1k0 for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 08:38:06 +0000 (envelope-from <bounce-md_31050260.5cc0206d.v1-2476866303f9480cbb2a812b10324978@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1556095085; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : Date : MIME-Version : 
 Content-Type : Content-Transfer-Encoding : From : Subject : Date : 
 X-Mandrill-User : List-Unsubscribe; 
 bh=1IRMmbYJGbRUUy9AkY1TlFVx40THUGy/XUgpLXz3izk=; 
 b=MXRWUBUM1he133Jr8XVuUHrGLLNwRv6XtdG9lX0krgB+KhdjXqWCxYzO0LovMyGGSYc36o
 Rzq35zUdi+u+y8VM+bJfk/MO2Vp8zDc2OtyyC2Q/WmLGeV7iVxeYQH821ZrD4wCHnPJow72X
 Bo7RElqWAfmTKDr9zVoRyo2RbEqhw=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: FUSE workflow=? (Re: [RESEND1, PATCH 1/2] fuse: convert printk -> pr_*)
Received: from [87.98.221.171] by mandrillapp.com id 2476866303f9480cbb2a812b10324978; Wed, 24 Apr 2019 08:38:05 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Maxim Patlasov <mpatlasov@parallels.com>,
        Anatol Pomozov <anatol.pomozov@gmail.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Andrew Gallagher <andrewjcg@fb.com>,
        "Anand V . Avati" <avati@redhat.com>,
        Alexey Kuznetsov <kuznet@virtuozzo.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Constantine Shulyupin <const@makelinux.com>,
        Chad Austin <chadaustin@fb.com>,
        Dan Schatzberg <dschatzberg@fb.com>,
        <linux-fsdevel@vger.kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Message-Id: <20190424083800.GA11722@deco.navytux.spb.ru>
In-Reply-To: <CAJfpegt9DRmwKksR0QSA7NzQP_=a=yJybdL9mOP1cw5goGkdgw@mail.gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.2476866303f9480cbb2a812b10324978
X-Mandrill-User: md_31050260
Date:   Wed, 24 Apr 2019 08:38:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+torvalds

On Tue, Apr 23, 2019 at 04:57:58PM +0200, Miklos Szeredi wrote:
> On Wed, Mar 27, 2019 at 10:15 AM Kirill Smelkov <kirr@nexedi.com> wrote:
> >
> > Functions, like pr_err, are a more modern variant of printing compared to
> > printk. They could be used to denoise sources by using needed level in
> > the print function name, and by automatically inserting per-driver /
> > function / ... print prefix as defined by pr_fmt macro. pr_* are also
> > said to be used in Documentation/process/coding-style.rst and more
> > recent code - for example overlayfs - uses them instead of printk.
> >
> > Convert CUSE and FUSE to use the new pr_* functions.
> >
> > CUSE output stays completely unchanged, while FUSE output is amended a
> > bit for "trying to steal weird page" warning - the second line now comes
> > also with "fuse:" prefix. I hope it is ok.
> 
> Yep.  Applied, thanks.

Miklos, thanks for feedback. Could you please clarify where the patch is
applied? Here is what linux/MAINTAINERS says

	FUSE: FILESYSTEM IN USERSPACE
	M:      Miklos Szeredi <miklos@szeredi.hu>
	L:      linux-fsdevel@vger.kernel.org
	W:      http://fuse.sourceforge.net/
	T:      git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
	S:      Maintained
	F:      fs/fuse/
	F:      include/uapi/linux/fuse.h
	F:      Documentation/filesystems/fuse.txt

but git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git was
not updated for ~ 2 months. I see other "Applied, thanks" replies from
you on linux-fsdevel in recent days and it suggests that patches are
indeed applied, but where they are integrated is the question.
Linux-next also has no post-5.1 fuse patches at all, so I'm really
puzzled about what is going on.

Is there any reason not to keep for-next fuse branch publicly available?
Or am I missing something?

Could you please also have a look at other posted patches? I'm
struggling for months sending them to you and not getting feedback. It
is kind of frustrating to work in this mode. Here they are:

- FOPEN_STREAM to fix read/write deadlock on stream-like files:

  https://lore.kernel.org/linux-fsdevel/20190424071316.11967-1-kirr@nexedi.com/

  the basis for this patch was landed to master already:

  git.kernel.org/linus/10dce8af3422

- FUSE_PRECISE_INVAL_DATA to allow filesystems to have precise control
  over data cache and in particular not to loose the whole data cache on
  file size change:

  https://lore.kernel.org/linux-fsdevel/e0b43507976d6ea9010f1bacaef067f18de49f1f.1553677194.git.kirr@nexedi.com/
  cover letter: https://lore.kernel.org/linux-fsdevel/cover.1553677194.git.kirr@nexedi.com/

  this patch is essential for my filesystem which cares very deeply about
  not loosing local file cache.

  ( "fuse: convert printk -> pr_*" was only a preparatory patch in that
    series suggested by Kirill Tkhai )

- don't stuck clients on retrieve_notify with size > max_write

  https://lore.kernel.org/linux-fsdevel/cover.1553680185.git.kirr@nexedi.com/
    https://lore.kernel.org/linux-fsdevel/12f7d0d98555ee0d174d04bb47644f65c07f035a.1553680185.git.kirr@nexedi.com/
    https://lore.kernel.org/linux-fsdevel/d74b17b9d33c3dcc7a1f2fa2914fb3c4e7cda127.1553680185.git.kirr@nexedi.com/

  this is kind of no-op if server behaves sanely, but for slightly
  misbehaving server changes kernel to return a regular error instead of
  promising to userspace that it will send a reply and not doing so,
  thus getting userspace stuck.

  when I got my filesystem initially stuck it required to dig a lot to
  understand what was going on

  https://marc.info/?l=linux-fsdevel&m=155057023600853&w=2
  (starting from "I've hit this bug for real ...")

  Even though go-fuse (the fuse library that was slightly misbehaving) is
  now fixed https://github.com/hanwen/go-fuse/commit/58dcd77a24, it is a
  big difference if userspace gets an error, or it gets "ok" return and
  is further stuck waiting for promised message. Besides libfuse and
  go-fuse there are several other fuse libraries and by fixing kernel
  behaviour here we care about all fuse users. In February you set 10
  lines budget for this "non-bug fix" and this budget is met with the
  patches which cumulatively are 2 lines of code change and 7 lines of
  comments.


Thanks beforehand,
Kirill
