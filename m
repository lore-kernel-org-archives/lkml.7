Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B708C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 06:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426B820882
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 06:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjhcZSiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfG3GEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 02:04:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43914 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfG3GEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 02:04:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id y17so36319703ljk.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 23:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lhPMu/d+mNYdO4/R52AZNi5dcudkfxUtoSnXQNNQLlQ=;
        b=EjhcZSiW+f0fGCMRFiSX0SOJOBGh0j//EIo6dykFJY6R2JbrH9ULgnQM7kU3M95hzN
         0Ocvh9z/vuU93g+A7Spe94issRYoBNmFeYNloFwSKMDk227vKZVPCp3OuzLsljoNX8Kx
         q/h9rM634j/VxpdgRrdkBK8FjoOYwKjOOmiKuFADAs43HNAF50Tj7qBpX5ZymyzTbZhX
         +mD78Mlhl1GDj3dlAEdTevu1F9kWunvsPANlYSLSbHhjEQHKsnvJBvbEp5GcxGv+eKbX
         bX/n5OhUWwLW/sUVwPYSavlpZjDd7SOXfv24PXXeZ5empjHxbfXPkWuFHleaT4syeLnh
         Wn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lhPMu/d+mNYdO4/R52AZNi5dcudkfxUtoSnXQNNQLlQ=;
        b=jXL+Bzxr0uXTpjNxqRMy4KDpCRHCwLdd6yt4Qus5B9ptprnOdwKSj2becB7sb/56OZ
         58yiECv3G0YYks9dB5k2Muq+vfcLUV/yuiKlBMJvGJQ3TZXtLfZDoIA3HSW+8cxsn8Se
         T0Bir8U/A5L+xT5M6RWktRCGK7clh+lzDE9Mhjt9b/Xl1k7a8Fho0o2K8eNKGqsaxOHb
         RrTM/TbiX9FJffigI4YBjW9f9mtxGTZt5bfM1pwgC6bIu36lDKMWjgPi6RfVLCfmqhRB
         1783zx+51LYIQmyCSawqUxrlwWPVgVLfbtr9UtHr3fmqLMXPF4D5AD0knpHwXXOc6ndQ
         sMjg==
X-Gm-Message-State: APjAAAX/kU2ejDviYG/2P3LEPFq5mj2kF/BCFTFOyfGcbaLf2mPhkjjH
        E+BGtch/fVF2Z/IhlDYizHcg3WmL6U08o7GUQrM=
X-Google-Smtp-Source: APXvYqxmzmHjV57Df9PHOF7v/xjttRA0NnN6lrhC81EOznMVxKhz9A/bRkA5d5KZr0oMTlR3OV/eB0A8gy041JH4Nxc=
X-Received: by 2002:a2e:85d7:: with SMTP id h23mr61000623ljj.53.1564466639430;
 Mon, 29 Jul 2019 23:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190215024830.GA26477@jordon-HP-15-Notebook-PC>
 <20190728180611.GA20589@mail-itl> <CAFqt6zaMDnpB-RuapQAyYAub1t7oSdHH_pTD=f5k-s327ZvqMA@mail.gmail.com>
 <CAFqt6zY+07JBxAVfMqb+X78mXwFOj2VBh0nbR2tGnQOP9RrNkQ@mail.gmail.com> <20190729133642.GQ1250@mail-itl>
In-Reply-To: <20190729133642.GQ1250@mail-itl>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 30 Jul 2019 11:33:47 +0530
Message-ID: <CAFqt6zZN+6r6wYJY+f15JAjj8dY+o30w_+EWH9Vy2kUXCKSBog@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH v4 8/9] xen/gntdev.c: Convert to use vm_map_pages()
To:     =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Juergen Gross <jgross@suse.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        robin.murphy@arm.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 7:06 PM Marek Marczykowski-G=C3=B3recki
<marmarek@invisiblethingslab.com> wrote:
>
> On Mon, Jul 29, 2019 at 02:02:54PM +0530, Souptick Joarder wrote:
> > On Mon, Jul 29, 2019 at 1:35 PM Souptick Joarder <jrdr.linux@gmail.com>=
 wrote:
