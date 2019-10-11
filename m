Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76A5C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 03:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A33E2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 03:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xk4BT32V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfJKDfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 23:35:52 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36897 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfJKDfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 23:35:52 -0400
Received: by mail-yw1-f65.google.com with SMTP id m7so2990510ywe.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 20:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OgPaV+qaSMkdCLw3rM07i0HH191EBL2f3oOUwQ7aINM=;
        b=Xk4BT32VWl7rmbedpzjSt5jXZ6YD4Nf9YCauqsxDOhZntTvKg5bpEb0RwAzy4VQMQL
         tlfrsMqcY0JHQAXCXq1ORbpQ5AUUP4m14X8nPaCiH3vSFvTydqmgp69cg/lKPuAoNHC5
         jNL0ADF3se3LDaAQEHYC4/4T5YFmHf9sP/f+5z7VK52bZBBjpEW8dYbZubWDunkCeGbZ
         GpjMunMnDVe+joQv8s74lShKRZBF5901HU+bWB/7jGqTydun6sQFCo/6J9Fn0P3rA9qE
         FsBgquAXoC+peoEcTVVg4+lW2Mn0HYiaGpasCjhtt9nSBGTnAv/l8NbTT4MRLOCul1ER
         axLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgPaV+qaSMkdCLw3rM07i0HH191EBL2f3oOUwQ7aINM=;
        b=Bo7gv0zL8ss0F67omA47KOGPG+Q7XGORNFZTULTZPMi1R93qZgzCQb839nXK2JB86h
         WoBwXs+EpWetMWNxweTukr3GSLPJwpy2HSVrACKFaEPBNKh+5K7kL5Sm8VuY3C8R2uL1
         fgKXOe0+7zKGpcrXOOQxt//zO4BAiMzh2Xpn5PrOdnW5F0AH4Z4V536osLrFroPw7ypb
         kp8TAfQbNHnQMlZJzhNP05jMKFwUYg0bx25fMzagBfgmZjv/3AC9bepX1Ex9yg6DgEsq
         0+Yi0M/uOwuieZNFcgA8+dvyimF7DRUzDWMpaTi6diLR6ZOyNDzpp9L7IGKkSMtmf6s1
         5kzA==
X-Gm-Message-State: APjAAAUYxeeRV5v/CrKgxELwApGsHYH+qqsJtnyP/WWfSWc8tez5Tyfs
        GIpYpLk6QKzJj5yvgr2+wyhuEnmPB1WPSYvu/fmOsuu3iXw=
X-Google-Smtp-Source: APXvYqx3e2s/VJH2fkJJc3gtf+mHISawf0sbgYOGmUSAfyxFrrhUpFi9yXJ4oieBmM3yVFqQsKMZUl/B2rXpoY9JXpc=
X-Received: by 2002:a81:74d4:: with SMTP id p203mr764119ywc.234.1570764950010;
 Thu, 10 Oct 2019 20:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191009192105.GC26530@ZenIV.linux.org.uk> <CAMo8BfKUOmExGRMaUPmcRsy=iyRrguLF6JOLUMegNnzkF9vcvQ@mail.gmail.com>
 <20191010015606.GD26530@ZenIV.linux.org.uk> <CAMo8BfLo4hy+WGA7p+7iZaLmmgFOyzMRAtG5dzNj=JEU04GoKA@mail.gmail.com>
 <20191010142956.GG26530@ZenIV.linux.org.uk>
In-Reply-To: <20191010142956.GG26530@ZenIV.linux.org.uk>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 10 Oct 2019 20:35:39 -0700
Message-ID: <CAMo8BfL3j4odehiR8KzHwjohfoBADOhjSjeXFG7AwgBXoXQRTw@mail.gmail.com>
Subject: Re: [PATCH] xtensa: fix {get,put}_user() for 64bit values
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 7:29 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> Hmm...   Looking at __get_user_size(), we have retval = 0; very early
> in it.  So I wonder if it should simply be
> #define __get_user_size(x, ptr, size, retval)                           \
> do {                                                                    \
>         int __cb;                                                       \
>         retval = 0;                                                     \
>         switch (size) {                                                 \
>         case 1: __get_user_asm(x, ptr, retval, 1, "l8ui", __cb);  break;\
>         case 2: __get_user_asm(x, ptr, retval, 2, "l16ui", __cb); break;\
>         case 4: __get_user_asm(x, ptr, retval, 4, "l32i", __cb);  break;\
>         case 8: if (unlikely(__copy_from_user(&x, ptr, 8)) {            \
>                         retval = -EFAULT;                               \
>                         x = 0;                                          \
>                 }                                                       \
>                 break;                                                  \
>         default: (x) = __get_user_bad();                                \
>         }                                                               \
> } while (0)
> so that 64bit case is closer to the others in that respect (i.e. zeroing
> done on failure and out of line).  No?

Ok, I agree.
The intermediate __gu_val in __get_user_[no]check doesn't work well
with some data types used in the kernel, unfortunately. I'll post a series
with what's close to your initial patch on top of rearranged
__get_user_[no]check.

-- 
Thanks.
-- Max
