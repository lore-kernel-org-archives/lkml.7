Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFB6C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 05:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583D720856
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 05:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXaHRONs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfEUF7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 01:59:53 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46307 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfEUF7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 01:59:53 -0400
Received: by mail-qt1-f195.google.com with SMTP id z19so19072044qtz.13;
        Mon, 20 May 2019 22:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFJexFuFkQtgep9ej8Oax/FWg9d9zce2LMAbaZR8bz0=;
        b=AXaHRONsav7diI2ncW4TwuNgXcylolW1VNwsd89FVxhq96s2Y5WA4Rp4zITKEjUIQZ
         fYlyPKAz4DUY47zRSIDQgsqcapiH0nBmv/e7dXebSQUe3u0Pmvlf2hdjoNzTPZFP+98r
         CegOC0cljHpjpBMcdFZYftRfLpkniu8nEtN/kkrIgdG7rNMdqfQb3XLW6Zi8pqbm6iZU
         MYanbICS3xQNwQTonClX4Tx78EFsB6+XVM3LA9DJ/al90SiIiukhGTZ4zXJ70opvKJqb
         xRz350cIsJOAN5YuSgVupdXq5WcID3AI1FlzDE6JkA60cIqzwiFQceWcpCgwbzykIm9g
         b+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFJexFuFkQtgep9ej8Oax/FWg9d9zce2LMAbaZR8bz0=;
        b=PBqXz82H+5leOpu4GCr1flCfmz4QyuR+hkqzEOcfL5DSoas7XbQIwzwZ5YOlY06+Eo
         NPBEpdaoUHpqp+GoBg+TvwOC7OBSVhDj0u5mzmNu0Oo5RXgz0elhK+uYAHT/P8I3J5j7
         M706o9I24YVb1dKFoBZY77zaZuGhbSpXbvRCE3TAzRO4Wjxsri/Q/Fttnb1rTf4FCmhr
         UqKZNSTpS4YrgJbmToWGAqeVLA8t5wiPpDIG4ARtfEw0mBhvlRM79lzsyv4SA3769n4q
         KJIh/GfeKMU0kn0lQXB6tMrgSox47Wofc2GnhKPlDaSHxz0ElnbV/2oKTrUkadXYiXkR
         5xpA==
X-Gm-Message-State: APjAAAVp6t5XgPITw2xU/ndW8gFAK3gCeNmRSSghilffDbcJPnzg4NA8
        r9bhTYwO1FrYm1lzsRPN+CLSJte/OdoRWIXYCLE=
X-Google-Smtp-Source: APXvYqyR2aJsBCaBYckwTtOZqKD3r6TKlC4VXsZVZgw5xchddWWenYIB+8d9YwG0W330ejG8oZ3q/cen8KU5Ev0pEMY=
X-Received: by 2002:ac8:2af4:: with SMTP id c49mr46564688qta.83.1558418391734;
 Mon, 20 May 2019 22:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190509111849.22927-1-marcos.souza.org@gmail.com>
 <20190516112317.GA8611@geeko> <CAPhsuW6i2N-pLcUEC7g3VZxBOMOhEJ8=cS3FwQonf3529=x_Mg@mail.gmail.com>
In-Reply-To: <CAPhsuW6i2N-pLcUEC7g3VZxBOMOhEJ8=cS3FwQonf3529=x_Mg@mail.gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 20 May 2019 22:59:40 -0700
Message-ID: <CAPhsuW6VqPh7RWwNYa+r8sim_4+LQio5+JNSAhDahbF=o0qrjw@mail.gmail.com>
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

On Thu, May 16, 2019 at 8:39 AM Song Liu <liu.song.a23@gmail.com> wrote:
>
> On Thu, May 16, 2019 at 4:24 AM Marcos Paulo de Souza
> <marcos.souza.org@gmail.com> wrote:
> >
> > ping.
> >

Applied to https://github.com/liu-song-6/linux/tree/md-next.

