Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34244C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0063C218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyEtl3KN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfCUPhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:37:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42676 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUPhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:37:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id r15so4522617pfn.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 08:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7aWftstCT7Zcy3Pd7b5DLtKI/CvAG0LiaBUQKNZR3WQ=;
        b=jyEtl3KNZEapDrjtjDfQLDr9jifQYz3466yBVsUZG2Lz0j3aC3QIOkI7rX417GuSwx
         CmNdTSzc+mvu/Utnl0nSrswuHzAdSQIeNUwiYYH/022iRwoOrhmZX+gE1arvA/NZtOZh
         oVYEPQx/ZpvLog7c7WwaH/w6VagGS7JspO7tfX3O+pMXAs2G3Y8ByMyQ4sQqDpq/Z11P
         9N3kW6mmE8AqZIAiVpUSivpJ6BJWufjY39fyW/vEwWPo+QruKEZLD4laDIj41Vthuy84
         /QLeAvQe2kKm4okxM8Vkv4OTtJfnA22hUjvrCf4P6QT8qKC/QrulXUFEf8jzzwodJP2F
         QCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7aWftstCT7Zcy3Pd7b5DLtKI/CvAG0LiaBUQKNZR3WQ=;
        b=fEcT1QBbasTZuPa9OS1XU6ih1P2HQjwta72Dv4lKrB9HXCDhP0U65eYmr268lpZw5u
         z1sgkkf8Fq3dGE6vFITuVYy7D3gTkG4hq2jP1vQlnXz14zS7kxMbTiPnPLyiVgHZ5hzA
         O6SalLsBUwNC0OnfJwuo3FkAaIuDhz+drk6IyDMGNfO9d9owm6gDNEupg0QCBNp92352
         f3+Aw3wMKDC2zC8JFUkBtWBXZNlc2d3YcdtsA+H/WfKbvzY8Y2CSe57qUHxg7DRaduZU
         eh4iAukAijTDgTw9X3ra5ZkALCobwdOG2JULEAQdj4dLkEf2kbqotDL5JOfjJpO3xjGb
         FoeQ==
X-Gm-Message-State: APjAAAWkVEbp63eTOoGpoEBBpCX2v5v1bgqtY0HLbPsCb1Obh0O2MO/k
        dj0lmqbE394psR+bG9mb4o+tGUR0glDNPEp+0aw=
X-Google-Smtp-Source: APXvYqwbMH6FCFcz9uSNgjm5h8fhIpa5x50nKLalXvrA5mouO8fLRhoRae2CzmCl0fO1YcpMz+cotPchcIT2mrP2GSg=
X-Received: by 2002:a17:902:a9c8:: with SMTP id b8mr4242561plr.12.1553182619094;
 Thu, 21 Mar 2019 08:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190321153036.43084-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190321153036.43084-1-andriy.shevchenko@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 Mar 2019 17:36:47 +0200
Message-ID: <CAHp75VekmW1T4nsp+wtOKbc8Xf_aUGUwxAw6PrpSpYEubxbNEQ@mail.gmail.com>
Subject: Re: [PATCH v1] lib/generic-radix-tree: Make good use of while (level--)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 5:32 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There is no need to split postincrement in while (level--) type of loops.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/generic-radix-tree.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
> index a7bafc413730..5a1818a0de1f 100644
> --- a/lib/generic-radix-tree.c
> +++ b/lib/generic-radix-tree.c
> @@ -59,13 +59,9 @@ void *__genradix_ptr(struct __genradix *radix, size_t offset)
>         if (ilog2(offset) >= genradix_depth_shift(level))
>                 return NULL;
>
> -       while (1) {
> +       while (level--) {
>                 if (!n)
>                         return NULL;
> -               if (!level)
> -                       break;
> -
> -               level--;

My bad, this will need an additional check. before the loop.

>
>                 n = n->children[offset >> genradix_depth_shift(level)];
>                 offset &= genradix_depth_size(level) - 1;
> @@ -157,9 +153,7 @@ void *__genradix_iter_peek(struct genradix_iter *iter,
>         if (ilog2(iter->offset) >= genradix_depth_shift(level))
>                 return NULL;
>
> -       while (level) {
> -               level--;
> -
> +       while (level--) {
>                 i = (iter->offset >> genradix_depth_shift(level)) &
>                         (GENRADIX_ARY - 1);
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
