Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810C8C04AB3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 08:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DF22173B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 08:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al5AmLsP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfEKILA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 04:11:00 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34283 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbfEKILA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 04:11:00 -0400
Received: by mail-lf1-f67.google.com with SMTP id v18so5728578lfi.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 01:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TQtZc3FelJBQESxVUuXzQ1cko0sOiYknE7Ka8Kps1YY=;
        b=al5AmLsPkWUP0wa7q0iB6soqaQEuPYfX4SBDqvRrM0p/UG1oSWSpI4uNt/e02ZYUJU
         ahKoI6IbQiLLSO2qJNCJ+iLlPoZiBoqJ7Y77f3M1n/ssjjspcwc+BLvCwnyoDdd+2i5X
         B4bb4q7z832ZXkXDdErEgNiR6qZGw0NySHHYrvkbmHApj8T48VHfhQ2NpHlUIax39SuG
         gjtzq0os4UsjlL3tNwLrSLeXPcYM6zyUJEJheNKUCzLtCiTOPdet5sIRf2LijH/mcb3M
         +B7XJ+y2W2dsTnKRaGxST00J5dhR7uYmSLk4T/T1/Mx2gI8Namq4U7SRp5w1l/QFp9+U
         hWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TQtZc3FelJBQESxVUuXzQ1cko0sOiYknE7Ka8Kps1YY=;
        b=gxFN2v/YuwyBKtY1wiwi0Sfirk4H6sUtn8n9lI5Dxf2xVLv0mqX5A/MqEwD0Kp92Ic
         ZWsTdOBUGDx54hZXugFS6KpgJADqPDdl0Md7KudM+dz73vtJQSjtLnjN90pjkaySqWch
         AzXK+ekLFI3Tnh72R8x5/dUJ7fAAjrvIF+gSS3IXncjluag896EVPd6PjsmBQTe+Rzcg
         eyKf1S1GYiT+pLrnBP8ziZJ52ViP/xk859koYqhVkpjwGGxS0PZwvsAu7BbcJ3tEa+aG
         fwPp3qiXNl4ZdfVMNk3mgecFSODvSmgTgk6pduzQw89FpC1XUVuHkSOP0e/AX8DUPoFO
         rA7g==
X-Gm-Message-State: APjAAAVQx2DPJYrOdBK8/zTQ2i5GmOTuoSu9rX6h71gID/yXEDiOx5QS
        ONgDnJnJJUSVRgyGg/q+Vlc07xG5nqjSlXJLFqlWLQ==
X-Google-Smtp-Source: APXvYqxrR+0F7Mtq0iFNk+3yrcIt+6zmntJ4b75xneeACJzPfrZqvtqgBurz7OcyTbIj1wp+pPTqYud6j7415sWrUmI=
X-Received: by 2002:ac2:5621:: with SMTP id b1mr8593193lff.27.1557562258490;
 Sat, 11 May 2019 01:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190422103836.48566-1-swkhack@gmail.com>
In-Reply-To: <20190422103836.48566-1-swkhack@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 11 May 2019 13:40:47 +0530
Message-ID: <CAFqt6zbxMKydJa=-TbPTWwxK-XJYyg=d-tV8AWfNSAA1Q2ugfA@mail.gmail.com>
Subject: Re: [PATCH] mm: Change count_mm_mlocked_page_nr return type
To:     Weikang shi <swkhack@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 4:08 PM Weikang shi <swkhack@gmail.com> wrote:
>
> From: swkhack <swkhack@gmail.com>
>
> In 64-bit machine,the value of "vma->vm_end - vma->vm_start"
> maybe negative in 32bit int and the "count >> PAGE_SHIFT"'s rusult

s/rusult/result.

> will be wrong.So change the local variable and return
> value to unsigned long will fix the problem.
>
> Signed-off-by: swkhack <swkhack@gmail.com>
> ---
>  mm/mlock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 080f3b364..d614163f5 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -636,11 +636,11 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
>   * is also counted.
>   * Return value: previously mlocked page counts
>   */
> -static int count_mm_mlocked_page_nr(struct mm_struct *mm,
> +static unsigned long count_mm_mlocked_page_nr(struct mm_struct *mm,
>                 unsigned long start, size_t len)
>  {
>         struct vm_area_struct *vma;
> -       int count = 0;
> +       unsigned long count = 0;
>
>         if (mm == NULL)
>                 mm = current->mm;
> --
> 2.17.1
>
