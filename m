Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56687C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D5F20848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2K5u0+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfDOLEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:04:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38256 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfDOLEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:04:32 -0400
Received: by mail-qt1-f194.google.com with SMTP id d13so18539347qth.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 04:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3TqFcWqXoSiXCLR4PSmxQUw0FwFcqtG3GY86OQIH+YQ=;
        b=V2K5u0+7fkacnueTk+B2AaQbKEGv18hQGRWA/lVjK1VB/RyQJXR1coHvYvKUxKLr5M
         PgbdPNgYfKKpSsuy/+Euqex/DdbNifK6Zj5zbhf7/Q/xI7k2OBLD6cff64Ea3YCMk6a5
         qyeyiTTwVSWWqbOXXzEbI2Royk7rCw/jtSPA4gcX2DMSu7MdM+gvCD0qBNLutxxBRt96
         4P4esrEw0nsVI8u++UYGbyu6FJ9KB/823UBuOgIeHYbJYPsAiUAvzCLNxCAHu7mjo4yQ
         RrWzos9ChhVNY/Mpjq5SBiJWNVZJt8WCaeoghI3JezyWT32NMq8QEQpGXZlnOqYEujpE
         9puA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3TqFcWqXoSiXCLR4PSmxQUw0FwFcqtG3GY86OQIH+YQ=;
        b=tBrZLwcRSwNhTD+K8CumPvznbycprTNh89owbbMm216i5vODrj+5cwgz5QEvmPSJ3y
         3xTvo2NCpmTCfzR4cHJGm8afW6VhoTCTY+T3qQF+7LuIRqH1QHvBMr97hNDwaiZ1aDu7
         TxV6aArYyN9pnqSMXtnPRd9lMdM4bsoq4JwL2TErSEox595ZbJXkSo0MgGA941Da8xSX
         EXkziS0IjrbNIOAbGJISLnN9/cEygspb0mAetLa9eiksbS7VmQWmHyWcTEa5Mb47VVi0
         d1jMhDHS4xKTzX5kq7EBZDzVkmbonrqsSsVNgRX8FGl7eiiUhSOztkZGChEMWoO95djQ
         oWbA==
X-Gm-Message-State: APjAAAUy0/uD5LVfzEumtTnzaEl987kjx73rmGSyCQrFLbv2LTjz+Q9X
        iwLpS1OHZZiMR8Gm8zzhtmAxbxayg835cVeaFQU=
X-Google-Smtp-Source: APXvYqwH8wD+AncjJl54cciKZyBQiuE/Kqymd4Qj1lAfxv4IaHlpE10Gwu/1DNPV0SvYYgMQRJTAbjQ6kK+9Hij2+QE=
X-Received: by 2002:a0c:d4a2:: with SMTP id u31mr60943733qvh.139.1555326270326;
 Mon, 15 Apr 2019 04:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190415073054.2577-1-yuchao0@huawei.com> <20190415073054.2577-5-yuchao0@huawei.com>
 <CAD14+f2uV6s6hBfQaQaJPBEAPVOFgEZfueuVPQ_43LpiWS9nZg@mail.gmail.com> <a77dc50c-01f0-459b-38de-50f97c129f31@huawei.com>
In-Reply-To: <a77dc50c-01f0-459b-38de-50f97c129f31@huawei.com>
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Mon, 15 Apr 2019 20:04:19 +0900
Message-ID: <CAD14+f2c7yYbc6hu2gWiHfRUrx0SctMZfc0+9HVk+_0UE+Mkug@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 13/13] f2fs: don't recovery orphan inode on
 readonly device
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the explanation.

And yes, this patch fixed it, the kernel log is now clean.

Thanks!

[   22.506553] F2FS-fs (loop0): write access unavailable, skipping
orphan cleanup
[   22.506555] F2FS-fs (loop0): recover fsync data on readonly fs
[   22.506556] F2FS-fs (loop0): quota file may be corrupted, skip loading it
[   22.507015] F2FS-fs (loop0): Mounted with checkpoint version = 26e7ba3e

