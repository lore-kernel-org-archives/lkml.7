Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC92C04E87
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B12B20644
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1tfe5A9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfESRcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:32:02 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37645 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfESRcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:32:01 -0400
Received: by mail-qt1-f194.google.com with SMTP id o7so13764496qtp.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 10:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xd/j2bFTFqvTkhoe0dY27U0vgyUtV1T98XiRQZuV78o=;
        b=X1tfe5A90x6J5V4+wVqHQimvtvECfIyQ1m7PveGOvsG/VqCe+kmo27BWVjB58gA+Wt
         UU6QiA5sVlMIie9hU0PZfiEbYBsTAw3RiuusnjaHar3uOtbL4co7CwVmGY/LsvVZPc0x
         fdrbpulN85v4u+GKt+e+O/uB4hJO3CE6ICCWCr9EXK2+qajhYxWXZM7O6AL1WzI3v31k
         H5F2EB2iVCCmDmB4q62TrrKC1QmmH6QUajYzafenWm5+ZZBhz6OQwcO1GQunln94GJ+O
         aKiI83p7G21ObFabwIj4UKmi5QZcr85FT7nf3os45NkWsOj7M1FkcMq2g/sGMyn3xNsZ
         SO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xd/j2bFTFqvTkhoe0dY27U0vgyUtV1T98XiRQZuV78o=;
        b=Qp7/Ui6ZS6/+xfbXjK5wCxjdOZXDdjtLsa3Ue+BV05qFdN/PzoK61wmACsX/dZ4lLZ
         dP+9opaJftswEYOnXetPoYUtEPihpjfZlBmKSlrHbvFn1K7jLsRzQA6dMQoow8UmE/FG
         X4H7iDQjlTK3RVycOp9eg+ie9JxDR1NS6pULFDdWE2FOaOzPlRU0qjLO+PEeJPMFL9LW
         L6iaDwj+lg/WvsB3q/JQW2aA33aspjBV+dcNIXy7bU3VKyWlQBZz80p/41SC0a0OZqa8
         HTwz5yeuaCda+WhuWEZimNdUSDbmwJJUiZD81K43k9thhAJ/wNhTuaGXW8oV8W2TIhCW
         +YZA==
X-Gm-Message-State: APjAAAXw0Q2ZVULrkbH/aB5CYRXW6yAGQZXOg9EJvVW2aJgnLqLIKwe5
        Ap2Q8T9ygZjTbjF0MPNce/NzrPpQzNpPZNTireg=
X-Google-Smtp-Source: APXvYqzXDx3NLiybo6NRxAHAzaM+6GWVTQUIcE1VaLVGLZadSNyE9hmcJBInctQqW26CkCTb4sli09T8U1Zii3P+SJU=
X-Received: by 2002:ac8:3862:: with SMTP id r31mr58971037qtb.26.1558287120129;
 Sun, 19 May 2019 10:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190426022554.56393-1-yuchao0@huawei.com>
In-Reply-To: <20190426022554.56393-1-yuchao0@huawei.com>
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Mon, 20 May 2019 02:31:49 +0900
Message-ID: <CAD14+f0f9fKMmzNYXzoPD9W5CrECwvmGLi2a8EphfyZhTPjvnA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: relocate chksum_offset for
 large_nat_bitmap feature
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk and Chao,

I was semi-forced today to use the new kernel and test f2fs.

My Ubuntu initramfs got a bit wonky and I had to boot into live CD and
fix some stuffs. The live CD was using 4.15 kernel, and just mounting
the f2fs partition there corrupted f2fs and my 4.19(with 5.1-rc1-4.19
f2fs-stable merged) refused to mount with "SIT is corrupted node"
message.

I used the latest f2fs-tools sent by Chao including "fsck.f2fs: fix to
repair cp_loads blocks at correct position"

It spit out 140M worth of output, but at least I didn't have to run it
twice. Everything returned "Ok" in the 2nd run.
The new log is at
http://arter97.com/f2fs/final

After fixing the image, I used my 4.19 kernel with 5.2-rc1-4.19
f2fs-stable merged and it mounted.

But, I got this:
[    1.047791] F2FS-fs (nvme0n1p3): layout of large_nat_bitmap is
deprecated, run fsck to repair, chksum_offset: 4092
[    1.081307] F2FS-fs (nvme0n1p3): Found nat_bits in checkpoint
[    1.161520] F2FS-fs (nvme0n1p3): recover fsync data on readonly fs
[    1.162418] F2FS-fs (nvme0n1p3): Mounted with checkpoint version = 761c7e00

