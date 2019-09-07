Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44284C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA2521835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hplbhUy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436504AbfIGQxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 12:53:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34912 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfIGQxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 12:53:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id n4so5302382pgv.2;
        Sat, 07 Sep 2019 09:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W4genfL+jPHiR47td/wtW6d/wn4QN3WitCbileJFLtQ=;
        b=hplbhUy68wRLcKR8srHTQATPr/0f2xRK0qUHJedlAVW1Ilkusi0lxOtbXThbbWxM/e
         SCYt6aKGL57k6wuM4TGZeD8srEwP3gZWdpulNoLwPZkhtaN7BJVZB+M9+EgUzoNWi02O
         xjjtwxhsgQIfk+gztwDtKmvuS3EEvfU9DrnCBY+mGXpjmuiuQyL4ebkqK0Vz3e6IunsQ
         nDcy3xHRlLnILejuJctA4QfGmsYDU86LO/4hWf1DNsXswZplmh47P7WehUjHSasTQqKu
         uCmZByp+p3XIsLIrhjJqkizLhLROpIAroP/6xe/PbTk6Jiyp2V3zF4IykRyvni+b2xCU
         RZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W4genfL+jPHiR47td/wtW6d/wn4QN3WitCbileJFLtQ=;
        b=O7DyXOgl1WjPBbcDkZJ2dQrBMmy8AG/3utLyU8NBReG9qQu3QQm/zURUurfbvVHHMv
         bGttG+2PAHbFiDE77vhu4UFxjRaE70QuwQ+WvfIF+LXR9NuzhBc18cV2kjBu/ainvgNm
         JLdVCp52JQKwDMglT89OOeozY0zWAXrAZA5sLo6UqdzMprQuXVX3pycb5pL9pV8IWPWx
         gOkQz+dkrFfRXH6zMsFxKOdVAiGv5iwKjXTA1Ji2Mpg7Idn6uYUTbij2oGtk5mfPTgZt
         qiZabbSzCV0hmdzCVOYmRWzU9uWFmYpsxxjQQiIImyL31cbEuK5EqjOI+TxoZZspxOSg
         RV2Q==
X-Gm-Message-State: APjAAAUUt8A0RRWGDCa5wRqhu03KCHXwBeo4fwI3gcvflre52ihRLMHj
        FAd5LxPZhGlVKZmS8ZQwXxyCSZ52KK3XGm7jCYg=
X-Google-Smtp-Source: APXvYqy1DgOby6QrM9ZtpZOXPHSJG9W43ZITQoiy+k5qFbkJoYTCqjnmsqVoNykrOFguTarYkr1tP1+8WQ1p6UtovoY=
X-Received: by 2002:a63:1020:: with SMTP id f32mr13841202pgl.203.1567875197860;
 Sat, 07 Sep 2019 09:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190816014140.10687-1-m.v.b@runbox.com> <20190816014140.10687-2-m.v.b@runbox.com>
In-Reply-To: <20190816014140.10687-2-m.v.b@runbox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 7 Sep 2019 19:53:06 +0300
Message-ID: <CAHp75VcTEJAO2Be08D22mJ7nmXBcf1gL04MG4uUV3FvzOa-vdA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_pmc_core_pltdrv: Module removal
 warning fix
