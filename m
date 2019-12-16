Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930E0C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A5F2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="PFhxIKbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfLPJsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:48:20 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48410 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbfLPJsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:48:20 -0500
Received: from zn.tnic (p4FED3450.dip0.t-ipconnect.de [79.237.52.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C5ED51EC05DE;
        Mon, 16 Dec 2019 10:48:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576489694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=q8O6VZTemt35IGzR/FF7o3a1DfxJLaFVolgurqY/LZw=;
        b=PFhxIKbPtj0Tv4MrASXYGGCvSuJTjVXI+02ZrMMKV/xMDyJS6ikvNKG12lAtDg/c4eGC6h
        qSFUrBlyP9Ve0wV6HGQa3av8h6C+m0SemosA/HFPtg2fQ4FvS5eV5OpNTMS+cKa4uQ6Gjl
        /cVXOuwEsjjoxl+amJjXg+uz9FRxaYA=
Date:   Mon, 16 Dec 2019 10:45:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] init: use do_mount() instead of ksys_mount()
Message-ID: <20191216094556.GA32241@zn.tnic>
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
 <20191212181422.31033-4-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191212181422.31033-4-linux@dominikbrodowski.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 07:14:20PM +0100, Dominik Brodowski wrote:
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 43f6d098c880..f55cbd9cb818 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -387,12 +387,25 @@ static void __init get_fs_names(char *page)
>  	*s = '\0';
>  }
>  
> -static int __init do_mount_root(char *name, char *fs, int flags, void *data)
> +static int __init do_mount_root(const char *name, const char *fs,
> +				 const int flags, const void *data)
>  {
>  	struct super_block *s;
> -	int err = ksys_mount(name, "/root", fs, flags, data);
> -	if (err)
> -		return err;
> +	char *data_page;
> +	struct page *p;
> +	int ret;
> +
> +	/* do_mount() requires a full page as fifth argument */
> +	p = alloc_page(GFP_KERNEL);
> +	if (!p)
> +		return -ENOMEM;
> +
> +	data_page = page_address(p);
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^

That doesn't work in my guest as it gives a funny address:

[    3.155314] mount_block_root: entry
[    3.155868] mount_block_root: fs_name: [ext3]
[    3.156512] do_mount_root: will copy data page: 0x00000000adf0ddb8

leading to the splat below.

Reverting the patch fixes the boot.

Thx.

[    3.575074] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    3.576858] #PF: supervisor read access in kernel mode
[    3.578274] #PF: error_code(0x0000) - not-present page
[    3.579003] PGD 0 P4D 0 
[    3.579003] Oops: 0000 [#1] PREEMPT SMP
[    3.579003] CPU: 8 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc1+ #17
[    3.579003] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
[    3.579003] RIP: 0010:strncpy+0xf/0x30
[    3.579003] Code: 0f b6 0c 16 88 0c 10 48 ff c2 84 c9 75 f2 f3 c3 66 66 2e 0f 1f 84 00 00 00 00 00 48 85 d2 48 89 f8 74 1b 4c 8d 04 17 48 89 fa <0f> b6 0e 80 f9 01 88 0a 48 83 de ff 48 ff c2 4c 39 c2 75 ec f3 c3
[    3.579003] RSP: 0018:ffffc90000013eb8 EFLAGS: 00010206
[    3.579003] RAX: ffff88807b780000 RBX: 0000000000008001 RCX: 0000000000000000
[    3.579003] RDX: ffff88807b780000 RSI: 0000000000000000 RDI: ffff88807b780000
[    3.579003] RBP: ffff88807b781000 R08: ffff88807b780fff R09: 00000000000770f4
[    3.579003] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88807b781000
[    3.579003] R13: 0000000000000000 R14: 0000000000000000 R15: ffffea0001ede000
[    3.579003] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[    3.579003] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.579003] CR2: 0000000000000000 CR3: 0000000002009000 CR4: 00000000003406e0
[    3.579003] Call Trace:
[    3.579003]  mount_block_root+0x14f/0x312
[    3.579003]  prepare_namespace+0x136/0x165
[    3.579003]  ? rest_init+0xb9/0xb9
[    3.579003]  kernel_init+0xa/0xf7
[    3.579003]  ret_from_fork+0x22/0x40
[    3.579003] Modules linked in:
[    3.579003] CR2: 0000000000000000
[    3.579003] ---[ end trace 2884b7e501f1daa6 ]---
[    3.579003] RIP: 0010:strncpy+0xf/0x30
[    3.579003] Code: 0f b6 0c 16 88 0c 10 48 ff c2 84 c9 75 f2 f3 c3 66 66 2e 0f 1f 84 00 00 00 00 00 48 85 d2 48 89 f8 74 1b 4c 8d 04 17 48 89 fa <0f> b6 0e 80 f9 01 88 0a 48 83 de ff 48 ff c2 4c 39 c2 75 ec f3 c3
[    3.579003] RSP: 0018:ffffc90000013eb8 EFLAGS: 00010206
[    3.579003] RAX: ffff88807b780000 RBX: 0000000000008001 RCX: 0000000000000000
[    3.579003] RDX: ffff88807b780000 RSI: 0000000000000000 RDI: ffff88807b780000
[    3.579003] RBP: ffff88807b781000 R08: ffff88807b780fff R09: 00000000000770f4
[    3.579003] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88807b781000
[    3.579003] R13: 0000000000000000 R14: 0000000000000000 R15: ffffea0001ede000
[    3.579003] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[    3.579003] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.579003] CR2: 0000000000000000 CR3: 0000000002009000 CR4: 00000000003406e0
[    3.611795] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
[    3.612923] Kernel Offset: disabled
[    3.613505] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
