Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A54C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043792173E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvSGJoct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387902AbfGPPHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 11:07:23 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36613 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbfGPPHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 11:07:23 -0400
Received: by mail-ot1-f68.google.com with SMTP id r6so21436592oti.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 08:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lKfULo1eMZAGbQNEWUso+2R41ym1FcQst15z8kTgQ38=;
        b=KvSGJocttM2XjFZf+K3n2VG2SKi6DPfEFmALEyNa1p3eeaWmxD+obERlIgbFxBvhdn
         2xhBR3ulUUE5RDGGe4l02cAdBlwtTdnw5KqCUtsY+4azVe/uAKZ3aWZ89Y3tDyTQA/HT
         oKBhDLRPdJMLY/szjejeTpH15eFwCns9xN/Yc/HFD3W29fbGg0kYcAKbgwNFzA9EzflI
         RzzxDafPGRMAXbN45a+tXzvGRAVB4P0A3recsHy+mK2oUReXBA6ms/Yr5k1vnGPz5Ud7
         YSP8U1Ud7AYdlBQJ0IsuirqRQCMIV2b7++Hs/NBzx4q5b+KZG25zXjqnyOkgucl5xHoV
         ttfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKfULo1eMZAGbQNEWUso+2R41ym1FcQst15z8kTgQ38=;
        b=KX0M92dqJj/R68NQRqFTrU8D7c2Cwr7/ZBnoZUXGyu7vyTBqdLGIlvGEYs/7qJRWyi
         YZuxYLUGyq3r+XVW05unHgfa+CKYvWLKeG+u6GUh4AIAaSFygetnEAfGt/HFIF2uuWcE
         EfUxqR67ziDavAL4Y5zI0QIZcmOTap+PI8Eh/dKKr8PtBeEo31xkpFZtALhbLPaXSrSR
         KsgPxWihe3RHBf1A25DqpoyaG5vCNY6f80up/nZE83ZXIZBatItpamG5hQ/Cos/m0EIE
         zYN90mz4gd6SQc+wR0xoQ42jEpIFK5hmW+c9zc6YORWWvgb6wqAVEjym1YnvT5brOVH7
         medw==
X-Gm-Message-State: APjAAAXCtSilxIamx4myWYk/tLJEXiH7PWMqCrdebNvGlc9U5eU5OlyK
        fv6DbovezvZOebWkp6A6M61USmPHMmCL8aGXp5E=
X-Google-Smtp-Source: APXvYqw0FwtLVnzp5TRrqVwvKN6i7mM+KAWSmD2nT7AzHAJsR+L8LJdJaNNa4X6wTVZO2BLpeNNDRDvTmQf7JjeT3tk=
X-Received: by 2002:a9d:73c4:: with SMTP id m4mr22945314otk.369.1563289642522;
 Tue, 16 Jul 2019 08:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190716132604.28289-1-lpf.vector@gmail.com> <20190716132604.28289-3-lpf.vector@gmail.com>
 <20190716143525.5vnnwh4m637dcb2f@pc636>
In-Reply-To: <20190716143525.5vnnwh4m637dcb2f@pc636>
From:   Pengfei Li <lpf.vector@gmail.com>
Date:   Tue, 16 Jul 2019 23:07:11 +0800
Message-ID: <CAD7_sbFNOOM-nmHRP9pJkfaXfZj6YO2rr0Q3zTM28-Xd70g_9w@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mm/vmalloc: modify struct vmap_area to reduce its size
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, rpenyaev@suse.de,
        peterz@infradead.org, guro@fb.com, rick.p.edgecombe@intel.com,
        rppt@linux.ibm.com, aryabinin@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:35 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Tue, Jul 16, 2019 at 09:26:04PM +0800, Pengfei Li wrote:
