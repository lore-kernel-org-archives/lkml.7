Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45E9C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 06:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988DB2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 06:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="mUbuNpug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfKRGM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 01:12:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40230 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfKRGM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 01:12:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id q15so5123154wrw.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 22:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dzhVBOMf59PHYjhcO5/bPOeyIO8A+TPlN5Z6xmX6Zfg=;
        b=mUbuNpugZTAnDNPQd9lieNDlt85CfqQ5HxNZOSP9AmjHYAi6SjRi99kn9IidBIRO/y
         nzWX4u6iJv3jxNH6Ebm8CnPahp9MXMG+rmb4i0k1gmRvkRsojYil4v294x+cCA73d/M1
         Us3w7jQR2ohkELcopCpnoFTNzC3mSuK01Y9IvHC8sSVUCljzpsjr8GGit1OmpD0D+YXg
         W/5aMm/0YbvxkVD9FrAwPdS1Y1KuysOwOlWlg7aQy/uN765LkJrx/wDzh/U+m731G2ph
         iKLwDuP0Rk7eOLCRi+7hP1QR8HELJWzSN1tMuVxi3Cckij/mAA0xQsY65zhW6Y33o60a
         ATGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dzhVBOMf59PHYjhcO5/bPOeyIO8A+TPlN5Z6xmX6Zfg=;
        b=gTRnHwR574/RXUjViU2gmNfYYHpEWBk2K1nNvv29VuJUHoVD9j5FsVOc5UnDL6LcW6
         a+CWSn/VY4Bt/14GbPPAJgN9TzWUHflJ2R8W2plD56WCux9rD+iXdiYgM8pdgNmbHOOG
         LJ0DT8yeBnALBLj1+xjHhYP2PMSrHXtGn0OZXvTSwyMyGoY2w9AyLBUAkks00E1CWb2r
         OE2yinuJUvfMOsOIfZuNPtY66ROqRJsV82WolbXhNsgqhwX2sXvcrgk0p1pJkuMzmmfJ
         poFkaU33lfsvnKCpnZXK4fMhFjqvzdiz/ajtS080L95DOwNmctm7pWaNP04bPtTPfq/A
         jV3w==
X-Gm-Message-State: APjAAAW+naEP5FSF5S9tFRZ4IzrDSnzmq4kBx+kpVQizebf+1PMUu78n
        8TEorCWmBKDXIlqKC6PfYS4/bA4qON0f7Xo03K56lw==
X-Google-Smtp-Source: APXvYqyF3YsX2G6wuJDiAhQzqIEHeeH7CEoNFF0mxhQU8u7tkSKps01SW+5Q5xygjLmoJsN3EyJbGsKlbggWsNZV+yo=
X-Received: by 2002:a05:6000:104:: with SMTP id o4mr26662567wrx.309.1574057574393;
 Sun, 17 Nov 2019 22:12:54 -0800 (PST)
MIME-Version: 1.0
References: <1574056694-28927-1-git-send-email-yash.shah@sifive.com>
In-Reply-To: <1574056694-28927-1-git-send-email-yash.shah@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 18 Nov 2019 11:42:43 +0530
Message-ID: <CAAhSdy1i8i9MNnSyBud_k2sqn9mwYadh3YFgQ_42u9+C6F3VDg@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Add address map dumper
To:     Yash Shah <yash.shah@sifive.com>
Cc:     "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 11:28 AM Yash Shah <yash.shah@sifive.com> wrote:
>
> Add support for dumping the kernel address space layout to the console.
> User can enable CONFIG_DEBUG_VM to dump the virtual memory region into
> dmesg buffer during boot-up.
>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
> This patch is based on Linux 5.4-rc6 and tested on SiFive HiFive
> Unleashed board.
>
> Changes in v2:
> - Avoid #ifdefs inside functions
> - Helper functions instead of macros
> - Drop newly added CONFIG_DEBUG_VM_LAYOUT, instead use CONFIG_DEBUG_VM
> ---
>  arch/riscv/mm/init.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 573463d..7828136 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -45,6 +45,41 @@ void setup_zero_page(void)
>         memset((void *)empty_zero_page, 0, PAGE_SIZE);
>  }
>
> +#ifdef CONFIG_DEBUG_VM
> +static inline void print_mlk(char *name, unsigned long b, unsigned long t)
> +{
> +       pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld kB)\n", name, b, t,
> +                 (((t) - (b)) >> 10));
> +}
> +
> +static inline void print_mlm(char *name, unsigned long b, unsigned long t)
> +{
> +       pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld MB)\n", name, b, t,
> +                 (((t) - (b)) >> 20));
> +}
> +
> +static void print_vm_layout(void)
> +{
> +       pr_notice("Virtual kernel memory layout:\n");
> +       print_mlk("fixmap", (unsigned long)FIXADDR_START,
> +                 (unsigned long)FIXADDR_TOP);
> +       print_mlm("vmemmap", (unsigned long)VMEMMAP_START,
> +                 (unsigned long)VMEMMAP_END);
> +       print_mlm("vmalloc", (unsigned long)VMALLOC_START,
> +                 (unsigned long)VMALLOC_END);
> +       print_mlm("lowmem", (unsigned long)PAGE_OFFSET,
> +                 (unsigned long)high_memory);
> +       print_mlk(".init", (unsigned long)__init_begin,
> +                 (unsigned long)__init_end);
> +       print_mlk(".text", (unsigned long)_text, (unsigned long)_etext);
> +       print_mlk(".data", (unsigned long)_sdata, (unsigned long)_edata);
> +       print_mlk(".bss", (unsigned long)__bss_start,
> +                 (unsigned long)__bss_stop);
> +}
> +#else
> +static void print_vm_layout(void) { }
> +#endif /* CONFIG_DEBUG_VM */
> +
>  void __init mem_init(void)
>  {
>  #ifdef CONFIG_FLATMEM
> @@ -55,6 +90,7 @@ void __init mem_init(void)
>         memblock_free_all();
>
>         mem_init_print_info(NULL);
> +       print_vm_layout();
>  }
>
>  #ifdef CONFIG_BLK_DEV_INITRD
> --
> 2.7.4
>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
