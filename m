Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BDAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93A02085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br4hP5Ua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfCNMBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:01:32 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40296 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfCNMBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:01:32 -0400
Received: by mail-yw1-f68.google.com with SMTP id p64so858581ywg.7;
        Thu, 14 Mar 2019 05:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oZODocrUkC0mLZGDSWfLaCUM33i+j2tcUizSAEEaLRc=;
        b=Br4hP5Uacmm/icfrIayICNRzoTe/p/6W0nDjvTJ5XMYcS5vfFQN/RFF/TxGQPAvQFm
         Y6nhCWwy2IJQn2DCnQf5DSuUONDnrxcIjvd/uYcDp8twRBjJZ39wVPtkxE6Okva/yFf3
         KkJyd70BiNVQ7Wqjatg8xQGrytY4qPwZzJVJjL1ZtqBKYGiWf6J5dVBVmyM9DNCRkq3e
         Z/JXGUvQpiZN4maLB86+iv2s5Lwcutq8mMoZ9aXGjui+hWkvRWOCg0r4cIMNVZewSw4x
         7QypDrcTk3cpB34yTRl0d/hG3G1Vb2sKVDZUpZBObKIHV2imymFiBr4ZygxiZeSbZBsD
         bi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZODocrUkC0mLZGDSWfLaCUM33i+j2tcUizSAEEaLRc=;
        b=JgyW6MlTF+jPeUixkfKDU3A/q7nk7XOkxnE8BjaGH+SXk94NTPJCei/FBbclhAwIvW
         sqZXTXiV0FOBZw1UyKTd6EFPs3OGXUCzei4rD8b96c/x5+jamZyuLQYVJbyihb5Iocb8
         AS9Ge7d5IZxitRoA4nunURBOYhurVuNeb5RSFtu0yLJA8WUmbMW/XOe5iIds+AHykA4n
         Cp3bKHfg+DJ2ee4kATLz4NNd4uiz2w/hC1J0bQuQJ7mkq3yR+8SAvQzz7wPvifs5ZxCK
         cT4UUyH3Icx53DeUztUa8cGT8ulKvHGaYrC32jPf2V3SwjBhOjlkneNNPvLkUuI15j7d
         18rA==
X-Gm-Message-State: APjAAAX18RLGe8vihNZ3QUG3toLupZOkAz9s/ngjrnu7r6R70+B0U41x
        kupykLwgHpsOG0COFNYf8p/5UfbJ1WBlq/hKKhUqkWNQjrw=
X-Google-Smtp-Source: APXvYqw5EwIiQtYe8ROjqHiWq/TDxVaejDtC4cqkyTeD4N7XHVRhWDHSlumL83Ib+ALybkhz0PHoiMSX1EKXR2zr5U0=
X-Received: by 2002:a25:4643:: with SMTP id t64mr41676114yba.462.1552564890316;
 Thu, 14 Mar 2019 05:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <201903140234.4FpTWdW3%lkp@intel.com> <20190314083758.GA16658@quack2.suse.cz>
