Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E761C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAD920C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="z2yxKPxy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfHFVFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:05:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34025 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfHFVFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:05:38 -0400
Received: by mail-ot1-f67.google.com with SMTP id n5so96145690otk.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 14:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bL9WIDO7sBDPuzb3CXk+Z4+KurUQJsfGVwyfuIglMnE=;
        b=z2yxKPxyTcUc/O0JPDhYlubCTmWn88V/XHMgPAW10JVY9PDY328HIFjdo5D72jUH9f
         NgLzeLRf01N3eu0r1mdcfI7/BvjmTgkY/TwdpldwvbZ6CYEkwmp0eYXtVjobhRaRQuLv
         UKVBPLyKcHIhmZ3R5exIUzoaoQVCcIZsFwVAzTGEHH8mOBIpEeJV0N4FZvasdWo3/BMo
         KGuoLOtTZHjpAh9PykT0gDKxN/TsFkitTz6RF0I1c9hGrl8ZOrgqZWNkXh78fIJeqajS
         J0PWgZNpFBbIOgjBn3Sa58UezqTODB4r3nJN4DcwPF/L6QTs9YSzBz3/MuR4za3eFBwA
         +vLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bL9WIDO7sBDPuzb3CXk+Z4+KurUQJsfGVwyfuIglMnE=;
        b=to/n2Amvmt26+Un2hlnlhYNXl5MxaLcDLySmLhC1Rsy/vu7JxBNwPNaLK1q4KYcqYI
         G6GVjFIDb1WTgAGO9BJLZLYRIqkYVfkKDWyaj6ZMEQfB1Ca/XOFQpRsHGcNmkO1Zgtn3
         iMW80N8kgF7pPxkCasgh7gb7Ltj2C5roPYSK8901i6tKyrVbU8+7xvcpa7Qh3cybOg5T
         Czm/O53IhPrNz0LbJEjFtNRD1Ek8n0MeRZMiik7hImhZLQt79lydnBlCkRjtT9g/imPL
         Z0GQJag4lb0Ec2h6tmE6gJIw8i02HCa/G2W81ucE2PSYpmlqGxVWIqmyA9b+AFoF0PTR
         E7nQ==
X-Gm-Message-State: APjAAAU2g0Q1CdWCergKyjTPKY/f86OfU3xGT70sMuNY22/R3NTw+qEb
        or8Z13ieQiPHRHxVvVpvuTdD/Kam3N4pkDt/lpHi2w==
X-Google-Smtp-Source: APXvYqz/Ak9jnetJg9GXee4VtqrfI/7ybe9DtdbHdF+C7k/OSWwPkzRw1cnJyGFIKt8iguhq8EC0LfgFQg7v9HFSu0g=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr4639053otf.126.1565125537390;
 Tue, 06 Aug 2019 14:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <1565112345-28754-1-git-send-email-jane.chu@oracle.com> <1565112345-28754-2-git-send-email-jane.chu@oracle.com>
In-Reply-To: <1565112345-28754-2-git-send-email-jane.chu@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 6 Aug 2019 14:05:25 -0700
Message-ID: <CAPcyv4jv1Dr=mDkYZ62B=nZux=bFWxYFu3u_N+8Pr0i0jyM2Lg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm/memory-failure.c clean up around tk pre-allocation
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jane, looks good. Checkpatch prompts me to point out a couple more fixups:

This patch is titled:

    "mm/memory-failure.c clean up..."

...to match the second patch it should be:

    "mm/memory-failure: clean up..."

On Tue, Aug 6, 2019 at 10:26 AM Jane Chu <jane.chu@oracle.com> wrote:
>
> add_to_kill() expects the first 'tk' to be pre-allocated, it makes
> subsequent allocations on need basis, this makes the code a bit
> difficult to read. Move all the allocation internal to add_to_kill()
> and drop the **tk argument.
>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  mm/memory-failure.c | 40 +++++++++++++---------------------------
>  1 file changed, 13 insertions(+), 27 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index d9cc660..51d5b20 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -304,25 +304,19 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
>  /*
>   * Schedule a process for later kill.
>   * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
> - * TBD would GFP_NOIO be enough?
>   */
>  static void add_to_kill(struct task_struct *tsk, struct page *p,
>                        struct vm_area_struct *vma,
> -                      struct list_head *to_kill,
> -                      struct to_kill **tkc)
> +                      struct list_head *to_kill)
>  {
>         struct to_kill *tk;
>
> -       if (*tkc) {
> -               tk = *tkc;
> -               *tkc = NULL;
> -       } else {
> -               tk = kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
> -               if (!tk) {
> -                       pr_err("Memory failure: Out of memory while machine check handling\n");
> -                       return;
> -               }
> +       tk = kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
> +       if (!tk) {
> +               pr_err("Memory failure: Out of memory while machine check handling\n");
> +               return;
>         }

checkpatch points out that this error message can be deleted.
According to the commit that added this check (ebfdc40969f2
"checkpatch: attempt to find unnecessary 'out of memory' messages")
the kernel already prints a message and a backtrace on these events,
so seems like a decent additional cleanup to fold.

With those fixups you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...along with Naoya's ack.

I would Cc: Andrew Morton on the v5 posting of these as he's the
upstream path for changes to this file.
