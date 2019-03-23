Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFCEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 07:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C185218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 07:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/AR1oKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfCWH5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 03:57:45 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35538 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfCWH5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 03:57:45 -0400
Received: by mail-lf1-f67.google.com with SMTP id u21so2896806lfu.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 00:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z/aKwYGbH4+4di22m+SqS1QqQLmAyze04q50aG94qec=;
        b=R/AR1oKEe2ljpDS5QiysNTkNvvv23MRCzkh8IOdwwVKfhH9n1/37FX8cdvDf831gCa
         SnqtO9fIoYKGnZISeG7ZDbOo03+VZoUhvp336GETtE/SaFJLiLFBpx7PrkmLJgaH9FZk
         u2HMtd6kmDSpKJyZvJ0nFUwsUXW2uYUicqD3K8JN5HIlW8MiSttM1meEE2cCsrtKFIoF
         1VPJDiiBWU+y9Mx2idSR/XKXkefrMhPFvOheqblQuafQtEfJareRcryQUYTc86VKkBhL
         GF94leqrp7yCFWjZoXG9OxKbT6m8obo4GgmzmoHrMsdFGZWB7JMi1XZ6E7bDGwHRZmxY
         +irA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z/aKwYGbH4+4di22m+SqS1QqQLmAyze04q50aG94qec=;
        b=n+CitarikkQJbowgQUTt4LvtxevToVfxMEorqYi7mmBbXy4HcpLz/75pzGbT9rloP2
         I5rNnUIxtUxs5esfFJ7I7Z3hXf6RdiYfnxzZ1kK8Ug4MjK9OcXea5jCwSRg9ggtkZBVV
         /Iu0jjk/2jXoZoAcMiIDQjXidY1OZSlO42VCcbY8blLmh/7N+qV74CJrJQbBwYDM98sC
         1iSOjgc1zR4IxR9NLRhp/ooabSI1qp2jrnLaCJQiinAoNl7coNQat1rb0ku1KXgprH1m
         TzJ4/55A4L9g08FktU0GGVOWwX7+d37+nT29uXfI5rZkyHSyPd/QJBavklBmYjtcDi81
         VNkQ==
X-Gm-Message-State: APjAAAUKE6UUTosBfimqBVvi2CupCX9jfxCvdu4s9qYO71F94qMrRCRi
        YW7/Z4RMWaAEv+20w85qqSKhYWSoljsply7lISg=
X-Google-Smtp-Source: APXvYqw2OFgPkW1ptRJ1lwSvUOaaOxpN+Ynt1Ziwp7YAjcFek1jouzI8PAsRksV4xu6gcMDiRsc+83N/s8xFBzOIJDQ=
X-Received: by 2002:a19:c9c1:: with SMTP id z184mr7129547lff.138.1553327863003;
 Sat, 23 Mar 2019 00:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190309075917.6791-1-kjlu@umn.edu> <11B50B8B-7A27-4BFD-B0C6-669C74381B46@umn.edu>
In-Reply-To: <11B50B8B-7A27-4BFD-B0C6-669C74381B46@umn.edu>
From:   Maxim Levitsky <maximlevitsky@gmail.com>
Date:   Sat, 23 Mar 2019 09:57:32 +0200
Message-ID: <CACAwPwaPb6x0WWay5Wt5hsYumLv3sQea9Nq4GAJHJ6qLs62apQ@mail.gmail.com>
Subject: Re: [PATCH] memstick: fix a potential NULL pointer dereference
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 5:08 AM Kangjie Lu <kjlu@umn.edu> wrote:
>
> Hi Maxim,
>
> Can you review this patch?
>
> Thanks,
>
> > On Mar 9, 2019, at 1:59 AM, Kangjie Lu <kjlu@umn.edu> wrote:
> >
> > In case alloc_ordered_workqueue fails, the fix returns ENOMEM to
> > avoid potential NULL pointer dereference.
> >
> > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > ---
> > drivers/memstick/core/ms_block.c | 5 +++++
> > 1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
> > index 82daccc9ea62..8e00de414567 100644
> > --- a/drivers/memstick/core/ms_block.c
> > +++ b/drivers/memstick/core/ms_block.c
> > @@ -2149,6 +2149,11 @@ static int msb_init_disk(struct memstick_dev *card)
> >
> >       msb->usage_count = 1;
> >       msb->io_queue = alloc_ordered_workqueue("ms_block", WQ_MEM_RECLAIM);
> > +     if (!msb->io_queue) {
> > +             rc = -ENOMEM;
> > +             goto out_put_disk;
> > +     }
> > +
> >       INIT_WORK(&msb->io_work, msb_io_work);
> >       sg_init_table(msb->prealloc_sg, MS_BLOCK_MAX_SEGS+1);
> >
> > --
> > 2.17.1
> >

Looks OK to me!

Reviewed-by: Maxim Levitsky <maximlevitsky@gmail.com>

Best regards,
     Maxim Levitsky
