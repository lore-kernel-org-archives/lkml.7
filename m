Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F66C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 00:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016E420693
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 00:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htQl4RsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390820AbfIJAwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 20:52:53 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33181 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390745AbfIJAww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 20:52:52 -0400
Received: by mail-ot1-f66.google.com with SMTP id g25so14321884otl.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 17:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGIIao9PdFSLqjKhUlXcUfbYL/hFNuXa3CP5/F54v8M=;
        b=htQl4RsZD/SoZ/vc52gD8t3b50B7xySrWXQ7BLNx7V0jbJLA5b9RhJn2wyqnyWLSv4
         ApKclrkm7kzU9kr0b2RpyLy2x2YU2Eq+b7BV+QtnEPvFfBnZO+ZyUbI13yj+BHU6xPKx
         1xJ+4apj8ckZWJtLPpVkQECrxSxK7IA9IEeEzEXHOFDAosZ0gFT4UhOuPywHXDgykGwO
         7Y9fy0jC1Rpx3o/nmO4hrTf7Jyv7XrsFnYiaIR/eSOJ6mT7WnD+dkowkZAJQxtUmK5Yj
         owIO8eanjx7Fi2sViZkk8H6w3RyLAWzBe7zsV6BNOfd3RsgH5yv0Ma1mDrFnEa3Na/Rm
         UrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGIIao9PdFSLqjKhUlXcUfbYL/hFNuXa3CP5/F54v8M=;
        b=d1QC/sdyq+wx1/TjHarZutTup183AQ0UlIVwvHxI2dLnrYCCnQ2X6bzzkrL28w0tQG
         iCGhUGQCcc/8rTN5/bU5uLDC2oUNyKnG25NZecub4avlFAl4kZE9b49bZmKj1SEXn8Gk
         jeKbByVFKJSNx1eUye3I9hHk/9fJ/rQs7Ch9+At0EzsMD8SdlTXJT8j5R1hCpBzjz4U9
         iYh7Zk1hCRfzFnJCLOee/tvF/4jpWf0htSCCwBrsOiOc2XuTYUrVDHPy0SHyio7oGJG0
         9ElOsNVDZgA+QnWv90dRy242XeD9rTSifCUg1RMeCvlxGPxOBxNKgy+A8H8r5Oihwu9B
         hT2g==
X-Gm-Message-State: APjAAAXMGiCTaqtMFdKkzveyahPfCGVRTnqGrpL6zhhNDnS7tqrioUju
        c05ziVNOw0N83ddR5sQCRst9zZU3VmXv1eMKdDM=
X-Google-Smtp-Source: APXvYqzkQoPCx4SYbSI7XLeNrk+DA2aad7QI5zqB6UhLaP/Kt2foPN9VkhR43wq0JloRyhoYwN5OeXtAOrbv8Rh0w3Y=
X-Received: by 2002:a9d:12e4:: with SMTP id g91mr21315054otg.368.1568076771758;
 Mon, 09 Sep 2019 17:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190903160430.1368-1-lpf.vector@gmail.com> <20190903160430.1368-2-lpf.vector@gmail.com>
 <4e9a237f-2370-0f55-34d2-1fbb9334bf88@suse.cz> <CAD7_sbEwwqp_ONzYxPQfBDORH4g2Du=LKt=eWf+6SsLgtysBmA@mail.gmail.com>
 <3a95d20d-ccf9-bd45-2db3-380cc3e0cd17@rasmusvillemoes.dk>
In-Reply-To: <3a95d20d-ccf9-bd45-2db3-380cc3e0cd17@rasmusvillemoes.dk>
From:   Pengfei Li <lpf.vector@gmail.com>
Date:   Tue, 10 Sep 2019 08:52:40 +0800
Message-ID: <CAD7_sbHV=tXrZaBuQuifVznFMUf13hs7t_QcgFVmrCdMHT4Ytg@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm, slab: Make kmalloc_info[] contain all types of names
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christopher Lameter <cl@linux.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 2:30 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 09/09/2019 18.53, Pengfei Li wrote:
> > On Mon, Sep 9, 2019 at 10:59 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> >>>   /*
> >>>    * kmalloc_info[] is to make slub_debug=,kmalloc-xx option work at boot time.
> >>>    * kmalloc_index() supports up to 2^26=64MB, so the final entry of the table is
> >>>    * kmalloc-67108864.
> >>>    */
> >>>   const struct kmalloc_info_struct kmalloc_info[] __initconst = {
> >>
> >> BTW should it really be an __initconst, when references to the names
> >> keep on living in kmem_cache structs? Isn't this for data that's
> >> discarded after init?
> >
> > You are right, I will remove __initconst in v2.
>
> No, __initconst is correct, and should be kept. The string literals
> which the .name pointers point to live in .rodata, and we're copying the
> values of these .name pointers. Nothing refers to something inside
> kmalloc_info[] after init. (It would be a whole different matter if
> struct kmalloc_info_struct consisted of { char name[NN]; unsigned int
> size; }).
>

Thank you for your comment. I will keep it in v3.

I did learn :)


> Rasmus
