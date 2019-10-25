Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F63CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB78521D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571993216;
	bh=T0hGt0bPBfRV6BkGN/7sAn94df0B/wKoK48JCSqJFlY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Pmqah2v3x5BMfXmLht+y83efbzfKcmQXp+UZVEVzzKQ/vzFCb+hd9oVUbgkqhZ0+C
	 QLJjqLngJqFKqbsXSkUS29PVBSJ1us0atUfjep6JsEgt2UrLo8W87QsHnoDcJIbMBl
	 k9xIlFafIrB4CbJMTAs4iw3p1rbdneHV8bMAQh2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408544AbfJYIq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:46:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46728 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408483AbfJYIqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:46:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id n15so1296969wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 01:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=exj+JQCFM4kIaPpcruxUmmTKHwR9HwCRU6Cd5ZQAxg8=;
        b=i5uUky6OkF3Y8Or+QadfXXkOZALG2XUtdIVAbL2yZRkuXvzz9GX0lUfwUDKJl+jZCX
         nc5UQoxqoCLBsv0k3dnyPQCVCbPDzdnYMjND9GDrQZXcgeR0B5I5z90QChVb9m+oiwRW
         eyyqpCevUIIiW7+ulXlIVTEygn9DxsAPGZ7xXEdP9E6A9D73C5vc7SlBsJm1w48KN6xT
         sJYKSmVo47L9T0gT8oSZC4fBKGG80a07yxhxPUtMuLXQIp8oe1eW6WTR5RHJHxc1VkFE
         EqPbP9cJWG6oGWHtUiufKNaH3jrxrFIA9+cRF6bjvFwRmv9fjynFKzE1K0MUyLOx23Zg
         yDSg==
X-Gm-Message-State: APjAAAWrtd8RvCVFNj4Z4hINegLxMN96TPlLXReT+H/VPNKWZ7aiIp4e
        blpqDXOQcrsGufapyZE466YD8DD1/1QzVFfjKqM0Zg==
X-Google-Smtp-Source: APXvYqwdsHnl3UrjCCmCmgbNSpbzdSqOtomm9MbKcpgkYiOwkuk53fQTiIkY2iQZ++PQaTkvQArFaynUk5VOIOCcU5M=
X-Received: by 2002:adf:f684:: with SMTP id v4mr1738976wrp.336.1571993213261;
 Fri, 25 Oct 2019 01:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191016125019.157144-1-namhyung@kernel.org> <20191016125019.157144-3-namhyung@kernel.org>
 <20191024175201.GB3622521@devbig004.ftw2.facebook.com>
In-Reply-To: <20191024175201.GB3622521@devbig004.ftw2.facebook.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 25 Oct 2019 17:46:42 +0900
Message-ID: <CAM9d7cgDL_tt=+_VRZW9YUMxHN2ED2atr-8BcZJ76X6G3E2mwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kernfs: Allow creation with external gen + ino numbers
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Song Liu <liu.song.a23@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 2:52 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Wed, Oct 16, 2019 at 09:50:19PM +0900, Namhyung Kim wrote:
> > diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index 6ebae6bbe6a5..f2e54532c110 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -618,10 +618,10 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
> >                                            struct kernfs_node *parent,
> >                                            const char *name, umode_t mode,
> >                                            kuid_t uid, kgid_t gid,
> > +                                          u32 gen, int ino,
>
> Shouldn't this be ino_t so that we can use 64bit uniq id as ino
> directly where possible?  Also, it might make more sense if ino comes
> before gen.

Will change the order.

>
> > @@ -635,11 +635,24 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
> >
> >       idr_preload(GFP_KERNEL);
> >       spin_lock(&kernfs_idr_lock);
> > -     cursor = idr_get_cursor(&root->ino_idr);
> > -     ret = idr_alloc_cyclic(&root->ino_idr, kn, 1, 0, GFP_ATOMIC);
> > -     if (ret >= 0 && ret < cursor)
> > -             root->next_generation++;
> > -     gen = root->next_generation;
> > +
> > +     if (ino == 0) {
> > +             cursor = idr_get_cursor(&root->ino_idr);
> > +             ret = idr_alloc_cyclic(&root->ino_idr, kn, 1, 0, GFP_ATOMIC);
> > +             if (ret >= 0 && ret < cursor)
> > +                     root->next_generation++;
> > +             gen = root->next_generation;
> > +     } else {
> > +             ret = idr_alloc(&root->ino_idr, kn, ino, ino + 1, GFP_ATOMIC);
> > +             if (ret != ino) {
> > +                     WARN_ONCE(1, "kernfs ino was used: %d", ino);
> > +                     ret = -EINVAL;
> > +             } else {
> > +                     WARN_ON(root->next_generation > gen);
> > +                     root->next_generation = gen;
> > +             }
> > +     }
>
> Oh, I see, so the code is still depending on idr and thus the use of
> 32bit ino.  Hmm....

Right.

>
> >  static inline struct kernfs_node *
> > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > index 44c67d26c1fe..13d0d181a9f8 100644
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -3916,16 +3916,22 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
> >       char name[CGROUP_FILE_NAME_MAX];
> >       struct kernfs_node *kn;
> >       struct lock_class_key *key = NULL;
> > +     struct cgroup_root *root = cgrp->root;
> > +     int ino, gen;
> >       int ret;
> >
> >  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> >       key = &cft->lockdep_key;
> >  #endif
> > +
> > +     ino = cgroup_idr_alloc(&root->cgroup_idr, NULL, false, GFP_KERNEL);
> > +     gen = root->cgroup_idr.generation;
> > +
> >       kn = __kernfs_create_file(cgrp->kn, cgroup_file_name(cgrp, cft, name),
> >                                 cgroup_file_mode(cft),
> >                                 GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
> >                                 0, cft->kf_ops, cft,
> > -                               NULL, key);
> > +                               NULL, key, gen, ino);
>
> Can we move this to a separate patch so that this patch can be an
> identity conversion?

Will do.

Thanks
Namhyung
