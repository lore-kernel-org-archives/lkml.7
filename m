Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD865C06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACF8218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRsVmLHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfGDJbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 05:31:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41154 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfGDJbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:31:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so5346765ota.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 02:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=81qzDNnuUWXeeKG5ggbworMMEY0MTN6GujxFNt/FSKY=;
        b=PRsVmLHYYokfq1dAWNfZbXfAw/fqsNWpYh3uV3l/g68KONC8Oig3Sq4ok+8fTFtb5U
         m+mMKk5caDAp/3QjJdljekiK+pC03tUk9uzWYWGlbECBUWbnXDWLCrWKkjj6hsOFkJPl
         ZTIyCBDVxixFNks3FPtXldjqjaKC1fuAa4yZvkt0NAA/xnnSLgKbQfFc/SpDLKLp3yCa
         ZAprvC57Z2fcGxs5K5pTV/11h4CUBUOSKL2Snp4snyHsIzWabfThd2nU2EZ0v8sIKfqd
         Gif5b2UOxVPVAFJfMdsNCR0MMcPcidSeRlU8w86XXkIkEHtNxOT2tptV5Ajrr1flg7Gd
         qmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81qzDNnuUWXeeKG5ggbworMMEY0MTN6GujxFNt/FSKY=;
        b=jwzU1XoMm7uiR1A2r0ZW8xLBWJ1rNjfh6IGgwf7GIrI0uWWpWD2/wvov2uprkv9w8K
         zvuBfNASog0lTiaPp70Czl8QAug1ZDzDKmZGFzvxAXAYjuCSgSL1HtjlIBCwDLmK1M34
         vdpBxZ3skzAhzHZJ8PWxvfS7Z14WaQRQxPfeO4OaBeMrnyrIzYXWsh2Zff2byQGZM1ac
         9sdHsw+SOfNT52Uef4AfEe3bvQjyqwlcy1MZsY/XEvw8P1wWe3UsEQXhpTsk6LHQDSyg
         6vTawYhnB/CRVnp+lIVC04YwSXwxcvhPMcd9JwEo26l5OxTsnpEFOq3g6KXzfma1caaS
         8nmQ==
X-Gm-Message-State: APjAAAXK+fhWUfJZGWNZ2D5hJjmK0zhHec0zZvJXPFdSbrLPyPnVleyB
        gj3ecjmXESy2CswaIvLNmtpVsI4fD0zlApzzydE=
X-Google-Smtp-Source: APXvYqze2xsXujbeNbNbw8cpCmEutfUMYGbnvnrymsCSndKtBHHCMeJ+vzrksgLBW9mRoeVoAJvFhadPs958WKD3LiY=
X-Received: by 2002:a9d:73c4:: with SMTP id m4mr15813610otk.369.1562232675969;
 Thu, 04 Jul 2019 02:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190702141541.12635-1-lpf.vector@gmail.com> <20190703193035.xsbdspgeiwzoo7aa@pc636>
In-Reply-To: <20190703193035.xsbdspgeiwzoo7aa@pc636>
From:   Pengfei Li <lpf.vector@gmail.com>
Date:   Thu, 4 Jul 2019 17:31:04 +0800
Message-ID: <CAD7_sbFi+KY-pH+2RZTq29qpBukvqZcC0xuB-7EJ_WNPP84bjQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm/vmalloc.c: improve readability and rewrite vmap_area
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     akpm@linux-foundation.org, peterz@infradead.org, rpenyaev@suse.de,
        mhocko@suse.com, guro@fb.com, aryabinin@virtuozzo.com,
        rppt@linux.ibm.com, mingo@kernel.org, rick.p.edgecombe@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 3:30 AM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> Hello, Li.
>
> I do not think that it is worth to reduce the struct size the way
> this series does. I mean the union around flags/va_start. Simply saying
> if we need two variables: flags and va_start let's have them. Otherwise
> everybody has to think what he/she access at certain moment of time.
>
> So it would be easier to make mistakes, also that conversion looks strange
> to me. That is IMHO.
>
> If we want to reduce the size to L1-cache-line(64 bytes), i would propose to
> eliminate the "flags" variable from the structure. We could do that if apply
> below patch(as an example) on top of https://lkml.org/lkml/2019/7/3/661:
>

Hi, Vlad

Thank you for your detailed comments!

What you said inspired me. I really have no reason to stubbornly
keep the "flags" in vmap_area since it can be eliminated.

I will eliminate the "flags" from vmap_area as you suggested, and
the next version will be based on top of your commit
https://lkml.org/lkml/2019/7/3/661.


-- 
Pengfei