>
> Thanks for the patch. I will process it after the merge window closes.
>
> Song
>
> > On Thu, May 09, 2019 at 08:18:49AM -0300, Marcos Paulo de Souza wrote:
> > > These definitions are being moved to raid1-10.c.
> > >
> > > Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> > > ---
> > >  drivers/md/raid1-10.c | 25 +++++++++++++++++++++++++
> > >  drivers/md/raid1.c    | 29 ++---------------------------
> > >  drivers/md/raid10.c   | 27 +--------------------------
> > >  3 files changed, 28 insertions(+), 53 deletions(-)
> > >
> > > diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
> > > index 400001b815db..7d968bf08e54 100644
> > > --- a/drivers/md/raid1-10.c
> > > +++ b/drivers/md/raid1-10.c
> > > @@ -3,6 +3,31 @@
> > >  #define RESYNC_BLOCK_SIZE (64*1024)
> > >  #define RESYNC_PAGES ((RESYNC_BLOCK_SIZE + PAGE_SIZE-1) / PAGE_SIZE)
> > >
> > > +/*
> > > + * Number of guaranteed raid bios in case of extreme VM load:
> > > + */
> > > +#define      NR_RAID_BIOS 256
> > > +
> > > +/* when we get a read error on a read-only array, we redirect to another
> > > + * device without failing the first device, or trying to over-write to
> > > + * correct the read error.  To keep track of bad blocks on a per-bio
> > > + * level, we store IO_BLOCKED in the appropriate 'bios' pointer
> > > + */
> > > +#define IO_BLOCKED ((struct bio *)1)
> > > +/* When we successfully write to a known bad-block, we need to remove the
> > > + * bad-block marking which must be done from process context.  So we record
> > > + * the success by setting devs[n].bio to IO_MADE_GOOD
> > > + */
> > > +#define IO_MADE_GOOD ((struct bio *)2)
> > > +
> > > +#define BIO_SPECIAL(bio) ((unsigned long)bio <= 2)
> > > +
> > > +/* When there are this many requests queue to be written by
> > > + * the raid thread, we become 'congested' to provide back-pressure
> > > + * for writeback.
> > > + */
> > > +static int max_queued_requests = 1024;
> > > +
> > >  /* for managing resync I/O pages */
> > >  struct resync_pages {
> > >       void            *raid_bio;
> > > diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> > > index 0c8a098d220e..bb052c35bf29 100644
> > > --- a/drivers/md/raid1.c
> > > +++ b/drivers/md/raid1.c
> > > @@ -50,31 +50,6 @@
> > >        (1L << MD_HAS_PPL) |           \
> > >        (1L << MD_HAS_MULTIPLE_PPLS))
> > >
> > > -/*
> > > - * Number of guaranteed r1bios in case of extreme VM load:
> > > - */
> > > -#define      NR_RAID1_BIOS 256
> > > -
> > > -/* when we get a read error on a read-only array, we redirect to another
> > > - * device without failing the first device, or trying to over-write to
> > > - * correct the read error.  To keep track of bad blocks on a per-bio
> > > - * level, we store IO_BLOCKED in the appropriate 'bios' pointer
> > > - */
> > > -#define IO_BLOCKED ((struct bio *)1)
> > > -/* When we successfully write to a known bad-block, we need to remove the
> > > - * bad-block marking which must be done from process context.  So we record
> > > - * the success by setting devs[n].bio to IO_MADE_GOOD
> > > - */
> > > -#define IO_MADE_GOOD ((struct bio *)2)
> > > -
> > > -#define BIO_SPECIAL(bio) ((unsigned long)bio <= 2)
> > > -
> > > -/* When there are this many requests queue to be written by
> > > - * the raid1 thread, we become 'congested' to provide back-pressure
> > > - * for writeback.
> > > - */
> > > -static int max_queued_requests = 1024;
> > > -
> > >  static void allow_barrier(struct r1conf *conf, sector_t sector_nr);
> > >  static void lower_barrier(struct r1conf *conf, sector_t sector_nr);
> > >
> > > @@ -2955,7 +2930,7 @@ static struct r1conf *setup_conf(struct mddev *mddev)
> > >       if (!conf->poolinfo)
> > >               goto abort;
> > >       conf->poolinfo->raid_disks = mddev->raid_disks * 2;
> > > -     err = mempool_init(&conf->r1bio_pool, NR_RAID1_BIOS, r1bio_pool_alloc,
> > > +     err = mempool_init(&conf->r1bio_pool, NR_RAID_BIOS, r1bio_pool_alloc,
> > >                          r1bio_pool_free, conf->poolinfo);
> > >       if (err)
> > >               goto abort;
> > > @@ -3240,7 +3215,7 @@ static int raid1_reshape(struct mddev *mddev)
> > >       newpoolinfo->mddev = mddev;
> > >       newpoolinfo->raid_disks = raid_disks * 2;
> > >
> > > -     ret = mempool_init(&newpool, NR_RAID1_BIOS, r1bio_pool_alloc,
> > > +     ret = mempool_init(&newpool, NR_RAID_BIOS, r1bio_pool_alloc,
> > >                          r1bio_pool_free, newpoolinfo);
> > >       if (ret) {
> > >               kfree(newpoolinfo);
> > > diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> > > index 3b6880dd648d..24cb116d950f 100644
> > > --- a/drivers/md/raid10.c
> > > +++ b/drivers/md/raid10.c
> > > @@ -73,31 +73,6 @@
> > >   *    [B A] [D C]    [B A] [E C D]
> > >   */
> > >
> > > -/*
> > > - * Number of guaranteed r10bios in case of extreme VM load:
> > > - */
> > > -#define      NR_RAID10_BIOS 256
> > > -
> > > -/* when we get a read error on a read-only array, we redirect to another
> > > - * device without failing the first device, or trying to over-write to
> > > - * correct the read error.  To keep track of bad blocks on a per-bio
> > > - * level, we store IO_BLOCKED in the appropriate 'bios' pointer
> > > - */
> > > -#define IO_BLOCKED ((struct bio *)1)
> > > -/* When we successfully write to a known bad-block, we need to remove the
> > > - * bad-block marking which must be done from process context.  So we record
> > > - * the success by setting devs[n].bio to IO_MADE_GOOD
> > > - */
> > > -#define IO_MADE_GOOD ((struct bio *)2)
> > > -
> > > -#define BIO_SPECIAL(bio) ((unsigned long)bio <= 2)
> > > -
> > > -/* When there are this many requests queued to be written by
> > > - * the raid10 thread, we become 'congested' to provide back-pressure
> > > - * for writeback.
> > > - */
> > > -static int max_queued_requests = 1024;
> > > -
> > >  static void allow_barrier(struct r10conf *conf);
> > >  static void lower_barrier(struct r10conf *conf);
> > >  static int _enough(struct r10conf *conf, int previous, int ignore);
> > > @@ -3684,7 +3659,7 @@ static struct r10conf *setup_conf(struct mddev *mddev)
> > >
> > >       conf->geo = geo;
> > >       conf->copies = copies;
> > > -     err = mempool_init(&conf->r10bio_pool, NR_RAID10_BIOS, r10bio_pool_alloc,
> > > +     err = mempool_init(&conf->r10bio_pool, NR_RAID_BIOS, r10bio_pool_alloc,
> > >                          r10bio_pool_free, conf);
> > >       if (err)
> > >               goto out;
> > > --
> > > 2.21.0
> > >
> >
> > --
> > Thanks,
> > Marcos
