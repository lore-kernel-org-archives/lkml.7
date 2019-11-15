Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9243EC33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3592073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="U9usOCz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfKONwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:52:21 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41040 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfKONwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:52:20 -0500
Received: by mail-qv1-f68.google.com with SMTP id g18so3777900qvp.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 05:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=En/i0mthZpZvBiVTNrAQOYo+mL/zOQQWMDgCZMT6UJQ=;
        b=U9usOCz4Y+Ccrh7wRKgnYMkH+xsOZmCuF7gaEx2tjqr7dKhq3Z+b1BymHlSEHrX5nt
         ZteIpssn+vyYSN+svr6MeeQlHGhb9jGBT4PnxEyjllUQgatqf/VQvENyRfrvsp8JL6AC
         KwzZaQQWO81+kuGADVx7XcGx683FL14k1I+4aICU3bIFsHUWr6C8OWcmlMVdrTuaQtBP
         1WR1ug+O0ZFEyynl6Sz7C8CbxH4SmnamIByRA7R12spu75GnZh1BBSZgscGrYee1BaCW
         hYVcfXIFx6zfD2u5AET57EfI06qxW93ooy2yDOiWjkBmSWRuBSzJx37tQ01Uw+wcxf2u
         GFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=En/i0mthZpZvBiVTNrAQOYo+mL/zOQQWMDgCZMT6UJQ=;
        b=uRXPyCHpdpDUDqATNeDDx4NcBYuP1pfBuvhf6KldC56UG0tSnGeDZcj7AQVrFjTxKD
         SVb3Zm3wZuc/WUsPlkLF9JEJh7jRosG0cn11n/rAbFPo4vLAuH9rAG1AcrhdoOT9xVJt
         ujvwKiKCIPQAMRFFBesxbCPiX7fY4yiFkp+1H7guQmplA8KJ5GbARGlOpOw6Ovi824bE
         Rzw7/dEEaflMUGbJpyuQ6qym/w9QMxYtFlKiNxkIh5e//FgiMwU6wTaTxci/b3McsD5l
         cAUfKGjTXjXAv5orpTDj0OxVNN2ciwSIJvO2MD2AUF01rSo/t35pEYmLzo0Ql6ZnU645
         oPrw==
X-Gm-Message-State: APjAAAUm21PS2aHpwzIOFO9QlDywivMHgHk3dom7XFO6ScAL2mz1dl0W
        7bLrvb20E0Xgiy6jWRkgucFymNfNOz8=
X-Google-Smtp-Source: APXvYqytHn9HhD1jy+wId5udh+kHrIxZOaT+/DdqUVP3yjcLOnxpCq+mp+CUdHmlDhG79M9Lf2FejA==
X-Received: by 2002:a0c:b88f:: with SMTP id y15mr13590929qvf.161.1573825939616;
        Fri, 15 Nov 2019 05:52:19 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x203sm4206111qkb.11.2019.11.15.05.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 05:52:19 -0800 (PST)
Message-ID: <1573825937.5937.126.camel@lca.pw>
Subject: Re: [PATCH] mm: Cast the type of unmap_start to u64
From:   Qian Cai <cai@lca.pw>
To:     Chen Jun <chenjun102@huawei.com>, Hugh Dickins <hughd@google.com>,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com
Date:   Fri, 15 Nov 2019 08:52:17 -0500
In-Reply-To: <1573867464-5107-1-git-send-email-chenjun102@huawei.com>
References: <1573867464-5107-1-git-send-email-chenjun102@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-15 at 20:24 -0500, Chen Jun wrote:
> In 64bit system. sb->s_maxbytes of shmem filesystem is MAX_LFS_FILESIZE,
> which equal LLONG_MAX.
> If offset > LLONG_MAX - PAGE_SIZE, offset + len < LLONG_MAX in
> shmem_fallocate, which will pass the checking in vfs_fallocate.
> 	/* Check for wrap through zero too */
> 	if (((offset + len) > inode->i_sb->s_maxbytes) || ((offset + len) < 0))
> 		return -EFBIG;
> 
> loff_t unmap_start = round_up(offset, PAGE_SIZE) in shmem_fallocate
> causes a overflow.
> 
> Syzkaller reports a overflow problem in mm/shmem:
> UBSAN: Undefined behaviour in mm/shmem.c:2014:10

What is the syzkaller reproducer if any?

> signed integer overflow:
> '9223372036854775807 + 1' cannot be represented in type 'long long int'
> CPU: 0 PID:17076 Comm: syz-executor0 Not tainted 4.1.46+ #1
> Hardware name: linux, dummy-virt (DT)
> Call trace:
> [<ffff800000092150>] dump_backtrace+0x0/0x2c8 arch/arm64/kernel/traps.c:100
> [<ffff800000092438>] show_stack+0x20/0x30 arch/arm64/kernel/traps.c:238
> [<ffff800000f9b134>] __dump_stack lib/dump_stack.c:15 [inline]
> [<ffff800000f9b134>] ubsan_epilogue+0x18/0x70 lib/ubsan.c:164
> [<ffff800000f9b468>] handle_overflow+0x158/0x1b0 lib/ubsan.c:195
> [<ffff800000341280>] shmem_fallocate+0x6d0/0x820 mm/shmem.c:2104
> [<ffff8000003ee008>] vfs_fallocate+0x238/0x428 fs/open.c:312
> [<ffff8000003ef72c>] SYSC_fallocate fs/open.c:335 [inline]
> [<ffff8000003ef72c>] SyS_fallocate+0x54/0xc8 fs/open.c:239
> 
> The highest bit of unmap_start will be appended with sign bit 1 (overflow)
> when calculate shmem_falloc.start:
> shmem_falloc.start = unmap_start >> PAGE_SHIFT.
> 
> Fix it by casting the type of unmap_start to u64, when right shifted.
> 
> This bug is found in LTS Linux 4.1. It also seems to exist in mainline.
> 
> Signed-off-by: Chen Jun <chenjun102@huawei.com>
> ---
>  mm/shmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index e9342c3..82cebbc 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2717,7 +2717,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
>  		}
>  
>  		shmem_falloc.waitq = &shmem_falloc_waitq;
> -		shmem_falloc.start = unmap_start >> PAGE_SHIFT;
> +		shmem_falloc.start = (u64)unmap_start >> PAGE_SHIFT;
>  		shmem_falloc.next = (unmap_end + 1) >> PAGE_SHIFT;
>  		spin_lock(&inode->i_lock);
>  		inode->i_private = &shmem_falloc;
