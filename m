Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2E1C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28A220715
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CwfPZFkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfKNOMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:12:16 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40602 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfKNOMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:12:16 -0500
Received: by mail-io1-f65.google.com with SMTP id p6so6911455iod.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 06:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=daXwaUpM9rRfCebsmeONO+eG+0swkZkfxKanttjfQ/M=;
        b=CwfPZFkf1HyQsjO44bPoviF3INvOmCZcdCvmiHkR7B2Y7V60TIPmHS/VjHjkSYR/uY
         zuu+hBAXQ/q7J+wyZqVj7M1yjhD/zTxboQ4fJ3ggdLhCsDKu7HVpEnr5aT7JBamN6BZ5
         D0QrO4vdIjz/GORRN3zxzHlrqai5WV5EOIIGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=daXwaUpM9rRfCebsmeONO+eG+0swkZkfxKanttjfQ/M=;
        b=NiG+a0LMMmaX9Fpn9DqQfJylGnLbUqkC7unEfyQf+kU1S8bUh7MP1hleHJX6xfIXf7
         q6qev9I6ErhrB/bEYj+0ihN5uUcO+9cExIQII1whCcjUdysTwFdaZOXXZ8vFv+ZevH05
         X8yXRbCh953LfmA9vT9ofFk2qZDnIgwUyBhtKPh3mI1dnLtPNlYec32CNcfXI4tTHjSz
         9DvzOFo9vKZ55IWVlV+XfVP7vyhYG8ZbDx7333EdoQFUQrLPlyh23jvW99PvfoJtU27s
         I9mNXA3Zzgm/I/+K4RiwFR1vOzh/CthqshEJHsHPFCD3sE62RwfuWTTxe1ap28gp0s9Y
         rJvg==
X-Gm-Message-State: APjAAAVx/X6EpQMyf4seR7hCqvNWEtxOoeQOFgDe/Lz23351cw4mLNHo
        2ez2j5bU39bLRiDe/GbxD6ph4gYWoqddLCZAnWWayw==
X-Google-Smtp-Source: APXvYqzO/XeI0LEz9tcNtwQoyD6Arn70KqOOtK1lrjrMQZqnfM3KlQTf5/N/xZb3ePDHl8DWlaj+NaVTXwn9+qb2YvQ=
X-Received: by 2002:a6b:3bca:: with SMTP id i193mr7197900ioa.285.1573740734918;
 Thu, 14 Nov 2019 06:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20191107104957.306383-1-colin.king@canonical.com>
 <CAJfpegtr_xg_VG2npTfaxC+vD7B8bKa_0n9pu5vyfU-XQ9oV9Q@mail.gmail.com> <CAOQ4uxhnpeyK6xW-c5NOQZ_h1uhAOUn_BbVVVYhUgZ74KSKDKQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhnpeyK6xW-c5NOQZ_h1uhAOUn_BbVVVYhUgZ74KSKDKQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 14 Nov 2019 15:12:04 +0100
