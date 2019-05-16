Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DFEC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 07:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4E62082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 07:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJk9HEnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfEPHbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 03:31:02 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46310 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEPHbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 03:31:01 -0400
Received: by mail-yb1-f195.google.com with SMTP id z22so219715ybi.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 00:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GVt+8/S9xZlwwkWG1PlPMVhqKME8gM7ABoyAssUfp34=;
        b=eJk9HEnZpy5U2y9EOA7OmV1mUJO7aXYGKOLcDadFsBWNQc3uC60k3YTQ1Uh006P22q
         bifZARk7Fh+rzkH9ZrqlL8cB9coRlD+p9X4cAFVCoJW4TSMWFXCU9HlUiUtWyLgXA5g0
         sMfgmVrGwO1UY8tRU1fQDwUo9b+G8PGgMT7tcVeCyc/qNb/3KfqBagoV5sSvAsK5+6zf
         B94OBTVPtZ/UmOHM/+iWfYdeQlt2UasXOkcV5dSG0v4v6xzSDXkM3mSl/vn2wiaQu6rZ
         J9ZTi5excR5pK2J2z2bvodQHWhrvt5yHXhRW3He2ahkcwP4/WUCNnfW7YmqPVS+NVM1K
         8BeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GVt+8/S9xZlwwkWG1PlPMVhqKME8gM7ABoyAssUfp34=;
        b=KTLVBMgRWUFqY3DqfdVblnQ33CsoEFNiayFHMPZ0EPcw2fBZfge/EClEwtOVnCz22z
         PvnfKTBA6Ksx/hBptvbW9YIaj51zo9Xp7rCeqDx/smTZTcAcDIQJmB9T+QV+5qeCg4ma
         6eECA4Rtj4T8GQAIuRUi29TLYEMpQB/BA9W6hQbB6+ACIS1AwVjPpcCaGUj+RuZ+NfHm
         eZnDYWFBr1XTlG+5Jnmgbvwjghcawpjo7zCuBeRgLvokibM1U9zYJ6fTBKbkLH+NJVPe
         mRWYO1bdKrPHBWLvU0BZHA2bUU/ZkES95R14fMpNysY7bWakAMmEPC+GkQKNenPUXY5Z
         QrlA==
X-Gm-Message-State: APjAAAW3Dbfk5L+6XSLJNeNWGA5NSwdhaQ+yr1zlBlqtNj6ky6ezDth4
        mdrf4H4jPxZKO1TdEKBCyZo9AaPhR4YfxZFAtjA=
X-Google-Smtp-Source: APXvYqxmH29D0NGJed5QeuA1TJKhB++qYRpIKOeRtLdwclUShZBcDQER2VpLN7ON/03jITGEU8SZMviooA4+7ZRu5QU=
X-Received: by 2002:a25:9089:: with SMTP id t9mr23802417ybl.369.1557991860971;
 Thu, 16 May 2019 00:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190406183508.25273-1-urezki@gmail.com> <20190406183508.25273-2-urezki@gmail.com>
 <20190514141942.23271725e5d1b8477a44f102@linux-foundation.org> <20190515152415.lcbnqvcjppype7i5@pc636>
In-Reply-To: <20190515152415.lcbnqvcjppype7i5@pc636>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Thu, 16 May 2019 09:30:49 +0200
Message-ID: <CA+KHdyURm1xb1u4=aV97KQYFi0R_3=SJPBCezWqEB8hT=J8pCw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] mm/vmap: keep track of free blocks for vmap allocation
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Tobin C. Harding" <tobin@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Tobin C. Harding <tobin@kernel.org>

On Wed, May 15, 2019 at 5:24 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> Hello, Andrew.
>
> > An earlier version of this patch was accused of crashing the kernel:
> >
> > https://lists.01.org/pipermail/lkp/2019-April/010004.html
> >
> > does the v4 series address this?
> I tried before to narrow down that crash but i did not succeed, so
> i have never seen that before on my test environment as well as
> during running lkp-tests including trinity test case:
>
> test-url: http://codemonkey.org.uk/projects/trinity/
>
> But after analysis of the Call-trace and slob_alloc():
>
> <snip>
> [    0.395722] Call Trace:
> [    0.395722]  slob_alloc+0x1c9/0x240
> [    0.395722]  kmem_cache_alloc+0x70/0x80
> [    0.395722]  acpi_ps_alloc_op+0xc0/0xca
> [    0.395722]  acpi_ps_get_next_arg+0x3fa/0x6ed
> <snip>
>
> <snip>
>     /* Attempt to alloc */
>     prev = sp->lru.prev;
>     b = slob_page_alloc(sp, size, align);
>     if (!b)
>         continue;
>
>     /* Improve fragment distribution and reduce our average
>      * search time by starting our next search here. (see
>      * Knuth vol 1, sec 2.5, pg 449) */
>     if (prev != slob_list->prev &&
>             slob_list->next != prev->next)
>         list_move_tail(slob_list, prev->next); <- Crash is here in __list_add_valid()
>     break;
> }
> <snip>
>
> i see that it tries to manipulate with "prev" node that may be removed
> from the list by slob_page_alloc() earlier if whole page is used. I think
> that crash has to be fixed by the below commit:
>
> https://www.spinics.net/lists/mm-commits/msg137923.html
>
> it was introduced into 5.1-rc3 kernel.
>
> Why ("mm/vmalloc.c: keep track of free blocks for vmap allocation")
> was accused is probably because it uses "kmem cache allocations with struct alignment"
> instead of kmalloc()/kzalloc(). Maybe because of bigger size requests
> it became easier to trigger the BUG. But that is theory.
>
> --
> Vlad Rezki



-- 
Uladzislau Rezki