> > Objective
> > ---------
> > The current implementation of struct vmap_area wasted space.
> >
> > After applying this commit, sizeof(struct vmap_area) has been
> > reduced from 11 words to 8 words.
> >
> > Description
> > -----------
> > 1) Pack "subtree_max_size", "vm" and "purge_list".
> > This is no problem because
> >     A) "subtree_max_size" is only used when vmap_area is in
> >        "free" tree
> >     B) "vm" is only used when vmap_area is in "busy" tree
> >     C) "purge_list" is only used when vmap_area is in
> >        vmap_purge_list
> >
> > 2) Eliminate "flags".
> > Since only one flag VM_VM_AREA is being used, and the same
> > thing can be done by judging whether "vm" is NULL, then the
> > "flags" can be eliminated.
> >
> > Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
> > Suggested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  include/linux/vmalloc.h | 20 +++++++++++++-------
> >  mm/vmalloc.c            | 24 ++++++++++--------------
> >  2 files changed, 23 insertions(+), 21 deletions(-)
> >
> > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > index 9b21d0047710..a1334bd18ef1 100644
> > --- a/include/linux/vmalloc.h
> > +++ b/include/linux/vmalloc.h
> > @@ -51,15 +51,21 @@ struct vmap_area {
> >       unsigned long va_start;
> >       unsigned long va_end;
> >
> > -     /*
> > -      * Largest available free size in subtree.
> > -      */
> > -     unsigned long subtree_max_size;
> > -     unsigned long flags;
> >       struct rb_node rb_node;         /* address sorted rbtree */
> >       struct list_head list;          /* address sorted list */
> > -     struct llist_node purge_list;    /* "lazy purge" list */
> > -     struct vm_struct *vm;
> > +
> > +     /*
> > +      * The following three variables can be packed, because
> > +      * a vmap_area object is always one of the three states:
> > +      *    1) in "free" tree (root is vmap_area_root)
> > +      *    2) in "busy" tree (root is free_vmap_area_root)
> > +      *    3) in purge list  (head is vmap_purge_list)
> > +      */
> > +     union {
> > +             unsigned long subtree_max_size; /* in "free" tree */
> > +             struct vm_struct *vm;           /* in "busy" tree */
> > +             struct llist_node purge_list;   /* in purge list */
> > +     };
> >  };
> >
> >  /*
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 71d8040a8a0b..39bf9cf4175a 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -329,7 +329,6 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
> >  #define DEBUG_AUGMENT_PROPAGATE_CHECK 0
> >  #define DEBUG_AUGMENT_LOWEST_MATCH_CHECK 0
> >
> > -#define VM_VM_AREA   0x04
> >
> >  static DEFINE_SPINLOCK(vmap_area_lock);
> >  /* Export for kexec only */
> > @@ -1115,7 +1114,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> >
> >       va->va_start = addr;
> >       va->va_end = addr + size;
> > -     va->flags = 0;
> > +     va->vm = NULL;
> >       insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
> >
> >       spin_unlock(&vmap_area_lock);
> > @@ -1922,7 +1921,6 @@ void __init vmalloc_init(void)
> >               if (WARN_ON_ONCE(!va))
> >                       continue;
> >
> > -             va->flags = VM_VM_AREA;
> >               va->va_start = (unsigned long)tmp->addr;
> >               va->va_end = va->va_start + tmp->size;
> >               va->vm = tmp;
> > @@ -2020,7 +2018,6 @@ static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
> >       vm->size = va->va_end - va->va_start;
> >       vm->caller = caller;
> >       va->vm = vm;
> > -     va->flags |= VM_VM_AREA;
> >       spin_unlock(&vmap_area_lock);
> >  }
> >
> > @@ -2125,10 +2122,10 @@ struct vm_struct *find_vm_area(const void *addr)
> >       struct vmap_area *va;
> >
> >       va = find_vmap_area((unsigned long)addr);
> > -     if (va && va->flags & VM_VM_AREA)
> > -             return va->vm;
> > +     if (!va)
> > +             return NULL;
> >
> > -     return NULL;
> > +     return va->vm;
> >  }
> >
> >  /**
> > @@ -2149,11 +2146,10 @@ struct vm_struct *remove_vm_area(const void *addr)
> >
> >       spin_lock(&vmap_area_lock);
> >       va = __find_vmap_area((unsigned long)addr);
> > -     if (va && va->flags & VM_VM_AREA) {
> > +     if (va && va->vm) {
> >               struct vm_struct *vm = va->vm;
> >
> >               va->vm = NULL;
> > -             va->flags &= ~VM_VM_AREA;
> >               spin_unlock(&vmap_area_lock);
> >
> >               kasan_free_shadow(vm);
> > @@ -2856,7 +2852,7 @@ long vread(char *buf, char *addr, unsigned long count)
> >               if (!count)
> >                       break;
> >
> > -             if (!(va->flags & VM_VM_AREA))
> > +             if (!va->vm)
> >                       continue;
> >
> >               vm = va->vm;
> > @@ -2936,7 +2932,7 @@ long vwrite(char *buf, char *addr, unsigned long count)
> >               if (!count)
> >                       break;
> >
> > -             if (!(va->flags & VM_VM_AREA))
> > +             if (!va->vm)
> >                       continue;
> >
> >               vm = va->vm;
> > @@ -3466,10 +3462,10 @@ static int s_show(struct seq_file *m, void *p)
> >       va = list_entry(p, struct vmap_area, list);
> >
> >       /*
> > -      * s_show can encounter race with remove_vm_area, !VM_VM_AREA on
> > -      * behalf of vmap area is being tear down or vm_map_ram allocation.
> > +      * If !va->vm then this vmap_area object is allocated
> > +      * by vm_map_ram.
> >        */
> This point is still valid. There is a race between remove_vm_area() vs
> s_show() and va->vm = NULL. So, please keep that comment.
>

Thank you.
I will keep the comment in the next version.

> > -     if (!(va->flags & VM_VM_AREA)) {
> > +     if (!va->vm) {
> >               seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
> >                       (void *)va->va_start, (void *)va->va_end,
> >                       va->va_end - va->va_start);
> > --
> > 2.21.0
> >
>
> --
> Vlad Rezki
