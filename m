Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B515BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757E8218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FH7aQvKx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XuHRzJIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbfC2Uqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:46:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43464 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730160AbfC2Uqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:46:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D41076087F; Fri, 29 Mar 2019 20:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553892395;
        bh=5pHMuzhUAdMu7a3KdCWYhEYaGwzWC1RblVaaor5o8EM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FH7aQvKx0mzVt6xsZ/PUZP6c0eghcad63UJhSIvzkbotrYGKCOgoK7HrgW/b/fcGH
         e400kN9EOr+eFEm2T/WcsKnef5HFfzSfRLNpcd7cI8AxbUrTDOBPbATHWe6CTX3XoH
         +RH9w9VjlRZza8VUhOl5ixLbjUIiWka6fW0L6wNk=
Received: from [10.79.168.116] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BAB8D6079C;
        Fri, 29 Mar 2019 20:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553892393;
        bh=5pHMuzhUAdMu7a3KdCWYhEYaGwzWC1RblVaaor5o8EM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XuHRzJIoZeISRf2uQGHjtLyUFK6McBVHEKLHuhVr2eOLzuHfnmYGDdubqiscgfyHv
         WM3vQPfMp9w50YX0KigfKsada1VunN1lqA1TcZ3kgxQeBvH+FOjNgV7m3u7zdcbvdZ
         6r4IEZQCpPWc7KwTA5xcpgzK5jnl0ds1R4alWXdY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BAB8D6079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] fbdev: fix divide error in fb_var_to_videomode
To:     shile.zhang@linux.alibaba.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Fredrik Noring <noring@nocrew.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
References: <1552998003-237288-1-git-send-email-shile.zhang@linux.alibaba.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <a3eedb3a-bd70-a33c-a0d1-d111ed11d7de@codeaurora.org>
Date:   Sat, 30 Mar 2019 02:16:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1552998003-237288-1-git-send-email-shile.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/19/2019 5:50 PM, shile.zhang@linux.alibaba.com wrote:
> From: Shile Zhang <shile.zhang@linux.alibaba.com>
>
> To fix following divide-by-zero error found by Syzkaller:
>
>    divide error: 0000 [#1] SMP PTI
>    CPU: 7 PID: 8447 Comm: test Kdump: loaded Not tainted 4.19.24-8.al7.x86_64 #1
>    Hardware name: Alibaba Cloud Alibaba Cloud ECS, BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
>    RIP: 0010:fb_var_to_videomode+0xae/0xc0
>    Code: 04 44 03 46 78 03 4e 7c 44 03 46 68 03 4e 70 89 ce d1 ee 69 c0 e8 03 00 00 f6 c2 01 0f 45 ce 83 e2 02 8d 34 09 0f 45 ce 31 d2 <41> f7 f0 31 d2 f7 f1 89 47 08 f3 c3 66 0f 1f 44 00 00 0f 1f 44 00
>    RSP: 0018:ffffb7e189347bf0 EFLAGS: 00010246
>    RAX: 00000000e1692410 RBX: ffffb7e189347d60 RCX: 0000000000000000
>    RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffb7e189347c10
>    RBP: ffff99972a091c00 R08: 0000000000000000 R09: 0000000000000000
>    R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000100
>    R13: 0000000000010000 R14: 00007ffd66baf6d0 R15: 0000000000000000
>    FS:  00007f2054d11740(0000) GS:ffff99972fbc0000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 00007f205481fd20 CR3: 00000004288a0001 CR4: 00000000001606a0
>    Call Trace:
>     fb_set_var+0x257/0x390
>     ? lookup_fast+0xbb/0x2b0
>     ? fb_open+0xc0/0x140
>     ? chrdev_open+0xa6/0x1a0
>     do_fb_ioctl+0x445/0x5a0
>     do_vfs_ioctl+0x92/0x5f0
>     ? __alloc_fd+0x3d/0x160
>     ksys_ioctl+0x60/0x90
>     __x64_sys_ioctl+0x16/0x20
>     do_syscall_64+0x5b/0x190
>     entry_SYSCALL_64_after_hwframe+0x44/0xa9
>    RIP: 0033:0x7f20548258d7
>    Code: 44 00 00 48 8b 05 b9 15 2d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 89 15 2d 00 f7 d8 64 89 01 48
>
> It can be triggered easily with following test code:
>
>    #include <linux/fb.h>
>    #include <fcntl.h>
>    #include <sys/ioctl.h>
>    int main(void)
>    {
>            struct fb_var_screeninfo var = {.activate = 0x100, .pixclock = 60};
>            int fd = open("/dev/fb0", O_RDWR);
>            if (fd < 0)
>                    return 1;
>
>            if (ioctl(fd, FBIOPUT_VSCREENINFO, &var))
>                    return 1;
>
>            return 0;
>    }
>
> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>

To avoid any exception we should include the check.
Looks fine to me.
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/video/fbdev/core/modedb.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
> index 283d9307..ac04987 100644
> --- a/drivers/video/fbdev/core/modedb.c
> +++ b/drivers/video/fbdev/core/modedb.c
> @@ -935,6 +935,9 @@ void fb_var_to_videomode(struct fb_videomode *mode,
>   	if (var->vmode & FB_VMODE_DOUBLE)
>   		vtotal *= 2;
>   
> +	if (!htotal || !vtotal)
> +		return;
> +
>   	hfreq = pixclock/htotal;
>   	mode->refresh = hfreq/vtotal;
>   }
