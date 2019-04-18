Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0DFC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BEBA20652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdWluM1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389145AbfDRN3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:29:03 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35402 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388263AbfDRN3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:29:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id h39so2145204qte.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 06:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C/CTVl5mn6QIzCiB3sGUbm1tDaVx3TG2wl3p3rrYOOg=;
        b=cdWluM1MaAwo7AKcKnKXpXZftFyyVPJzoE4TToByXdsQ6k2nXAbggNZLrLwUusfz9e
         kU5HIlo7GZfK8Ao3TGIIgBdpPCPdj0o5zKY22+Tts39R60SVe3Cf8mjbT1saCKuQ0UIu
         tE58WZsaN6Ype/r34FiJPCovxNFI1sazfSXsfE8ECO5SahD0jNIxXE2cFViU0HfApzUG
         q+EXWgYZwkRf/7fYQ3NQeIHXjQ90OZc3ZnxJ58EEHVKiWEv2FRpv2+zudXTSbQge46ur
         WKGHAuSlcDy5xkF5LWodI4KcFV044sbhsAleQV6FrCd7yfraoc3z1mghdLPiKHuiZLPt
         aaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C/CTVl5mn6QIzCiB3sGUbm1tDaVx3TG2wl3p3rrYOOg=;
        b=WMeDm9NAhJNtWE2JpBqCGDEqofL7hbqLzfOd/3f4IG6f6zhlgT4tIAUNenO0C8WuuB
         v/NA+K/zEnKi9jJob6WGX52PrRxzxfZkdAjyJCGBIpIDTlcq9QNl/6V8N9gqBxjl8qZc
         tSBygLlcBasZ5uREk6hoaCoPOCTVRx75bdgsQNuyNtnkBKWBOMvvXGFWNaLUN7dUlykH
         NVjErl8gB3jA4hXnZc7caUZNAfpb0EDH81Xs8bxvSUL4WArQ4LPPxeYVy3LxsLB1tSAC
         z4izgufNV18slNs3aunz207aKd/gpsGdv73BPHJkOfakbF22NAtGzDn3YfeyqC4bASNH
         nUbg==
X-Gm-Message-State: APjAAAU1dw9uwAMHqfONieSi4LSkoWlnT0QzkIhR6t4TF8j7TFwHnU/L
        Q9S4kExehIgMn+bfSNxN4gm0+SmLuwAPZk1h0HA=
X-Google-Smtp-Source: APXvYqxJK2xpaMO778a6btMLWISCI3qZ77GsnjIBW0aS9EC3s5AeqKhPreI3EhRdl59eDKh0cUR1H7RRlD3wBTu6l3I=
X-Received: by 2002:ac8:950:: with SMTP id z16mr75202454qth.16.1555594141910;
 Thu, 18 Apr 2019 06:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190415113933.21621-1-yuchao0@huawei.com>
In-Reply-To: <20190415113933.21621-1-yuchao0@huawei.com>
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Thu, 18 Apr 2019 22:28:50 +0900
Message-ID: <CAD14+f1ZLcU=f2odX-ufGDbgHmt0Cb4fO4bUfXqNXGSdYOGgeg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2 13/13] f2fs: don't recovery orphan inode on
 readonly device
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

Probably unrelated but a similar issue:
Warning appears upon unmounting a corrupted R/O f2fs loop image.

Should be a trivial issue to fix as well :)

[ 2373.758424] ------------[ cut here ]------------
[ 2373.758428] generic_make_request: Trying to write to read-only
block-device loop1 (partno 0)
[ 2373.758455] WARNING: CPU: 1 PID: 13950 at block/blk-core.c:2174
generic_make_request_checks+0x590/0x630
[ 2373.758556] CPU: 1 PID: 13950 Comm: umount Tainted: G           O
   4.19.35-zen+ #1
