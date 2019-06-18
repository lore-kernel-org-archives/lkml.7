Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DDDC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CB8213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QooPXmn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfFRNkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:40:41 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34598 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbfFRNkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:40:40 -0400
Received: by mail-qk1-f194.google.com with SMTP id t8so8569074qkt.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 06:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZI5wHdiFgtuzsQeLY+E22h5PJMnK0tB2yGyNBxZfSqI=;
        b=QooPXmn9aHah5NAlG4PfOfya5KeBRPEo/cvd64QxdYAB2AkodS68j+GjfPi84y88a8
         DuB0moLc60pdiekoXOCOsAxtghv/tzyS0Zmk+0MTZYsCOMvXwdivw9V7wUKoLv6q4Axg
         5s6bDCqaOyBCLr0QLrvUxRJ36c87CczbZqr7489CDIbk5w73LorhbzV6/p+ILdWmi3EO
         QBo9JXpFB/Ht4FqcBxvorRa1+QvlOIMjcuwGXXSs2RW1sMA4cGX4JDaIo7BcsPKhNArX
         7PXLzk7LUCtr49cSwuHKA+oMLhBIasoWAkwIyRCAeENSKRYKtox2kQoezDn3ZK5Mwul7
         Q7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZI5wHdiFgtuzsQeLY+E22h5PJMnK0tB2yGyNBxZfSqI=;
        b=iGqRE13xAKQhYLuPV1EqgRcrYp9V4eWdIqBitFMmV1NUedOjsRg/Ez2aBm1Utx48dq
         fkyKV48lgLJtxazso8QbsAjM7LRp8EWsg2EucCazlyViPZ9rEIGm+WyCrCD4UwH53f+q
         aU/ZmH9WMiz50CG9EvuEg5IHcELYKYpCLwDI+9c7u62ZPqL+HJ7iKXRhh/3kRL0zGb7P
         xhq0uS7PbAGAZrMNEBuVfnCtzIcpQJZhCbJ4XvU+9LDjCn8Lmo0l9fAYehGKlHBEMAP5
         5UJjcS6RsnWzPHtJlaTwvYbnpVidSy83sbHx/abSx8hpR95KxLcF46ECFfavykGo9Zmg
         dufw==
X-Gm-Message-State: APjAAAWav3Vopoynh1NWbOUtlP6opQRWgbeAF9tYffU6L1fvp2BJdRux
        XK3vx2utWQ4mR6LLZCFQhEZnY5MZvjrWg4IBPmmcBA==
X-Google-Smtp-Source: APXvYqydIfBeJNwoqU7hLKDek16QVNj311nTvALhVsaWemQl/rKnPG8IXP59Ccqe5Lnh87RqflvTK1whFaMyh7g4f+8=
X-Received: by 2002:a37:696:: with SMTP id 144mr91098200qkg.250.1560865239273;
 Tue, 18 Jun 2019 06:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190618092650.2943749-1-arnd@arndb.de>
In-Reply-To: <20190618092650.2943749-1-arnd@arndb.de>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 18 Jun 2019 09:40:28 -0400
Message-ID: <CAJWu+oqzd8MJqusRV0LAK=Xnm7VSRSu3QbNZ-j5h9_MbzcFhhg@mail.gmail.com>
Subject: Re: [PATCH] mm/vmalloc: avoid bogus -Wmaybe-uninitialized warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 5:27 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> gcc gets confused in pcpu_get_vm_areas() because there are too many
> branches that affect whether 'lva' was initialized before it gets
> used:
>
> mm/vmalloc.c: In function 'pcpu_get_vm_areas':
> mm/vmalloc.c:991:4: error: 'lva' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>     insert_vmap_area_augment(lva, &va->rb_node,
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      &free_vmap_area_root, &free_vmap_area_list);
>      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> mm/vmalloc.c:916:20: note: 'lva' was declared here
>   struct vmap_area *lva;
>                     ^~~
>
> Add an intialization to NULL, and check whether this has changed
> before the first use.
>
> Fixes: 68ad4a330433 ("mm/vmalloc.c: keep track of free blocks for vmap allocation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/vmalloc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a9213fc3802d..42a6f795c3ee 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -913,7 +913,12 @@ adjust_va_to_fit_type(struct vmap_area *va,
>         unsigned long nva_start_addr, unsigned long size,
>         enum fit_type type)
>  {
> -       struct vmap_area *lva;
> +       /*
> +        * GCC cannot always keep track of whether this variable
> +        * was initialized across many branches, therefore set
> +        * it NULL here to avoid a warning.
> +        */
> +       struct vmap_area *lva = NULL;

Fair enough, but is this 5-line comment really needed here?

- Joel
