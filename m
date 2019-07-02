Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A492C06511
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A6C2146F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1R5QsTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfGBHqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:46:00 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41893 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGBHp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:45:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id 205so15863202ljj.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5IrBPD0J3ThoKKFU4/FQRnog7nkm0QgrOR9tIqfG3FY=;
        b=d1R5QsTYa5MTtTEHHeCBzlMg9hZoSTCrw52r1zZF5ZH3HtRyfd1fMwfCVSWnHKA2kG
         4yOBQgQwFxAfrJAoRCkpslMVYXq4M4qzZEhhN5eAueF6CDd47bf1YGy7CVMb4QD9NZ6N
         9FFBS5L6sLobrCnhGda6f/KzikGGytL1t7rQamquIJyhjAVuuWEx7we3wKkf24HvN7Nl
         6GDP08kRaJ2X8lBBU/kp/7dw40Kwc2TysdxBYOdxkhkWZwSAlHYNiQ6QQDdXumAjceiA
         re/bUmjD12UwXfzamlmxA5GbyLp1Ijx3uuJh4MGTHoBwxSrc7K+2vWPk15rDH77JGhPb
         yT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5IrBPD0J3ThoKKFU4/FQRnog7nkm0QgrOR9tIqfG3FY=;
        b=XUnwkB5n6mdCye1ieIbxgxqwlGFMf0KeklLQ3z5A8NgNDgKHiH+LH0YjgVJC4Q+ALW
         ifvcphP/6H6MFGwCl/FD/d8h0zCXR8jCkx5Ta+qUGNWM85rvwplRIakCpom4xoZgQLlt
         HdbtDlVb7+iHyv8F/lg6RO73cBucMrc4xsVNLhQADaIeBvViflq90ROjhry2fYihw2z9
         bQQkkR/vYEDnwacH3gxQuxRkENGWVk9MHKaPg2GkZrTq28dFOyPe+WyhuPqVSEj755G4
         fdS/iMfi/CrrEMVczqzlbyTGbCqyiODNoHUF/gttSnwcaytt4QG/6WMO83o4Pe+d0iMY
         Ly/A==
X-Gm-Message-State: APjAAAUE+NCxO+EHFFaoGx5NhkOj8LLafJqUSRhXsmkh7hjYvvVflS77
        TY9bgkCr02i/Q3l67oSKzHEPtM7IdLt/IHBuRD4=
X-Google-Smtp-Source: APXvYqxJ4w6Wee+ZufWo6q87k8jBVJa0des3If6bhXo6eBuX5YbcNlItTrHcH+egqRL+ObwM7oDMNYBaEiKXghKcdow=
X-Received: by 2002:a2e:86cc:: with SMTP id n12mr16247419ljj.146.1562053557722;
 Tue, 02 Jul 2019 00:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190701173042.221453-1-henryburns@google.com>
In-Reply-To: <20190701173042.221453-1-henryburns@google.com>
From:   Vitaly Wool <vitalywool@gmail.com>
Date:   Tue, 2 Jul 2019 10:45:46 +0300
Message-ID: <CAMJBoFPbRcdZ+NnX17OQ-sOcCwe+ZAsxcDJoR0KDkgBY9WXvpg@mail.gmail.com>
Subject: Re: [PATCH] mm/z3fold: Fix z3fold_buddy_slots use after free
To:     Henry Burns <henryburns@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Xidong Wang <wangxidong_97@163.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Henry,

On Mon, Jul 1, 2019 at 8:31 PM Henry Burns <henryburns@google.com> wrote:
>
> Running z3fold stress testing with address sanitization
> showed zhdr->slots was being used after it was freed.
>
> z3fold_free(z3fold_pool, handle)
>   free_handle(handle)
>     kmem_cache_free(pool->c_handle, zhdr->slots)
>   release_z3fold_page_locked_list(kref)
>     __release_z3fold_page(zhdr, true)
>       zhdr_to_pool(zhdr)
>         slots_to_pool(zhdr->slots)  *BOOM*

Thanks for looking into this. I'm not entirely sure I'm all for
splitting free_handle() but let me think about it.

> Instead we split free_handle into two functions, release_handle()
> and free_slots(). We use release_handle() in place of free_handle(),
> and use free_slots() to call kmem_cache_free() after
> __release_z3fold_page() is done.

A little less intrusive solution would be to move backlink to pool
from slots back to z3fold_header. Looks like it was a bad idea from
the start.

Best regards,
   Vitaly