On Mon, Apr 15, 2019 at 5:57 PM Chao Yu <yuchao0@huawei.com> wrote:
>
> On 2019/4/15 16:10, Ju Hyung Park wrote:
> > Hi,
> >
> > Thanks for the fix. I'll try this sooner than later.
> >
> > One minor request though, can you change
> > "JuHyung Park <qkrwngud825@gmail.com>"
> > to
> > "Park Ju Hyung <qkrwngud825@gmail.com>"?
> >
> > That's my preference and I'd like to avoid any inconsistencies.
>
> Sure, will update it in next version. :)
>
> >
> > One additional question from reviewing the code surrounding it:
> > does it really makes sense to cleanup orphan inodes even when the "ro"
> > mount option is passed?
> > It's an explicit request from the user not to write to the block device/image.
>
> Now, f2fs follows the rule that ext4 kept, you can check codes in
> ext4_orphan_cleanup()
>
>         if (bdev_read_only(sb->s_bdev)) {
>                 ext4_msg(sb, KERN_ERR, "write access "
>                         "unavailable, skipping orphan cleanup");
>                 return;
>         }
> ...
>         if (s_flags & SB_RDONLY) {
>                 ext4_msg(sb, KERN_INFO, "orphan cleanup on readonly fs");
>                 sb->s_flags &= ~SB_RDONLY;
>         }
>
> There are two points in above codes:
> - if block device is readonly, filesystem should not execute any recovery flow
> which can trigger write IO.
> - if filesystem was mounted as readonly one, and recovery is needed, it will
> ignore readonly flag and update data in device for journal recovery during mount.
>
> So IMO, readonly mountoption sematics is only try to restrict data/meta update
> behavior that is triggered by user from mountpoint, but filesystem still can do
> any updates on a writable device if it needs, mostly like recovery flow.
>
> Anyway, if you want to limit any updates on block device, making it readonly
> will be a good choice. :)
>
> Thanks,
>
> >
> > Thanks.
> >
> > On Mon, Apr 15, 2019 at 4:31 PM Chao Yu <yuchao0@huawei.com> wrote:
> >>
> >> As JuHyung Park reported in mailing list:
> >>
> >> https://sourceforge.net/p/linux-f2fs/mailman/message/36639787/
> >>
> >> generic_make_request: Trying to write to read-only block-device loop0 (partno 0)
> >> WARNING: CPU: 0 PID: 23437 at block/blk-core.c:2174 generic_make_request_checks+0x594/0x630
> >>
> >>  generic_make_request+0x46/0x3d0
> >>  submit_bio+0x30/0x110
> >>  __submit_merged_bio+0x68/0x390
> >>  f2fs_submit_page_write+0x1bb/0x7f0
> >>  f2fs_do_write_meta_page+0x7f/0x160
> >>  __f2fs_write_meta_page+0x70/0x140
> >>  f2fs_sync_meta_pages+0x140/0x250
> >>  f2fs_write_checkpoint+0x5c5/0x17b0
> >>  f2fs_sync_fs+0x9c/0x110
> >>  sync_filesystem+0x66/0x80
> >>  f2fs_recover_fsync_data+0x790/0xa30
> >>  f2fs_fill_super+0xe4e/0x1980
> >>  mount_bdev+0x518/0x610
> >>  mount_fs+0x34/0x13f
> >>  vfs_kern_mount.part.11+0x4f/0x120
> >>  do_mount+0x2d1/0xe40
> >>  __x64_sys_mount+0xbf/0xe0
> >>  do_syscall_64+0x4a/0xf0
> >>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >>
> >> print_req_error: I/O error, dev loop0, sector 4096
> >>
> >> If block device is readonly, we should never trigger write IO from
> >> filesystem layer, but previously, orphan recovery didn't consider
> >> such condition, result in triggering above warning, fix it.
> >>
> >> Reported-by: JuHyung Park <qkrwngud825@gmail.com>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/checkpoint.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> >> index a7ad1b1e5750..90e1bab86269 100644
> >> --- a/fs/f2fs/checkpoint.c
> >> +++ b/fs/f2fs/checkpoint.c
> >> @@ -674,6 +674,12 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
> >>         if (!is_set_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG))
> >>                 return 0;
> >>
> >> +       if (bdev_read_only(sbi->sb->s_bdev)) {
> >> +               f2fs_msg(sbi->sb, KERN_INFO, "write access "
> >> +                       "unavailable, skipping orphan cleanup");
> >> +               return 0;
> >> +       }
> >> +
> >>         if (s_flags & SB_RDONLY) {
> >>                 f2fs_msg(sbi->sb, KERN_INFO, "orphan cleanup on readonly fs");
> >>                 sbi->sb->s_flags &= ~SB_RDONLY;
> >> --
> >> 2.18.0.rc1
> >>
> >>
> >>
> >> _______________________________________________
> >> Linux-f2fs-devel mailing list
> >> Linux-f2fs-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > .
> >