In-Reply-To: <20190314083758.GA16658@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 14 Mar 2019 14:01:18 +0200
Message-ID: <CAOQ4uxhZH9=U63J1_bVrMbNO-Quy-8S300Qi6VmZxvKwYCogQQ@mail.gmail.com>
Subject: Re: fs/notify/fanotify/fanotify.c:198:2: note: in expansion of macro 'pr_warn_ratelimited'
To:     Jan Kara <jack@suse.cz>
Cc:     kbuild-all@01.org, linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 10:37 AM Jan Kara <jack@suse.cz> wrote:
>
> AFAICS this is the known problem with weird mips definitions of
> __kernel_fsid_t which uses long whereas all other architectures use int,
> right? Seeing that mips can actually have 8-byte longs, I guess this
> bogosity is just wired in the kernel API and we cannot easily fix it in
> mips (mips guys, correct me if I'm wrong). So what if we just
> unconditionally typed printed values to unsigned int to silence the
> warning?

I don't understand why. To me that sounds like papering over a bug.

See this reply from mips developer Paul Burton:
https://marc.info/?l=linux-fsdevel&m=154783680019904&w=2
mips developers have not replied to the question why __kernel_fsid_t
should use long.

My concern is that we expose __kernel_fsid_t type in uapi header
in struct fanotify_event_info_fid. We should make sure this type
is consistent with glibc's fsid_t.

For reference, the statfs(2) man page says that on Linux
"...fsid_t is defined as struct { int val[2]; }".

Besides, it looks like __kernel_fsid_t got let behind on the
mips posix_types cleanup:
bb8ac181a5cf bury __kernel_nlink_t, make internal nlink_t consistent
86fcd10e9a57 mips: Use generic posix_types.h

To me this seems like an issue that mips developers should
advise on the solution.

Thanks,
Amir.

>
>                                                                 Honza
>
> On Thu 14-03-19 02:31:52, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   5453a3df2a5eb49bc24615d4cf0d66b2aae05e5f
> > commit: e9e0c8903009477b630e37a8b6364b26a00720da fanotify: encode file identifier for FAN_REPORT_FID
> > date:   5 weeks ago
> > config: mips-allmodconfig (attached as .config)
> > compiler: mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout e9e0c8903009477b630e37a8b6364b26a00720da
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.2.0 make.cross ARCH=mips
> >
> > All warnings (new ones prefixed by >>):
> >
> >    In file included from include/linux/kernel.h:14:0,
> >                     from include/linux/list.h:9,
> >                     from include/linux/preempt.h:11,
> >                     from include/linux/spinlock.h:51,
> >                     from include/linux/fdtable.h:11,
> >                     from fs/notify/fanotify/fanotify.c:3:
> >    fs/notify/fanotify/fanotify.c: In function 'fanotify_encode_fid':
> >    include/linux/kern_levels.h:5:18: warning: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'long int' [-Wformat=]
> >     #define KERN_SOH "\001"  /* ASCII Start Of Header */
> >                      ^
> >    include/linux/printk.h:424:10: note: in definition of macro 'printk_ratelimited'
> >       printk(fmt, ##__VA_ARGS__);    \
> >              ^~~
> >    include/linux/kern_levels.h:12:22: note: in expansion of macro 'KERN_SOH'
> >     #define KERN_WARNING KERN_SOH "4" /* warning conditions */
> >                          ^~~~~~~~
> >    include/linux/printk.h:440:21: note: in expansion of macro 'KERN_WARNING'
> >      printk_ratelimited(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
> >                         ^~~~~~~~~~~~
> > >> fs/notify/fanotify/fanotify.c:198:2: note: in expansion of macro 'pr_warn_ratelimited'
> >      pr_warn_ratelimited("fanotify: failed to encode fid (fsid=%x.%x, "
> >      ^~~~~~~~~~~~~~~~~~~
> >    fs/notify/fanotify/fanotify.c:198:61: note: format string is defined here
> >      pr_warn_ratelimited("fanotify: failed to encode fid (fsid=%x.%x, "
> >                                                                ~^
> >                                                                %lx
> >    In file included from include/linux/kernel.h:14:0,
> >                     from include/linux/list.h:9,
> >                     from include/linux/preempt.h:11,
> >                     from include/linux/spinlock.h:51,
> >                     from include/linux/fdtable.h:11,
> >                     from fs/notify/fanotify/fanotify.c:3:
> >    include/linux/kern_levels.h:5:18: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'long int' [-Wformat=]
> >     #define KERN_SOH "\001"  /* ASCII Start Of Header */
> >                      ^
> >    include/linux/printk.h:424:10: note: in definition of macro 'printk_ratelimited'
> >       printk(fmt, ##__VA_ARGS__);    \
> >              ^~~
> >    include/linux/kern_levels.h:12:22: note: in expansion of macro 'KERN_SOH'
> >     #define KERN_WARNING KERN_SOH "4" /* warning conditions */
> >                          ^~~~~~~~
> >    include/linux/printk.h:440:21: note: in expansion of macro 'KERN_WARNING'
> >      printk_ratelimited(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
> >                         ^~~~~~~~~~~~
> > >> fs/notify/fanotify/fanotify.c:198:2: note: in expansion of macro 'pr_warn_ratelimited'
> >      pr_warn_ratelimited("fanotify: failed to encode fid (fsid=%x.%x, "
> >      ^~~~~~~~~~~~~~~~~~~
> >    fs/notify/fanotify/fanotify.c:198:64: note: format string is defined here
> >      pr_warn_ratelimited("fanotify: failed to encode fid (fsid=%x.%x, "
> >                                                                   ~^
> >                                                                   %lx
> >
> > vim +/pr_warn_ratelimited +198 fs/notify/fanotify/fanotify.c
> >
> >    154
> >    155        static int fanotify_encode_fid(struct fanotify_event *event,
> >    156                                       const struct path *path, gfp_t gfp)
> >    157        {
> >    158                struct fanotify_fid *fid = &event->fid;
> >    159                int dwords, bytes = 0;
> >    160                struct kstatfs stat;
> >    161                int err, type;
> >    162
> >    163                stat.f_fsid.val[0] = stat.f_fsid.val[1] = 0;
> >    164                fid->ext_fh = NULL;
> >    165                dwords = 0;
> >    166                err = -ENOENT;
> >    167                type = exportfs_encode_inode_fh(d_inode(path->dentry), NULL, &dwords,
> >    168                                                NULL);
> >    169                if (!dwords)
> >    170                        goto out_err;
> >    171
> >    172                err = vfs_statfs(path, &stat);
> >    173                if (err)
> >    174                        goto out_err;
> >    175
> >    176                bytes = dwords << 2;
> >    177                if (bytes > FANOTIFY_INLINE_FH_LEN) {
> >    178                        /* Treat failure to allocate fh as failure to allocate event */
> >    179                        err = -ENOMEM;
> >    180                        fid->ext_fh = kmalloc(bytes, gfp);
> >    181                        if (!fid->ext_fh)
> >    182                                goto out_err;
> >    183                }
> >    184
> >    185                type = exportfs_encode_inode_fh(d_inode(path->dentry),
> >    186                                                fanotify_fid_fh(fid, bytes), &dwords,
> >    187                                                NULL);
> >    188                err = -EINVAL;
> >    189                if (!type || type == FILEID_INVALID || bytes != dwords << 2)
> >    190                        goto out_err;
> >    191
> >    192                fid->fsid = stat.f_fsid;
> >    193                event->fh_len = bytes;
> >    194
> >    195                return type;
> >    196
> >    197        out_err:
> >  > 198                pr_warn_ratelimited("fanotify: failed to encode fid (fsid=%x.%x, "
> >    199                                    "type=%d, bytes=%d, err=%i)\n",
> >    200                                    stat.f_fsid.val[0], stat.f_fsid.val[1],
> >    201                                    type, bytes, err);
> >    202                kfree(fid->ext_fh);
> >    203                fid->ext_fh = NULL;
> >    204                event->fh_len = 0;
> >    205
> >    206                return FILEID_INVALID;
> >    207        }
> >    208
> >
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology Center
> > https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
