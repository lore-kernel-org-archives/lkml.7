Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBDFC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D13424A51
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFTBxFiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfFDLBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:01:23 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39647 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbfFDLBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:01:22 -0400
Received: by mail-vs1-f66.google.com with SMTP id n2so4821746vso.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 04:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WDbPSKeCZ8oAwUO/gbQAYonHxio/dp9v0ZS3lSUVGiI=;
        b=UFTBxFiFaQAgtc8pGRfpgJK9845bc1+wNN3Ljkixb6j9f/C6DpMOv6EeY1wjgMedGS
         1z4TxRJ2Uf/dl5OTSZcqew7Xw4uMG1N6xKcAYtI9vvSz5VV6ha9bJ6dwVDgORMX6bCrS
         GKKBfElTwlYNDrFuxzHjOXxJO6rYrJrbGaQXjfeLJeUS265m2BZDLz+0UiFBDv5iTzMl
         boiJTv5mPyyDY4mFXGSlJHkj/5xIHajEhH5HZ4Z/W1oa4DXBWGMvGkt3T+D217UFzvrQ
         0Dz/jFifyp/r98ljW5sCi7WcYFQeRupstHnMuRZ2fA1sCe331hW4CUxOKRdtxd2LJkZq
         SACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WDbPSKeCZ8oAwUO/gbQAYonHxio/dp9v0ZS3lSUVGiI=;
        b=LDg8HiICD7TkLEXMofzwcSMA1OcO89EJycpiT7sulYfCmE2qsrybpnaRyl0xueo0le
         Qm0S6vDKwiUIU4oMnLZsBQv3AC9qLZVZcnPTEYMaT8fMeXP36Yde+kNrkCofGf6sYaLH
         qU8qxtpC11ii6o9KIWw5Oo3NpVXecIJzsQvZxNieNpI4nQjltRSxyOGNVydjz/7RyL5l
         HE64xSSmmWAFOKVfoyscRXqjKTrV0N+vrYWKU5X6Yj+cN9CQiYz/ilevQIK/oaO5/iK3
         S1pKe/80K1+NASzeJ4k5DHvgz5uR45uf4W6xFlOcbDxfoD3Vz1a2JpTxwXGyXxZ/gI5m
         H+/A==
X-Gm-Message-State: APjAAAVp52TN3acPqufyVzaGb0z8lhPCZ+EUmZzWsohp8DZpt+/3zRej
        P2R6BYDSuPLikHIPbsb2cVMOHiN1sOjgpOjuDq5YBw==
X-Google-Smtp-Source: APXvYqw2LlI1r2QNjEMglKQhTLxp/mFVzp3+GFK0ixuGGyE3T4oSZc8iLerthe1V9Q76vq1872HT3A+BHOIBTgWhL9g=
X-Received: by 2002:a67:e3d5:: with SMTP id k21mr765014vsm.172.1559646080843;
 Tue, 04 Jun 2019 04:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190603112453.20097-1-ttayar@habana.ai>
In-Reply-To: <20190603112453.20097-1-ttayar@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 4 Jun 2019 14:00:54 +0300
Message-ID: <CAFCwf12Ry+tan4Wov-xJqO0aWbapNsB+xcnHs2f-3LuN7fVRKg@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Fix virtual address access via debugfs for
 2MB pages
To:     Tomer Tayar <ttayar@habana.ai>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 2:25 PM Tomer Tayar <ttayar@habana.ai> wrote:
>
> The debugfs interface for accessing DRAM virtual addresses currently
> uses the 12 LSBs of a virtual address as an offset.
> However, it should use the 20 LSBs in case the device MMU page size is
> 2MB instead of 4KB.
> This patch fixes the offset calculation to be based on the page size.
>
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> ---
>  drivers/misc/habanalabs/debugfs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/debugfs.c
> index 0ce5621c1324..ba418aaa404c 100644
> --- a/drivers/misc/habanalabs/debugfs.c
> +++ b/drivers/misc/habanalabs/debugfs.c
> @@ -500,6 +500,7 @@ static int device_va_to_pa(struct hl_device *hdev, u64 virt_addr,
>  {
>         struct hl_ctx *ctx = hdev->user_ctx;
>         u64 hop_addr, hop_pte_addr, hop_pte;
> +       u64 offset_mask = HOP4_MASK | OFFSET_MASK;
>         int rc = 0;
>
>         if (!ctx) {
> @@ -542,12 +543,14 @@ static int device_va_to_pa(struct hl_device *hdev, u64 virt_addr,
>                         goto not_mapped;
>                 hop_pte_addr = get_hop4_pte_addr(ctx, hop_addr, virt_addr);
>                 hop_pte = hdev->asic_funcs->read_pte(hdev, hop_pte_addr);
> +
> +               offset_mask = OFFSET_MASK;
>         }
>
>         if (!(hop_pte & PAGE_PRESENT_MASK))
>                 goto not_mapped;
>
> -       *phys_addr = (hop_pte & PTE_PHYS_ADDR_MASK) | (virt_addr & OFFSET_MASK);
> +       *phys_addr = (hop_pte & ~offset_mask) | (virt_addr & offset_mask);
>
>         goto out;
>
> --
> 2.17.1
>
This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
applied to -fixes