> > >
> > > On Sun, Jul 28, 2019 at 11:36 PM Marek Marczykowski-G=C3=B3recki
> > > <marmarek@invisiblethingslab.com> wrote:
> > > >
> > > > On Fri, Feb 15, 2019 at 08:18:31AM +0530, Souptick Joarder wrote:
> > > > > Convert to use vm_map_pages() to map range of kernel
> > > > > memory to user vma.
> > > > >
> > > > > map->count is passed to vm_map_pages() and internal API
> > > > > verify map->count against count ( count =3D vma_pages(vma))
> > > > > for page array boundary overrun condition.
> > > >
> > > > This commit breaks gntdev driver. If vma->vm_pgoff > 0, vm_map_page=
s
> > > > will:
> > > >  - use map->pages starting at vma->vm_pgoff instead of 0
> > >
> > > The actual code ignores vma->vm_pgoff > 0 scenario and mapped
> > > the entire map->pages[i]. Why the entire map->pages[i] needs to be ma=
pped
> > > if vma->vm_pgoff > 0 (in original code) ?
>
> vma->vm_pgoff is used as index passed to gntdev_find_map_index. It's
> basically (ab)using this parameter for "which grant reference to map".
>
> > > are you referring to set vma->vm_pgoff =3D 0 irrespective of value pa=
ssed
> > > from user space ? If yes, using vm_map_pages_zero() is an alternate
> > > option.
>
> Yes, that should work.

I prefer to use vm_map_pages_zero() to resolve both the issues. Alternative=
ly
the patch can be reverted as you suggested. Let me know you opinion and wai=
t
for feedback from others.

Boris, would you like to give any feedback ?

>
> > > >  - verify map->count against vma_pages()+vma->vm_pgoff instead of j=
ust
> > > >    vma_pages().
> > >
> > > In original code ->
> > >
> > > diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> > > index 559d4b7f807d..469dfbd6cf90 100644
> > > --- a/drivers/xen/gntdev.c
> > > +++ b/drivers/xen/gntdev.c
> > > @@ -1084,7 +1084,7 @@ static int gntdev_mmap(struct file *flip, struc=
t
> > > vm_area_struct *vma)
> > > int index =3D vma->vm_pgoff;
> > > int count =3D vma_pages(vma);
> > >
> > > Count is user passed value.
> > >
> > > struct gntdev_grant_map *map;
> > > - int i, err =3D -EINVAL;
> > > + int err =3D -EINVAL;
> > > if ((vma->vm_flags & VM_WRITE) && !(vma->vm_flags & VM_SHARED))
> > > return -EINVAL;
> > > @@ -1145,12 +1145,9 @@ static int gntdev_mmap(struct file *flip,
> > > struct vm_area_struct *vma)
> > > goto out_put_map;
> > > if (!use_ptemod) {
> > > - for (i =3D 0; i < count; i++) {
> > > - err =3D vm_insert_page(vma, vma->vm_start + i*PAGE_SIZE,
> > > - map->pages[i]);
> > >
> > > and when count > i , we end up with trying to map memory outside
> > > boundary of map->pages[i], which was not correct.
> >
> > typo.
> > s/count > i / count > map->count
>
> gntdev_find_map_index verifies it. Specifically, it looks for a map match=
ing
> both index and count.
>
> > >
> > > - if (err)
> > > - goto out_put_map;
> > > - }
> > > + err =3D vm_map_pages(vma, map->pages, map->count);
> > > + if (err)
> > > + goto out_put_map;
> > >
> > > With this commit, inside __vm_map_pages(), we have addressed this sce=
nario.
> > >
> > > +static int __vm_map_pages(struct vm_area_struct *vma, struct page **=
pages,
> > > + unsigned long num, unsigned long offset)
> > > +{
> > > + unsigned long count =3D vma_pages(vma);
> > > + unsigned long uaddr =3D vma->vm_start;
> > > + int ret, i;
> > > +
> > > + /* Fail if the user requested offset is beyond the end of the objec=
t */
> > > + if (offset > num)
> > > + return -ENXIO;
> > > +
> > > + /* Fail if the user requested size exceeds available object size */
> > > + if (count > num - offset)
> > > + return -ENXIO;
> > >
> > > By checking count > num -offset. (considering vma->vm_pgoff !=3D 0 as=
 well).
> > > So we will never cross the boundary of map->pages[i].
> > >
> > >
> > > >
> > > > In practice, this breaks using a single gntdev FD for mapping multi=
ple
> > > > grants.
> > >
> > > How ?
>
> gntdev uses vma->vm_pgoff to select which grant entry should be mapped.
> map struct returned by gntdev_find_map_index() describes just the pages
> to be mapped. Specifically map->pages[0] should be mapped at
> vma->vm_start, not vma->vm_start+vma->vm_pgoff*PAGE_SIZE.
>
> When trying to map grant with index (aka vma->vm_pgoff) > 1,
> __vm_map_pages() will refuse to map it because it will expect map->count
> to be at least vma_pages(vma)+vma->vm_pgoff, while it is exactly
> vma_pages(vma).
>
> > > > It looks like vm_map_pages() is not a good fit for this code and IM=
O it
> > > > should be reverted.
> > >
> > > Did you hit any issue around this code in real time ?
>
> Yes, relevant strace output:
> [pid   857] ioctl(7, IOCTL_GNTDEV_MAP_GRANT_REF, 0x7ffd3407b6d0) =3D 0
> [pid   857] mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 7, 0) =3D =
0x777f1211b000
> [pid   857] ioctl(7, IOCTL_GNTDEV_SET_UNMAP_NOTIFY, 0x7ffd3407b710) =3D 0
> [pid   857] ioctl(7, IOCTL_GNTDEV_MAP_GRANT_REF, 0x7ffd3407b6d0) =3D 0
> [pid   857] mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 7, 0x1000)=
 =3D -1 ENXIO (No such device or address)