But after doing a reboot, the message is gone:
[    1.098423] F2FS-fs (nvme0n1p3): Found nat_bits in checkpoint
[    1.177771] F2FS-fs (nvme0n1p3): recover fsync data on readonly fs
[    1.178365] F2FS-fs (nvme0n1p3): Mounted with checkpoint version = 761c7eda

I'm not exactly sure why the kernel detected that I'm still using the
old layout on the first boot. Maybe fsck didn't fix it properly, or
the check from the kernel is improper.

I also noticed that Jaegeuk sent v1 of this patch to upstream. (Maybe
that's why the kernel detected old layout?) Please send v2 to upstream
soon, as running older fsck will cause much more headaches.

Thanks.


On Fri, Apr 26, 2019 at 11:26 AM Chao Yu <yuchao0@huawei.com> wrote:
>
> For large_nat_bitmap feature, there is a design flaw:
>
> Previous:
>
> struct f2fs_checkpoint layout:
> +--------------------------+  0x0000
> | checkpoint_ver           |
> | ......                   |
> | checksum_offset          |------+
> | ......                   |      |
> | sit_nat_version_bitmap[] |<-----|-------+
> | ......                   |      |       |
> | checksum_value           |<-----+       |
> +--------------------------+  0x1000      |
> |                          |      nat_bitmap + sit_bitmap
> | payload blocks           |              |
> |                          |              |
> +--------------------------|<-------------+
>
> Obviously, if nat_bitmap size + sit_bitmap size is larger than
> MAX_BITMAP_SIZE_IN_CKPT, nat_bitmap or sit_bitmap may overlap
> checkpoint checksum's position, once checkpoint() is triggered
> from kernel, nat or sit bitmap will be damaged by checksum field.
>
> In order to fix this, let's relocate checksum_value's position
> to the head of sit_nat_version_bitmap as below, then nat/sit
> bitmap and chksum value update will become safe.
>
> After:
>
> struct f2fs_checkpoint layout:
> +--------------------------+  0x0000
> | checkpoint_ver           |
> | ......                   |
> | checksum_offset          |------+
> | ......                   |      |
> | sit_nat_version_bitmap[] |<-----+
> | ......                   |<-------------+
> |                          |              |
> +--------------------------+  0x1000      |
> |                          |      nat_bitmap + sit_bitmap
> | payload blocks           |              |
> |                          |              |
> +--------------------------|<-------------+
>
> Related report and discussion:
>
> https://sourceforge.net/p/linux-f2fs/mailman/message/36642346/
>
> Reported-by: Park Ju Hyung <qkrwngud825@gmail.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2:
> - improve hint message suggested by Ju Hyung.
> - move verification to f2fs_sanity_check_ckpt().
>  fs/f2fs/f2fs.h  |  4 +++-
>  fs/f2fs/super.c | 13 +++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 119bc5a9783e..aa71c1aa9eaa 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1909,9 +1909,11 @@ static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
>         int offset;
>
>         if (is_set_ckpt_flags(sbi, CP_LARGE_NAT_BITMAP_FLAG)) {
> +               unsigned int chksum_size = sizeof(__le32);
> +
>                 offset = (flag == SIT_BITMAP) ?
>                         le32_to_cpu(ckpt->nat_ver_bitmap_bytesize) : 0;
> -               return &ckpt->sit_nat_version_bitmap + offset;
> +               return &ckpt->sit_nat_version_bitmap + offset + chksum_size;
>         }
>
>         if (__cp_payload(sbi) > 0) {
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index fefc8cc6e756..22241bb866df 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2714,6 +2714,19 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
>                 return 1;
>         }
>
> +       if (__is_set_ckpt_flags(ckpt, CP_LARGE_NAT_BITMAP_FLAG)) {
> +               unsigned int chksum_offset;
> +
> +               chksum_offset = le32_to_cpu(ckpt->checksum_offset);
> +               if (chksum_offset != CP_MIN_CHKSUM_OFFSET) {
> +                       f2fs_msg(sbi->sb, KERN_WARNING,
> +                               "using deprecated layout of large_nat_bitmap, "
> +                               "please run fsck v1.13.0 or higher to repair, "
> +                               "chksum_offset: %u", chksum_offset);
> +                       return 1;
> +               }
> +       }
> +
>         if (unlikely(f2fs_cp_error(sbi))) {
>                 f2fs_msg(sbi->sb, KERN_ERR, "A bug case: need to run fsck");
>                 return 1;
> --
> 2.18.0.rc1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
