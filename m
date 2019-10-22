Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2C3CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE742166E
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gUPc3+r0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbfJVC1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 22:27:22 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38639 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730271AbfJVC1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:27:21 -0400
Received: by mail-qk1-f193.google.com with SMTP id p4so14868397qkf.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 19:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VN4XOQxWZMWnSTs2Dh2Lw0yjzpEOfDxml7hxLuxIwLs=;
        b=gUPc3+r0SNz5/3BwEP/jyh2XSQNeJOemtUsONV716BzuDnty9pw46TrLUwK6o1cscy
         8uXKN3QbQeDI4bNQJbBIPchpNZXoFUU5P+ci1bZd9YXOaeNT7UMcp6y3sB0Y17A/Dq6s
         Du4/0ZaY520ok4LbWICjEYsktLstQJ6TxDDt99B9okzfv2X4Q+MZ3cyoIk2QHSHRXoCF
         YzwKH4T9VELi04rhOhLbFInmRMfP2vjAVoCyc41Vz/WcbXKrNB1g/4pHEH6IL/2uK0/5
         Gttu/YQGKgixxsJnaXKUoUyu1+sHU/YFbVoPgt0YQKXWJM4XvxbvNXCiyhz5euildoC1
         h/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VN4XOQxWZMWnSTs2Dh2Lw0yjzpEOfDxml7hxLuxIwLs=;
        b=kcHSpmSmDEkO9mE1fSG1B3ZlHLCjKf2pPzJvMIdZLW/afUTP20QCPvm7gh01X58KpZ
         RixLFrdZAQe0DH4jsEjs0n6exNyR9m4Yk8GkX10PKDURwdoz5LednVij9ilsjaQeDh4z
         sYe1RywMVzGwU/tezmOODgfYR3VBUpROoUSSmE5LcasAYrNlCyvEZuneHlt/4fKQiZao
         rYVZTmbffux5bw1chqbFnWNG50gqLcs43EsmhNFmVcZ0KEH8iWnk7NXbT8Fg0k5abQuh
         u5BwgnxZzpo/VElO218Bx55oU82WE3fZysBcF45HdsJEa7W5hSjWT/fsdHHgh/1UCHbn
         hbqA==
X-Gm-Message-State: APjAAAWSFZiEymo9h8K89diSc26I/2LZcf/jbRLgK2j67pOQdZVu+KY9
        3C9hgyDsEz1ChG6fUiwkRIHLbXdTdOh0IOAvjla1OQ==
X-Google-Smtp-Source: APXvYqzli1POTBKn0kITztaQ0CotLZWI9kuTgVDX+qwQpn+d/fAMU56WobWzNiniZRveIUy3KQbdmwei73fofxuITjk=
X-Received: by 2002:a37:4a87:: with SMTP id x129mr908751qka.43.1571711240126;
 Mon, 21 Oct 2019 19:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191022021810.3216-1-lyude@redhat.com>
In-Reply-To: <20191022021810.3216-1-lyude@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 22 Oct 2019 04:27:08 +0200
Message-ID: <CACT4Y+YQf-aje4jqSMop24af_GO8G_oPMfrJ9B7oo5_EudwHow@mail.gmail.com>
Subject: Re: [RFC] kasan: include the hashed pointer for an object's location
To:     Lyude Paul <lyude@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Sean Paul <sean@poorly.run>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 4:19 AM Lyude Paul <lyude@redhat.com> wrote:
>
> The vast majority of the kernel that needs to print out pointers as a
> way to keep track of a specific object in the kernel for debugging
> purposes does so using hashed pointers, since these are "good enough".
> Ironically, the one place we don't do this is within kasan. While
> simply printing a hashed version of where an out of bounds memory access
> occurred isn't too useful, printing out the hashed address of the object
> in question usually is since that's the format most of the kernel is
> likely to be using in debugging output.
>
> Of course this isn't perfect though-having the object's originating
> address doesn't help users at all that need to do things like printing
> the address of a struct which is embedded within another struct, but
> it's certainly better then not printing any hashed addresses. And users
> which need to handle less trivial cases like that can simply fall back
> to careful usage of %px.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: kasan-dev@googlegroups.com
> ---
>  mm/kasan/report.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 621782100eaa..0a5663fee1f7 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -128,8 +128,9 @@ static void describe_object_addr(struct kmem_cache *cache, void *object,
>         int rel_bytes;
>
>         pr_err("The buggy address belongs to the object at %px\n"
> -              " which belongs to the cache %s of size %d\n",
> -               object, cache->name, cache->object_size);
> +              " (aka %p) which belongs to the cache\n"
> +              " %s of size %d\n",
> +              object, object, cache->name, cache->object_size);

Hi Lyude,

This only prints hashed address for heap objects, but
print_address_description() has 4 different code paths for different
types of addresses (heap, global, stack, page). Plus there is a case
for address without shadow.
Should we print the hashed address at least for all cases in
print_address_description()?


>         if (!addr)
>                 return;
> --
> 2.21.0
>
