Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B71C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8BA22D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jKTgxbew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfICPB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:01:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37321 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfICPB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:01:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1so9297707pgp.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 08:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a2fhN1NcP29VAX6Q4kuHnoYPTW0IlOqHifPZstOm4mo=;
        b=jKTgxbewf7sPASPHDIRjZy/DSg3ccnPxPhmVM1qw2+3zyIY1XYDZ5fOOV+Je7/21m3
         /zKF5xLg2gmAdqSC/V898UGcMHe8vo0jdhWTZPgtUj+4omdGaDQMpZ3rsz2yJjr23hYB
         VWOBGrtzqY/vAsw1rWOghUctwpPEduxbmy9VqF3hWvqrKcQjlRWpYEzPXKGnu1GIrzvs
         dP3X5JiFfCiv0SkWuWyA7f/+6J5Z1Gt4/cUXSH+H7NXJi7Pg2eWYRkbsNF5QkBggK6xh
         3T8Og5eFyiiSTQzmTPgE3TpO3TTIBa3NbJSq9u0nCtrLFCbWmpJVWeOaKlj/WrA42Fxn
         LTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a2fhN1NcP29VAX6Q4kuHnoYPTW0IlOqHifPZstOm4mo=;
        b=Y2U0S/Ti4jqvY2mSGP8N/CyA0raGlNI50XhHBuqGUIRViRufEWzZ7rFZzhgHC5IQhl
         zer0+QnesU3wEPJbQBK7EIghDjnfudeB+4X0Gd11oOHsH1BlUR7Ky1CV6AyXQoRgfDiw
         LGLDnVLIxPrWeLHiE34ZyDP7oezTyB8M+obMlU2x80742yuo55JVJHZbVo6cnx5akfMF
         dU6QbCshvgQYoWPYtUgE+ZbWvXVFjyOcp2z/QeWLEAdNWmXBeDJa0n0LAp7SOFKHr5xC
         0Vmt7Lmd5A1E2EYJM7QPtlDUDjRAblka2um0gieWJMM69ktvNncKWUj+zNEvPR7HGY0l
         flTw==
X-Gm-Message-State: APjAAAW1eGiBQg5/v1v1/7AgMg2I6XGi0FMIq8rK5RC+3YkeD76oCa8g
        K6kvzwYA9OHbbT8XGsmUgWsjy94NR7R2Mwqf5KIdTA==
X-Google-Smtp-Source: APXvYqzoH/zqH0zVgfmZ7SrzRTTfX8La3Wn+15p5UKdCPhfC1viIQJ8QHtV6dTQPzQxiTvlGTgw/QngMDvTtPJdudiE=
X-Received: by 2002:a63:3006:: with SMTP id w6mr30960993pgw.440.1567522917541;
 Tue, 03 Sep 2019 08:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190903145536.3390-1-dja@axtens.net> <20190903145536.3390-6-dja@axtens.net>
In-Reply-To: <20190903145536.3390-6-dja@axtens.net>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 3 Sep 2019 17:01:46 +0200
Message-ID: <CAAeHK+w_HKVh___E0j3hctt_efSPR3PwKuO5XNpf=w5obfYSSA@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] kasan debug: track pages allocated for vmalloc shadow
To:     Daniel Axtens <dja@axtens.net>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>, gor@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 4:56 PM Daniel Axtens <dja@axtens.net> wrote:
>
> Provide the current number of vmalloc shadow pages in
> /sys/kernel/debug/kasan_vmalloc/shadow_pages.

Maybe it makes sense to put this into /sys/kernel/debug/kasan/
(without _vmalloc) and name e.g. vmalloc_shadow_pages? In case we want
to expose more generic KASAN debugging info later.

>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
>
> ---
>
> Merging this is probably overkill, but I leave it to the discretion
> of the broader community.
>
> On v4 (no dynamic freeing), I saw the following approximate figures
> on my test VM:
>
>  - fresh boot: 720
>  - after test_vmalloc: ~14000
>
> With v5 (lazy dynamic freeing):
>
>  - boot: ~490-500
>  - running modprobe test_vmalloc pushes the figures up to sometimes
>     as high as ~14000, but they drop down to ~560 after the test ends.
>     I'm not sure where the extra sixty pages are from, but running the
>     test repeately doesn't cause the number to keep growing, so I don't
>     think we're leaking.
>  - with vmap_stack, spawning tasks pushes the figure up to ~4200, then
>     some clearing kicks in and drops it down to previous levels again.
> ---
>  mm/kasan/common.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index e33cbab83309..e40854512417 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -35,6 +35,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/bug.h>
>  #include <linux/uaccess.h>
> +#include <linux/debugfs.h>
>
>  #include <asm/tlbflush.h>
>
> @@ -750,6 +751,8 @@ core_initcall(kasan_memhotplug_init);
>  #endif
>
>  #ifdef CONFIG_KASAN_VMALLOC
> +static u64 vmalloc_shadow_pages;
> +
>  static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
>                                       void *unused)
>  {
> @@ -776,6 +779,7 @@ static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
>         if (likely(pte_none(*ptep))) {
>                 set_pte_at(&init_mm, addr, ptep, pte);
>                 page = 0;
> +               vmalloc_shadow_pages++;
>         }
>         spin_unlock(&init_mm.page_table_lock);
>         if (page)
> @@ -829,6 +833,7 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
>         if (likely(!pte_none(*ptep))) {
>                 pte_clear(&init_mm, addr, ptep);
>                 free_page(page);
> +               vmalloc_shadow_pages--;
>         }
>         spin_unlock(&init_mm.page_table_lock);
>
> @@ -947,4 +952,25 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
>                                        (unsigned long)shadow_end);
>         }
>  }
> +
> +static __init int kasan_init_vmalloc_debugfs(void)
> +{
> +       struct dentry *root, *count;
> +
> +       root = debugfs_create_dir("kasan_vmalloc", NULL);
> +       if (IS_ERR(root)) {
> +               if (PTR_ERR(root) == -ENODEV)
> +                       return 0;
> +               return PTR_ERR(root);
> +       }
> +
> +       count = debugfs_create_u64("shadow_pages", 0444, root,
> +                                  &vmalloc_shadow_pages);
> +
> +       if (IS_ERR(count))
> +               return PTR_ERR(root);
> +
> +       return 0;
> +}
> +late_initcall(kasan_init_vmalloc_debugfs);
>  #endif
> --
> 2.20.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20190903145536.3390-6-dja%40axtens.net.