Message-ID: <CAJfpegu7egxf=BVyVQKKW_icjMbjdLcLdd1FEw5hXLvDaiLNVQ@mail.gmail.com>
Subject: Re: [PATCH][V2] ovl: fix lookup failure on multi lower squashfs
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Colin King <colin.king@canonical.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        stable <stable@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 5:34 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, Nov 13, 2019 at 6:02 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Thu, Nov 7, 2019 at 11:50 AM Colin King <colin.king@canonical.com> wrote:
> > >
> > > From: Colin Ian King <colin.king@canonical.com>
> > >
> > > In the past, overlayfs required that lower fs have non null uuid in
> > > order to support nfs export and decode copy up origin file handles.
> > >
> > > Commit 9df085f3c9a2 ("ovl: relax requirement for non null uuid of
> > > lower fs") relaxed this requirement for nfs export support, as long
> > > as uuid (even if null) is unique among all lower fs.
> > >
> > > However, said commit unintentionally also relaxed the non null uuid
> > > requirement for decoding copy up origin file handles, regardless of
> > > the unique uuid requirement.
> > >
> > > Amend this mistake by disabling decoding of copy up origin file handle
> > > from lower fs with a conflicting uuid.
> > >
> > > We still encode copy up origin file handles from those fs, because
> > > file handles like those already exist in the wild and because they
> > > might provide useful information in the future.
> > >
> > > Reported-by: Colin Ian King <colin.king@canonical.com>
> > > Link: https://lore.kernel.org/lkml/20191106234301.283006-1-colin.king@canonical.com/
> > > Fixes: 9df085f3c9a2 ("ovl: relax requirement for non null uuid ...")
> > > Cc: stable@vger.kernel.org # v4.20+
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > ---
> > >  fs/overlayfs/namei.c     |  8 ++++++++
> > >  fs/overlayfs/ovl_entry.h |  2 ++
> > >  fs/overlayfs/super.c     | 16 ++++++++++------
> > >  3 files changed, 20 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> > > index e9717c2f7d45..f47c591402d7 100644
> > > --- a/fs/overlayfs/namei.c
> > > +++ b/fs/overlayfs/namei.c
> > > @@ -325,6 +325,14 @@ int ovl_check_origin_fh(struct ovl_fs *ofs, struct ovl_fh *fh, bool connected,
> > >         int i;
> > >
> > >         for (i = 0; i < ofs->numlower; i++) {
> > > +               /*
> > > +                * If lower fs uuid is not unique among lower fs we cannot match
> > > +                * fh->uuid to layer.
> > > +                */
> > > +               if (ofs->lower_layers[i].fsid &&
> > > +                   ofs->lower_layers[i].fs->bad_uuid)
> > > +                       continue;
> > > +
> > >                 origin = ovl_decode_real_fh(fh, ofs->lower_layers[i].mnt,
> > >                                             connected);
> > >                 if (origin)
> > > diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> > > index a8279280e88d..28348c44ea5b 100644
> > > --- a/fs/overlayfs/ovl_entry.h
> > > +++ b/fs/overlayfs/ovl_entry.h
> > > @@ -22,6 +22,8 @@ struct ovl_config {
> > >  struct ovl_sb {
> > >         struct super_block *sb;
> > >         dev_t pseudo_dev;
> > > +       /* Unusable (conflicting) uuid */
> > > +       bool bad_uuid;
> > >  };
> > >
> > >  struct ovl_layer {
> > > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > > index afbcb116a7f1..5d4faab57ba0 100644
> > > --- a/fs/overlayfs/super.c
> > > +++ b/fs/overlayfs/super.c
> > > @@ -1255,17 +1255,18 @@ static bool ovl_lower_uuid_ok(struct ovl_fs *ofs, const uuid_t *uuid)
> > >  {
> > >         unsigned int i;
> > >
> > > -       if (!ofs->config.nfs_export && !(ofs->config.index && ofs->upper_mnt))
> > > -               return true;
> > > -
>
> Colin, I mislead you, this should be (I think):
>
>        if (!ofs->config.nfs_export && !ofs->upper_mnt)
>                return true;
>
> > >         for (i = 0; i < ofs->numlowerfs; i++) {
> > >                 /*
> > >                  * We use uuid to associate an overlay lower file handle with a
> > >                  * lower layer, so we can accept lower fs with null uuid as long
> > >                  * as all lower layers with null uuid are on the same fs.
> > > +                * if we detect multiple lower fs with the same uuid, we
> > > +                * disable lower file handle decoding on all of them.
> > >                  */
> > > -               if (uuid_equal(&ofs->lower_fs[i].sb->s_uuid, uuid))
> > > +               if (uuid_equal(&ofs->lower_fs[i].sb->s_uuid, uuid)) {
> > > +                       ofs->lower_fs[i].bad_uuid = true;
> > >                         return false;
> > > +               }
> > >         }
> > >         return true;
> > >  }
> > > @@ -1277,6 +1278,7 @@ static int ovl_get_fsid(struct ovl_fs *ofs, const struct path *path)
> > >         unsigned int i;
> > >         dev_t dev;
> > >         int err;
> > > +       bool bad_uuid = false;
> > >
> > >         /* fsid 0 is reserved for upper fs even with non upper overlay */
> > >         if (ofs->upper_mnt && ofs->upper_mnt->mnt_sb == sb)
> > > @@ -1287,10 +1289,11 @@ static int ovl_get_fsid(struct ovl_fs *ofs, const struct path *path)
> > >                         return i + 1;
> > >         }
> > >
> > > -       if (!ovl_lower_uuid_ok(ofs, &sb->s_uuid)) {
> > > +       if (ofs->upper_mnt && !ovl_lower_uuid_ok(ofs, &sb->s_uuid)) {
> >
> > This seems bogus: why only check conflicting lower layers if there's
> > an upper layer?
>
> It is bogus - it was my (wrong) suggestion.
> The thinking was that we only decode origin fh if we have an upper layer
> and index only valid with upper layer.
> I forgot the case of nfs_export and lower-only setup.
> Suggested fix above.
>
> >
> > > +               bad_uuid = true;
> > >                 ofs->config.index = false;
> > >                 ofs->config.nfs_export = false;
> > > -               pr_warn("overlayfs: %s uuid detected in lower fs '%pd2', falling back to index=off,nfs_export=off.\n",
> > > +               pr_warn("overlayfs: %s uuid detected in lower fs '%pd2', enforcing index=off,nfs_export=off.\n",
> >
> > And this while this makes sense, it doesn't really fit into this patch
> > (no change of behavior regarding how index and nfs_export are
> > handled).
> >
>
> Again, this was my (not wrong?) suggestion.
> What this patch changes is that ovl_lower_uuid_ok() can now return false
> and we get to this print although user did not ask for index nor nfs_export.
> So the "falling back" language no longer makes sense.

But does "enforcing" makes sense in this light?  That's not what the
detected bad_uuid condition is about, it's about failing to utilize
origin markings to make inode numbers persistent for filesystems that
have null uuid.   Is that correct?   Can we do a message that makes
that somewhat more clearer?

Thanks,
Miklos
