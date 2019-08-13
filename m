Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858DDC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F560206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVbPiymk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfHMViV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:38:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35014 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfHMViV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:38:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so2688616wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 14:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPqZmEUP+OCmd1zB4XrRpQqFSNaRPFjphn5AyHf/W4c=;
        b=hVbPiymkiv59P7I9Izziyl7CrbyvNYc3fv4pVc1WuPgaq39dWUbX+I9IUz3RbFVQ0K
         xldm0LGnNWLsSJRwfLK8Q9TLst4LWCB9BgV76Q3ly+mi2WX2mhrrGXCaV0th/wh3cq06
         4OdC24uGCz+BiXf+fYd6NpJ1p1v0Kr5vzzd2Ysi7sJ8zZODnW+6R9tqijRlgDc5ReHFr
         fI2d8nW26Qr79AeUQDESX6bEcadgoduHn0+bZBmEXZPgF6NobyfGyz9dAC8CaKReXEc+
         V5UFFdTGaJfgy+n/SFDR5T83VViKsJx0EZ7opBNdBQqu8wS8OS7XujXEhpSH0Vshbywy
         7mAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPqZmEUP+OCmd1zB4XrRpQqFSNaRPFjphn5AyHf/W4c=;
        b=XFGrEcZlKNC/UON7k/1A8I/dY6Tp8Uao3Unjrm4BxxD6dwJ2ZPXCYhY1x6ronLFvAQ
         ikpm7P7YDN6EESqogP81oWvD4iQtvdKpjWsPjZXSxalcsx4q7+eXQ6X6xZ0IjouQs9B7
         +x4QQMfFhgWEfY82ohGCNFL1CJfduKSh1I0rf9+HvPnFvxbGUmXeX5FV+gmuX8jqFmvQ
         1Z+zy1uI2KActF3VSowtmPVUxThCLf47JOLMZTbo/3jak1QLQ2UM32ibYtjdYBMCPVr/
         YwyVAsiM90XtTd0BWC0MXrUdFwkPTtgX+S+FZcmM9bgbuPbKjE7Bzzs2CWzn4g+JzRlQ
         BKxA==
X-Gm-Message-State: APjAAAUsXVYATJll+NTpsk1wKpijnonFI6DrhaHkePIXX1ADLjVN/RjO
        UwdJ+9bAoBa16ek7ffJTTofRJwP4UCtoT0FceEo=
X-Google-Smtp-Source: APXvYqwvvWTtS3T/7ubA6lTx2mfmOnYn4Fn0A685ouv4FtXe9gICxk42c5HllO89PO9U+xLY3vmztsutJ0NFhk4wN8o=
X-Received: by 2002:a1c:9e4d:: with SMTP id h74mr5197971wme.9.1565732299027;
 Tue, 13 Aug 2019 14:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <1565431061-145460-1-git-send-email-chengzhihao1@huawei.com>
In-Reply-To: <1565431061-145460-1-git-send-email-chengzhihao1@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 13 Aug 2019 23:38:07 +0200
Message-ID: <CAFLxGvzOMfqJJ+ZKTUavxEx+0_OJO_VcrNu1nn2rrvcypAxAAA@mail.gmail.com>
Subject: Re: [PATCH RFC v2] ubi: ubi_wl_get_peb: Increase the number of
 attempts while getting PEB
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Richard Weinberger <richard@nod.at>, yi.zhang@huawei.com,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 11:51 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>
> Running stress test io_paral (A pressure ubi test in mtd-utils) on an
> UBI device with fewer PEBs (fastmap enabled) may cause ENOSPC errors and
> make UBI device read-only, but there are still free PEBs on the UBI
> device. This problem can be easily reproduced by performing the following
> steps on a 2-core machine:
>   $ modprobe nandsim first_id_byte=0x20 second_id_byte=0x33 parts=80
>   $ modprobe ubi mtd="0,0" fm_autoconvert
>   $ ./io_paral /dev/ubi0
>
> We may see the following verbose:
> (output)
>   [io_paral] update_volume():108: failed to write 380 bytes at offset
>   95920 of volume 2
>   [io_paral] update_volume():109: update: 97088 bytes
>   [io_paral] write_thread():227: function pwrite() failed with error 28
>   (No space left on device)
>   [io_paral] write_thread():229: cannot write 15872 bytes to offs 31744,
>   wrote -1
> (dmesg)
>   ubi0 error: ubi_wl_get_peb [ubi]: Unable to get a free PEB from user WL
>   pool
>   ubi0 warning: ubi_eba_write_leb [ubi]: switch to read-only mode
>   CPU: 0 PID: 2027 Comm: io_paral Not tainted 5.3.0-rc2-00001-g5986cd0 #9
>   ubi0 warning: try_write_vid_and_data [ubi]: failed to write VID header
>   to LEB 2:5, PEB 18
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0
>   -0-ga698c8995f-prebuilt.qemu.org 04/01/2014
>   Call Trace:
>     dump_stack+0x85/0xba
>     ubi_eba_write_leb+0xa1e/0xa40 [ubi]
>     vol_cdev_write+0x307/0x520 [ubi]
>     vfs_write+0xfa/0x280
>     ksys_pwrite64+0xc5/0xe0
>     __x64_sys_pwrite64+0x22/0x30
>     do_syscall_64+0xbf/0x440
>
> In function ubi_wl_get_peb, the operation of filling the pool
> (ubi_update_fastmap) with free PEBs and fetching a free PEB from the pool
> is not atomic. After thread A filling the pool with free PEB, free PEB may
> be taken away by thread B. When thread A checks the expression again, the
> condition is still unsatisfactory. At this time, there may still be free
> PEBs on UBI that can be filled into the pool.
>
> This patch increases the number of attempts to obtain PEB. An extreme
> case (No free PEBs left after creating test volumes) has been tested on
> different type of machines for 100 times. The biggest number of attempts
> are shown below:
>
>              x86_64     arm64
>   2-core        4         4
>   4-core        8         4
>   8-core        4         4
>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Thanks for addressing this!
I'll take this version. :-)

-- 
Thanks,
//richard
