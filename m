Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03454C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C074C2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALyc7P86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfEPPjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:39:42 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36243 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEPPjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:39:41 -0400
Received: by mail-qt1-f194.google.com with SMTP id a17so4446705qth.3;
        Thu, 16 May 2019 08:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2fucNeGLVJ+d2Z6pO2MAWI5egeSfRnpuIQ5sFO0bkEc=;
        b=ALyc7P86MwlpsWVd/8dzfg0fvyKnwqsj8vk4XqqkLw97LH5dep5kyHSKzSSUyfCfbL
         v8AoOMWhafLWcm0oz9YqTB1S4mXN3TyPjW8+h2AHcB6fhi+IXuUQXQDxyZV4yAZr136z
         bDI+4IhEleyjUeC58ciECzON1kY0LQ5FwUouw/99gphcxABKnTBqAQv6moLzv87J5iXn
         fde1tgapwHgCKc6znCgUOLd8xlUXleyqAv60OjVYNtYzb72Y0TnHPaEK6dsFeiXbVWzf
         Lzx1vwmM2Bod09Y3ueY4fdhsGDLnmjVzDacKSc3YgqI6O0EoE+muSceMXoR0B1hG48m2
         7+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2fucNeGLVJ+d2Z6pO2MAWI5egeSfRnpuIQ5sFO0bkEc=;
        b=HLXLeP+bO4t5+Lav68o7MDavpi+v3kkpzEtA15qDI7/T93EqWXCNkxcTTHh/naC4Ip
         SdufWmpj6r2O6Cv5neOXTsv+TmDBWHpCUpe3eJzMcEuwMXYr0wSVYlWUJHKpkyDJSx0k
         cuSlCT7WcaIOEIQKx3Fi1JGHbN9ROCKKhGuf2dLYi/xzfh5IVyb2+SUdv7StzjbI8MWf
         3ftck8BwBV3xr1pBK0drShmf1zFhTxsInG5t6Upj9xsvSJC+jFlmlQ9n3659nN8hGc4a
         uQeDL9vUOlTD5aeKW7flKi4KTzFVegwdb2ZzwsnHTnp8JGsa9OXQ87uQj6Z0JIEQ1QvP
         WOqA==
X-Gm-Message-State: APjAAAUID+GcusyhoMopdsUGaBNzVqYBckLjQaUbaw33WlIVISbmgXN+
        kTdu60bAmCWgLhHWZBoiJgteWCPMZzwht7Lk7E0=
X-Google-Smtp-Source: APXvYqyYzYJ8p/LjkZLq3rUwySlBVWphza95OT9qxYPQIBK34vYrTSB1qPi5f4QtPVEucfBgw0aPxekJkUwIvXClPGg=
X-Received: by 2002:ac8:538f:: with SMTP id x15mr8270285qtp.263.1558021180433;
 Thu, 16 May 2019 08:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190509111849.22927-1-marcos.souza.org@gmail.com> <20190516112317.GA8611@geeko>
In-Reply-To: <20190516112317.GA8611@geeko>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 16 May 2019 08:39:29 -0700
Message-ID: <CAPhsuW6i2N-pLcUEC7g3VZxBOMOhEJ8=cS3FwQonf3529=x_Mg@mail.gmail.com>
Subject: Re: [PATCH] drivers: md: Unify common definitions of raid1 and raid10
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>, Shaohua Li <shli@kernel.org>,
        "open list:SOFTWARE RAID (Multiple Disks) SUPPORT" 
        <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 4:24 AM Marcos Paulo de Souza
<marcos.souza.org@gmail.com> wrote:
>
> ping.
>

Thanks for the patch. I will process it after the merge window closes.

Song

