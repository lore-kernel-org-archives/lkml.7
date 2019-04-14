Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C9AC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 21:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331BA2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 21:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+QWO3E7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfDNV0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 17:26:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37370 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfDNV0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 17:26:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so17675357wmf.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 14:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=If9WXHCplywK5przMUyIXPjCmQSJcs07z5kgn5Iorzw=;
        b=M+QWO3E7Qo1CBXw0kjN+H+ZW7/G8sHf9nO/fTIctNXaGnJSUOHBK3YY6BVJXu+5ZNL
         16gEeFUeePI5ApJJn/S6GWYS1wP0+N8Pb5Q0ESo8odfbzLr6mFmSx7vDSb4CPpe/Bg/G
         TG5anCbuxhPmYkIxDDx6Uvc6Uf90BbS36WtfphTlhW0LZKndHvPoVc9nE6uUcd4tNKrf
         6NT/DsyDAQwuexLDVMEFiXuZPzOJiCZ7b+xXRHYr+T++t3uOoPqchI+1oY1Q7NfeI+V2
         zLmarzl1X1wBEGqceN/Z/rsEysuWK7ElsAsOszDB+GwNgh2DQ4Yhayq50LczkrDCl6hw
         53NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=If9WXHCplywK5przMUyIXPjCmQSJcs07z5kgn5Iorzw=;
        b=jK6Xm+uglgqd03huWyo4QVTPG4PSgtQXFjNmN1y2qpNIaaX2ZVj3KW3/WBQpPyhwQe
         BQJ/l5xgBtRh6GRqULi98FMk6szzhfH/X8wE/FE7ps5DPf4l9ot29k7axtfOSThwAdNa
         h2htyfgEafJbwQ1yiIQf63x0su2WT40hNdZG2xrhhOibB+g4OKpqg8FN4Qt8QI3za/za
         f87eRallaWka+CfTlvxNUXXy9+65N+i4rGxfJylpftzFxYq57a4Snj/IRgLcbGRI6qET
         1KlQkp5PcYCe2q3zyTMqyopmq7CTzS+uetE3YGo4/SawA/BPnTbN01dpUEoz8+0am1fx
         3exg==
X-Gm-Message-State: APjAAAUi1YlY7lXbgLtEJCBNGTD/OqSK4++YDhrzSwHZc+Khr17O/rgF
        lZQoxu0z0Xt1ZVANtbnVx1Wq6CM=
X-Google-Smtp-Source: APXvYqxBPJyIrFfBIgHhvWqXIyuUz8AE8rcJazWmVBEfkkf1mnaGNxCzIzY71I5CAvDmjM+2vIFooQ==
X-Received: by 2002:a1c:7611:: with SMTP id r17mr7271211wmc.98.1555277166345;
        Sun, 14 Apr 2019 14:26:06 -0700 (PDT)
Received: from localhost (33.red-83-38-164.dynamicip.rima-tde.net. [83.38.164.33])
        by smtp.gmail.com with ESMTPSA id z7sm12921567wml.40.2019.04.14.14.26.05
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 14:26:05 -0700 (PDT)
Subject: Re: bug disabling NX (noexec=off)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86 team <x86@kernel.org>
References: <c090ad3c-1f2f-c148-dd44-a58df0788588@gmail.com>
 <alpine.DEB.2.21.1904141158400.4917@nanos.tec.linutronix.de>
From:   Xose Vazquez Perez <xose.vazquez@gmail.com>
Message-ID: <92ac69b8-7e29-50e1-f460-4e7ac8c6b7ac@gmail.com>
Date:   Sun, 14 Apr 2019 23:26:04 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904141158400.4917@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/19 11:59 AM, Thomas Gleixner wrote:
> On Sat, 13 Apr 2019, Xose Vazquez Perez wrote:
>> [    0.000000] NX (Execute Disable) protection: disabled by kernel command line option
>> [    0.000000] ------------[ cut here ]------------
>> [    0.000000] attempted to set unsupported pgprot: 8000000000000163 bits: 8000000000000000 supported: 7fffffffffffffff
> 
> Does the below patch fix it for you?
> 
> Thanks,
> 
> 	tglx
> 
> 8<----------------
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 0029604af8a4..dd73d5d74393 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -825,7 +825,7 @@ void __init __early_set_fixmap(enum fixed_addresses idx,
>  	pte = early_ioremap_pte(addr);
>  
>  	/* Sanitize 'prot' against any unsupported bits: */
> -	pgprot_val(flags) &= __default_kernel_pte_mask;
> +	pgprot_val(flags) &= __supported_pte_mask;
>  
>  	if (pgprot_val(flags))
>  		set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, flags));
> 

Yes, it fixed it.


But there is another bug that I did not see before, but it was there:

---cut dmesg---
Freeing unused kernel image memory: 76K
------------[ cut here ]------------
x86/mm: Found insecure W+X mapping at address 0xffff9df500000000
WARNING: CPU: 1 PID: 1 at arch/x86/mm/dump_pagetables.c:262 note_page+0x2ae/0x650
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.0.7-300.fc30.x86_64 #1
Hardware name: Hewlett-Packard p6-2004es/2ABF, BIOS 7.16 03/23/2012
RIP: 0010:note_page+0x2ae/0x650
Code: 29 f0 48 c1 e8 0c 48 01 43 40 80 3d 54 15 2c 01 00 0f 85 07 ff ff ff 48 c7 c7 a0 d9 0a b7 c6 05 40 15 2c 01 01 e8 41 2d 06 00 <0f> 0b 4c 8b 4b 20 e9 e9 fe ff ff 48 29 d6 84 c9 0f 85 71 09 00 00
RSP: 0018:ffffb35940c63e18 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffb35940c63ec8 RCX: 0000000000000050
RDX: 0000000000000001 RSI: 0000000000000092 RDI: 0000000000000247
RBP: 0000000000000161 R08: 0000000000000001 R09: 00000000000002ca
R10: 000000000000e844 R11: 0000000000000003 R12: 0000000000000000
R13: 0000000000000005 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff9df737280000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2e235a8a88 CR3: 000000012b20e002 CR4: 00000000000606e0
Call Trace:
 ? vprintk_emit+0x1ec/0x250
 ptdump_walk_pgd_level_core+0x46a/0x4c0
 ? rest_init+0xaa/0xaa
 kernel_init+0x2c/0x106
 ret_from_fork+0x1f/0x40
---[ end trace 3288a26b9a3da7ee ]---
x86/mm: Checked W+X mappings: FAILED, 2175454 W+X pages found.
rodata_test: all tests were successful
Run /init as init process
---cut dmesg---


Thank you.