>
> details here:
> https://github.com/QubesOS/qubes-issues/issues/5199
>
>
> > >
> > >
> > > >
> > > > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > > > Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > > > > ---
> > > > >  drivers/xen/gntdev.c | 11 ++++-------
> > > > >  1 file changed, 4 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> > > > > index 5efc5ee..5d64262 100644
> > > > > --- a/drivers/xen/gntdev.c
> > > > > +++ b/drivers/xen/gntdev.c
> > > > > @@ -1084,7 +1084,7 @@ static int gntdev_mmap(struct file *flip, s=
truct vm_area_struct *vma)
> > > > >       int index =3D vma->vm_pgoff;
> > > > >       int count =3D vma_pages(vma);
> > > > >       struct gntdev_grant_map *map;
> > > > > -     int i, err =3D -EINVAL;
> > > > > +     int err =3D -EINVAL;
> > > > >
> > > > >       if ((vma->vm_flags & VM_WRITE) && !(vma->vm_flags & VM_SHAR=
ED))
> > > > >               return -EINVAL;
> > > > > @@ -1145,12 +1145,9 @@ static int gntdev_mmap(struct file *flip, =
struct vm_area_struct *vma)
> > > > >               goto out_put_map;
> > > > >
> > > > >       if (!use_ptemod) {
> > > > > -             for (i =3D 0; i < count; i++) {
> > > > > -                     err =3D vm_insert_page(vma, vma->vm_start +=
 i*PAGE_SIZE,
> > > > > -                             map->pages[i]);
> > > > > -                     if (err)
> > > > > -                             goto out_put_map;
> > > > > -             }
> > > > > +             err =3D vm_map_pages(vma, map->pages, map->count);
> > > > > +             if (err)
> > > > > +                     goto out_put_map;
> > > > >       } else {
> > > > >  #ifdef CONFIG_X86
> > > > >               /*
> > > >
> > > > --
> > > > Best Regards,
> > > > Marek Marczykowski-G=C3=B3recki
> > > > Invisible Things Lab
> > > > A: Because it messes up the order in which people normally read tex=
t.
> > > > Q: Why is top-posting such a bad thing?
>
> --
> Best Regards,
> Marek Marczykowski-G=C3=B3recki
> Invisible Things Lab
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
