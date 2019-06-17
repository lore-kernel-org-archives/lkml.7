Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38018C31E5D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA902086A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfFQOvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:51:06 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34717 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfFQOvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:51:06 -0400
Received: by mail-qk1-f195.google.com with SMTP id t8so6341995qkt.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 07:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q8FJ2kwlqp+MobuH8TFvTjKHjPn6ix+Pc/KnlT4DZoQ=;
        b=F81NtuSqp5lEzf4o6xzOWNCxy+wYhEmiOcLlKEECM5ISEgE+U+JKCXOW2yaJ9rqZwj
         G7w0+9eYdisTBdG2Scm1NE38Y4/9ToKy4ITnV8Z7b7jf9NK0oumm/2MmPjpaxvygIiiI
         BaGSe0AP7W2FaPp077RHjf7FZZYXGubyhg+X9ExbK/PNw2I0NVpVlbV3+3RuGnStgQxv
         sTNiQPDL6WJ1+rLrUyG9U/Ns6gTD4/fS123t92k3ZGX9egdVa/muGIn68MW4rjfEWfty
         Mk3vr6mI3p2RiYAoK9O2ITJx7+vnzuGLoMUXjz6Uv1bvzfIxlxODD5ilgbD0LDMx5iDB
         3Vjw==
X-Gm-Message-State: APjAAAUiQxQNN9srHwGQNG9SnB23kZZVMPhA12ZGMuKCvZXoIGiBsEg9
        W21lxr+IUgSpujck8FzS7yQP/UaXxqPckSh8FbE=
X-Google-Smtp-Source: APXvYqzGHPK0SuAOiFmF36ZCL+V6bBx3pWjrebtOkfLE1KzmEr0hyrwu/CO4hn9QYjNX0GmKoAn1mJ5RYvF4ApuHWDg=
X-Received: by 2002:ae9:e608:: with SMTP id z8mr80517080qkf.182.1560783065346;
 Mon, 17 Jun 2019 07:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190617121427.77565-1-arnd@arndb.de> <20190617141244.5x22nrylw7hodafp@pc636>
 <CAK8P3a3sjuyeQBUprGFGCXUSDAJN_+c+2z=pCR5J05rByBVByQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3sjuyeQBUprGFGCXUSDAJN_+c+2z=pCR5J05rByBVByQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 17 Jun 2019 16:50:48 +0200
Message-ID: <CAK8P3a0pnEnzfMkCi7Nb97-nG4vnAj7fOepfOaW0OtywP8TLpw@mail.gmail.com>
Subject: Re: [BUG]: mm/vmalloc: uninitialized variable access in pcpu_get_vm_areas
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Roman Penyaev <rpenyaev@suse.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 4:44 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jun 17, 2019 at 4:12 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > On Mon, Jun 17, 2019 at 02:14:11PM +0200, Arnd Bergmann wrote:
> > > gcc points out some obviously broken code in linux-next
> > >
> > > mm/vmalloc.c: In function 'pcpu_get_vm_areas':
> > > mm/vmalloc.c:991:4: error: 'lva' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> > >     insert_vmap_area_augment(lva, &va->rb_node,
> > >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >      &free_vmap_area_root, &free_vmap_area_list);
> > >      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > mm/vmalloc.c:916:20: note: 'lva' was declared here
> > >   struct vmap_area *lva;
> > >                     ^~~
> > >
> > > Remove the obviously broken code. This is almost certainly
> > > not the correct solution, but it's what I have applied locally
> > > to get a clean build again.
> > >
> > > Please fix this properly.
> > >
>
> > >
> > Please do not apply this. It will just break everything.
>
> As I wrote in my description, this was purely meant as a bug
> report, not a patch to be applied.
>
> > As Roman pointed we can just set lva = NULL; in the beginning to make GCC happy.
> > For some reason GCC decides that it can be used uninitialized, but that
> > is not true.
>
> I got confused by the similarly named FL_FIT_TYPE/NE_FIT_TYPE
> constants and misread this as only getting run in the case where it is
> not initialized, but you are right that it always is initialized here.
>
> I see now that the actual cause of the warning is the 'while' loop in
> augment_tree_propagate_from(). gcc is unable to keep track of
> the state of the 'lva' variable beyond that and prints a bogus warning.

I managed to un-confuse gcc-8 by turning the if/else if/else into
a switch statement. If you all think this is an acceptable solution,
I'll submit that after some more testing to ensure it addresses
all configurations:

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a9213fc3802d..5b7e50de008b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -915,7 +915,8 @@ adjust_va_to_fit_type(struct vmap_area *va,
 {
        struct vmap_area *lva;

-       if (type == FL_FIT_TYPE) {
+       switch (type) {
+       case FL_FIT_TYPE:
                /*
                 * No need to split VA, it fully fits.
                 *
@@ -925,7 +926,8 @@ adjust_va_to_fit_type(struct vmap_area *va,
                 */
                unlink_va(va, &free_vmap_area_root);
                kmem_cache_free(vmap_area_cachep, va);
-       } else if (type == LE_FIT_TYPE) {
+               break;
+       case LE_FIT_TYPE:
                /*
                 * Split left edge of fit VA.
                 *
@@ -934,7 +936,8 @@ adjust_va_to_fit_type(struct vmap_area *va,
                 * |-------|-------|
                 */
                va->va_start += size;
-       } else if (type == RE_FIT_TYPE) {
+               break;
+       case RE_FIT_TYPE:
                /*
                 * Split right edge of fit VA.
                 *
@@ -943,7 +946,8 @@ adjust_va_to_fit_type(struct vmap_area *va,
                 * |-------|-------|
                 */
                va->va_end = nva_start_addr;
-       } else if (type == NE_FIT_TYPE) {
+               break;
+       case NE_FIT_TYPE:
                /*
                 * Split no edge of fit VA.
                 *
@@ -980,7 +984,8 @@ adjust_va_to_fit_type(struct vmap_area *va,
                 * Shrink this VA to remaining size.
                 */
                va->va_start = nva_start_addr + size;
-       } else {
+               break;
+       default:
                return -1;
        }

       Arnd