> On Thu, May 09, 2019 at 08:18:49AM -0300, Marcos Paulo de Souza wrote:
> > These definitions are being moved to raid1-10.c.
> >
> > Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> > ---
> >  drivers/md/raid1-10.c | 25 +++++++++++++++++++++++++
> >  drivers/md/raid1.c    | 29 ++---------------------------
> >  drivers/md/raid10.c   | 27 +--------------------------
> >  3 files changed, 28 insertions(+), 53 deletions(-)
> >
> > diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
> > index 400001b815db..7d968bf08e54 100644
> > --- a/drivers/md/raid1-10.c
> > +++ b/drivers/md/raid1-10.c
> > @@ -3,6 +3,31 @@
> >  #define RESYNC_BLOCK_SIZE (64*1024)
> >  #define RESYNC_PAGES ((RESYNC_BLOCK_SIZE + PAGE_SIZE-1) / PAGE_SIZE)
> >
> > +/*
> > + * Number of guaranteed raid bios in case of extreme VM load:
> > + */
> > +#define      NR_RAID_BIOS 256
> > +
> > +/* when we get a read error on a read-only array, we redirect to another
> > + * device without failing the first device, or trying to over-write to
> > + * correct the read error.  To keep track of bad blocks on a per-bio
> > + * level, we store IO_BLOCKED in the appropriate 'bios' pointer
> > + */
> > +#define IO_BLOCKED ((struct bio *)1)
> > +/* When we successfully write to a known bad-block, we need to remove the
> > + * bad-block marking which must be done from process context.  So we record
> > + * the success by setting devs[n].bio to IO_MADE_GOOD
> > + */
> > +#define IO_MADE_GOOD ((struct bio *)2)
> > +
> > +#define BIO_SPECIAL(bio) ((unsigned long)bio <= 2)
> > +
> > +/* When there are this many requests queue to be written by
> > + * the raid thread, we become 'congested' to provide back-pressure
> > + * for writeback.
> > + */
> > +static int max_queued_requests = 1024;
> > +
> >  /* for managing resync I/O pages */
> >  struct resync_pages {
> >       void            *raid_bio;
> > diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> > index 0c8a098d220e..bb052c35bf29 100644
> > --- a/drivers/md/raid1.c
> > +++ b/drivers/md/raid1.c
> > @@ -50,31 +50,6 @@
> >        (1L << MD_HAS_PPL) |           \
> >        (1L << MD_HAS_MULTIPLE_PPLS))
> >
> > -/*
> > - * Number of guaranteed r1bios in case of extreme VM load:
> > - */
> > -#define      NR_RAID1_BIOS 256
> > -
> > -/* when we get a read error on a read-only array, we redirect to another
> > - * device without failing the first device, or trying to over-write to
> > - * correct the read error.  To keep track of bad blocks on a per-bio
> > - * level, we store IO_BLOCKED in the appropriate 'bios' pointer
> > - */
> > -#define IO_BLOCKED ((struct bio *)1)
> > -/* When we successfully write to a known bad-block, we need to remove the
> > - * bad-block marking which must be done from process context.  So we record
> > - * the success by setting devs[n].bio to IO_MADE_GOOD
> > - */
> > -#define IO_MADE_GOOD ((struct bio *)2)
> > -
> > -#define BIO_SPECIAL(bio) ((unsigned long)bio <= 2)
> > -
> > -/* When there are this many requests queue to be written by
> > - * the raid1 thread, we become 'congested' to provide back-pressure
> > - * for writeback.
> > - */
> > -static int max_queued_requests = 1024;
> > -
> >  static void allow_barrier(struct r1conf *conf, sector_t sector_nr);
> >  static void lower_barrier(struct r1conf *conf, sector_t sector_nr);
> >
> > @@ -2955,7 +2930,7 @@ static struct r1conf *setup_conf(struct mddev *mddev)
> >       if (!conf->poolinfo)
> >               goto abort;
> >       conf->poolinfo->raid_disks = mddev->raid_disks * 2;
> > -     err = mempool_init(&conf->r1bio_pool, NR_RAID1_BIOS, r1bio_pool_alloc,
> > +     err = mempool_init(&conf->r1bio_pool, NR_RAID_BIOS, r1bio_pool_alloc,
> >                          r1bio_pool_free, conf->poolinfo);
> >       if (err)
> >               goto abort;
> > @@ -3240,7 +3215,7 @@ static int raid1_reshape(struct mddev *mddev)
> >       newpoolinfo->mddev = mddev;
> >       newpoolinfo->raid_disks = raid_disks * 2;
> >
> > -     ret = mempool_init(&newpool, NR_RAID1_BIOS, r1bio_pool_alloc,
> > +     ret = mempool_init(&newpool, NR_RAID_BIOS, r1bio_pool_alloc,
> >                          r1bio_pool_free, newpoolinfo);
> >       if (ret) {
> >               kfree(newpoolinfo);
> > diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> > index 3b6880dd648d..24cb116d950f 100644
> > --- a/drivers/md/raid10.c
> > +++ b/drivers/md/raid10.c
> > @@ -73,31 +73,6 @@
> >   *    [B A] [D C]    [B A] [E C D]
> >   */
> >
> > -/*
> > - * Number of guaranteed r10bios in case of extreme VM load:
> > - */
> > -#define      NR_RAID10_BIOS 256
> > -
> > -/* when we get a read error on a read-only array, we redirect to another
> > - * device without failing the first device, or trying to over-write to
> > - * correct the read error.  To keep track of bad blocks on a per-bio
> > - * level, we store IO_BLOCKED in the appropriate 'bios' pointer
> > - */
> > -#define IO_BLOCKED ((struct bio *)1)
> > -/* When we successfully write to a known bad-block, we need to remove the
> > - * bad-block marking which must be done from process context.  So we record
> > - * the success by setting devs[n].bio to IO_MADE_GOOD
> > - */
> > -#define IO_MADE_GOOD ((struct bio *)2)
> > -
> > -#define BIO_SPECIAL(bio) ((unsigned long)bio <= 2)
> > -
> > -/* When there are this many requests queued to be written by
> > - * the raid10 thread, we become 'congested' to provide back-pressure
> > - * for writeback.
> > - */
> > -static int max_queued_requests = 1024;
> > -
> >  static void allow_barrier(struct r10conf *conf);
> >  static void lower_barrier(struct r10conf *conf);
> >  static int _enough(struct r10conf *conf, int previous, int ignore);
> > @@ -3684,7 +3659,7 @@ static struct r10conf *setup_conf(struct mddev *mddev)
> >
> >       conf->geo = geo;
> >       conf->copies = copies;
> > -     err = mempool_init(&conf->r10bio_pool, NR_RAID10_BIOS, r10bio_pool_alloc,
> > +     err = mempool_init(&conf->r10bio_pool, NR_RAID_BIOS, r10bio_pool_alloc,
> >                          r10bio_pool_free, conf);
> >       if (err)
> >               goto out;
> > --
> > 2.21.0
> >
>
> --
> Thanks,
> Marcos
