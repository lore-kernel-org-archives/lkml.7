Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6211C31E58
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B4D2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfFQOEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:04:33 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39421 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfFQOEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:04:33 -0400
Received: by mail-qk1-f193.google.com with SMTP id i125so6210390qkd.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 07:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wyv3XjYWUgnOQsz9LKXunlG3ze5V59yjJvNLNW3SDc4=;
        b=osu0T/BdkyNpMxcNRfBD/GJpfUx8yuedOZT1OddUutDvsUdkHXAZ8zZUqr9raggWlq
         U+SIbEVFt11QPw8732HvKKU8pmmyqjYfYfWqkBUBqeSBzgcHUQL4tH9ryjsOmJsmdkks
         v2cUFtZLx8cA0fEnN3WdkYgQfbpWOCJ+pxnuGTnZdaqXz7iZBKaFLxgoI5PwW66aH6i/
         7+6IC0VfSokvvPfPNj99ssi5UZyMvYSoGyA2xXeYd8f5CZviv+Uqc//63VqtevYm8/r+
         VdzEW4EaYOITKt5TUzDMBtOz4+1UKifF5obPBpIX1Vj5ktZ4n5XkDzZ8lRXuEuAlFMff
         D/6w==
X-Gm-Message-State: APjAAAW0/IlDPf27ZkmpGE57FJIxPR7Sucp517x9lkpkmpQgrxc9ayVN
        rh7yWNtknhsTOWhM/AiUSFsEzSTSNLbupnCzkF4=
X-Google-Smtp-Source: APXvYqxfILWhAdKXQ4OWbwL16dTg8+0rppOl294W+m7hdTdNP3jcvSOtAIQCjQ3rZPM0axb4x4PZsoZRGkPIyUFm8U8=
X-Received: by 2002:ae9:e608:: with SMTP id z8mr80292298qkf.182.1560780272294;
 Mon, 17 Jun 2019 07:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190617121427.77565-1-arnd@arndb.de> <457d8e5e453a18faf358bc1360a19003@suse.de>
In-Reply-To: <457d8e5e453a18faf358bc1360a19003@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 17 Jun 2019 16:04:14 +0200
Message-ID: <CAK8P3a0+jOW==OOx_CLj=TCsG5EBK2ni6kw1+PexJLAC2NEp_g@mail.gmail.com>
Subject: Re: [BUG]: mm/vmalloc: uninitialized variable access in pcpu_get_vm_areas
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
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

On Mon, Jun 17, 2019 at 3:49 PM Roman Penyaev <rpenyaev@suse.de> wrote:
> >               augment_tree_propagate_from(va);
> >
> > -             if (type == NE_FIT_TYPE)
> > -                     insert_vmap_area_augment(lva, &va->rb_node,
> > -                             &free_vmap_area_root, &free_vmap_area_list);
> > -     }
> > -
> >       return 0;
> >  }
>
>
> Hi Arnd,
>
> Seems the proper fix is just setting lva to NULL.  The only place
> where lva is allocated and then used is when type == NE_FIT_TYPE,
> so according to my shallow understanding of the code everything
> should be fine.

I don't see how NULL could work here. insert_vmap_area_augment()
passes the va pointer into find_va_links() and link_va(), both of
which dereference the pointer, see

static void
insert_vmap_area_augment(struct vmap_area *va,
        struct rb_node *from, struct rb_root *root,
        struct list_head *head)
{
        struct rb_node **link;
        struct rb_node *parent;

        if (from)
                link = find_va_links(va, NULL, from, &parent);
        else
                link = find_va_links(va, root, NULL, &parent);

        link_va(va, root, parent, link, head);
        augment_tree_propagate_from(va);
}

static __always_inline struct rb_node **
find_va_links(struct vmap_area *va,
        struct rb_root *root, struct rb_node *from,
        struct rb_node **parent)
{
       ...
                       if (va->va_start < tmp_va->va_end &&
                                va->va_end <= tmp_va->va_start)
       ...
}

static __always_inline void
link_va(struct vmap_area *va, struct rb_root *root,
        struct rb_node *parent, struct rb_node **link, struct list_head *head)
{
        ...
        rb_link_node(&va->rb_node, parent, link);
        ...
}

       Arnd