To:     "M. Vefa Bicakci" <m.v.b@runbox.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 4:42 AM M. Vefa Bicakci <m.v.b@runbox.com> wrote:
>
> Prior to this commit, removing the intel_pmc_core_pltdrv module
> would cause the following warning:
>
>   ------------[ cut here ]------------
>   Device 'intel_pmc_core.0' does not have a release() function, \
>     it is broken and must be fixed. See Documentation/kobject.txt.
>   WARNING: CPU: 0 PID: 2202 at drivers/base/core.c:1238 device_release+0x6f/0x80
>   Modules linked in: fuse intel_rapl_msr ip6table_filter ip6_tables ipt_REJECT \
>     nf_reject_ipv4 xt_conntrack iptable_filter xt_MASQUERADE iptable_nat nf_nat \
>     nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c intel_rapl_common \
>     intel_pmc_core_pltdrv(-) xen_netfront intel_pmc_core crct10dif_pclmul \
>     crc32_pclmul crc32c_intel ghash_clmulni_intel intel_rapl_perf pcspkr binfmt_misc \
>     u2mfn(O) xenfs xen_gntdev xen_gntalloc xen_blkback xen_privcmd xen_evtchn \
>     ip_tables overlay xen_blkfront
>   CPU: 0 PID: 2202 Comm: rmmod Tainted: G        W  O      5.3.0-rc3-next-20190809-1 #2
>   RIP: 0010:device_release+0x6f/0x80
>   Code: 48 8b 85 c0 02 00 00 48 85 c0 74 09 48 8b 40 40 48 85 c0 75 c6 48 8b 75 50 48 85 f6 74 10 48 c7 c7 58 68 12 82 e8 5f 62 a9 ff <0f> 0b eb b5 48 8b 75 00 eb ea 0f 1f 80 00 00 00 00 0f 1f 44 00 00
>   RSP: 0018:ffffc90000763ea8 EFLAGS: 00010286
>   RAX: 0000000000000000 RBX: ffffffff822da080 RCX: 0000000000000006
>   RDX: 0000000000000007 RSI: 0000000000000082 RDI: ffff88813ba17540
>   RBP: ffffffffc0107010 R08: 0000000000000195 R09: 000000000000000d
>   R10: 000000000000000a R11: ffffc90000763d65 R12: ffff88800c9e9000
>   R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>   FS:  000071250bf142c0(0000) GS:ffff88813ba00000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 000060ab8fd82d49 CR3: 00000001273ba004 CR4: 00000000003606f0
>   Call Trace:
>    kobject_put+0x85/0x1b0
>    __x64_sys_delete_module+0x14b/0x270
>    do_syscall_64+0x5f/0x1a0
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   RIP: 0033:0x71250c031c6b
>   Code: 73 01 c3 48 8b 0d 1d 42 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ed 41 0c 00 f7 d8 64 89 01 48
>   RSP: 002b:00007ffec29e6038 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
>   RAX: ffffffffffffffda RBX: 00006040bc3e07b0 RCX: 000071250c031c6b
>   RDX: 000000000000000a RSI: 0000000000000800 RDI: 00006040bc3e0818
>   RBP: 00007ffec29e6088 R08: 1999999999999999 R09: 0000000000000000
>   R10: 000071250c0a6ac0 R11: 0000000000000206 R12: 00007ffec29e6250
>   R13: 00007ffec29e67b7 R14: 00006040bc3e0260 R15: 00007ffec29e6090
>   ---[ end trace 5e5421608729d6f5 ]---
>
> This commit hence adds an empty release function for the driver.
>

Pushed to my review and testing queue, thanks!

P.S. I cut unnecessary output off.

> Signed-off-by: M. Vefa Bicakci <m.v.b@runbox.com>
> ---
>  drivers/platform/x86/intel_pmc_core_pltdrv.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/platform/x86/intel_pmc_core_pltdrv.c b/drivers/platform/x86/intel_pmc_core_pltdrv.c
> index a8754a6db1b8..186540014c48 100644
> --- a/drivers/platform/x86/intel_pmc_core_pltdrv.c
> +++ b/drivers/platform/x86/intel_pmc_core_pltdrv.c
> @@ -18,8 +18,16 @@
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>
> +static void intel_pmc_core_release(struct device *dev)
> +{
> +       /* Nothing to do. */
> +}
> +
>  static struct platform_device pmc_core_device = {
>         .name = "intel_pmc_core",
> +       .dev  = {
> +               .release = intel_pmc_core_release,
> +       },
>  };
>
>  /*
> --
> 2.21.0
>


-- 
With Best Regards,
Andy Shevchenko