> <snip>
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 51e131245379..49bb82863d5b 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -51,15 +51,22 @@ struct vmap_area {
>         unsigned long va_start;
>         unsigned long va_end;
>
> -       /*
> -        * Largest available free size in subtree.
> -        */
> -       unsigned long subtree_max_size;
> -       unsigned long flags;
>         struct rb_node rb_node;         /* address sorted rbtree */
>         struct list_head list;          /* address sorted list */
> -       struct llist_node purge_list;    /* "lazy purge" list */
> -       struct vm_struct *vm;
> +
> +       /*
> +        * Below three variables can be packed, because vmap_area
> +        * object can be only in one of the three different states:
> +        *
> +        * - when an object is in "free" tree only;
> +        * - when an object is in "purge list" only;
> +        * - when an object is in "busy" tree only.
> +        */
> +       union {
> +               unsigned long subtree_max_size;
> +               struct llist_node purge_list;
> +               struct vm_struct *vm;
> +       };
>  };
>
>  /*
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6f1b6a188227..e389a6db222b 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -329,8 +329,6 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
>  #define DEBUG_AUGMENT_PROPAGATE_CHECK 0
>  #define DEBUG_AUGMENT_LOWEST_MATCH_CHECK 0
>
> -#define VM_VM_AREA     0x04
> -
>  static DEFINE_SPINLOCK(vmap_area_lock);
>  /* Export for kexec only */
>  LIST_HEAD(vmap_area_list);
> @@ -1108,7 +1106,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>
>         va->va_start = addr;
>         va->va_end = addr + size;
> -       va->flags = 0;
> +       va->vm = NULL;
>         insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
>
>         spin_unlock(&vmap_area_lock);
> @@ -1912,7 +1910,6 @@ void __init vmalloc_init(void)
>                 if (WARN_ON_ONCE(!va))
>                         continue;
>
> -               va->flags = VM_VM_AREA;
>                 va->va_start = (unsigned long)tmp->addr;
>                 va->va_end = va->va_start + tmp->size;
>                 va->vm = tmp;
> @@ -2010,7 +2007,6 @@ static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
>         vm->size = va->va_end - va->va_start;
>         vm->caller = caller;
>         va->vm = vm;
> -       va->flags |= VM_VM_AREA;
>         spin_unlock(&vmap_area_lock);
>  }
>
> @@ -2115,7 +2111,7 @@ struct vm_struct *find_vm_area(const void *addr)
>         struct vmap_area *va;
>
>         va = find_vmap_area((unsigned long)addr);
> -       if (va && va->flags & VM_VM_AREA)
> +       if (va && va->vm)
>                 return va->vm;
>
>         return NULL;
> @@ -2139,11 +2135,10 @@ struct vm_struct *remove_vm_area(const void *addr)
>
>         spin_lock(&vmap_area_lock);
>         va = __find_vmap_area((unsigned long)addr);
> -       if (va && va->flags & VM_VM_AREA) {
> +       if (va && va->vm) {
>                 struct vm_struct *vm = va->vm;
>
>                 va->vm = NULL;
> -               va->flags &= ~VM_VM_AREA;
>                 spin_unlock(&vmap_area_lock);
>
>                 kasan_free_shadow(vm);
> @@ -2854,7 +2849,7 @@ long vread(char *buf, char *addr, unsigned long count)
>                 if (!count)
>                         break;
>
> -               if (!(va->flags & VM_VM_AREA))
> +               if (!va->vm)
>                         continue;
>
>                 vm = va->vm;
> @@ -2934,7 +2929,7 @@ long vwrite(char *buf, char *addr, unsigned long count)
>                 if (!count)
>                         break;
>
> -               if (!(va->flags & VM_VM_AREA))
> +               if (!va->vm)
>                         continue;
>
>                 vm = va->vm;
> @@ -3464,10 +3459,10 @@ static int s_show(struct seq_file *m, void *p)
>         va = list_entry(p, struct vmap_area, list);
>
>         /*
> -        * s_show can encounter race with remove_vm_area, !VM_VM_AREA on
> -        * behalf of vmap area is being tear down or vm_map_ram allocation.
> +        * s_show can encounter race with remove_vm_area, !vm on behalf
> +        * of vmap area is being tear down or vm_map_ram allocation.
>          */
> -       if (!(va->flags & VM_VM_AREA)) {
> +       if (!va->vm) {
>                 seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
>                         (void *)va->va_start, (void *)va->va_end,
>                         va->va_end - va->va_start);
> <snip>
>
> urezki@pc636:~/data/ssd/coding/linux-stable$ pahole -C vmap_area mm/vmalloc.o
> die__process_function: tag not supported (INVALID)!
> struct vmap_area {
>         long unsigned int          va_start;             /*     0     8 */
>         long unsigned int          va_end;               /*     8     8 */
>         struct rb_node             rb_node;              /*    16    24 */
>         struct list_head           list;                 /*    40    16 */
>         union {
>                 long unsigned int  subtree_max_size;     /*           8 */
>                 struct llist_node  purge_list;           /*           8 */
>                 struct vm_struct * vm;                   /*           8 */
>         };                                               /*    56     8 */
>         /* --- cacheline 1 boundary (64 bytes) --- */
>
>         /* size: 64, cachelines: 1, members: 5 */
> };
> urezki@pc636:~/data/ssd/coding/linux-stable$
>
> --
> Vlad Rezki
