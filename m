Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF01AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D51C206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0KcyVCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfDOIKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:10:35 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39993 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfDOIKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:10:34 -0400
Received: by mail-qk1-f196.google.com with SMTP id w20so9289616qka.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 01:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=usx/bJaMhT9Xd427rTsoAeZAG2JpYIEnOVZk4zttm+0=;
        b=f0KcyVCIyaqc6ng+6BtiL8IRWb2m7opi1KsZ67t9VKOqAMwYldEn6I5ApRhX464n18
         nJcETufBLMalh1gpgq0AMaGv5TGO40QW/J9H03vxIE5EfUoTgx/MN1IWciOe7cQsm4No
         Wiznp1KCH2O/jbbOu9QOS+n6lguPxzGwkLa2We8vEWO8fJRtbKM3WxMewupQbcNv0vGn
         Jn8NECnCJL9IRLLVM8olNLJMGMqFeMOZIqxdHtx6LOgGzx4m7O3Oa99HWLpfysju0wDK
         F7lxeg+4fNHZgHgn62QZF0M9n15NDuwQgwaYd17PoNTcfDCNRYZZILhspsHLibSO7TkB
         Af1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=usx/bJaMhT9Xd427rTsoAeZAG2JpYIEnOVZk4zttm+0=;
        b=FEXUV3l5fEOOyHIRj3ykpRVGYGCowKyhm2S/nt/Ev5leODydekBwtoJvg88QeWHwZc
         VPc9FDJ8WiH9N/hEp6CJxL7Suaa0lqY882Ez79eEemFTPlvA4TQZli63sUG5zwFaFMU1
         8cnqmhaPDi7EUF6fJvGEkqxqH7gNhtPchk8S4SiCbB5l1SLBIS1uxvSBAIh5VpJVi3Ud
         xGsr96lzm1SicXxC+fmknjZTMMwoyGB+VAA210ExZBn7IQurDRGxmcKwg61IKX19H0X5
         vV/CHTxUK+umBpw7mkay+a6Y3LUSMag2YICbiqBfBnqpt99pH8LPVI7Z4KY4Df1VbfEY
         L0hw==
X-Gm-Message-State: APjAAAUz3BBKGwZI8W6LnQkmZKDyi6alJLAxJUhzWy/TgE/07LpKQ6sb
        mSs/kKF7qlpw2fJAyRcUlrl6lcAquhLQAAEtk70=
X-Google-Smtp-Source: APXvYqwN2zm2D9pX6jJ9XK2Ra0ZKvdra+YNHrQ4qTwUZVP7ejF5ja2KOAQqvRVl+Y+Wv3E744kdwisLdMFWFAP+O6CU=
X-Received: by 2002:a05:620a:15e7:: with SMTP id p7mr53688970qkm.283.1555315833575;
 Mon, 15 Apr 2019 01:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190415073054.2577-1-yuchao0@huawei.com> <20190415073054.2577-5-yuchao0@huawei.com>
In-Reply-To: <20190415073054.2577-5-yuchao0@huawei.com>
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Mon, 15 Apr 2019 17:10:22 +0900
Message-ID: <CAD14+f2uV6s6hBfQaQaJPBEAPVOFgEZfueuVPQ_43LpiWS9nZg@mail.gmail.com>
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

Hi,

Thanks for the fix. I'll try this sooner than later.

One minor request though, can you change
"JuHyung Park <qkrwngud825@gmail.com>"
to
"Park Ju Hyung <qkrwngud825@gmail.com>"?

That's my preference and I'd like to avoid any inconsistencies.

One additional question from reviewing the code surrounding it:
does it really makes sense to cleanup orphan inodes even when the "ro"
mount option is passed?
It's an explicit request from the user not to write to the block device/image.

Thanks.

On Mon, Apr 15, 2019 at 4:31 PM Chao Yu <yuchao0@huawei.com> wrote:
>
> As JuHyung Park reported in mailing list:
>
> https://sourceforge.net/p/linux-f2fs/mailman/message/36639787/
>
> generic_make_request: Trying to write to read-only block-device loop0 (partno 0)
> WARNING: CPU: 0 PID: 23437 at block/blk-core.c:2174 generic_make_request_checks+0x594/0x630
>
>  generic_make_request+0x46/0x3d0
>  submit_bio+0x30/0x110
>  __submit_merged_bio+0x68/0x390
>  f2fs_submit_page_write+0x1bb/0x7f0
>  f2fs_do_write_meta_page+0x7f/0x160
>  __f2fs_write_meta_page+0x70/0x140
>  f2fs_sync_meta_pages+0x140/0x250
>  f2fs_write_checkpoint+0x5c5/0x17b0
>  f2fs_sync_fs+0x9c/0x110
>  sync_filesystem+0x66/0x80
>  f2fs_recover_fsync_data+0x790/0xa30
>  f2fs_fill_super+0xe4e/0x1980
>  mount_bdev+0x518/0x610
>  mount_fs+0x34/0x13f
>  vfs_kern_mount.part.11+0x4f/0x120
>  do_mount+0x2d1/0xe40
>  __x64_sys_mount+0xbf/0xe0
>  do_syscall_64+0x4a/0xf0
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> print_req_error: I/O error, dev loop0, sector 4096
>
> If block device is readonly, we should never trigger write IO from
> filesystem layer, but previously, orphan recovery didn't consider
> such condition, result in triggering above warning, fix it.
>
> Reported-by: JuHyung Park <qkrwngud825@gmail.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/checkpoint.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index a7ad1b1e5750..90e1bab86269 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -674,6 +674,12 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
>         if (!is_set_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG))
>                 return 0;
>
> +       if (bdev_read_only(sbi->sb->s_bdev)) {
> +               f2fs_msg(sbi->sb, KERN_INFO, "write access "
> +                       "unavailable, skipping orphan cleanup");
> +               return 0;
> +       }
> +
>         if (s_flags & SB_RDONLY) {
>                 f2fs_msg(sbi->sb, KERN_INFO, "orphan cleanup on readonly fs");
>                 sbi->sb->s_flags &= ~SB_RDONLY;
> --
> 2.18.0.rc1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
