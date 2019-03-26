Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC9BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67BE20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbfCZFyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 01:54:49 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:51455 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725535AbfCZFyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 01:54:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TNg4QDt_1553579653;
Received: from ali-6c96cfdd1403.local(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0TNg4QDt_1553579653)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Mar 2019 13:54:43 +0800
Subject: Re: [PATCH] fbdev: fix divide error in fb_var_to_videomode
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Fredrik Noring <noring@nocrew.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
References: <1552998003-237288-1-git-send-email-shile.zhang@linux.alibaba.com>
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
Message-ID: <0560ca36-a7a8-ed6f-d66f-059336e6b5e9@linux.alibaba.com>
Date:   Tue, 26 Mar 2019 13:54:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552998003-237288-1-git-send-email-shile.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bartlomiej, Fredrik, Daniel,

Could you please help to have a look at this patch?

Many thanks!

-Shile

On 2019/3/19 20:20, shile.zhang@linux.alibaba.com wrote:
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
