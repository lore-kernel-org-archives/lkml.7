Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABD8C31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BBF20833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfFQOpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:45:07 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45203 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfFQOpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:45:07 -0400
Received: by mail-qt1-f194.google.com with SMTP id j19so10943325qtr.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 07:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ZuDMi3lli8OO05kFY206yEp9wlXM0BbyA8+D2np9Sw=;
        b=c2dDsSljvRvu1LWNQzX3FwHsKsagO9LB70uV9oWbWjk0RwNErgVgyELx0v2BZO07on
         ugbJtGMfuP/BKFgr67KuLhrvOtY4Dl+UfnV3UKDh7T8VHb5zMCyYdP981O2XhqHnL8Qr
         FCOJlVP0qUuuyTFc8tU5tqUFNNnb3NcpVndHgLcrlSbH/wZSTeDlJqyK7HEWwIfaY0Gt
         rmzAM47YiHN22q8ybluwLG4a8XSGvs/jT0qZkxQlsoBHIu6b7wRhE8kjvlRWFdSmuaNV
         JskjecPSSWgQlbzUss2bQ2/3MyfeRqpEvWJ99njuDW3Bhh2QJsztlS8S5Dz43jUb4Nbz
         IQUQ==
X-Gm-Message-State: APjAAAWgnQ9xQjHzMH9m3DO4/ZqESJ59Hbjl5LROwP/yL8+H84drYyN1
        TfnQKI2mPBHjBIn5mbKQo518LZdVlN7TDk7arWo=
X-Google-Smtp-Source: APXvYqy9Ua2AlWMGNVTT5MH9RdtUYwxp9mnEiPm+6tBRLWINKiftc1eLzmlvbDFk91T4uD74kg4HJbkksF88ISPUJ+s=
X-Received: by 2002:ac8:3485:: with SMTP id w5mr17348190qtb.142.1560782706039;
 Mon, 17 Jun 2019 07:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190617121427.77565-1-arnd@arndb.de> <20190617141244.5x22nrylw7hodafp@pc636>
In-Reply-To: <20190617141244.5x22nrylw7hodafp@pc636>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 17 Jun 2019 16:44:49 +0200
Message-ID: <CAK8P3a3sjuyeQBUprGFGCXUSDAJN_+c+2z=pCR5J05rByBVByQ@mail.gmail.com>
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

On Mon, Jun 17, 2019 at 4:12 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Mon, Jun 17, 2019 at 02:14:11PM +0200, Arnd Bergmann wrote:
> > gcc points out some obviously broken code in linux-next
> >
> > mm/vmalloc.c: In function 'pcpu_get_vm_areas':
> > mm/vmalloc.c:991:4: error: 'lva' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> >     insert_vmap_area_augment(lva, &va->rb_node,
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >      &free_vmap_area_root, &free_vmap_area_list);
> >      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > mm/vmalloc.c:916:20: note: 'lva' was declared here
> >   struct vmap_area *lva;
> >                     ^~~
> >
> > Remove the obviously broken code. This is almost certainly
> > not the correct solution, but it's what I have applied locally
> > to get a clean build again.
> >
> > Please fix this properly.
> >

> >
> Please do not apply this. It will just break everything.

As I wrote in my description, this was purely meant as a bug
report, not a patch to be applied.

> As Roman pointed we can just set lva = NULL; in the beginning to make GCC happy.
> For some reason GCC decides that it can be used uninitialized, but that
> is not true.

I got confused by the similarly named FL_FIT_TYPE/NE_FIT_TYPE
constants and misread this as only getting run in the case where it is
not initialized, but you are right that it always is initialized here.

I see now that the actual cause of the warning is the 'while' loop in
augment_tree_propagate_from(). gcc is unable to keep track of
the state of the 'lva' variable beyond that and prints a bogus warning.

        Arnd