[ 2373.758558] Hardware name: System manufacturer System Product
Name/ROG MAXIMUS X HERO (WI-FI AC), BIOS 1704 09/14/2018
[ 2373.758564] RIP: 0010:generic_make_request_checks+0x590/0x630
[ 2373.758567] Code: 5c 03 00 00 48 8d 74 24 08 48 89 df c6 05 b5 cd
36 01 01 e8 c2 90 01 00 48 89 c6 44 89 ea 48 c7 c7 98 64 59 82 e8 d5
9b a7 ff <0f> 0b 48 8b 7b 08 e9 f2 fa ff ff 41 8b 86 98 02 00 00 49 8b
16 89
[ 2373.758570] RSP: 0018:ffff8882bdb43950 EFLAGS: 00010282
[ 2373.758573] RAX: 0000000000000050 RBX: ffff8887244c6700 RCX: 0000000000000006
[ 2373.758575] RDX: 0000000000000007 RSI: 0000000000000086 RDI: ffff88884ec56340
[ 2373.758577] RBP: ffff888849c426c0 R08: 0000000000000004 R09: 00000000000003ba
[ 2373.758579] R10: 0000000000000001 R11: 0000000000000029 R12: 0000000000001000
[ 2373.758581] R13: 0000000000000000 R14: ffff888844a2e800 R15: ffff8882bdb43ac0
[ 2373.758584] FS:  00007fc0d114f8c0(0000) GS:ffff88884ec40000(0000)
knlGS:0000000000000000
[ 2373.758586] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2373.758588] CR2: 00007fc0d1ad12c0 CR3: 00000002bdb82003 CR4: 00000000003606e0
[ 2373.758590] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2373.758592] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2373.758593] Call Trace:
[ 2373.758602]  ? generic_make_request+0x46/0x3d0
[ 2373.758608]  ? wait_woken+0x80/0x80
[ 2373.758612]  ? mempool_alloc+0xb7/0x1a0
[ 2373.758618]  ? submit_bio+0x30/0x110
[ 2373.758622]  ? bvec_alloc+0x7c/0xd0
[ 2373.758628]  ? __submit_merged_bio+0x68/0x390
[ 2373.758633]  ? f2fs_submit_page_write+0x1bb/0x7f0
[ 2373.758638]  ? f2fs_do_write_meta_page+0x7f/0x160
[ 2373.758642]  ? __f2fs_write_meta_page+0x70/0x140
[ 2373.758647]  ? f2fs_sync_meta_pages+0x140/0x250
[ 2373.758653]  ? f2fs_write_checkpoint+0x5c5/0x17b0
[ 2373.758657]  ? f2fs_sync_fs+0x9c/0x110
[ 2373.758664]  ? sync_filesystem+0x66/0x80
[ 2373.758667]  ? generic_shutdown_super+0x1d/0x100
[ 2373.758670]  ? kill_block_super+0x1c/0x40
[ 2373.758674]  ? kill_f2fs_super+0x64/0xb0
[ 2373.758678]  ? deactivate_locked_super+0x2d/0xb0
[ 2373.758682]  ? cleanup_mnt+0x65/0xa0
[ 2373.758688]  ? task_work_run+0x7f/0xa0
[ 2373.758693]  ? exit_to_usermode_loop+0x9c/0xa0
[ 2373.758698]  ? do_syscall_64+0xc7/0xf0
[ 2373.758703]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2373.758706] ---[ end trace 5d3639907c56271b ]---
[ 2373.758780] print_req_error: I/O error, dev loop1, sector 143048
[ 2373.758800] print_req_error: I/O error, dev loop1, sector 152200
[ 2373.758808] print_req_error: I/O error, dev loop1, sector 8192
[ 2373.758819] print_req_error: I/O error, dev loop1, sector 12272

Thanks.

On Mon, Apr 15, 2019 at 8:40 PM Chao Yu <yuchao0@huawei.com> wrote:
>
> As Park Ju Hyung reported in mailing list:
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
> Reported-by: Park Ju Hyung <qkrwngud825@gmail.com>
> Tested-by: Park Ju Hyung <qkrwngud825@gmail.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2:
> - adjust Park's first/last name order.
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
